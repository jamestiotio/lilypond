/*
  localkeyreg.cc -- implement Local_key_register

  (c) 1997 Han-Wen Nienhuys <hanwen@stack.nl>
*/

#include "localkeyreg.hh"
#include "localkeyitem.hh"
#include "complexwalker.hh"

Local_key_register::Local_key_register(Complex_walker*w)
    : Request_register(w)
{
    key_item_p_ = 0;    
}
bool
Local_key_register::try_request(Request*)

{
    return false;
}

void
Local_key_register::process_request()
{
}
void
Local_key_register::do_pre_move_process()
{
    if (key_item_p_) {
	walk_l_->typeset_element(key_item_p_);
	key_item_p_ = 0;
    }
}
void
Local_key_register::acknowledge_element(Staff_elem_info info)
{    
    if (info.req_l_->melodic()) {
	Melodic_req * melodic_l_ = info.req_l_->melodic();

	if( melodic_l_->forceacc ||
	    walk_l_->local_key_.oct(melodic_l_->octave).acc(melodic_l_->notename)
	    != melodic_l_->accidental) {
	    Item * support_l_ = info.elem_p_->item();
	

	    if (!key_item_p_) {
		key_item_p_ = new Local_key_item(walk_l_->clef_.c0_position_i_);
		key_item_p_->c0_position = walk_l_->clef_.c0_position_i_;
	    }
	    
	    key_item_p_->add(melodic_l_);
	    key_item_p_->add(support_l_);
	    walk_l_->local_key_.oct(melodic_l_->octave)
		.set(melodic_l_->notename, melodic_l_->accidental);
	}
    }
}
