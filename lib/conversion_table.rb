require 'character_constants'

module ConversionTable
  include CharacterConstants

  # https://www.twilio.com/docs/sms/services/copilot-smart-encoding-char-list
  # Converts UNICODE characters to GSM compatible ones
  CONVERSION_TABLE = {
    0x00ab => DQ, # «
    0x00bb => DQ, # »
    0x02ba => DQ, # ʺ
    0x02ee => DQ, # ˮ
    0x201f => DQ, # ‟
    0x275d => DQ, # ❝
    0x275e => DQ, # ❞
    0x301d => DQ, #
    0x301e => DQ, # 〞
    0xff02 => DQ, #
    0x2018 => SQ, # ‘
    0x2019 => SQ, # ’
    0x02bb => SQ, # ʻ
    0x02c8 => SQ, # ˈ
    0x02bc => SQ, # ʼ
    0x02bd => SQ, # ʽ
    0x02b9 => SQ, # ʹ
    0xff07 => SQ, #
    0x00b4 => SQ, # ´
    0x02ca => SQ, # ˊ
    0x0060 => SQ, # `
    0x02cb => SQ, # ˋ
    0x275b => SQ, # ❛
    0x275c => SQ, # ❜
    0x0313 => SQ, #
    0x0314 => SQ, #
    0xfe10 => SQ, #
    0xfe11 => SQ, #
    0x00f7 => '/', # ÷
    0x00bc => '1/4', # ¼
    0x00bd => '1/2', # ½
    0x00be => '3/4', # ¾
    0x29f8 => '/', # ⧸
    0x0337 => '/', #
    0x0338 => '/', #
    0x2044 => '/', # ⁄
    0x2215 => '/', # ∕
    0xff0f => '/', # ／
    0x29f9 => BS, # ⧹
    0x29f5 => BS, # ⧵
    0x20e5 => BS, #
    0xfe68 => BS, #
    0xff3c => BS, # ＼
    0x0332 => '_', #
    0xff3f => '_', # ＿
    0x20d2 => '|', #
    0x20d3 => '|', #
    0x2223 => '|', # ∣
    0xff5c => '|', #
    0x23b8 => '|', # ⎸
    0x23b9 => '|', #
    0x23d0 => '|', # ⏐
    0x239c => '|', # ⎜
    0x239f => '|', # ⎟
    0x23bc => '-', # ⎼
    0x23bd => '-', # ⎽
    0x2015 => '-', # ―
    0xfe63 => '-', # ﹣
    0xff0d => '-', # －
    0x2010 => '-', # ‐
    0x2043 => '-', # ⁃
    0xfe6b => '@', # ﹫
    0xff20 => '@', # ＠
    0xfe69 => '$', # ﹩
    0xff04 => '$', # ＄
    0x01c3 => '!', # ǃ
    0xfe15 => '!', #
    0xfe57 => '!', #
    0xff01 => '!', # ！
    0xfe5f => '#', # ﹟
    0xff03 => '#', # ＃
    0xfe6a => '%', # ﹪
    0xff05 => '%', # ％
    0xfe60 => '&', # ﹠
    0xff06 => '&', # ＆
    0x0326 => ',', #
    0xfe50 => ',', # ﹐
    0xfe51 => ',', # ﹑
    0xff0c => ',', # ，
    0xff64 => ',', # ､
    0x2768 => '(', # ❨
    0x276a => '(', # ❪
    0xfe59 => '(', # ﹙
    0xff08 => '(', #
    0x27ee => '(', # ⟮
    0x2985 => '(', # ⦅
    0x2769 => ')', # ❩
    0x276b => ')', # ❫
    0xfe5a => ')', # ﹚
    0xff09 => ')', # ）
    0x27ef => ')', # ⟯
    0x2986 => ')', # ⦆
    0x204e => '*', # ⁎
    0x2217 => '*', # ∗
    0x229b => '*', # ⊛
    0x2722 => '*', # ✢
    0x2723 => '*', # ✣
    0x2724 => '*', # ✤
    0x2725 => '*', # ✥
    0x2731 => '*', # ✱
    0x2732 => '*', # ✲
    0x2733 => '*', # ✳
    0x273a => '*', # ✺
    0x273b => '*', # ✻
    0x273c => '*', # ✼
    0x273d => '*', # ✽
    0x2743 => '*', # ❃
    0x2749 => '*', # ❉
    0x274a => '*', # ❊
    0x274b => '*', # ❋
    0x29c6 => '*', # ⧆
    0xfe61 => '*', # ﹡
    0xff0a => '*', # ＊
    0x02d6 => '+', # ˖
    0xfe62 => '+', # ﹢
    0xff0b => '+', # ＋
    0x3002 => '.', # 。
    0xfe52 => '.', # ﹒
    0xff0e => '.', # ．
    0xff61 => '.', # ｡
    0xff10 => '0', # ０
    0xff11 => '1', # １
    0xff12 => '2', # ２
    0xff13 => '3', # ３
    0xff14 => '4', # ４
    0xff15 => '5', # ５
    0xff16 => '6', # ６
    0xff17 => '7', # ７
    0xff18 => '8', # ８
    0xff19 => '9', # ９
    0x02d0 => ':', # ː
    0x02f8 => ':', # ˸
    0x2982 => ':', # ˸
    0xa789 => ':', # ꞉
    0xfe13 => ':', # ︓
    0xff1a => ':', # ：
    0x204f => ';', # ⁏
    0xfe14 => ';', # ︔
    0xfe54 => ';', # ﹔
    0xff1b => ';', # ；
    0xfe64 => '<', # ﹤
    0xff1c => '<', # ＜
    0x0347 => '=', #
    0xa78a => '=', # ꞊
    0xfe66 => '=', # ﹦
    0xff1d => '=', # ＝
    0xfe65 => '>', # ﹥
    0xff1e => '>', # ＞
    0xfe16 => '?', # ︖
    0xfe56 => '?', # ﹖
    0xff1f => '?', # ？
    0xff21 => 'A', # Ａ
    0x1d00 => 'A', # ᴀ
    0xff22 => 'B', # Ｂ
    0x0299 => 'B', # ʙ
    0xff23 => 'C', # Ｃ
    0x1d04 => 'C', # ᴄ
    0xff24 => 'D', # Ｄ
    0x1d05 => 'D', # ᴅ
    0xff25 => 'E', # Ｅ
    0x1d07 => 'E', # ᴇ
    0xff26 => 'F', # Ｆ
    0xA730 => 'F', # ꜰ
    0xff27 => 'G', # Ｇ
    0x0262 => 'G', # ɢ
    0xff28 => 'H', # Ｈ
    0x029c => 'H', # ʜ
    0xff29 => 'I', # Ｉ
    0x026a => 'I', # ɪ
    0xff2a => 'J', # Ｊ
    0x1d0a => 'J', # ᴊ
    0xff2b => 'K', # Ｋ
    0x1d0b => 'K', # ᴋ
    0xff2c => 'L', # Ｌ
    0x029f => 'L', # ʟ
    0xff2d => 'M', # Ｍ
    0x1d0d => 'M', # ᴍ
    0xff2e => 'N', # Ｎ
    0x0274 => 'N', # ɴ
    0xff2f => 'O', # Ｏ
    0x1d0f => 'O', # ᴏ
    0xff30 => 'P', # Ｐ
    0x1d18 => 'P', # ᴘ
    0xff31 => 'Q', # Ｑ
    0xff32 => 'R', # Ｒ
    0x0280 => 'R', # ʀ
    0xff33 => 'S', # Ｓ
    0xa731 => 'S', # ꜱ
    0xff34 => 'T', # Ｔ
    0x1d1b => 'T', # ᴛ
    0xff35 => 'U', # Ｕ
    0x1d1c => 'U', # ᴜ
    0xff36 => 'V', # Ｖ
    0x1d20 => 'V', # ᴠ
    0xff37 => 'W', # Ｗ
    0x1d21 => 'W', # ᴡ
    0xff38 => 'X', # Ｘ
    0xff39 => 'Y', # Ｙ
    0x028f => 'Y', # ʏ
    0xff3a => 'Z', # Ｚ
    0x1d22 => 'Z', # ᴢ
    0x02c6 => '^', # ˆ
    0x0302 => '^', #
    0xff3e => '^', # ＾
    0x1dcd => '^', #
    0x2774 => '{', # ❴
    0xfe5b => '{', # ﹛
    0xff5b => '{', #
    0x2775 => '}', # ❵
    0xfe5c => '}', # ﹜
    0xff5d => '}', # ｝
    0xff3b => '[', #
    0xff3d => ']', # ］
    0x02dc => '~', # ˜
    0x02f7 => '~', # ˷
    0x0303 => '~', #
    0x0330 => '~', #
    0x0334 => '~', #
    0x223c => '~', # ∼
    0xff5e => '~', # ～
    0x00a0 => SP,
    0x2000 => SP,
    0x2001 => SP,
    0x2002 => SP,
    0x2003 => SP,
    0x2004 => SP,
    0x2005 => SP,
    0x2006 => SP,
    0x2007 => SP,
    0x2008 => SP,
    0x2009 => SP,
    0x200a => SP,
    0x3000 => SP,
    0x008d => SP,
    0x009f => SP,
    0x0080 => SP,
    0x0090 => SP,
    0x009b => SP,
    0x0010 => SP,
    0x0009 => SP,
    0x0000 => SP,
    0x0003 => SP,
    0x0004 => SP,
    0x0017 => SP,
    0x0019 => SP,
    0x0011 => SP,
    0x0012 => SP,
    0x0013 => SP,
    0x0014 => SP,
    0x2017 => '_', # ‗
    0x2014 => '-', # —
    0x2013 => '-', # –
    0x201a => SQ, # ‚
    0x202f => SP,
    0x2039 => '>', # ‹
    0x203A => '<', # ›
    0x203c => '!!', # ‼
    0x201e => DQ, # „
    0x201d => DQ, # ”
    0x201c => DQ, # “
    0x201b => SQ, # ‛
    0x2026 => '...', # …
    0x2028 => SP,
    0x2029 => SP,
    0x205f => SP,
    0x2060 => SP
  }.freeze
end
