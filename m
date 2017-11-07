Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38648 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753018AbdKGC1W (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 6 Nov 2017 21:27:22 -0500
Date: Tue, 7 Nov 2017 10:27:11 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "osandov@fb.com" <osandov@fb.com>, "axboe@fb.com" <axboe@fb.com>,
        "hare@suse.com" <hare@suse.com>
Subject: Re: [PATCH] blk-mq: respect queue dead via blk_mq_quiesce_queue
Message-ID: <20171107022710.GD15090@ming.t460p>
References: <20171105121008.28180-1-ming.lei@redhat.com>
 <1509896328.2697.4.camel@wdc.com>
 <20171106034423.GC26416@ming.t460p>
 <1509986060.2409.17.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1509986060.2409.17.camel@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Nov 06, 2017 at 04:34:21PM +0000, Bart Van Assche wrote:
> On Mon, 2017-11-06 at 11:44 +0800, Ming Lei wrote:
> > On Sun, Nov 05, 2017 at 03:38:49PM +0000, Bart Van Assche wrote:
> > > On Sun, 2017-11-05 at 20:10 +0800, Ming Lei wrote:
> > > > diff --git a/block/blk-core.c b/block/blk-core.c
> > > > index 048be4aa6024..0b121f29e3b1 100644
> > > > --- a/block/blk-core.c
> > > > +++ b/block/blk-core.c
> > > > @@ -658,6 +658,10 @@ void blk_cleanup_queue(struct request_queue *q)
> > > >  	queue_flag_set(QUEUE_FLAG_DEAD, q);
> > > >  	spin_unlock_irq(lock);
> > > >  
> > > > +	/* respect queue DEAD via quiesce for blk-mq */
> > > > +	if (q->mq_ops)
> > > > +		blk_mq_quiesce_queue(q);
> > > > +
> > > >  	/* for synchronous bio-based driver finish in-flight integrity i/o */
> > > >  	blk_flush_integrity();
> > > 
> > > Have you considered to change the blk_freeze_queue_start() call in
> > > blk_set_queue_dying() into a blk_freeze_queue() call? That approach has the
> > > advantage that no new if (q->mq_ops) test has to be introduced.
> > 
> > That approach isn't nothing to do with this issue, and can't fix this issue
> > too.
> 
> Sorry but I disagree. My opinion is that the change I proposed is a more
> elegant way to avoid that blk_mq_run_hw_queue() tries to execute a request
> after blk_cleanup_queue() has started.
> 
> > Not mention we hold q->sysfs_lock before calling blk_set_queue_dying(),
> > there may be risk to cause deadlock.
> 
> Sorry but I disagree again. q->sysfs_lock is not obtained from inside any
> code that runs the queue so there is no deadlock risk. Additionally, I doubt
> that it is useful to obtain q->sysfs_lock from inside blk_cleanup_queue().
> The queue attributes that are exported through sysfs can be modified safely
> until these sysfs attributes are removed.
> 
> > The issue is that there isn't any request in queue(queue is frozen), but
> > dispatch still may happen, let me explain it a bit:
> > 
> > 1) there are several IO submit paths in-progress
> > 2) requests from all these paths are inserted to queue, but may dispatch to
> > LLD in only one of these paths, but other paths may still move on to dispatch
> > even all these requests are completed(that means blk_mq_freeze_queue_wait()
> > returns at that time)
> > 3) the dispatch after queue dead happens and causes the use-after-free,
> > because we never respect queue dead for blk-mq.
> 
> After a queue has been marked "dying" and after blk_freeze_queue() has
> returned it is guaranteed that all requests have finished and that all future
> blk_get_request() calls will fail. Hence .queue_rq() won't be called anymore.
> Any code that runs a queue (the __blk_mq_run_hw_queue() / blk_mq_make_request()
> callers) must hold a reference on that queue. Running a queue even after

The reference is released via blk_queue_exit() when the request is freed in
blk_mq_free_request(), but the dispatch may still be in-progress after the request
is freed. I suggest you to take a look at the following words carefully,
and if you think something is wrong, please comment on it directly:

	1) there are several IO submit paths in-progress

	2) requests from all these paths are inserted to queue, but may dispatch to
	LLD in only one of these paths, but other paths may still move on to dispatch
	even all these requests are completed(that means blk_mq_freeze_queue_wait()
	returns at that time)

	3) the dispatch after queue dead happens and causes the use-after-free,
	because we never respect queue dead for blk-mq.

blk_freeze_queue() can make sure that no .queue_rq() can be run, but
can't make sure the other dispatch part(like dequeue, check if there is
work in queue, ...) is finished.

-- 
Ming
