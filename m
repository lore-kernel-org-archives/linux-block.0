Return-Path: <SRS0=81jf=ZZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FC4BC432C0
	for <linux-block@archiver.kernel.org>; Tue,  3 Dec 2019 14:04:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F0F020684
	for <linux-block@archiver.kernel.org>; Tue,  3 Dec 2019 14:04:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="MJS+05bo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbfLCOEp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 3 Dec 2019 09:04:45 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41248 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbfLCOEp (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 Dec 2019 09:04:45 -0500
Received: by mail-lj1-f196.google.com with SMTP id h23so3935086ljc.8
        for <linux-block@vger.kernel.org>; Tue, 03 Dec 2019 06:04:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=LSmHkSFspCAoGLZeDXYvXSGrmVOCjoTFcqwfiygk3u8=;
        b=MJS+05bon7q1Su2jl4IhRKDfFSgWaQ/EO3qMV0yfbXTj6dmeneHbRcM9yOVU8WZmAS
         BnCyE4fEHi9vqUDnfFddPAfDXmzY10it9UEfCqb/MHOvSb+p7GylwDsG5fNN6ljaphzO
         15Sv+E+NkiSwnsqx/ADXDQTxQBEyk4I3WxMFXOfanNPQb/qllqycSEJt+JDjCbplqr5o
         +aALqAO6734dJpbwrItEwSsEk1r/CIWoHUlHeGANfH+SzYpz//fNlg75y9HO8SRSf3Qa
         AE0oSOHqtl5Wo7T+ANilpA3NrxOBPhdz7NGgJDAIKA8iH7vYwenZdo1Q2y7WIa2OXvBE
         K1MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=LSmHkSFspCAoGLZeDXYvXSGrmVOCjoTFcqwfiygk3u8=;
        b=cG54CKzJojHil1gdIk5OvnMzwYG/cIR4ytQJP3upscrhtne6CS0IgnABxLCcriIpta
         u/XG/Mkk96GkoKu+Sj7LJteLOUmCu03SZrqMU5lpiZU/32Q1jxDBTNYuPwQu2LJrnUEd
         JsTwhgy1Ic8/fkuCktYY2hvYBPalxOs2kiaAK08D6bzEFxZPQVYnailJMZeWaj6Oex2v
         HlkNNfALcaDE88f8q3Up7br9MJlsdjLRDOdUuCV1/8NMsVBZoveCiiGmtW+ft4NAStQp
         NHubbuyZ21K5zxBFnRS9L++eT9XJeAOkN8sjKTEJAuRXr2n9TbLxXtqh0r2z4REbZZle
         PCnA==
X-Gm-Message-State: APjAAAVv1G5eF0Vz+pthRpK6lZp7yi9sX1rUjCnhPUySwuXbeRr36LXJ
        RpzvyJl169CiJKHDC4E2pgA5Fw==
X-Google-Smtp-Source: APXvYqzSE2dPgOa5Vfp9YmozLvv+0kKpAKQq6x6BQTn9aHMXaOiKOrTitRq0MjTlQiE+vjH3RmCo+A==
X-Received: by 2002:a2e:7202:: with SMTP id n2mr2399377ljc.194.1575381882855;
        Tue, 03 Dec 2019 06:04:42 -0800 (PST)
Received: from localhost ([194.62.217.57])
        by smtp.gmail.com with ESMTPSA id y11sm1653137lfc.27.2019.12.03.06.04.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2019 06:04:42 -0800 (PST)
Date:   Tue, 3 Dec 2019 15:04:40 +0100
From:   Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Hans Holmberg <hans@owltronix.com>, linux-block@vger.kernel.org
Subject: Re: [PATCH 7/8] block: don't handle bio based drivers in
 blk_revalidate_disk_zones
Message-ID: <20191203140440.cb3ru56jkcgbvpug@mpHalley.local>
References: <20191203093908.24612-1-hch@lst.de>
 <20191203093908.24612-8-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191203093908.24612-8-hch@lst.de>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 03.12.2019 10:39, Christoph Hellwig wrote:
