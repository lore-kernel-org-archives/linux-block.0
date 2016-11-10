Return-Path: <jack@suse.cz>
Date: Thu, 10 Nov 2016 20:38:08 +0100
From: Jan Kara <jack@suse.cz>
To: Jens Axboe <axboe@kernel.dk>
Cc: Jens Axboe <axboe@fb.com>, Jan Kara <jack@suse.cz>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, hch@lst.de
Subject: Re: [PATCH 6/8] block: add scalable completion tracking of requests
Message-ID: <20161110193808.GF31098@quack2.suse.cz>
References: <1478034531-28559-1-git-send-email-axboe@fb.com>
 <1478034531-28559-7-git-send-email-axboe@fb.com>
 <20161108133007.GP32353@quack2.suse.cz>
 <cbd840e8-1807-5cf9-913b-bc62dbc7ac9e@fb.com>
 <20161109090157.GZ32353@quack2.suse.cz>
 <3c7e3183-a7e3-4219-54ca-65c9f45b6d5b@fb.com>
 <d07a75a1-6b8d-2cf0-d18f-93938ad86215@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <d07a75a1-6b8d-2cf0-d18f-93938ad86215@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Wed 09-11-16 12:52:25, Jens Axboe wrote:
> On 11/09/2016 09:09 AM, Jens Axboe wrote:
> >On 11/09/2016 02:01 AM, Jan Kara wrote:
> >>On Tue 08-11-16 08:25:52, Jens Axboe wrote:
> >>>On 11/08/2016 06:30 AM, Jan Kara wrote:
> >>>>On Tue 01-11-16 15:08:49, Jens Axboe wrote:
> >>>>>For legacy block, we simply track them in the request queue. For
> >>>>>blk-mq, we track them on a per-sw queue basis, which we can then
> >>>>>sum up through the hardware queues and finally to a per device
> >>>>>state.
> >>>>>
> >>>>>The stats are tracked in, roughly, 0.1s interval windows.
> >>>>>
> >>>>>Add sysfs files to display the stats.
> >>>>>
> >>>>>Signed-off-by: Jens Axboe <axboe@fb.com>
> >>>>
> >>>>This patch looks mostly good to me but I have one concern: You track
> >>>>statistics in a fixed 134ms window, stats get cleared at the
> >>>>beginning of
> >>>>each window. Now this can interact with the writeback window and
> >>>>latency
> >>>>settings which are dynamic and settable from userspace - so if the
> >>>>writeback code observation window gets set larger than the stats
> >>>>window,
> >>>>things become strange since you'll likely miss quite some observations
> >>>>about read latencies. So I think you need to make sure stats window is
> >>>>always larger than writeback window. Or actually, why do you have
> >>>>something
> >>>>like stats window and don't leave clearing of statistics completely
> >>>>to the
> >>>>writeback tracking code?
> >>>
> >>>That's a good point, and there actually used to be a comment to that
> >>>effect in the code. I think the best solution here would be to make the
> >>>stats code mask available somewhere, and allow a consumer of the stats
> >>>to request a larger window.
> >>>
> >>>Similarly, we could make the stat window be driven by the consumer, as
> >>>you suggest.
> >>>
> >>>Currently there are two pending submissions that depend on the stats
> >>>code. One is this writeback series, and the other one is the hybrid
> >>>polling code. The latter does not really care about the window size as
> >>>such, since it has no monitoring window of its own, and it wants the
> >>>auto-clearing as well.
> >>>
> >>>I don't mind working on additions for this, but I'd prefer if we could
> >>>layer them on top of the existing series instead of respinning it.
> >>>There's considerable test time on the existing patchset. Would that work
> >>>for you? Especially collapsing the stats and wbt windows would require
> >>>some re-architecting.
> >>
> >>OK, that works for me. Actually, when thinking about this, I have one
> >>more
> >>suggestion: Do we really want to expose the wbt window as a sysfs
> >>tunable?
> >>I guess it is good for initial experiments but longer term having the wbt
> >>window length be a function of target read latency might be better.
> >>Generally you want the window length to be considerably larger than the
> >>target latency but OTOH not too large so that the algorithm can react
> >>reasonably quickly so that suggests it could really be autotuned (and we
> >>scale the window anyway to adapt it to current situation).
> >
> >That's not a bad idea, I have thought about that as well before. We
> >don't need the window tunable, and you are right, it can be a function
> >of the desired latency.
> >
> >I'll hardwire the 100msec latency window for now and get rid of the
> >exposed tunable. It's harder to remove sysfs files once they have made
> >it into the kernel...
> 
> Killed the sysfs variable, so for now it'll be a 100msec window by
> default.

OK, I guess good enough to get this merged.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
