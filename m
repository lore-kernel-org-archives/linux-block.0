Return-Path: <hare@suse.de>
Subject: Re: [PATCH 02/12] block: Unexport blk_queue_end_tag()
To: Bart Van Assche <bart.vanassche@wdc.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Johannes Thumshirn <jthumshirn@suse.de>
References: <20170817232311.25948-1-bart.vanassche@wdc.com>
 <20170817232311.25948-3-bart.vanassche@wdc.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <cd374c03-4859-a307-dc98-3b82fee3e2cb@suse.de>
Date: Fri, 18 Aug 2017 09:31:30 +0200
MIME-Version: 1.0
In-Reply-To: <20170817232311.25948-3-bart.vanassche@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 08/18/2017 01:23 AM, Bart Van Assche wrote:
> This function is only used inside the block layer core. Hence
> unexport it.
> 
> Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Hannes Reinecke <hare@suse.de>
> Cc: Johannes Thumshirn <jthumshirn@suse.de>
> ---
>  block/blk-tag.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/block/blk-tag.c b/block/blk-tag.c
> index 2290f65b9d73..e1a9c15eb1b8 100644
> --- a/block/blk-tag.c
> +++ b/block/blk-tag.c
> @@ -290,7 +290,6 @@ void blk_queue_end_tag(struct request_queue *q, struct request *rq)
>  	 */
>  	clear_bit_unlock(tag, bqt->tag_map);
>  }
> -EXPORT_SYMBOL(blk_queue_end_tag);
>  
>  /**
>   * blk_queue_start_tag - find a free tag and assign it
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
