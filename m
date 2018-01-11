Return-Path: <osandov@osandov.com>
Return-Path: <osandov@osandov.com>
Date: Thu, 11 Jan 2018 10:21:32 -0800
From: Omar Sandoval <osandov@osandov.com>
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Omar Sandoval <osandov@fb.com>,
	Hannes Reinecke <hare@suse.de>,
	Johannes Thumshirn <jthumshirn@suse.de>
Subject: Re: [PATCH v2 2/2] blk-mq: Fix a race condition in
 blk_mq_mark_tag_wait()
Message-ID: <20180111182132.GA23481@vader.DHCP.thefacebook.com>
References: <20180110193919.6886-1-bart.vanassche@wdc.com>
 <20180110193919.6886-3-bart.vanassche@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180110193919.6886-3-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Wed, Jan 10, 2018 at 11:39:19AM -0800, Bart Van Assche wrote:
> Both add_wait_queue() and blk_mq_dispatch_wake() protect wait queue
> manipulations with the wait queue lock. Hence also protect the
> !list_empty(&wait->entry) test with the wait queue lock instead of
> the hctx lock.
> 
> Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Omar Sandoval <osandov@fb.com>
> Cc: Hannes Reinecke <hare@suse.de>
> Cc: Johannes Thumshirn <jthumshirn@suse.de>
> ---
>  block/blk-mq.c | 19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index e770e8814f60..d5313ce60836 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1184,7 +1184,7 @@ static bool blk_mq_mark_tag_wait(struct blk_mq_hw_ctx **hctx,
>  	bool shared_tags = (this_hctx->flags & BLK_MQ_F_TAG_SHARED) != 0;
>  	struct sbq_wait_state *ws;
>  	wait_queue_entry_t *wait;
> -	bool ret;
> +	bool on_wait_list, ret;
>  
>  	if (!shared_tags) {
>  		if (!test_bit(BLK_MQ_S_SCHED_RESTART, &this_hctx->state))
> @@ -1204,13 +1204,15 @@ static bool blk_mq_mark_tag_wait(struct blk_mq_hw_ctx **hctx,
>  		if (!list_empty_careful(&wait->entry))
>  			return false;
>  
> -		spin_lock(&this_hctx->lock);
> -		if (!list_empty(&wait->entry)) {
> -			spin_unlock(&this_hctx->lock);
> +		ws = bt_wait_ptr(&this_hctx->tags->bitmap_tags, this_hctx);
> +
> +		spin_lock_irq(&ws->wait.lock);
> +		on_wait_list = !list_empty(&wait->entry);
> +		spin_unlock_irq(&ws->wait.lock);

This isn't quite right. There's no guarantee that the struct
sbq_wait_state returned by bt_wait_ptr() is the same one that the wait
entry is on, so the lock on the returned ws->wait isn't necessarily
protecting the wait entry. I think we should just be using
list_empty_careful() in this case.

> +
> +		if (on_wait_list)
>  			return false;
> -		}
>  
> -		ws = bt_wait_ptr(&this_hctx->tags->bitmap_tags, this_hctx);
>  		add_wait_queue(&ws->wait, wait);
>  		/*
>  		 * It's possible that a tag was freed in the window between the
> @@ -1218,10 +1220,8 @@ static bool blk_mq_mark_tag_wait(struct blk_mq_hw_ctx **hctx,
>  		 * queue.
>  		 */
>  		ret = blk_mq_get_driver_tag(rq, hctx, false);
> -		if (!ret) {
> -			spin_unlock(&this_hctx->lock);
> +		if (!ret)
>  			return false;
> -		}
>  
>  		/*
>  		 * We got a tag, remove ourselves from the wait queue to ensure
> @@ -1230,7 +1230,6 @@ static bool blk_mq_mark_tag_wait(struct blk_mq_hw_ctx **hctx,
>  		spin_lock_irq(&ws->wait.lock);
>  		list_del_init(&wait->entry);
>  		spin_unlock_irq(&ws->wait.lock);
> -		spin_unlock(&this_hctx->lock);
>  	}
>  	return ret;
>  }
> -- 
> 2.15.1
> 
