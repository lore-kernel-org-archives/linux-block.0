Return-Path: <zhangweiping@didichuxing.com>
Date: Sat, 7 Oct 2017 16:46:23 +0800
From: weiping zhang <zhangweiping@didichuxing.com>
To: <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>
Subject: Re: [PATCH v4] blk-mq: fix nr_requests wrong value when modify it
 from sysfs
Message-ID: <20171007084623.GA6035@source.didichuxing.com>
References: <20170922153624.GA15873@localhost.didichuxing.com>
 <20170930145727.GA34288@source.didichuxing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20170930145727.GA34288@source.didichuxing.com>
Return-Path: zhangweiping@didichuxing.com
List-ID: <linux-block@vger.kernel.org>

On Sat, Sep 30, 2017 at 10:57:31PM +0800, weiping zhang wrote:
> On Fri, Sep 22, 2017 at 11:36:28PM +0800, weiping zhang wrote:
> > if blk-mq use "none" io scheduler, nr_request get a wrong value when
> > input a number > tag_set->queue_depth. blk_mq_tag_update_depth will get
> > the smaller one min(nr, set->queue_depth), and then q->nr_request get a
> > wrong value.
> > 
> > Reproduce:
> > 
> > echo none > /sys/block/nvme0n1/queue/scheduler
> > echo 1000000 > /sys/block/nvme0n1/queue/nr_requests
> > cat /sys/block/nvme0n1/queue/nr_requests
> > 1000000
> > 
> > Signed-off-by: weiping zhang <zhangweiping@didichuxing.com>
> > ---
> > 
> > Changes since v4:
> >  * fix typo in commit message(queue/ioscheduler => queue/scheduler)
> > 
> > Changes since v3:
> >  * remove compare nr with tags->qdepth, pass nr to blk_mq_tag_update_depth
> > directly
> > 
> >  * remove return EINVAL when user modify nr_request less than BLKDEV_MIN_RQ
> > 
> > Changes since v2:
> >  * add return EINVAL when user modify nr_request less than BLKDEV_MIN_RQ
> >  * remove pr_warn, and return EINVAL, if input number is too large
> > 
> >  block/blk-mq.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > index 98a1860..491e336 100644
> > --- a/block/blk-mq.c
> > +++ b/block/blk-mq.c
> > @@ -2642,8 +2642,7 @@ int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr)
> >  		 * queue depth. This is similar to what the old code would do.
> >  		 */
> >  		if (!hctx->sched_tags) {
> > -			ret = blk_mq_tag_update_depth(hctx, &hctx->tags,
> > -							min(nr, set->queue_depth),
> > +			ret = blk_mq_tag_update_depth(hctx, &hctx->tags, nr,
> >  							false);
> >  		} else {
> >  			ret = blk_mq_tag_update_depth(hctx, &hctx->sched_tags,
> > -- 
> > 2.9.4
> > 
> 
> Hi Jens,
> 
> As you say before:
> > blk_mq_tag_update_depth() should already return
> > -EINVAL for the case where we can't grow the tags. Looks like this patch
> > should simply remove the min(nr, set->queue_depth) and just pass in 'nr'.
> I also find that hctx->tags->nr_tags equal to tag_set->queue_depth no matter use
> hctx->sched_tags or not. So I think it's safe to verify 'nr' by
> hctx->tags->nr_tags.
> 
Hello Jens,

ping
