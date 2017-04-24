Return-Path: <osandov@osandov.com>
Return-Path: <osandov@osandov.com>
Date: Mon, 24 Apr 2017 09:55:49 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Omar Sandoval <osandov@fb.com>, Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH v4 05/10] blk-mq: Unregister debugfs attributes earlier
Message-ID: <20170424165549.GC28510@vader.DHCP.thefacebook.com>
References: <20170421234026.18970-1-bart.vanassche@sandisk.com>
 <20170421234026.18970-6-bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170421234026.18970-6-bart.vanassche@sandisk.com>
List-ID: <linux-block@vger.kernel.org>

On Fri, Apr 21, 2017 at 04:40:21PM -0700, Bart Van Assche wrote:
> One of the debugfs attributes allows to run a queue. Since running
> a queue after a queue has entered the "dead" state is not allowed
> and even can cause a kernel crash, unregister the debugfs attributes
> before a queue reaches the "dead" state.

More important than this case, I think, is that blk_cleanup_queue()
calls blk_mq_free_queue(q), so most of the debugfs entries would lead to
use-after-frees. If you add that to the commit message and address my
comment below,

Reviewed-by: Omar Sandoval <osandov@fb.com>

> Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
> Cc: Omar Sandoval <osandov@fb.com>
> Cc: Hannes Reinecke <hare@suse.com>
> ---
>  block/blk-core.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index a49b0830aaaf..33c91a4bee97 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -566,6 +566,11 @@ void blk_cleanup_queue(struct request_queue *q)
>  	spin_lock_irq(lock);
>  	if (!q->mq_ops)
>  		__blk_drain_queue(q, true);
> +	spin_unlock_irq(lock);
> +
> +	blk_mq_debugfs_unregister_mq(q);
> +
> +	spin_lock_irq(lock);
>  	queue_flag_set(QUEUE_FLAG_DEAD, q);
>  	spin_unlock_irq(lock);

Do we actually have to hold the queue lock when we set QUEUE_FLAG_DEAD?
