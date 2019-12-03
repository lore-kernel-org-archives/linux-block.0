Return-Path: <SRS0=81jf=ZZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54BB1C432C0
	for <linux-block@archiver.kernel.org>; Tue,  3 Dec 2019 14:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FA0A20684
	for <linux-block@archiver.kernel.org>; Tue,  3 Dec 2019 14:02:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="g51JifLs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbfLCOCo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 3 Dec 2019 09:02:44 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34475 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbfLCOCo (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 Dec 2019 09:02:44 -0500
Received: by mail-lj1-f194.google.com with SMTP id m6so3978555ljc.1
        for <linux-block@vger.kernel.org>; Tue, 03 Dec 2019 06:02:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=PUBTM0oX1IMY6bzvPwx/wq5AJ9I3w+hOo7XmbHEeDSc=;
        b=g51JifLsQ8IHy7b/M3/pKVoioRS7NHagPLZgbfn4UNW4XnJeJZLmJAPLeBAVOfHgd1
         OgQAmocEEYt2xuRqgw97B3hRuiILF5EtX1ITx82ktXCv5Xu3Ze607d74p0G2OEN2Z80M
         fyZ50WnSZX6tPgrvg3v7FnQ1oNGrrneli0e4D830D408RKim9uWZKhXnzFg44ragKcZN
         ei8q/1ZAcApnQEiz6AGr4kBYqPgEaCvr6EwzpfpPEzbm/SqTqsXmkf4IzVCM6aeMpd2Q
         QEQJcyx9mAwWE3xUSqfGzxT5aXPgci4cPxkZx06FQMFeunbYe3xeBTFNmcv/0mvij612
         hE4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=PUBTM0oX1IMY6bzvPwx/wq5AJ9I3w+hOo7XmbHEeDSc=;
        b=R2ck6zN1oCt9iX8bBnClnN/NbpRPNzc2ztlZwjTwySTbxIoB46AmdlLfSrgC2uUCEb
         REGsNK8VbNjRHQmhKxhj1kWpbdms2O+uf+tsndsTzgPWEQAFJ6X8MEc/UZHjkaHhv4M6
         q/Dpj3Wc+npeubkjfJUpbJOFgW9upGH1vERsL+jFsjcim7uW0KtCBVu72BYnbo6j5wQK
         zMlF/CPcfn9/DlBmGmv1UdbzjiPFMhEDV/JJC5s7IkMEG8JnP//hacggki4pDgNaka5l
         WtLKX+jrW/AJdxK8wj1rLn28HGa1LPDUUiHWjqHB6f3fLrMGDmdiRyv+WhGMAW2EyAOg
         GMSg==
X-Gm-Message-State: APjAAAUExS3k3CIMEcNQxHOenqL/gBITkF6MgpcgRHcdNNLLl9T6Mjd6
        nP0Z3kq5jTTQZ2+vnhrYP4SB7O2RnpX/Sp+8
X-Google-Smtp-Source: APXvYqzycACcCBNoAUnrQnDSXAH+3GmvtrqMSq3WlYAnlZo4nEr59smJzUeEFDI7C7PG6SW6Q9NdXA==
X-Received: by 2002:a2e:9596:: with SMTP id w22mr2667462ljh.21.1575381761570;
        Tue, 03 Dec 2019 06:02:41 -0800 (PST)
Received: from localhost ([194.62.217.57])
        by smtp.gmail.com with ESMTPSA id g26sm1386708ljn.89.2019.12.03.06.02.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2019 06:02:40 -0800 (PST)
Date:   Tue, 3 Dec 2019 15:02:39 +0100
From:   Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Hans Holmberg <hans@owltronix.com>, linux-block@vger.kernel.org
Subject: Re: [PATCH 5/8] block: replace seq_zones_bitmap with
 conv_zones_bitmap
Message-ID: <20191203140239.x5a5ll2u5wgou6la@mpHalley.local>
References: <20191203093908.24612-1-hch@lst.de>
 <20191203093908.24612-6-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191203093908.24612-6-hch@lst.de>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 03.12.2019 10:39, Christoph Hellwig wrote:
