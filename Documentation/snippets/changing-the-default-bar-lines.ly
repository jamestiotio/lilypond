%% DO NOT EDIT this file manually; it is automatically
%% generated from LSR http://lsr.di.unimi.it
%% Make any changes in LSR itself, or in Documentation/snippets/new/ ,
%% and then run scripts/auxiliar/makelsr.py
%%
%% This file is in the public domain.
\version "2.23.1"

\header {
  lsrtags = "repeats, staff-notation"

  texidoc = "
Default bar lines can be changed when re-defined in a score context.

"
  doctitle = "Changing the default bar lines"
} % begin verbatim

% http://lsr.di.unimi.it/LSR/Item?id=964
%%=> http://lists.gnu.org/archive/html/lilypond-user/2014-03/msg00126.html
%%=> http://lilypond.1069038.n5.nabble.com/Changing-the-default-end-repeat-bracket-tc169357.html

\layout {
  \context {
    \Score
    %% Changing the defaults from engraver-init.ly
    defaultBarType = #"!"
    startRepeatType = #"[|:"
    endRepeatType = #":|]"
    doubleRepeatType = #":|][|:"
  }
}

%% example:
{
  c'1
  \repeat volta 2 { \repeat unfold 2 c' }
  \repeat volta 2 { \repeat unfold 2 c' }
  \alternative {
    { c' }
    {
      %% v2.18 workaround
      \once\override Score.VoltaBracket.shorten-pair = #'(1 . -1)
      c'
    }
  }
  \bar "|."
}
