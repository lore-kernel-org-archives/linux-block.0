Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89935C54EAA
	for <linux-block@archiver.kernel.org>; Sat, 28 Jan 2023 01:18:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231408AbjA1BSr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 27 Jan 2023 20:18:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233262AbjA1BSm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Jan 2023 20:18:42 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 524EC7B435
        for <linux-block@vger.kernel.org>; Fri, 27 Jan 2023 17:18:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1674868721; x=1706404721;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=iJLp56gGVPr2tbKQVnE1mKbD4T1JMxn5/FCqcZ3APTI=;
  b=n9XjM4AekEKfm68yMvXQyiFIbFilpUTPCur49ZFEGC2C/7IJS4dYSBGi
   GZoxX4y9l/jfB8IkMIpi5kE2cNx9PSmDPCQFYl/sRTUgFyDQlMQU4cdnu
   nqvqVCN7WWqHKeU1dUE4e5faeebq8istdwflbMCkYfUBw7GBEKw+azN1y
   3zhjWhSDxcwrDkDpSWL5E4fHic0pl8EAqVYG/S0ikJcQqz76WXrU6Dj1Y
   KtRX8E7r/qMn15MiDLZXEUjU68h0jO+FJfPxzIPP1FuJXg+xRVxrBZNFS
   YS9ojebutux3EgTO7y9Ydv7smEa/hU/ub82eYUaIL4eFGLVxozT73w5OX
   w==;
X-IronPort-AV: E=Sophos;i="5.97,252,1669046400"; 
   d="scan'208";a="333917208"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jan 2023 09:18:41 +0800
IronPort-SDR: K29tqE63vt24ev9btJOR6BRv2bfvxnxoncKJglgEmECU8AwF2ioQI0b+ibNHQ8dcPuT/I9Y028
 VQY6uFKmbl/FbI+/I+GdMm3wspgvR9RH53LefAB1Dq0NedVD2mnzA8YewtonYmJd/GnjPnyW0A
 I5HsgFCTdSFf/VBEPYWuEVvqeXd41zas25E/4w3RsbZ5Gl/CZ8/ib1EcoaqgrkQzN63XoRN47f
 9ojilvQRFX+wvYdRJBC/Rd2re1gjTdpFJOOVe2ksmHB/XbvpnMWJPkxjQCFjhm2hTeQkJtfrjV
 UTM=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Jan 2023 16:30:25 -0800
IronPort-SDR: keQAxe6RzRio/mfsE12Cv1HtuuNTCkhXTQpKt83XRPAjpYCIBcpTKX+/t39icfdGthxhFQC3+j
 xbyPK8fDPm8oytUuWLOXUmU1hhQE7j7DJpa69SCMy+2z2IDDioHglWAwRenLMT1SczY/eM8W9i
 Ucs/DmCZSz9MXpg6HlQ9bJo4t/U6M2XL/bwlL+jae2ckIdAAl9gMjt2yWQchJNONrXTAk2i9hU
 6sKtNvTPcv31tF+Pgl/Urk7GgI3JVgrCJMoGs8IyH3X/N/nBju2mljHSKxiZuFTMsonFYP/emo
 vKI=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Jan 2023 17:18:41 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4P3c5r5MGBz1RvTr
        for <linux-block@vger.kernel.org>; Fri, 27 Jan 2023 17:18:40 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1674868720; x=1677460721; bh=iJLp56gGVPr2tbKQVnE1mKbD4T1JMxn5/FC
        qcZ3APTI=; b=mvL2mLCN4i/rV1gK1ulhvwu84E7SjGyFHzAVZAePWpkx7a4TLYz
        o6KaJ0pReBm+sJi4O8r9S6SAsso1zauWXPwOrKkQeIgzdQZ4DlpDaeJ8X2zaO3wc
        z+OgE2Ck+48B+KyxH46/pVz+k25hvP1/El7CHTzCJwOh+RodJJMEQFPScXaI2FN8
        qSYn79oLHN4NOT4UGW4wgOzgJj9QWmjFPYyJ6z/+OYyHxZ+weQX9yAs2W0PdgyHw
        Oa9JGLIkcNRFXdhxMwWv+IILISIWGu5Ft2aqh5uBZuSNMpvTD4kBRdpkStwxQqOF
        9kRb0Nw26bFioHZla/B+iOuetPUkQ9mdWdQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 2KA2uHDN0_g2 for <linux-block@vger.kernel.org>;
        Fri, 27 Jan 2023 17:18:40 -0800 (PST)
Received: from [10.225.163.66] (unknown [10.225.163.66])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4P3c5q02syz1RvLy;
        Fri, 27 Jan 2023 17:18:38 -0800 (PST)
