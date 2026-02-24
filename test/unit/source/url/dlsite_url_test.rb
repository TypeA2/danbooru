# frozen_string_literal: true

require "test_helper"

module Source::Tests::URL
  class DlsiteUrlTest < ActiveSupport::TestCase
    context "when parsing" do
      should_identify_url_types(
        image_urls: [
          "https://img.dlsite.jp/modpub/images2/work/doujin/RJ01183000/RJ01182574_img_main.jpg",
          "https://img.dlsite.jp/modpub/images2/ana/doujin/RJ01571000/RJ01570715_ana_img_main.webp",
          "https://img.dlsite.jp/modpub/images2/parts/RJ01109000/RJ01108646/c595ec4d121d80c300d94b368806d655.jpg",
          "https://img.dlsite.jp/modpub/images2/parts_ana/RJ01030000/RJ01029765/33415f94d0cf83d85f39624dac1e3724.jpg",
        ],
        page_urls: [
          "https://www.dlsite.com/home/work/=/product_id/RJ01096697",
          "https://www.dlsite.com/home/work/=/product_id/RJ01096697.html",
          "https://www.dlsite.com/maniax/work/=/product_id/RJ01134569.html",
          "https://www.dlsite.com/maniax/announce/=/product_id/RJ01137148.html",
          "https://www.dlsite.com/maniax-touch/announce/=/product_id/RJ01110853.html",
          "https://www.dlsite.com/girls/work/=/product_id/RJ01345621.html",
          "https://www.dlsite.com/bl/work/=/product_id/RJ01329452.html",
          "https://www.dlsite.com/pro/work/=/product_id/VJ015443.html",
          "https://www.dlsite.com/books/work/=/product_id/BJ181344.html",
          "https://www.dlsite.com/eng/work/=/product_id/RE277378.html",
          "https://www.dlsite.com/ecchi-eng/work/=/product_id/RE028506.html",
          "https://www.dlsite.com/ecchi-eng-touch/work/=/product_id/RE166667.html",
          "https://www.dlsite.com/ecchi-eng/announce/=/product_id/RE155768.html",
          "https://eng.dlsite.com/work/=/product_id/RE036764",
          "https://eng.dlsite.com/work/=/product_id/RE022725.html",
          "http://maniax.dlsite.com/work/=/product_id/RJ072689.html",
        ],
        profile_urls: [
          "https://www.dlsite.com/maniax/circle/profile/=/maker_id/RG05689",
          "https://www.dlsite.com/maniax/circle/profile/=/maker_id/RG05689.html",
          "https://www.dlsite.com/maniax-touch/circle/profile/=/maker_id/RG64022.html",
          "https://www.dlsite.com/home/circle/profile/=/maker_id/RG64308.html",
          "https://www.dlsite.com/ecchi-eng/circle/profile/=/maker_id/RG05689.html",
          "https://www.dlsite.com/girls/circle/profile/=/maker_id/RG70492.html",
          "https://www.dlsite.com/bl/circle/profile/=/maker_id/RG11630.html",
          "https://www.dlsite.com/books/author/=/author_id/AJ010529",
          "https://www.dlsite.com/comic/author/=/author_id/AJ010529",
          "https://www.dlsite.com/maniax/author/=/author_id/AJ010452",
        ],
      )
    end

    context "when extracting attributes" do
      url_parser_should_work("https://img.dlsite.jp/modpub/images2/work/doujin/RJ01183000/RJ01182574_img_main.jpg",                       page_url: "https://www.dlsite.com/maniax/work/=/product_id/RJ01182574.html")
      url_parser_should_work("https://img.dlsite.jp/modpub/images2/ana/doujin/RJ01571000/RJ01570715_ana_img_main.webp",                   page_url: "https://www.dlsite.com/maniax/announce/=/product_id/RJ01570715.html")
      url_parser_should_work("https://img.dlsite.jp/modpub/images2/parts/RJ01109000/RJ01108646/c595ec4d121d80c300d94b368806d655.jpg",     page_url: "https://www.dlsite.com/maniax/work/=/product_id/RJ01108646.html")
      url_parser_should_work("https://img.dlsite.jp/modpub/images2/parts_ana/RJ01030000/RJ01029765/33415f94d0cf83d85f39624dac1e3724.jpg", page_url: "https://www.dlsite.com/maniax/announce/=/product_id/RJ01029765.html")

      url_parser_should_work("https://www.dlsite.com/home/work/=/product_id/RJ01096697",                  page_url: "https://www.dlsite.com/home/work/=/product_id/RJ01096697.html")
      url_parser_should_work("https://www.dlsite.com/home/work/=/product_id/RJ01096697.html",             page_url: "https://www.dlsite.com/home/work/=/product_id/RJ01096697.html")
      url_parser_should_work("https://www.dlsite.com/maniax/work/=/product_id/RJ01134569.html",           page_url: "https://www.dlsite.com/maniax/work/=/product_id/RJ01134569.html")
      url_parser_should_work("https://www.dlsite.com/maniax/announce/=/product_id/RJ01137148.html",       page_url: "https://www.dlsite.com/maniax/announce/=/product_id/RJ01137148.html")
      url_parser_should_work("https://www.dlsite.com/maniax-touch/announce/=/product_id/RJ01110853.html", page_url: "https://www.dlsite.com/maniax-touch/announce/=/product_id/RJ01110853.html")
      url_parser_should_work("https://www.dlsite.com/girls/work/=/product_id/RJ01345621.html",            page_url: "https://www.dlsite.com/girls/work/=/product_id/RJ01345621.html")
      url_parser_should_work("https://www.dlsite.com/bl/work/=/product_id/RJ01329452.html",               page_url: "https://www.dlsite.com/bl/work/=/product_id/RJ01329452.html")
      url_parser_should_work("https://www.dlsite.com/pro/work/=/product_id/VJ015443.html",                page_url: "https://www.dlsite.com/pro/work/=/product_id/VJ015443.html")
      url_parser_should_work("https://www.dlsite.com/books/work/=/product_id/BJ181344.html",              page_url: "https://www.dlsite.com/books/work/=/product_id/BJ181344.html")
      url_parser_should_work("https://www.dlsite.com/eng/work/=/product_id/RE277378.html",                page_url: "https://www.dlsite.com/eng/work/=/product_id/RE277378.html")
      url_parser_should_work("https://www.dlsite.com/ecchi-eng/work/=/product_id/RE028506.html",          page_url: "https://www.dlsite.com/ecchi-eng/work/=/product_id/RE028506.html")
      url_parser_should_work("https://www.dlsite.com/ecchi-eng-touch/work/=/product_id/RE166667.html",    page_url: "https://www.dlsite.com/ecchi-eng-touch/work/=/product_id/RE166667.html")
      url_parser_should_work("https://www.dlsite.com/ecchi-eng/announce/=/product_id/RE155768.html",      page_url: "https://www.dlsite.com/ecchi-eng/announce/=/product_id/RE155768.html")

      url_parser_should_work("https://eng.dlsite.com/work/=/product_id/RE036764",                         page_url: "https://www.dlsite.com/maniax/work/=/product_id/RE036764.html")
      url_parser_should_work("https://eng.dlsite.com/work/=/product_id/RE022725.html",                    page_url: "https://www.dlsite.com/maniax/work/=/product_id/RE022725.html")
      url_parser_should_work("http://maniax.dlsite.com/work/=/product_id/RJ072689.html",                  page_url: "https://www.dlsite.com/maniax/work/=/product_id/RJ072689.html")

      url_parser_should_work("https://www.dlsite.com/maniax/circle/profile/=/maker_id/RG05689",            profile_url: "https://www.dlsite.com/maniax/circle/profile/=/maker_id/RG05689.html")
      url_parser_should_work("https://www.dlsite.com/maniax/circle/profile/=/maker_id/RG05689.html",       profile_url: "https://www.dlsite.com/maniax/circle/profile/=/maker_id/RG05689.html")
      url_parser_should_work("https://www.dlsite.com/maniax-touch/circle/profile/=/maker_id/RG64022.html", profile_url: "https://www.dlsite.com/maniax/circle/profile/=/maker_id/RG64022.html")
      url_parser_should_work("https://www.dlsite.com/home/circle/profile/=/maker_id/RG64308.html",         profile_url: "https://www.dlsite.com/maniax/circle/profile/=/maker_id/RG64308.html")
      url_parser_should_work("https://www.dlsite.com/ecchi-eng/circle/profile/=/maker_id/RG05689.html",    profile_url: "https://www.dlsite.com/maniax/circle/profile/=/maker_id/RG05689.html")
      url_parser_should_work("https://www.dlsite.com/girls/circle/profile/=/maker_id/RG70492.html",        profile_url: "https://www.dlsite.com/maniax/circle/profile/=/maker_id/RG70492.html")
      url_parser_should_work("https://www.dlsite.com/bl/circle/profile/=/maker_id/RG11630.html",           profile_url: "https://www.dlsite.com/maniax/circle/profile/=/maker_id/RG11630.html")

      url_parser_should_work("https://www.dlsite.com/books/author/=/author_id/AJ010529",                   profile_url: "https://www.dlsite.com/books/author/=/author_id/AJ010529")
      url_parser_should_work("https://www.dlsite.com/comic/author/=/author_id/AJ010529",                   profile_url: "https://www.dlsite.com/books/author/=/author_id/AJ010529")
      url_parser_should_work("https://www.dlsite.com/maniax/author/=/author_id/AJ010452",                  profile_url: "https://www.dlsite.com/books/author/=/author_id/AJ010452")
    end
  end
end
