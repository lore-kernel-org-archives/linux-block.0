Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B04A7C48BDF
	for <linux-block@archiver.kernel.org>; Thu, 24 Jun 2021 12:36:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95237613F6
	for <linux-block@archiver.kernel.org>; Thu, 24 Jun 2021 12:36:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231561AbhFXMiS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Jun 2021 08:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231635AbhFXMiL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Jun 2021 08:38:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D980DC061756
        for <linux-block@vger.kernel.org>; Thu, 24 Jun 2021 05:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=LsbQaWr+OntFzu3Fljjs/4+F5Gj0wSksQB7KLYXtDTQ=; b=Th1pPwYr0EoaCvDFXGWkCwMr3O
        ifJgWvGF2na6U5y9SRH2IieYlDDzHvXFeckMVLaWgb4u3L18P98VbzdF9inGf0kwkh03Gr71bCu26
        +SmLBhEMfdbp59lOHGRfZU40J9zWWDU9d0f6y05Pf2bTObr9UvTV9jOKGfAoSccEQm0PuyhDnS06R
        U/9aSSnghZe2B6oJVB5ruKY5UniL8uruBcTtJl/+VcvP4xmMWpgZE1z1iErwbBWCjD0OopwAhel4C
        dTWMdQ5/YXg6PqulLHqil+jvzAvWt9rMG1oy+HcbvcMz7zsUDoy3XkAcG89Wg70w6lkUEAFwYK3pW
        DKAS/zow==;
Received: from 213-225-9-92.nat.highway.a1.net ([213.225.9.92] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lwOZo-00GZT6-Lh; Thu, 24 Jun 2021 12:35:32 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 2/2] block: pass a gendisk to bdev_disk_changed
Date:   Thu, 24 Jun 2021 14:32:40 +0200
Message-Id: <20210624123240.441814-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210624123240.441814-1-hch@lst.de>
References: <20210624123240.441814-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

bdev_disk_changed can only operate on whole devices.  Make that clear
by passing a gendisk instead of the struct block_device.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/partitions/core.c         | 22 ++++++++++------------
 drivers/block/loop.c            | 21 ++++++++++-----------
 drivers/s390/block/dasd_genhd.c |  4 ++--
 fs/block_dev.c                  |  4 ++--
 include/linux/genhd.h           |  2 +-
 5 files changed, 25 insertions(+), 28 deletions(-)

diff --git a/block/partitions/core.c b/block/partitions/core.c
index b79785f7027c..347c56a51d87 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -120,8 +120,7 @@ static void free_partitions(struct parsed_partitions *state)
 	kfree(state);
 }
 
-static struct parsed_partitions *check_partition(struct gendisk *hd,
-		struct block_device *bdev)
+static struct parsed_partitions *check_partition(struct gendisk *hd)
 {
 	struct parsed_partitions *state;
 	int i, res, err;
@@ -136,7 +135,7 @@ static struct parsed_partitions *check_partition(struct gendisk *hd,
 	}
 	state->pp_buf[0] = '\0';
 
-	state->bdev = bdev;
+	state->bdev = hd->part0;
 	disk_name(hd, 0, state->name);
 	snprintf(state->pp_buf, PAGE_SIZE, " %s:", state->name);
 	if (isdigit(state->name[strlen(state->name)-1]))
@@ -546,7 +545,7 @@ void blk_drop_partitions(struct gendisk *disk)
 	}
 }
 