Message-ID: <ff478889-7a02-135f-57b6-f56d386d7065@opensource.wdc.com>
Date:   Sat, 28 Jan 2023 10:18:37 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] null_blk: Support configuring the maximum segment size
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>,
        Chaitanya Kulkarni <kch@nvidia.com>
References: <20230128005926.79336-1-bvanassche@acm.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20230128005926.79336-1-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/28/23 09:59, Bart Van Assche wrote:
> Add support for configuring the maximum segment size.
> 
> Add support for segments smaller than the page size.
> 
> This patch enables testing segments smaller than the page size with a
> driver that does not call blk_rq_map_sg().
> 
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Cc: Chaitanya Kulkarni <kch@nvidia.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  drivers/block/null_blk/main.c     | 19 ++++++++++++++++---
>  drivers/block/null_blk/null_blk.h |  1 +
>  2 files changed, 17 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
> index 4c601ca9552a..06eaa7ff4a86 100644
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
> @@ -630,7 +636,8 @@ static ssize_t memb_group_features_show(struct config_item *item, char *page)
>  	return snprintf(page, PAGE_SIZE,
>  			"badblocks,blocking,blocksize,cache_size,"
>  			"completion_nsec,discard,home_node,hw_queue_depth,"
> -			"irqmode,max_sectors,mbps,memory_backed,no_sched,"
> +			"irqmode,max_sectors,max_segment_size,mbps,"
> +			"memory_backed,no_sched,"
>  			"poll_queues,power,queue_mode,shared_tag_bitmap,size,"
>  			"submit_queues,use_per_node_hctx,virt_boundary,zoned,"
>  			"zone_capacity,zone_max_active,zone_max_open,"
> @@ -693,6 +700,7 @@ static struct nullb_device *null_alloc_dev(void)
>  	dev->queue_mode = g_queue_mode;
>  	dev->blocksize = g_bs;
>  	dev->max_sectors = g_max_sectors;
> +	dev->max_segment_size = g_max_segment_size;
>  	dev->irqmode = g_irqmode;
>  	dev->hw_queue_depth = g_hw_queue_depth;
>  	dev->blocking = g_blocking;
> @@ -1234,6 +1242,8 @@ static int null_transfer(struct nullb *nullb, struct page *page,
>  	unsigned int valid_len = len;
>  	int err = 0;
>  
> +	WARN_ONCE(len > dev->max_segment_size, "%u > %u\n", len,
> +		  dev->max_segment_size);

Shouldn't this be an EIO return as this is not supposed to happen ?

>  	if (!is_write) {
>  		if (dev->zoned)
>  			valid_len = null_zone_valid_read_len(nullb,
> @@ -1269,7 +1279,8 @@ static int null_handle_rq(struct nullb_cmd *cmd)
>  
>  	spin_lock_irq(&nullb->lock);
>  	rq_for_each_segment(bvec, rq, iter) {
> -		len = bvec.bv_len;
> +		len = min(bvec.bv_len, nullb->dev->max_segment_size);
> +		bvec.bv_len = len;
>  		err = null_transfer(nullb, bvec.bv_page, len, bvec.bv_offset,
>  				     op_is_write(req_op(rq)), sector,
>  				     rq->cmd_flags & REQ_FUA);
> @@ -1296,7 +1307,8 @@ static int null_handle_bio(struct nullb_cmd *cmd)
>  
>  	spin_lock_irq(&nullb->lock);
>  	bio_for_each_segment(bvec, bio, iter) {
> -		len = bvec.bv_len;
> +		len = min(bvec.bv_len, nullb->dev->max_segment_size);
> +		bvec.bv_len = len;
>  		err = null_transfer(nullb, bvec.bv_page, len, bvec.bv_offset,
>  				     op_is_write(bio_op(bio)), sector,
>  				     bio->bi_opf & REQ_FUA);
> @@ -2125,6 +2137,7 @@ static int null_add_dev(struct nullb_device *dev)
>  		dev->max_sectors = queue_max_hw_sectors(nullb->q);
>  	dev->max_sectors = min(dev->max_sectors, BLK_DEF_MAX_SECTORS);
>  	blk_queue_max_hw_sectors(nullb->q, dev->max_sectors);
> +	blk_queue_max_segment_size(nullb->q, dev->max_segment_size);
>  
>  	if (dev->virt_boundary)
>  		blk_queue_virt_boundary(nullb->q, PAGE_SIZE - 1);
> diff --git a/drivers/block/null_blk/null_blk.h b/drivers/block/null_blk/null_blk.h
> index eb5972c50be8..8cb73fe05fa3 100644
> --- a/drivers/block/null_blk/null_blk.h
> +++ b/drivers/block/null_blk/null_blk.h
> @@ -102,6 +102,7 @@ struct nullb_device {
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

