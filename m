Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 4/5] blk-mq-debugfs: Show busy requests
To: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Hannes Reinecke <hare@suse.com>, Omar Sandoval <osandov@fb.com>,
 Ming Lei <ming.lei@redhat.com>
References: <20170525233810.23211-1-bart.vanassche@sandisk.com>
 <20170525233810.23211-5-bart.vanassche@sandisk.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <fa7126bb-7652-ed01-da08-23c3f428c00b@kernel.dk>
Date: Fri, 26 May 2017 07:26:56 -0600
MIME-Version: 1.0
In-Reply-To: <20170525233810.23211-5-bart.vanassche@sandisk.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 05/25/2017 05:38 PM, Bart Van Assche wrote:
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

Let's not call that variable 'ctx', in blk-mq that's pretty much
reserved for the sw queues.

-- 
Jens Axboe
