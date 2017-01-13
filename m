Return-Path: <sagi@grimberg.me>
Subject: Re: [PATCH 4/6] blk-mq: Update queue map when changing queue count
To: Keith Busch <keith.busch@intel.com>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
 Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
 Thomas Gleixner <tglx@linutronix.de>
References: <1483569671-1462-1-git-send-email-keith.busch@intel.com>
 <1483569671-1462-5-git-send-email-keith.busch@intel.com>
Cc: Marc Merlin <marc@merlins.org>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <5daa7b54-d797-1485-04ae-f5318b22a7f2@grimberg.me>
Date: Fri, 13 Jan 2017 22:39:38 +0200
MIME-Version: 1.0
In-Reply-To: <1483569671-1462-5-git-send-email-keith.busch@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>

> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index a8e67a1..9b7ed03 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2223,7 +2223,6 @@ static void blk_mq_queue_reinit(struct request_queue *q,
>  	 * we should change hctx numa_node according to new topology (this
>  	 * involves free and re-allocate memory, worthy doing?)
>  	 */
> -

This looks mis-placed.

>  	blk_mq_map_swqueue(q, online_mask);
>
>  	blk_mq_sysfs_register(q);
> @@ -2481,6 +2480,11 @@ void blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set, int nr_hw_queues)
>  		blk_mq_freeze_queue(q);
>
>  	set->nr_hw_queues = nr_hw_queues;
> +	if (set->ops->map_queues)
> +		set->ops->map_queues(set);
> +	else
> +		blk_mq_map_queues(set);
> +

Makes sense,

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
