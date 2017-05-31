Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37520 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751100AbdEaCzq (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 May 2017 22:55:46 -0400
Date: Wed, 31 May 2017 10:55:33 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <Bart.VanAssche@sandisk.com>
Cc: "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>
Subject: Re: [PATCH v2 6/8] blk-mq: don't stop queue for quiescing
Message-ID: <20170531025532.GE12220@ming.t460p>
References: <20170527142126.26079-1-ming.lei@redhat.com>
 <20170527142126.26079-7-ming.lei@redhat.com>
 <1495921766.13651.4.camel@sandisk.com>
 <20170528105047.GC6488@ming.t460p>
 <1495987400.2849.3.camel@sandisk.com>
 <20170530002703.GB29253@ming.t460p>
 <1496163742.2627.11.camel@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1496163742.2627.11.camel@sandisk.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, May 30, 2017 at 05:02:23PM +0000, Bart Van Assche wrote:
> On Tue, 2017-05-30 at 08:27 +0800, Ming Lei wrote:
> > On Sun, May 28, 2017 at 04:03:20PM +0000, Bart Van Assche wrote:
> > > On Sun, 2017-05-28 at 18:50 +0800, Ming Lei wrote:
> > > > On Sat, May 27, 2017 at 09:49:27PM +0000, Bart Van Assche wrote:
> > > > > On Sat, 2017-05-27 at 22:21 +0800, Ming Lei wrote:
> > > > > > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > > > > > index 032045841856..84cce67caee3 100644
> > > > > > --- a/block/blk-mq.c
> > > > > > +++ b/block/blk-mq.c
> > > > > > @@ -168,8 +168,6 @@ void blk_mq_quiesce_queue(struct request_queue *q)
> > > > > >  	unsigned int i;
> > > > > >  	bool rcu = false;
> > > > > >  
> > > > > > -	__blk_mq_stop_hw_queues(q, true);
> > > > > > -
> > > > > >  	spin_lock_irq(q->queue_lock);
> > > > > >  	queue_flag_set(QUEUE_FLAG_QUIESCED, q);
> > > > > >  	spin_unlock_irq(q->queue_lock);
> > > > > > @@ -198,7 +196,12 @@ void blk_mq_unquiesce_queue(struct request_queue *q)
> > > > > >  	queue_flag_clear(QUEUE_FLAG_QUIESCED, q);
> > > > > >  	spin_unlock_irq(q->queue_lock);
> > > > > >  
> > > > > > -	blk_mq_start_stopped_hw_queues(q, true);
> > > > > > +	/*
> > > > > > +	 * During quiescing, requests can be inserted
> > > > > > +	 * to scheduler's queue or sw queue, so we run
> > > > > > +	 * queues for dispatching these requests.
> > > > > > +	 */
> > > > > > +	blk_mq_start_hw_queues(q);
> > > > > >  }
> > > > > >  EXPORT_SYMBOL_GPL(blk_mq_unquiesce_queue);
> > > > > 
> > > > > This looks really weird to me. If blk_mq_quiesce_queue() doesn't stop any
> > > > > hardware queues, why should blk_mq_unquiesce_queue() start any hardware
> > > > > queues?
> > > > 
> > > > Please see the above comment, especially in direct issue path, we have to
> > > > insert the request into sw/scheduler queue when queue is quiesced,
> > > > and these queued requests have to be dispatched out during unquiescing.
> > > > 
> > > > I considered to sleep the current context under this situation, but
> > > > turns out it is more complicated to handle, given we have very limited
> > > > queue depth, just let applications consumes all, then wait.
> > > 
> > > Hello Ming,
> > > 
> > > The above seems to me to be an argument to *run* the queue from inside
> > > blk_mq_unquiesce_queue() instead of *starting* stopped queues from inside
> > > that function.
> > 
> > Yes, it is run queues, as you can see in my comment.
> > 
> > The reality is that we can't run queue without clearing the STOPPED state.
> 
> Hello Ming,
> 
> I think it's completely wrong to make blk_mq_unquiesce_queue() to clear the
> STOPPED state. Stopping a queue is typically used to tell the block layer to
> stop dispatching requests and not to resume dispatching requests until the
> STOPPED flag is cleared. If stopping and quiescing a queue happen
> simultaneously then dispatching should not occur before both
> blk_mq_unquiesce_queue() and blk_mq_start_hw_queue() have been called. Your
> patch would make dispatching start too early.

Yes, I thought of it too, now we need to sleep the context of direct issue,
then restart in blk_mq_unquiesce_queue() can be avoided.


Thanks,
Ming
