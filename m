Return-Path: <osandov@osandov.com>
Return-Path: <osandov@osandov.com>
Date: Thu, 22 Dec 2016 08:52:07 -0800
From: Omar Sandoval <osandov@osandov.com>
To: Bart Van Assche <Bart.VanAssche@sandisk.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"axboe@fb.com" <axboe@fb.com>, "axboe@kernel.dk" <axboe@kernel.dk>,
	"osandov@fb.com" <osandov@fb.com>,
	"paolo.valente@linaro.org" <paolo.valente@linaro.org>
Subject: Re: [PATCHSET v4] blk-mq-scheduling framework
Message-ID: <20161222165207.GA25717@vader>
References: <1481933536-12844-1-git-send-email-axboe@fb.com>
 <1482423775.2682.6.camel@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1482423775.2682.6.camel@sandisk.com>
List-ID: <linux-block@vger.kernel.org>

On Thu, Dec 22, 2016 at 04:23:24PM +0000, Bart Van Assche wrote:
> On Fri, 2016-12-16 at 17:12 -0700, Jens Axboe wrote:
> > From the discussion last time, I looked into the feasibility of having
> > two sets of tags for the same request pool, to avoid having to copy
> > some of the request fields at dispatch and completion time. To do that,
> > we'd have to replace the driver tag map(s) with our own, and augment
> > that with tag map(s) on the side representing the device queue depth.
> > Queuing IO with the scheduler would allocate from the new map, and
> > dispatching would acquire the "real" tag. We would need to change
> > drivers to do this, or add an extra indirection table to map a real
> > tag to the scheduler tag. We would also need a 1:1 mapping between
> > scheduler and hardware tag pools, or additional info to track it.
> > Unless someone can convince me otherwise, I think the current approach
> > is cleaner.
> 
> Hello Jens,
> 
> Can you have a look at the attached patches? These implement the "two tags
> per request" approach without a table that maps one tag type to the other
> or any other ugly construct.�__blk_mq_alloc_request() is modified such that
> it assigns rq->sched_tag and sched_tags->rqs[] instead of rq->tag and
> tags->rqs[]. rq->tag and tags->rqs[] are assigned just before dispatch by
> blk_mq_assign_drv_tag(). This approach results in significantly less code
> than the approach proposed in v4 of your blk-mq-sched patch series. Memory
> usage is lower because only a single set of requests is allocated. The
> runtime overhead is lower because request fields no longer have to be
> copied between the requests owned by the block driver and the requests
> owned by the I/O scheduler. I can boot a VM from the virtio-blk driver but
> otherwise the attached patches have not yet been tested.
> 
> Thanks,
> 
> Bart.

Hey, Bart,

This approach occurred to us, but we couldn't figure out a way to make
blk_mq_tag_to_rq() work with it. From skimming over the patches, I
didn't see a solution to that problem.
