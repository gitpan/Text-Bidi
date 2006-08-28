# This file was created automatically by SWIG 1.3.29.
# Don't modify this file, modify the SWIG interface instead.
package Text::Bidi::private;
require Exporter;
require DynaLoader;
@ISA = qw(Exporter DynaLoader);
package Text::Bidi::privatec;
bootstrap Text::Bidi::private;
package Text::Bidi::private;
@EXPORT = qw( );

# ---------- BASE METHODS -------------

package Text::Bidi::private;

sub TIEHASH {
    my ($classname,$obj) = @_;
    return bless $obj, $classname;
}

sub CLEAR { }

sub FIRSTKEY { }

sub NEXTKEY { }

sub FETCH {
    my ($self,$field) = @_;
    my $member_func = "swig_${field}_get";
    $self->$member_func();
}

sub STORE {
    my ($self,$field,$newval) = @_;
    my $member_func = "swig_${field}_set";
    $self->$member_func($newval);
}

sub this {
    my $ptr = shift;
    return tied(%$ptr);
}


# ------- FUNCTION WRAPPERS --------

package Text::Bidi::private;

*log2vis = *Text::Bidi::privatec::log2vis;
*fribidi_wcwidth = *Text::Bidi::privatec::fribidi_wcwidth;
*fribidi_wcswidth = *Text::Bidi::privatec::fribidi_wcswidth;
*fribidi_wcswidth_cjk = *Text::Bidi::privatec::fribidi_wcswidth_cjk;
*fribidi_type_name = *Text::Bidi::privatec::fribidi_type_name;
*fribidi_log2vis_get_embedding_levels = *Text::Bidi::privatec::fribidi_log2vis_get_embedding_levels;
*fribidi_remove_bidi_marks = *Text::Bidi::privatec::fribidi_remove_bidi_marks;
*fribidi_get_type = *Text::Bidi::privatec::fribidi_get_type;
*fribidi_get_types = *Text::Bidi::privatec::fribidi_get_types;
*fribidi_get_mirror_char = *Text::Bidi::privatec::fribidi_get_mirror_char;
*fribidi_set_mirroring = *Text::Bidi::privatec::fribidi_set_mirroring;
*fribidi_set_reorder_nsm = *Text::Bidi::privatec::fribidi_set_reorder_nsm;
*fribidi_char_set_enter_cap_rtl = *Text::Bidi::privatec::fribidi_char_set_enter_cap_rtl;
*fribidi_cap_rtl_to_unicode = *Text::Bidi::privatec::fribidi_cap_rtl_to_unicode;
*fribidi_unicode_to_cap_rtl = *Text::Bidi::privatec::fribidi_unicode_to_cap_rtl;

############# Class : Text::Bidi::private::FriBidiRunType ##############

package Text::Bidi::private::FriBidiRunType;
use vars qw(@ISA %OWNER %ITERATORS %BLESSEDMEMBERS);
@ISA = qw( Text::Bidi::private );
%OWNER = ();
%ITERATORS = ();
*swig_length_get = *Text::Bidi::privatec::FriBidiRunType_length_get;
*swig_length_set = *Text::Bidi::privatec::FriBidiRunType_length_set;
*swig_attribute_get = *Text::Bidi::privatec::FriBidiRunType_attribute_get;
*swig_attribute_set = *Text::Bidi::privatec::FriBidiRunType_attribute_set;
sub new {
    my $pkg = shift;
    my $self = Text::Bidi::privatec::new_FriBidiRunType(@_);
    bless $self, $pkg if defined($self);
}

sub DESTROY {
    return unless $_[0]->isa('HASH');
    my $self = tied(%{$_[0]});
    return unless defined $self;
    delete $ITERATORS{$self};
    if (exists $OWNER{$self}) {
        Text::Bidi::privatec::delete_FriBidiRunType($self);
        delete $OWNER{$self};
    }
}

sub DISOWN {
    my $self = shift;
    my $ptr = tied(%$self);
    delete $OWNER{$ptr};
}

sub ACQUIRE {
    my $self = shift;
    my $ptr = tied(%$self);
    $OWNER{$ptr} = 1;
}


############# Class : Text::Bidi::private::_FriBidiList ##############

