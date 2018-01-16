Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42194 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751113AbeAPBgc (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 Jan 2018 20:36:32 -0500
Date: Tue, 16 Jan 2018 09:36:16 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Mike Snitzer <snitzer@redhat.com>
Cc: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH V4 1/3] blk-mq: move actual issue into one helper
Message-ID: <20180116013615.GC3213@ming.t460p>
References: <20180115165810.2515-1-ming.lei@redhat.com>
 <20180115165810.2515-2-ming.lei@redhat.com>
 <20180115171547.GA24260@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180115171547.GA24260@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Jan 15, 2018 at 12:15:47PM -0500, Mike Snitzer wrote:
> On Mon, Jan 15 2018 at 11:58am -0500,
> Ming Lei <ming.lei@redhat.com> wrote:
> 
> > No functional change, just to clean up code a bit, so that the following
> > change of using direct issue for blk_mq_request_bypass_insert() which is
> > needed by DM can be easier to do.
> > 
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  block/blk-mq.c | 39 +++++++++++++++++++++++++++------------
> >  1 file changed, 27 insertions(+), 12 deletions(-)
> > 
> > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > index edb1291a42c5..bf8d6651f40e 100644
> > --- a/block/blk-mq.c
> > +++ b/block/blk-mq.c
> > @@ -1696,15 +1696,37 @@ static blk_qc_t request_to_qc_t(struct blk_mq_hw_ctx *hctx, struct request *rq)
> >  	return blk_tag_to_qc_t(rq->internal_tag, hctx->queue_num, true);
> >  }
> >  
> > -static void __blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
> > -					struct request *rq,
> > -					blk_qc_t *cookie)
> > +static blk_status_t __blk_mq_issue_req(struct blk_mq_hw_ctx *hctx,
> > +				       struct request *rq,
> > +				       blk_qc_t *new_cookie)
> >  {
> > +	blk_status_t ret;
> >  	struct request_queue *q = rq->q;
> >  	struct blk_mq_queue_data bd = {
> >  		.rq = rq,
> >  		.last = true,
> >  	};
> > +
> > +	if (!blk_mq_get_driver_tag(rq, NULL, false))
> > +		return BLK_STS_AGAIN;
> > +
> > +	if (!blk_mq_get_dispatch_budget(hctx)) {
> > +		blk_mq_put_driver_tag(rq);
> > +		return BLK_STS_AGAIN;
> > +	}
> > +
> > +	*new_cookie = request_to_qc_t(hctx, rq);
> > +
> > +	ret = q->mq_ops->queue_rq(hctx, &bd);
> > +
> > +	return ret;
> > +}
> > +
> > +static void __blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
> > +					struct request *rq,
> > +					blk_qc_t *cookie)
> > +{
> > +	struct request_queue *q = rq->q;
> >  	blk_qc_t new_cookie;
> >  	blk_status_t ret;
> >  	bool run_queue = true;
> > @@ -1718,22 +1740,15 @@ static void __blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
> >  	if (q->elevator)
> >  		goto insert;
> >  
> > -	if (!blk_mq_get_driver_tag(rq, NULL, false))
> > +	ret = __blk_mq_issue_req(hctx, rq, &new_cookie);
> > +	if (ret == BLK_STS_AGAIN)
> >  		goto insert;
> 
> You're (ab)using BLK_STS_AGAIN as a means to an end...
> But what if in the future q->mq_ops->queue_rq() returns BLK_STS_AGAIN?

Yeah, but now only dio uses that, so I let Jens decide it.

-- 
Ming
