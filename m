Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFF82C2B9F4
	for <linux-block@archiver.kernel.org>; Fri, 25 Jun 2021 06:44:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7AF161421
	for <linux-block@archiver.kernel.org>; Fri, 25 Jun 2021 06:44:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbhFYGqh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 25 Jun 2021 02:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbhFYGqh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Jun 2021 02:46:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4470FC061574
        for <linux-block@vger.kernel.org>; Thu, 24 Jun 2021 23:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=cxZoNvpT9KG08gtLbt+m+4z1mWUVg+68R0FzPYZ/MqM=; b=WxFdG8j27SvMaPOF7SoiSEAAJm
        l9g1a3d/Toxl9kOld/PkDRY8govD+TTZRlqDVs2adcXi7akxlzTXmCwNysmhKwsiu3PeJYPAq4ca2
        Sihb44yR3+0cvwIifze67OYW7KMBHWd6Q534Q58aTAu5n1nR9FEmXt3mX3+MO6Nof9AfYN8WWutna
        CxlBaFl0Q7qnP8QntA/VGWv0ySKxrpERiW5/GHtkPSl/sAgWppcLTUF3L7wpEJQPzre9Y9kcX/GOc
        pwYpO1qRGVB+tOojyyKAuilAA7noR93ghVu1DbNIwID3e5AnduDx01U7mJ9PGUsSwXGRU6mCq4ihR
        3QBFEIEg==;
Received: from 089144193030.atnat0002.highway.a1.net ([89.144.193.30] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lwfZS-00HNq8-BY; Fri, 25 Jun 2021 06:44:12 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH] block: pass a gendisk to bdev_{add,del,resize}_partition
Date:   Fri, 25 Jun 2021 08:41:59 +0200
Message-Id: <20210625064159.923557-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

These helpers deal with partition tables and thus logically operate
on the gendisk.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk.h             |  6 +++---
 block/ioctl.c           |  7 ++++---
 block/partitions/core.c | 36 ++++++++++++++++++------------------
 3 files changed, 25 insertions(+), 24 deletions(-)

diff --git a/block/blk.h b/block/blk.h
index 4b885c0f6708..a18d87c8af9e 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -348,10 +348,10 @@ char *disk_name(struct gendisk *hd, int partno, char *buf);
 #define ADDPART_FLAG_NONE	0
 #define ADDPART_FLAG_RAID	1
 #define ADDPART_FLAG_WHOLEDISK	2
