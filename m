Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33194 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751062AbdE1KoK (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 28 May 2017 06:44:10 -0400
Date: Sun, 28 May 2017 18:44:01 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <Bart.VanAssche@sandisk.com>
Cc: "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>
Subject: Re: [PATCH v2 4/8] blk-mq: fix blk_mq_quiesce_queue
Message-ID: <20170528104400.GB6488@ming.t460p>
References: <20170527142126.26079-1-ming.lei@redhat.com>
 <20170527142126.26079-5-ming.lei@redhat.com>
 <1495921605.13651.2.camel@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1495921605.13651.2.camel@sandisk.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


On Sat, May 27, 2017 at 09:46:45PM +0000, Bart Van Assche wrote:
> On Sat, 2017-05-27 at 22:21 +0800, Ming Lei wrote:
> > It is required that no dispatch can happen any more once
> > blk_mq_quiesce_queue() returns, and we don't have such requirement
> > on APIs of stopping queue.
> > 
> > But blk_mq_quiesce_queue() still may not block/drain dispatch in the
> > following cases:
> > 
> > - direct issue or BLK_MQ_S_START_ON_RUN
> > - in theory, new RCU read-side critical sections may begin while
> > synchronize_rcu() was waiting, and end after synchronize_rcu()
> > returns, during the period dispatch still may happen
> 
> Hello Ming,

Hello Bart,

> 
> I think the title and the description of this patch are wrong. Since
> the current queue quiescing mechanism works fine for drivers that do
> not stop and restart a queue (e.g. SCSI and dm-core), please change the

I have provided the issues in current quiesce mechanism, now I post it again:

	But blk_mq_quiesce_queue() still may not block/drain dispatch in the
	following cases:
	
	- direct issue or BLK_MQ_S_START_ON_RUN
	- in theory, new RCU read-side critical sections may begin while
	synchronize_rcu() was waiting, and end after synchronize_rcu()
	returns, during the period dispatch still may happen

Not like stopping queue, any dispatching has to be drained/blocked
when the synchronize_rcu() returns, otherwise double free or
use-after-free can be triggered, which has been observed on NVMe
already.

> title and description to reflect that the purpose of this patch is
> to allow drivers that use the quiesce mechanism to restart a queue
> without unquiescing it.

First it is really a fix, and then a improvement, so could you tell me
where is wrong with the title and the description?

> 
> > @@ -209,6 +217,9 @@ void blk_mq_wake_waiters(struct request_queue *q)
> >  	 * the queue are notified as well.
> >  	 */
> >  	wake_up_all(&q->mq_freeze_wq);
> > +
> > +	/* Forcibly unquiesce the queue to avoid having stuck requests */
> > +	blk_mq_unquiesce_queue(q);
> >  }
> 
> Should the block layer unquiesce a queue if a block driver hasn't 
> done that before queue removal starts or should the block driver
> itself do that?

Some drivers might quiesce a queue and not unquiesce it, such as
NVMe.

OK, I will consider to fix drivers first.

> The block layer doesn't restart stopped queues from
> inside blk_set_queue_dying() so why should it unquiesce a quiesced
> queue?

If the quiesced queue isn't unquiesced, it may cause I/O hang, since
any I/O in sw queue/scheduler queue can't be completed at all.

OK, will fix driver in next post.

Actually the queue has to be started after blk_set_queue_dying(),
otherwise it can cause I/O hang too, and there can be lots of
writeback I/O in the following del_gendisk(). We have done it
in NVMe already, see nvme_kill_queues().

Maybe in future, we should consider to do that all in block layer.

>  
> >  bool blk_mq_can_queue(struct blk_mq_hw_ctx *hctx)
> > @@ -1108,13 +1119,15 @@ static void __blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx)
> >  
> >  	if (!(hctx->flags & BLK_MQ_F_BLOCKING)) {
> >  		rcu_read_lock();
> > -		blk_mq_sched_dispatch_requests(hctx);
> > +		if (!blk_queue_quiesced(hctx->queue))
> > +			blk_mq_sched_dispatch_requests(hctx);
> >  		rcu_read_unlock();
> >  	} else {
> >  		might_sleep();
> >  
> >  		srcu_idx = srcu_read_lock(&hctx->queue_rq_srcu);
> > -		blk_mq_sched_dispatch_requests(hctx);
> > +		if (!blk_queue_quiesced(hctx->queue))
> > +			blk_mq_sched_dispatch_requests(hctx);
> >  		srcu_read_unlock(&hctx->queue_rq_srcu, srcu_idx);
> >  	}
> >  }
> 
> Sorry but I don't like these changes. Why have the blk_queue_quiesced()
> calls be added at other code locations than the blk_mq_hctx_stopped() calls?
> This will make the block layer unnecessary hard to maintain. Please consider
> to change the blk_mq_hctx_stopped(hctx) calls in blk_mq_sched_dispatch_requests()
> and *blk_mq_*run_hw_queue*() into blk_mq_hctx_stopped(hctx) || blk_queue_quiesced(q).

One benefit is that we make it explicit that the flag has to be checked
inside the RCU read-side critical sections. If you put it somewhere,
someone may put it out of read-side critical sections in future.


Thanks,
Ming
