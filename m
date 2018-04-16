Return-Path: <linux-block-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:58046 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753359AbeDPKv0 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Apr 2018 06:51:26 -0400
Subject: Re: [PATCH 08/12] mmc: reduce use of block bounce buffers
To: Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org,
        linux-arch@vger.kernel.org, linux-block@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
        netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
References: <20180416085032.7367-1-hch@lst.de>
 <20180416085032.7367-9-hch@lst.de>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <2067b808-65b3-e4d9-e376-1062abc1542f@arm.com>
Date: Mon, 16 Apr 2018 11:51:23 +0100
MIME-Version: 1.0
In-Reply-To: <20180416085032.7367-9-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 16/04/18 09:50, Christoph Hellwig wrote:
> We can rely on the dma-mapping code to handle any DMA limits that is
> bigger than the ISA DMA mask for us (either using an iommu or swiotlb),
> so remove setting the block layer bounce limit for anything but bouncing
> for highmem pages.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/mmc/core/queue.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
> index 56e9a803db21..60a02a763d01 100644
> --- a/drivers/mmc/core/queue.c
> +++ b/drivers/mmc/core/queue.c
> @@ -351,17 +351,14 @@ static const struct blk_mq_ops mmc_mq_ops = {
>   static void mmc_setup_queue(struct mmc_queue *mq, struct mmc_card *card)
>   {
>   	struct mmc_host *host = card->host;
> -	u64 limit = BLK_BOUNCE_HIGH;
> -
> -	if (mmc_dev(host)->dma_mask && *mmc_dev(host)->dma_mask)
> -		limit = (u64)dma_max_pfn(mmc_dev(host)) << PAGE_SHIFT;
>   
>   	blk_queue_flag_set(QUEUE_FLAG_NONROT, mq->queue);
>   	blk_queue_flag_clear(QUEUE_FLAG_ADD_RANDOM, mq->queue);
>   	if (mmc_can_erase(card))
>   		mmc_queue_setup_discard(mq->queue, card);
>   
> -	blk_queue_bounce_limit(mq->queue, limit);
> +	if (!mmc_dev(host)->dma_mask || !mmc_dev(host)->dma_mask)

I'm almost surprised that GCC doesn't warn about "x || x", but 
nevertheless I think you've lost a "*" here...

Robin.

> +		blk_queue_bounce_limit(mq->queue, BLK_BOUNCE_HIGH);
>   	blk_queue_max_hw_sectors(mq->queue,
>   		min(host->max_blk_count, host->max_req_size / 512));
>   	blk_queue_max_segments(mq->queue, host->max_segs);
> 
