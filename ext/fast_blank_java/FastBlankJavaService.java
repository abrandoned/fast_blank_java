package com.abrandoned.fast_blank_java;

import org.jruby.Ruby;
import org.jruby.RubyModule;
import org.jruby.runtime.load.BasicLibraryService;
import com.abrandoned.fast_blank_java.*;

import java.io.IOException;

public class FastBlankJavaService implements BasicLibraryService {
    @Override
    public boolean basicLoad(final Ruby runtime) throws IOException {
        RubyModule protobuf_java_helpers = runtime.getModule("FastBlankJava");

        RubyModule varinter = protobuf_java_helpers.defineModuleUnder(FastBlankJava.class.getSimpleName());
        varinter.defineAnnotatedMethods(FastBlankJava.class);

        return true;
    }
}
