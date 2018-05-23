Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH V2] blk-mq: avoid to starve tag allocation after
 allocation process migrates
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, Omar Sandoval <osandov@fb.com>
References: <20180519074406.6045-1-ming.lei@redhat.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <7a4499e8-60bb-892a-91cf-f2d2c4be74b7@kernel.dk>
Date: Tue, 22 May 2018 21:59:17 -0600
MIME-Version: 1.0
In-Reply-To: <20180519074406.6045-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 5/19/18 1:44 AM, Ming Lei wrote:
> When the allocation process is scheduled back and the mapped hw queue is
> changed, do one extra wake up on orignal queue for compensating wake up
> miss, so other allocations on the orignal queue won't be starved.
> 
> This patch fixes one request allocation hang issue, which can be
> triggered easily in case of very low nr_request.

Trying to think of better ways we can fix this, but I don't see
any right now. Getting rid of the wake_up_nr() kills us on tons
of tasks waiting. Maybe it might be possible to only go through
the fake wakeup IFF we have a task waiting on the list, that'd
spare us the atomic dec and cmpxchg for all cases except if we
have a task (or more) waiting on the existing wait state.

> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
> index 336dde07b230..77607f89d205 100644
> --- a/block/blk-mq-tag.c
> +++ b/block/blk-mq-tag.c
> @@ -134,6 +134,8 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
>  	ws = bt_wait_ptr(bt, data->hctx);
>  	drop_ctx = data->ctx == NULL;
>  	do {
> +		struct sbitmap_queue *bt_orig;

This should be called 'bt_prev'.

> diff --git a/include/linux/sbitmap.h b/include/linux/sbitmap.h
> index 841585f6e5f2..b23f50355281 100644
> --- a/include/linux/sbitmap.h
> +++ b/include/linux/sbitmap.h
> @@ -484,6 +484,13 @@ static inline struct sbq_wait_state *sbq_wait_ptr(struct sbitmap_queue *sbq,
>  void sbitmap_queue_wake_all(struct sbitmap_queue *sbq);
>  
>  /**
> + * sbitmap_wake_up() - Do a regular wake up compensation if the queue
> + * allocated from is changed after scheduling back.
> + * @sbq: Bitmap queue to wake up.
> + */
> +void sbitmap_queue_wake_up(struct sbitmap_queue *sbq);

The blk-mq issue is bleeding into sbitmap here. This should just detail
that this issues a wakeup, similar to how freeing a tag would

-- 
Jens Axboe
