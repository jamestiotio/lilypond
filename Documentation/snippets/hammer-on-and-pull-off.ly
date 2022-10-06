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
  lsrtags = "editorial-annotations, fretted-strings"

  texidoc = "
Hammer-on and pull-off can be obtained using slurs.
"

  doctitle = "Hammer on and pull off"
} % begin verbatim


\new TabStaff {
  \relative c' {
    d4( e\2)
    a( g)
  }
}
