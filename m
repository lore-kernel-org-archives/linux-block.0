Return-Path: <BATV+942a091854393eb11ca5+4852+infradead.org+hch@bombadil.srs.infradead.org>
Date: Mon, 5 Dec 2016 05:07:52 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@fb.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, paolo.valente@linaro.org
Subject: Re: [PATCH 3/7] block: use appropriate queue running functions
Message-ID: <20161205130752.GC7100@infradead.org>
References: <1480734921-23701-1-git-send-email-axboe@fb.com>
 <1480734921-23701-4-git-send-email-axboe@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1480734921-23701-4-git-send-email-axboe@fb.com>
List-ID: <linux-block@vger.kernel.org>

On Fri, Dec 02, 2016 at 08:15:17PM -0700, Jens Axboe wrote:
> Use MQ variants for MQ, legacy ones for legacy.
> 
> Signed-off-by: Jens Axboe <axboe@fb.com>
> ---
>  block/blk-core.c  |  5 ++++-
>  block/blk-exec.c  | 10 ++++++++--
>  block/blk-flush.c | 14 ++++++++++----
>  block/elevator.c  |  5 ++++-
>  4 files changed, 26 insertions(+), 8 deletions(-)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 0e23589ab3bf..3591f5419509 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -340,7 +340,10 @@ void __blk_run_queue(struct request_queue *q)
>  	if (unlikely(blk_queue_stopped(q)))
>  		return;
>  
> -	__blk_run_queue_uncond(q);
> +	if (WARN_ON_ONCE(q->mq_ops))
> +		blk_mq_run_hw_queues(q, true);
> +	else

This looks odd with the WARN_ON..

> +++ b/block/blk-exec.c
> @@ -80,8 +80,14 @@ void blk_execute_rq_nowait(struct request_queue *q, struct gendisk *bd_disk,
>  	}
>  
>  	__elv_add_request(q, rq, where);
> -	__blk_run_queue(q);
> -	spin_unlock_irq(q->queue_lock);
> +
> +	if (q->mq_ops) {
> +		spin_unlock_irq(q->queue_lock);
> +		blk_mq_run_hw_queues(q, false);
> +	} else {
> +		__blk_run_queue(q);
> +		spin_unlock_irq(q->queue_lock);
> +	}

We already branch out to the blk-mq path earlier in the function.
