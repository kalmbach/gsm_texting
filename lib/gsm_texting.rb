require 'character_constants'
require 'compatibility_table'
require 'conversion_table'

module GSMTexting
  include CharacterConstants
  include CompatibilityTable
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
  def encode(str, transliterate: false, replace_char: nil)
    return if str.nil?
    replace_char = canonicalize_replace_char(replace_char)

    str.unpack("U*").map { |char|
      utf8_char = char.chr(Encoding::UTF_8)

      compatible_char = compatible_char_for(char)
      transformed_char = transformed_char_for(char) if transliterate
      gsm_char_for(compatible_char || transformed_char || utf8_char, replace_char)
    }.join
  end

  private

  def canonicalize_replace_char(char)
    char && can_encode?(char) ? char : DEFAULT_REPLACE_CHAR
  end

  def compatible_char_for(char)
    COMPATIBILITY_TABLE[char]
  end

  def transformed_char_for(char)
    CONVERSION_TABLE[char]
  end

  def gsm_char_for(char, replace_char)
    can_encode?(char) ? char : replace_char
  end
end
