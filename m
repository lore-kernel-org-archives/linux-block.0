Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: Jeff Moyer <jmoyer@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>, y2038@lists.linaro.org, Hannes Reinecke <hare@suse.com>, Mike Christie <mchristi@redhat.com>, Shaohua Li <shli@fb.com>, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] blktrace: avoid using timespec
Date: Sat, 18 Jun 2016 21:02:08 +0200
Message-ID: <3744206.k1Hv7RyTzG@wuerfel>
In-Reply-To: <x494m8r5vnb.fsf@segfault.boston.devel.redhat.com>
References: <20160617145849.3771756-1-arnd@arndb.de> <57646E09.9080408@kernel.dk> <x494m8r5vnb.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-block@vger.kernel.org>

On Friday, June 17, 2016 5:54:16 PM CEST Jeff Moyer wrote:
> Jens Axboe <axboe@kernel.dk> writes:
> 
> > On 06/17/2016 05:36 PM, Steven Rostedt wrote:
> >>
> >> Jens,
> >>
> >> You want to take this, or do you want me to?
> >
> > I'll add it to my 4.8 tree, thanks Arnd.
> 
> +       /* need to check user space to see if this breaks in y2038 or y2106 */
> 
> Userspace just uses it to print the timestamp, right?  So do we need the
> comment?

If we have more details, the comment should describe what happens and
when it overflows. If you have the source at hand, maybe you can answer
these:

How does it print the timestamp? Does it print the raw seconds value
using %u (correct) or %d (incorrect), or does it convert it into
year/month/day/hour/min/sec?

In the last case, how does it treat second values above 0x80000000? Are
those printed as  year 2038 or year 1902?

Are we sure that there is only one user space implementation that reads
these values?

	Arnd
