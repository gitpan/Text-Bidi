# This file was automatically generated by SWIG (http://www.swig.org).
# Version 2.0.10
#
# Do not make changes to this file unless you know what you are doing--modify
# the SWIG interface file instead.

package Text::Bidi::private;
use base qw(Exporter);
use base qw(DynaLoader);
package Text::Bidi::privatec;
bootstrap Text::Bidi::private;
package Text::Bidi::private;
@EXPORT = qw();

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

*get_bidi_type = *Text::Bidi::privatec::get_bidi_type;
*get_bidi_types = *Text::Bidi::privatec::get_bidi_types;
*get_bidi_type_name = *Text::Bidi::privatec::get_bidi_type_name;
*get_joining_type = *Text::Bidi::privatec::get_joining_type;
*get_joining_types = *Text::Bidi::privatec::get_joining_types;
*get_joining_type_name = *Text::Bidi::privatec::get_joining_type_name;
*get_mirror_char = *Text::Bidi::privatec::get_mirror_char;
*shape_mirroring = *Text::Bidi::privatec::shape_mirroring;
*get_par_direction = *Text::Bidi::privatec::get_par_direction;
*get_par_embedding_levels = *Text::Bidi::privatec::get_par_embedding_levels;
*reorder_line = *Text::Bidi::privatec::reorder_line;
*utf8_to_internal = *Text::Bidi::privatec::utf8_to_internal;
*internal_to_utf8 = *Text::Bidi::privatec::internal_to_utf8;
*reorder_map = *Text::Bidi::privatec::reorder_map;

# ------- VARIABLE STUBS --------

package Text::Bidi::private;

