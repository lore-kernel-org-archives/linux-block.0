Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC7EBC19F2D
	for <linux-block@archiver.kernel.org>; Thu, 11 Aug 2022 20:21:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235560AbiHKUV5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Aug 2022 16:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233534AbiHKUV4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Aug 2022 16:21:56 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AD06792D1
        for <linux-block@vger.kernel.org>; Thu, 11 Aug 2022 13:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1660249314; x=1691785314;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=PaqvzZxRcEr0+CT5UB15A08/nBKKsFBZ3mGE5lOTL8Y=;
  b=YV2T369ys1LuwVX++LkYbUTfQK16FF9Lv6/Hs/HOmLUxB3Nq0cfbq0IT
   lS9lkXeeVPkNwp+7GijXlo12QQL4p4EhcfAMszql9hfr13GUEaOYzGwDB
   7UPWhgrosSe2r162/yk7/xjZiy4TuNnmq4QjzY1SGp/trf/Prn2egE/cF
   kzCZDQSS5AaSFnwRTJoXp5/Dnzx/xVqMwOTl6+JY0hryF8K7m2h62VU5b
   V7jEe3xWT9t+gWCBJOAA0v+5H948eMRXlW1oTbvn731zxFXtwoqm5s37P
   0kDL7i0IgQT2uiKaMD5JO1NO0ocUPWL38bDWzGupm2ponf3bwwzmHWXdy
   A==;
X-IronPort-AV: E=Sophos;i="5.93,230,1654531200"; 
   d="scan'208";a="320579663"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 12 Aug 2022 04:21:53 +0800
IronPort-SDR: BiVVNa5aU+WnCbdTq1oapBVu0wVL1Wi7e07awehPSuiQhLtaLVxYqHPiEIy+6CqmWhNxDEYQUQ
 NA5y8iATdbcCsp6zkrJ6mWPSlrvQrN3nqtv0fU7jx6CDLuf+mGGKymm1nmg9JTVYQXZdlwjosJ
 2IpvWO1HSfM8KWpPLCQMbM/Hld2OzIKObsxE7bwYthr4ch++zz+LDv+5SF8aqEILIj68vwQBbL
 Epe8WzGDJ8KimQqcOLrgg9mWdYCjGCwSAnmhth/fIW9kGgjtKCM/PcgM6KbQyrU5bhOlRiu5xv
 hdK07oOKQGXPemfka5Po4fD6
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Aug 2022 12:42:46 -0700
IronPort-SDR: KHHkj/1udSNXZvPCxB+qdnWO9d4nUbfUvkNqU7eYd4Aaw0W3sHDYRhQQ8sQx+QikkSRF59JhGt
 MPeAax8DxBh2X4joG4AFqvRLQhbZuJgDdiST5maAUfHfkZfAi3xVr6UI/s4CP2FFmoX9e4S3Cx
 SGcT4AnuhNuIb1xZtIcBmnIfL4AVFJPT+RcYXCo4hbLNo5T7J+p4G7NS0Lilt5zj8LUMEQuMvP
 GA4hVmmImSxCnQwN0wv5NBEkiU4/geVCVnOz7LM0UAQrXkqXIMBRMLq0tgDnq1+WrVWZ9DkPys
 qSY=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Aug 2022 13:21:53 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4M3dWP0q4Jz1Rws4
        for <linux-block@vger.kernel.org>; Thu, 11 Aug 2022 13:21:53 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1660249312; x=1662841313; bh=PaqvzZxRcEr0+CT5UB15A08/nBKKsFBZ3mG
        E5lOTL8Y=; b=AMcmyLVPNlo5pzyagRiH4r92Sm7xf3CA8x5ETJMBefVeitp2S+k
        TQj1Do0vLf7eTEAP0V8y1+THKSI7qtu/qnhS7+5fHNb6mkqgpDGhGSJMhHB3L3Lm
        p4iPyrTp0hH17v+rRTt+VbnKvjB13qVFMjC3wGiaOG3B1FqORvjOv/7jCOwz9lk9
        20OKLzKAtkEFsDY444Pd683BQBOEn0JwscfVczAYSurUzTawP2280vxk3AgB0Y9X
        Js8CEyQvmp6ltWsHaRdhR3bewW4vMkoagfLYpzgrn2TaWHoki3jJ6i7qkHtrUULw
        blBhLkVYb+PHZvm2cMqks8VI3eaXcRRlu8g==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id c1aeA1IiTjfT for <linux-block@vger.kernel.org>;
        Thu, 11 Aug 2022 13:21:52 -0700 (PDT)
Received: from [10.11.46.122] (c02drav6md6t.sdcorp.global.sandisk.com [10.11.46.122])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4M3dWL6qzfz1RtVk;
        Thu, 11 Aug 2022 13:21:50 -0700 (PDT)
