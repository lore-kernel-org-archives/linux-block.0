Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46CB9C433EF
	for <linux-block@archiver.kernel.org>; Wed, 29 Jun 2022 06:20:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231805AbiF2GU0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Jun 2022 02:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiF2GUZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Jun 2022 02:20:25 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E1ED1E3DA
        for <linux-block@vger.kernel.org>; Tue, 28 Jun 2022 23:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=w+eAhaEwYzrBKv1p2vOIrioeBsl4ezmWD5aFt2jnr5s=; b=di30CmgUipzyelyKhtkOz8ARBM
        YE93a5qg7n77HnoRBdRXfGtP7zFIFBfKzePHd4ayKpLO2ebH9v4SXaJ28nuhIzNpihX806eykXfZj
        ZIGIiGM+RU+7O6vlTrxtRm9lqO/pO+ui/Mg8Y7uW+IgkaUdFm86g0t8MC4Fhs457ncHVs1duwNlGc
        VfhKt+uxNSSq96M2bVNhADttzjVbLhkbbkr3sXMxKzanAl0ETp/irlaPz1z2C5tOCLHLkoAdSQIi1
        Dhp7ajwv8l8Cv+3/cEyn3O6VXUeMiazy/K0EeaQYHcWCYWYCpMdmYUzDXm2ccCjmDg7cBG1weKo9/
        FuRgQrfQ==;
Received: from [2001:4bb8:199:3788:6e38:f996:aa54:7e1e] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o6R3n-009knu-Mr; Wed, 29 Jun 2022 06:20:24 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>,
        Damien Le Moal <damien.lemoal@wdc.com>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 2/2] block: simplify disk_set_independent_access_ranges
Date:   Wed, 29 Jun 2022 08:20:13 +0200
Message-Id: <20220629062013.1331068-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220629062013.1331068-1-hch@lst.de>
References: <20220629062013.1331068-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Lift setting disk->ia_ranges from disk_register_independent_access_ranges
into disk_set_independent_access_ranges, and make the behavior the same
for the registered vs non-registered queue cases.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-ia-ranges.c | 57 ++++++++++++-------------------------------
 block/blk-sysfs.c     |  2 +-
 block/blk.h           |  3 +--
 3 files changed, 18 insertions(+), 44 deletions(-)

diff --git a/block/blk-ia-ranges.c b/block/blk-ia-ranges.c
index c1bf14bcd15f4..2bd1d311033b5 100644
--- a/block/blk-ia-ranges.c
+++ b/block/blk-ia-ranges.c
@@ -102,31 +102,18 @@ static struct kobj_type blk_ia_ranges_ktype = {
  * disk_register_independent_access_ranges - register with sysfs a set of
  *		independent access ranges
  * @disk:	Target disk
- * @new_iars:	New set of independent access ranges
  *
  * Register with sysfs a set of independent access ranges for @disk.
- * If @new_iars is not NULL, this set of ranges is registered and the old set
- * specified by disk->ia_ranges is unregistered. Otherwise, disk->ia_ranges is
- * registered if it is not already.
  */
-int disk_register_independent_access_ranges(struct gendisk *disk,
-				struct blk_independent_access_ranges *new_iars)
+int disk_register_independent_access_ranges(struct gendisk *disk)
 {
+	struct blk_independent_access_ranges *iars = disk->ia_ranges;
 	struct request_queue *q = disk->queue;
-	struct blk_independent_access_ranges *iars;
 	int i, ret;
 
 	lockdep_assert_held(&q->sysfs_dir_lock);
 	lockdep_assert_held(&q->sysfs_lock);
 
-	/* If a new range set is specified, unregister the old one */
-	if (new_iars) {
-		if (disk->ia_ranges)
-			disk_unregister_independent_access_ranges(disk);
-		disk->ia_ranges = new_iars;
-	}
-
-	iars = disk->ia_ranges;
 	if (!iars)
 		return 0;
 
@@ -210,6 +197,9 @@ static bool disk_check_ia_ranges(struct gendisk *disk,
 	sector_t sector = 0;
 	int i;
 
+	if (WARN_ON_ONCE(!iars->nr_ia_ranges))
+		return false;
+
 	/*
 	 * While sorting the ranges in increasing LBA order, check that the
 	 * ranges do not overlap, that there are no sector holes and that all
@@ -298,25 +288,15 @@ void disk_set_independent_access_ranges(struct gendisk *disk,
 {
 	struct request_queue *q = disk->queue;
 
-	if (WARN_ON_ONCE(iars && !iars->nr_ia_ranges)) {
+	mutex_lock(&q->sysfs_dir_lock);
+	mutex_lock(&q->sysfs_lock);
+	if (iars && !disk_check_ia_ranges(disk, iars)) {
 		kfree(iars);
 		iars = NULL;
 	}
-
-	mutex_lock(&q->sysfs_dir_lock);
-	mutex_lock(&q->sysfs_lock);
-
-	if (iars) {
-		if (!disk_check_ia_ranges(disk, iars)) {
-			kfree(iars);
-			iars = NULL;
-			goto reg;
-		}
-
-		if (!disk_ia_ranges_changed(disk, iars)) {
-			kfree(iars);
-			goto unlock;
-		}
+	if (iars && !disk_ia_ranges_changed(disk, iars)) {
+		kfree(iars);
+		goto unlock;
 	}
 
 	/*
@@ -324,17 +304,12 @@ void disk_set_independent_access_ranges(struct gendisk *disk,
 	 * revalidation. If that is the case, we need to unregister the old
 	 * set of independent access ranges and register the new set. If the
 	 * queue is not registered, registration of the device request queue
-	 * will register the independent access ranges, so only swap in the
-	 * new set and free the old one.
+	 * will register the independent access ranges.
 	 */
-reg:
-	if (blk_queue_registered(q)) {
-		disk_register_independent_access_ranges(disk, iars);
-	} else {
-		swap(disk->ia_ranges, iars);
-		kfree(iars);
-	}
-
+	disk_unregister_independent_access_ranges(disk);
+	disk->ia_ranges = iars;
+	if (blk_queue_registered(q))
+		disk_register_independent_access_ranges(disk);
 unlock:
 	mutex_unlock(&q->sysfs_lock);
 	mutex_unlock(&q->sysfs_dir_lock);
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 85ea43eff094c..58cb9cb9f48cd 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -832,7 +832,7 @@ int blk_register_queue(struct gendisk *disk)
 		blk_mq_debugfs_register(q);
 	mutex_unlock(&q->debugfs_mutex);
 
-	ret = disk_register_independent_access_ranges(disk, NULL);
+	ret = disk_register_independent_access_ranges(disk);
 	if (ret)
 		goto put_dev;
 
diff --git a/block/blk.h b/block/blk.h
index 74d59435870cb..58ad50cacd2d5 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -459,8 +459,7 @@ long compat_blkdev_ioctl(struct file *file, unsigned cmd, unsigned long arg);
 
 extern const struct address_space_operations def_blk_aops;
 
-int disk_register_independent_access_ranges(struct gendisk *disk,
-				struct blk_independent_access_ranges *new_iars);
+int disk_register_independent_access_ranges(struct gendisk *disk);
 void disk_unregister_independent_access_ranges(struct gendisk *disk);
 
 #ifdef CONFIG_FAIL_MAKE_REQUEST
-- 
2.30.2

