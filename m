Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79D4FC7EE2F
	for <linux-block@archiver.kernel.org>; Mon, 12 Jun 2023 22:17:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbjFLWRw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 12 Jun 2023 18:17:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbjFLWRv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Jun 2023 18:17:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF0E0126
        for <linux-block@vger.kernel.org>; Mon, 12 Jun 2023 15:17:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C4B362FCA
        for <linux-block@vger.kernel.org>; Mon, 12 Jun 2023 22:17:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97DB8C433D2;
        Mon, 12 Jun 2023 22:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686608268;
        bh=6CmdIjPY8gJYqLjEXMdtjgQ88WJ74YfQ5JLK9y9V+gI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Q206lF5rq7UeEcshnzoom2nnCXtu8v6hwp1g7MbweDHKda1BO1sxXxDvnaUv3ayDl
         UUC5wBH+3AfyNDLbZq877vBF1OEhcztPcyBjK4EkT4dw8WtLsxgpa1PYH57bGLzyi4
         cwxcttH7rN6Cdm77OHy0vJfGb+p8kx9esdPjWXws2MNP26JfspqP5fgfnyWFlTEwv5
         z+09CFha1wunQs6mq8xbmiNrNF6gL4cmojI2WoQkL7KKMz98IVjcTeJxvI5sVZCnp7
         EyBmRwXoE/Jlv3S1Hf69D8iozYpsMticJe0Zvyxax4fAbmAEFg8K6xY9mbw9LgZjhs
         QyLPWb62PL5xw==
Message-ID: <407d7371-efa2-154d-a05f-a827171806a0@kernel.org>
Date:   Tue, 13 Jun 2023 07:17:46 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v6 8/8] null_blk: Support configuring the maximum segment
 size
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Sandeep Dhavale <dhavale@google.com>,
        Juan Yescas <jyescas@google.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
References: <20230612203314.17820-1-bvanassche@acm.org>
 <20230612203314.17820-9-bvanassche@acm.org>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230612203314.17820-9-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/13/23 05:33, Bart Van Assche wrote:
