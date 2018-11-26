package com.abrandoned.fast_blank_java;

import java.io.IOException;
import java.io.InputStream;
import java.lang.CharSequence;
import org.jcodings.Encoding;
import org.jcodings.specific.ASCIIEncoding;
import org.jruby.Ruby;
import org.jruby.RubyString;
import org.jruby.util.io.EncodingUtils;
import org.jruby.RubyIO;
import org.jruby.ext.stringio.StringIO;
import org.jruby.util.ByteList;
import org.jruby.anno.JRubyMethod;
import org.jruby.runtime.ThreadContext;
import org.jruby.runtime.builtin.IRubyObject;

public class FastBlankJava {
  @JRubyMethod(name = { "fast_blank_java?", "blank?" })
  public static IRubyObject fast_blank_as_java_p(ThreadContext context, IRubyObject self) {
    org.jruby.Ruby runtime = context.getRuntime();

    if (self instanceof RubyString) {
      org.jruby.RubyString rubyString = ((RubyString) self);
      if (rubyString.isEmpty()) {
        return runtime.getTrue();
      }

      ByteList blankValue = rubyString.getByteList();
      byte[] stringBytes = blankValue.unsafeBytes();
      org.jcodings.Encoding enc = rubyString.getEncoding();
      int begin = blankValue.begin();
      int size = blankValue.length();
      int begin_plus_size = begin + size;
      int next_char = begin;
      int codepoint = 0;
      int[] len_p = {0};

      while(next_char < begin_plus_size) {
        codepoint = EncodingUtils.encCodepointLength(stringBytes, next_char, begin + size, len_p, enc);

        switch(codepoint) {
          case 9:
          case 0xa:
          case 0xb:
          case 0xc:
          case 0xd:
          case 0x20:
          case 0x85:
          case 0xa0:
          case 0x1680:
          case 0x2000:
          case 0x2001:
          case 0x2002:
          case 0x2003:
          case 0x2004:
          case 0x2005:
          case 0x2006:
          case 0x2007:
          case 0x2008:
          case 0x2009:
          case 0x200a:
          case 0x2028:
          case 0x2029:
          case 0x202f:
          case 0x205f:
          case 0x3000:
            break;
          default:
            return runtime.getFalse();
        }

        next_char += len_p[0];
      }

      return runtime.getTrue();
    }

    throw context.getRuntime().newTypeError("can't #fast_blank_java? a non-string object");
  }
}
