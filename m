Return-Path: <SRS0=NI9l=Y6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8245EC5DF63
	for <linux-block@archiver.kernel.org>; Wed,  6 Nov 2019 15:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54229217F5
	for <linux-block@archiver.kernel.org>; Wed,  6 Nov 2019 15:14:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ne45Ql2n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbfKFPOt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Nov 2019 10:14:49 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:60388 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727685AbfKFPOt (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Nov 2019 10:14:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=tacAcoHLke84A2MUEU/oq+4ea9NtkuV3dVYNPQrLTp0=; b=Ne45Ql2n9yxF/Q9gHsg9XnYliA
        YATb2NnTLlXehyXsYFzJDqJVYVkNGOX4onyulZ3/xghYT/BUSnnEuedWe/AWUQMN6ZSTxTQ2TkfTZ
        JF8zXIGqiITj/BbdnV72KQkLM8XlfSmwokssqc4/xvIfdTLZLgCtM3oDcLJe+B++fPJfbMxIFBz58
        CIMOeollRyFsfUpw8V/XAFJdJ1eKlQKQShEZlLWuorG+fb5n51+/qOuRyxFNULUz+tpFBj12Gf9Z5
        0wuGhlr6bC2Rxo4KRAPDnR64QLQ1vJvDXQW9Vcs9S435UQ38tbNu8P74zC3bJfL13Mdnp/obmo0hs
        QqQDKLDA==;
Received: from [88.128.80.117] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iSN1E-0005Ep-89; Wed, 06 Nov 2019 15:14:48 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>
Cc:     linux-block@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH 3/5] block: move rescan_partitions to fs/block_dev.c
Date:   Wed,  6 Nov 2019 16:14:37 +0100
Message-Id: <20191106151439.30056-4-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191106151439.30056-1-hch@lst.de>
References: <20191106151439.30056-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Large parts of rescan_partitions aren't about partitions, and
moving it to block_dev.c will allow for some further cleanups by
merging it into its only caller.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/partition-generic.c | 37 ++-----------------------------------
 fs/block_dev.c            | 38 ++++++++++++++++++++++++++++++++++++--
 include/linux/fs.h        |  2 --
 include/linux/genhd.h     |  4 ++--
 4 files changed, 40 insertions(+), 41 deletions(-)

diff --git a/block/partition-generic.c b/block/partition-generic.c
index eae9daa8a523..7a6e406ac490 100644
--- a/block/partition-generic.c
+++ b/block/partition-generic.c
@@ -439,7 +439,7 @@ static bool disk_unlock_native_capacity(struct gendisk *disk)
 	}
 }
 
