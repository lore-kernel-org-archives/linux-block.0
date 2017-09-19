Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH V4 05/14] blk-mq-sched: improve dispatching from sw queue
To: Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
 Christoph Hellwig <hch@infradead.org>
Cc: Bart Van Assche <bart.vanassche@sandisk.com>,
 Laurence Oberman <loberman@redhat.com>,
 Paolo Valente <paolo.valente@linaro.org>,
 Mel Gorman <mgorman@techsingularity.net>
References: <20170902151729.6162-1-ming.lei@redhat.com>
 <20170902151729.6162-6-ming.lei@redhat.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <937c6abf-8438-5e04-76a6-8485eb8be141@kernel.dk>
Date: Tue, 19 Sep 2017 14:37:50 -0600
MIME-Version: 1.0
In-Reply-To: <20170902151729.6162-6-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 09/02/2017 09:17 AM, Ming Lei wrote:
> @@ -142,18 +178,31 @@ void blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx)
>  	if (!list_empty(&rq_list)) {
>  		blk_mq_sched_mark_restart_hctx(hctx);
>  		do_sched_dispatch = blk_mq_dispatch_rq_list(q, &rq_list);
> -	} else if (!has_sched_dispatch) {
> +	} else if (!has_sched_dispatch && !q->queue_depth) {
> +		/*
> +		 * If there is no per-request_queue depth, we
> +		 * flush all requests in this hw queue, otherwise
> +		 * pick up request one by one from sw queue for
> +		 * avoiding to mess up I/O merge when dispatch
> +		 * is busy, which can be triggered easily by
> +		 * per-request_queue queue depth
> +		 */
>  		blk_mq_flush_busy_ctxs(hctx, &rq_list);
>  		blk_mq_dispatch_rq_list(q, &rq_list);
>  	}

I don't like this part at all. It's a heuristic, and on top of that,
it's a heuristic based on a weak assumption that if q->queue_depth == 0,
then we never run into BUSY constraints. I think that would be stronger
if it was based on "is this using shared tags", but even that is not
great at all. It's perfectly possible to have a shared tags setup and
never run into resource constraints. The opposite condition is also true
- you can run without shared tags, and yet hit resource constraints
constantly. Hence this is NOT a good test for deciding whether to flush
everything at once or not. In short, I think a much better test case
would be "has this device ever returned BLK_STS_RESOURCE. As it so
happens, that's easy enough to keep track of and base this test on.

Additionally, this further differentiates dispatch cases. I'd much
rather just have one sane dispatch case. I realize we are balancing
between performance/scalability and practical cases like merging here,
but it should not be impossible to do.

-- 
Jens Axboe
