%% DO NOT EDIT this file manually; it is automatically
%% generated from LSR http://lsr.di.unimi.it
%% Make any changes in LSR itself, or in Documentation/snippets/new/ ,
%% and then run scripts/auxiliar/makelsr.py
%%
%% This file is in the public domain.
\version "2.23.1"

\header {
  lsrtags = "rhythms"

  texidoc = "
Beamlets can be set to point in the direction of the beat to which they
belong.  The first beam avoids sticking out flags (the default); the
second beam strictly follows the beat.

"
  doctitle = "Strict beat beaming"
} % begin verbatim

\relative c'' {
  \time 6/8
  a8. a16 a a
  \set strictBeatBeaming = ##t
  a8. a16 a a
}
