\version "1.5.68"

\header {
texidoc="Various warnings
"
}

linebreak = \penalty #-1000

\score {
  \notes {
    c''
    \property Voice.Stem \set #'length = #"foo"
    \property Voice.Stem \set #'longth = #2
    \property Staff.clefStyle = #"foo"
    \property Staff.clefStyle = #2
 }
}
