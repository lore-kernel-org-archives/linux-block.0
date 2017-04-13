Return-Path: <osandov@osandov.com>
Return-Path: <osandov@osandov.com>
Date: Thu, 13 Apr 2017 16:21:04 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Omar Sandoval <osandov@fb.com>, Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH 5/6] blk-mq: Add blk_mq_ops.show_rq()
Message-ID: <20170413232104.GF1550@vader.DHCP.thefacebook.com>
References: <20170411205842.28137-1-bart.vanassche@sandisk.com>
 <20170411205842.28137-6-bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170411205842.28137-6-bart.vanassche@sandisk.com>
List-ID: <linux-block@vger.kernel.org>

On Tue, Apr 11, 2017 at 01:58:41PM -0700, Bart Van Assche wrote:
> This new callback function will be used in the next patch to show
> more information about SCSI requests.
> 
> Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
> Cc: Omar Sandoval <osandov@fb.com>
> Cc: Hannes Reinecke <hare@suse.com>
> ---
>  block/blk-mq-debugfs.c | 10 ++++++++--
>  include/linux/blk-mq.h |  6 ++++++
>  2 files changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
> index 161f30fc236f..6b28d92d4c0e 100644
> --- a/block/blk-mq-debugfs.c
> +++ b/block/blk-mq-debugfs.c
> @@ -316,7 +316,9 @@ static const char *const rqf_name[] = {
>  static int blk_mq_debugfs_rq_show(struct seq_file *m, void *v)
>  {
>  	struct request *rq = list_entry_rq(v);
> +	const struct blk_mq_ops *const mq_ops = rq->q->mq_ops;
>  	const unsigned int op = rq->cmd_flags & REQ_OP_MASK;
> +	char drv_info[200];
>  
>  	seq_printf(m, "%p {.op=", rq);
>  	if (op < ARRAY_SIZE(op_name) && op_name[op])
> @@ -329,8 +331,12 @@ static int blk_mq_debugfs_rq_show(struct seq_file *m, void *v)
>  	seq_puts(m, ", .rq_flags=");
>  	blk_flags_show(m, (__force unsigned int)rq->rq_flags, rqf_name,
>  		       ARRAY_SIZE(rqf_name));
> -	seq_printf(m, ", .tag=%d, .internal_tag=%d}\n", rq->tag,
> -		   rq->internal_tag);
> +	if (mq_ops->show_rq)
> +		mq_ops->show_rq(rq, drv_info, sizeof(drv_info));

How about passing the seq_file to the callback instead of this
arbitrarily-sized on-stack buffer?