Message-ID: <01062caf-6504-f223-b9c2-6543a58f7f9d@opensource.wdc.com>
Date:   Thu, 11 Aug 2022 13:21:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH v10 02/13] block:rearrange
 bdev_{is_zoned,zone_sectors,get_queue} helpers in blkdev.h
Content-Language: en-US
To:     Pankaj Raghav <p.raghav@samsung.com>, snitzer@kernel.org,
        axboe@kernel.dk, hch@lst.de, agk@redhat.com
Cc:     linux-block@vger.kernel.org, Johannes.Thumshirn@wdc.com,
        bvanassche@acm.org, matias.bjorling@wdc.com, hare@suse.de,
        gost.dev@samsung.com, linux-nvme@lists.infradead.org,
        jaegeuk@kernel.org, pankydev8@gmail.com,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
References: <20220811143043.126029-1-p.raghav@samsung.com>
 <CGME20220811143046eucas1p2e49a778cff29476c7ebaef1d1c67d86c@eucas1p2.samsung.com>
 <20220811143043.126029-3-p.raghav@samsung.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220811143043.126029-3-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2022/08/11 7:30, Pankaj Raghav wrote:
> Define bdev_is_zoned(), bdev_zone_sectors() and bdev_get_queue() earlier
> in the blkdev.h include file. Simplify bdev_is_zoned() by removing the
> superfluous NULL check for request queue while we are at it.
> 
> This commit has no functional change, and it is a prep patch for allowing
> zoned devices with non-power-of-2 zone sizes in the block layer.
> 
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  include/linux/blkdev.h | 43 +++++++++++++++++++-----------------------
>  1 file changed, 19 insertions(+), 24 deletions(-)
> 
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index ab82d1ff0cce..84e7881262e3 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -635,6 +635,11 @@ static inline bool queue_is_mq(struct request_queue *q)
>  	return q->mq_ops;
>  }
>  
> +static inline struct request_queue *bdev_get_queue(struct block_device *bdev)
> +{
> +	return bdev->bd_queue;	/* this is never NULL */
> +}
> +
>  #ifdef CONFIG_PM
>  static inline enum rpm_status queue_rpm_status(struct request_queue *q)
>  {
> @@ -666,6 +671,20 @@ static inline bool blk_queue_is_zoned(struct request_queue *q)
>  	}
>  }
>  
> +static inline bool bdev_is_zoned(struct block_device *bdev)
> +{
> +	return blk_queue_is_zoned(bdev_get_queue(bdev));
> +}

You changed this too, so drop the current reviewed-by tag please.

For the next round, feel free to add:

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

> +
> +static inline sector_t bdev_zone_sectors(struct block_device *bdev)
> +{
> +	struct request_queue *q = bdev_get_queue(bdev);
> +
> +	if (!blk_queue_is_zoned(q))
> +		return 0;
> +	return q->limits.chunk_sectors;
> +}
> +
>  #ifdef CONFIG_BLK_DEV_ZONED
>  static inline unsigned int disk_nr_zones(struct gendisk *disk)
>  {
> @@ -892,11 +911,6 @@ int bio_poll(struct bio *bio, struct io_comp_batch *iob, unsigned int flags);
>  int iocb_bio_iopoll(struct kiocb *kiocb, struct io_comp_batch *iob,
>  			unsigned int flags);
>  
> -static inline struct request_queue *bdev_get_queue(struct block_device *bdev)
> -{
> -	return bdev->bd_queue;	/* this is never NULL */
> -}
> -
>  /* Helper to convert BLK_ZONE_ZONE_XXX to its string format XXX */
>  const char *blk_zone_cond_str(enum blk_zone_cond zone_cond);
>  
> @@ -1296,25 +1310,6 @@ static inline enum blk_zoned_model bdev_zoned_model(struct block_device *bdev)
>  	return BLK_ZONED_NONE;
>  }
>  
> -static inline bool bdev_is_zoned(struct block_device *bdev)
> -{
> -	struct request_queue *q = bdev_get_queue(bdev);
> -
> -	if (q)
> -		return blk_queue_is_zoned(q);
> -
> -	return false;
> -}
> -
> -static inline sector_t bdev_zone_sectors(struct block_device *bdev)
> -{
> -	struct request_queue *q = bdev_get_queue(bdev);
> -
> -	if (!blk_queue_is_zoned(q))
> -		return 0;
> -	return q->limits.chunk_sectors;
> -}
> -
>  static inline int queue_dma_alignment(const struct request_queue *q)
>  {
>  	return q ? q->dma_alignment : 511;


-- 
Damien Le Moal
Western Digital Research