>bio based drivers only need to update q->nr_zones.  Do that manually
>instead of overloading blk_revalidate_disk_zones to keep that function
>simpler for the next round of changes that will rely even more on the
>request based functionality.
>
>Signed-off-by: Christoph Hellwig <hch@lst.de>
>---
> block/blk-zoned.c             | 16 +++++-----------
> drivers/block/null_blk_main.c | 12 +++++++++---
> drivers/md/dm-table.c         | 12 +++++++-----
> include/linux/blkdev.h        |  5 -----
> 4 files changed, 21 insertions(+), 24 deletions(-)
>
>diff --git a/block/blk-zoned.c b/block/blk-zoned.c
>index 0131f9e14bd1..51d427659ce7 100644
>--- a/block/blk-zoned.c
>+++ b/block/blk-zoned.c
>@@ -419,8 +419,9 @@ static int blk_revalidate_zone_cb(struct blk_zone *zone, unsigned int idx,
>  *
>  * Helper function for low-level device drivers to (re) allocate and initialize
>  * a disk request queue zone bitmaps. This functions should normally be called
>- * within the disk ->revalidate method. For BIO based queues, no zone bitmap
>- * is allocated.
>+ * within the disk ->revalidate method for blk-mq based drivers.  For BIO based
>+ * drivers only q->nr_zones needs to be updated so that the sysfs exposed value
>+ * is correct.
>  */
> int blk_revalidate_disk_zones(struct gendisk *disk)
> {
>@@ -433,15 +434,8 @@ int blk_revalidate_disk_zones(struct gendisk *disk)
>
> 	if (WARN_ON_ONCE(!blk_queue_is_zoned(q)))
> 		return -EIO;
>-
>-	/*
>-	 * BIO based queues do not use a scheduler so only q->nr_zones
>-	 * needs to be updated so that the sysfs exposed value is correct.
>-	 */
>-	if (!queue_is_mq(q)) {
>-		q->nr_zones = args.nr_zones;
>-		return 0;
>-	}
>+	if (WARN_ON_ONCE(!queue_is_mq(q)))
>+		return -EIO;
>
> 	/*
> 	 * Ensure that all memory allocations in this context are done as
>diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.c
>index dd6026289fbf..068cd0ae6e2c 100644
>--- a/drivers/block/null_blk_main.c
>+++ b/drivers/block/null_blk_main.c
>@@ -1576,11 +1576,17 @@ static int null_gendisk_register(struct nullb *nullb)
> 	disk->queue		= nullb->q;
> 	strncpy(disk->disk_name, nullb->disk_name, DISK_NAME_LEN);
>
>+#ifdef CONFIG_BLK_DEV_ZONED
> 	if (nullb->dev->zoned) {
>-		ret = blk_revalidate_disk_zones(disk);
>-		if (ret)
>-			return ret;
>+		if (queue_is_mq(nullb->q)) {
>+			ret = blk_revalidate_disk_zones(disk);
>+			if (ret)
>+				return ret;
>+		} else {
>+			nullb->q->nr_zones = blkdev_nr_zones(disk);
>+		}
> 	}
>+#endif
>
> 	add_disk(disk);
> 	return 0;
>diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
>index 2ae0c1913766..0a2cc197f62b 100644
>--- a/drivers/md/dm-table.c
>+++ b/drivers/md/dm-table.c
>@@ -1954,12 +1954,14 @@ void dm_table_set_restrictions(struct dm_table *t, struct request_queue *q,
> 	/*
> 	 * For a zoned target, the number of zones should be updated for the
> 	 * correct value to be exposed in sysfs queue/nr_zones. For a BIO based
>-	 * target, this is all that is needed. For a request based target, the
>-	 * queue zone bitmaps must also be updated.
>-	 * Use blk_revalidate_disk_zones() to handle this.
>+	 * target, this is all that is needed.
> 	 */
>-	if (blk_queue_is_zoned(q))
>-		blk_revalidate_disk_zones(t->md->disk);
>+#ifdef CONFIG_BLK_DEV_ZONED
>+	if (blk_queue_is_zoned(q)) {
>+		WARN_ON_ONCE(queue_is_mq(q));
>+		q->nr_zones = blkdev_nr_zones(t->md->disk);
>+	}
>+#endif
>
> 	/* Allow reads to exceed readahead limits */
> 	q->backing_dev_info->io_pages = limits->max_sectors >> (PAGE_SHIFT - 9);
>diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
>index 503c4d4c5884..47eb22a3b7f9 100644
>--- a/include/linux/blkdev.h
>+++ b/include/linux/blkdev.h
>@@ -375,11 +375,6 @@ static inline unsigned int blkdev_nr_zones(struct gendisk *disk)
> 	return 0;
> }
>
>-static inline int blk_revalidate_disk_zones(struct gendisk *disk)
>-{
>-	return 0;
>-}
>-
> static inline int blkdev_report_zones_ioctl(struct block_device *bdev,
> 					    fmode_t mode, unsigned int cmd,
> 					    unsigned long arg)
>-- 
>2.20.1
>

Looks good to me.

Reviewed-by: Javier González <javier@javigon.com>