-static bool blk_add_partition(struct gendisk *disk, struct block_device *bdev,
+static bool blk_add_partition(struct gendisk *disk,
 		struct parsed_partitions *state, int p)
 {
 	sector_t size = state->parts[p].size;
@@ -596,7 +595,7 @@ static bool blk_add_partition(struct gendisk *disk, struct block_device *bdev,
 	return true;
 }
 
-static int blk_add_partitions(struct gendisk *disk, struct block_device *bdev)
+static int blk_add_partitions(struct gendisk *disk)
 {
 	struct parsed_partitions *state;
 	int ret = -EAGAIN, p;
@@ -604,7 +603,7 @@ static int blk_add_partitions(struct gendisk *disk, struct block_device *bdev)
 	if (!disk_part_scan_enabled(disk))
 		return 0;
 
-	state = check_partition(disk, bdev);
+	state = check_partition(disk);
 	if (!state)
 		return 0;
 	if (IS_ERR(state)) {
@@ -648,7 +647,7 @@ static int blk_add_partitions(struct gendisk *disk, struct block_device *bdev)
 	kobject_uevent(&disk_to_dev(disk)->kobj, KOBJ_CHANGE);
 
 	for (p = 1; p < state->limit; p++)
-		if (!blk_add_partition(disk, bdev, state, p))
+		if (!blk_add_partition(disk, state, p))
 			goto out_free_state;
 
 	ret = 0;
@@ -657,9 +656,8 @@ static int blk_add_partitions(struct gendisk *disk, struct block_device *bdev)
 	return ret;
 }
 
-int bdev_disk_changed(struct block_device *bdev, bool invalidate)
+int bdev_disk_changed(struct gendisk *disk, bool invalidate)
 {
-	struct gendisk *disk = bdev->bd_disk;
 	int ret = 0;
 
 	lockdep_assert_held(&disk->open_mutex);
@@ -670,8 +668,8 @@ int bdev_disk_changed(struct block_device *bdev, bool invalidate)
 rescan:
 	if (disk->open_partitions)
 		return -EBUSY;
-	sync_blockdev(bdev);
-	invalidate_bdev(bdev);
+	sync_blockdev(disk->part0);
+	invalidate_bdev(disk->part0);
 	blk_drop_partitions(disk);
 
 	clear_bit(GD_NEED_PART_SCAN, &disk->state);
@@ -691,7 +689,7 @@ int bdev_disk_changed(struct block_device *bdev, bool invalidate)
 	}
 
 	if (get_capacity(disk)) {
-		ret = blk_add_partitions(disk, bdev);
+		ret = blk_add_partitions(disk);
 		if (ret == -EAGAIN)
 			goto rescan;
 	} else if (invalidate) {
diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 40b7c6c470f2..c6e73c051790 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -647,14 +647,13 @@ static inline void loop_update_dio(struct loop_device *lo)
 				lo->use_dio);
 }
 
-static void loop_reread_partitions(struct loop_device *lo,
-				   struct block_device *bdev)
+static void loop_reread_partitions(struct loop_device *lo)
 {
 	int rc;
 
-	mutex_lock(&bdev->bd_disk->open_mutex);
-	rc = bdev_disk_changed(bdev, false);
-	mutex_unlock(&bdev->bd_disk->open_mutex);
+	mutex_lock(&lo->lo_disk->open_mutex);
+	rc = bdev_disk_changed(lo->lo_disk, false);
+	mutex_unlock(&lo->lo_disk->open_mutex);
 	if (rc)
 		pr_warn("%s: partition scan of loop%d (%s) failed (rc=%d)\n",
 			__func__, lo->lo_number, lo->lo_file_name, rc);
@@ -752,7 +751,7 @@ static int loop_change_fd(struct loop_device *lo, struct block_device *bdev,
 	 */
 	fput(old_file);
 	if (partscan)
-		loop_reread_partitions(lo, bdev);
+		loop_reread_partitions(lo);
 	return 0;
 
 out_err:
@@ -1175,7 +1174,7 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
 	bdgrab(bdev);
 	mutex_unlock(&lo->lo_mutex);
 	if (partscan)
-		loop_reread_partitions(lo, bdev);
+		loop_reread_partitions(lo);
 	if (!(mode & FMODE_EXCL))
 		bd_abort_claiming(bdev, loop_configure);
 	return 0;
@@ -1269,10 +1268,10 @@ static int __loop_clr_fd(struct loop_device *lo, bool release)
 		 * current holder is released.
 		 */
 		if (!release)
-			mutex_lock(&bdev->bd_disk->open_mutex);
-		err = bdev_disk_changed(bdev, false);
+			mutex_lock(&lo->lo_disk->open_mutex);
+		err = bdev_disk_changed(lo->lo_disk, false);
 		if (!release)
-			mutex_unlock(&bdev->bd_disk->open_mutex);
+			mutex_unlock(&lo->lo_disk->open_mutex);
 		if (err)
 			pr_warn("%s: partition scan of loop%d failed (rc=%d)\n",
 				__func__, lo_number, err);
@@ -1417,7 +1416,7 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 out_unlock:
 	mutex_unlock(&lo->lo_mutex);
 	if (partscan)
-		loop_reread_partitions(lo, bdev);
+		loop_reread_partitions(lo);
 
 	return err;
 }
diff --git a/drivers/s390/block/dasd_genhd.c b/drivers/s390/block/dasd_genhd.c
index bf2082d461c7..493e8469893c 100644
--- a/drivers/s390/block/dasd_genhd.c
+++ b/drivers/s390/block/dasd_genhd.c
@@ -110,7 +110,7 @@ int dasd_scan_partitions(struct dasd_block *block)
 	}
 
 	mutex_lock(&block->gdp->open_mutex);
-	rc = bdev_disk_changed(bdev, false);
+	rc = bdev_disk_changed(block->gdp, false);
 	mutex_unlock(&block->gdp->open_mutex);
 	if (rc)
 		DBF_DEV_EVENT(DBF_ERR, block->base,
@@ -146,7 +146,7 @@ void dasd_destroy_partitions(struct dasd_block *block)
 	block->bdev = NULL;
 
 	mutex_lock(&bdev->bd_disk->open_mutex);
-	bdev_disk_changed(bdev, true);
+	bdev_disk_changed(bdev->bd_disk, true);
 	mutex_unlock(&bdev->bd_disk->open_mutex);
 
 	/* Matching blkdev_put to the blkdev_get in dasd_scan_partitions. */
diff --git a/fs/block_dev.c b/fs/block_dev.c
index 5b3a73ecb696..34253d155f5c 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1253,7 +1253,7 @@ static int blkdev_get_whole(struct block_device *bdev, fmode_t mode)
 			/* avoid ghost partitions on a removed medium */
 			if (ret == -ENOMEDIUM &&
 			     test_bit(GD_NEED_PART_SCAN, &disk->state))
-				bdev_disk_changed(bdev, true);
+				bdev_disk_changed(disk, true);
 			return ret;
 		}
 	}
@@ -1264,7 +1264,7 @@ static int blkdev_get_whole(struct block_device *bdev, fmode_t mode)
 			bdev->bd_bdi = bdi_get(disk->queue->backing_dev_info);
 	}
 	if (test_bit(GD_NEED_PART_SCAN, &disk->state))
-		bdev_disk_changed(bdev, false);
+		bdev_disk_changed(disk, false);
 	bdev->bd_openers++;
 	return 0;;
 }
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index f5f0c9bdf1d2..13b34177cc85 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -256,7 +256,7 @@ static inline sector_t get_capacity(struct gendisk *disk)
 	return bdev_nr_sectors(disk->part0);
 }
 
-int bdev_disk_changed(struct block_device *bdev, bool invalidate);
+int bdev_disk_changed(struct gendisk *disk, bool invalidate);
 void blk_drop_partitions(struct gendisk *disk);
 
 extern struct gendisk *__alloc_disk_node(int minors, int node_id);
-- 
2.30.2

