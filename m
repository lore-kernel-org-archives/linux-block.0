Return-Path: <linux-block-owner@vger.kernel.org>
Received: from linuxhacker.ru ([217.76.32.60]:58152 "EHLO fiona.linuxhacker.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752256AbdAYSav (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Jan 2017 13:30:51 -0500
Subject: Re: [Lsf-pc] [LSF/MM TOPIC] block level event logging for storage media management
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=windows-1252
From: Oleg Drokin <green@linuxhacker.ru>
In-Reply-To: <20170125095613.GA18739@quack2.suse.cz>
Date: Wed, 25 Jan 2017 13:30:25 -0500
Cc: Dan Williams <dan.j.williams@intel.com>,
        linux-block@vger.kernel.org, Song Liu <songliubraving@fb.com>,
        Andreas Dilger <andreas.dilger@intel.com>,
        "Verma, Vishal L" <vishal.l.verma@intel.com>,
        Jens Axboe <axboe@fb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kernel Team <Kernel-team@fb.com>,
        lsf-pc@lists.linux-foundation.org
Message-Id: <4B2CEE25-A213-4385-9410-8C969950F3BC@linuxhacker.ru>
References: <6040124E-4928-4FC8-8A52-35115D9CA1DF@fb.com> <CAA9_cmd_XMbw_26ePCSWLxP9PoTn36n8sO5buE2iTCoPnK+CHg@mail.gmail.com> <92E1CE17-4F28-4934-BB60-358FA334AA5F@fb.com> <CAPcyv4hrcS13ijDU2+Mp59EKCqkWLMv7uj=BhKKewiz02YZiPA@mail.gmail.com> <41FACF7F-7B70-47FC-92FB-B64C545BE434@linuxhacker.ru> <20170125095613.GA18739@quack2.suse.cz>
To: Jan Kara <jack@suse.cz>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


On Jan 25, 2017, at 4:56 AM, Jan Kara wrote:

> On Tue 24-01-17 15:18:57, Oleg Drokin wrote:
>> 
>> On Jan 23, 2017, at 2:27 AM, Dan Williams wrote:
>> 
>>> [ adding Oleg ]
>>> 
>>> On Sun, Jan 22, 2017 at 10:00 PM, Song Liu <songliubraving@fb.com> wrote:
>>>> Hi Dan,
>>>> 
>>>> I think the the block level event log is more like log only system. When en event
>>>> happens,  it is not necessary to take immediate action. (I guess this is different
>>>> to bad block list?).
>>>> 
>>>> I would hope the event log to track more information. Some of these individual
>>>> event may not be very interesting, for example, soft error or latency outliers.
>>>> However, when we gather event log for a fleet of devices, these "soft event"
>>>> may become valuable for health monitoring.
>>> 
>>> I'd be interested in this. It sounds like you're trying to fill a gap
>>> between tracing and console log messages which I believe others have
>>> encountered as well.
>> 
>> We have a somewhat similar problem problem in Lustre and I guess it's not
>> just Lustre.  Currently there are all sorts of conditional debug code all
>> over the place that goes to the console and when you enable it for
>> anything verbose, you quickly overflow your dmesg buffer no matter the
>> size, that might be mostly ok for local "block level" stuff, but once you
>> become distributed, it start to be a mess and once you get to be super
>> large it worsens even more since you need to somehow coordinate data from
>> multiple nodes, ensure all of it is not lost and still you don't end up
>> using a lot of it since only a few nodes end up being useful.  (I don't
>> know how NFS people manage to debug complicated issues using just this,
>> could not be super easy).
>> 
>> Having some sort of a buffer of a (potentially very) large size that
>> could be storing the data until it's needed, or eagerly polled by some
>> daemon for storage (helpful when you expect a lot of data that definitely
>> won't fit in RAM).
>> 
>> Tracepoints have the buffer and the daemon, but creating new messages is
>> very cumbersome, so converting every debug message into one does not look
>> very feasible.  Also it's convenient to have "event masks" one want
>> logged that I don't think you could do with tracepoints.
> 
> So creating trace points IMO isn't that cumbersome. I agree that converting
> hundreds or thousands debug printks into tracepoints is a pain in the
> ass but still it is doable. WRT filtering, you can enable each tracepoint
> individually. Granted that is not exactly the 'event mask' feature you ask
> about but that can be easily scripted in userspace if you give some
> structure to tracepoint names. Finally tracepoints provide a fine grained
> control you never get with printk - e.g. you can make a tracepoint trigger
> only if specific inode is involved with trace filters which greatly reduces
> the amount of output.

Oh, I am not dissing tracepoints, don't get me wrong, they add valuable things
at a fine-grained level when you have necessary details.
The problem is sometimes there are bugs where you don't have enough of knowledge
beforehand so you cannot do some fine-grained debug.
Think of a 10.000 nodes cluster (heck make it even 100 or probably even 10)
with a report of "when running a moderately sized job, there's a hang/something weird/
some unexpected data corruption" that does not occur when run on a single node,
so often what you resort to is the shotgun approach where you enable all debug (or
selective like "Everything in ldlm and everything rpc related) you
could everywhere, then run the job for however long it takes to reproduce and then
once reproduced, you sift through those locks reconstructing picture back together
only to discover there was this weird race on one of the clients only when
some lock was contended but then the grant RPC and some userspace action
coincided or some such.
the dev_dbg() and nfs's /proc/sys/sunrpc/*debug are somewhat similar, only they dump
to dmesg which is quite limited in buffer size, adds huge delays if it goes out to some
slow console, wipes other potentially useful messages from the buffer in process
and such.

I guess you could print script tracepoints with a pattern in their name too,
but then there's this pain in the ass of converting:
$ git grep CERROR  drivers/staging/lustre/ | wc -l
1069
$ git grep CDEBUG  drivers/staging/lustre/ | wc -l
1140

messages AND there's also this thing that I do want many of those output to console
(because they are important enough) and to the buffer (so I can see them relative to
other debug messages I do not want to go to the console).

if tracepoints could be extended to enable that much - I'd be a super happy camper,
of course.
Sure, you cannot just make a macro that wraps the whole print into a tracepoint, but
that would be a stupid tracepoint with no finegrained control whatsoever,
but perhaps we can do name arguments or some such so that when you do

TRACEPOINT(someid, priority, "format string", some_value, some_other_value, �);

then if priority includes TPOINT_CONSOLE - it would also always go to console and to
the tracepoint buffer, and I can use the some_value and some_other_value
as actual matches for things (sure, that would limit you to just variables with
no logic done on them, but that's ok, I guess, could always be precalculated if
really necessary).

Hm, trying to research if you can extract the tracepoint buffer from a kernel crashdump
(and if anybody already happened to write a crash module for it yet), I also
stumbled upon LKST - http://elinux.org/Linux_Kernel_State_Tracer
(no idea how stale that is, but the page is from 2011 and last patch is from 2 years
ago) - this also implements a buffer and all sorts of extra event tracing,
so it appears to underscore the demand for such things is there and existing
mechanisms don't deliver for one reason or another.