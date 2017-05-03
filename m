Return-Path: <axboe@kernel.dk>
Date: Wed, 3 May 2017 14:14:45 -0600
From: Jens Axboe <axboe@kernel.dk>
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org,
	Bart Van Assche <bart.vanassche@sandisk.com>,
	Omar Sandoval <osandov@fb.com>
Subject: Re: [PATCH V2 4/5] blk-mq: use hw tag for scheduling if hw tag space
 is big enough
Message-ID: <20170503201444.GA29177@kernel.dk>
References: <20170503195839.6539-1-ming.lei@redhat.com>
 <20170503195839.6539-5-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170503195839.6539-5-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

On Thu, May 04 2017, Ming Lei wrote:
> diff --git a/block/blk-mq-sched.h b/block/blk-mq-sched.h
> index edafb5383b7b..241d23c18181 100644
> --- a/block/blk-mq-sched.h
> +++ b/block/blk-mq-sched.h
> @@ -129,4 +136,19 @@ static inline bool blk_mq_sched_needs_restart(struct blk_mq_hw_ctx *hctx)
>  	return test_bit(BLK_MQ_S_SCHED_RESTART, &hctx->state);
>  }
>  
> +/*
> + * If this queue has enough hardware tags and doesn't share tags with
> + * other queues, just use hw tag directly for scheduling.
> + */
> +static inline bool blk_mq_sched_may_use_hw_tag(struct request_queue *q)
> +{
> +	if (q->tag_set->flags & BLK_MQ_F_TAG_SHARED)
> +		return false;
> +
> +	if (blk_mq_get_queue_depth(q) < q->nr_requests)
> +		return false;
> +
> +	return true;
> +}
> +

Let's put that in block/blk-mq-sched.c instead, especially since it
grows more code in the next patch.

-- 
Jens Axboe
