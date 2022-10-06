%% DO NOT EDIT this file manually; it was automatically
%% generated from the LilyPond Snippet Repository
%% (http://lsr.di.unimi.it).
%%
%% Make any changes in the LSR itself, or in
%% `Documentation/snippets/new/`, then run
%% `scripts/auxiliar/makelsr.pl`.
%%
%% This file is in the public domain.

\version "2.23.13"

\header {
  lsrtags = "rhythms, version-specific"

  texidoc = "
To typeset beams grouped @code{3-4-3-2} in 12/8 it is necessary first
to override the default beam endings in 12/8, and then to set up the
new beaming endings:
"

  doctitle = "Reverting default beam endings"
} % begin verbatim


\relative c'' {
  \time 12/8

  % Default beaming
  a8 a a a a a a a a a a a

  % Set new values for beam endings
  \set Score.beatStructure = 3,4,3,2
  a8 a a a a a a a a a a a
}
