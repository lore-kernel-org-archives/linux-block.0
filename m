Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42436 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750984AbdE1Kuz (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 28 May 2017 06:50:55 -0400
Date: Sun, 28 May 2017 18:50:47 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <Bart.VanAssche@sandisk.com>
Cc: "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>
Subject: Re: [PATCH v2 6/8] blk-mq: don't stop queue for quiescing
Message-ID: <20170528105047.GC6488@ming.t460p>
References: <20170527142126.26079-1-ming.lei@redhat.com>
 <20170527142126.26079-7-ming.lei@redhat.com>
 <1495921766.13651.4.camel@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1495921766.13651.4.camel@sandisk.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Sat, May 27, 2017 at 09:49:27PM +0000, Bart Van Assche wrote:
> On Sat, 2017-05-27 at 22:21 +0800, Ming Lei wrote:
> > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > index 032045841856..84cce67caee3 100644
> > --- a/block/blk-mq.c
> > +++ b/block/blk-mq.c
> > @@ -168,8 +168,6 @@ void blk_mq_quiesce_queue(struct request_queue *q)
> >  	unsigned int i;
> >  	bool rcu = false;
> >  
> > -	__blk_mq_stop_hw_queues(q, true);
> > -
> >  	spin_lock_irq(q->queue_lock);
> >  	queue_flag_set(QUEUE_FLAG_QUIESCED, q);
> >  	spin_unlock_irq(q->queue_lock);
> > @@ -198,7 +196,12 @@ void blk_mq_unquiesce_queue(struct request_queue *q)
> >  	queue_flag_clear(QUEUE_FLAG_QUIESCED, q);
> >  	spin_unlock_irq(q->queue_lock);
> >  
> > -	blk_mq_start_stopped_hw_queues(q, true);
> > +	/*
> > +	 * During quiescing, requests can be inserted
> > +	 * to scheduler's queue or sw queue, so we run
> > +	 * queues for dispatching these requests.
> > +	 */
> > +	blk_mq_start_hw_queues(q);
> >  }
> >  EXPORT_SYMBOL_GPL(blk_mq_unquiesce_queue);
> 
> Hello Ming,

Hello Bart,

> 
> This looks really weird to me. If blk_mq_quiesce_queue() doesn't stop any
> hardware queues, why should blk_mq_unquiesce_queue() start any hardware
> queues?

Please see the above comment, especially in direct issue path, we have to
insert the request into sw/scheduler queue when queue is quiesced,
and these queued requests have to be dispatched out during unquiescing.

I considered to sleep the current context under this situation, but
turns out it is more complicated to handle, given we have very limited
queue depth, just let applications consumes all, then wait.

Thanks,
Ming
