require 'nokogiri'
require 'colorize'

class MyLint
  attr_reader :document
  def initialize
    @document = Nokogiri::HTML.parse(open('index.html'))
  end

  def validate
    doctype
    meta_tag
    head_tag
    body_tag
    unordered_list
    lang_length
    inline_style
  end

  private

  def doctype
    value = document.search('/doctype')
    if value.empty?
      puts '[TEST FAILED] : '.red + 'doctype not declared'
    else
      puts '[TEST PASSED] : '.green + 'doctype declared'
    end
  end

  def meta_tag
    meta = document.search('//meta[@name]')
    if meta.empty?
      puts '[TEST FAILED] : '.red + 'meta description tag not found'
    else
      document.xpath('//meta[@name]/@content').all? do |attr|
        if attr.value.empty?
          puts '[TEST FAILED] : '.red + 'meta description tag not found'
        else
          puts '[TEST PASSED] : '.green + 'meta description tag found'
        end
      end
    end
  end

  def unordered_list
    value = document.search('ul')
    if value.empty? || value.text.empty?
      puts '[TEST FAILED] : '.red + ' ul tag is missing'
    else
      puts '[TEST PASSED] : '.green + 'ul tag found'
    end
  end

  def head_tag
    value = document.search('head')
    if value.empty? || value.text.empty?
      puts '[TEST FAILED] : '.red + ' head tag is missing'
    else
      puts '[TEST PASSED] : '.green + 'head tag found'
    end
  end

  def body_tag
    value = document.search('//body')
     # puts value
    if value.text.empty?
      puts '[TEST FAILED] : '.red + ' body contents are missing'
    else
      puts '[TEST PASSED] : '.green + 'body contents found'
    end
    end

  def lang_length
    lang = document.search('//html[@lang]')
    if lang.empty?
      puts '[TEST FAILED] : '.red + 'lang not defined'
    else
      document.xpath('//html[@lang]').all? do |attr|
        if attr.elements.size >= 5
          puts '[TEST FAILED] : '.red + 'lang length too long'
        else
          puts '[TEST PASSED] : '.green + 'lang length is not too long'
        end
      end
    end
  end

  def inline_style
    value = document.search('style')
    if value.empty? || value.text.empty?
      puts '[TEST PASSED] : '.green + 'Inline styling not detected'
    else
      puts '[TEST FAILED] : '.red + 'Move inline style to css file'
    end
  end
end
