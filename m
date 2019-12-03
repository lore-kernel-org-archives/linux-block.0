Return-Path: <SRS0=81jf=ZZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCE1FC432C0
	for <linux-block@archiver.kernel.org>; Tue,  3 Dec 2019 14:00:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 774C820409
	for <linux-block@archiver.kernel.org>; Tue,  3 Dec 2019 14:00:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="T3vxcQ9X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726214AbfLCOAO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 3 Dec 2019 09:00:14 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:33130 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbfLCOAN (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 Dec 2019 09:00:13 -0500
Received: by mail-lf1-f65.google.com with SMTP id n25so3086768lfl.0
        for <linux-block@vger.kernel.org>; Tue, 03 Dec 2019 06:00:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pCMBCAvDC0/3M+fYSslU0RzU9tvtwIJcbVht/xlG/uk=;
        b=T3vxcQ9XRlPdQFzzYbEzm7jTyJGwm+1Uzx/kCr8e9v75gp8iJoEYKykgZZZxoltOB7
         0EsIRPS/OzKJapwBBxEr/q7pE1NXnciUaWcPmPJz08N+D+jy63zEdwSUGbjcucsOApKC
         XyMgm8rZk4AkNXvAZoPEZWFIkSHMUO+aeZKvGE6a8GuUH8Q/iJS7RduG+M51SmAI+cVq
         WrSvc1Bb4yPVLO2BQXbf9R9ZzWW7848vI6tXynRPhmN44LgASeaYNQzSrlAGaSQxFUmt
         oDU5OmimOc/7sJ///2vfn/2yyQt/Wq6YyA3gyrC0txA0MyfH0GGyu9AlDdrOmLrSOPyY
         ty2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pCMBCAvDC0/3M+fYSslU0RzU9tvtwIJcbVht/xlG/uk=;
        b=SFqOzkJQkneYQBTLpx4gnc8f0bOw2atiwgwKS0Rat/e5yL3jXT+auWcV5+UgmE2nmT
         LyzCnRfCta9kEhiRPrjawMbZ2rEd6tTA6CeTreWERct/pzwWJkMrfAZqIFprsqQyU9Tc
         ZLFujAyeM5FatcABGk1hxHWbsH/BG/te5G6FsvFmLxNiqXwWH+qSdnLmkTLMuyO5z6yr
         vQGqvhQlKQ7NeQ16BMDiAaiFvvd5Q3v6Ftb/lRUiI5SGXTvXrqmEeo8Q/sJmaUfFjL5I
         JaXhzH9c5hXpW9RjD0zU9Sjj3KR1gF9l9D6f522kaquVqXfML77qNu+zAsWvFbwsVs/a
         3tgg==
X-Gm-Message-State: APjAAAU/89qNJuUjgg6TT0d76nB9UzqsmoWu757xgOA5l1/+DWbocTvX
        Mm9KcXMhuUqpfnGejgDnzlDRVw==
X-Google-Smtp-Source: APXvYqzg/00RPXb2c7zH+KOzWqJBdxYlJhlt0KrDJcJj4WPYZAPYCz6yT2V71++kArAOFfTmdFn/cQ==
X-Received: by 2002:a19:f514:: with SMTP id j20mr2598495lfb.31.1575381611080;
        Tue, 03 Dec 2019 06:00:11 -0800 (PST)
Received: from localhost ([194.62.217.57])
        by smtp.gmail.com with ESMTPSA id z9sm1393756ljm.40.2019.12.03.06.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2019 06:00:10 -0800 (PST)
Date:   Tue, 3 Dec 2019 15:00:09 +0100
From:   Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Hans Holmberg <hans@owltronix.com>, linux-block@vger.kernel.org
Subject: Re: [PATCH 8/8] block: set the zone size in
 blk_revalidate_disk_zones atomically
