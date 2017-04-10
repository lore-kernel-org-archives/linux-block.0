Return-Path: <osandov@osandov.com>
Return-Path: <osandov@osandov.com>
Date: Mon, 10 Apr 2017 13:00:45 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Jens Axboe <axboe@kernel.dk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 0/2] Export more queue state information through debugfs
Message-ID: <20170410200045.GA18846@vader.DHCP.thefacebook.com>
References: <20170330182127.24288-1-bart.vanassche@sandisk.com>
 <826af944-2316-8352-118c-91887d747eca@kernel.dk>
 <51f5cd27-4ae4-0a21-63e2-c7a2ec95e257@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <51f5cd27-4ae4-0a21-63e2-c7a2ec95e257@sandisk.com>
List-ID: <linux-block@vger.kernel.org>

On Mon, Apr 10, 2017 at 11:40:49AM -0700, Bart Van Assche wrote:
> On 04/10/2017 11:28 AM, Jens Axboe wrote:
> > On 03/30/2017 12:21 PM, Bart Van Assche wrote:
> >> This is a short patch series with one patch that exports the queue state
> >> and another patch that shows symbolic names for hctx state and flags
> >> instead of a numerical bitmask.
> >>
> >> Please consider these patches for kernel v4.12.
> > 
> > Thanks, added for 4.12.
> 
> Hello Jens,
> 
> Thanks! This infrastructure was essential while analyzing queue stalls.
> 
> After I had posted this series I improved and extended the blk-mq debugfs
> functionality further. Please consider including the patch below in v4.12.
> 
> Thanks,
> 
> Bart.
> 
> 
> From: Bart Van Assche <bart.vanassche@sandisk.com>
> Subject: [PATCH] blk-mq: Two fixes for the code that exports the queue state
> 
> Remove the array entry for QUEUE_FLAG_RESTART since that flag has
> been removed after the blk-mq-debugfs patch that introduced this
> array entry was posted.
> 
> Avoid that querying the queue state of a dead queue triggers a
> kernel crash.
> 
> Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
> ---
>  block/blk-mq-debugfs.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
> index 91d09f58a596..a1ce823578c7 100644
> --- a/block/blk-mq-debugfs.c
> +++ b/block/blk-mq-debugfs.c
> @@ -92,7 +92,6 @@ static const char *const blk_queue_flag_name[] = {
>  	[QUEUE_FLAG_FLUSH_NQ]	 = "FLUSH_NQ",
>  	[QUEUE_FLAG_DAX]	 = "DAX",
>  	[QUEUE_FLAG_STATS]	 = "STATS",
> -	[QUEUE_FLAG_RESTART]	 = "RESTART",
>  	[QUEUE_FLAG_POLL_STATS]	 = "POLL_STATS",
>  	[QUEUE_FLAG_REGISTERED]	 = "REGISTERED",
>  };
> @@ -112,6 +111,14 @@ static ssize_t blk_queue_flags_store(struct file *file, const char __user *ubuf,
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

Can you just move blk_queue_flags_fops to blk_mq_debugfs_queue_attrs
instead of adding blk_queue_attrs?
