Return-Path: <ming.lei@redhat.com>
Date: Wed, 20 Sep 2017 10:37:40 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
	Bart Van Assche <bart.vanassche@sandisk.com>,
	Laurence Oberman <loberman@redhat.com>,
	Paolo Valente <paolo.valente@linaro.org>,
	Mel Gorman <mgorman@techsingularity.net>
Subject: Re: [PATCH V4 05/14] blk-mq-sched: improve dispatching from sw queue
Message-ID: <20170920023739.GC23062@ming.t460p>
References: <20170902151729.6162-1-ming.lei@redhat.com>
 <20170902151729.6162-6-ming.lei@redhat.com>
 <937c6abf-8438-5e04-76a6-8485eb8be141@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <937c6abf-8438-5e04-76a6-8485eb8be141@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

Hi Jens,

Thanks for your comment!

On Tue, Sep 19, 2017 at 02:37:50PM -0600, Jens Axboe wrote:
> On 09/02/2017 09:17 AM, Ming Lei wrote:
> > @@ -142,18 +178,31 @@ void blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx)
> >  	if (!list_empty(&rq_list)) {
> >  		blk_mq_sched_mark_restart_hctx(hctx);
> >  		do_sched_dispatch = blk_mq_dispatch_rq_list(q, &rq_list);
> > -	} else if (!has_sched_dispatch) {
> > +	} else if (!has_sched_dispatch && !q->queue_depth) {
> > +		/*
> > +		 * If there is no per-request_queue depth, we
> > +		 * flush all requests in this hw queue, otherwise
> > +		 * pick up request one by one from sw queue for
> > +		 * avoiding to mess up I/O merge when dispatch
> > +		 * is busy, which can be triggered easily by
> > +		 * per-request_queue queue depth
> > +		 */
> >  		blk_mq_flush_busy_ctxs(hctx, &rq_list);
> >  		blk_mq_dispatch_rq_list(q, &rq_list);
> >  	}
> 
> I don't like this part at all. It's a heuristic, and on top of that,

Yeah, it is a heuristic for improving SCSI-MQ's performance.

> it's a heuristic based on a weak assumption that if q->queue_depth == 0,

Only SCSI sets q->queue_depth, which means all hw queues share
the global queue depth of q->queue_depth, once the total number
of in-flight requests from all hctx is bigger than q->queue_depth,
the queue will becomes BUSY.

> then we never run into BUSY constraints. I think that would be stronger
> if it was based on "is this using shared tags", but even that is not

IMO, it isn't related with shared tags, for example, SATA's
performance can be affected by SCSI_MQ, which has single tags.

The root cause is that limits of q->queue_depth and SCSI's
.cmd_per_lun inside SCSI, which will cause device to return
BLK_STS_RESOURCE because IO scheduler queue depth is usually
bigger than q->queue_depth, and it can be quite worse especially
in case of shared tags.

> great at all. It's perfectly possible to have a shared tags setup and
> never run into resource constraints. The opposite condition is also true

As I explained, it isn't related with shared tags, either shared tags
or single tags may run into resource constraints, SCSI has both
shared/single tags cases, and all have this issue if q->queue_depth
set.

> - you can run without shared tags, and yet hit resource constraints
> constantly. Hence this is NOT a good test for deciding whether to flush
> everything at once or not. In short, I think a much better test case
> would be "has this device ever returned BLK_STS_RESOURCE. As it so
> happens, that's easy enough to keep track of and base this test on.

OK, looks we can try to flush all first, and switch to pick one by
one if device ever returned BLK_STS_RESOURCE. Are you fine with
this way? Or better suggestion?

> 
> Additionally, this further differentiates dispatch cases. I'd much
> rather just have one sane dispatch case. I realize we are balancing
> between performance/scalability and practical cases like merging here,
> but it should not be impossible to do.

Yeah, I agree, but both flush_all and pick one by one aren't invented
by this patch, :-)

-- 
Ming
