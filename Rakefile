require "bundler/gem_tasks"
require "rake/testtask"
require "rake/javaextensiontask"

::Rake::JavaExtensionTask.new("fast_blank_java") do |ext|
 jruby_home = ENV["MY_RUBY_HOME"] # this is available of rvm
 jars = ["#{jruby_home}/lib/jruby.jar"] + FileList["lib/*.jar"]
 ext.classpath = jars.map { |x| File.expand_path x }.join ":"
 ext.ext_dir = "ext/"
 ext.lib_dir = "lib/jars"
 ext.name = "fast_blank_java"
 ext.source_version = "1.8"
 ext.target_version = "1.8"
end