Message-ID: <20191203140009.weqdw2kopzaizuoo@mpHalley.local>
References: <20191203093908.24612-1-hch@lst.de>
 <20191203093908.24612-9-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20191203093908.24612-9-hch@lst.de>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 03.12.2019 10:39, Christoph Hellwig wrote:
>The current zone revalidation code has a major problem in that it
>doesn't update the zone size and q->nr_zones atomically, leading
>to a short window where an out of bounds access to the zone arrays
>is possible.
>
>To fix this move the setting of the zone size into the crticial

nip: critical

>sections blk_revalidate_disk_zones so that it gets updated together
>with the zone bitmaps and q->nr_zones.  This also slightly simplifies
>the caller as it deducts the zone size from the report_zones.

This part makes sense. Good catch.
>
>This change also allows to check for a power of two zone size in generic
>code.

I think however that this checks should remain at the driver level, or
at least depend on a flag that signals that the zoned device is actually
a power of two.

>
>Reported-by: Hans Holmberg <hans@owltronix.com>
>Signed-off-by: Christoph Hellwig <hch@lst.de>
>---
> block/blk-zoned.c             | 59 ++++++++++++++++++++---------------
> drivers/block/null_blk_main.c |  3 +-
> drivers/scsi/sd_zbc.c         |  2 --
> 3 files changed, 35 insertions(+), 29 deletions(-)
>
>diff --git a/block/blk-zoned.c b/block/blk-zoned.c
>index 51d427659ce7..d00fcfd71dfe 100644
>--- a/block/blk-zoned.c
>+++ b/block/blk-zoned.c
>@@ -343,6 +343,7 @@ struct blk_revalidate_zone_args {
> 	unsigned long	*conv_zones_bitmap;
> 	unsigned long	*seq_zones_wlock;
> 	unsigned int	nr_zones;
>+	sector_t	zone_sectors;
> 	sector_t	sector;
> };
>
>@@ -355,25 +356,33 @@ static int blk_revalidate_zone_cb(struct blk_zone *zone, unsigned int idx,
> 	struct blk_revalidate_zone_args *args = data;
> 	struct gendisk *disk = args->disk;
> 	struct request_queue *q = disk->queue;
>-	sector_t zone_sectors = blk_queue_zone_sectors(q);
> 	sector_t capacity = get_capacity(disk);
>
> 	/*
> 	 * All zones must have the same size, with the exception on an eventual
> 	 * smaller last zone.
> 	 */
>-	if (zone->start + zone_sectors < capacity &&
>-	    zone->len != zone_sectors) {
>-		pr_warn("%s: Invalid zoned device with non constant zone size\n",
>-			disk->disk_name);
>-		return false;
>-	}
>+	if (zone->start == 0) {
>+		if (zone->len == 0 || !is_power_of_2(zone->len)) {
>+			pr_warn("%s: Invalid zoned device with non power of two zone size (%llu)\n",
>+				disk->disk_name, zone->len);
>+			return -ENODEV;
>+		}
>
>-	if (zone->start + zone->len >= capacity &&
>-	    zone->len > zone_sectors) {
>-		pr_warn("%s: Invalid zoned device with larger last zone size\n",
>-			disk->disk_name);
>-		return -ENODEV;
>+		args->zone_sectors = zone->len;
>+		args->nr_zones = (capacity + zone->len - 1) >> ilog2(zone->len);
>+	} else if (zone->start + args->zone_sectors < capacity) {
>+		if (zone->len != args->zone_sectors) {
>+			pr_warn("%s: Invalid zoned device with non constant zone size\n",
>+				disk->disk_name);
>+			return -ENODEV;
>+		}
>+	} else {
>+		if (zone->len > args->zone_sectors) {
>+			pr_warn("%s: Invalid zoned device with larger last zone size\n",
>+				disk->disk_name);
>+			return -ENODEV;
>+		}
> 	}
>
> 	/* Check for holes in the zone report */
>@@ -428,9 +437,9 @@ int blk_revalidate_disk_zones(struct gendisk *disk)
> 	struct request_queue *q = disk->queue;
> 	struct blk_revalidate_zone_args args = {
> 		.disk		= disk,
>-		.nr_zones	= blkdev_nr_zones(disk),
> 	};
>-	int ret = 0;
>+	unsigned int noio_flag;
>+	int ret;
>
> 	if (WARN_ON_ONCE(!blk_queue_is_zoned(q)))
> 		return -EIO;
>@@ -438,24 +447,22 @@ int blk_revalidate_disk_zones(struct gendisk *disk)
> 		return -EIO;
>
> 	/*
>-	 * Ensure that all memory allocations in this context are done as
>-	 * if GFP_NOIO was specified.
>+	 * Ensure that all memory allocations in this context are done as if
>+	 * GFP_NOIO was specified.
> 	 */
>-	if (args.nr_zones) {
>-		unsigned int noio_flag = memalloc_noio_save();
>-
>-		ret = disk->fops->report_zones(disk, 0, args.nr_zones,
>-					       blk_revalidate_zone_cb, &args);
>-		memalloc_noio_restore(noio_flag);
>-	}
>+	noio_flag = memalloc_noio_save();
>+	ret = disk->fops->report_zones(disk, 0, UINT_MAX,
>+				       blk_revalidate_zone_cb, &args);
>+	memalloc_noio_restore(noio_flag);
>
> 	/*
>-	 * Install the new bitmaps, making sure the queue is stopped and
>-	 * all I/Os are completed (i.e. a scheduler is not referencing the
>-	 * bitmaps).
>+	 * Install the new bitmaps and update nr_zones only once the queue is
>+	 * stopped and all I/Os are completed (i.e. a scheduler is not
>+	 * referencing the bitmaps).
> 	 */
> 	blk_mq_freeze_queue(q);
> 	if (ret >= 0) {
>+		blk_queue_chunk_sectors(q, args.zone_sectors);
> 		q->nr_zones = args.nr_zones;
> 		swap(q->seq_zones_wlock, args.seq_zones_wlock);
> 		swap(q->conv_zones_bitmap, args.conv_zones_bitmap);
>diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.c
>index 068cd0ae6e2c..997b7dc095b9 100644
>--- a/drivers/block/null_blk_main.c
>+++ b/drivers/block/null_blk_main.c
>@@ -1583,6 +1583,8 @@ static int null_gendisk_register(struct nullb *nullb)
> 			if (ret)
> 				return ret;
> 		} else {
>+			blk_queue_chunk_sectors(nullb->q,
>+					nullb->dev->zone_size_sects);
> 			nullb->q->nr_zones = blkdev_nr_zones(disk);
> 		}
> 	}
>@@ -1746,7 +1748,6 @@ static int null_add_dev(struct nullb_device *dev)
> 		if (rv)
> 			goto out_cleanup_blk_queue;
>
>-		blk_queue_chunk_sectors(nullb->q, dev->zone_size_sects);
> 		nullb->q->limits.zoned = BLK_ZONED_HM;
> 		blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, nullb->q);
> 		blk_queue_required_elevator_features(nullb->q,
>diff --git a/drivers/scsi/sd_zbc.c b/drivers/scsi/sd_zbc.c
>index 0e5ede48f045..27d72c1d4654 100644
>--- a/drivers/scsi/sd_zbc.c
>+++ b/drivers/scsi/sd_zbc.c
>@@ -412,8 +412,6 @@ int sd_zbc_read_zones(struct scsi_disk *sdkp, unsigned char *buf)
> 		goto err;
>
> 	/* The drive satisfies the kernel restrictions: set it up */
>-	blk_queue_chunk_sectors(sdkp->disk->queue,
>-			logical_to_sectors(sdkp->device, zone_blocks));
> 	blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, sdkp->disk->queue);
> 	blk_queue_required_elevator_features(sdkp->disk->queue,
> 					     ELEVATOR_F_ZBD_SEQ_WRITE);
>-- 
>2.20.1
>
