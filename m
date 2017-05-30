Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57822 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751007AbdE3AWt (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 29 May 2017 20:22:49 -0400
Date: Tue, 30 May 2017 08:22:35 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <Bart.VanAssche@sandisk.com>
Cc: "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>
Subject: Re: [PATCH v2 4/8] blk-mq: fix blk_mq_quiesce_queue
Message-ID: <20170530002227.GA29253@ming.t460p>
References: <20170527142126.26079-1-ming.lei@redhat.com>
 <20170527142126.26079-5-ming.lei@redhat.com>
 <1495921605.13651.2.camel@sandisk.com>
 <20170528104400.GB6488@ming.t460p>
 <1495987808.2849.5.camel@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1495987808.2849.5.camel@sandisk.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Sun, May 28, 2017 at 04:10:09PM +0000, Bart Van Assche wrote:
> On Sun, 2017-05-28 at 18:44 +0800, Ming Lei wrote:
> > On Sat, May 27, 2017 at 09:46:45PM +0000, Bart Van Assche wrote:
> > > On Sat, 2017-05-27 at 22:21 +0800, Ming Lei wrote:
> > > >  bool blk_mq_can_queue(struct blk_mq_hw_ctx *hctx)
> > > > @@ -1108,13 +1119,15 @@ static void __blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx)
> > > >  
> > > >  	if (!(hctx->flags & BLK_MQ_F_BLOCKING)) {
> > > >  		rcu_read_lock();
> > > > -		blk_mq_sched_dispatch_requests(hctx);
> > > > +		if (!blk_queue_quiesced(hctx->queue))
> > > > +			blk_mq_sched_dispatch_requests(hctx);
> > > >  		rcu_read_unlock();
> > > >  	} else {
> > > >  		might_sleep();
> > > >  
> > > >  		srcu_idx = srcu_read_lock(&hctx->queue_rq_srcu);
> > > > -		blk_mq_sched_dispatch_requests(hctx);
> > > > +		if (!blk_queue_quiesced(hctx->queue))
> > > > +			blk_mq_sched_dispatch_requests(hctx);
> > > >  		srcu_read_unlock(&hctx->queue_rq_srcu, srcu_idx);
> > > >  	}
> > > >  }
> > > 
> > > Sorry but I don't like these changes. Why have the blk_queue_quiesced()
> > > calls be added at other code locations than the blk_mq_hctx_stopped() calls?
> > > This will make the block layer unnecessary hard to maintain. Please consider
> > > to change the blk_mq_hctx_stopped(hctx) calls in blk_mq_sched_dispatch_requests()
> > > and *blk_mq_*run_hw_queue*() into blk_mq_hctx_stopped(hctx) || blk_queue_quiesced(q).
> > 
> > One benefit is that we make it explicit that the flag has to be checked
> > inside the RCU read-side critical sections. If you put it somewhere,
> > someone may put it out of read-side critical sections in future.
> 
> Hello Ming,
> 
> I really would like to see the blk_queue_quiesced() tests as close as possible to
> the blk_mq_hctx_stopped() tests. But I agree that we need a way to document and/or

Could you explain why we have to do that? And checking on stopped state
doesn't need to hold RCU/SRCU read lock, and that two states are really
different.

> verify that these tests occur with an RCU read-side lock held. Have you considered
> to use rcu_read_lock_held() to document this?

Then we need to check if it is RCU or SRCU, and make code ugly as
current check on BLOCKING.

Thanks,
Ming
