%module "Text::Bidi::private"
/*
 * Swig interface file for libfribidi
 * ==================================
 *
 * This interface file was designed for building a perl module, but should be 
 * easily adaptable to other languages.
 *
 * The general form of some functions in libfribidi is that an input string 
 * is supplied together with its length, as well as some pointer for the 
 * outputs of the function, which are arrays of the same length. Thus, the 
 * same parameter specifies the length of several arrays. We deal with it in 
 * the following way (adapted from list-vector.i in the guile part of the 
 * swig distribution):
 * The length is an "ignore" argument (numinputs=0), whose translation thus 
 * appears near the beginning. We allocate a (function-) global variable to 
 * hold the value in its typemap. The input string is then dealt with using a 
 * usual "in" typemap, which assigns values both to the string and to the 
 * global variable representing the length. Finally, the output string are 
 * allocated in a check typemap, which guarantees that the length is already 
 * initialised.
 *
 * Some of the outputs are optional, depending on wether we are in array or 
 * scalar context. To adapt it for other languages, it should only be 
 * necessary to modify the WANTARRAY macro.
 */

%include "typemaps.i"

%apply unsigned long *INPUT { FriBidiCharType *pbase_dirs }
%apply unsigned long *OUTPUT { FriBidiChar *mirrored_ch }

%define WANTARRAY
(GIMME_V == G_ARRAY)
%enddef

%typemap(default,noblock=1) FriBidiCharType* pbase_dirs
(FriBidiCharType temp, short _global_wantarray) {
  temp = FRIBIDI_TYPE_ON;
  $1 = &temp;
  _global_wantarray = WANTARRAY;
}

%typemap(argout) FriBidiCharType *pbase_dirs %{
  if (_global_wantarray) {
    mXPUSHu(*($1));
    argvi++;
  }
%}

%typemap(out) fribidi_boolean ""
%typemap(out) FriBidiStrIndex ""
%typemap(out) int ""

/* apparently, prefixing _global to temp variable name makes it global (no 
 * name mangling)
 */
%typemap(in,numinputs=0) FriBidiStrIndex len (FriBidiStrIndex* _global_p_len) %{
  $1 = 0;
  _global_p_len = &$1;
%}

%typemap(in,noblock=1) FriBidiChar* str (char* buf = 0, size_t size = 0) {
  buf = SvPV($input, size);
  *_global_p_len = %numeric_cast(size/sizeof($*1_ltype), FriBidiStrIndex);
  $1 = %static_cast(buf, $1_ltype);
}

/* the following three typemaps take care of a string arg, whose length is 
 * stored in *_global_p_len
 */
%typemap(in,numinputs=0) FriBidiChar* visual_str ($1_ltype* temp) %{
  temp = &$1;
%}

%typemap(check,noblock=1) FriBidiChar* visual_str {
  Newx(*temp$argnum, ((*_global_p_len) + 1), $*1_ltype);
}

%typemap(argout) FriBidiChar* visual_str %{
  mXPUSHp((const char *)($1), 
          (STRLEN)( (*_global_p_len) * sizeof($*1_ltype)));
  argvi++;
%}

%typemap(freearg) FriBidiChar* visual_str %{
  if ($1) Safefree($1);
%}

/* same,but where the output argument is optional, depending on the context 
 * (scalar/array). The arguments of the macro are the type to which the 
 * variable points, the name of the variable, and the expression to use when 
 * checking if we are in array context.
 */

%define OPTOUTARR(Type, NEWOPT, Check)
  %typemap(in,numinputs=0) Type* NEWOPT ($1_ltype* temp) %{
    temp = &$1;
  %}

  %typemap(check,noblock=1) Type* NEWOPT {
    if ( Check ) {
      Newx(*temp$argnum, ((*_global_p_len) + 1), $*1_ltype);
    }
  }

  %typemap(argout) Type* NEWOPT %{
    if ( Check ) {
      AV* tempav = newAV();
      int i;
      for(i=0 ; i < (*_global_p_len) ; i++)
        av_push(tempav, newSVuv($1[i]));
      XPUSHs(sv_2mortal(newRV_noinc((SV *) tempav)));
      argvi++;
    }
  %}

  %typemap(freearg) Type* NEWOPT %{
    if ($1) Safefree($1);
  %}
%enddef
    
OPTOUTARR(FriBidiStrIndex, NEWOPT, _global_wantarray);
OPTOUTARR(FriBidiLevel, embedding_level_list, _global_wantarray);
OPTOUTARR(FriBidiLevel, emb_levels, 1);
OPTOUTARR(FriBidiCharType, type, 1);

%apply FriBidiStrIndex* NEWOPT { FriBidiStrIndex* position_L_to_V_list,
                                 FriBidiStrIndex* position_V_to_L_list }

