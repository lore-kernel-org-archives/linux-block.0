Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59198 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759250AbdEZAom (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 May 2017 20:44:42 -0400
Date: Fri, 26 May 2017 08:44:28 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>
Cc: Bart Van Assche <Bart.VanAssche@sandisk.com>,
        "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 0/7] blk-mq: fix queue quiescing
Message-ID: <20170526004422.GA22365@ming.t460p>
References: <20170525042131.13172-1-ming.lei@redhat.com>
 <1495689892.3045.2.camel@sandisk.com>
 <20170525090917.GB15737@ming.t460p>
 <1495733047.2615.1.camel@sandisk.com>
 <cdfae246-d65e-fc49-69ec-dffe63832605@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cdfae246-d65e-fc49-69ec-dffe63832605@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, May 25, 2017 at 11:42:59AM -0600, Jens Axboe wrote:
> On 05/25/2017 11:24 AM, Bart Van Assche wrote:
> > On Thu, 2017-05-25 at 17:09 +0800, Ming Lei wrote:
> >> Another big issue is that 'srcu_struct' is very big, which shouldn't
> >> be embedded into hctx, since we only have one real user of
> >> BLK_MQ_F_BLOCKING.
> >>
> >> So I will fix that too.
> > 
> > Hello Ming,
> > 
> > Is something like the (untested) patch below perhaps what you had in mind?
> > 
> > Subject: [PATCH] blk-mq: Reduce blk_mq_hw_ctx size
> > 
> > Since the srcu structure is rather large (184 bytes on an x86-64
> > system), only allocate it if needed.
> > 
> > Reported-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  block/blk-mq.c         | 13 ++++++++++++-
> >  include/linux/blk-mq.h |  5 +++--
> >  2 files changed, 15 insertions(+), 3 deletions(-)
> > 
> > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > index 1e330de4e3c5..15b7d4077638 100644
> > --- a/block/blk-mq.c
> > +++ b/block/blk-mq.c
> > @@ -2233,6 +2233,17 @@ struct request_queue *blk_mq_init_queue(struct blk_mq_tag_set *set)
> >  }
> >  EXPORT_SYMBOL(blk_mq_init_queue);
> >  
> > +static int blk_mq_hw_ctx_size(struct request_queue *q)
> > +{
> > +	BUILD_BUG_ON(ALIGN(offsetof(struct blk_mq_hw_ctx, queue_rq_srcu) +
> > +		sizeof(((struct blk_mq_hw_ctx *)NULL)->queue_rq_srcu), 64) !=
> > +		sizeof(struct blk_mq_hw_ctx));
> > +
> > +	return q->tag_set->flags & BLK_MQ_F_BLOCKING ?
> > +		sizeof(struct blk_mq_hw_ctx) :
> > +		offsetof(struct blk_mq_hw_ctx, queue_rq_srcu);
> > +}
> > +
> >  static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
> >  						struct request_queue *q)
> >  {
> > @@ -2247,7 +2258,7 @@ static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
> >  			continue;
> >  
> >  		node = blk_mq_hw_queue_to_node(q->mq_map, i);
> > -		hctxs[i] = kzalloc_node(sizeof(struct blk_mq_hw_ctx),
> > +		hctxs[i] = kzalloc_node(blk_mq_hw_ctx_size(q),
> >  					GFP_KERNEL, node);
> >  		if (!hctxs[i])
> >  			break;
> > diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
> > index c0d59330b5e0..8467e1f83524 100644
> > --- a/include/linux/blk-mq.h
> > +++ b/include/linux/blk-mq.h
> > @@ -39,8 +39,6 @@ struct blk_mq_hw_ctx {
> >  	struct blk_mq_tags	*tags;
> >  	struct blk_mq_tags	*sched_tags;
> >  
> > -	struct srcu_struct	queue_rq_srcu;
> > -
> >  	unsigned long		queued;
> >  	unsigned long		run;
> >  #define BLK_MQ_MAX_DISPATCH_ORDER	7
> > @@ -62,6 +60,9 @@ struct blk_mq_hw_ctx {
> >  	struct dentry		*debugfs_dir;
> >  	struct dentry		*sched_debugfs_dir;
> >  #endif
> > +
> > +	/* Must be the last member - see also blk_mq_hw_ctx_size(). */
> > +	struct srcu_struct	queue_rq_srcu;
> >  };
> 
> Why not make it
> 
> 	/* Must be the last member - see also blk_mq_hw_ctx_size(). */
> 	struct srcu_struct	queue_rq_srcu[0];

Yeah, actually that was what I did yesterday in my local tree, will
posted out today with the blk_mq_quiesce_queue() fix.


Thanks,
Ming
