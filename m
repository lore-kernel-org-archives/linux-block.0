Return-Path: <SRS0=aEt0=ZG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC453C432C3
	for <linux-block@archiver.kernel.org>; Thu, 14 Nov 2019 14:34:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94F7420709
	for <linux-block@archiver.kernel.org>; Thu, 14 Nov 2019 14:34:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AHLN1wTo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbfKNOew (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Nov 2019 09:34:52 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:38548 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbfKNOew (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Nov 2019 09:34:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=smMIf5d5Q5aKw/SzyUzCMvGHgO1WCyubOuxyXylTzIg=; b=AHLN1wTobfiankSBhemFuo0+Ul
        hmb0DECVuJ9EuC1gpdzZVcJRJxJJSULEYQt4aFbJnxTR2DiVWCUiw2fmIcIHtx4AbZyoyqdOYZTle
        lgDhOp31NyzCiBXohJOmI1mD1ELdwgStUXP6EHyyLp9QN0LiInOdZB5ywvOORVwUkXUthTGk637zQ
        +xic6QEYk/gmBAzwm5jti9CgihJ9XjMhTtXiPE6yZu6FWOxnVB54fcUemYwsND1fqt4x9ccuAG/rq
        u6z+F1QXhOEGsNVuIRZyRqySlAINSZGReFFpay5tv5+4aaO5q6N3fk2768+rPNlcofaKZFpVBXewp
        p0k81OyA==;
Received: from [2001:4bb8:180:3806:c70:4a89:bc61:6] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iVGCw-0004kH-Tt; Thu, 14 Nov 2019 14:34:51 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>
Cc:     linux-block@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH 4/7] block: fix bdev_disk_changed for non-partitioned devices
Date:   Thu, 14 Nov 2019 15:34:35 +0100
Message-Id: <20191114143438.14681-5-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191114143438.14681-1-hch@lst.de>
References: <20191114143438.14681-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We still have to set the capacity to 0 if invalidating or call
revalidate_disk if not even if the disk has no partitions.  Fix
that by merging rescan_partitions into bdev_disk_changed and just
stubbing out blk_add_partitions and blk_drop_partitions for
non-partitioned devices.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 block/ioctl.c             |  6 ++----
 block/partition-generic.c |  5 +++++
 fs/block_dev.c            | 27 ++++++++-------------------
 include/linux/genhd.h     |  1 +
 4 files changed, 16 insertions(+), 23 deletions(-)

diff --git a/block/ioctl.c b/block/ioctl.c
index f6576a6d5778..5ccd9f016594 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -162,16 +162,14 @@ static int blkpg_ioctl(struct block_device *bdev, struct blkpg_ioctl_arg __user
  */
 int __blkdev_reread_part(struct block_device *bdev)
 {
-	struct gendisk *disk = bdev->bd_disk;
-
-	if (!disk_part_scan_enabled(disk) || bdev != bdev->bd_contains)
+	if (!disk_part_scan_enabled(bdev->bd_disk) || bdev != bdev->bd_contains)
 		return -EINVAL;
 	if (!capable(CAP_SYS_ADMIN))
 		return -EACCES;
 
 	lockdep_assert_held(&bdev->bd_mutex);
 
-	return rescan_partitions(disk, bdev, false);
+	return bdev_disk_changed(bdev, false);
 }
 EXPORT_SYMBOL(__blkdev_reread_part);
 
diff --git a/block/partition-generic.c b/block/partition-generic.c
index 2cbc23f6032c..61487421a319 100644
--- a/block/partition-generic.c
+++ b/block/partition-generic.c
@@ -445,6 +445,8 @@ int blk_drop_partitions(struct gendisk *disk, struct block_device *bdev)
 	struct hd_struct *part;
 	int res;
 
+	if (!disk_part_scan_enabled(disk))
+		return 0;
 	if (bdev->bd_part_count || bdev->bd_super)
 		return -EBUSY;
 	res = invalidate_partition(disk, 0);
@@ -514,6 +516,9 @@ int blk_add_partitions(struct gendisk *disk, struct block_device *bdev)
 	struct parsed_partitions *state;
 	int ret = -EAGAIN, p, highest;
 
+	if (!disk_part_scan_enabled(disk))
+		return 0;
+
 	state = check_partition(disk, bdev);
 	if (!state)
 		return 0;
diff --git a/fs/block_dev.c b/fs/block_dev.c
index f0710085e1f1..ae16466a67f7 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1508,9 +1508,9 @@ EXPORT_SYMBOL(bd_set_size);
 
 static void __blkdev_put(struct block_device *bdev, fmode_t mode, int for_part);
 
-static int rescan_partitions(struct gendisk *disk, struct block_device *bdev,
-		bool invalidate)
+int bdev_disk_changed(struct block_device *bdev, bool invalidate)
 {
+	struct gendisk *disk = bdev->bd_disk;
 	int ret;
 
 rescan:
@@ -1526,30 +1526,19 @@ static int rescan_partitions(struct gendisk *disk, struct block_device *bdev,
 	check_disk_size_change(disk, bdev, !invalidate);
 	bdev->bd_invalidated = 0;
 
-	if (!get_capacity(disk)) {
+	if (get_capacity(disk)) {
+		ret = blk_add_partitions(disk, bdev);
+		if (ret == -EAGAIN)
+			goto rescan;
+	} else {
 		/*
 		 * Tell userspace that the media / partition table may have
 		 * changed.
 		 */
 		kobject_uevent(&disk_to_dev(disk)->kobj, KOBJ_CHANGE);
-		return 0;
 	}
-	
-	ret = blk_add_partitions(disk, bdev);
-	if (ret == -EAGAIN)
-		goto rescan;
-	return ret;
-}
 
-
-static void bdev_disk_changed(struct block_device *bdev, bool invalidate)
-{
-	if (disk_part_scan_enabled(bdev->bd_disk)) {
-		rescan_partitions(bdev->bd_disk, bdev, invalidate);
-	} else {
-		check_disk_size_change(bdev->bd_disk, bdev, !invalidate);
-		bdev->bd_invalidated = 0;
-	}
+	return ret;
 }
 
 /*
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index f5cffbf63abf..8bb63027e4d6 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -621,6 +621,7 @@ extern void blk_invalidate_devt(dev_t devt);
 extern dev_t blk_lookup_devt(const char *name, int partno);
 extern char *disk_name (struct gendisk *hd, int partno, char *buf);
 
+int bdev_disk_changed(struct block_device *bdev, bool invalidate);
 int blk_add_partitions(struct gendisk *disk, struct block_device *bdev);
 int blk_drop_partitions(struct gendisk *disk, struct block_device *bdev);
 extern int disk_expand_part_tbl(struct gendisk *disk, int target);
-- 
2.20.1

