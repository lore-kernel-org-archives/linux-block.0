Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0DBBC48BDF
	for <linux-block@archiver.kernel.org>; Thu, 24 Jun 2021 12:35:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0431600EF
	for <linux-block@archiver.kernel.org>; Thu, 24 Jun 2021 12:35:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbhFXMho (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Jun 2021 08:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbhFXMhn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Jun 2021 08:37:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D7F6C061574
        for <linux-block@vger.kernel.org>; Thu, 24 Jun 2021 05:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=b5+RZ8OsXvSBOeiUSDNdVIyj89ncLN4j4pS9giNo44Q=; b=t7Hb8w7IDEI54wb38fxEqbourY
        GMPwOpdZia6xsiU6ptbbChBHqlAlljsnkQvwiv+WjwaycGPx2+LBW9ZsRe4EQX9FproQZtLOGWLtQ
        4iuqLbiR6sIM0RagJFKPx4gji42yd5xa/A+zS7qbUxyeaDIm5xjzNKkjgwA5JGsTn1PY8K43UYCYd
        1GEECEcBYy3XRJqOhmoxWhaQuVx+QmZCmk0qqsYFwp6KmQsONL3hu8PZXS0VH6FPd8tcOQxlS4AmG
        uVY/qRqrFED4rdPegx76gPUkgTL21gDfzHryZC4GEqsEJ1fR8ba7PTrpP2RGJ9XzVJE5E8MVk/oYJ
        cBZYsmsw==;
Received: from 213-225-9-92.nat.highway.a1.net ([213.225.9.92] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lwOZG-00GZRE-Ls; Thu, 24 Jun 2021 12:34:55 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 1/2] block: move bdev_disk_changed
Date:   Thu, 24 Jun 2021 14:32:39 +0200
Message-Id: <20210624123240.441814-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210624123240.441814-1-hch@lst.de>
References: <20210624123240.441814-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Move bdev_disk_changed to block/partitions/core.c, together with the
rest of the partition scanning code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/partitions/core.c | 55 ++++++++++++++++++++++++++++++++++++++++-
 fs/block_dev.c          | 53 ---------------------------------------
 include/linux/genhd.h   |  1 -
 3 files changed, 54 insertions(+), 55 deletions(-)

diff --git a/block/partitions/core.c b/block/partitions/core.c
index 186d4fbd9f09..b79785f7027c 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -596,7 +596,7 @@ static bool blk_add_partition(struct gendisk *disk, struct block_device *bdev,
 	return true;
 }
 
-int blk_add_partitions(struct gendisk *disk, struct block_device *bdev)
+static int blk_add_partitions(struct gendisk *disk, struct block_device *bdev)
 {
 	struct parsed_partitions *state;
 	int ret = -EAGAIN, p;
@@ -657,6 +657,59 @@ int blk_add_partitions(struct gendisk *disk, struct block_device *bdev)
 	return ret;
 }
 
+int bdev_disk_changed(struct block_device *bdev, bool invalidate)
+{
+	struct gendisk *disk = bdev->bd_disk;
+	int ret = 0;
+
+	lockdep_assert_held(&disk->open_mutex);
+
+	if (!(disk->flags & GENHD_FL_UP))
+		return -ENXIO;
+
+rescan:
+	if (disk->open_partitions)
+		return -EBUSY;
+	sync_blockdev(bdev);
+	invalidate_bdev(bdev);
+	blk_drop_partitions(disk);
+
+	clear_bit(GD_NEED_PART_SCAN, &disk->state);
+
+	/*
+	 * Historically we only set the capacity to zero for devices that
+	 * support partitions (independ of actually having partitions created).
+	 * Doing that is rather inconsistent, but changing it broke legacy
+	 * udisks polling for legacy ide-cdrom devices.  Use the crude check
+	 * below to get the sane behavior for most device while not breaking
+	 * userspace for this particular setup.
+	 */
+	if (invalidate) {
+		if (disk_part_scan_enabled(disk) ||
+		    !(disk->flags & GENHD_FL_REMOVABLE))
+			set_capacity(disk, 0);
+	}
+
+	if (get_capacity(disk)) {
+		ret = blk_add_partitions(disk, bdev);
+		if (ret == -EAGAIN)
+			goto rescan;
+	} else if (invalidate) {
+		/*
+		 * Tell userspace that the media / partition table may have
+		 * changed.
+		 */
+		kobject_uevent(&disk_to_dev(disk)->kobj, KOBJ_CHANGE);
+	}
+
+	return ret;
+}
+/*
+ * Only exported for loop and dasd for historic reasons.  Don't use in new
+ * code!
+ */
+EXPORT_SYMBOL_GPL(bdev_disk_changed);
+
 void *read_part_sector(struct parsed_partitions *state, sector_t n, Sector *p)
 {
 	struct address_space *mapping = state->bdev->bd_inode->i_mapping;
diff --git a/fs/block_dev.c b/fs/block_dev.c
index ac9b3c158a77..5b3a73ecb696 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1242,59 +1242,6 @@ static void blkdev_flush_mapping(struct block_device *bdev)
 	bdev_write_inode(bdev);
 }
 
-int bdev_disk_changed(struct block_device *bdev, bool invalidate)
-{
-	struct gendisk *disk = bdev->bd_disk;
-	int ret = 0;
-
-	lockdep_assert_held(&disk->open_mutex);
-
-	if (!(disk->flags & GENHD_FL_UP))
-		return -ENXIO;
-
-rescan:
-	if (disk->open_partitions)
-		return -EBUSY;
-	sync_blockdev(bdev);
-	invalidate_bdev(bdev);
-	blk_drop_partitions(disk);
-
-	clear_bit(GD_NEED_PART_SCAN, &disk->state);
-
-	/*
-	 * Historically we only set the capacity to zero for devices that
-	 * support partitions (independ of actually having partitions created).
-	 * Doing that is rather inconsistent, but changing it broke legacy
-	 * udisks polling for legacy ide-cdrom devices.  Use the crude check
-	 * below to get the sane behavior for most device while not breaking
-	 * userspace for this particular setup.
-	 */
-	if (invalidate) {
-		if (disk_part_scan_enabled(disk) ||
-		    !(disk->flags & GENHD_FL_REMOVABLE))
-			set_capacity(disk, 0);
-	}
-
-	if (get_capacity(disk)) {
-		ret = blk_add_partitions(disk, bdev);
-		if (ret == -EAGAIN)
-			goto rescan;
-	} else if (invalidate) {
-		/*
-		 * Tell userspace that the media / partition table may have
-		 * changed.
-		 */
-		kobject_uevent(&disk_to_dev(disk)->kobj, KOBJ_CHANGE);
-	}
-
-	return ret;
-}
-/*
- * Only exported for loop and dasd for historic reasons.  Don't use in new
- * code!
- */
-EXPORT_SYMBOL_GPL(bdev_disk_changed);
-
 static int blkdev_get_whole(struct block_device *bdev, fmode_t mode)
 {
 	struct gendisk *disk = bdev->bd_disk;
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 03d684f0498f..f5f0c9bdf1d2 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -257,7 +257,6 @@ static inline sector_t get_capacity(struct gendisk *disk)
 }
 
 int bdev_disk_changed(struct block_device *bdev, bool invalidate);
-int blk_add_partitions(struct gendisk *disk, struct block_device *bdev);
 void blk_drop_partitions(struct gendisk *disk);
 
 extern struct gendisk *__alloc_disk_node(int minors, int node_id);
-- 
2.30.2

