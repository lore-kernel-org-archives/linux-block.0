Return-Path: <maxg@mellanox.com>
Subject: Re: [PATCH 04/17] block: add a blk_steal_bios helper
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC: Keith Busch <keith.busch@intel.com>, Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>, Johannes Thumshirn <jthumshirn@suse.de>,
	<linux-nvme@lists.infradead.org>, <linux-block@vger.kernel.org>
References: <20171023145126.2471-1-hch@lst.de>
 <20171023145126.2471-5-hch@lst.de>
From: Max Gurtovoy <maxg@mellanox.com>
Message-ID: <ac15137b-b1a4-3988-17cc-fd6c25749542@mellanox.com>
Date: Tue, 24 Oct 2017 11:44:26 +0300
MIME-Version: 1.0
In-Reply-To: <20171023145126.2471-5-hch@lst.de>
Content-Type: text/plain; charset="windows-1255"; format=flowed
Return-Path: maxg@mellanox.com
List-ID: <linux-block@vger.kernel.org>



On 10/23/2017 5:51 PM, Christoph Hellwig wrote:
> This helpers allows to bounce steal the uncompleted bios from a request so
> that they can be reissued on another path.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>   block/blk-core.c       | 20 ++++++++++++++++++++
>   include/linux/blkdev.h |  2 ++
>   2 files changed, 22 insertions(+)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index b8c80f39f5fe..e804529e65a5 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -2767,6 +2767,26 @@ struct request *blk_fetch_request(struct request_queue *q)
>   }
>   EXPORT_SYMBOL(blk_fetch_request);
>   
> +/*
> + * Steal bios from a request.  The request must not have been partially
> + * completed before.
> + */

Maybe we can add to the comment that "list" is the destination for the 
stolen bio.

> +void blk_steal_bios(struct bio_list *list, struct request *rq)
> +{
> +	if (rq->bio) {
> +		if (list->tail)
> +			list->tail->bi_next = rq->bio;
> +		else
> +			list->head = rq->bio;
> +		list->tail = rq->biotail;

if list->tail != NULL don't we lose the "list->tail->bi_next = rq->bio;" 
assignment after assigning "list->tail = rq->biotail;" ?

> +	}
> +
> +	rq->bio = NULL;

we can add this NULL assignment inside the big "if", but I'm not sure 
regarding the next 2 assignments.
Anyway not a big deal.

> +	rq->biotail = NULL;
> +	rq->__data_len = 0;
> +}
> +EXPORT_SYMBOL_GPL(blk_steal_bios);
> +
