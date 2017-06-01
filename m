Return-Path: <ming.lei@redhat.com>
Date: Thu, 1 Jun 2017 10:47:15 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.com>,
	Omar Sandoval <osandov@fb.com>
Subject: Re: [PATCH v2 3/4] blk-mq-debugfs: Show busy requests
Message-ID: <20170601024714.GE23563@ming.t460p>
References: <20170531213050.30276-1-bart.vanassche@sandisk.com>
 <20170531213050.30276-4-bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170531213050.30276-4-bart.vanassche@sandisk.com>
List-ID: <linux-block@vger.kernel.org>

On Wed, May 31, 2017 at 02:30:49PM -0700, Bart Van Assche wrote:
> Requests that got stuck in a block driver are neither on
> blk_mq_ctx.rq_list nor on any hw dispatch queue. Make these
> visible in debugfs through the "busy" attribute.
> 
> Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Hannes Reinecke <hare@suse.com>
> Cc: Omar Sandoval <osandov@fb.com>
> Cc: Ming Lei <ming.lei@redhat.com>
> ---
>  block/blk-mq-debugfs.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
> index 8b06a12c1461..fa0f624dfccd 100644
> --- a/block/blk-mq-debugfs.c
> +++ b/block/blk-mq-debugfs.c
> @@ -370,6 +370,31 @@ static const struct seq_operations hctx_dispatch_seq_ops = {
>  	.show	= blk_mq_debugfs_rq_show,
>  };
>  
> +struct show_busy_params {
> +	struct seq_file		*m;
> +	struct blk_mq_hw_ctx	*hctx;
> +};
> +
> +static void hctx_show_busy(struct request *rq, void *data, bool reserved)
> +{
> +	const struct show_busy_params *params = data;
> +
> +	if (blk_mq_map_queue(rq->q, rq->mq_ctx->cpu) == params->hctx &&
> +	    test_bit(REQ_ATOM_STARTED, &rq->atomic_flags))
> +		__blk_mq_debugfs_rq_show(params->m,
> +					 list_entry_rq(&rq->queuelist));
> +}

Not like dumping requests in ctx and requeue list, the dumped requests
here may have been released and the result may not be 100% reliable,
so suggest to add comment for this fact.

Otherwise, looks fine for me.

Thanks,
Ming