package Text::Bidi::private::_FriBidiList;
use vars qw(@ISA %OWNER %ITERATORS %BLESSEDMEMBERS);
@ISA = qw( Text::Bidi::private );
%OWNER = ();
%ITERATORS = ();
*swig_data_get = *Text::Bidi::privatec::_FriBidiList_data_get;
*swig_data_set = *Text::Bidi::privatec::_FriBidiList_data_set;
*swig_next_get = *Text::Bidi::privatec::_FriBidiList_next_get;
*swig_next_set = *Text::Bidi::privatec::_FriBidiList_next_set;
*swig_prev_get = *Text::Bidi::privatec::_FriBidiList_prev_get;
*swig_prev_set = *Text::Bidi::privatec::_FriBidiList_prev_set;
sub new {
    my $pkg = shift;
    my $self = Text::Bidi::privatec::new__FriBidiList(@_);
    bless $self, $pkg if defined($self);
}

sub DESTROY {
    return unless $_[0]->isa('HASH');
    my $self = tied(%{$_[0]});
    return unless defined $self;
    delete $ITERATORS{$self};
    if (exists $OWNER{$self}) {
        Text::Bidi::privatec::delete__FriBidiList($self);
        delete $OWNER{$self};
    }
}

sub DISOWN {
    my $self = shift;
    my $ptr = tied(%$self);
    delete $OWNER{$ptr};
}

sub ACQUIRE {
    my $self = shift;
    my $ptr = tied(%$self);
    $OWNER{$ptr} = 1;
}


# ------- VARIABLE STUBS --------

package Text::Bidi::private;

