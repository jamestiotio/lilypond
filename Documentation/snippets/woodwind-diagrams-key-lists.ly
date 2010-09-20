% Do not edit this file; it is automatically
% generated from Documentation/snippets/new
% This file is in the public domain.
%% Note: this file works from version 2.13.24
\version "2.13.36"

\header {
%%%    Translation of GIT committish: ab9e3136d78bfaf15cc6d77ed1975d252c3fe506

  texidocde="
Dieses Schnipsel erzeugt eine Liste aller möglichen Löcher und Locheinstellungen
für Holzbläserdiagramme, wie sie in der Datei
@file{scm/define-woodwind-diagrams.scm} definiert sind.  Die Liste wird auf
der Kommandozeile und in der Log-Datei angezeigt, nicht in den Noten.
"
  doctitlede = "Liste der Löcher für Holzbläserdiagramme"


  lsrtags = "winds"

  texidoc="
The snippet below produces a list of all possible keys and key
settings for woodwind diagrams as defined in
@file{scm/define-woodwind-diagrams.scm}.  The list will be displayed
on the console and in the log file, but not in the music.
"
  doctitle = "Woodwind diagrams key lists"
} % begin verbatim


#(print-keys-verbose 'piccolo)
#(print-keys-verbose 'flute)
#(print-keys-verbose 'flute-b-extension)
#(print-keys-verbose 'oboe)
#(print-keys-verbose 'clarinet)
#(print-keys-verbose 'bass-clarinet)
#(print-keys-verbose 'low-bass-clarinet)
#(print-keys-verbose 'saxophone)
#(print-keys-verbose 'baritone-saxophone)
#(print-keys-verbose 'bassoon)
#(print-keys-verbose 'contrabassoon)
