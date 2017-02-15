Subject: Re: [PATCH v3] blk-mq-sched: separate mark hctx and queue restart
 operations
To: Omar Sandoval <osandov@osandov.com>, linux-block@vger.kernel.org
References: <7b2be6bff215dcbb09b2795b08f10a87870eecfa.1487176897.git.osandov@fb.com>
Cc: kernel-team@fb.com
From: Jens Axboe <axboe@fb.com>
Message-ID: <cc5a1143-e1ed-a4de-1c41-7403751ae576@fb.com>
Date: Wed, 15 Feb 2017 09:54:19 -0700
MIME-Version: 1.0
In-Reply-To: <7b2be6bff215dcbb09b2795b08f10a87870eecfa.1487176897.git.osandov@fb.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 02/15/2017 09:45 AM, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> In blk_mq_sched_dispatch_requests(), we call blk_mq_sched_mark_restart()
> after we dispatch requests left over on our hardware queue dispatch
> list. This is so we'll go back and dispatch requests from the scheduler.
> In this case, it's only necessary to restart the hardware queue that we
> are running; there's no reason to run other hardware queues just because
> we are using shared tags.
> 
> So, split out blk_mq_sched_mark_restart() into two operations, one for
> just the hardware queue and one for the whole request queue. The core
> code uses both, and I/O schedulers may also want to use them.
> 
> This also requires adjusting blk_mq_sched_restart_queues() to always
> check the queue restart flag, not just when using shared tags.

Looks good to me - just one comment:

> @@ -936,7 +936,10 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *list)
>  			 * in case the needed IO completed right before we
>  			 * marked the queue as needing a restart.
>  			 */
> -			blk_mq_sched_mark_restart(hctx);
> +			if (hctx->flags & BLK_MQ_F_TAG_SHARED)
> +				blk_mq_sched_mark_restart_queue(hctx);
> +			else
> +				blk_mq_sched_mark_restart_hctx(hctx);
>  			if (!blk_mq_get_driver_tag(rq, &hctx, false))
>  				break;
>  		}

Since we now pushed the SHARED tag into the caller, I think this
warrants a comment as to why the two cases are different (getting a
driver tag can fail with 0 pending IOs for SHARED). Just update the
existing comment.

-- 
Jens Axboe
