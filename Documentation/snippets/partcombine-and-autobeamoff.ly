%% Do not edit this file; it is automatically
%% generated from LSR http://lsr.dsi.unimi.it
%% This file is in the public domain.
\version "2.12.2"

\header {
  lsrtags = "rhythms"

%%   Translation of GIT committish: a874fda3641c9e02f61be5c41b215b8304b8ed00

  texidoces = "

Puede ser difícil comprender la función de @code{\\autoBeamOff} cuando
se usa con @code{\\partcombine}.

Puede ser preferible usar


@code{\\set Staff.autoBeaming = ##f}


en su lugar, para asegurarse de que el barrado automático se desactiva
para todo el pentagrama.


@code{\\partcombine} funciona aparentemente con tres voces: plica
arriba cuando hay una sola voz, plica abajo con la otra, y plica
arriba cuando está combinada.


Una llamada a @code{\\autoBeamOff} en el primer argumento de
partcombine se aplica a la voz que está activa en el momento en que se
procesa la llamada, ya sea voz única con la plica hacia arriba, hacia
abajo o combinadas.  Una llamada a @code{\\autoBeamOff} en el segundo
argumento se aplica a la voz que está sola con la plica abajo.


Para pode usar @code{\\autoBeamOff} con el objeto de detener todo el
barrado automático cuando se usa con @code{\\partcombine}, es
necesario hacer tres llamadas a @code{\\autoBeamOff}.




"
  doctitlees = "Partcombine y autoBeamOff"
%%   Translation of GIT committish: ab9e3136d78bfaf15cc6d77ed1975d252c3fe506

  texidocde = "
Die Funktionsweise von @code{@bs{}autoBeamOff}, wenn es zusammen mit
@code{@bs{}partcombine} eingesetzt wird, kann schwer zu verstehen sein.
Es kann besser sein, anstatt dessen

@example
\set Staff.autobeaming = ##f
@end example

@noindent
zu benutzen, um sicherzustellen, dass die automatische Bebalkung für das
gesamte System ausgeschaltet ist.

@code{\\partcombine} funktioniert offensichtlich mit 3 Stimme (Hals nach oben
einfach, Hals nach unten einfach, Hals nach oben kombiniert).

Ein @code{\\autoBeamOff}-Befehl im ersten Argument von @code{\\partcombine}
gilt für die Stimme, die zu dem Zeitpunkt aktiv ist, an dem der Befehl
verarbeitet wird, entweder für Hals nach oben, nach unten oder Hals nach
oben kombiniert.  Ein @code{\\autoBeamOff}-Befehl im zweiten Argument gilt
für die Stimme, die mit Hals nach unten einfach ist.

Um @code{\\autoBeamOff} zu benutzen, damit alle automatischen Balken aufhören,
wenn man es mit @code{\\partcombine} verwendet, muss @code{\\autoBeamOff}
@emph{dreimal} aufgerufen werden.

"
doctitlede = "Partcombine und autoBeamOff"

%% Translation of GIT committish: e1a149d0cc60b02e86209387958f4028567dd366
  texidocfr = "
Le fonction @code{@bs{}autoBeamOff} dans le cadre d'un
@code{@bs{}partcombine} agit de façon bien particulière@tie{}; c'est
pourquoi il vaut mieux tout d'abord recourir à

@example
\set Staff.autobeaming = ##f
@end example

@noindent
pour désactiver les ligatures automatiques pour l'ensemble de la portée
concernée.

L'instruction @code{\\partcombine} fonctionne apparament sur la base de
trois voix@tie{}: solo hampes montantes, solo hampes descendantes et
ensemble hampes montantes.

Lorsque @code{\\autoBeamOff} apparaît dans le premier argument de la
combinaison, il s'applique à la voix active à ce moment précis, qu'il
s'agisse du solo hampes montantes ou du combiné hampes montantes.
Lorsqu'elle est introduite dans le second argument, la commande
@code{\\autoBeamOff} s'appliquera au solo hampes descendantes.

Vous devrez donc, afin que @code{\\autoBeamOff} soit pleinement
opérationnel dans le cadre d'un @code{\\partcombine}, l'introduire aux
@strong{trois} niveaux.

"
doctitlefr = "Partcombine et autoBeamOff"


  texidoc = "
The function of @code{\\autoBeamOff} when used with
@code{\\partcombine} can be difficult to understand.

It may be preferable to use


@code{\\set Staff.autoBeaming = ##f}


instead, to ensure that autobeaming will be turned off for the entire
staff.


@code{\\partcombine} apparently works with 3 voices -- stem up single,
stem down single, stem up combined.


An @code{\\autoBeamOff} call in the first argument to partcombine will
apply to the voice that is active at the time the call is processed,
either stem up single or stem up combined. An @code{\\autoBeamOff} call
in the second argument will apply to the voice that is stem down single.


In order to use @code{\\autoBeamOff} to stop all autobeaming when used
with @code{\\partcombine}, it will be necessary to use three calls to
@code{\\autoBeamOff}.




"
  doctitle = "Partcombine and autoBeamOff"
} % begin verbatim

{
  %\set Staff.autoBeaming = ##f % turns off all autobeaming
  \partcombine
  {
    \autoBeamOff % applies to split up stems
    \repeat unfold 4 a'16
    %\autoBeamOff % applies to combined up stems
    \repeat unfold 4 a'8
    \repeat unfold 4 a'16
  }
  {
    \autoBeamOff % applies to down stems
    \repeat unfold 4 f'8
    \repeat unfold 8 f'16 |
  }
}
