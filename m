Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54388 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1426776AbdD2KgD (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 29 Apr 2017 06:36:03 -0400
Date: Sat, 29 Apr 2017 18:35:54 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <Bart.VanAssche@sandisk.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>,
        "hch@infradead.org" <hch@infradead.org>,
        "osandov@fb.com" <osandov@fb.com>
Subject: Re: [PATCH 3/4] blk-mq: use hw tag for scheduling if hw tag space is
 big enough
Message-ID: <20170429103554.GC12421@ming.t460p>
References: <20170428151539.25514-1-ming.lei@redhat.com>
 <20170428151539.25514-4-ming.lei@redhat.com>
 <1493402979.2767.10.camel@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1493402979.2767.10.camel@sandisk.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Apr 28, 2017 at 06:09:40PM +0000, Bart Van Assche wrote:
> On Fri, 2017-04-28 at 23:15 +0800, Ming Lei wrote:
> > +static inline bool blk_mq_sched_may_use_hw_tag(struct request_queue *q)
> > +{
> > +	if (q->tag_set->flags & BLK_MQ_F_TAG_SHARED)
> > +		return false;
> > +
> > +	if (blk_mq_get_queue_depth(q) < q->nr_requests)
> > +		return false;
> > +
> > +	return true;
> > +}
> 
> The only user of shared tag sets I know of is scsi-mq. I think it's really
> unfortunate that this patch systematically disables BLK_MQ_F_SCHED_USE_HW_TAG
> for scsi-mq.

In previous patch, I actually allow driver to pass this flag, but this
feature is dropped in this post, just for making it simple & clean.
If you think we need it for shared tag set, I can add it in v1.

For shared tag sets, I suggest to not enable it at default, because
scheduler is per request queue now, and generaly more requests available,
better it performs.  When tags are shared among several request
queues, one of them may use tags up for its own scheduling, then
starve others. But it should be possible and not difficult to allocate
requests fairly for scheduling in this case if we switch to per-hctx
scheduling.

> 
> >  int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr)
> >  {
> >  	struct blk_mq_tag_set *set = q->tag_set;
> > @@ -2681,9 +2694,12 @@ int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr)
> >  			break;
> >  	}
> >  
> > -	if (!ret)
> > +	if (!ret) {
> >  		q->nr_requests = nr;
> >  
> > +		blk_mq_update_sched_flag(q);
> > +	}
> > +
> >  	blk_mq_unfreeze_queue(q);
> >  	blk_mq_start_stopped_hw_queues(q, true);
> 
> If a queue is created with a low value of nr_requests that will cause
> blk_mq_sched_alloc_tags() to skip allocation of .sched_tags. If nr_requests
> is increased, can that cause this function to clear BLK_MQ_F_SCHED_USE_HW_TAG
> while keeping hctx->sched_tags == NULL and hence trigger a NULL pointer
> dereference?

Good catch, will fix it in V1.

Given both scheduler switch and updating requests number are not
frequent actions, we can allocate/deallocate .sched_tags just
in need.


Thanks,
Ming
