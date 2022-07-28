Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF0A4C04A68
	for <linux-block@archiver.kernel.org>; Thu, 28 Jul 2022 02:54:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234905AbiG1CyR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Jul 2022 22:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234759AbiG1CyN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Jul 2022 22:54:13 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A47954C8B
        for <linux-block@vger.kernel.org>; Wed, 27 Jul 2022 19:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1658976852; x=1690512852;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GSr/pP4m0bHkfNC+g6XCtP9uY3KjMFGPPT9S8YRebJE=;
  b=mxuroZ5p5urrDs286L5dW8LIbsMtmmwsIcdnYffQ9QYDSZSrSYs3OA8C
   xjmTSlShPETXqBm/9PS4FMTa/YB3HiU2RcKrJZaW2gdWIR5JUJPGJVyyc
   tT0K4LIWy6+Lyzb8gXTq62fNSDEApSp80g82L9MHp86DKOygqt4RtlCgp
   jgqiA6STA20Ssa9jyf6uUOu0c07Omrr1CO32cvoxijF79omsxvQkDuZOh
   VV3UrqE9XTvyIxHsi8AiuqKYBaEsWil7l1Wu/2qj01G+J6GYn0ZfIHLTx
   a76cvfr6CKMc8KA90svBR2mX2NjZn9XfcocN65bAFhAwqvR01cnVns/2J
   w==;
X-IronPort-AV: E=Sophos;i="5.93,196,1654531200"; 
   d="scan'208";a="311432502"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jul 2022 10:54:10 +0800
IronPort-SDR: nxDnf5gYt3dWRy3dBFCDdi5VUN0OXl/HQwi7K0kkhnUblERqIwUo8mUBL6TJedglXJnQM2J+M3
 Y9qU1JEb37UGFINgSRC9FfAckL2x/QvmJof0I/g5SpZrgR3VxIwJRB/3cOoi1NmhMnMHgjjZv4
 z0XXJJ04VhkmXUQAUagQuYEeP9lbdORD8FNX8ffkuj8Ppwb2du/7JpoeAThosXgXCxOFza3/ae
 grXqFBSJtXH6tKFJ3aoMf2IaMJB80QQy3pC3XagMC76p1iVUcI0p5skVVo2Mi/uPBPr/s/HHuv
 c26rtzgejxchnTQ2YWn/TYUf
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Jul 2022 19:10:17 -0700
IronPort-SDR: kzOyMM470b4KG/rWtlDzMR7e1UoJWZEQ4rUo2MCs5jOk903Z3TZfCUEitt9C8jY4DVtmbyrMPN
 SvAFOdh31GUefGaSR9j8R8UTpuzcoBf7jX13fYbS+Q/qtubLD9DZ+j1P4NVt7uJxOUII7aG5jr
 pq3ik2L08oL5p4rCaN7M75pMinMC3PPgtd6diMtwtXAiI04lOfnsAR4i64Hy6+wZZUbtcgJ+MK
 vuCle9SJgJxK9Ol2YM5lr/Jv/Ru6hctYFfaHFo1gfLFI+Y1FRANqdSidVAPvHdWdHy7/u21A0V
 m1Q=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Jul 2022 19:54:10 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LtZww6ssKz1Rwry
        for <linux-block@vger.kernel.org>; Wed, 27 Jul 2022 19:54:08 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1658976847; x=1661568848; bh=GSr/pP4m0bHkfNC+g6XCtP9uY3KjMFGPPT9
        S8YRebJE=; b=iAJOSVTr2atboaLSeqpeZri+S/tNSsrkHPx1mz1zbwzdF01DBQc
        waKcUZcHGbMLRL7E+eKen1a9JeWBM6bjHtrG3dg5HctisEKSlnjiqRAId1IKriTN
        pOMFX54PQK8efX+3ZmACMszslwuajReZ7M1uqN5PhD4B7mVC7ncMQ/y8toKmyLr4
        WuqpZzz26skvJhJYEHjbULz/9J9HKVtQuP+MaQJxgHRyNFS5jwt6VNEMWezf/J4x
        fa3zIwVODklXpd8x+hCvrqA+Rqnvbguz3uMb96IaKsIKym0eYPRrxEQOByu09FAq
        9uvbgYTQuHr8xCxzy6GDpMlxJjOgso2Qk8g==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id VCmsgJueSMX6 for <linux-block@vger.kernel.org>;
        Wed, 27 Jul 2022 19:54:07 -0700 (PDT)
