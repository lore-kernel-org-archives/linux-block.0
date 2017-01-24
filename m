Return-Path: <linux-block-owner@vger.kernel.org>
Received: from linuxhacker.ru ([217.76.32.60]:50338 "EHLO fiona.linuxhacker.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750715AbdAXVTX (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Jan 2017 16:19:23 -0500
Subject: Re: [LSF/MM TOPIC] block level event logging for storage media management
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=windows-1252
From: Oleg Drokin <green@linuxhacker.ru>
In-Reply-To: <CAPcyv4hrcS13ijDU2+Mp59EKCqkWLMv7uj=BhKKewiz02YZiPA@mail.gmail.com>
Date: Tue, 24 Jan 2017 15:18:57 -0500
Cc: Song Liu <songliubraving@fb.com>,
        lsf-pc@lists.linux-foundation.org, Jens Axboe <axboe@fb.com>,
        Kernel Team <Kernel-team@fb.com>, linux-block@vger.kernel.org,
        "Verma, Vishal L" <vishal.l.verma@intel.com>,
        Andreas Dilger <andreas.dilger@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Message-Id: <41FACF7F-7B70-47FC-92FB-B64C545BE434@linuxhacker.ru>
References: <6040124E-4928-4FC8-8A52-35115D9CA1DF@fb.com> <CAA9_cmd_XMbw_26ePCSWLxP9PoTn36n8sO5buE2iTCoPnK+CHg@mail.gmail.com> <92E1CE17-4F28-4934-BB60-358FA334AA5F@fb.com> <CAPcyv4hrcS13ijDU2+Mp59EKCqkWLMv7uj=BhKKewiz02YZiPA@mail.gmail.com>
To: Dan Williams <dan.j.williams@intel.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


On Jan 23, 2017, at 2:27 AM, Dan Williams wrote:

> [ adding Oleg ]
> 
> On Sun, Jan 22, 2017 at 10:00 PM, Song Liu <songliubraving@fb.com> wrote:
>> Hi Dan,
>> 
>> I think the the block level event log is more like log only system. When en event
>> happens,  it is not necessary to take immediate action. (I guess this is different
>> to bad block list?).
>> 
>> I would hope the event log to track more information. Some of these individual
>> event may not be very interesting, for example, soft error or latency outliers.
>> However, when we gather event log for a fleet of devices, these "soft event"
>> may become valuable for health monitoring.
> 
> I'd be interested in this. It sounds like you're trying to fill a gap
> between tracing and console log messages which I believe others have
> encountered as well.

We have a somewhat similar problem problem in Lustre and I guess it's not just Lustre.
Currently there are all sorts of conditional debug code all over the place that goes
to the console and when you enable it for anything verbose, you quickly overflow
your dmesg buffer no matter the size, that might be mostly ok for local
"block level" stuff, but once you become distributed, it start to be a mess
and once you get to be super large it worsens even more since you need to
somehow coordinate data from multiple nodes, ensure all of it is not lost and still
you don't end up using a lot of it since only a few nodes end up being useful.
(I don't know how NFS people manage to debug complicated issues using just this,
could not be super easy).

Having some sort of a buffer of a (potentially very) large size that could be
storing the data until it's needed, or eagerly polled by some daemon for storage
(helpful when you expect a lot of data that definitely won't fit in RAM).

Tracepoints have the buffer and the daemon, but creating new messages is
very cumbersome, so converting every debug message into one does not look very feasible.
Also it's convenient to have "event masks" one want logged that I don't think you could
do with tracepoints.

I know you were talking about reporting events to the block layer, but other than plain
errors what would block layer do with them? just a convenient way to map messages
to a particular device? You don't plan to store it on some block device as part
of the block layer, right?

Implementing such a buffer all sorts of additional generic data might be
collected automatically for all events as part of the buffer format like
what cpu did emit it, time, stack usage information, current pid,
backtrace (tracepoint-alike could be optional), actual source code location of
the message, �

Having something like that being standard part of {dev,pr}_{dbg,warn,...} and friends
would be super awesome too, I imagine (adding Greg to CC for that).

