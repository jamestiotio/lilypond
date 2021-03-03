/*
  This file is part of LilyPond, the GNU music typesetter.

  Copyright (C) 2020--2021 Daniel Eble <dan@faithful.be>

  LilyPond is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  LilyPond is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with LilyPond.  If not, see <http://www.gnu.org/licenses/>.
*/

#include "music-wrapper-iterator.hh"

#include "context.hh"
#include "input.hh"
#include "lily-imports.hh"
#include "music.hh"

class Volta_specced_music_iterator final : public Music_wrapper_iterator
{
public:
  DECLARE_SCHEME_CALLBACK (constructor, ());
  Volta_specced_music_iterator () = default;

protected:
  Music *create_event (Direction d);
  void process (Moment) override;

private:
  Context_handle event_handler_;
  bool started_ = false;
  bool stopped_ = false;
};

Music *
Volta_specced_music_iterator::create_event (Direction d)
{
  SCM ev_scm = Lily::make_span_event (ly_symbol2scm ("VoltaSpanEvent"),
                                      to_scm (d));
  auto *ev = unsmob<Music> (ev_scm);

  auto *mus = get_music ();
  ev->set_spot (*mus->origin ());
  set_property (ev, "volta-numbers", get_property (mus, "volta-numbers"));
  // TODO: tweaks? (see Tuplet_iterator)
  // TODO: length? (see Tuplet_iterator)
  return ev;
}

void
Volta_specced_music_iterator::process (Moment m)
{
  // TODO: Test empty music and grace notes (probably won't work as-is).
  if (!started_)
    {
      started_ = true;
      event_handler_.set_context (get_context ());
      report_event (create_event (START));
    }

  Music_wrapper_iterator::process (m);

  if (started_ && !stopped_ && (m == music_get_length ()))
    {
      stopped_ = true;
      if (auto *c = event_handler_.get_context ())
        {
          create_event (STOP)->send_to_context (c);
        }
    }
}

IMPLEMENT_CTOR_CALLBACK (Volta_specced_music_iterator);
