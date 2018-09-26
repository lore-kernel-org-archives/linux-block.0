Return-Path: <jianchao.w.wang@oracle.com>
Subject: Re: [PATCHv2] blk-mq: Allow blocking queue tag iter callbacks
To: Keith Busch <keith.busch@intel.com>,
        Linux Block <linux-block@vger.kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Bart Van Assche <bart.vanassche@gmail.com>
References: <20180925163620.11911-1-keith.busch@intel.com>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <023b9610-e7ae-0f0f-bbf1-6745d1dfd148@oracle.com>
Date: Wed, 26 Sep 2018 10:15:24 +0800
MIME-Version: 1.0
In-Reply-To: <20180925163620.11911-1-keith.busch@intel.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Keith

On 09/26/2018 12:36 AM, Keith Busch wrote:
> A recent commit runs tag iterator callbacks under the rcu read lock,
> but existing callbacks do not satisfy the non-blocking requirement.
> The commit intended to prevent an iterator from accessing a queue that's
> being modified. This patch fixes the original issue by taking a queue
> reference instead of reading it, which allows callbacks to make blocking
> calls.
> 
> Fixes: f5bbbbe4d6357 ("blk-mq: sync the update nr_hw_queues with blk_mq_queue_tag_busy_iter")
> Cc: Jianchao Wang <jianchao.w.wang@oracle.com>
> Signed-off-by: Keith Busch <keith.busch@intel.com>
> ---
> v1 -> v2:
> 
>   Leave the iterator interface as-is, making this change transparent
>   to the callers. This will increment the queue usage counter in the
>   timeout path twice, which is harmless.
> 

This is OK to me.
Acked-by: Jianchao Wang <jianchao.w.wang@oracle.com>

>   Changelog.
> 
>  block/blk-mq-tag.c | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
> 
> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
> index 94e1ed667b6e..41317c50a446 100644
> --- a/block/blk-mq-tag.c
> +++ b/block/blk-mq-tag.c
> @@ -322,16 +322,11 @@ void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_iter_fn *fn,
>  
>  	/*
>  	 * __blk_mq_update_nr_hw_queues will update the nr_hw_queues and
> -	 * queue_hw_ctx after freeze the queue. So we could use q_usage_counter
> -	 * to avoid race with it. __blk_mq_update_nr_hw_queues will users
> -	 * synchronize_rcu to ensure all of the users go out of the critical
> -	 * section below and see zeroed q_usage_counter.
> +	 * queue_hw_ctx after freeze the queue, so we use q_usage_counter
> +	 * to avoid race with it.
>  	 */
> -	rcu_read_lock();
> -	if (percpu_ref_is_zero(&q->q_usage_counter)) {
> -		rcu_read_unlock();
> +	if (!percpu_ref_tryget(&q->q_usage_counter))
>  		return;
> -	}
>  
>  	queue_for_each_hw_ctx(q, hctx, i) {
>  		struct blk_mq_tags *tags = hctx->tags;
> @@ -347,7 +342,7 @@ void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_iter_fn *fn,
>  			bt_for_each(hctx, &tags->breserved_tags, fn, priv, true);
>  		bt_for_each(hctx, &tags->bitmap_tags, fn, priv, false);
>  	}
> -	rcu_read_unlock();
> +	blk_queue_exit(q);
>  }
>  
>  static int bt_alloc(struct sbitmap_queue *bt, unsigned int depth,
> 
