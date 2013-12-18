# 
# file: js_escape_convert.rb
# desc: 转换js的escape函数生成的数据
# author: jerry
# modify: 2013-12-18

# str = "%u6BCF%u4E00%u4E2A%u7A0B%u5E8F%u5458%u4E0A%u8F88%u5B50%u90FD%u662F%u6298%u7FFC%u7684%u5929%u4F7F"
# puts JsEscapeConvert.utf8RawUrlDecode(str)
# 每一个程序员上辈子都是折翼的天使

require 'cgi'
require 'iconv'
module JsEscapeConvert
  # 抓换js escape 后的字符串
  def self.utf8RawUrlDecode(source)
    decodedStr = ''
    pos = 0
    len = source.size
    while pos < len do
      charAt = source[pos, 1]
      if charAt == '%'
        pos += 1
        charAt = source[pos, 1]
        if charAt == 'u'
          pos += 1
          unicodeHexVal = source[pos, 4]
          unicodeHexVal.insert(0,'%')
          unicodeHexVal.insert(3,'%')
          entity = CGI.unescape(unicodeHexVal)
          decodedStr += Iconv.conv("utf-8","unicodebig",entity)
          pos += 4
        else
          hexVal = source[pos, 2]
          # solve ArgumentError: invalid byte sequence in UTF-8
          decodedStr += hexVal.hex.chr.force_encoding("ISO-8859-1").encode("utf-8", replace: nil)
          pos += 2
        end
      else
        decodedStr += charAt
        pos += 1
      end
    end
    decodedStr
  end
end
