require "test_helper"

module Source::Tests::Extractor
  class BoothExtractorTest < ActiveSupport::TestCase
    context "A booth post" do
      strategy_should_work(
        "https://booth.pm/en/items/3240411",
        image_urls: %w[
          https://booth.pximg.net/767c867a-c6c7-426b-80b6-894d92993db3/i/3240411/150d3a16-7339-4484-b95f-63638c0b75d2.png
          https://booth.pximg.net/767c867a-c6c7-426b-80b6-894d92993db3/i/3240411/1207a003-baf5-49b5-8010-e986dd00e63a.jpg
          https://booth.pximg.net/767c867a-c6c7-426b-80b6-894d92993db3/i/3240411/ce9b3c6c-5f00-47b0-9bd1-fb9619a36531.jpg
        ],
        profile_url: "https://cullmee.booth.pm",
        page_url: "https://booth.pm/en/items/3240411",
        display_name: "くるみ",
        username: "cullmee",
        other_names: %w[くるみ cullmee],
        tags: %w[アイドルマスターシャイニーカラーズ アクリルスタンド二次創作 シャニマス 月岡恋鐘],
        artist_commentary_title: "月岡恋鐘 日本横断フェア アクリルスタンド",
        dtext_artist_commentary_desc: <<~EOS.chomp,
          歌姫庭園28にて頒布した月岡恋鐘(日本横断フェア衣装)のアクリルスタンド
          高さ140mm×幅8mm(約)
          厚さ3mm
        EOS
      )
    end

    context "An active booth image" do
      strategy_should_work(
        "https://booth.pximg.net/767c867a-c6c7-426b-80b6-894d92993db3/i/3240411/150d3a16-7339-4484-b95f-63638c0b75d2.png",
        image_urls: %w[
          https://booth.pximg.net/767c867a-c6c7-426b-80b6-894d92993db3/i/3240411/150d3a16-7339-4484-b95f-63638c0b75d2.png
        ],
        profile_url: "https://cullmee.booth.pm",
        page_url: "https://booth.pm/en/items/3240411",
        display_name: "くるみ",
        username: "cullmee",
        other_names: %w[くるみ cullmee],
        tags: %w[アイドルマスターシャイニーカラーズ アクリルスタンド二次創作 シャニマス 月岡恋鐘],
        artist_commentary_title: "月岡恋鐘 日本横断フェア アクリルスタンド",
        dtext_artist_commentary_desc: <<~EOS.chomp,
          歌姫庭園28にて頒布した月岡恋鐘(日本横断フェア衣装)のアクリルスタンド
          高さ140mm×幅8mm(約)
          厚さ3mm
        EOS
      )
    end

    context "A deleted booth image" do
      strategy_should_work(
        "https://booth.pximg.net/67e59677-bc7e-4249-918f-8c406b204df6/i/4266304/71f7517c-ed21-4a51-9e62-030787c44c0c.jpeg",
        image_urls: ["https://booth.pximg.net/67e59677-bc7e-4249-918f-8c406b204df6/i/4266304/71f7517c-ed21-4a51-9e62-030787c44c0c.jpeg"],
        page_url: "https://booth.pm/en/items/4266304",
        profile_url: nil,
        display_name: nil,
        username: nil,
        other_names: [],
        tags: [],
        artist_commentary_title: nil,
        dtext_artist_commentary_desc: "",
      )
    end

    context "A booth post with artist name in the url" do
      strategy_should_work(
        "https://re-face.booth.pm/items/2423989",
        image_urls: ["https://booth.pximg.net/8bb9e4e3-d171-4027-88df-84480480f79d/i/2423989/a692d4f3-4371-4a86-a337-83fee82d46a4.png"],
        profile_url: "https://re-face.booth.pm",
        page_url: "https://booth.pm/en/items/2423989",
        display_name: "Re:fAce Music Production SHOP",
        username: "re-face",
        other_names: ["Re:fAce Music Production SHOP", "re-face"],
        tags: ["music", "original", "re:face", "ricchan *", "virtual youtuber", "くるみ", "だてんちゆあ", "ひなの羽衣", "りふぇいす。", "アイドル", "千草はな", "白乃クロミ", "白咲べる", "赤坂まさか", "音楽"],
        artist_commentary_title: "RwithV vol.1 -アイドルはじめます！-",
        dtext_artist_commentary_desc: <<~EOS.chomp,
          Re:fAce 2020秋新作アルバム「R with V vol.1 -アイドルはじめます！-」

          Re:fAce×Vtuberコラボアルバム第一弾は7人のVtuberとRe:fAceがコラボした全12曲の豪華フルアルバム。

          千草はな https://twitter.com/hanachigusa_ch
          白咲べる https://twitter.com/bell_srsk
          くるみ https://twitter.com/kurumi_UoxoU
          白乃クロミ https://twitter.com/shirono_kuromi
          ひなの羽衣 https://twitter.com/HinanoUi
          だてんちゆあ https://twitter.com/datenti_yua
          赤坂まさか https://twitter.com/Masaka_asobu

          注文が殺到した際は、発送が遅れてしまう場合もございますので予めご了承ください。

          最新情報をお届け！各種ページをチェック！！

          Re:fAce公式ツイッター https://twitter.com/RefAce_official
          りふぇいす。公式キャラクター りふぇ子 https://twitter.com/refA_ko
          Re:fAce/りふぇいす。公式HP https://www.reface-music.com
        EOS
      )
    end

    context "A booth post with a factory.pixiv.net image" do
      strategy_should_work(
        "https://dai-xt.booth.pm/items/5701118",
        image_urls: %w[
          https://booth.pximg.net/1b715ca5-f3dc-484e-9406-eec4047c5ad0/i/5701118/1eabc2c5-e2a1-4079-89ce-061226edeb85.png
          https://booth.pximg.net/1b715ca5-f3dc-484e-9406-eec4047c5ad0/i/5701118/3deaf844-0f03-4bb9-ad32-58b158e787ba.png
          https://booth.pximg.net/1b715ca5-f3dc-484e-9406-eec4047c5ad0/i/5701118/3a461bed-40a5-42bf-b216-676a1303b691.png
          https://factory.pixiv.net/files/uploads/i/conceptual_drawing/3a6f3742-03b6-4968-9599-20dc2c0e1172/canvas_f2605b12ed.png
        ],
        media_files: [
          { file_size: 606_453 },
          { file_size: 785_702 },
          { file_size: 287_766 },
          { file_size: 321_775 },
        ],
        page_url: "https://booth.pm/en/items/5701118",
        profile_urls: %w[https://dai-xt.booth.pm],
        display_name: "シーウィード・ヴィレッジ",
        username: "dai-xt",
        tags: [
          ["ライブ・ア・ヒーロー!", "https://booth.pm/en/items?tags%5B%5D=%E3%83%A9%E3%82%A4%E3%83%96%E3%83%BB%E3%82%A2%E3%83%BB%E3%83%92%E3%83%BC%E3%83%AD%E3%83%BC%21"],
          ["ダンゾー", "https://booth.pm/en/items?tags%5B%5D=%E3%83%80%E3%83%B3%E3%82%BE%E3%83%BC"],
        ],
        dtext_artist_commentary_title: "ダンゾー(ライブ・ア・ヒーロー！) 非公式アクリルフィギュア",
        dtext_artist_commentary_desc: <<~EOS.chomp,
          この商品はpixivFACTORYで作られた商品です。サンプル画像は完成イメージのため、実物と異なる場合があります。

          -----
          画集『SCHRANZ NINJA』の表紙を飾るダンゾーのアクリルフィギュア。
          公式とは無関係のファングッズですのでご了承ください。

          ロゴデザイン：Poyoshi 様
        EOS
      )
    end

    context "A profile background picture" do
      strategy_should_work(
        "https://s2.booth.pm/8bb9e4e3-d171-4027-88df-84480480f79d/3d70de06-8e7c-444e-b8eb-a8a95bf20638_base_resized.jpg",
        image_urls: ["https://s2.booth.pm/8bb9e4e3-d171-4027-88df-84480480f79d/3d70de06-8e7c-444e-b8eb-a8a95bf20638.png"],
        page_url: nil,
        profile_url: nil,
        display_name: nil,
        username: nil,
        other_names: [],
        tags: [],
        artist_commentary_title: nil,
        artist_commentary_desc: nil,
      )
    end

    context "A profile icon" do
      strategy_should_work(
        "https://booth.pximg.net/c/128x128/users/3193929/icon_image/5be9eff4-1d9e-4a79-b097-33c1cd4ad314_base_resized.jpg",
        image_urls: ["https://booth.pximg.net/users/3193929/icon_image/5be9eff4-1d9e-4a79-b097-33c1cd4ad314.png"],
        page_url: nil,
        profile_url: nil,
        display_name: nil,
        username: nil,
        other_names: [],
        tags: [],
        artist_commentary_title: nil,
        artist_commentary_desc: nil,
      )
    end

    context "A non-existing or deleted post" do
      strategy_should_work(
        "https://booth.pm/en/items/2003079",
        deleted: true,
        page_url: "https://booth.pm/en/items/2003079",
        profile_url: nil,
        display_name: nil,
        username: nil,
        other_names: [],
        tags: [],
        artist_commentary_title: nil,
        artist_commentary_desc: nil,
      )
    end
  end
end
