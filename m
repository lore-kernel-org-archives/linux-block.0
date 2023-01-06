Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E222CC3DA7A
	for <linux-block@archiver.kernel.org>; Fri,  6 Jan 2023 11:00:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232599AbjAFLAy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 6 Jan 2023 06:00:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232688AbjAFLAt (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 6 Jan 2023 06:00:49 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4059D6E42D
        for <linux-block@vger.kernel.org>; Fri,  6 Jan 2023 03:00:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1673002845; x=1704538845;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=dzMGYcC76vsGLcqnozoVnvpsbbrZPxZlS6l3+6NEWPY=;
  b=VDtpwSlKu7lJ64v3F1rFz7XAjkj6KO7yhJcUIF0tnKZ9A9A7D6dyRin/
   vqQdJOJwGBWy4yB97z3WB5Zsd1RbPETRry9POFXcCEnMI8uFkwieyqAF8
   nY/HKMDMtwMfvWfmArYG/K2JGNFQkhMvnp9yQz9DxPW9Li+wBqYpZYfxg
   v0XVLvUQE85z5arfo6K1BVFBky+GOblUtdIS0fmoQ0vCC5yEDz+R+iaOz
   SZRrLSgsN/myU55+8ybl5wBIWo3rQ/8D8eoPvxqbqzuwGMP/P3sHsDn6M
   53YlnPlnsBCLY7URBBNIVQiUfSN2plW6RuiXj/ufFPPUNVuuM/RV0hL9g
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,305,1665417600"; 
   d="scan'208";a="225224632"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 06 Jan 2023 19:00:43 +0800
IronPort-SDR: tiGyv+sp92xU23//kCL9DAYxpMNfvhbZ7OuQtD2wTcuIAYv5RyPkrurPv/X2RUxq5xcvdidRV1
 uNrLDE/RPduqixO5pr0XsSRERK7RNAHl4PcVxjbZfwXOIdvBA1HC6yKnnZ4MlxdPvMb46paBBv
 u443A2RuJbF2jvzJ5n6/+zQfs+QZR2d+s7LQkYI5C0+1kSvyOvknNTWV76g7DJb//9tBo/j64k
 umDKYOLBT0Z0mJs7uS3FyFxu1X1cvYQIjsZrow81dQeJK805AnJq1hQsS+RBu9azNGO7trJ8vc
 u/I=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Jan 2023 02:12:53 -0800
IronPort-SDR: L1QtWZkE0SHZT/393pgtx6pK1IHYIosECj4bxjkfAilrm8mrTioptrM3CP6sqOre3xXuhSXOiY
 QbG8AywrIGdv9V+IIlyIPrRxcfA6f0QpsRukspZv6sa37Rz294ihdOvzgHA7n98aYvEF77sRwh
 2z4bZZ94QoIGqdfNLt2Jg+MWOKwmlN9xE2mljuRUDqqTTcFTOMz/OxnbGYpkMGRSPlBrqlGwbP
 FydFgeLonugbBxd2mwfLYQ1qSyhvYfgY54qrLYBtTsMzrXw8qXmnSEcPK2JyPu9wUQt+f4cKjA
 4i0=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Jan 2023 03:00:45 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NpL3b1sxKz1Rwt8
        for <linux-block@vger.kernel.org>; Fri,  6 Jan 2023 03:00:43 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1673002841; x=1675594842; bh=dzMGYcC76vsGLcqnozoVnvpsbbrZPxZlS6l
        3+6NEWPY=; b=bI2spnR+FSiaJZD4rCqOcAS5ZC4aFxAg5nxQYH9ZyzdPB6qzPqK
        qJl9DAxhBKDWf75kvgRz6sFKhkvGo50dpTfOtfOw5I8MQXCgPtZvgnoa/XgMBmkC
        wJHygiz9VZ/Az5WOlI3Sdx7uHm/Ao6zAZDxNQktjEiG78uC3st3QbwZQLWOukKxZ
        DUDsw4M1M3dbDDQNyDNtaAOQjAiUl5Sw1+bS5x7hERVnVcEQQFO1JwIP8BGbgppB
        FOg+lp5YUtPl5ESQQVtmFQMXdwq9uWaQHrrW3FyDCmkFvGTM0kyzMmxZI6O0eUPi
        Qtj2WFVnjNkfsy2c8K9rcPVMSkjP2XxaCmA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id UbGaDG-cDWgU for <linux-block@vger.kernel.org>;
        Fri,  6 Jan 2023 03:00:41 -0800 (PST)
Received: from [10.149.53.254] (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NpL3X00tLz1RvLy;
        Fri,  6 Jan 2023 03:00:39 -0800 (PST)
Message-ID: <32aaa034-dc39-75dd-f4ec-e0e5ef9dd29c@opensource.wdc.com>
Date:   Fri, 6 Jan 2023 20:00:38 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 2/7] block: add a new helper bdev_{is_zone_start,
 offset_from_zone_start}
Content-Language: en-US
To:     Pankaj Raghav <p.raghav@samsung.com>, axboe@kernel.dk
Cc:     kernel@pankajraghav.com, linux-kernel@vger.kernel.org,
        hare@suse.de, bvanassche@acm.org, snitzer@kernel.org,
        dm-devel@redhat.com, linux-nvme@lists.infradead.org, hch@lst.de,
        linux-block@vger.kernel.org, gost.dev@samsung.com
References: <20230106083317.93938-1-p.raghav@samsung.com>
 <CGME20230106083320eucas1p1f8de0c6ecf351738e8f0ee5f3390d94f@eucas1p1.samsung.com>
 <20230106083317.93938-3-p.raghav@samsung.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20230106083317.93938-3-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/6/23 17:33, Pankaj Raghav wrote:
> Instead of open coding to check for zone start, add a helper to improve
> readability and store the logic in one place.
> 
> bdev_offset_from_zone_start() will be used later in the series.
> 
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>  block/blk-core.c       |  2 +-
>  block/blk-zoned.c      |  4 ++--
>  include/linux/blkdev.h | 18 ++++++++++++++++++
>  3 files changed, 21 insertions(+), 3 deletions(-)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 9321767470dc..0405b3144e7a 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -573,7 +573,7 @@ static inline blk_status_t blk_check_zone_append(struct request_queue *q,
>  		return BLK_STS_NOTSUPP;
>  
>  	/* The bio sector must point to the start of a sequential zone */
> -	if (bio->bi_iter.bi_sector & (bdev_zone_sectors(bio->bi_bdev) - 1) ||
> +	if (!bdev_is_zone_start(bio->bi_bdev, bio->bi_iter.bi_sector) ||
>  	    !bio_zone_is_seq(bio))
>  		return BLK_STS_IOERR;
>  
> diff --git a/block/blk-zoned.c b/block/blk-zoned.c
> index db829401d8d0..614b575be899 100644
> --- a/block/blk-zoned.c
> +++ b/block/blk-zoned.c
> @@ -277,10 +277,10 @@ int blkdev_zone_mgmt(struct block_device *bdev, enum req_op op,
>  		return -EINVAL;
>  
>  	/* Check alignment (handle eventual smaller last zone) */
> -	if (sector & (zone_sectors - 1))
> +	if (!bdev_is_zone_start(bdev, sector))
>  		return -EINVAL;
>  
> -	if ((nr_sectors & (zone_sectors - 1)) && end_sector != capacity)
> +	if (!bdev_is_zone_start(bdev, nr_sectors) && end_sector != capacity)
>  		return -EINVAL;
>  
>  	/*
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 0e40b014c40b..04b7cbfd7a2a 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -715,6 +715,7 @@ static inline unsigned int disk_zone_no(struct gendisk *disk, sector_t sector)
>  {
>  	return 0;
>  }
> +

whiteline change

>  static inline unsigned int bdev_max_open_zones(struct block_device *bdev)
>  {
>  	return 0;
> @@ -1304,6 +1305,23 @@ static inline sector_t bdev_zone_sectors(struct block_device *bdev)
>  	return q->limits.chunk_sectors;
>  }
>  
> +static inline sector_t bdev_offset_from_zone_start(struct block_device *bdev,
> +						   sector_t sec)
> +{
> +	if (!bdev_is_zoned(bdev))

this helper should never be called outside of code supporting zones. So
why this check ?

> +		return 0;
> +
> +	return sec & (bdev_zone_sectors(bdev) - 1);
> +}
> +
> +static inline bool bdev_is_zone_start(struct block_device *bdev, sector_t sec)
> +{
> +	if (!bdev_is_zoned(bdev))
> +		return false;

Same here.

> +
> +	return bdev_offset_from_zone_start(bdev, sec) == 0;
> +}
> +
>  static inline int queue_dma_alignment(const struct request_queue *q)
>  {
>  	return q ? q->limits.dma_alignment : 511;

-- 
Damien Le Moal
Western Digital Research

