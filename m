Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:48272 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751800AbdAYJ42 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Jan 2017 04:56:28 -0500
Date: Wed, 25 Jan 2017 10:56:13 +0100
From: Jan Kara <jack@suse.cz>
To: Oleg Drokin <green@linuxhacker.ru>
Cc: Dan Williams <dan.j.williams@intel.com>,
        linux-block@vger.kernel.org, Song Liu <songliubraving@fb.com>,
        Andreas Dilger <andreas.dilger@intel.com>,
        "Verma, Vishal L" <vishal.l.verma@intel.com>,
        Jens Axboe <axboe@fb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kernel Team <Kernel-team@fb.com>,
        lsf-pc@lists.linux-foundation.org
Subject: Re: [Lsf-pc] [LSF/MM TOPIC] block level event logging for storage
 media management
Message-ID: <20170125095613.GA18739@quack2.suse.cz>
References: <6040124E-4928-4FC8-8A52-35115D9CA1DF@fb.com>
 <CAA9_cmd_XMbw_26ePCSWLxP9PoTn36n8sO5buE2iTCoPnK+CHg@mail.gmail.com>
 <92E1CE17-4F28-4934-BB60-358FA334AA5F@fb.com>
 <CAPcyv4hrcS13ijDU2+Mp59EKCqkWLMv7uj=BhKKewiz02YZiPA@mail.gmail.com>
 <41FACF7F-7B70-47FC-92FB-B64C545BE434@linuxhacker.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <41FACF7F-7B70-47FC-92FB-B64C545BE434@linuxhacker.ru>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue 24-01-17 15:18:57, Oleg Drokin wrote:
> 
> On Jan 23, 2017, at 2:27 AM, Dan Williams wrote:
> 
> > [ adding Oleg ]
> > 
> > On Sun, Jan 22, 2017 at 10:00 PM, Song Liu <songliubraving@fb.com> wrote:
> >> Hi Dan,
> >> 
> >> I think the the block level event log is more like log only system. When en event
> >> happens,  it is not necessary to take immediate action. (I guess this is different
> >> to bad block list?).
> >> 
> >> I would hope the event log to track more information. Some of these individual
> >> event may not be very interesting, for example, soft error or latency outliers.
> >> However, when we gather event log for a fleet of devices, these "soft event"
> >> may become valuable for health monitoring.
> > 
> > I'd be interested in this. It sounds like you're trying to fill a gap
> > between tracing and console log messages which I believe others have
> > encountered as well.
> 
> We have a somewhat similar problem problem in Lustre and I guess it's not
> just Lustre.  Currently there are all sorts of conditional debug code all
> over the place that goes to the console and when you enable it for
> anything verbose, you quickly overflow your dmesg buffer no matter the
> size, that might be mostly ok for local "block level" stuff, but once you
> become distributed, it start to be a mess and once you get to be super
> large it worsens even more since you need to somehow coordinate data from
> multiple nodes, ensure all of it is not lost and still you don't end up
> using a lot of it since only a few nodes end up being useful.  (I don't
> know how NFS people manage to debug complicated issues using just this,
> could not be super easy).
> 
> Having some sort of a buffer of a (potentially very) large size that
> could be storing the data until it's needed, or eagerly polled by some
> daemon for storage (helpful when you expect a lot of data that definitely
> won't fit in RAM).
> 
> Tracepoints have the buffer and the daemon, but creating new messages is
> very cumbersome, so converting every debug message into one does not look
> very feasible.  Also it's convenient to have "event masks" one want
> logged that I don't think you could do with tracepoints.

So creating trace points IMO isn't that cumbersome. I agree that converting
hundreds or thousands debug printks into tracepoints is a pain in the
ass but still it is doable. WRT filtering, you can enable each tracepoint
individually. Granted that is not exactly the 'event mask' feature you ask
about but that can be easily scripted in userspace if you give some
structure to tracepoint names. Finally tracepoints provide a fine grained
control you never get with printk - e.g. you can make a tracepoint trigger
only if specific inode is involved with trace filters which greatly reduces
the amount of output.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
