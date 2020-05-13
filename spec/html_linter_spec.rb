require_relative '../lib/html_linter'
require 'nokogiri'

describe MyLint do
  mylint = MyLint.new
  let(:document) { Nokogiri::HTML.parse(open('index.html')) }

  describe '#doctype' do
    it 'returns true if doctype is declared' do
      value = document.search('doctype')
      expect(!value.empty?).to eq(true)
    end

    it 'returns an error if doctype is not present' do
      value = document.search('doctype')
      expect(!value.empty?).not_to eq(false)
    end
  end

  describe '#meta_tag' do
    it 'returns true if there is a meta tag' do
      value = document.search('meta[@name]')
      expect(!value.empty?).to eq(true)
    end

    it 'returns false if meta tag is not found' do
      value = document.search('meta[@name]')
      expect(!value.empty?).not_to eq(false)
    end

    context 'when the meta tag is empty' do
      it 'returns true if all meta description is not empty' do
        expect(document.xpath('//meta[@name]/@content').all? { |attr| !attr.value.empty? }).to eq(true)
      end

      it 'returns false if all meta description is empty' do
        expect(document.xpath('//meta[@name]/@content').all? { |attr| attr.value.empty? }).to eq(false)
      end
    end
  end

  describe '#head_tag' do
    it 'returns true if head tag is found' do
      value = document.search('head')
      expect(!value.empty?).to eq(true)
    end

    it 'returns false if head tag is not found' do
      value = document.search('head')
      expect(!value.empty?).not_to eq(false)
    end
  end

  describe '#body_tag' do
    it 'returns true if body tag is found' do
      value = document.search('body')
      expect(!value.empty?).to eq(true)
    end

    it 'returns false if head tag is not found' do
      value = document.search('body')
      expect(!value.empty?).not_to eq(false)
    end
  end

  describe '#unordered_list' do
    it 'returns true if ul tag is found' do
      value = document.search('ul')
      expect(!value.empty?).to eq(true)
    end

    it 'returns false if ul tag is not found' do
      value = document.search('ul')
      expect(!value.empty?).not_to eq(false)
    end
  end

  describe '#lang_length' do
    it 'returns an error if lang attribute is not defined ' do
      value = document.search('html[@lang]')
      expect(value.empty?).to eq(true)
    end
  end

    it 'returns an error if lang length is too long' do
      value  = document.search('html[@lang]').all? do |attr|
      attr.values.size >= 5
      expect(value).to eq(true)
      end
     end

     it 'returns true if lang length is too long' do
       value  = document.xpath('html[@lang]').all? do |attr|
       value = attr.values.size >= 5
       expect(value).not_to eq(false)
       end
      end

    describe '#inline_style' do
    it 'returns true if there is no style tag ' do
      value = document.search('style')
      expect(value.empty?).to eq(true)
    end

    it 'returns an error if style tag is found' do
      value = document.search('style')
      expect(!value.empty?).to eq(false)
    end
  end

end
