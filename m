Return-Path: <osandov@osandov.com>
Return-Path: <osandov@osandov.com>
Date: Mon, 1 May 2017 17:19:24 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Omar Sandoval <osandov@fb.com>, Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH 6/6] blk-mq-debugfs: Add 'kick' operation
Message-ID: <20170502001924.GB2894@vader>
References: <20170427155437.23228-1-bart.vanassche@sandisk.com>
 <20170427155437.23228-7-bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170427155437.23228-7-bart.vanassche@sandisk.com>
List-ID: <linux-block@vger.kernel.org>

On Thu, Apr 27, 2017 at 08:54:37AM -0700, Bart Van Assche wrote:
> Running a queue causes the block layer to examine the per-CPU and
> hw queues but not the requeue list. Hence add a 'kick' operation
> that also examines the requeue list.

The naming of these operations isn't super intuitive, but it makes
enough sense if you know the code, I guess.

Reviewed-by: Omar Sandoval <osandov@fb.com>

> Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
> Cc: Omar Sandoval <osandov@fb.com>
> Cc: Hannes Reinecke <hare@suse.com>
> ---
>  block/blk-mq-debugfs.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
> index a5e286e04569..aeca26c739d1 100644
> --- a/block/blk-mq-debugfs.c
> +++ b/block/blk-mq-debugfs.c
> @@ -120,8 +120,10 @@ static ssize_t blk_queue_flags_store(struct file *file, const char __user *ubuf,
>  		blk_mq_run_hw_queues(q, true);
>  	} else if (strcmp(op, "start") == 0) {
>  		blk_mq_start_stopped_hw_queues(q, true);
> +	} else if (strcmp(op, "kick") == 0) {
> +		blk_mq_kick_requeue_list(q);
>  	} else {
> -		pr_err("%s: unsupported operation %s. Use either 'run' or 'start'\n",
> +		pr_err("%s: unsupported operation %s. Use 'run', 'start' or 'kick'\n",
>  		       __func__, op);
>  		return -EINVAL;
>  	}
> -- 
> 2.12.2
> 
