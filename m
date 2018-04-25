Return-Path: <borntraeger@de.ibm.com>
Subject: Re: [PATCH] Revert "blk-mq: remove code for dealing with remapping
 queue"
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Ewan Milne <emilne@redhat.com>,
        Stefan Haberland <sth@linux.vnet.ibm.com>,
        Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
References: <20180424200144.16179-1-ming.lei@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 25 Apr 2018 09:41:26 +0200
MIME-Version: 1.0
In-Reply-To: <20180424200144.16179-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <30f75463-b50b-e3b7-8f78-768538fce016@de.ibm.com>
List-ID: <linux-block@vger.kernel.org>


On 04/24/2018 10:01 PM, Ming Lei wrote:
> This reverts commit 37c7c6c76d431dd7ef9c29d95f6052bd425f004c.
> 
> Turns out some drivers(most are FC drivers) may not use managed
> IRQ affinity, and has their customized .map_queues meantime, so
> still keep this code for avoiding regression.
> 
> Reported-by: Laurence Oberman <loberman@redhat.com>
> Cc: Ewan Milne <emilne@redhat.com>
> Cc: Stefan Haberland <sth@linux.vnet.ibm.com>
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Sagi Grimberg <sagi@grimberg.me>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Seems to work ok with 4.17-rc2 + this patch with s390 and dasd devices.
So one of the other fixes seems to have taken care of the original issue. 
Would be good if Stefan Haberland could also verify that.


> ---
>  block/blk-mq.c | 34 +++++++++++++++++++++++++++++++---
>  1 file changed, 31 insertions(+), 3 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index e39276852638..f4891b792d0d 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2407,7 +2407,7 @@ static void blk_mq_free_map_and_requests(struct blk_mq_tag_set *set,
>  
>  static void blk_mq_map_swqueue(struct request_queue *q)
>  {
> -	unsigned int i;
> +	unsigned int i, hctx_idx;
>  	struct blk_mq_hw_ctx *hctx;
>  	struct blk_mq_ctx *ctx;
>  	struct blk_mq_tag_set *set = q->tag_set;
> @@ -2424,8 +2424,23 @@ static void blk_mq_map_swqueue(struct request_queue *q)
>  
>  	/*
>  	 * Map software to hardware queues.
> +	 *
> +	 * If the cpu isn't present, the cpu is mapped to first hctx.
>  	 */
>  	for_each_possible_cpu(i) {
> +		hctx_idx = q->mq_map[i];
> +		/* unmapped hw queue can be remapped after CPU topo changed */
> +		if (!set->tags[hctx_idx] &&
> +		    !__blk_mq_alloc_rq_map(set, hctx_idx)) {
> +			/*
> +			 * If tags initialization fail for some hctx,
> +			 * that hctx won't be brought online.  In this
> +			 * case, remap the current ctx to hctx[0] which
> +			 * is guaranteed to always have tags allocated
> +			 */
> +			q->mq_map[i] = 0;
> +		}
> +
>  		ctx = per_cpu_ptr(q->queue_ctx, i);
>  		hctx = blk_mq_map_queue(q, i);
>  
> @@ -2437,8 +2452,21 @@ static void blk_mq_map_swqueue(struct request_queue *q)
>  	mutex_unlock(&q->sysfs_lock);
>  
>  	queue_for_each_hw_ctx(q, hctx, i) {
> -		/* every hctx should get mapped by at least one CPU */
> -		WARN_ON(!hctx->nr_ctx);
> +		/*
> +		 * If no software queues are mapped to this hardware queue,
> +		 * disable it and free the request entries.
> +		 */
> +		if (!hctx->nr_ctx) {
> +			/* Never unmap queue 0.  We need it as a
> +			 * fallback in case of a new remap fails
> +			 * allocation
> +			 */
> +			if (i && set->tags[i])
> +				blk_mq_free_map_and_requests(set, i);
> +
> +			hctx->tags = NULL;
> +			continue;
> +		}
>  
>  		hctx->tags = set->tags[i];
>  		WARN_ON(!hctx->tags);
> 
