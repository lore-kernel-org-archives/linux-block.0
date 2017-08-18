Return-Path: <hare@suse.de>
Subject: Re: [PATCH 01/12] block: Fix two comments that refer to .queue_rq()
 return values
To: Bart Van Assche <bart.vanassche@wdc.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Ming Lei <ming.lei@redhat.com>, Johannes Thumshirn <jthumshirn@suse.de>
References: <20170817232311.25948-1-bart.vanassche@wdc.com>
 <20170817232311.25948-2-bart.vanassche@wdc.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <028b47da-8ccd-814f-93ce-73e0f2caef4d@suse.de>
Date: Fri, 18 Aug 2017 09:31:11 +0200
MIME-Version: 1.0
In-Reply-To: <20170817232311.25948-2-bart.vanassche@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 08/18/2017 01:23 AM, Bart Van Assche wrote:
> Since patch "blk-mq: switch .queue_rq return value to blk_status_t"
> .queue_rq() returns a BLK_STS_* value instead of a BLK_MQ_RQ_*
> value. Hence refer to the former in comments about .queue_rq()
> return values.
> 
> Fixes: commit 39a70c76b89b ("blk-mq: clarify dispatch may not be drained/blocked by stopping queue")
> Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Hannes Reinecke <hare@suse.de>
> Cc: Johannes Thumshirn <jthumshirn@suse.de>
> ---
>  block/blk-mq.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index fe764ca16993..f84d145490bf 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1258,7 +1258,7 @@ EXPORT_SYMBOL(blk_mq_queue_stopped);
>  /*
>   * This function is often used for pausing .queue_rq() by driver when
>   * there isn't enough resource or some conditions aren't satisfied, and
> - * BLK_MQ_RQ_QUEUE_BUSY is usually returned.
> + * BLK_STS_RESOURCE is usually returned.
>   *
>   * We do not guarantee that dispatch can be drained or blocked
>   * after blk_mq_stop_hw_queue() returns. Please use
> @@ -1275,7 +1275,7 @@ EXPORT_SYMBOL(blk_mq_stop_hw_queue);
>  /*
>   * This function is often used for pausing .queue_rq() by driver when
>   * there isn't enough resource or some conditions aren't satisfied, and
> - * BLK_MQ_RQ_QUEUE_BUSY is usually returned.
> + * BLK_STS_RESOURCE is usually returned.
>   *
>   * We do not guarantee that dispatch can be drained or blocked
>   * after blk_mq_stop_hw_queues() returns. Please use
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
