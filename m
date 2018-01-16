Return-Path: <ming.lei@redhat.com>
Date: Tue, 16 Jan 2018 09:43:42 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Mike Snitzer <snitzer@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH V4 1/3] blk-mq: move actual issue into one helper
Message-ID: <20180116014341.GE3213@ming.t460p>
References: <20180115165810.2515-1-ming.lei@redhat.com>
 <20180115165810.2515-2-ming.lei@redhat.com>
 <2b698c6c-9d9d-8555-7fe8-272bcdd65086@kernel.dk>
 <20180115194112.GA25341@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180115194112.GA25341@redhat.com>
List-ID: <linux-block@vger.kernel.org>

On Mon, Jan 15, 2018 at 02:41:12PM -0500, Mike Snitzer wrote:
> On Mon, Jan 15 2018 at 12:29pm -0500,
> Jens Axboe <axboe@kernel.dk> wrote:
> 
> > On 1/15/18 9:58 AM, Ming Lei wrote:
> > > No functional change, just to clean up code a bit, so that the following
> > > change of using direct issue for blk_mq_request_bypass_insert() which is
> > > needed by DM can be easier to do.
> > > 
> > > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > > ---
> > >  block/blk-mq.c | 39 +++++++++++++++++++++++++++------------
> > >  1 file changed, 27 insertions(+), 12 deletions(-)
> > > 
> > > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > > index edb1291a42c5..bf8d6651f40e 100644
> > > --- a/block/blk-mq.c
> > > +++ b/block/blk-mq.c
> > > @@ -1696,15 +1696,37 @@ static blk_qc_t request_to_qc_t(struct blk_mq_hw_ctx *hctx, struct request *rq)
> > >  	return blk_tag_to_qc_t(rq->internal_tag, hctx->queue_num, true);
> > >  }
> > >  
> > > -static void __blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
> > > -					struct request *rq,
> > > -					blk_qc_t *cookie)
> > > +static blk_status_t __blk_mq_issue_req(struct blk_mq_hw_ctx *hctx,
> > > +				       struct request *rq,
> > > +				       blk_qc_t *new_cookie)
> > >  {
> > > +	blk_status_t ret;
> > >  	struct request_queue *q = rq->q;
> > >  	struct blk_mq_queue_data bd = {
> > >  		.rq = rq,
> > >  		.last = true,
> > >  	};
> > > +
> > > +	if (!blk_mq_get_driver_tag(rq, NULL, false))
> > > +		return BLK_STS_AGAIN;
> > > +
> > > +	if (!blk_mq_get_dispatch_budget(hctx)) {
> > > +		blk_mq_put_driver_tag(rq);
> > > +		return BLK_STS_AGAIN;
> > > +	}
> > > +
> > > +	*new_cookie = request_to_qc_t(hctx, rq);
> > > +
> > > +	ret = q->mq_ops->queue_rq(hctx, &bd);
> > > +
> > > +	return ret;
> > 
> > 	return q->mq_ops->queue_rq(hctx, &bd);
> > 
> > and kill 'ret', it's not used.
> 
> Yeap, good point.
> 
> > But more importantly, who puts the
> > driver tag and the budget if we get != OK for ->queue_rq()?
> 
> __blk_mq_try_issue_directly() processes the returned value same as before
> this patch.  Means this patch isn't making any functional change:
> If BLK_STS_RESOURCE: __blk_mq_requeue_request() is called.
> __blk_mq_requeue_request() will blk_mq_put_driver_tag().
> Otherwise, all other errors result in blk_mq_end_request(rq, ret);
> 
> So ignoring this patch, are you concerned that:
> 1) Does blk_mq_end_request() put both?  Looks like blk_mq_free_request()
> handles rq->tag != -1 but why not have it use __blk_mq_put_driver_tag()?
> I'm not seeing where the budget is put from blk_mq_end_request()...

blk_mq_free_request() releases driver tag, and budget is owned by driver
once .queue_rq is called.

> 
> 2) Nothing seems to be putting the budget in
> __blk_mq_try_issue_directly()'s BLK_STS_RESOURCE error path?  I share
> your concern now (for drivers who set {get,put}_budget in mq_ops).
> Should __blk_mq_requeue_request() be updated to also
> blk_mq_put_dispatch_budget()?

No, at least it is current protocol of using budget, please see
scsi_mq_queue_rq() and comment of blk_mq_do_dispatch_sched().

-- 
Ming
