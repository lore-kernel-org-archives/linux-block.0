Return-Path: <hare@suse.de>
Subject: Re: [PATCH v2 2/2] blk-mq: Fix a race condition in
 blk_mq_mark_tag_wait()
To: Bart Van Assche <bart.vanassche@wdc.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Omar Sandoval <osandov@fb.com>, Johannes Thumshirn <jthumshirn@suse.de>
References: <20180110193919.6886-1-bart.vanassche@wdc.com>
 <20180110193919.6886-3-bart.vanassche@wdc.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <c796aeee-7e3d-485e-403c-f36ab5254bd0@suse.de>
Date: Thu, 11 Jan 2018 08:39:32 +0100
MIME-Version: 1.0
In-Reply-To: <20180110193919.6886-3-bart.vanassche@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 01/10/2018 08:39 PM, Bart Van Assche wrote:
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
> +
> +		if (on_wait_list)
>  			return false;
> -		}
>  
> -		ws = bt_wait_ptr(&this_hctx->tags->bitmap_tags, this_hctx);
>  		add_wait_queue(&ws->wait, wait);
>  		/*
>  		 * It's possible that a tag was freed in the window between the
I'm actually not that convinced with this change; originally we had been
checking if it's on the wait list, and only _then_ call bt_wait_ptr().
Now we call bt_wait_ptr() always, meaning we run a chance of increasing
the bitmap_tags wait pointer without actually using it.
Looking at the code I'm not sure this is the correct way of using it ...

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
