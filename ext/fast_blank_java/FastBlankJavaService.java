package com.abrandoned.fast_blank_java;

import org.jruby.Ruby;
import org.jruby.RubyModule;
import org.jruby.runtime.load.BasicLibraryService;
import com.abrandoned.fast_blank_java.*;

import java.io.IOException;

public class FastBlankJavaService implements BasicLibraryService {
    @Override
    public boolean basicLoad(final Ruby runtime) throws IOException {
        RubyModule fast_blank_java = runtime.getModule("FastBlankJava");
        fast_blank_java.defineAnnotatedMethods(FastBlankJava.class);

        return true;
    }
}
