Return-Path: <osandov@osandov.com>
Return-Path: <osandov@osandov.com>
Date: Thu, 13 Apr 2017 16:01:02 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Omar Sandoval <osandov@fb.com>, Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH 1/6] blk-mq: Do not invoke queue operations on a dead
 queue
Message-ID: <20170413230102.GA1550@vader.DHCP.thefacebook.com>
References: <20170411205842.28137-1-bart.vanassche@sandisk.com>
 <20170411205842.28137-2-bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170411205842.28137-2-bart.vanassche@sandisk.com>
List-ID: <linux-block@vger.kernel.org>

On Tue, Apr 11, 2017 at 01:58:37PM -0700, Bart Van Assche wrote:
> The blk-mq debugfs attributes are removed after blk_cleanup_queue()
> has finished. Since running a queue after a queue has entered the
> "dead" state is not allowed, disallow this. This patch avoids that
> an attempt to run a dead queue triggers a kernel crash.
> 
> Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
> Cc: Omar Sandoval <osandov@fb.com>
> Cc: Hannes Reinecke <hare@suse.com>
> ---
>  block/blk-mq-debugfs.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
> index df9b688b877c..a1ce823578c7 100644
> --- a/block/blk-mq-debugfs.c
> +++ b/block/blk-mq-debugfs.c
> @@ -111,6 +111,14 @@ static ssize_t blk_queue_flags_store(struct file *file, const char __user *ubuf,
>  	struct request_queue *q = file_inode(file)->i_private;
>  	char op[16] = { }, *s;
>  
> +	/*
> +	 * The debugfs attributes are removed after blk_cleanup_queue() has
> +	 * called blk_mq_free_queue(). Return if QUEUE_FLAG_DEAD has been set
> +	 * to avoid triggering a use-after-free.
> +	 */
> +	if (blk_queue_dead(q))
> +		return -ENOENT;
> +
>  	len = min(len, sizeof(op) - 1);
>  	if (copy_from_user(op, ubuf, len))
>  		return -EFAULT;
> -- 
> 2.12.0
> 

Hi, Bart,

Looking at this, I think we have similar issues with most of the other
debugfs files. Should we move the debugfs cleanup earlier?
