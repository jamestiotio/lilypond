/*
  thread-devnull-engraver.cc -- implement Thread_devnull_engraver

  source file of the GNU LilyPond music typesetter
  
  (c) 2000--2003 Jan Nieuwenhuizen <janneke@gnu.org>
*/

#include "engraver.hh"
#include "item.hh"
#include "event.hh"
#include "translator-group.hh"

class Thread_devnull_engraver : public Engraver
{
public:
  TRANSLATOR_DECLARATIONS(Thread_devnull_engraver);
  
protected:
  virtual void acknowledge_grob (Grob_info);
};



void
Thread_devnull_engraver::acknowledge_grob (Grob_info i)
{
  SCM s = get_property ("devNullThread");

  if (s == ly_symbol2scm ("always")
      || (s == SCM_EOL
	  && to_boolean (get_property ("soloADue"))
	  && ((daddy_trans_->id_string_.left_string (3) == "two"
	       && (to_boolean (get_property ("unison"))
		   || to_boolean (get_property ("unisilence"))))

	      /* Maybe this should be optional? */
	      || to_boolean (get_property ("othersolo")))))
    {
      i.grob_->suicide ();
    }
}
Thread_devnull_engraver::Thread_devnull_engraver(){}

ENTER_DESCRIPTION(Thread_devnull_engraver,
/* descr */       "Kill elements whenever we are Voice called `two' and either "
"unison, unisilence or soloADue is set.@footnote{On unix systems, the "
"file @file{/dev/null} is special device: anything written to it is "
"discarded.}. This engraver works closely together with the part "
"combiner.  When the part combiner notices that two threads are "
"identical, it tells the @code{Thread_devnull_engraver} to discard " 
"everything in the second thread. "
,
/* creats*/       "",
/* accepts */     "",
/* acks  */      "grob-interface",
/* reads */       "",
/* write */       "");