%inline %{
#include <fribidi/fribidi.h>
FRIBIDI_API void log2vis ( /* input */
                           FriBidiChar *str,
                           FriBidiStrIndex len,
                           /* output */
                           FriBidiChar *visual_str,
                           FriBidiCharType *pbase_dirs,
                           FriBidiStrIndex *position_L_to_V_list,
                           FriBidiStrIndex *position_V_to_L_list,
                           FriBidiLevel *embedding_level_list) {
    fribidi_log2vis(str, len, pbase_dirs, visual_str, position_L_to_V_list, 
                    position_V_to_L_list, embedding_level_list);
}

%}

%import "fribidi/fribidi_config.h"
%import "fribidi/fribidi_char_sets.h"
%include "fribidi/fribidi_unicode.h"
%include "fribidi/fribidi_types.h"

FRIBIDI_API fribidi_boolean
fribidi_log2vis_get_embedding_levels (	/* input */
                                        FriBidiChar *str,
                                        FriBidiStrIndex len,
                                        FriBidiCharType *pbase_dirs,
                                        /* output */
                                        FriBidiLevel *emb_levels);

%apply FriBidiChar* str { FriBidiChar *inout }
%typemap(argout) FriBidiChar* inout %{
  mXPUSHp((const char *)($1), 
          (STRLEN)( (result) * sizeof($*1_ltype)));
  argvi++;
%}

%typemap(in,numinputs=0) FriBidiLevel *embedding_level_in ""
%typemap(in,numinputs=0) FriBidiStrIndex *position_to_this_list ""
%typemap(default) FriBidiStrIndex *position_from_this_list ""
%typemap(in,noblock=1) FriBidiStrIndex *position_from_this_list {
  if (SvOK($input)) {
    AV* buf;
    size_t size;
    size_t i;
    buf = (AV*)(SvRV($input));
    size = av_len(buf) + 1;
    Newx($1, size, $*1_ltype);
    for(i=0;i < size; i++) {
      SV** sv = av_fetch(buf, i, 0);
      if ( sv )
        $1[i] = %numeric_cast(SvUV(*sv), $*1_ltype);
      else
        $1[i] = -1;
    }
  }
}

%typemap(argout) FriBidiStrIndex *position_from_this_list %{
  if ( $1 ) {
    AV* tempav = newAV();
    int i;
    for(i=0 ; i < result ; i++)
      av_push(tempav, newSVuv($1[i]));
    XPUSHs(sv_2mortal(newRV_noinc((SV *) tempav)));
    argvi++;
  }
%}

%typemap(freearg) FriBidiStrIndex *position_from_this_list %{
  if ($1) Safefree($1);
%}

FRIBIDI_API FriBidiStrIndex
fribidi_remove_bidi_marks(FriBidiChar *inout,
                          FriBidiStrIndex len,
                          FriBidiStrIndex *position_to_this_list,
                          FriBidiStrIndex *position_from_this_list,
                          FriBidiLevel *embedding_level_in);

FRIBIDI_API FriBidiCharType fribidi_get_type (FriBidiChar uch);

FRIBIDI_API void fribidi_get_types (   /* input */
				       FriBidiChar *str,
				       FriBidiStrIndex len,
				       /* output */
				       FriBidiCharType *type);

FRIBIDI_API fribidi_boolean fribidi_get_mirror_char (	/* Input */
                                                FriBidiChar ch,
                                                /* Output */
                                                FriBidiChar *mirrored_ch);

FRIBIDI_API void fribidi_set_mirroring (fribidi_boolean mirror);
FRIBIDI_API void fribidi_set_reorder_nsm (fribidi_boolean);

/* from fribidi_char_sets_cap_rtl.h */
%apply FriBidiChar* str { char* s }
%apply FriBidiChar* visual_str { char *out, FriBidiChar* out }

/* the size of the output string may grow because of control seqs. */
%typemap(check,noblock=1) char* out {
  Newx(*temp$argnum, 2*((*_global_p_len) + 1), $*1_ltype);
}

%typemap(argout) char* out, FriBidiChar* out %{
  mXPUSHp((char *)($1), 
          (STRLEN)( (result) * sizeof($*1_ltype)));
  argvi++;
%}

fribidi_boolean fribidi_char_set_enter_cap_rtl (void);

int fribidi_cap_rtl_to_unicode (char *s, FriBidiStrIndex len,
                          /* Output */
                          FriBidiChar *out);
int fribidi_unicode_to_cap_rtl (FriBidiChar *str, FriBidiStrIndex len,
                          /* Output */
                          char *out);


/* vim: fo-=t comments-=:% cindent sw=2: */