>Invert the meaning of seq_zones_bitmap by keeping a bitmap of
>conventional zones.  This allows not having a bitmap for devices
>that do not have conventional zones.
>
>Signed-off-by: Christoph Hellwig <hch@lst.de>
>---
> block/blk-zoned.c      | 18 +++++++++---------
> include/linux/blkdev.h | 14 ++++++++------
> 2 files changed, 17 insertions(+), 15 deletions(-)
>
>diff --git a/block/blk-zoned.c b/block/blk-zoned.c
>index 65a9bdc9fe27..9c3931051f4f 100644
>--- a/block/blk-zoned.c
>+++ b/block/blk-zoned.c
>@@ -332,15 +332,15 @@ static inline unsigned long *blk_alloc_zone_bitmap(int node,
>
> void blk_queue_free_zone_bitmaps(struct request_queue *q)
> {
>-	kfree(q->seq_zones_bitmap);
>-	q->seq_zones_bitmap = NULL;
>+	kfree(q->conv_zones_bitmap);
>+	q->conv_zones_bitmap = NULL;
> 	kfree(q->seq_zones_wlock);
> 	q->seq_zones_wlock = NULL;
> }
>
> struct blk_revalidate_zone_args {
> 	struct gendisk	*disk;
>-	unsigned long	*seq_zones_bitmap;
>+	unsigned long	*conv_zones_bitmap;
> 	unsigned long	*seq_zones_wlock;
> 	sector_t	sector;
> };
>@@ -394,8 +394,8 @@ static int blk_revalidate_zone_cb(struct blk_zone *zone, unsigned int idx,
> 		return -ENODEV;
> 	}
>
>-	if (zone->type != BLK_ZONE_TYPE_CONVENTIONAL)
>-		set_bit(idx, args->seq_zones_bitmap);
>+	if (zone->type == BLK_ZONE_TYPE_CONVENTIONAL)
>+		set_bit(idx, args->conv_zones_bitmap);
>
> 	args->sector += zone->len;
> 	return 0;
>@@ -415,8 +415,8 @@ static int blk_update_zone_info(struct gendisk *disk, unsigned int nr_zones,
> 	args->seq_zones_wlock = blk_alloc_zone_bitmap(q->node, nr_zones);
> 	if (!args->seq_zones_wlock)
> 		return -ENOMEM;
>-	args->seq_zones_bitmap = blk_alloc_zone_bitmap(q->node, nr_zones);
>-	if (!args->seq_zones_bitmap)
>+	args->conv_zones_bitmap = blk_alloc_zone_bitmap(q->node, nr_zones);
>+	if (!args->conv_zones_bitmap)
> 		return -ENOMEM;
>
> 	ret = disk->fops->report_zones(disk, 0, nr_zones,
>@@ -465,7 +465,7 @@ int blk_revalidate_disk_zones(struct gendisk *disk)
> 	if (ret >= 0) {
> 		q->nr_zones = nr_zones;
> 		swap(q->seq_zones_wlock, args.seq_zones_wlock);
>-		swap(q->seq_zones_bitmap, args.seq_zones_bitmap);
>+		swap(q->conv_zones_bitmap, args.conv_zones_bitmap);
> 		ret = 0;
> 	} else {
> 		pr_warn("%s: failed to revalidate zones\n", disk->disk_name);
>@@ -474,7 +474,7 @@ int blk_revalidate_disk_zones(struct gendisk *disk)
> 	blk_mq_unfreeze_queue(q);
>
> 	kfree(args.seq_zones_wlock);
>-	kfree(args.seq_zones_bitmap);
>+	kfree(args.conv_zones_bitmap);
> 	return ret;
> }
> EXPORT_SYMBOL_GPL(blk_revalidate_disk_zones);
>diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
>index c5852de402b6..503c4d4c5884 100644
>--- a/include/linux/blkdev.h
>+++ b/include/linux/blkdev.h
>@@ -503,9 +503,9 @@ struct request_queue {
> 	/*
> 	 * Zoned block device information for request dispatch control.
> 	 * nr_zones is the total number of zones of the device. This is always
>-	 * 0 for regular block devices. seq_zones_bitmap is a bitmap of nr_zones
>-	 * bits which indicates if a zone is conventional (bit clear) or
>-	 * sequential (bit set). seq_zones_wlock is a bitmap of nr_zones
>+	 * 0 for regular block devices. conv_zones_bitmap is a bitmap of nr_zones
>+	 * bits which indicates if a zone is conventional (bit set) or
>+	 * sequential (bit clear). seq_zones_wlock is a bitmap of nr_zones
> 	 * bits which indicates if a zone is write locked, that is, if a write
> 	 * request targeting the zone was dispatched. All three fields are
> 	 * initialized by the low level device driver (e.g. scsi/sd.c).
>@@ -518,7 +518,7 @@ struct request_queue {
> 	 * blk_mq_unfreeze_queue().
> 	 */
> 	unsigned int		nr_zones;
>-	unsigned long		*seq_zones_bitmap;
>+	unsigned long		*conv_zones_bitmap;
> 	unsigned long		*seq_zones_wlock;
> #endif /* CONFIG_BLK_DEV_ZONED */
>
>@@ -723,9 +723,11 @@ static inline unsigned int blk_queue_zone_no(struct request_queue *q,
> static inline bool blk_queue_zone_is_seq(struct request_queue *q,
> 					 sector_t sector)
> {
>-	if (!blk_queue_is_zoned(q) || !q->seq_zones_bitmap)
>+	if (!blk_queue_is_zoned(q))
> 		return false;
>-	return test_bit(blk_queue_zone_no(q, sector), q->seq_zones_bitmap);
>+	if (!q->conv_zones_bitmap)
>+		return true;
>+	return !test_bit(blk_queue_zone_no(q, sector), q->conv_zones_bitmap);
> }
> #else /* CONFIG_BLK_DEV_ZONED */
> static inline unsigned int blk_queue_nr_zones(struct request_queue *q)
>-- 
>2.20.1
>

Looks good to me.

Reviewed-by: Javier González <javier@javigon.com>
