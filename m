Return-Path: <ming.lei@redhat.com>
Date: Thu, 12 Apr 2018 17:49:33 +0800
From: Ming Lei <ming.lei@redhat.com>
To: "jianchao.wang" <jianchao.w.wang@oracle.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Bart Van Assche <bart.vanassche@wdc.com>, Tejun Heo <tj@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Israel Rukshin <israelr@mellanox.com>,
	Max Gurtovoy <maxg@mellanox.com>, stable@vger.kernel.org
Subject: Re: [PATCH V2] blk-mq: fix race between complete and
 BLK_EH_RESET_TIMER
Message-ID: <20180412094928.GA4697@ming.t460p>
References: <20180411233812.18003-1-ming.lei@redhat.com>
 <f63c9def-4fef-5032-814c-5dc142d5be5a@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <f63c9def-4fef-5032-814c-5dc142d5be5a@oracle.com>
List-ID: <linux-block@vger.kernel.org>

On Thu, Apr 12, 2018 at 10:38:56AM +0800, jianchao.wang wrote:
> Hi Ming
> 
> On 04/12/2018 07:38 AM, Ming Lei wrote:
> > +	 *
> > +	 * Cover complete vs BLK_EH_RESET_TIMER race in slow path with
> > +	 * helding queue lock.
> >  	 */
> >  	hctx_lock(hctx, &srcu_idx);
> >  	if (blk_mq_rq_aborted_gstate(rq) != rq->gstate)
> >  		__blk_mq_complete_request(rq);
> > +	else {
> > +		unsigned long flags;
> > +		bool need_complete = false;
> > +
> > +		spin_lock_irqsave(q->queue_lock, flags);
> > +		if (!blk_mq_rq_aborted_gstate(rq))
> > +			need_complete = true;
> > +		else
> > +			blk_mq_rq_update_state(rq, MQ_RQ_COMPLETE_IN_TIMEOUT);
> > +		spin_unlock_irqrestore(q->queue_lock, flags);
> 
> What if the .timeout return BLK_EH_HANDLED during this ?
> timeout context                     irq context
>   .timeout()
>                                      blk_mq_complete_request
>                                        set state to MQ_RQ_COMPLETE_IN_TIMEOUT
>   __blk_mq_complete_request
>     WARN_ON_ONCE(blk_mq_rq_state(rq) 
>      != MQ_RQ_IN_FLIGHT);

Thinking of it further, if the normal completion from irq context can
happen after BLK_EH_HANDLED is returned from .timeout, this request may 
be recycled immediately after __blk_mq_complete_request(), then
blk_mq_complete_request() can complete the new instance early, so that
can be another race between old normal completion and new dispatch.

I guess .timeout should make sure this thing won't happen.

--
Ming
