require File.expand_path(File.dirname(__FILE__) + "/../lib/gsm_texting")

RSpec.describe GSMTexting do
  describe "#can_encode?" do
    it "can encode basic set of characters" do
      basic_set = GSMTexting::BASIC_CHARACTER_SET.join
      expect(GSMTexting.can_encode?(basic_set)).to be true
    end

    it "can encode extended set of characters" do
      extended_set = GSMTexting::BASIC_CHARACTER_SET_EXTENSION.join
      expect(GSMTexting.can_encode?(extended_set)).to be true
    end

    it "cannot encode compatible unicode characters" do
      input_characters = GSMTexting::COMPATIBILITY_TABLE.keys.pack("U*")
      expect(GSMTexting.can_encode?(input_characters)).to be false
    end

    it "cannot encode convertible characters" do
      input_characters = GSMTexting::CONVERSION_TABLE.keys.pack("U*")
      expect(GSMTexting.can_encode?(input_characters)).to be false
    end
  end

  describe "#encode" do
    it "can convert unicode characters to gsm compatible characters" do
      input_characters = GSMTexting::COMPATIBILITY_TABLE.keys.pack("U*")
      expect(GSMTexting.can_encode?(input_characters)).to be false

      encoded_characters = GSMTexting.encode(input_characters)
      expect(GSMTexting.can_encode?(encoded_characters)).to be true
    end

    it "can transliterate unicode chars to compatible gsm characters" do
      input_characters = GSMTexting::CONVERSION_TABLE.keys.pack("U*")
      expect(GSMTexting.can_encode?(input_characters)).to be false

      encoded_characters = GSMTexting.encode(input_characters, transliterate: true)
      expect(GSMTexting.can_encode?(encoded_characters)).to be true
    end
  end

  describe "replace_char argument" do
    it "will use default replace character" do
      input_characters = "ξ"
      expect(GSMTexting.can_encode?(input_characters)).to be false

      encoded_characters = GSMTexting.encode(input_characters)
      expect(encoded_characters).to eq GSMTexting::DEFAULT_REPLACE_CHAR
    end

    it "will use provided char as replacement" do
      input_characters = "ξ"
      expect(GSMTexting.can_encode?(input_characters)).to be false

      encoded_characters = GSMTexting.encode(input_characters, replace_char: "*")
      expect(encoded_characters).to eq "*"
    end
  end

  describe "transliterate argument" do
    it "will not transliterate chars by default" do
      input_characters = GSMTexting::CONVERSION_TABLE.keys.pack("U*")
      expect(GSMTexting.can_encode?(input_characters)).to be false

      encoded_characters = GSMTexting.encode(input_characters)
      expect(encoded_characters).to eq "?" * input_characters.length
    end

    it "will transliterate chars if requested" do
      input_characters = GSMTexting::CONVERSION_TABLE.keys.pack("U*")
      expect(GSMTexting.can_encode?(input_characters)).to be false

      encoded_characters = GSMTexting.encode(input_characters, transliterate: true)
      expect(encoded_characters).to eq GSMTexting::CONVERSION_TABLE.values.join
    end
  end
end
