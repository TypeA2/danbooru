require "test_helper"

module Source::Tests::URL
  class NaverCafeUrlTest < ActiveSupport::TestCase
    context "when parsing" do
      should_identify_url_types(
        image_urls: [
          "https://cafeptthumb-phinf.pstatic.net/MjAyMDA3MDZfMTM0/MDAxNTk0MDA2Mjk0MTcw.JA_GkVUpYytyzximdxyl9Y7wtMoBHkPn2p7S3dLLAzYg.XQfw46B7G2ae5nhw7xc3wkWZgYUS9Debf_XIlsED1jgg.PNG/1.png?type=w800",
          "https://cafeskthumb-phinf.pstatic.net/MjAyNDA0MDFfMjkw/MDAxNzExOTQ5MTg5NzY2.8DmwoaPifD-0oadfU7t1_lKnvdamYMrnLy54eMrN9vAg.za-YKoWgxbO1dTr4Zql6sZH0FmdOsirmo3WobhB2kJgg.JPEG/maxresdefault.jpg?type=w1080",
          "https://cafefiles.pstatic.net/MjAyMDA3MDZfMTM0/MDAxNTk0MDA2Mjk0MTcw.JA_GkVUpYytyzximdxyl9Y7wtMoBHkPn2p7S3dLLAzYg.XQfw46B7G2ae5nhw7xc3wkWZgYUS9Debf_XIlsED1jgg.PNG/1.png",
          "https://cafefiles.pstatic.net/MjAyNDA0MDFfMjkw/MDAxNzExOTQ5MTg5NzY2.8DmwoaPifD-0oadfU7t1_lKnvdamYMrnLy54eMrN9vAg.za-YKoWgxbO1dTr4Zql6sZH0FmdOsirmo3WobhB2kJgg.JPEG/maxresdefault.jpg",
          "http://cafefiles.naver.net/MjAyMDA3MDZfMTM0/MDAxNTk0MDA2Mjk0MTcw.JA_GkVUpYytyzximdxyl9Y7wtMoBHkPn2p7S3dLLAzYg.XQfw46B7G2ae5nhw7xc3wkWZgYUS9Debf_XIlsED1jgg.PNG/1.png",
          "http://cafefiles.naver.net/MjAyNDA0MDFfMjkw/MDAxNzExOTQ5MTg5NzY2.8DmwoaPifD-0oadfU7t1_lKnvdamYMrnLy54eMrN9vAg.za-YKoWgxbO1dTr4Zql6sZH0FmdOsirmo3WobhB2kJgg.JPEG/maxresdefault.jpg",
          "http://cafefiles.naver.net/20160912_57/lioneva_1473691969811MBqn4_JPEG/%BF%A1%B5%E0%C4%C9%C0%CC%C5%CD.jpg",
        ],
        page_urls: [
          "https://cafe.naver.com/ca-fe/cafes/29767250/articles/785",
          "https://m.cafe.naver.com/ca-fe/web/cafes/29767250/articles/785",
          "https://cafe.naver.com/ArticleRead.nhn?clubid=29767250&articleid=793",
          "https://m.cafe.naver.com/ArticleRead.nhn?clubid=29767250&articleid=793",
          "https://cafe.naver.com/nexonmoe?iframe_url=%2FArticleRead.nhn%3Fclubid%3D29767250%26articleid%3D793",
          "https://cafe.naver.com/nexonmoe?iframe_url_utf8=%2FArticleRead.nhn%3Fclubid%3D29767250%26articleid%3D793",
          "https://cafe.naver.com/masterofeternity/793",
          "https://m.cafe.naver.com/masterofeternity/793",
        ],
        profile_urls: [
          "https://cafe.naver.com/masterofeternity",
          "https://m.cafe.naver.com/masterofeternity",
          "https://cafe.naver.com/masterofeternity?iframe_url=/MyCafeIntro.nhn%3Fclubid=29314033",
          "https://cafe.naver.com/MyCafeIntro.nhn?clubid=29314033",
          "https://cafe.naver.com/ArticleList.nhn?search.clubid=29767250&search.menuid=19",
          "https://cafe.naver.com/ca-fe/cafes/27842958/members/Iep9BEdfIxd759MU7JgtSg",
        ],
      )

      should_not_find_false_positives(
        image_urls: [
          "https://m.cafe.naver.com/ImageView.nhn?imageUrl=https://cafeptthumb-phinf.pstatic.net/MjAyMDEwMjFfMjIz/MDAxNjAzMjc1MTg3NjM5.waVrxNtSEW261INoEfGXuebgU4-q-IcNCg2oE7PfQ2Ug.vzDeHTJOcain0rNrITE80ulrN21UjiSEeU3X22qAEuUg.GIF/5sopu.gif",
          "https://cafe.naver.com/common/storyphoto/viewer.html?src=https%3A%2F%2Fcafeptthumb-phinf.pstatic.net%2FMjAyMzA3MDZfMzIg%2FMDAxNjg4NjM3NzcyNDg3.CrtekTl5XiXEJCFy9532vabMKo0CaWwryTMM0Up77Jgg.8ppf2Q3uiVWUlIP6jckYwYSe5Ys-erSsd7yf8XoHECIg.PNG%2F%25EC%259C%25A0%25EC%259A%25B0%25EC%25B9%25B4_%25EC%2597%2585%25EB%25A1%259C%25EB%2593%259C%25EC%259A%25A9.png",
        ],
      )
    end
  end
end
