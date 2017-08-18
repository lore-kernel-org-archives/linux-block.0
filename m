Return-Path: <hare@suse.de>
Subject: Re: [PATCH 03/12] blk-mq: Explain when 'active_queues' is decremented
To: Bart Van Assche <bart.vanassche@wdc.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Johannes Thumshirn <jthumshirn@suse.de>
References: <20170817232311.25948-1-bart.vanassche@wdc.com>
 <20170817232311.25948-4-bart.vanassche@wdc.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <8d3922ef-25ce-5e4a-4f68-d8aa29afa589@suse.de>
Date: Fri, 18 Aug 2017 09:32:05 +0200
MIME-Version: 1.0
In-Reply-To: <20170817232311.25948-4-bart.vanassche@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 08/18/2017 01:23 AM, Bart Van Assche wrote:
> It is nontrivial to derive from the blk-mq source code when
> blk_mq_tags.active_queues is decremented. Hence add a comment that
> explains this.
> 
> Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Hannes Reinecke <hare@suse.de>
> Cc: Johannes Thumshirn <jthumshirn@suse.de>
> ---
>  block/blk-mq.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index f84d145490bf..b86d2cafc355 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -834,6 +834,10 @@ static void blk_mq_timeout_work(struct work_struct *work)
>  	} else {
>  		struct blk_mq_hw_ctx *hctx;
>  
> +		/*
> +		 * All requests finished (latest request timeout) seconds ago,
> +		 * so mark each hctx as idle.
> +		 */
>  		queue_for_each_hw_ctx(q, hctx, i) {
>  			/* the hctx may be unmapped, so check it here */
>  			if (blk_mq_hw_queue_mapped(hctx))
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
