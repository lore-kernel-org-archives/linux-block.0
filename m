Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFBA8C433FE
	for <linux-block@archiver.kernel.org>; Thu, 20 Oct 2022 23:13:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbiJTXNh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Oct 2022 19:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbiJTXNb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Oct 2022 19:13:31 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0443A22EC8D
        for <linux-block@vger.kernel.org>; Thu, 20 Oct 2022 16:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666307606; x=1697843606;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=eXgtPHllD7O0YHoe8GtjVPbOrFIx/lqPgJgfb0ZdJG4=;
  b=P+2OKZPKipmQT3wbXQDQ5scmX94LfBbAZWCMKBDKkxigFtZ1GZDLehwX
   Aqy+4sqtcVB7LiCDlNTi7T+7+Irm2v4+KQgHh2xjt3ZjvWeI+WkxA9OPE
   3ujEazPYeh+v8spxfCuRSuri6nkQFRRHBVDRo00DOcJmPF0zLQn1B7CkN
   DFcBTJX4qPnJAJKX1O8VNGbGs4rmTybE5keW6QS5eH8I5V58B5xPuE6iY
   IE7cQoPLDGCMhEPA0MxKiSLm+qoy+IYKgL9E6scSsGjc9Es4H4QaKLyv4
   cQeRLn5GVBNFr8aWOYV7Hx2xGW0dZiPLQv0tzhiNl12b1LUbYP/xB2KV2
   Q==;
X-IronPort-AV: E=Sophos;i="5.95,200,1661788800"; 
   d="scan'208";a="318702937"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 21 Oct 2022 07:13:23 +0800
IronPort-SDR: 9ZZzVOGhK7htloEVCjM83fAY6j60zLNMUT/pYeA2pD1XcJfTOiuOy9VAfa+fDOnqlpvVgiifdQ
 b7P68dXaVstiVm6Dcf7SOoGXrAomYoEgr3u7Idr0A3ibbEJbfcPCi0/zufzLi4Okk6LH/SztU5
 YdrPwPCBFd/rvwUm3F3vHn0c9XLUyzLSKL67gjVNL9X5BuCUN1H3h62AI6L2LO+jotMlzE2hte
 Rrs1Eqh4RBJybalmuWojgzEyFs4npqJbfq0mqzq8RDrSPACVuaUchAJUR2ld8oeYjtV9AWAGLg
 EZBfNLSlMFRZoArRh/Raeetg
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Oct 2022 15:32:51 -0700
IronPort-SDR: K2NnTcX2RE3u0xXAo8kUOXtm1bmTwGsGp66UJMVCfxgwGMn4iQ6Onhyx6MC0NyYIMOLh/f0MQL
 RnMiSidbhZWQEoYYBJfvy0IftmoV52A/U0P1YQVU/VJDNQI1odIkaL5CkWBt9GawUSBqUubTSb
 8sExiI76k8Bw9wH39jdZ0Uvh9E2oBdX8u0i8hwM3vHZnV9bd7TRP4BJDS33MbDZT1MiFXVBHw7
 lSMSPOgsqNCFr8mNeR1YxcVIpcPdLVtP2lK7DDd7X8SdZNE6e6xXBKBExAlM9iTL66o4WVm3zc
 XNM=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Oct 2022 16:13:24 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Mtk0z0Vy9z1Rwtl
        for <linux-block@vger.kernel.org>; Thu, 20 Oct 2022 16:13:23 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1666307601; x=1668899602; bh=eXgtPHllD7O0YHoe8GtjVPbOrFIx/lqPgJg
        fb0ZdJG4=; b=rm7q1z3s5J2ZHG1UEvjVHrV3dqk7Lj90goqMRzlyQedreizSvQB
        DQ0Q1HUTH1Gf3tB0Ymzkai68Aqi8QH/9HER56BtbhkvTmhIXZ8um9p/D+D2g7n83
        nE9yRIl9d990fT4idaEMUbV+mIlCFPufUfJ2vrE7gylJTZn4fr46IjSc2eSKP6+l
        9lpUQ3+cL2OMEzHmfsNZIp/BCLDHaHWx4fv1OUdsqOlkJ0XSBlZ9dDxGYAkSib3l
        4rD5Egsbo6E6qEiszxsoWVhq8CnR8EcQpu2tJqQ4lit9v58scKbcfKjaJuGzKRzw
        LA8dsqatKw0fnx6N+NBbf4b8JHDArpUVxrg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Z45F5fsvBfhg for <linux-block@vger.kernel.org>;
        Thu, 20 Oct 2022 16:13:21 -0700 (PDT)
Received: from [10.225.163.126] (unknown [10.225.163.126])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Mtk0w1Twbz1RvLy;
        Thu, 20 Oct 2022 16:13:20 -0700 (PDT)