*unicode_version = *Text::Bidi::privatec::unicode_version;
*FRIBIDI_BIDI_NUM_TYPES = *Text::Bidi::privatec::FRIBIDI_BIDI_NUM_TYPES;
*FRIBIDI_BIDI_MAX_EXPLICIT_LEVEL = *Text::Bidi::privatec::FRIBIDI_BIDI_MAX_EXPLICIT_LEVEL;
*FRIBIDI_BIDI_MAX_RESOLVED_LEVELS = *Text::Bidi::privatec::FRIBIDI_BIDI_MAX_RESOLVED_LEVELS;
*FRIBIDI_CHAR_LRM = *Text::Bidi::privatec::FRIBIDI_CHAR_LRM;
*FRIBIDI_CHAR_RLM = *Text::Bidi::privatec::FRIBIDI_CHAR_RLM;
*FRIBIDI_CHAR_LRE = *Text::Bidi::privatec::FRIBIDI_CHAR_LRE;
*FRIBIDI_CHAR_RLE = *Text::Bidi::privatec::FRIBIDI_CHAR_RLE;
*FRIBIDI_CHAR_PDF = *Text::Bidi::privatec::FRIBIDI_CHAR_PDF;
*FRIBIDI_CHAR_LRO = *Text::Bidi::privatec::FRIBIDI_CHAR_LRO;
*FRIBIDI_CHAR_RLO = *Text::Bidi::privatec::FRIBIDI_CHAR_RLO;
*FRIBIDI_CHAR_LS = *Text::Bidi::privatec::FRIBIDI_CHAR_LS;
*FRIBIDI_CHAR_PS = *Text::Bidi::privatec::FRIBIDI_CHAR_PS;
*FRIBIDI_CHAR_ZWNJ = *Text::Bidi::privatec::FRIBIDI_CHAR_ZWNJ;
*FRIBIDI_CHAR_ZWJ = *Text::Bidi::privatec::FRIBIDI_CHAR_ZWJ;
*FRIBIDI_CHAR_HEBREW_ALEF = *Text::Bidi::privatec::FRIBIDI_CHAR_HEBREW_ALEF;
*FRIBIDI_CHAR_ARABIC_ALEF = *Text::Bidi::privatec::FRIBIDI_CHAR_ARABIC_ALEF;
*FRIBIDI_CHAR_ARABIC_ZERO = *Text::Bidi::privatec::FRIBIDI_CHAR_ARABIC_ZERO;
*FRIBIDI_CHAR_PERSIAN_ZERO = *Text::Bidi::privatec::FRIBIDI_CHAR_PERSIAN_ZERO;
*FRIBIDI_CHAR_ZWNBSP = *Text::Bidi::privatec::FRIBIDI_CHAR_ZWNBSP;
*FRIBIDI_CHAR_FILL = *Text::Bidi::privatec::FRIBIDI_CHAR_FILL;
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
*FRIBIDI_MASK_PRIVATE = *Text::Bidi::privatec::FRIBIDI_MASK_PRIVATE;
*FRIBIDI_TYPE_LTR_VAL = *Text::Bidi::privatec::FRIBIDI_TYPE_LTR_VAL;
*FRIBIDI_TYPE_RTL_VAL = *Text::Bidi::privatec::FRIBIDI_TYPE_RTL_VAL;
*FRIBIDI_TYPE_AL_VAL = *Text::Bidi::privatec::FRIBIDI_TYPE_AL_VAL;
*FRIBIDI_TYPE_LRE_VAL = *Text::Bidi::privatec::FRIBIDI_TYPE_LRE_VAL;
*FRIBIDI_TYPE_RLE_VAL = *Text::Bidi::privatec::FRIBIDI_TYPE_RLE_VAL;
*FRIBIDI_TYPE_LRO_VAL = *Text::Bidi::privatec::FRIBIDI_TYPE_LRO_VAL;
*FRIBIDI_TYPE_RLO_VAL = *Text::Bidi::privatec::FRIBIDI_TYPE_RLO_VAL;
*FRIBIDI_TYPE_PDF_VAL = *Text::Bidi::privatec::FRIBIDI_TYPE_PDF_VAL;
*FRIBIDI_TYPE_EN_VAL = *Text::Bidi::privatec::FRIBIDI_TYPE_EN_VAL;
*FRIBIDI_TYPE_AN_VAL = *Text::Bidi::privatec::FRIBIDI_TYPE_AN_VAL;
*FRIBIDI_TYPE_ES_VAL = *Text::Bidi::privatec::FRIBIDI_TYPE_ES_VAL;
*FRIBIDI_TYPE_ET_VAL = *Text::Bidi::privatec::FRIBIDI_TYPE_ET_VAL;
*FRIBIDI_TYPE_CS_VAL = *Text::Bidi::privatec::FRIBIDI_TYPE_CS_VAL;
*FRIBIDI_TYPE_NSM_VAL = *Text::Bidi::privatec::FRIBIDI_TYPE_NSM_VAL;
*FRIBIDI_TYPE_BN_VAL = *Text::Bidi::privatec::FRIBIDI_TYPE_BN_VAL;
*FRIBIDI_TYPE_BS_VAL = *Text::Bidi::privatec::FRIBIDI_TYPE_BS_VAL;
*FRIBIDI_TYPE_SS_VAL = *Text::Bidi::privatec::FRIBIDI_TYPE_SS_VAL;
*FRIBIDI_TYPE_WS_VAL = *Text::Bidi::privatec::FRIBIDI_TYPE_WS_VAL;
*FRIBIDI_TYPE_ON_VAL = *Text::Bidi::privatec::FRIBIDI_TYPE_ON_VAL;
*FRIBIDI_TYPE_WLTR_VAL = *Text::Bidi::privatec::FRIBIDI_TYPE_WLTR_VAL;
*FRIBIDI_TYPE_WRTL_VAL = *Text::Bidi::privatec::FRIBIDI_TYPE_WRTL_VAL;
*FRIBIDI_TYPE_SENTINEL = *Text::Bidi::privatec::FRIBIDI_TYPE_SENTINEL;
*FRIBIDI_TYPE_PRIVATE = *Text::Bidi::privatec::FRIBIDI_TYPE_PRIVATE;
*FRIBIDI_TYPE_LTR = *Text::Bidi::privatec::FRIBIDI_TYPE_LTR;
*FRIBIDI_TYPE_RTL = *Text::Bidi::privatec::FRIBIDI_TYPE_RTL;
*FRIBIDI_TYPE_AL = *Text::Bidi::privatec::FRIBIDI_TYPE_AL;
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
*FRIBIDI_TYPE_LRE = *Text::Bidi::privatec::FRIBIDI_TYPE_LRE;
*FRIBIDI_TYPE_RLE = *Text::Bidi::privatec::FRIBIDI_TYPE_RLE;
*FRIBIDI_TYPE_LRO = *Text::Bidi::privatec::FRIBIDI_TYPE_LRO;
*FRIBIDI_TYPE_RLO = *Text::Bidi::privatec::FRIBIDI_TYPE_RLO;
*FRIBIDI_TYPE_PDF = *Text::Bidi::privatec::FRIBIDI_TYPE_PDF;
*FRIBIDI_PAR_LTR = *Text::Bidi::privatec::FRIBIDI_PAR_LTR;
*FRIBIDI_PAR_RTL = *Text::Bidi::privatec::FRIBIDI_PAR_RTL;
*FRIBIDI_PAR_ON = *Text::Bidi::privatec::FRIBIDI_PAR_ON;
*FRIBIDI_PAR_WLTR = *Text::Bidi::privatec::FRIBIDI_PAR_WLTR;
*FRIBIDI_PAR_WRTL = *Text::Bidi::privatec::FRIBIDI_PAR_WRTL;
*FRIBIDI_TYPE_WLTR = *Text::Bidi::privatec::FRIBIDI_TYPE_WLTR;
*FRIBIDI_TYPE_WRTL = *Text::Bidi::privatec::FRIBIDI_TYPE_WRTL;
*FRIBIDI_FLAG_SHAPE_MIRRORING = *Text::Bidi::privatec::FRIBIDI_FLAG_SHAPE_MIRRORING;
*FRIBIDI_FLAG_REORDER_NSM = *Text::Bidi::privatec::FRIBIDI_FLAG_REORDER_NSM;
*FRIBIDI_FLAG_SHAPE_ARAB_PRES = *Text::Bidi::privatec::FRIBIDI_FLAG_SHAPE_ARAB_PRES;
*FRIBIDI_FLAG_SHAPE_ARAB_LIGA = *Text::Bidi::privatec::FRIBIDI_FLAG_SHAPE_ARAB_LIGA;
*FRIBIDI_FLAG_SHAPE_ARAB_CONSOLE = *Text::Bidi::privatec::FRIBIDI_FLAG_SHAPE_ARAB_CONSOLE;
*FRIBIDI_FLAG_REMOVE_BIDI = *Text::Bidi::privatec::FRIBIDI_FLAG_REMOVE_BIDI;
*FRIBIDI_FLAG_REMOVE_JOINING = *Text::Bidi::privatec::FRIBIDI_FLAG_REMOVE_JOINING;
*FRIBIDI_FLAG_REMOVE_SPECIALS = *Text::Bidi::privatec::FRIBIDI_FLAG_REMOVE_SPECIALS;
*FRIBIDI_FLAGS_DEFAULT = *Text::Bidi::privatec::FRIBIDI_FLAGS_DEFAULT;
*FRIBIDI_FLAGS_ARABIC = *Text::Bidi::privatec::FRIBIDI_FLAGS_ARABIC;
*FRIBIDI_MASK_JOINS_RIGHT = *Text::Bidi::privatec::FRIBIDI_MASK_JOINS_RIGHT;
*FRIBIDI_MASK_JOINS_LEFT = *Text::Bidi::privatec::FRIBIDI_MASK_JOINS_LEFT;
*FRIBIDI_MASK_ARAB_SHAPES = *Text::Bidi::privatec::FRIBIDI_MASK_ARAB_SHAPES;
*FRIBIDI_MASK_TRANSPARENT = *Text::Bidi::privatec::FRIBIDI_MASK_TRANSPARENT;
*FRIBIDI_MASK_IGNORED = *Text::Bidi::privatec::FRIBIDI_MASK_IGNORED;
*FRIBIDI_MASK_LIGATURED = *Text::Bidi::privatec::FRIBIDI_MASK_LIGATURED;
*FRIBIDI_JOINING_TYPE_U_VAL = *Text::Bidi::privatec::FRIBIDI_JOINING_TYPE_U_VAL;
*FRIBIDI_JOINING_TYPE_R_VAL = *Text::Bidi::privatec::FRIBIDI_JOINING_TYPE_R_VAL;
*FRIBIDI_JOINING_TYPE_D_VAL = *Text::Bidi::privatec::FRIBIDI_JOINING_TYPE_D_VAL;
*FRIBIDI_JOINING_TYPE_C_VAL = *Text::Bidi::privatec::FRIBIDI_JOINING_TYPE_C_VAL;
*FRIBIDI_JOINING_TYPE_L_VAL = *Text::Bidi::privatec::FRIBIDI_JOINING_TYPE_L_VAL;
*FRIBIDI_JOINING_TYPE_T_VAL = *Text::Bidi::privatec::FRIBIDI_JOINING_TYPE_T_VAL;
*FRIBIDI_JOINING_TYPE_G_VAL = *Text::Bidi::privatec::FRIBIDI_JOINING_TYPE_G_VAL;
*_FRIBIDI_JOINING_TYPE_JUNK = *Text::Bidi::privatec::_FRIBIDI_JOINING_TYPE_JUNK;
1;