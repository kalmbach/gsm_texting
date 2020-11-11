# frozen_string_literal: true

require File.expand_path([File.dirname(__FILE__), '/../lib/gsm_texting'].join)

RSpec.describe GSMTexting do
  let(:long_message) do
    'Lorem Ipsum is simply dummy text of the printing and typesetting industry.'\
    "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s,"\
    'when an unknown printer took a galley of type and scrambled it to make a type'\
    'specimen book'
  end

  let(:truncated_message) do
    'Lorem Ipsum is simply dummy text of the printing and typesetting industry.'\
      "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s,"\
      'when an...'
  end

  describe 'can_encode?' do
    it 'returns true if text can be encoded' do
      expect(GSMTexting.can_encode?('hola')).to be true
    end

    it 'returns false if text cannot be encoded' do
      expect(GSMTexting.can_encode?('ɴ⇼')).to be false
    end
  end

  describe 'encode' do
    it 'can perform smart substitutions' do
      expect(GSMTexting.encode('ɴo')).to eq 'No'
    end

    it 'will replace not compatible chars with default char' do
      expect(GSMTexting.encode('Sí')).to eq 'S?'
    end

    it 'will replace not compatible chars with provided char' do
      expect(GSMTexting.encode('Sí', replace_char: '*')).to eq 'S*'
    end

    it 'can perform transliterations' do
      expect(GSMTexting.encode('Sí', transliterate: true)).to eq 'Si'
    end

    it 'can truncate large messages into a single segment' do
      expect(GSMTexting.encode(long_message, truncate: true)).to eq truncated_message
    end
  end

  describe 'single_segment?' do
    it 'returns true if message fits into a single sms segment' do
      expect(GSMTexting.single_segment?('Hola')).to be true
    end

    it 'returns false if message doesnt fit into a single sms segment' do
      expect(GSMTexting.single_segment?(long_message)).to eq false
    end

    it 'raises an error if  message cannot be encoded' do
      expect { GSMTexting.single_segment?('ɴ⇼') }.to raise_error GSMTexting::InvalidGSMString
    end
  end
end
