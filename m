Return-Path: <hare@suse.de>
Subject: Re: [PATCH] blk-mq-debugfs: Also show requests that have not yet been
 started
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.com>,
 Johannes Thumshirn <jthumshirn@suse.de>,
 "Martin K . Petersen" <martin.petersen@oracle.com>
References: <20181004173524.52712-1-bvanassche@acm.org>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <789eda3e-281e-280d-3942-7ffe15b71265@suse.de>
Date: Fri, 5 Oct 2018 07:48:02 +0200
MIME-Version: 1.0
In-Reply-To: <20181004173524.52712-1-bvanassche@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 10/4/18 7:35 PM, Bart Van Assche wrote:
> When debugging e.g. the SCSI timeout handler it is important that
> requests that have not yet been started or that already have
> completed are also reported through debugfs.
> 
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: Hannes Reinecke <hare@suse.com>
> Cc: Johannes Thumshirn <jthumshirn@suse.de>
> Cc: Martin K. Petersen <martin.petersen@oracle.com>
> ---
>   block/blk-mq-debugfs.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
> index a5ea86835fcb..41b86f50d126 100644
> --- a/block/blk-mq-debugfs.c
> +++ b/block/blk-mq-debugfs.c
> @@ -431,8 +431,7 @@ static void hctx_show_busy_rq(struct request *rq, void *data, bool reserved)
>   {
>   	const struct show_busy_params *params = data;
>   
> -	if (blk_mq_map_queue(rq->q, rq->mq_ctx->cpu) == params->hctx &&
> -	    blk_mq_rq_state(rq) != MQ_RQ_IDLE)
> +	if (blk_mq_map_queue(rq->q, rq->mq_ctx->cpu) == params->hctx)
>   		__blk_mq_debugfs_rq_show(params->m,
>   					 list_entry_rq(&rq->queuelist));
>   }
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