Message-ID: <6a72dd3a-2b84-9345-9782-1ef2fe9caa07@opensource.wdc.com>
Date:   Fri, 21 Oct 2022 08:13:19 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 10/10] null_blk: Support configuring the maximum segment
 size
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Vincent Fu <vincent.fu@samsung.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Yu Kuai <yukuai3@huawei.com>
References: <20221019222324.362705-1-bvanassche@acm.org>
 <20221019222324.362705-11-bvanassche@acm.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20221019222324.362705-11-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/20/22 07:23, Bart Van Assche wrote:
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
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  drivers/block/null_blk/main.c     | 20 +++++++++++++++++---
>  drivers/block/null_blk/null_blk.h |  1 +
>  2 files changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
> index 1f154f92f4c2..bc811ab52c4a 100644
> --- a/drivers/block/null_blk/main.c
> +++ b/drivers/block/null_blk/main.c
> @@ -157,6 +157,10 @@ static int g_max_sectors;
>  module_param_named(max_sectors, g_max_sectors, int, 0444);
>  MODULE_PARM_DESC(max_sectors, "Maximum size of a command (in 512B sectors)");
>  
> +static unsigned int g_max_segment_size = 1UL << 31;

Nit: UINT_MAX ?

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
> @@ -532,6 +537,7 @@ static struct configfs_attribute *nullb_device_attrs[] = {
>  	&nullb_device_attr_queue_mode,
>  	&nullb_device_attr_blocksize,
>  	&nullb_device_attr_max_sectors,
> +	&nullb_device_attr_max_segment_size,
>  	&nullb_device_attr_irqmode,
>  	&nullb_device_attr_hw_queue_depth,
>  	&nullb_device_attr_index,
> @@ -610,7 +616,8 @@ static ssize_t memb_group_features_show(struct config_item *item, char *page)
>  	return snprintf(page, PAGE_SIZE,
>  			"badblocks,blocking,blocksize,cache_size,"
>  			"completion_nsec,discard,home_node,hw_queue_depth,"
> -			"irqmode,max_sectors,mbps,memory_backed,no_sched,"
> +			"irqmode,max_sectors,max_segment_size,mbps,"
> +			"memory_backed,no_sched,"
>  			"poll_queues,power,queue_mode,shared_tag_bitmap,size,"
>  			"submit_queues,use_per_node_hctx,virt_boundary,zoned,"
>  			"zone_capacity,zone_max_active,zone_max_open,"
> @@ -673,6 +680,7 @@ static struct nullb_device *null_alloc_dev(void)
>  	dev->queue_mode = g_queue_mode;
>  	dev->blocksize = g_bs;
>  	dev->max_sectors = g_max_sectors;
> +	dev->max_segment_size = g_max_segment_size;
>  	dev->irqmode = g_irqmode;
>  	dev->hw_queue_depth = g_hw_queue_depth;
>  	dev->blocking = g_blocking;
> @@ -1214,6 +1222,8 @@ static int null_transfer(struct nullb *nullb, struct page *page,
>  	unsigned int valid_len = len;
>  	int err = 0;
>  
> +	WARN_ONCE(len > dev->max_segment_size, "%u > %u\n", len,
> +		  dev->max_segment_size);
>  	if (!is_write) {
>  		if (dev->zoned)
>  			valid_len = null_zone_valid_read_len(nullb,
> @@ -1249,7 +1259,8 @@ static int null_handle_rq(struct nullb_cmd *cmd)
>  
>  	spin_lock_irq(&nullb->lock);
>  	rq_for_each_segment(bvec, rq, iter) {
> -		len = bvec.bv_len;
> +		len = min(bvec.bv_len, nullb->dev->max_segment_size);
> +		bvec.bv_len = len;
>  		err = null_transfer(nullb, bvec.bv_page, len, bvec.bv_offset,
>  				     op_is_write(req_op(rq)), sector,
>  				     rq->cmd_flags & REQ_FUA);
> @@ -1276,7 +1287,8 @@ static int null_handle_bio(struct nullb_cmd *cmd)
>  
>  	spin_lock_irq(&nullb->lock);
>  	bio_for_each_segment(bvec, bio, iter) {
> -		len = bvec.bv_len;
> +		len = min(bvec.bv_len, nullb->dev->max_segment_size);
> +		bvec.bv_len = len;
>  		err = null_transfer(nullb, bvec.bv_page, len, bvec.bv_offset,
>  				     op_is_write(bio_op(bio)), sector,
>  				     bio->bi_opf & REQ_FUA);
> @@ -2088,6 +2100,7 @@ static int null_add_dev(struct nullb_device *dev)
>  	nullb->q->queuedata = nullb;
>  	blk_queue_flag_set(QUEUE_FLAG_NONROT, nullb->q);
>  	blk_queue_flag_clear(QUEUE_FLAG_ADD_RANDOM, nullb->q);
> +	blk_queue_flag_set(QUEUE_FLAG_SUB_PAGE_SEGMENTS, nullb->q);

Where is this defined ? I do not see this flag defined anywhere in Linus
tree nor in Jens for-next...

>  
>  	mutex_lock(&lock);
>  	rv = ida_simple_get(&nullb_indexes, 0, 0, GFP_KERNEL);
> @@ -2106,6 +2119,7 @@ static int null_add_dev(struct nullb_device *dev)
>  	dev->max_sectors = min_t(unsigned int, dev->max_sectors,
>  				 BLK_DEF_MAX_SECTORS);
>  	blk_queue_max_hw_sectors(nullb->q, dev->max_sectors);
> +	blk_queue_max_segment_size(nullb->q, dev->max_segment_size);
>  
>  	if (dev->virt_boundary)
>  		blk_queue_virt_boundary(nullb->q, PAGE_SIZE - 1);
> diff --git a/drivers/block/null_blk/null_blk.h b/drivers/block/null_blk/null_blk.h
> index 94ff68052b1e..6784ee9f5fda 100644
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