-static int drop_partitions(struct gendisk *disk, struct block_device *bdev)
+int blk_drop_partitions(struct gendisk *disk, struct block_device *bdev)
 {
 	struct disk_part_iter piter;
 	struct hd_struct *part;
@@ -573,7 +573,7 @@ static bool blk_add_partition(struct gendisk *disk, struct block_device *bdev,
 	return true;
 }
 
-static int blk_add_partitions(struct gendisk *disk, struct block_device *bdev)
+int blk_add_partitions(struct gendisk *disk, struct block_device *bdev)
 {
 	struct parsed_partitions *state;
 	int ret = -EAGAIN, p, highest;
@@ -632,39 +632,6 @@ static int blk_add_partitions(struct gendisk *disk, struct block_device *bdev)
 	return ret;
 }
 
-int rescan_partitions(struct gendisk *disk, struct block_device *bdev,
-		bool invalidate)
-{
-	int ret;
-
-rescan:
-	ret = drop_partitions(disk, bdev);
-	if (ret)
-		return ret;
-
-	if (invalidate)
-		set_capacity(disk, 0);
-	else if (disk->fops->revalidate_disk)
-		disk->fops->revalidate_disk(disk);
-
-	check_disk_size_change(disk, bdev, !invalidate);
-	bdev->bd_invalidated = 0;
-
-	if (!get_capacity(disk)) {
-		/*
-		 * Tell userspace that the media / partition table may have
-		 * changed.
-		 */
-		kobject_uevent(&disk_to_dev(disk)->kobj, KOBJ_CHANGE);
-		return 0;
-	}
-	
-	ret = blk_add_partitions(disk, bdev);
-	if (ret == -EAGAIN)
-		goto rescan;
-	return ret;
-}
-
 unsigned char *read_dev_sector(struct block_device *bdev, sector_t n, Sector *p)
 {
 	struct address_space *mapping = bdev->bd_inode->i_mapping;
diff --git a/fs/block_dev.c b/fs/block_dev.c
index 0af62b76d031..f0710085e1f1 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1416,8 +1416,8 @@ static void flush_disk(struct block_device *bdev, bool kill_dirty)
  * and adjusts it if it differs. When shrinking the bdev size, its all caches
  * are freed.
  */
-void check_disk_size_change(struct gendisk *disk, struct block_device *bdev,
-		bool verbose)
+static void check_disk_size_change(struct gendisk *disk,
+		struct block_device *bdev, bool verbose)
 {
 	loff_t disk_size, bdev_size;
 
@@ -1508,6 +1508,40 @@ EXPORT_SYMBOL(bd_set_size);
 
 static void __blkdev_put(struct block_device *bdev, fmode_t mode, int for_part);
 
+static int rescan_partitions(struct gendisk *disk, struct block_device *bdev,
+		bool invalidate)
+{
+	int ret;
+
+rescan:
+	ret = blk_drop_partitions(disk, bdev);
+	if (ret)
+		return ret;
+
+	if (invalidate)
+		set_capacity(disk, 0);
+	else if (disk->fops->revalidate_disk)
+		disk->fops->revalidate_disk(disk);
+
+	check_disk_size_change(disk, bdev, !invalidate);
+	bdev->bd_invalidated = 0;
+
+	if (!get_capacity(disk)) {
+		/*
+		 * Tell userspace that the media / partition table may have
+		 * changed.
+		 */
+		kobject_uevent(&disk_to_dev(disk)->kobj, KOBJ_CHANGE);
+		return 0;
+	}
+	
+	ret = blk_add_partitions(disk, bdev);
+	if (ret == -EAGAIN)
+		goto rescan;
+	return ret;
+}
+
+
 static void bdev_disk_changed(struct block_device *bdev, bool invalidate)
 {
 	if (disk_part_scan_enabled(bdev->bd_disk)) {
diff --git a/include/linux/fs.h b/include/linux/fs.h
index e0d909d35763..d233dd661df7 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2703,8 +2703,6 @@ extern void make_bad_inode(struct inode *);
 extern bool is_bad_inode(struct inode *);
 
 #ifdef CONFIG_BLOCK
-extern void check_disk_size_change(struct gendisk *disk,
-		struct block_device *bdev, bool verbose);
 extern int revalidate_disk(struct gendisk *);
 extern int check_disk_change(struct block_device *);
 extern int __invalidate_device(struct block_device *, bool);
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index fd7774e64f0b..f5cffbf63abf 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -621,9 +621,9 @@ extern void blk_invalidate_devt(dev_t devt);
 extern dev_t blk_lookup_devt(const char *name, int partno);
 extern char *disk_name (struct gendisk *hd, int partno, char *buf);
 
+int blk_add_partitions(struct gendisk *disk, struct block_device *bdev);
+int blk_drop_partitions(struct gendisk *disk, struct block_device *bdev);
 extern int disk_expand_part_tbl(struct gendisk *disk, int target);
-int rescan_partitions(struct gendisk *disk, struct block_device *bdev,
-		bool invalidate);
 extern struct hd_struct * __must_check add_partition(struct gendisk *disk,
 						     int partno, sector_t start,
 						     sector_t len, int flags,
-- 
2.20.1

