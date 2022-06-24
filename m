Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7649C433EF
	for <linux-block@archiver.kernel.org>; Fri, 24 Jun 2022 00:29:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbiFXA3c (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Jun 2022 20:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbiFXA3a (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Jun 2022 20:29:30 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F19F049B48
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 17:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1656030570; x=1687566570;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+LqrAxZB4O8IlwGZM86CmUnhr6e88gOs5IN9Q8s8QVk=;
  b=I2sokD+IwzHRR7f1W7r23L3QT9LTNyphGbyaog+0V3hici/VoZV6hhwr
   UoXoTQwIIa94I8seBPc2G7dKvQ/RGTYeqltzLSq7N1QEGSbLtghh2eOTa
   mHH1JIrSt/hXeuqEjf2CbF7SfZQTxZ2mRAidcuQC+mq4Tb61Q9udUcXit
   3mE//GUUIZy6nm7wtrRmPalSOQJ2L4Ejim6vtys79ML6jGU/kde3cTp5x
   tbzlHM1TqGJc3OXR4zdg1O6UsXe/hJEiaEV6ixwfp0B65xS2eiegaGrKl
   orTQVWBFtnICquKX2fciBlk58+miFcNp55hCdLH/M8kf8D87e5tRBiU6q
   A==;
X-IronPort-AV: E=Sophos;i="5.92,217,1650902400"; 
   d="scan'208";a="204716970"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 24 Jun 2022 08:29:30 +0800
IronPort-SDR: zEjky7+kjLKbE59DSZOTjc1bjMuGtbKSQj5JTk1/VgU4bx66+cFdeLE9Mzr+35WTcuy4cAuiHe
 ODAkromwmjCs4AqNLpYtRQgGBtfytASzR/eFjayiThNfrR9qEWNoFuhzFC2wAWW2QdQ+CtX4tL
 D9wHs3uYrHqTKJzQg1n8CPgBGOBzhWFUSib81MzCBUw6dXstgcAB8qKhSPxnr/FOJlEST3D4W3
 u7PAVUeFebFhl2WIN9aYKoniJdVroGzqFj2BlO1LeDUEhaiqv4YV8wClAdKPX08eVT+mKozuPU
 ezUu1Z7aW6KK2gtq/fKAnxRi
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Jun 2022 16:51:56 -0700
IronPort-SDR: LBAHNtOjsuF3wSdMbx/ysuskHxpuut2ZdVRbbOAc0Bd2GypY4/J95om7QdfqudlhXoxh0sMGVu
 ddWUWh+3PxgZxYlD51kwiwsGOCIDazKH5fywG2EutJRfLrHzuUfBDKIxwVOWxmttcnR/nkpY5y
 8RJdLhssD89hgih6jvION7yL2rtrG/wE3sQ3pT4su/ndcIAPnp167gvRGtFiv4PpRtyl41PeWU
 xTT+u+B6mBmPUOAhvK289RR+EGOOXxG5aMblISjr0WNs6LCJsdR9QJuE5h6Wng7Ai8XQe4Fd5N
 Lss=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Jun 2022 17:29:29 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LTdKj1XF6z1Rwnm
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 17:29:29 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1656030568; x=1658622569; bh=+LqrAxZB4O8IlwGZM86CmUnhr6e88gOs5IN
        9Q8s8QVk=; b=Hmd19Qb9xCGdNVylhIjchRDvhwNf9Zq7mGJ5gzdmJWvOCs5KmBL
        Tg1dVHrEwiokmx2BZBAkP9M6mkUowOC54JKAQv2p0635cgIeDi1RiFzt0d0xMTC2
        nRmB5aQO/6dt8JYnH+vPGXAMjIF97Ta/+iv/BGnjZNFkLvTrZpG4W/QqLMffws7D
        ECHZ720f+QinNcGIV+xP80UioZlx4+AaRbidq/paamKfpX3Cmd5IlfvOJMa9ohyN
        H+T/tBVuujGpkUHfDvgbstAWyBNDEFVm+Gdpa+Vl2fDMbW9dNos3O5JZYPEqgG/c
        oSH2JLg331YX7pbJ1lbck7u+e7B16zI1A0g==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id yL9qMrTEJyLO for <linux-block@vger.kernel.org>;
        Thu, 23 Jun 2022 17:29:28 -0700 (PDT)
Received: from [10.225.163.93] (unknown [10.225.163.93])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LTdKg68tBz1RtVk;
        Thu, 23 Jun 2022 17:29:27 -0700 (PDT)
Message-ID: <4328cfcd-902d-49b9-dd36-e8c1577ee1f3@opensource.wdc.com>
Date:   Fri, 24 Jun 2022 09:29:26 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 6/6] block/null_blk: Add support for pipelining zoned
 writes
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <20220623232603.3751912-1-bvanassche@acm.org>
 <20220623232603.3751912-7-bvanassche@acm.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220623232603.3751912-7-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/24/22 08:26, Bart Van Assche wrote:
> Add a new configfs attribute for enabling pipelining of zoned writes. If
> that attribute has been set, retry zoned writes that are not aligned with
> the write pointer. The test script below reports 236 K IOPS with no I/O
> scheduler, 81 K IOPS with mq-deadline and pipelining disabled and 121 K
> IOPS with mq-deadline and pipelining enabled (+49%).
> 
>     #!/bin/bash
> 
>     for d in /sys/kernel/config/nullb/*; do
>         [ -d "$d" ] && rmdir "$d"
>     done
>     modprobe -r null_blk
>     set -e
>     modprobe null_blk nr_devices=0
>     udevadm settle
>     (
>         cd /sys/kernel/config/nullb
>         mkdir nullb0
>         cd nullb0
>         params=(
> 	    completion_nsec=100000
> 	    hw_queue_depth=64
> 	    irqmode=2
> 	    memory_backed=1
> 	    pipeline_zoned_writes=1
> 	    size=1
> 	    submit_queues=1
> 	    zone_size=1
> 	    zoned=1
> 	    power=1
>         )
>         for p in "${params[@]}"; do
> 	    echo "${p//*=}" > "${p//=*}"
>         done
>     )
>     params=(
>         --direct=1
>         --filename=/dev/nullb0
>         --iodepth=64
>         --iodepth_batch=16
>         --ioengine=io_uring
>         --ioscheduler=mq-deadline
> 	--hipri=0
>         --name=nullb0
>         --runtime=30
>         --rw=write
>         --time_based=1
>         --zonemode=zbd
>     )
>     fio "${params[@]}"
> 
> Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  drivers/block/null_blk/main.c     | 9 +++++++++
>  drivers/block/null_blk/null_blk.h | 3 +++
>  drivers/block/null_blk/zoned.c    | 4 +++-
>  3 files changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
> index fd68e6f4637f..d5fc651ffc3d 100644
> --- a/drivers/block/null_blk/main.c
> +++ b/drivers/block/null_blk/main.c
> @@ -408,6 +408,7 @@ NULLB_DEVICE_ATTR(zone_capacity, ulong, NULL);
>  NULLB_DEVICE_ATTR(zone_nr_conv, uint, NULL);
>  NULLB_DEVICE_ATTR(zone_max_open, uint, NULL);
>  NULLB_DEVICE_ATTR(zone_max_active, uint, NULL);
> +NULLB_DEVICE_ATTR(pipeline_zoned_writes, bool, NULL);
>  NULLB_DEVICE_ATTR(virt_boundary, bool, NULL);
>  
>  static ssize_t nullb_device_power_show(struct config_item *item, char *page)
> @@ -531,6 +532,7 @@ static struct configfs_attribute *nullb_device_attrs[] = {
>  	&nullb_device_attr_zone_nr_conv,
>  	&nullb_device_attr_zone_max_open,
>  	&nullb_device_attr_zone_max_active,
> +	&nullb_device_attr_pipeline_zoned_writes,
>  	&nullb_device_attr_virt_boundary,
>  	NULL,
>  };
> @@ -1626,6 +1628,11 @@ static blk_status_t null_queue_rq(struct blk_mq_hw_ctx *hctx,
>  	cmd->error = BLK_STS_OK;
>  	cmd->nq = nq;
>  	cmd->fake_timeout = should_timeout_request(rq);
> +	if (!(rq->rq_flags & RQF_DONTPREP)) {
> +		rq->rq_flags |= RQF_DONTPREP;
> +		cmd->retries = 0;
> +		cmd->max_attempts = rq->q->nr_hw_queues * rq->q->nr_requests;
> +	}
>  
>  	blk_mq_start_request(rq);
>  
> @@ -2042,6 +2049,8 @@ static int null_add_dev(struct nullb_device *dev)
>  	nullb->q->queuedata = nullb;
>  	blk_queue_flag_set(QUEUE_FLAG_NONROT, nullb->q);
>  	blk_queue_flag_clear(QUEUE_FLAG_ADD_RANDOM, nullb->q);
> +	if (dev->pipeline_zoned_writes)
> +		blk_queue_flag_set(QUEUE_FLAG_PIPELINE_ZONED_WRITES, nullb->q);
>  
>  	mutex_lock(&lock);
>  	nullb->index = ida_simple_get(&nullb_indexes, 0, 0, GFP_KERNEL);
> diff --git a/drivers/block/null_blk/null_blk.h b/drivers/block/null_blk/null_blk.h
> index 8359b43842f2..bbe2cb17bdbd 100644
> --- a/drivers/block/null_blk/null_blk.h
> +++ b/drivers/block/null_blk/null_blk.h
> @@ -23,6 +23,8 @@ struct nullb_cmd {
>  	unsigned int tag;
>  	blk_status_t error;
>  	bool fake_timeout;
> +	u16 retries;
> +	u16 max_attempts;
>  	struct nullb_queue *nq;
>  	struct hrtimer timer;
>  };
> @@ -112,6 +114,7 @@ struct nullb_device {
>  	bool memory_backed; /* if data is stored in memory */
>  	bool discard; /* if support discard */
>  	bool zoned; /* if device is zoned */
> +	bool pipeline_zoned_writes;
>  	bool virt_boundary; /* virtual boundary on/off for the device */
>  };
>  
> diff --git a/drivers/block/null_blk/zoned.c b/drivers/block/null_blk/zoned.c
> index 2fdd7b20c224..8d0a5e16f4b1 100644
> --- a/drivers/block/null_blk/zoned.c
> +++ b/drivers/block/null_blk/zoned.c
> @@ -403,7 +403,9 @@ static blk_status_t null_zone_write(struct nullb_cmd *cmd, sector_t sector,
>  		else
>  			cmd->bio->bi_iter.bi_sector = sector;
>  	} else if (sector != zone->wp) {
> -		ret = BLK_STS_IOERR;
> +		ret = dev->pipeline_zoned_writes &&
> +			++cmd->retries < cmd->max_attempts ?
> +			BLK_STS_DEV_RESOURCE : BLK_STS_IOERR;

Hard to read. Could you change this to a plain "if()" ?


		if (dev->pipeline_zoned_writes &&
		    ++cmd->retries < cmd->max_attempts)
			ret = BLK_STS_DEV_RESOURCE;
		else
			ret = BLK_STS_IOERR;

Adding a comment on top of this hunk explaining the difference between the
2 cases would be nice too.

>  		goto unlock;
>  	}
>  


-- 
Damien Le Moal
Western Digital Research
