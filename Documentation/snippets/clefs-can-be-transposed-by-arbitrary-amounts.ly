%% DO NOT EDIT this file manually; it is automatically
%% generated from LSR http://lsr.di.unimi.it
%% Make any changes in LSR itself, or in Documentation/snippets/new/ ,
%% and then run scripts/auxiliar/makelsr.py
%%
%% This file is in the public domain.
\version "2.23.1"

\header {
  lsrtags = "pitches"

  texidoc = "
Clefs can be transposed by arbitrary amounts, not just by octaves.

"
  doctitle = "Clefs can be transposed by arbitrary amounts"
} % begin verbatim

\relative c' {
  \clef treble
  c4 c c c
  \clef "treble_8"
  c4 c c c
  \clef "treble_5"
  c4 c c c
  \clef "treble^3"
  c4 c c c
}
