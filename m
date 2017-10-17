Return-Path: <ming.lei@redhat.com>
Date: Tue, 17 Oct 2017 08:37:54 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2] blk-mq: Make blk_mq_get_request() error path less
 confusing
Message-ID: <20171017003748.GA15996@ming.t460p>
References: <20171016233226.5488-1-bart.vanassche@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171016233226.5488-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Mon, Oct 16, 2017 at 04:32:26PM -0700, Bart Van Assche wrote:
> blk_mq_get_tag() can modify data->ctx. This means that in the
> error path of blk_mq_get_request() data->ctx should be passed to
> blk_mq_put_ctx() instead of local_ctx. Note: since blk_mq_put_ctx()
> ignores its argument, this patch does not change any functionality.
> 
> References: commit 1ad43c0078b7 ("blk-mq: don't leak preempt counter/q_usage_counter when allocating rq failed")
> Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
> Cc: Ming Lei <ming.lei@redhat.com>
> ---
> Changes compared to v1:
> - Removed "Cc: <stable>"
> - Removed "bug fix" from the description.
> 
>  block/blk-mq.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 097ca3ece716..d9b3b5dc66ab 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -336,12 +336,14 @@ static struct request *blk_mq_get_request(struct request_queue *q,
>  	struct elevator_queue *e = q->elevator;
>  	struct request *rq;
>  	unsigned int tag;
> -	struct blk_mq_ctx *local_ctx = NULL;
> +	bool put_ctx_on_error = false;
>  
>  	blk_queue_enter_live(q);
>  	data->q = q;
> -	if (likely(!data->ctx))
> -		data->ctx = local_ctx = blk_mq_get_ctx(q);
> +	if (likely(!data->ctx)) {
> +		data->ctx = blk_mq_get_ctx(q);
> +		put_ctx_on_error = true;
> +	}
>  	if (likely(!data->hctx))
>  		data->hctx = blk_mq_map_queue(q, data->ctx->cpu);
>  	if (op & REQ_NOWAIT)
> @@ -360,8 +362,8 @@ static struct request *blk_mq_get_request(struct request_queue *q,
>  
>  	tag = blk_mq_get_tag(data);
>  	if (tag == BLK_MQ_TAG_FAIL) {
> -		if (local_ctx) {
> -			blk_mq_put_ctx(local_ctx);
> +		if (put_ctx_on_error) {
> +			blk_mq_put_ctx(data->ctx);
>  			data->ctx = NULL;
>  		}
>  		blk_queue_exit(q);
> -- 
> 2.14.2
> 

Reviewed-by: Ming Lei <ming.lei@redhat.com>


-- 
Ming
