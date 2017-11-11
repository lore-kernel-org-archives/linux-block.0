Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49132 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751058AbdKKCUC (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 10 Nov 2017 21:20:02 -0500
Date: Sat, 11 Nov 2017 10:19:48 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>, "osandov@fb.com" <osandov@fb.com>,
        "hare@suse.com" <hare@suse.com>
Subject: Re: [PATCH] blk-mq: respect queue dead via blk_mq_quiesce_queue
Message-ID: <20171111021942.GA20382@ming.t460p>
References: <20171105121008.28180-1-ming.lei@redhat.com>
 <1509896328.2697.4.camel@wdc.com>
 <1510331434.2905.2.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1510331434.2905.2.camel@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Nov 10, 2017 at 04:30:35PM +0000, Bart Van Assche wrote:
> On Sun, 2017-11-05 at 15:38 +0000, Bart Van Assche wrote:
> > On Sun, 2017-11-05 at 20:10 +0800, Ming Lei wrote:
> > > diff --git a/block/blk-core.c b/block/blk-core.c
> > > index 048be4aa6024..0b121f29e3b1 100644
> > > --- a/block/blk-core.c
> > > +++ b/block/blk-core.c
> > > @@ -658,6 +658,10 @@ void blk_cleanup_queue(struct request_queue *q)
> > >  	queue_flag_set(QUEUE_FLAG_DEAD, q);
> > >  	spin_unlock_irq(lock);
> > >  
> > > +	/* respect queue DEAD via quiesce for blk-mq */
> > > +	if (q->mq_ops)
> > > +		blk_mq_quiesce_queue(q);
> > > +
> > >  	/* for synchronous bio-based driver finish in-flight integrity i/o */
> > >  	blk_flush_integrity();
> > 
> > Have you considered to change the blk_freeze_queue_start() call in
> > blk_set_queue_dying() into a blk_freeze_queue() call? That approach has the
> > advantage that no new if (q->mq_ops) test has to be introduced.
> 
> There is an additional reason why I think it would be better to make
> blk_set_queue_dying() wait until requests that are in progress have finished.
> Some block drivers, e.g. the mtip driver, start cleaning up resources
> immediately after blk_set_queue_dying() has returned. So making
> blk_set_queue_dying() wait would fix a race condition in at least the mtip
> driver.

Looks you don't explain how your approach fixes this issue.

IMO, your may can't fix this issue.

1) the core idea:
when blk_freeze_queue() returns, there is still in-progress dispatch or
we can call it in-progress io submission; So once blk_freeze_queue() returns,
blk_cleanup_queue() will go ahead, and the in-progress dispatch may trigger
use-after-free, even corrupt memory.

For detailed reason, please see:

	https://marc.info/?l=linux-block&m=150993988115872&w=2

2) suppose you replace blk_freeze_queue_start() with blk_freeze_queue()
in blk_set_queue_dying(), that changes nothing about this issue.

You may think the blk_freeze_queue() called in blk_cleanup_queue() implies
synchronize_rcu(), which may drain up the in-progress dispatch. But the
in-progress dispatch(io submission) may not enter rcu read critical area yet
at that time, for example, in one IO submission path, the request is just
added to scheduler queue, and this request is exactly dispatched to LLD via
other run queue and completed before the actual run queue from the current
io submission. So the implied synchronize_rcu() won't help this case at all.

Or do I miss your idea?

-- 
Ming
