Return-Path: <ming.lei@redhat.com>
Date: Tue, 16 Jan 2018 09:40:10 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Mike Snitzer <snitzer@redhat.com>,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH V4 1/3] blk-mq: move actual issue into one helper
Message-ID: <20180116014009.GD3213@ming.t460p>
References: <20180115165810.2515-1-ming.lei@redhat.com>
 <20180115165810.2515-2-ming.lei@redhat.com>
 <2b698c6c-9d9d-8555-7fe8-272bcdd65086@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2b698c6c-9d9d-8555-7fe8-272bcdd65086@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Mon, Jan 15, 2018 at 10:29:46AM -0700, Jens Axboe wrote:
> On 1/15/18 9:58 AM, Ming Lei wrote:
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
> 
> 	return q->mq_ops->queue_rq(hctx, &bd);
> 
> and kill 'ret', it's not used. But more importantly, who puts the

OK.

> driver tag and the budget if we get != OK for ->queue_rq()?

For the budget, the current protocol is that driver is responsible for the
release once .queue_rq is called, see scsi_mq_queue_rq() and comment in
blk_mq_do_dispatch_sched().

For driver tag, it is released in blk_mq_free_request(), which is done
in failure handling of != OK.

-- 
Ming
