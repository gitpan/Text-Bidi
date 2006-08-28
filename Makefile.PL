use ExtUtils::MakeMaker;
WriteMakefile(
    NAME => 'Text::Bidi::private',
    VERSION_FROM => 'lib/Text/Bidi.pm',
    ABSTRACT_FROM => 'lib/Text/Bidi.pm',
    DISTNAME => 'Text-Bidi',
    LIBS => '-lfribidi',
    OBJECT => 'private.o',
);

sub MY::postamble {
    <<'EOF';
private.c: swig/fribidi.i
	-/usr/bin/swig -perl -Wall -I/usr/include -outdir lib/Text/Bidi/ -o $@ $<

swig-clean: clean
	-rm private.c lib/Text/Bidi/private.pm

EOF
}
