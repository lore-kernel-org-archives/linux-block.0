Return-Path: <osandov@osandov.com>
Return-Path: <osandov@osandov.com>
Date: Tue, 25 Apr 2017 14:30:18 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH v5 05/10] blk-mq: Unregister debugfs attributes earlier
Message-ID: <20170425213018.GB6361@vader>
References: <20170425203745.19946-1-bart.vanassche@sandisk.com>
 <20170425203745.19946-6-bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170425203745.19946-6-bart.vanassche@sandisk.com>
List-ID: <linux-block@vger.kernel.org>

On Tue, Apr 25, 2017 at 01:37:40PM -0700, Bart Van Assche wrote:
> One of the debugfs attributes allows to run a queue. Since running
> a queue after a queue has entered the "dead" state is not allowed
> and triggers a use-after-free, unregister the debugfs attributes
> before a queue reaches the "dead" state.

Still not happy with this commit message. I'd prefer:

We currently call blk_mq_free_queue() from blk_cleanup_queue() before we
unregister the debugfs attributes for that queue in blk_release_queue().
This leaves a window open during which accessing most of the mq debugfs
attributes would cause a use-after-free. Additionally, the "state"
attribute allows running the queue, which we should not do after the
queue has entered the "dead" state. Fix both of these cases by
unregistering the debugfs attributes before this.

Jens, could you ack that dropping the lock is okay?

> Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
> Reviewed-by: Hannes Reinecke <hare@suse.com>
> Reviewed-by: Omar Sandoval <osandov@fb.com>
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
>  
> -- 
> 2.12.2
> 
