%% DO NOT EDIT this file manually; it is automatically
%% generated from LSR http://lsr.di.unimi.it
%% Make any changes in LSR itself, or in Documentation/snippets/new/ ,
%% and then run scripts/auxiliar/makelsr.py
%%
%% This file is in the public domain.
\version "2.23.1"

\header {
  lsrtags = "simultaneous-notes, staff-notation"

  texidoc = "
The @code{\\partCombine} function takes two music expressions each
containing a part, and distributes them among four @code{Voice}s named
@qq{two} @qq{one} @qq{solo} and @qq{chords} depending on when and how the
parts merged into a common voice.   The voices output from
@code{\\partCombine} can have their layout properties adjusted in the
usual way.  Here we define extensions of @code{\\partCombine} to make
it easier to put four voices on a staff.

@verbatim
soprano = { d'4 | cis'  b  e'  d'8 cis' | cis'2 b }
alto = { fis4 | e8 fis gis ais b4 b | b ais fis2 }
tenor = { a8 b | cis' dis' e'4 b8 cis' d'4 | gis cis' dis'2 }
bass = { fis8 gis | a4 gis g fis | eis fis b,2 }

\\new Staff <<
  \\key b\\minor
  \\clef alto
  \\partial 4
  \\transpose b b'
  \\partCombineUp \\soprano \\alto
  \\partCombineDown \\tenor \\bass
>>
@end verbatim

"
  doctitle = "Two \\partCombine pairs on one staff"
} % begin verbatim

\layout {
  \context {
    \Staff
    \accepts "VoiceBox"
  }
  \context {
    \name "VoiceBox"
    \type "Engraver_group"
    \defaultchild "Voice"
    \accepts "Voice"
    \accepts "NullVoice"
  }
}

customPartCombineUp =
#(define-music-function (partOne partTwo)
  (ly:music? ly:music?)
"Take the music in @var{partOne} and @var{partTwo} and return
a @code{VoiceBox} named @q{Up} containing @code{Voice}s
that contain @var{partOne} and @var{partTwo} merged into one
voice where feasible.  This variant sets the default voicing
in the output to use upward stems."
#{
  \new VoiceBox = "Up" <<
    \context Voice = "one" { \voiceOne }
    \context Voice = "two" { \voiceThree }
    \context Voice = "shared" { \voiceOne }
    \context Voice = "solo" { \voiceOne }
    \context NullVoice = "null" {}
    \partCombine #partOne #partTwo
  >>
#})

customPartCombineDown = #
(define-music-function (partOne partTwo)
  (ly:music? ly:music?)
"Take the music in @var{partOne} and @var{partTwo} and return
a @code{VoiceBox} named @q{Down} containing @code{Voice}s
that contain @var{partOne} and @var{partTwo} merged into one
voice where feasible.  This variant sets the default voicing
in the output to use downward stems."
#{
  \new VoiceBox = "Down" <<
    \set VoiceBox.soloText = #"Solo III"
    \set VoiceBox.soloIIText = #"Solo IV"
    \context Voice ="one" { \voiceFour }
    \context Voice ="two" { \voiceTwo }
    \context Voice ="shared" { \voiceFour }
    \context Voice ="solo" { \voiceFour }
    \context NullVoice = "null" {}
    \partCombine #partOne #partTwo
  >>
#})

soprano = { d'4 | cis'  b  e'  d'8 cis' | cis'2 b }
alto = { fis4 | e8 fis gis ais b4 b | b ais fis2 }
tenor = { a8 b | cis' dis' e'4 b8 cis' d'4 | gis cis' dis'2 }
bass = { fis8 gis | a4 gis g fis | eis fis b,2 }

\new Staff <<
  \key b\minor
  \clef alto
  \partial 4
  \transpose b b'
  \customPartCombineUp \soprano \alto
  \customPartCombineDown \tenor \bass
>>
