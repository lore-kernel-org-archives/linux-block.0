Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34498 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751134AbdKFDoj (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 5 Nov 2017 22:44:39 -0500
Date: Mon, 6 Nov 2017 11:44:24 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>, "osandov@fb.com" <osandov@fb.com>,
        "hare@suse.com" <hare@suse.com>
Subject: Re: [PATCH] blk-mq: respect queue dead via blk_mq_quiesce_queue
Message-ID: <20171106034423.GC26416@ming.t460p>
References: <20171105121008.28180-1-ming.lei@redhat.com>
 <1509896328.2697.4.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1509896328.2697.4.camel@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Sun, Nov 05, 2017 at 03:38:49PM +0000, Bart Van Assche wrote:
> On Sun, 2017-11-05 at 20:10 +0800, Ming Lei wrote:
> > diff --git a/block/blk-core.c b/block/blk-core.c
> > index 048be4aa6024..0b121f29e3b1 100644
> > --- a/block/blk-core.c
> > +++ b/block/blk-core.c
> > @@ -658,6 +658,10 @@ void blk_cleanup_queue(struct request_queue *q)
> >  	queue_flag_set(QUEUE_FLAG_DEAD, q);
> >  	spin_unlock_irq(lock);
> >  
> > +	/* respect queue DEAD via quiesce for blk-mq */
> > +	if (q->mq_ops)
> > +		blk_mq_quiesce_queue(q);
> > +
> >  	/* for synchronous bio-based driver finish in-flight integrity i/o */
> >  	blk_flush_integrity();
> 
> Have you considered to change the blk_freeze_queue_start() call in
> blk_set_queue_dying() into a blk_freeze_queue() call? That approach has the
> advantage that no new if (q->mq_ops) test has to be introduced.

That approach isn't nothing to do with this issue, and can't fix this issue
too. Not mention we hold q->sysfs_lock before calling blk_set_queue_dying(),
there may be risk to cause deadlock.

The issue is that there isn't any request in queue(queue is frozen), but
dispatch still may happen, let me explain it a bit:

1) there are several IO submit paths in-progress
2) requests from all these paths are inserted to queue, but may dispatch to
LLD in only one of these paths, but other paths may still move on to dispatch
even all these requests are completed(that means blk_mq_freeze_queue_wait()
returns at that time)
3) the dispatch after queue dead happens and causes the use-after-free,
because we never respect queue dead for blk-mq.

That is exactly what QUEUE_DEAD supposes to protect, and we can let quiesce
respect QUEUE_DEAD perfectly and easily.

> 
> Additionally, the call trace in the description of this patch shows that the
> comment in blk_execute_rq_nowait() is wrong. How about changing that comment
> as follows?
> 
> @@ -57,10 +57,12 @@ void blk_execute_rq_nowait(struct request_queue *q, struct gendisk *bd_disk,
>  	rq->end_io = done;
>  
>  	/*
> -	 * don't check dying flag for MQ because the request won't
> -	 * be reused after dying flag is set
> +	 * blk_freeze_queue() must be called before transitioning a queue
> +	 * into the "dead" state to guarantee that blk_execute_rq_nowait()
> +	 * won't attempt to queue a request on a "dead" blk-mq queue.

blk_freeze_queue() can't cover queue dead as I explained above, and it
returns just when there is no request in queue, but dispatch may be in-progress.

>  	 */
>  	if (q->mq_ops) {
> +		WARN_ON_ONCE(blk_queue_dead(q));
>  		blk_mq_sched_insert_request(rq, at_head, true, false, false);
>  		return;
>  	}

No, this WARN_ON() can never be triggered, because the request isn't
completed yet.

-- 
Ming