*FRIBIDI_UNICODE_VERSION = *Text::Bidi::privatec::FRIBIDI_UNICODE_VERSION;
*UNI_MAX_BIDI_LEVEL = *Text::Bidi::privatec::UNI_MAX_BIDI_LEVEL;
*UNI_LRM = *Text::Bidi::privatec::UNI_LRM;
*UNI_RLM = *Text::Bidi::privatec::UNI_RLM;
*UNI_LRE = *Text::Bidi::privatec::UNI_LRE;
*UNI_RLE = *Text::Bidi::privatec::UNI_RLE;
*UNI_PDF = *Text::Bidi::privatec::UNI_PDF;
*UNI_LRO = *Text::Bidi::privatec::UNI_LRO;
*UNI_RLO = *Text::Bidi::privatec::UNI_RLO;
*UNI_LS = *Text::Bidi::privatec::UNI_LS;
*UNI_PS = *Text::Bidi::privatec::UNI_PS;
*UNI_ZWNJ = *Text::Bidi::privatec::UNI_ZWNJ;
*UNI_ZWJ = *Text::Bidi::privatec::UNI_ZWJ;
*UNI_HEBREW_ALEF = *Text::Bidi::privatec::UNI_HEBREW_ALEF;
*UNI_ARABIC_ALEF = *Text::Bidi::privatec::UNI_ARABIC_ALEF;
*UNI_ARABIC_ZERO = *Text::Bidi::privatec::UNI_ARABIC_ZERO;
*UNI_FARSI_ZERO = *Text::Bidi::privatec::UNI_FARSI_ZERO;
*FRIBIDI_MASK_RTL = *Text::Bidi::privatec::FRIBIDI_MASK_RTL;
*FRIBIDI_MASK_ARABIC = *Text::Bidi::privatec::FRIBIDI_MASK_ARABIC;
*FRIBIDI_MASK_STRONG = *Text::Bidi::privatec::FRIBIDI_MASK_STRONG;
*FRIBIDI_MASK_WEAK = *Text::Bidi::privatec::FRIBIDI_MASK_WEAK;
*FRIBIDI_MASK_NEUTRAL = *Text::Bidi::privatec::FRIBIDI_MASK_NEUTRAL;
*FRIBIDI_MASK_SENTINEL = *Text::Bidi::privatec::FRIBIDI_MASK_SENTINEL;
*FRIBIDI_MASK_LETTER = *Text::Bidi::privatec::FRIBIDI_MASK_LETTER;
*FRIBIDI_MASK_NUMBER = *Text::Bidi::privatec::FRIBIDI_MASK_NUMBER;
*FRIBIDI_MASK_NUMSEPTER = *Text::Bidi::privatec::FRIBIDI_MASK_NUMSEPTER;
*FRIBIDI_MASK_SPACE = *Text::Bidi::privatec::FRIBIDI_MASK_SPACE;
*FRIBIDI_MASK_EXPLICIT = *Text::Bidi::privatec::FRIBIDI_MASK_EXPLICIT;
*FRIBIDI_MASK_SEPARATOR = *Text::Bidi::privatec::FRIBIDI_MASK_SEPARATOR;
*FRIBIDI_MASK_OVERRIDE = *Text::Bidi::privatec::FRIBIDI_MASK_OVERRIDE;
*FRIBIDI_MASK_ES = *Text::Bidi::privatec::FRIBIDI_MASK_ES;
*FRIBIDI_MASK_ET = *Text::Bidi::privatec::FRIBIDI_MASK_ET;
*FRIBIDI_MASK_CS = *Text::Bidi::privatec::FRIBIDI_MASK_CS;
*FRIBIDI_MASK_NSM = *Text::Bidi::privatec::FRIBIDI_MASK_NSM;
*FRIBIDI_MASK_BN = *Text::Bidi::privatec::FRIBIDI_MASK_BN;
*FRIBIDI_MASK_BS = *Text::Bidi::privatec::FRIBIDI_MASK_BS;
*FRIBIDI_MASK_SS = *Text::Bidi::privatec::FRIBIDI_MASK_SS;
*FRIBIDI_MASK_WS = *Text::Bidi::privatec::FRIBIDI_MASK_WS;
*FRIBIDI_TYPE_LTR = *Text::Bidi::privatec::FRIBIDI_TYPE_LTR;
*FRIBIDI_TYPE_RTL = *Text::Bidi::privatec::FRIBIDI_TYPE_RTL;
*FRIBIDI_TYPE_AL = *Text::Bidi::privatec::FRIBIDI_TYPE_AL;
*FRIBIDI_TYPE_LRE = *Text::Bidi::privatec::FRIBIDI_TYPE_LRE;
*FRIBIDI_TYPE_RLE = *Text::Bidi::privatec::FRIBIDI_TYPE_RLE;
*FRIBIDI_TYPE_LRO = *Text::Bidi::privatec::FRIBIDI_TYPE_LRO;
*FRIBIDI_TYPE_RLO = *Text::Bidi::privatec::FRIBIDI_TYPE_RLO;
*FRIBIDI_TYPE_PDF = *Text::Bidi::privatec::FRIBIDI_TYPE_PDF;
*FRIBIDI_TYPE_EN = *Text::Bidi::privatec::FRIBIDI_TYPE_EN;
*FRIBIDI_TYPE_AN = *Text::Bidi::privatec::FRIBIDI_TYPE_AN;
*FRIBIDI_TYPE_ES = *Text::Bidi::privatec::FRIBIDI_TYPE_ES;
*FRIBIDI_TYPE_ET = *Text::Bidi::privatec::FRIBIDI_TYPE_ET;
*FRIBIDI_TYPE_CS = *Text::Bidi::privatec::FRIBIDI_TYPE_CS;
*FRIBIDI_TYPE_NSM = *Text::Bidi::privatec::FRIBIDI_TYPE_NSM;
*FRIBIDI_TYPE_BN = *Text::Bidi::privatec::FRIBIDI_TYPE_BN;
*FRIBIDI_TYPE_BS = *Text::Bidi::privatec::FRIBIDI_TYPE_BS;
*FRIBIDI_TYPE_SS = *Text::Bidi::privatec::FRIBIDI_TYPE_SS;
*FRIBIDI_TYPE_WS = *Text::Bidi::privatec::FRIBIDI_TYPE_WS;
*FRIBIDI_TYPE_ON = *Text::Bidi::privatec::FRIBIDI_TYPE_ON;
*FRIBIDI_TYPE_L = *Text::Bidi::privatec::FRIBIDI_TYPE_L;
*FRIBIDI_TYPE_R = *Text::Bidi::privatec::FRIBIDI_TYPE_R;
*FRIBIDI_TYPE_N = *Text::Bidi::privatec::FRIBIDI_TYPE_N;
*FRIBIDI_TYPE_WL = *Text::Bidi::privatec::FRIBIDI_TYPE_WL;
*FRIBIDI_TYPE_WR = *Text::Bidi::privatec::FRIBIDI_TYPE_WR;
*FRIBIDI_TYPE_SOT = *Text::Bidi::privatec::FRIBIDI_TYPE_SOT;
*FRIBIDI_TYPE_EOT = *Text::Bidi::privatec::FRIBIDI_TYPE_EOT;
*FRIBIDI_TYPES_COUNT = *Text::Bidi::privatec::FRIBIDI_TYPES_COUNT;
*fribidi_prop_to_type = *Text::Bidi::privatec::fribidi_prop_to_type;
1;
