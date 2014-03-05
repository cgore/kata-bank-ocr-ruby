# -*- coding: utf-8 -*-

# Copyright © 2014, Christopher Mark Gore,
# Soli Deo Gloria,
# All rights reserved.
#
# 2317 South River Road, Saint Charles, Missouri 63303 USA.
# Web: http://cgore.com
# Email: cgore@cgore.com
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#
#   * Redistributions of source code must retain the above copyright
#     notice, this list of conditions and the following disclaimer.
#
#   * Redistributions in binary form must reproduce the above copyright
#     notice, this list of conditions and the following disclaimer in the
#     documentation and/or other materials provided with the distribution.
#
#   * Neither the name of Christopher Mark Gore nor the names of other
#     contributors may be used to endorse or promote products derived from
#     this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
# ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
# LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
# SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
# INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
# CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
# ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
# POSSIBILITY OF SUCH DAMAGE.

module KataBankOcr
  class OcrFileFormatError < ArgumentError
  end

  class OcrFile
    attr_reader :path
    attr_reader :file_lines

    def initialize(path)
      @path = path
      raise ArgumentError if not path.kind_of? String
      raise ArgumentError, "File #{path} DNE" if not File.exists? path
      @file_lines = File.new(path).readlines

      ## XXX: This test fails on the examples: some are 27, some are 28.
      # @file_lines.each do |line|
      #   raise OcrFileFormatError, "Line length #{line.length} on line #{line}" if not line.length == 27+1
      # end

      
    end
  end

  class Line
    attr_reader :strings

    def initialize(*strings)
      @strings = strings
      raise ArgumentError if not @strings.kind_of? Array
      raise ArgumentError if @strings.length != 3
      @strings.each do |string|
        raise ArgumentError if not string.kind_of? String
        raise ArgumentError if not string.length == 27
      end
      
    end
  end

  class Digit
    attr_reader :strings

    def initialize(*strings)
      @strings = strings
    end

    def == other
      self.strings == other.strings
    end

    def is_digit? n
      raise ArgumentError if not n.kind_of? Integer
      raise ArgumentError if not (0..9).include? n
      self == DIGITS[n]
    end

    def to_digit
      (0..9).each do |n|
        return n if is_digit? n
      end
      raise RuntimeError, "Not a valid digit"
    end
  end

  ZERO = Digit.new(
    " _ ",
    "| |",
    "|_|")
  ONE = Digit.new(
    "   ",
    "  |",
    "  |")
  TWO = Digit.new(
    " _ ",
    " _|",
    "|_ ")
  THREE = Digit.new(
    " _ ",
    " _|",
    " _|")
  FOUR = Digit.new(
    "   ",
    "|_|",
    "  |")
  FIVE = Digit.new(
    " _ ",
    "|_ ",
    " _|")
  SIX = Digit.new(
    " _ ",
    "|_ ",
    "|_|")
  SEVEN = Digit.new(
    " _ ",
    "  |",
    "  |")
  EIGHT = Digit.new(
    " _ ",
    "|_|",
    "|_|")
  NINE = Digit.new(
    " _ ",
    "|_|",
    "  |")
  DIGITS = [ZERO,ONE,TWO,THREE,FOUR,FIVE,SIX,SEVEN,EIGHT,NINE]
end