> Add support for configuring the maximum segment size.
> 
> Add support for segments smaller than the page size.
> 
> This patch enables testing segments smaller than the page size with a
> driver that does not call blk_rq_map_sg().
> 
> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  drivers/block/null_blk/main.c     | 19 ++++++++++++++++---
>  drivers/block/null_blk/null_blk.h |  1 +
>  2 files changed, 17 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
> index b3fedafe301e..9c9098f1bd52 100644
> --- a/drivers/block/null_blk/main.c
> +++ b/drivers/block/null_blk/main.c
> @@ -157,6 +157,10 @@ static int g_max_sectors;
>  module_param_named(max_sectors, g_max_sectors, int, 0444);
>  MODULE_PARM_DESC(max_sectors, "Maximum size of a command (in 512B sectors)");
>  
> +static unsigned int g_max_segment_size = BLK_MAX_SEGMENT_SIZE;
> +module_param_named(max_segment_size, g_max_segment_size, int, 0444);
> +MODULE_PARM_DESC(max_segment_size, "Maximum size of a segment in bytes");
> +
>  static unsigned int nr_devices = 1;
>  module_param(nr_devices, uint, 0444);
>  MODULE_PARM_DESC(nr_devices, "Number of devices to register");
> @@ -409,6 +413,7 @@ NULLB_DEVICE_ATTR(home_node, uint, NULL);
>  NULLB_DEVICE_ATTR(queue_mode, uint, NULL);
>  NULLB_DEVICE_ATTR(blocksize, uint, NULL);
>  NULLB_DEVICE_ATTR(max_sectors, uint, NULL);
> +NULLB_DEVICE_ATTR(max_segment_size, uint, NULL);
>  NULLB_DEVICE_ATTR(irqmode, uint, NULL);
>  NULLB_DEVICE_ATTR(hw_queue_depth, uint, NULL);
>  NULLB_DEVICE_ATTR(index, uint, NULL);
> @@ -550,6 +555,7 @@ static struct configfs_attribute *nullb_device_attrs[] = {
>  	&nullb_device_attr_queue_mode,
>  	&nullb_device_attr_blocksize,
>  	&nullb_device_attr_max_sectors,
> +	&nullb_device_attr_max_segment_size,
>  	&nullb_device_attr_irqmode,
>  	&nullb_device_attr_hw_queue_depth,
>  	&nullb_device_attr_index,
> @@ -652,7 +658,8 @@ static ssize_t memb_group_features_show(struct config_item *item, char *page)
>  	return snprintf(page, PAGE_SIZE,
>  			"badblocks,blocking,blocksize,cache_size,"
>  			"completion_nsec,discard,home_node,hw_queue_depth,"
> -			"irqmode,max_sectors,mbps,memory_backed,no_sched,"
> +			"irqmode,max_sectors,max_segment_size,mbps,"
> +			"memory_backed,no_sched,"
>  			"poll_queues,power,queue_mode,shared_tag_bitmap,size,"
>  			"submit_queues,use_per_node_hctx,virt_boundary,zoned,"
>  			"zone_capacity,zone_max_active,zone_max_open,"
> @@ -722,6 +729,7 @@ static struct nullb_device *null_alloc_dev(void)
>  	dev->queue_mode = g_queue_mode;
>  	dev->blocksize = g_bs;
>  	dev->max_sectors = g_max_sectors;
> +	dev->max_segment_size = g_max_segment_size;
>  	dev->irqmode = g_irqmode;
>  	dev->hw_queue_depth = g_hw_queue_depth;
>  	dev->blocking = g_blocking;
> @@ -1248,6 +1256,8 @@ static int null_transfer(struct nullb *nullb, struct page *page,
>  	unsigned int valid_len = len;
>  	int err = 0;
>  
> +	WARN_ONCE(len > dev->max_segment_size, "%u > %u\n", len,
> +		  dev->max_segment_size);
>  	if (!is_write) {
>  		if (dev->zoned)
>  			valid_len = null_zone_valid_read_len(nullb,
> @@ -1283,7 +1293,8 @@ static int null_handle_rq(struct nullb_cmd *cmd)
>  
>  	spin_lock_irq(&nullb->lock);
>  	rq_for_each_segment(bvec, rq, iter) {
> -		len = bvec.bv_len;
> +		len = min(bvec.bv_len, nullb->dev->max_segment_size);
> +		bvec.bv_len = len;

I am still confused by this change... Why is it necessary ? If max_segment_size
is set correctly, how can we ever get a BIO with a bvec length exceeding that
maximum ? If that is the case, aren't we missing a bio_split() somewhere ?

>  		err = null_transfer(nullb, bvec.bv_page, len, bvec.bv_offset,
>  				     op_is_write(req_op(rq)), sector,
>  				     rq->cmd_flags & REQ_FUA);
> @@ -1310,7 +1321,8 @@ static int null_handle_bio(struct nullb_cmd *cmd)
>  
>  	spin_lock_irq(&nullb->lock);
>  	bio_for_each_segment(bvec, bio, iter) {
> -		len = bvec.bv_len;
> +		len = min(bvec.bv_len, nullb->dev->max_segment_size);
> +		bvec.bv_len = len;
>  		err = null_transfer(nullb, bvec.bv_page, len, bvec.bv_offset,
>  				     op_is_write(bio_op(bio)), sector,
>  				     bio->bi_opf & REQ_FUA);
> @@ -2161,6 +2173,7 @@ static int null_add_dev(struct nullb_device *dev)
>  		dev->max_sectors = queue_max_hw_sectors(nullb->q);
>  	dev->max_sectors = min(dev->max_sectors, BLK_DEF_MAX_SECTORS);
>  	blk_queue_max_hw_sectors(nullb->q, dev->max_sectors);
> +	blk_queue_max_segment_size(nullb->q, dev->max_segment_size);
>  
>  	if (dev->virt_boundary)
>  		blk_queue_virt_boundary(nullb->q, PAGE_SIZE - 1);
> diff --git a/drivers/block/null_blk/null_blk.h b/drivers/block/null_blk/null_blk.h
> index 929f659dd255..7bf80b0035f5 100644
> --- a/drivers/block/null_blk/null_blk.h
> +++ b/drivers/block/null_blk/null_blk.h
> @@ -107,6 +107,7 @@ struct nullb_device {
>  	unsigned int queue_mode; /* block interface */
>  	unsigned int blocksize; /* block size */
>  	unsigned int max_sectors; /* Max sectors per command */
> +	unsigned int max_segment_size; /* Max size of a single DMA segment. */
>  	unsigned int irqmode; /* IRQ completion handler */
>  	unsigned int hw_queue_depth; /* queue depth */
>  	unsigned int index; /* index of the disk, only valid with a disk */

-- 
Damien Le Moal
Western Digital Research

