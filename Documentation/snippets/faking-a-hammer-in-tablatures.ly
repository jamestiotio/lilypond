% Do not edit this file; it is automatically
% generated from Documentation/snippets/new
% This file is in the public domain.
%% Note: this file works from version 2.13.4
\version "2.13.36"

\header {
%% Translation of GIT committish: 0b55335aeca1de539bf1125b717e0c21bb6fa31b

  texidoces = "
Se puede simular un @qq{hammer} o ligado ascendente con ligaduras de
expresión.

"

  doctitlees = "Simular un hammer o ligado ascendente en una tablatura"

  lsrtags = "fretted-strings"
  texidoc = "
A hammer in tablature can be faked with slurs.
"
  doctitle = "Faking a hammer in tablatures"
} % begin verbatim


\score {
  \new TabStaff {
    \relative c'' {
      \tabFullNotation
      c4( d) d( d)
      d2( c)
    }
  }
}
