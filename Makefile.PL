use strict;
use warnings;

use 5.010000;

use ExtUtils::MakeMaker 6.30;

my (%fribidi, $libs, $cflags);
eval { require ExtUtils::PkgConfig };
if ( $@ ) {
    warn $@;
} else {
    %fribidi = eval { ExtUtils::PkgConfig->find('fribidi') };
}
if ( %fribidi ) {
    $libs = $fribidi{'libs'};
    $cflags = $fribidi{'cflags'};
} else {
    unless ( -r '/usr/include/fribidi/fribidi.h' ) {
        warn <<'EOF';

It seems that fribidi is missing. 

fribidi should be installed prior to the installation of this module.

EOF
        exit 0;

    }
    warn "Using heuristic values for CFLAGS and LIBS\n";
    $libs = '-lfribidi';
    $cflags = '-I/usr/include/fribidi -I/usr/include/glib-2.0 -I/usr/lib/glib-2.0/include';
}

my %WriteMakefileArgs = (
                       'MIN_PERL_VERSION' => '5.010000',
                       'CONFIGURE_REQUIRES' => {
                                                 'ExtUtils::MakeMaker' => '6.30'
                                               },
                       'LICENSE' => 'perl',
                       'DISTNAME' => 'Text-Bidi',
                       'test' => {
                                   'TESTS' => 't/*.t'
                                 },
                       'NAME' => 'Text::Bidi::private',
                       'TEST_REQUIRES' => {
                                            'List::Util' => '0',
                                            'Test::More' => '0',
                                            'ExtUtils::MakeMaker' => '0',
                                            'File::Spec' => '0',
                                            'IO::Handle' => '0',
                                            'Data::Dumper' => '0',
                                            'charnames' => '0',
                                            'File::Spec::Functions' => '0',
                                            'version' => '0.77',
                                            'utf8' => '0',
                                            'File::Temp' => '0',
                                            'IPC::Open3' => '0'
                                          },
                       'AUTHOR' => 'Moshe Kamensky <kamensky@cpan.org>',
                       'BUILD_REQUIRES' => {},
                       'EXE_FILES' => [
                                        'bin/fribidi.pl'
                                      ],
                       'PREREQ_PM' => {
                                        'DynaLoader' => '0',
                                        'Tie::Array' => '0',
                                        'warnings' => '0',
                                        'base' => '0',
                                        'open' => '0',
                                        'Carp' => '0',
                                        'strict' => '0',
                                        'Exporter' => '0',
                                        'Getopt::Long' => '0',
                                        'overload' => '0',
                                        'Encode' => '0',
                                        'integer' => '0'
                                      },
                       'VERSION' => '2.09',
                       'ABSTRACT' => 'Unicode bidi algorithm using libfribidi'
                     );


%WriteMakefileArgs = (%WriteMakefileArgs,
    INC => $cflags,
    LIBS => $libs,
    OBJECT => 'private.o',
);

unless ( eval { ExtUtils::MakeMaker->VERSION(6.63_03) } ) {
  my $tr = delete $WriteMakefileArgs{TEST_REQUIRES};
  my $br = $WriteMakefileArgs{BUILD_REQUIRES};
  for my $mod ( keys %$tr ) {
    if ( exists $br->{$mod} ) {
      $br->{$mod} = $tr->{$mod} if $tr->{$mod} > $br->{$mod};
    }
    else {
      $br->{$mod} = $tr->{$mod};
    }
  }
}

unless ( eval { ExtUtils::MakeMaker->VERSION(6.56) } ) {
  my $br = delete $WriteMakefileArgs{BUILD_REQUIRES};
  my $pp = $WriteMakefileArgs{PREREQ_PM};
  for my $mod ( keys %$br ) {
    if ( exists $pp->{$mod} ) {
      $pp->{$mod} = $br->{$mod} if $br->{$mod} > $pp->{$mod};
    }
    else {
      $pp->{$mod} = $br->{$mod};
    }
  }
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);

sub MY::postamble {
    <<EOF;
private.c: swig/fribidi.i
	-/usr/bin/swig -perl -Wall -I/usr/include $cflags -outdir lib/Text/Bidi/ -o \$@ \$<

swig-clean: clean
	-rm private.c lib/Text/Bidi/private.pm

EOF
}

