%% DO NOT EDIT this file manually; it is automatically
%% generated from Documentation/snippets/new
%% Make any changes in Documentation/snippets/new/
%% and then run scripts/auxiliar/makelsr.py
%%
%% This file is in the public domain.
%% Note: this file works from version 2.23.6
\version "2.23.6"

\header {
  lsrtags = "expressive-marks"

  texidoc = "
The shorthands are defined in @samp{ly/script-init.ly}, where the
variables @code{dashHat}, @code{dashPlus}, @code{dashDash},
@code{dashBang}, @code{dashLarger}, @code{dashDot}, and
@code{dashUnderscore} are assigned default values.  The default values
for the shorthands can be modified. For example, to associate the
@code{-+} (@code{dashPlus}) shorthand with the @emph{trill} symbol
instead of the default @emph{+} symbol, assign the value @code{\\trill}
to the variable @code{dashPlus}:

"
  doctitle = "Modifying default values for articulation shorthand notation"
} % begin verbatim


\relative c'' { c1-+ }

dashPlus = \trill

\relative c'' { c1-+ }
