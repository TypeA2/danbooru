# frozen_string_literal: true

# Extractor for URL shorteners such as bit.ly or t.co.
#
# TODO: Add more shorteners from https://wiki.archiveteam.org/index.php/URLTeam. Use data dumps to unshorten dead URLs?
class Source::Extractor::URLShortener < Source::Extractor
  delegate :page_url, :profile_url, :artist_name, :display_name, :username, :tag_name, :artist_commentary_title, :artist_commentary_desc, :dtext_artist_commentary_title, :dtext_artist_commentary_desc, to: :sub_extractor, allow_nil: true
  delegate :domain, :site, :host, :path, :path_segments, :params, to: :parsed_url

  def image_urls
    sub_extractor&.image_urls || []
  end

  def other_names
    sub_extractor&.other_names || []
  end

  def profile_urls
    sub_extractor&.profile_urls || []
  end

  def tags
    sub_extractor&.tags || []
  end

  def artists
    sub_extractor&.artists || []
  end

  memoize def sub_extractor
    # In case the URL leads to a chain of URL shorteners, don't go more than five redirects deep.
    return nil if parent_extractors.grep(Source::Extractor::URLShortener).size > 5

    Source::URL.parse(redirect_url)&.extractor(parent_extractor: self)
  end

  memoize def redirect_url
    https_url = Addressable::URI.join("https://#{host}", path)

    case [domain, *path_segments]

    # curl -v https://amzn.asia/bGjatHL
    # Returns 301 on success and 404 on error. Doesn't support HEAD.
    in "amzn.asia", *rest
      http.redirect_url(https_url, method: "GET")&.to_s

    # curl -I https:///amzn.to/2oaTatI
    # Returns 301 on success and a 302 redirect to http://www.amazon.com on error.
    in "amzn.to", id
      response = http.no_follow.head(https_url)
      response.headers["Location"] if response.status.code == 301

    # curl -I https://hoyo.link/aifgFBAL
    # curl -I https://hoyo.link/80GCFBAL?q=25tufAgwB8N
    in "hoyo.link", id
      if params[:q].present?
        url = http.redirect_url("https://bbs-api-os.hoyolab.com/community/misc/api/transit?q=#{params[:q]}", method: "GET")
        url&.params&.dig(:url) || url&.to_s
      else
        url = http.redirect_url(https_url, method: "GET")&.to_s
        url unless url == "https://webstatic.hoyoverse.com/short_link/404_v2.html"
      end

    # curl -v https://naver.me/FABhCw8Z
    # HEAD not supported; https://naver.me redirects to http://naver.me; returns 307 on success and 404 on error.
    in "naver.me", id
      response = http.no_follow.get("https://naver.me/#{id}")
      response.headers["Location"] if response.status.redirect?

    # curl -I https://pin.it/4A1N0Rd5W
    # https://pin.it/4A1N0Rd5W redirects to https://api.pinterest.com/url_shortener/#{id}/redirect/.
    # Returns 302 on success and a 302 redirect to https://api.pinterest.com/url_shortener/:id/redirect/None or https://www.pinterest.com on error.
    in "pin.it", id
      response = http.no_follow.head("https://api.pinterest.com/url_shortener/#{id}/redirect/")
      url = response.headers["Location"] if response.status.redirect?
      url unless url.in?(%W[https://api.pinterest.com/url_shortener/#{id}/redirect/None https://www.pinterest.com])

    # curl -I https://posty.pe/343rpc
    in "posty.pe", id
      url = http.redirect_url(https_url)&.to_s
      url unless url.in?(%w[https://www.postype.com https://www.postype.com/404])

    # curl -I https://skfb.ly/GXzZ
    # https://skfb.ly/GXzZ -> https://sketchfab.com:443/s/GXzZa -> https://sketchfab.com/3d-models/my-dnd-map-falkirk-91a1199bda5e45cb84260bac20502f28
    in "skfb.ly", id
      http.redirect_url("https://sketchfab.com/s/#{id}")&.to_s

    # curl -v https://reurl.cc/E2zlnA
    # HEAD not supported; Returns 200 OK with 'Target' header on success and no 'Target' header on error.
    in "reurl.cc", id
      response = http.no_follow.get(https_url)
      response.headers["Target"] if response.status.code == 200

    # curl -I https://shorturl.at/uMS23
    # http://shorturl.at/uMS23 -> https://shorturl.at/uMS23 -> https://www.shorturl.at/uMS23 -> https://drive.google.com/drive/folders/1NL1iwZb8o52ieGt-Tkt8AAZu79rqmekj?usp=sharing
    # Returns 302 on success and a 302 redirect to https://www.shorturl.at/ on error
    in "shorturl.at", id
      url = http.redirect_url("https://www.shorturl.at/#{id}")&.to_s
      url unless url == "https://www.shorturl.at/"

    # curl -I http://xhslink.com/WNd9gI
    # Returns 307 on success, 307 redirect to http://www.xiaohongshu.com on error, and 500 if id is too long.
    in "xhslink.com", id
      # http://xhslink.com/ErpbmK，复制本条信息，打开【小红书】App查看精彩内容！
      url = http.redirect_url(https_url)&.to_s
      url unless url == "http://www.xiaohongshu.com"

    # curl -v https://t.cn/A6pONxY1 # -> https://video.weibo.com/show?fid=1034:4914351942074379
    # Returns 302 redirect for trusted URLs, 200 success with Location header for untrusted URLs, and 302 redirect to http://weibo.com/sorry on error. Requires browser user agent and GET method.
    in "t.cn", id
      response = http.no_follow.get(https_url)
      url = response.headers["Location"] if response.status.code.in?(200..399)
      url unless url == "http://weibo.com/sorry"

    # curl -I https://t.co/Dxn7CuVErW
    # curl -I https://pic.twitter.com/Dxn7CuVErW
    # curl -I https://pic.x.com/Dxn7CuVErW
    # All the same, except pic.x.com redirects to pic.twitter.com.
    in "twitter.com" | "x.com" | "t.co", id
      http.headers("User-Agent": "curl/8.2.1").redirect_url("https://t.co/#{id}")&.to_s

    # curl -I https://bit.ly/4aAVa4y
    # Can't use a browser user agent for these shorteners, otherwise we get a HTML response instead of a 301 redirect.
    in "bit.ly" | "j.mp" | "pse.is", id
      http.headers("User-Agent": "curl/8.2.1").redirect_url(https_url)&.to_s

    else
      response = http.no_follow.head(https_url)
      url = response.headers["Location"] if response.status.redirect?
      url unless url&.starts_with?("/") # Treat relative redirects as errors.
    end
  end
end
