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
  lsrtags = "chords, specific-notation"

  texidoc = "
The layout of the major 7 can be tuned with @code{majorSevenSymbol}.
"

  doctitle = "chord name major7"
} % begin verbatim


\chords {
  c:7+
  \set majorSevenSymbol = \markup { j7 }
  c:7+
}