-int bdev_add_partition(struct block_device *bdev, int partno,
+int bdev_add_partition(struct gendisk *disk, int partno,
 		sector_t start, sector_t length);
-int bdev_del_partition(struct block_device *bdev, int partno);
-int bdev_resize_partition(struct block_device *bdev, int partno,
+int bdev_del_partition(struct gendisk *disk, int partno);
+int bdev_resize_partition(struct gendisk *disk, int partno,
 		sector_t start, sector_t length);
 
 int bio_add_hw_page(struct request_queue *q, struct bio *bio,
diff --git a/block/ioctl.c b/block/ioctl.c
index 24beec9ca9c9..395ec6b3c1c3 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -16,6 +16,7 @@
 static int blkpg_do_ioctl(struct block_device *bdev,
 			  struct blkpg_partition __user *upart, int op)
 {
+	struct gendisk *disk = bdev->bd_disk;
 	struct blkpg_partition p;
 	long long start, length;
 
@@ -30,7 +31,7 @@ static int blkpg_do_ioctl(struct block_device *bdev,
 		return -EINVAL;
 
 	if (op == BLKPG_DEL_PARTITION)
-		return bdev_del_partition(bdev, p.pno);
+		return bdev_del_partition(disk, p.pno);
 
 	start = p.start >> SECTOR_SHIFT;
 	length = p.length >> SECTOR_SHIFT;
@@ -40,9 +41,9 @@ static int blkpg_do_ioctl(struct block_device *bdev,
 		/* check if partition is aligned to blocksize */
 		if (p.start & (bdev_logical_block_size(bdev) - 1))
 			return -EINVAL;
-		return bdev_add_partition(bdev, p.pno, start, length);
+		return bdev_add_partition(disk, p.pno, start, length);
 	case BLKPG_RESIZE_PARTITION:
-		return bdev_resize_partition(bdev, p.pno, start, length);
+		return bdev_resize_partition(disk, p.pno, start, length);
 	default:
 		return -EINVAL;
 	}
diff --git a/block/partitions/core.c b/block/partitions/core.c
index 347c56a51d87..875bf6763b0e 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -449,30 +449,30 @@ static bool partition_overlaps(struct gendisk *disk, sector_t start,
 	return overlap;
 }
 
-int bdev_add_partition(struct block_device *bdev, int partno,
-		sector_t start, sector_t length)
+int bdev_add_partition(struct gendisk *disk, int partno, sector_t start,
+		sector_t length)
 {
 	struct block_device *part;
 
-	mutex_lock(&bdev->bd_disk->open_mutex);
-	if (partition_overlaps(bdev->bd_disk, start, length, -1)) {
-		mutex_unlock(&bdev->bd_disk->open_mutex);
+	mutex_lock(&disk->open_mutex);
+	if (partition_overlaps(disk, start, length, -1)) {
+		mutex_unlock(&disk->open_mutex);
 		return -EBUSY;
 	}
 
-	part = add_partition(bdev->bd_disk, partno, start, length,
-			ADDPART_FLAG_NONE, NULL);
-	mutex_unlock(&bdev->bd_disk->open_mutex);
+	part = add_partition(disk, partno, start, length, ADDPART_FLAG_NONE,
+			     NULL);
+	mutex_unlock(&disk->open_mutex);
 	return PTR_ERR_OR_ZERO(part);
 }
 
-int bdev_del_partition(struct block_device *bdev, int partno)
+int bdev_del_partition(struct gendisk *disk, int partno)
 {
 	struct block_device *part = NULL;
 	int ret = -ENXIO;
 
-	mutex_lock(&bdev->bd_disk->open_mutex);
-	part = xa_load(&bdev->bd_disk->part_tbl, partno);
+	mutex_lock(&disk->open_mutex);
+	part = xa_load(&disk->part_tbl, partno);
 	if (!part)
 		goto out_unlock;
 
@@ -483,18 +483,18 @@ int bdev_del_partition(struct block_device *bdev, int partno)
 	delete_partition(part);
 	ret = 0;
 out_unlock:
-	mutex_unlock(&bdev->bd_disk->open_mutex);
+	mutex_unlock(&disk->open_mutex);
 	return ret;
 }
 
-int bdev_resize_partition(struct block_device *bdev, int partno,
-		sector_t start, sector_t length)
+int bdev_resize_partition(struct gendisk *disk, int partno, sector_t start,
+		sector_t length)
 {
 	struct block_device *part = NULL;
 	int ret = -ENXIO;
 
-	mutex_lock(&bdev->bd_disk->open_mutex);
-	part = xa_load(&bdev->bd_disk->part_tbl, partno);
+	mutex_lock(&disk->open_mutex);
+	part = xa_load(&disk->part_tbl, partno);
 	if (!part)
 		goto out_unlock;
 
@@ -503,14 +503,14 @@ int bdev_resize_partition(struct block_device *bdev, int partno,
 		goto out_unlock;
 
 	ret = -EBUSY;
-	if (partition_overlaps(bdev->bd_disk, start, length, partno))
+	if (partition_overlaps(disk, start, length, partno))
 		goto out_unlock;
 
 	bdev_set_nr_sectors(part, length);
 
 	ret = 0;
 out_unlock:
-	mutex_unlock(&bdev->bd_disk->open_mutex);
+	mutex_unlock(&disk->open_mutex);
 	return ret;
 }
 
-- 
2.30.2

