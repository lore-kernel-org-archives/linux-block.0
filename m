Return-Path: <SRS0=81jf=ZZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7CCBC432C0
	for <linux-block@archiver.kernel.org>; Tue,  3 Dec 2019 14:03:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACA5A20684
	for <linux-block@archiver.kernel.org>; Tue,  3 Dec 2019 14:03:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="w8lViIWn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726114AbfLCODx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 3 Dec 2019 09:03:53 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:42688 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbfLCODx (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 Dec 2019 09:03:53 -0500
Received: by mail-lf1-f65.google.com with SMTP id y19so3042144lfl.9
        for <linux-block@vger.kernel.org>; Tue, 03 Dec 2019 06:03:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=J5hgxh1hPaVZ5cAnNCsh6cQ9BZ/Gcg6dBtoKKORVDcY=;
        b=w8lViIWn34g/uX+kguCfNq7sSabb64f4Zxb3EoN0Bm+u77WTOvSUZCDQml8GJrPv+o
         lpfmg44075GN8I/j8Ij+M105RgIylGoBuWQm0Arx1S4ANxkp5u9qTeVS7J7sVRSyQCY0
         AU0nz4jIOLrFTQNvfWbbn0sObS9M/hwvrQwK+eR1TdyCcrQ+zKV8BVFyx2idaAqcs9H4
         YSPdFoEGdbshQsLYh/Z4fsQMNPz0H9lh+yuOVJ3fgK+XmfHBvomIecvLsGejkMltzAnU
         TeuBm9SeOlEAwmXiDD+9sYIWu5uVKSDIivhIVo1Z60cuGr4mfh9M+PFHAWNy4JewWImJ
         Sv0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=J5hgxh1hPaVZ5cAnNCsh6cQ9BZ/Gcg6dBtoKKORVDcY=;
        b=VciYQ8GncbEQU9xKL2pPCmU3XSynpabgYc+2zJsHse2QqAydpArQaH64/mYSlCnzh6
         VemxvdP4NVUXUPoDE74Ggtb5ORqyXy34bIcFLKiucQCNzO0196qhkGJdEFEEmh9Gpchk
         OOUey4ejDOsGNqlddaOIEmm0PCzEYRPE1PbDjDtPEDxjRAPGBlPR6GUZzoX9t5QuEkYG
         CYhk1+9I7fNsTzokDvx8I8q1TWSW7NsFYyOytPvDjmSwDCkuRvR/v//BhcuK0CMZkyHB
         euq1EDtugVNVlz2mstpDuApYm1ORAMEvGC4XfLs+4WAT29zU5Egh9zoiV0Wu3kk9W8wT
         PjHA==
X-Gm-Message-State: APjAAAUi28Kqiy7JUtS4eQrOCsvB2qs2P641mx74OBexE+MKgz0UtNYh
        fAxkDRSoMmJZZCLcwnqPgRACfQSBouEaAT+j
X-Google-Smtp-Source: APXvYqwjeyAhm/10TslDt/xOuJpVVUbuEbMmmNKuj+Ou7PN0LBtvt7IdwjrJIVs932TL/OS5uSNulA==
X-Received: by 2002:a19:550a:: with SMTP id n10mr2847959lfe.104.1575381830283;
        Tue, 03 Dec 2019 06:03:50 -0800 (PST)
Received: from localhost ([194.62.217.57])
        by smtp.gmail.com with ESMTPSA id 207sm1616340ljj.72.2019.12.03.06.03.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2019 06:03:49 -0800 (PST)
Date:   Tue, 3 Dec 2019 15:03:48 +0100
From:   Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Hans Holmberg <hans@owltronix.com>, linux-block@vger.kernel.org
Subject: Re: [PATCH 6/8] block: allocate the zone bitmaps lazily
Message-ID: <20191203140348.str5nt7oudu2prpn@mpHalley.local>
References: <20191203093908.24612-1-hch@lst.de>
 <20191203093908.24612-7-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191203093908.24612-7-hch@lst.de>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 03.12.2019 10:39, Christoph Hellwig wrote:
>Allocate the conventional zone bitmap and the sequential zone locking
>bitmap only when we find a zone of the respective type.  This avoids
>wasting memory on the conventional zone bitmap for devices that only
>have sequential zones, and will also prepare for other future changes.
>
>Signed-off-by: Christoph Hellwig <hch@lst.de>
>---
> block/blk-zoned.c | 65 +++++++++++++++++++++++------------------------
> 1 file changed, 32 insertions(+), 33 deletions(-)
>
>diff --git a/block/blk-zoned.c b/block/blk-zoned.c
>index 9c3931051f4f..0131f9e14bd1 100644
>--- a/block/blk-zoned.c
>+++ b/block/blk-zoned.c
>@@ -342,6 +342,7 @@ struct blk_revalidate_zone_args {
> 	struct gendisk	*disk;
> 	unsigned long	*conv_zones_bitmap;
> 	unsigned long	*seq_zones_wlock;
>+	unsigned int	nr_zones;
> 	sector_t	sector;
> };
>
>@@ -385,8 +386,22 @@ static int blk_revalidate_zone_cb(struct blk_zone *zone, unsigned int idx,
> 	/* Check zone type */
> 	switch (zone->type) {
> 	case BLK_ZONE_TYPE_CONVENTIONAL:
>+		if (!args->conv_zones_bitmap) {
>+			args->conv_zones_bitmap =
>+				blk_alloc_zone_bitmap(q->node, args->nr_zones);
>+			if (!args->conv_zones_bitmap)
>+				return -ENOMEM;
>+		}
>+		set_bit(idx, args->conv_zones_bitmap);
>+		break;
> 	case BLK_ZONE_TYPE_SEQWRITE_REQ:
> 	case BLK_ZONE_TYPE_SEQWRITE_PREF:
>+		if (!args->seq_zones_wlock) {
>+			args->seq_zones_wlock =
>+				blk_alloc_zone_bitmap(q->node, args->nr_zones);
>+			if (!args->seq_zones_wlock)
>+				return -ENOMEM;
>+		}
> 		break;
> 	default:
> 		pr_warn("%s: Invalid zone type 0x%x at sectors %llu\n",
>@@ -394,37 +409,10 @@ static int blk_revalidate_zone_cb(struct blk_zone *zone, unsigned int idx,
> 		return -ENODEV;
> 	}
>
>-	if (zone->type == BLK_ZONE_TYPE_CONVENTIONAL)
>-		set_bit(idx, args->conv_zones_bitmap);
>-
> 	args->sector += zone->len;
> 	return 0;
> }
>
>-static int blk_update_zone_info(struct gendisk *disk, unsigned int nr_zones,
>-				struct blk_revalidate_zone_args *args)
>-{
>-	/*
>-	 * Ensure that all memory allocations in this context are done as
>-	 * if GFP_NOIO was specified.
>-	 */
>-	unsigned int noio_flag = memalloc_noio_save();
>-	struct request_queue *q = disk->queue;
>-	int ret;
>-
>-	args->seq_zones_wlock = blk_alloc_zone_bitmap(q->node, nr_zones);
>-	if (!args->seq_zones_wlock)
>-		return -ENOMEM;
>-	args->conv_zones_bitmap = blk_alloc_zone_bitmap(q->node, nr_zones);
>-	if (!args->conv_zones_bitmap)
>-		return -ENOMEM;
>-
>-	ret = disk->fops->report_zones(disk, 0, nr_zones,
>-				       blk_revalidate_zone_cb, args);
>-	memalloc_noio_restore(noio_flag);
>-	return ret;
>-}
>-
> /**
>  * blk_revalidate_disk_zones - (re)allocate and initialize zone bitmaps
>  * @disk:	Target disk
>@@ -437,8 +425,10 @@ static int blk_update_zone_info(struct gendisk *disk, unsigned int nr_zones,
> int blk_revalidate_disk_zones(struct gendisk *disk)
> {
> 	struct request_queue *q = disk->queue;
>-	unsigned int nr_zones = blkdev_nr_zones(disk);
>-	struct blk_revalidate_zone_args args = { .disk = disk };
>+	struct blk_revalidate_zone_args args = {
>+		.disk		= disk,
>+		.nr_zones	= blkdev_nr_zones(disk),
>+	};
> 	int ret = 0;
>
> 	if (WARN_ON_ONCE(!blk_queue_is_zoned(q)))
>@@ -449,12 +439,21 @@ int blk_revalidate_disk_zones(struct gendisk *disk)
> 	 * needs to be updated so that the sysfs exposed value is correct.
> 	 */
> 	if (!queue_is_mq(q)) {
>-		q->nr_zones = nr_zones;
>+		q->nr_zones = args.nr_zones;
> 		return 0;
> 	}
>
>-	if (nr_zones)
>-		ret = blk_update_zone_info(disk, nr_zones, &args);
>+	/*
>+	 * Ensure that all memory allocations in this context are done as
>+	 * if GFP_NOIO was specified.
>+	 */
>+	if (args.nr_zones) {
>+		unsigned int noio_flag = memalloc_noio_save();
>+
>+		ret = disk->fops->report_zones(disk, 0, args.nr_zones,
>+					       blk_revalidate_zone_cb, &args);
>+		memalloc_noio_restore(noio_flag);
>+	}
>
> 	/*
> 	 * Install the new bitmaps, making sure the queue is stopped and
>@@ -463,7 +462,7 @@ int blk_revalidate_disk_zones(struct gendisk *disk)
> 	 */
> 	blk_mq_freeze_queue(q);
> 	if (ret >= 0) {
>-		q->nr_zones = nr_zones;
>+		q->nr_zones = args.nr_zones;
> 		swap(q->seq_zones_wlock, args.seq_zones_wlock);
> 		swap(q->conv_zones_bitmap, args.conv_zones_bitmap);
> 		ret = 0;
>-- 
>2.20.1

Looks good to me.

Reviewed-by: Javier González <javier@javigon.com>
