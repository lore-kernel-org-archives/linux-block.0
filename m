Return-Path: <hare@suse.de>
Subject: Re: [PATCH 4/5] blk-mq-debugfs: Show busy requests
To: Bart Van Assche <bart.vanassche@sandisk.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Hannes Reinecke <hare@suse.com>, Omar Sandoval <osandov@fb.com>,
 Ming Lei <ming.lei@redhat.com>
References: <20170525233810.23211-1-bart.vanassche@sandisk.com>
 <20170525233810.23211-5-bart.vanassche@sandisk.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <60bf5a0d-461e-94b7-98d6-56583d53cd73@suse.de>
Date: Fri, 26 May 2017 16:38:29 +0200
MIME-Version: 1.0
In-Reply-To: <20170525233810.23211-5-bart.vanassche@sandisk.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 05/26/2017 01:38 AM, Bart Van Assche wrote:
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
>  block/blk-mq-debugfs.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
> index 8b06a12c1461..70a2b955afee 100644
> --- a/block/blk-mq-debugfs.c
> +++ b/block/blk-mq-debugfs.c
> @@ -370,6 +370,30 @@ static const struct seq_operations hctx_dispatch_seq_ops = {
>  	.show	= blk_mq_debugfs_rq_show,
>  };
>  
> +struct show_busy_ctx {
> +	struct seq_file		*m;
> +	struct blk_mq_hw_ctx	*hctx;
> +};
> +
> +static void hctx_show_busy(struct request *rq, void *data, bool reserved)
> +{
> +	const struct show_busy_ctx *ctx = data;
> +
> +	if (blk_mq_map_queue(rq->q, rq->mq_ctx->cpu) == ctx->hctx &&
> +	    test_bit(REQ_ATOM_STARTED, &rq->atomic_flags))
> +		blk_mq_debugfs_rq_show(ctx->m, &rq->queuelist);
> +}
> +
> +static int hctx_busy_show(void *data, struct seq_file *m)
> +{
> +	struct blk_mq_hw_ctx *hctx = data;
> +	struct show_busy_ctx ctx = { .m = m, .hctx = hctx };
> +
> +	blk_mq_tagset_busy_iter(hctx->queue->tag_set, hctx_show_busy, &ctx);
> +
> +	return 0;
> +}
> +
>  static int hctx_ctx_map_show(void *data, struct seq_file *m)
>  {
>  	struct blk_mq_hw_ctx *hctx = data;
> @@ -705,6 +729,7 @@ static const struct blk_mq_debugfs_attr blk_mq_debugfs_hctx_attrs[] = {
>  	{"state", 0400, hctx_state_show},
>  	{"flags", 0400, hctx_flags_show},
>  	{"dispatch", 0400, .seq_ops = &hctx_dispatch_seq_ops},
> +	{"busy", 0400, hctx_busy_show},
>  	{"ctx_map", 0400, hctx_ctx_map_show},
>  	{"tags", 0400, hctx_tags_show},
>  	{"tags_bitmap", 0400, hctx_tags_bitmap_show},
> 
Hmm. I wonder if this is going to work as intended; 'busy' might be
changing rapidly, so the busy_iter might be giving us unintended results.
Have you checked?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
