require 'character_constants'
require 'conversion_table'

module GSMTexting
  include CharacterConstants
  include ConversionTable
  extend self

  DEFAULT_REPLACE_CHAR = "?".freeze

  BASIC_CHARACTER_SET = [
    '@', 'Δ',  SP, '0', '¡', 'P', '¿', 'p',
    '£', '_', '!', '1', 'A', 'Q', 'a', 'q',
    '$', 'Φ',  DQ, '2', 'B', 'R', 'b', 'r',
    '¥', 'Γ', '#', '3', 'C', 'S', 'c', 's',
    'è', 'Λ', '¤', '4', 'D', 'T', 'd', 't',
    'é', 'Ω', '%', '5', 'E', 'U', 'e', 'u',
    'ù', 'Π', '&', '6', 'F', 'V', 'f', 'v',
    'ì', 'Ψ',  SQ, '7', 'G', 'W', 'g', 'w',
    'ò', 'Σ', '(', '8', 'H', 'X', 'h', 'x',
    'Ç', 'Θ', ')', '9', 'I', 'Y', 'i', 'y',
     LF, 'Ξ', '*', ':', 'J', 'Z', 'j', 'z',
    'Ø', ESC, '+', ';', 'K', 'Ä', 'k', 'ä',
    'ø', 'Æ', ',', '<', 'L', 'Ö', 'l', 'ö',
     CR, 'æ', '-', '=', 'M', 'Ñ', 'm', 'ñ',
    'Å', 'ß', '.', '>', 'N', 'Ü', 'n', 'ü',
    'å', 'É', '/', '?', 'O', '§', 'o', 'à'
  ].freeze

  BASIC_CHARACTER_SET_EXTENSION = [
    FF, BS, '|', '^', '€', '{', '}', '[', '~', ']'
  ].freeze

  CHARACTER_SET_REGEX = Regexp.escape(BASIC_CHARACTER_SET.join)
  CHARACTER_EXTENSION_REGEX = Regexp.escape(BASIC_CHARACTER_SET_EXTENSION.compact.join)

  GSM_REGEX = /\A[#{CHARACTER_SET_REGEX}#{CHARACTER_EXTENSION_REGEX}]*\z/.freeze

  # Verifies if string can be encoded in GSM-7 without loosing information
  def can_encode?(str)
    str.nil? || !(GSM_REGEX =~ str).nil?
  end

  # Convert unicode chars to GSM-7 compatible equivalents if possible
  def encode(str, replace_char: nil)
    return if str.nil?

    unless replace_char && can_encode?(replace_char)
      replace_char = DEFAULT_REPLACE_CHAR
    end

    str.unpack("U*").map { |char|
      gsm_compatible_char = CONVERSION_TABLE[char]
      utf8_char = char.chr(Encoding::UTF_8)
      gsm_char = can_encode?(utf8_char) ? utf8_char : replace_char

      gsm_compatible_char || gsm_char
    }.join
  end
end
