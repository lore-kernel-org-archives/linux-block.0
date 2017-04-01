Return-Path: <hare@suse.com>
Subject: Re: [PATCH v4 1/2] blk-mq: Export queue state through
 /sys/kernel/debug/block/*/state
To: Bart Van Assche <Bart.VanAssche@sandisk.com>, Jens Axboe <axboe@kernel.dk>
References: <20170330182127.24288-1-bart.vanassche@sandisk.com>
 <20170330182127.24288-2-bart.vanassche@sandisk.com>
 <1D08B61A9CF0974AA09887BE32D889DA1310F4@ULS-OP-MBXIP03.sdcorp.global.sandisk.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Omar Sandoval <osandov@fb.com>
From: Hannes Reinecke <hare@suse.com>
Message-ID: <a2b83675-0335-824a-c891-e99fb009a7df@suse.com>
Date: Sat, 1 Apr 2017 10:05:17 +0200
MIME-Version: 1.0
In-Reply-To: <1D08B61A9CF0974AA09887BE32D889DA1310F4@ULS-OP-MBXIP03.sdcorp.global.sandisk.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 04/01/2017 01:23 AM, Bart Van Assche wrote:
> Make it possible to check whether or not a block layer queue has
> been stopped. Make it possible to start and to run a blk-mq queue
> from user space.
>
> Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
> Cc: Omar Sandoval <osandov@fb.com>
> Cc: Hannes Reinecke <hare@suse.com>
>
> ---
>
> Changes compared to v3:
> - Return -ENOENT for attempts to run or start a queue after it has reached the
>   state "dead". This is needed to avoid a use-after-free and potentially a kernel
>   crash.
>
> ---
>
>  block/blk-mq-debugfs.c | 114 +++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 114 insertions(+)
>
> diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
> index 4b3f962a9c7a..bd3afa4e1602 100644
> --- a/block/blk-mq-debugfs.c
> +++ b/block/blk-mq-debugfs.c
> @@ -43,6 +43,117 @@ static int blk_mq_debugfs_seq_open(struct inode *inode, struct file *file,
>  	return ret;
>  }
>
> +static int blk_flags_show(struct seq_file *m, const unsigned long flags,
> +			  const char *const *flag_name, int flag_name_count)
> +{
> +	bool sep = false;
> +	int i;
> +
> +	for (i = 0; i < sizeof(flags) * BITS_PER_BYTE; i++) {
> +		if (!(flags & BIT(i)))
> +			continue;
> +		if (sep)
> +			seq_puts(m, " ");
> +		sep = true;
> +		if (i < flag_name_count && flag_name[i])
> +			seq_puts(m, flag_name[i]);
> +		else
> +			seq_printf(m, "%d", i);
> +	}
> +	seq_puts(m, "\n");
> +	return 0;
> +}
> +
> +static const char *const blk_queue_flag_name[] = {
> +	[QUEUE_FLAG_QUEUED]	 = "QUEUED",
> +	[QUEUE_FLAG_STOPPED]	 = "STOPPED",
> +	[QUEUE_FLAG_SYNCFULL]	 = "SYNCFULL",
> +	[QUEUE_FLAG_ASYNCFULL]	 = "ASYNCFULL",
> +	[QUEUE_FLAG_DYING]	 = "DYING",
> +	[QUEUE_FLAG_BYPASS]	 = "BYPASS",
> +	[QUEUE_FLAG_BIDI]	 = "BIDI",
> +	[QUEUE_FLAG_NOMERGES]	 = "NOMERGES",
> +	[QUEUE_FLAG_SAME_COMP]	 = "SAME_COMP",
> +	[QUEUE_FLAG_FAIL_IO]	 = "FAIL_IO",
> +	[QUEUE_FLAG_STACKABLE]	 = "STACKABLE",
> +	[QUEUE_FLAG_NONROT]	 = "NONROT",
> +	[QUEUE_FLAG_IO_STAT]	 = "IO_STAT",
> +	[QUEUE_FLAG_DISCARD]	 = "DISCARD",
> +	[QUEUE_FLAG_NOXMERGES]	 = "NOXMERGES",
> +	[QUEUE_FLAG_ADD_RANDOM]	 = "ADD_RANDOM",
> +	[QUEUE_FLAG_SECERASE]	 = "SECERASE",
> +	[QUEUE_FLAG_SAME_FORCE]	 = "SAME_FORCE",
> +	[QUEUE_FLAG_DEAD]	 = "DEAD",
> +	[QUEUE_FLAG_INIT_DONE]	 = "INIT_DONE",
> +	[QUEUE_FLAG_NO_SG_MERGE] = "NO_SG_MERGE",
> +	[QUEUE_FLAG_POLL]	 = "POLL",
> +	[QUEUE_FLAG_WC]		 = "WC",
> +	[QUEUE_FLAG_FUA]	 = "FUA",
> +	[QUEUE_FLAG_FLUSH_NQ]	 = "FLUSH_NQ",
> +	[QUEUE_FLAG_DAX]	 = "DAX",
> +	[QUEUE_FLAG_STATS]	 = "STATS",
> +	[QUEUE_FLAG_POLL_STATS]	 = "POLL_STATS",
> +	[QUEUE_FLAG_REGISTERED]	 = "REGISTERED",
> +};
> +
> +static int blk_queue_flags_show(struct seq_file *m, void *v)
> +{
> +	struct request_queue *q = m->private;
> +
> +	blk_flags_show(m, q->queue_flags, blk_queue_flag_name,
> +		       ARRAY_SIZE(blk_queue_flag_name));
> +	return 0;
> +}
> +
> +static ssize_t blk_queue_flags_store(struct file *file, const char __user *ubuf,
> +				     size_t len, loff_t *offp)
> +{
> +	struct request_queue *q = file_inode(file)->i_private;
> +	char op[16] = { }, *s;
> +
> +	/*
> +	 * The debugfs attributes are removed after blk_cleanup_queue() has
> +	 * called blk_mq_free_queue(). Return if QUEUE_FLAG_DEAD has been set
> +	 * to avoid triggering a use-after-free.
> +	 */
> +	if (blk_queue_dead(q))
> +		return -ENOENT;
> +
> +	len = min(len, sizeof(op) - 1);
> +	if (copy_from_user(op, ubuf, len))
> +		return -EFAULT;
> +	s = op;
> +	strsep(&s, " \t\n"); /* strip trailing whitespace */
> +	if (strcmp(op, "run") == 0) {
> +		blk_mq_run_hw_queues(q, true);
> +	} else if (strcmp(op, "start") == 0) {
> +		blk_mq_start_stopped_hw_queues(q, true);
> +	} else {
> +		pr_err("%s: unsupported operation %s. Use either 'run' or 'start'\n",
> +		       __func__, op);
> +		return -EINVAL;
> +	}
> +	return len;
> +}
> +
I would have added 'stop' for completeness, but that's probably for very 
specific cases only.

Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
