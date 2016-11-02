Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
Date: Tue, 1 Nov 2016 23:37:34 -0600
To: Johannes Thumshirn <jthumshirn@suse.de>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, hch@lst.de
Subject: Re: [PATCH 1/4] block: add scalable completion tracking of requests
Message-ID: <20161102053734.GA1317@kernel.dk>
References: <1478034325-28232-1-git-send-email-axboe@fb.com>
 <1478034325-28232-2-git-send-email-axboe@fb.com>
 <20161101222550.u64m4txqjgoohwbv@linux-x5ow.site>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161101222550.u64m4txqjgoohwbv@linux-x5ow.site>
List-ID: <linux-block@vger.kernel.org>

On Tue, Nov 01 2016, Johannes Thumshirn wrote:
> On Tue, Nov 01, 2016 at 03:05:22PM -0600, Jens Axboe wrote:
> > For legacy block, we simply track them in the request queue. For
> > blk-mq, we track them on a per-sw queue basis, which we can then
> > sum up through the hardware queues and finally to a per device
> > state.
> > 
> > The stats are tracked in, roughly, 0.1s interval windows.
> > 
> > Add sysfs files to display the stats.
> > 
> > Signed-off-by: Jens Axboe <axboe@fb.com>
> > ---
> 
> [...]
> 
> >  
> >  	/* incremented at completion time */
> >  	unsigned long		____cacheline_aligned_in_smp rq_completed[2];
> > +	struct blk_rq_stat	stat[2];
> 
> Can you add an enum or define for the directions? Just 0 and 1 aren't very
> intuitive.

Good point, I added that and updated both the stats patch and the
subsequent blk-mq poll code.

-- 
Jens Axboe
