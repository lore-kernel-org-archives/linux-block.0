Subject: Re: [PATCH] blk-mq: Export queue state through
 /sys/kernel/debug/block/*/state
To: Bart Van Assche <Bart.VanAssche@sandisk.com>
References: <1D08B61A9CF0974AA09887BE32D889DA12BA96@ULS-OP-MBXIP03.sdcorp.global.sandisk.com>
Cc: Omar Sandoval <osandov@fb.com>, Hannes Reinecke <hare@suse.de>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@fb.com>
Message-ID: <f80153aa-3e7d-0a20-e426-7e58cd7c249d@fb.com>
Date: Thu, 30 Mar 2017 09:27:43 -0600
MIME-Version: 1.0
In-Reply-To: <1D08B61A9CF0974AA09887BE32D889DA12BA96@ULS-OP-MBXIP03.sdcorp.global.sandisk.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 03/29/2017 03:32 PM, Bart Van Assche wrote:
> Make it possible to check whether or not a block layer queue has
> been stopped. Make it possible to start and to run a blk-mq queue
> from user space.

Looks good, minor nitpicking below.

> +static int blk_queue_flags_show(struct seq_file *m, void *v)
> +{
> +	struct request_queue *q = m->private;
> +	bool sep = false;
> +	int i;
> +
> +	for (i = 0; i < sizeof(q->queue_flags) * BITS_PER_BYTE; i++) {
> +		if (!(q->queue_flags & BIT(i)))
> +			continue;
> +		if (sep)
> +			seq_puts(m, " ");
> +		sep = true;

Put that sep = true in the else branch?

> +	if (strcmp(op, "run") == 0) {
> +		blk_mq_run_hw_queues(q, true);
> +	} else if (strcmp(op, "start") == 0) {
> +		blk_mq_start_stopped_hw_queues(q, true);
> +	} else {
> +		pr_err("%s: unsupported operation %s\n", __func__, op);
> +		return -EINVAL;
> +	}

You are inconsistent with your braces. I'd prefer no braces for single
lines.

Should the error case include valid commands? It'd be nice to have this
available, and not have to resort to looking at the source to figure out
what commands are available.

-- 
Jens Axboe
