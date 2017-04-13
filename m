Return-Path: <osandov@osandov.com>
Return-Path: <osandov@osandov.com>
Date: Thu, 13 Apr 2017 16:17:56 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Omar Sandoval <osandov@fb.com>, Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH 4/6] blk-mq: Show operation, cmd_flags and rq_flags names
Message-ID: <20170413231756.GE1550@vader.DHCP.thefacebook.com>
References: <20170411205842.28137-1-bart.vanassche@sandisk.com>
 <20170411205842.28137-5-bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170411205842.28137-5-bart.vanassche@sandisk.com>
List-ID: <linux-block@vger.kernel.org>

On Tue, Apr 11, 2017 at 01:58:40PM -0700, Bart Van Assche wrote:
> Show the operation name, .cmd_flags and .rq_flags as names instead
> of numbers.
> 
> Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
> Cc: Omar Sandoval <osandov@fb.com>
> Cc: Hannes Reinecke <hare@suse.com>

I like this :) one minor nit below.

Reviewed-by: Omar Sandoval <osandov@fb.com>

> ---
>  block/blk-mq-debugfs.c | 72 +++++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 69 insertions(+), 3 deletions(-)
> 
> diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
> index aae4b7c7b7b0..161f30fc236f 100644
> --- a/block/blk-mq-debugfs.c
> +++ b/block/blk-mq-debugfs.c
[snip]
>  static int blk_mq_debugfs_rq_show(struct seq_file *m, void *v)
>  {
>  	struct request *rq = list_entry_rq(v);
> +	const unsigned int op = rq->cmd_flags & REQ_OP_MASK;
>  
> -	seq_printf(m, "%p {.cmd_flags=0x%x, .rq_flags=0x%x, .tag=%d, .internal_tag=%d}\n",
> -		   rq, rq->cmd_flags, (__force unsigned int)rq->rq_flags,
> -		   rq->tag, rq->internal_tag);
> +	seq_printf(m, "%p {.op=", rq);
> +	if (op < ARRAY_SIZE(op_name) && op_name[op])
> +		seq_printf(m, "%s", op_name[op]);
> +	else
> +		seq_printf(m, "%d", op);
> +	seq_puts(m, ", .cmd_flags=");
> +	blk_flags_show(m, rq->cmd_flags ^ op, cmd_flag_name,
                          ^^^^^^^^^^^^^^^^^^
I think rq->cmd_flags & ~REQ_OP_MASK is slightly clearer here, but I
don't feel that strongly about it, it's up to you.

> +		       ARRAY_SIZE(cmd_flag_name));
> +	seq_puts(m, ", .rq_flags=");
> +	blk_flags_show(m, (__force unsigned int)rq->rq_flags, rqf_name,
> +		       ARRAY_SIZE(rqf_name));
> +	seq_printf(m, ", .tag=%d, .internal_tag=%d}\n", rq->tag,
> +		   rq->internal_tag);
>  	return 0;
>  }
>  
> -- 
> 2.12.0
> 
