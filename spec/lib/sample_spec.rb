# -*- encoding: utf-8 -*-
require 'spec_helper'

describe Version do
  it "Versionが#family_numberと#update_numberメソッドを実行できる" do
    Version.new("").should respond_to("family_number", "update_number")
  end

  describe ".valid?" do
    it "JDK7u40を渡したらTrueを返す" do
      Version.valid?("JDK7u40").should be_true
    end

    it "正規のバージョン以外の文字を渡したらFalseを返す" do
      Version.valid?("hoge").should be_false
      Version.valid?("fuga").should be_false
    end

    it "JDK7u9xを渡したらFalseを返す" do
      Version.valid?("JDK7u9x").should be_false
    end

  end

  describe ".parse" do
    it "family_numberとupdate_numberメソッドを実行できるオブジェクトを返す" do
      Version.parse("JDK7u40").should respond_to("family_number", "update_number")
    end

    it "JDK7u4xを渡したら例外を返すこと" do
      proc { Version.parse("JDK7u4x")}.should raise_error
    end
  end

  describe "#family_number" do
    it "ファミリーナンバーを返すこと" do
      Version.new("JDK7u40").family_number.should == 7
      Version.new("JDK8u40").family_number.should == 8
    end
  end

  describe "#update_number" do
    it "アップデートナンバーを返すこと" do
      Version.new("JDK7u40").update_number.should == 40
      Version.new("JDK7u35").update_number.should == 35
    end
  end

  describe "#lt" do
    it "自分より小さいバージョンを渡したときはtrueを返すこと" do
      u40 = Version.new("JDK7u40")
      u51 = Version.new("JDK7u51")
      u40.lt(u51).should be_true
    end

    it "自分より小さいバージョンを渡したときはtrueを返すこと" do
      f7 = Version.new("JDK7u40")
      f8 = Version.new("JDK8u00")
      f7.lt(f8).should be_true
    end
  end
 
  describe "#lern" do
    it "JDK(数字)を渡したらその数字を返す" do
      def test(var)
        return $1.to_i if /JDK(\d*)/ =~ var
        return nil
      end
      test("JDK7").should == 7
    end
  end
end
