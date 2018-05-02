Return-Path: <ming.lei@redhat.com>
Date: Wed, 2 May 2018 11:33:43 +0800
From: Ming Lei <ming.lei@redhat.com>
To: "jianchao.wang" <jianchao.w.wang@oracle.com>
Cc: Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V2 1/5] block: introduce blk_quiesce_timeout() and
 blk_unquiesce_timeout()
Message-ID: <20180502033342.GD22363@ming.t460p>
References: <20180429154152.16656-1-ming.lei@redhat.com>
 <20180429154152.16656-2-ming.lei@redhat.com>
 <93c4190f-178a-a3b4-5203-bd8c6a0eaef2@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <93c4190f-178a-a3b4-5203-bd8c6a0eaef2@oracle.com>
List-ID: <linux-block@vger.kernel.org>

On Wed, May 02, 2018 at 10:23:35AM +0800, jianchao.wang wrote:
> Hi ming
> 
> On 04/29/2018 11:41 PM, Ming Lei wrote:
> >  
> > +static void __blk_unquiesce_timeout(struct request_queue *q)
> > +{
> > +	unsigned long flags;
> > +
> > +	spin_lock_irqsave(q->queue_lock, flags);
> > +	q->timeout_off = false;
> > +	spin_unlock_irqrestore(q->queue_lock, flags);
> > +}
> > +
> > +void blk_unquiesce_timeout(struct request_queue *q)
> > +{
> > +	__blk_unquiesce_timeout(q);
> > +	mod_timer(&q->timeout, jiffies + q->rq_timeout);
> > +}
> > +EXPORT_SYMBOL(blk_unquiesce_timeout);
> > +
> > +void blk_quiesce_timeout(struct request_queue *q)
> > +{
> > +	unsigned long flags;
> > +
> > +	spin_lock_irqsave(q->queue_lock, flags);
> > +	q->timeout_off = true;
> > +	spin_unlock_irqrestore(q->queue_lock, flags);
> > +
> > +	del_timer_sync(&q->timeout);
> > +	cancel_work_sync(&q->timeout_work);
> > +}
> > +EXPORT_SYMBOL(blk_quiesce_timeout);
> > +
> >  /**
> >   * blk_sync_queue - cancel any pending callbacks on a queue
> >   * @q: the queue
> > @@ -408,8 +437,7 @@ EXPORT_SYMBOL(blk_stop_queue);
> >   */
> >  void blk_sync_queue(struct request_queue *q)
> >  {
> > -	del_timer_sync(&q->timeout);
> > -	cancel_work_sync(&q->timeout_work);
> > +	blk_quiesce_timeout(q);
> >  
> >  	if (q->mq_ops) {
> >  		struct blk_mq_hw_ctx *hctx;
> > @@ -421,6 +449,8 @@ void blk_sync_queue(struct request_queue *q)
> >  	} else {
> >  		cancel_delayed_work_sync(&q->delay_work);
> >  	}
> > +
> > +	__blk_unquiesce_timeout(q);
> >  }
> >  EXPORT_SYMBOL(blk_sync_queue);
> >  
> > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > index 0dc9e341c2a7..890dd3b3e3e1 100644
> > --- a/block/blk-mq.c
> > +++ b/block/blk-mq.c
> > @@ -901,6 +901,15 @@ static void blk_mq_timeout_work(struct work_struct *work)
> >  	};
> >  	struct blk_mq_hw_ctx *hctx;
> >  	int i;
> > +	bool timeout_off;
> > +	unsigned long flags;
> > +
> > +	spin_lock_irqsave(q->queue_lock, flags);
> > +	timeout_off = q->timeout_off;
> > +	spin_unlock_irqrestore(q->queue_lock, flags);
> > +
> > +	if (timeout_off)
> > +		return;
> 
> Looks like there is still race as following:
> 
> blk_quiesce_timeout                          blk_mq_timeout_work
>                                                -> timeout_off = q->timeout_off; //still a false
>   -> q->timeout_off = true;
>   -> del_timer_sync(&q->timeout);
>                                                -> mod_timer
>   -> cancel_work_sync(&q->timeout_work);

No, there isn't such race, the 'mod_timer' doesn't make a difference
because 'q->timeout_off' will be visible in new work func after
cancel_work_sync() returns. So even the timer is expired, work func
still returns immediately.

That means del_timer_sync() isn't absolutely necessary too.

Thanks,
Ming
