require "java"
require "jruby"
require "fast_blank_java/version"

module FastBlankJava
  # Your code goes here...
end

require "jars/fast_blank_java.jar"
com.abrandoned.fast_blank_java.FastBlankJavaService.new.basicLoad(::JRuby.runtime)
