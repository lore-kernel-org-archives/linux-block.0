Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47752 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757672AbdEVJwV (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 May 2017 05:52:21 -0400
Date: Mon, 22 May 2017 17:52:08 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Omar Sandoval <osandov@fb.com>
Subject: Re: [PATCH] blk-mq: provide a default .bio_merge
Message-ID: <20170522095207.GE15872@ming.t460p>
References: <20170512162054.25517-1-ming.lei@redhat.com>
 <20170521063059.GA23777@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170521063059.GA23777@infradead.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Sat, May 20, 2017 at 11:30:59PM -0700, Christoph Hellwig wrote:
> On Sat, May 13, 2017 at 12:20:54AM +0800, Ming Lei wrote:
> > Before blk-mq is introduced, I/O is merged before putting into
> > plug queue, but blk-mq changed the order and makes merging
> > basically impossible until mq-deadline is introduced. Then it
> > is observed that throughput of sequential I/O is degraded about
> > 10%~20% on virtio-blk in the test[1] if IO schedluer isn't used.
> > 
> > This patch provides a default per-sw-queue bio merging if there
> > isn't scheduler enabled or the scheduler hasn't implement .bio_merge(),
> > and this way actually moves merging before plugging just
> > like what blk_queue_bio() does, then the performance regression
> > is fixed.
> 
> This looks generally reasonable, but can you split the move of
> blk_mq_attempt_merge into a separate patch (or just skip it for now)?
> This clutters up the diff a lot and makes it much harder to read.

OK, will do it in v2.

> 
> >  bool __blk_mq_sched_bio_merge(struct request_queue *q, struct bio *bio)
> >  {
> >  	struct elevator_queue *e = q->elevator;
> > +	struct blk_mq_ctx *ctx = blk_mq_get_ctx(q);
> > +	struct blk_mq_hw_ctx *hctx = blk_mq_map_queue(q, ctx->cpu);
> > +	bool ret = false;
> >  
> > +	if (e && e->type->ops.mq.bio_merge) {
> >  		blk_mq_put_ctx(ctx);
> >  		return e->type->ops.mq.bio_merge(hctx, bio);
> > +	} else if (hctx->flags & BLK_MQ_F_SHOULD_MERGE) {
> 
> No need for the relse here given the return.  Also both mq-deadline
> and cfq don't need the hctx at all and just the queue, so we could even
> skip it for that case.
> 
> 	if (e && e->type->ops.mq.bio_merge)
> 		return e->type->ops.mq.bio_merge(q, bio);

That need to change current elevator interface(pass q instead of hctx), so
I think better to not do that in this patch.

> 
> 	ctx = blk_mq_get_ctx(q);
> 	hctx = blk_mq_map_queue(q, ctx->cpu);
> 	if (hctx->flags & BLK_MQ_F_SHOULD_MERGE) {
> 		...
> 	}
> 
> (and we only need the hctx for the flags, sigh..)

The check may need to be removed in the future, since every blk-mq driver
sets BLK_MQ_F_SHOULD_MERGE now.

Thanks,
Ming
