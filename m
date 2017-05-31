Return-Path: <prvs=3177d4db0=eduval@lab126.com>
Date: Wed, 31 May 2017 14:43:27 -0700
From: Eduardo Valentin <eduval@amazon.com>
To: Bart Van Assche <bart.vanassche@sandisk.com>
CC: Jens Axboe <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        "Christoph
 Hellwig" <hch@lst.de>, Hannes Reinecke <hare@suse.com>,
        Omar Sandoval
	<osandov@fb.com>, Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH v2 3/4] blk-mq-debugfs: Show busy requests
Message-ID: <20170531214327.GD7903@u40b0340c692b58f6553c.ant.amazon.com>
References: <20170531213050.30276-1-bart.vanassche@sandisk.com>
 <20170531213050.30276-4-bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20170531213050.30276-4-bart.vanassche@sandisk.com>
List-ID: <linux-block@vger.kernel.org>

Hello,

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
> +
> +static int hctx_busy_show(void *data, struct seq_file *m)
> +{
> +	struct blk_mq_hw_ctx *hctx = data;
> +	struct show_busy_params params = { .m = m, .hctx = hctx };
> +
> +	blk_mq_tagset_busy_iter(hctx->queue->tag_set, hctx_show_busy, &params);
> +
> +	return 0;
> +}

Why not making the two above one single function?
hctx_busy_show vs. hctx_show_busy seams a bit confusing, and I could not see
where they get reused in your patch set..


> +
>  static int hctx_ctx_map_show(void *data, struct seq_file *m)
>  {
>  	struct blk_mq_hw_ctx *hctx = data;
> @@ -705,6 +730,7 @@ static const struct blk_mq_debugfs_attr blk_mq_debugfs_hctx_attrs[] = {
>  	{"state", 0400, hctx_state_show},
>  	{"flags", 0400, hctx_flags_show},
>  	{"dispatch", 0400, .seq_ops = &hctx_dispatch_seq_ops},
> +	{"busy", 0400, hctx_busy_show},
>  	{"ctx_map", 0400, hctx_ctx_map_show},
>  	{"tags", 0400, hctx_tags_show},
>  	{"tags_bitmap", 0400, hctx_tags_bitmap_show},
> -- 
> 2.12.2
> 
> 

-- 
All the best,
Eduardo Valentin
