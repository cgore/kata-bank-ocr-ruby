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

require 'spec_helper'

require 'kata-bank-ocr'
include KataBankOcr

describe OcrFile do
  it "can be instantiated" do
    OcrFile.new(example_path(1, "123456789.ocr")).should be_a OcrFile
  end

  describe :file_lines do
    it "contains the file lines" do
      @ocr_file = OcrFile.new example_path 1, "123456789.ocr"
      @ocr_file.file_lines.should be_an Array
      @ocr_file.file_lines.each do |line|
        line.should be_a String
      end
    end
  end
end

describe Line do
  before :all do
    @line = Line.new(
      "    _  _     _  _  _  _  _  ",
      "  | _| _||_||_ |_   ||_||_| ",
      "  ||_  _|  | _||_|  ||_| _| ")
  end

  it "can be instantiated" do
    @line.should be_a Line
  end

  describe :digits do
    it "splits out the individual digits" do
      @line.digits.should be_a Array
      @line.digits.length.should == 9
      @line.digits[0].should == ONE
      @line.digits[1].should == TWO
      @line.digits[2].should == THREE
      @line.digits[3].should == FOUR
      @line.digits[4].should == FIVE
      @line.digits[5].should == SIX
      @line.digits[6].should == SEVEN
      @line.digits[7].should == EIGHT
      @line.digits[8].should == NINE
    end
  end

  describe :to_i do
    it "works" do
      @line.to_i.should == 123456789
    end
  end
end

describe Digit do
  it "can be instantiated" do
    Digit.new("123","456","789").should be_a Digit
  end

  describe :== do
    it "works" do
      ZERO.should == Digit.new(
        " _ ",
        "| |",
        "|_|")
    end
  end

  describe :is_digit? do
    it "returns true for the correct n" do
      ZERO.should be_is_digit 0
      ONE.should be_is_digit 1
      TWO.should be_is_digit 2
      THREE.should be_is_digit 3
      FOUR.should be_is_digit 4
      FIVE.should be_is_digit 5
      SIX.should be_is_digit 6
      SEVEN.should be_is_digit 7
      EIGHT.should be_is_digit 8
      NINE.should be_is_digit 9
    end
  end

  describe :to_digit do
    it "returns the correct digit" do
      ZERO.to_digit.should == 0
      ONE.to_digit.should == 1
      TWO.to_digit.should == 2
      THREE.to_digit.should == 3
      FOUR.to_digit.should == 4
      FIVE.to_digit.should == 5
      SIX.to_digit.should == 6
      SEVEN.to_digit.should == 7
      EIGHT.to_digit.should == 8
      NINE.to_digit.should == 9
    end
  end
end
