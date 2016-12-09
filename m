Return-Path: <hare@suse.de>
Subject: Re: [PATCH 4/7] blk-flush: run the queue when inserting blk-mq flush
To: Jens Axboe <axboe@fb.com>, axboe@kernel.dk, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <1481228005-9245-1-git-send-email-axboe@fb.com>
 <1481228005-9245-5-git-send-email-axboe@fb.com>
Cc: paolo.valente@linaro.org, osandov@fb.com
From: Hannes Reinecke <hare@suse.de>
Message-ID: <e1a0459d-b9dc-7275-a051-2327f8b9ac94@suse.de>
Date: Fri, 9 Dec 2016 07:45:49 +0100
MIME-Version: 1.0
In-Reply-To: <1481228005-9245-5-git-send-email-axboe@fb.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 12/08/2016 09:13 PM, Jens Axboe wrote:
> Currently we pass in to run the queue async, but don't flag the
> queue to be run. We don't need to run it async here, but we should
> run it. So fixup the parameters.
>
> Signed-off-by: Jens Axboe <axboe@fb.com>
> ---
>  block/blk-flush.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/block/blk-flush.c b/block/blk-flush.c
> index 1bdbb3d3e5f5..27a42dab5a36 100644
> --- a/block/blk-flush.c
> +++ b/block/blk-flush.c
> @@ -426,7 +426,7 @@ void blk_insert_flush(struct request *rq)
>  	if ((policy & REQ_FSEQ_DATA) &&
>  	    !(policy & (REQ_FSEQ_PREFLUSH | REQ_FSEQ_POSTFLUSH))) {
>  		if (q->mq_ops) {
> -			blk_mq_insert_request(rq, false, false, true);
> +			blk_mq_insert_request(rq, false, true, false);
>  		} else
>  			list_add_tail(&rq->queuelist, &q->queue_head);
>  		return;
>
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: F. Imend�rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N�rnberg)
