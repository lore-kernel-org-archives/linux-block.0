Return-Path: <peterz@infradead.org>
Date: Mon, 24 Jul 2017 18:19:40 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: bo.li.liu@oracle.com, Jens Axboe <axboe@kernel.dk>,
	Ming Lei <tom.leiming@gmail.com>, David Sterba <dsterba@suse.com>,
	linux-block <linux-block@vger.kernel.org>, fdmanana@suse.com,
	Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] block: note about cloned bios and
 bio_for_each_segment_all
Message-ID: <20170724161940.llwty5vdyqq6sokw@hirez.programming.kicks-ass.net>
References: <20170714134051.22756-1-dsterba@suse.com>
 <CACVXFVP_a5kofmW-Wfx1FT_kyqFKdatf57RfKLrh+Jte1J8ZmA@mail.gmail.com>
 <06376146-e4c3-efd6-8893-155052b14034@kernel.dk>
 <20170714205429.GC10708@lim.localdomain>
 <7e460ce6-7f91-53b6-dad1-d22965b6c8af@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <7e460ce6-7f91-53b6-dad1-d22965b6c8af@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Tue, Jul 18, 2017 at 03:19:00PM -0700, Bart Van Assche wrote:
> Hello Peter,

Sorry for being late, I'm trying to recover from a few weeks of leave
and the inbox is in shambles.

> In a test I ran myself with kernel v4.12-rc1 I also noticed that a
> WARN_ON_ONCE() statement triggered an oops in report_bug() and killed the
> kernel thread of the caller instead of letting the caller continue. What I
> ran into is probably the same oops as in the above call trace. For the test
> I ran myself the disassembly is as follows:
> 
> (gdb) list *(report_bug+0x94)
> 0xffffffff812ba024 is in report_bug (lib/bug.c:177).
> 172                                     return BUG_TRAP_TYPE_WARN;
> 173
> 174                             /*
> 175                              * Since this is the only store, concurrency is not an issue.
> 176                              */
> 177                             bug->flags |= BUGFLAG_DONE;
> 178                     }
> 179             }
> 180
> 181             if (warning) {
> 
> Could this be related to patch "debug: Add _ONCE() logic to report_bug()"?
> Is this a known issue? If so, is a fix perhaps already available?

Yep..  please see:

  https://marc.info/?l=linux-kernel&m=150055119925677
