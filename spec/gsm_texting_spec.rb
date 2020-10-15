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

    it "cannot encode incompatible unicode characters" do
      unicode_characters = GSMTexting::COMPATIBILITY_TABLE.keys.pack("U*")
      expect(GSMTexting.can_encode?(unicode_characters)).to be false
    end
  end

  describe "#encode" do
    it "can convert unicode to gsm compatible chars" do
      unicode_characters = GSMTexting::COMPATIBILITY_TABLE.keys.pack("U*")
      expect(GSMTexting.can_encode?(unicode_characters)).to be false

      converted_characters = GSMTexting.encode(unicode_characters)
      expect(GSMTexting.can_encode?(converted_characters)).to be true
    end

    it "can convert unicode chars to similar gsm chars" do
      unicode_characters = "áéíóu"
      expect(GSMTexting.can_encode?(unicode_characters)).to be false
      converted_characters = GSMTexting.encode(unicode_characters)
      puts "converted: " + converted_characters
      expect(GSMTexting.can_encode?(converted_characters)).to be true
    end
  end
end
