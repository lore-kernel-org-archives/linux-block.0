Return-Path: <linux-block-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:38314 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1166133AbdDXHce (ORCPT
        <rfc822;groupwise-linux-block@vger.kernel.org:0:0>);
        Mon, 24 Apr 2017 03:32:34 -0400
Subject: Re: [PATCH v4 09/10] blk-mq: Add blk_mq_ops.show_rq()
To: Bart Van Assche <bart.vanassche@sandisk.com>,
        Jens Axboe <axboe@kernel.dk>
References: <20170421234026.18970-1-bart.vanassche@sandisk.com>
 <20170421234026.18970-10-bart.vanassche@sandisk.com>
Cc: linux-block@vger.kernel.org
From: Hannes Reinecke <hare@suse.com>
Message-ID: <1e88d065-5a98-1edc-658e-c0194e471994@suse.com>
Date: Mon, 24 Apr 2017 09:32:31 +0200
MIME-Version: 1.0
In-Reply-To: <20170421234026.18970-10-bart.vanassche@sandisk.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 04/22/2017 01:40 AM, Bart Van Assche wrote:
> This new callback function will be used in the next patch to show
> more information about SCSI requests.
> 
> Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
> Reviewed-by: Omar Sandoval <osandov@fb.com>
> Cc: Hannes Reinecke <hare@suse.com>
> ---
>  block/blk-mq-debugfs.c | 6 +++++-
>  include/linux/blk-mq.h | 6 ++++++
>  2 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
> index 3a99146ece39..c5eca9245459 100644
> --- a/block/blk-mq-debugfs.c
> +++ b/block/blk-mq-debugfs.c
> @@ -311,6 +311,7 @@ static const char *const rqf_name[] = {
>  static int blk_mq_debugfs_rq_show(struct seq_file *m, void *v)
>  {
>  	struct request *rq = list_entry_rq(v);
> +	const struct blk_mq_ops *const mq_ops = rq->q->mq_ops;
>  	const unsigned int op = rq->cmd_flags & REQ_OP_MASK;
>  
>  	seq_printf(m, "%p {.op=", rq);
> @@ -324,8 +325,11 @@ static int blk_mq_debugfs_rq_show(struct seq_file *m, void *v)
>  	seq_puts(m, ", .rq_flags=");
>  	blk_flags_show(m, (__force unsigned int)rq->rq_flags, rqf_name,
>  		       ARRAY_SIZE(rqf_name));
> -	seq_printf(m, ", .tag=%d, .internal_tag=%d}\n", rq->tag,
> +	seq_printf(m, ", .tag=%d, .internal_tag=%d", rq->tag,
>  		   rq->internal_tag);
> +	if (mq_ops->show_rq)
> +		mq_ops->show_rq(m, rq);
> +	seq_puts(m, "}\n");
>  	return 0;
>  }
>  
> diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
> index 0c4dadb85f62..b7bf11c05568 100644
> --- a/include/linux/blk-mq.h
> +++ b/include/linux/blk-mq.h
> @@ -121,6 +121,12 @@ struct blk_mq_ops {
>  	softirq_done_fn		*complete;
>  
>  	/*
> +	 * Used by the debugfs implementation to show driver-specific
> +	 * information about a request.
> +	 */
> +	void (*show_rq)(struct seq_file *m, struct request *rq);
> +
> +	/*
>  	 * Called when the block layer side of a hardware queue has been
>  	 * set up, allowing the driver to allocate/init matching structures.
>  	 * Ditto for exit/teardown.
> 
I don't really like this; what does happen if someone disabled
CONFIG_BLK_DEBUGFS?
Won't we end up with a stale callback?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		               zSeries & Storage
hare@suse.com			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: F. Imend�rffer, J. Smithard, D. Upmanyu, G. Norton
HRB 21284 (AG N�rnberg)
