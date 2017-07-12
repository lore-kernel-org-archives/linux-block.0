Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41036 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754620AbdGLDpr (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Jul 2017 23:45:47 -0400
Date: Wed, 12 Jul 2017 11:45:38 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>,
        "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH 3/6] blk-mq: send the request to dispatch list if direct
 issue returns busy
Message-ID: <20170712034538.GJ13036@ming.t460p>
References: <20170711182103.11461-1-ming.lei@redhat.com>
 <20170711182103.11461-4-ming.lei@redhat.com>
 <1499804330.2586.32.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1499804330.2586.32.camel@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Jul 11, 2017 at 08:18:51PM +0000, Bart Van Assche wrote:
> On Wed, 2017-07-12 at 02:21 +0800, Ming Lei wrote:
> > Before mq IO scheduler is in, we always send the request to
> > dispatch list if .queue_rq() return busy. After mq IO scheduler
> > is introduced, we only do this way when scheduler is used in
> > case of direct issue. Actually we can do that when scheduler
> > isn't used too.
> > 
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  block/blk-mq.c | 18 +++++++++++++++---
> >  1 file changed, 15 insertions(+), 3 deletions(-)
> > 
> > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > index 041f7b7fa0d6..6e0fc80aa151 100644
> > --- a/block/blk-mq.c
> > +++ b/block/blk-mq.c
> > @@ -1463,6 +1463,16 @@ static blk_qc_t request_to_qc_t(struct blk_mq_hw_ctx *hctx, struct request *rq)
> >  	return blk_tag_to_qc_t(rq->internal_tag, hctx->queue_num, true);
> >  }
> >  
> > +static void blk_mq_direct_dispatch(struct blk_mq_hw_ctx *hctx,
> > +				   struct request *rq)
> > +{
> > +	spin_lock(&hctx->lock);
> > +	list_add(&rq->queuelist, &hctx->dispatch);
> > +	spin_unlock(&hctx->lock);
> > +
> > +	blk_mq_run_hw_queue(hctx, false);
> > +}
> > +
> >  static void __blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
> >  					struct request *rq,
> >  					blk_qc_t *cookie, bool may_sleep)
> > @@ -1499,15 +1509,17 @@ static void __blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
> >  	switch (ret) {
> >  	case BLK_STS_OK:
> >  		*cookie = new_cookie;
> > -		return;
> > +		break;
> >  	case BLK_STS_RESOURCE:
> >  		__blk_mq_requeue_request(rq);
> > -		goto insert;
> > +		blk_mq_direct_dispatch(hctx, rq);
> > +		break;
> >  	default:
> >  		*cookie = BLK_QC_T_NONE;
> >  		blk_mq_end_request(rq, ret);
> > -		return;
> > +		break;
> >  	}
> > +	return;
> >  
> >  insert:
> >  	blk_mq_sched_insert_request(rq, false, run_queue, false, may_sleep);
> 
> Hello Ming,
> 
> This patch changes the behavior of blk_mq_try_issue_directly() if a scheduler
> has been configured and .queue_rq() returns BLK_STS_RESOURCE, namely by skipping
> the e->type->ops.mq.insert_requests() call. Sorry but I don't think this is what
> we want.

It does not change behaviour for scheduler, please see
blk_mq_sched_bypass_insert() which is called from
blk_mq_sched_insert_request().

-- 
Ming