Received: from [10.225.163.14] (unknown [10.225.163.14])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LtZwr6MMlz1RtVk;
        Wed, 27 Jul 2022 19:54:04 -0700 (PDT)
Message-ID: <8e0c4a9f-de4a-d53e-efef-0b27017ec78d@opensource.wdc.com>
Date:   Thu, 28 Jul 2022 11:54:03 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v8 01/11] block: make bdev_nr_zones and disk_zone_no
 generic for npo2 zsze
Content-Language: en-US
To:     Pankaj Raghav <p.raghav@samsung.com>, hch@lst.de, axboe@kernel.dk,
        snitzer@kernel.org, Johannes.Thumshirn@wdc.com
Cc:     matias.bjorling@wdc.com, gost.dev@samsung.com,
        linux-kernel@vger.kernel.org, hare@suse.de,
        linux-block@vger.kernel.org, pankydev8@gmail.com,
        bvanassche@acm.org, jaegeuk@kernel.org, dm-devel@redhat.com,
        linux-nvme@lists.infradead.org,
        Luis Chamberlain <mcgrof@kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>
References: <20220727162245.209794-1-p.raghav@samsung.com>
 <CGME20220727162247eucas1p203fc14aa17ecbcb3e6215d5304bb0c85@eucas1p2.samsung.com>
 <20220727162245.209794-2-p.raghav@samsung.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220727162245.209794-2-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/28/22 01:22, Pankaj Raghav wrote:
> Adapt bdev_nr_zones and disk_zone_no function so that it can

s/function/functions
s/it/they

> also work for non-power-of-2 zone sizes.
> 
> As the existing deployments of zoned devices had power-of-2

had power-of-2 assumption -> assume that a device zone size is a power of
2 number of sectors

Existing deployments still exist, so do not use the past tense please.

> assumption, power-of-2 optimized calculation is kept for those devices.
> 
> There are no direct hot paths modified and the changes just
> introduce one new branch per call.
> 
> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
> Reviewed-by: Adam Manzanares <a.manzanares@samsung.com>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  block/blk-zoned.c      | 13 +++++++++----
>  include/linux/blkdev.h |  8 +++++++-
>  2 files changed, 16 insertions(+), 5 deletions(-)
> 
> diff --git a/block/blk-zoned.c b/block/blk-zoned.c
> index a264621d4905..dce9c95b4bcd 100644
> --- a/block/blk-zoned.c
> +++ b/block/blk-zoned.c
> @@ -111,17 +111,22 @@ EXPORT_SYMBOL_GPL(__blk_req_zone_write_unlock);
>   * bdev_nr_zones - Get number of zones
>   * @bdev:	Target device
>   *
> - * Return the total number of zones of a zoned block device.  For a block
> - * device without zone capabilities, the number of zones is always 0.
> + * Return the total number of zones of a zoned block device, including the
> + * eventual small last zone if present. For a block device without zone
> + * capabilities, the number of zones is always 0.
>   */
>  unsigned int bdev_nr_zones(struct block_device *bdev)
>  {
>  	sector_t zone_sectors = bdev_zone_sectors(bdev);
> +	sector_t capacity = bdev_nr_sectors(bdev);
>  
>  	if (!bdev_is_zoned(bdev))
>  		return 0;
> -	return (bdev_nr_sectors(bdev) + zone_sectors - 1) >>
> -		ilog2(zone_sectors);
> +
> +	if (is_power_of_2(zone_sectors))
> +		return (capacity + zone_sectors - 1) >> ilog2(zone_sectors);
> +
> +	return DIV_ROUND_UP_SECTOR_T(capacity, zone_sectors);
>  }
>  EXPORT_SYMBOL_GPL(bdev_nr_zones);
>  
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index dccdf1551c62..85b832908f28 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -673,9 +673,15 @@ static inline unsigned int disk_nr_zones(struct gendisk *disk)
>  
>  static inline unsigned int disk_zone_no(struct gendisk *disk, sector_t sector)
>  {
> +	sector_t zone_sectors = disk->queue->limits.chunk_sectors;
> +
>  	if (!blk_queue_is_zoned(disk->queue))
>  		return 0;
> -	return sector >> ilog2(disk->queue->limits.chunk_sectors);
> +
> +	if (is_power_of_2(zone_sectors))
> +		return sector >> ilog2(zone_sectors);
> +
> +	return div64_u64(sector, zone_sectors);
>  }
>  
>  static inline bool disk_zone_is_seq(struct gendisk *disk, sector_t sector)


-- 
Damien Le Moal
Western Digital Research
