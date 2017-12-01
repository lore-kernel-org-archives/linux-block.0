Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 2/7] block: Document more locking requirements
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Hannes Reinecke <hare@suse.de>, Johannes Thumshirn <jthumshirn@suse.de>
References: <20171201000848.2656-1-bart.vanassche@wdc.com>
 <20171201000848.2656-3-bart.vanassche@wdc.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <a057d4ab-ddfd-9461-4086-e6f9ec83bb07@kernel.dk>
Date: Thu, 30 Nov 2017 20:03:31 -0700
MIME-Version: 1.0
In-Reply-To: <20171201000848.2656-3-bart.vanassche@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 11/30/2017 05:08 PM, Bart Van Assche wrote:
> This patch does not change any functionality.

Unless these actually found real bugs, I think it's pointless.
Add a comment. And this:
 
> @@ -1003,9 +1007,14 @@ bool blk_mq_get_driver_tag(struct request *rq, struct blk_mq_hw_ctx **hctx,
>  static int blk_mq_dispatch_wake(wait_queue_entry_t *wait, unsigned mode,
>  				int flags, void *key)
>  {
> -	struct blk_mq_hw_ctx *hctx;
> +	struct blk_mq_hw_ctx *hctx =
> +		container_of(wait, struct blk_mq_hw_ctx, dispatch_wait);
> +
> +#ifdef CONFIG_LOCKDEP
> +	struct sbq_wait_state *ws = bt_wait_ptr(&hctx->tags->bitmap_tags, hctx);
>  
> -	hctx = container_of(wait, struct blk_mq_hw_ctx, dispatch_wait);
> +	lockdep_assert_held(&ws->wait.lock);
> +#endif

we're definitely not doing.

-- 
Jens Axboe
