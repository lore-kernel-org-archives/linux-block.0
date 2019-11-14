Return-Path: <SRS0=aEt0=ZG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD795C43141
	for <linux-block@archiver.kernel.org>; Thu, 14 Nov 2019 14:34:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE4FD20709
	for <linux-block@archiver.kernel.org>; Thu, 14 Nov 2019 14:34:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VR7Bg6CN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbfKNOer (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Nov 2019 09:34:47 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:38514 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbfKNOer (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Nov 2019 09:34:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=O4l7BMR5gaC47QiwcEUqc8ISxjKkayarR0B4kx4FRkQ=; b=VR7Bg6CNxVpv2zMH94eRuYv2nf
        cKaHk746Kd4psY4INhQ6Fp5zAQoVYbpw1z6LdoOv2PkjWBreH/BZaoOk1jubf9bjFejgxUWGfSlZ0
        EFqpD5v+41HPu2SbDLdZmXwcTqHRMDRyf21by2+dbXLyB07sW5Ov6YTL8bcwFHdgqJbzPu67xO86z
        OR5JuIMU6d3pyTBkzhDEcry554NLCal9To+K/NW51hInLB//vFEnZbDBqlh8rB1iaogqxRU2hXOYq
        TZFXt2xh0VvRhhEoP1iMGS2kbHleQfxiKSZB0KqaYPKx9ggM/7NbmDGqkPahHvedduQKelcMY6Ces
        pXrx/oyQ==;
Received: from [2001:4bb8:180:3806:c70:4a89:bc61:6] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iVGCr-0004jH-Sw; Thu, 14 Nov 2019 14:34:46 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>
Cc:     linux-block@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH 2/7] block: merge invalidate_partitions into rescan_partitions
Date:   Thu, 14 Nov 2019 15:34:33 +0100
Message-Id: <20191114143438.14681-3-hch@lst.de>
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

A lot of the logic in invalidate_partitions and rescan_partitions is
shared.  Merge the two functions to simplify things.  There is a small
behavior change in that we now send the kevent change notice also if we
were not invalidating but no partitions were found, which seems like
the right thing to do.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 block/ioctl.c             |  2 +-
 block/partition-generic.c | 38 ++++++++++++++------------------------
 fs/block_dev.c            |  5 +----
 include/linux/genhd.h     |  4 ++--
 4 files changed, 18 insertions(+), 31 deletions(-)

diff --git a/block/ioctl.c b/block/ioctl.c
index 8756efb1419e..f6576a6d5778 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -171,7 +171,7 @@ int __blkdev_reread_part(struct block_device *bdev)
 
 	lockdep_assert_held(&bdev->bd_mutex);
 
-	return rescan_partitions(disk, bdev);
+	return rescan_partitions(disk, bdev, false);
 }
 EXPORT_SYMBOL(__blkdev_reread_part);
 
diff --git a/block/partition-generic.c b/block/partition-generic.c
index 0909f66aab9d..da39a858fe47 100644
--- a/block/partition-generic.c
+++ b/block/partition-generic.c
@@ -576,7 +576,8 @@ static int blk_add_partitions(struct gendisk *disk, struct block_device *bdev)
 	return ret;
 }
 
-int rescan_partitions(struct gendisk *disk, struct block_device *bdev)
+int rescan_partitions(struct gendisk *disk, struct block_device *bdev,
+		bool invalidate)
 {
 	int ret;
 
@@ -585,13 +586,22 @@ int rescan_partitions(struct gendisk *disk, struct block_device *bdev)
 	if (ret)
 		return ret;
 
-	if (disk->fops->revalidate_disk)
+	if (invalidate)
+		set_capacity(disk, 0);
+	else if (disk->fops->revalidate_disk)
 		disk->fops->revalidate_disk(disk);
-	check_disk_size_change(disk, bdev, true);
+
+	check_disk_size_change(disk, bdev, !invalidate);
 	bdev->bd_invalidated = 0;
 
-	if (!get_capacity(disk))
+	if (!get_capacity(disk)) {
+		/*
+		 * Tell userspace that the media / partition table may have
+		 * changed.
+		 */
+		kobject_uevent(&disk_to_dev(disk)->kobj, KOBJ_CHANGE);
 		return 0;
+	}
 	
 	ret = blk_add_partitions(disk, bdev);
 	if (ret == -EAGAIN)
@@ -599,26 +609,6 @@ int rescan_partitions(struct gendisk *disk, struct block_device *bdev)
 	return ret;
 }
 
-int invalidate_partitions(struct gendisk *disk, struct block_device *bdev)
-{
-	int res;
-
-	if (!bdev->bd_invalidated)
-		return 0;
-
-	res = drop_partitions(disk, bdev);
-	if (res)
-		return res;
-
-	set_capacity(disk, 0);
-	check_disk_size_change(disk, bdev, false);
-	bdev->bd_invalidated = 0;
-	/* tell userspace that the media / partition table may have changed */
-	kobject_uevent(&disk_to_dev(disk)->kobj, KOBJ_CHANGE);
-
-	return 0;
-}
-
 unsigned char *read_dev_sector(struct block_device *bdev, sector_t n, Sector *p)
 {
 	struct address_space *mapping = bdev->bd_inode->i_mapping;
diff --git a/fs/block_dev.c b/fs/block_dev.c
index d612468ee66b..0af62b76d031 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1511,10 +1511,7 @@ static void __blkdev_put(struct block_device *bdev, fmode_t mode, int for_part);
 static void bdev_disk_changed(struct block_device *bdev, bool invalidate)
 {
 	if (disk_part_scan_enabled(bdev->bd_disk)) {
-		if (invalidate)
-			invalidate_partitions(bdev->bd_disk, bdev);
-		else
-			rescan_partitions(bdev->bd_disk, bdev);
+		rescan_partitions(bdev->bd_disk, bdev, invalidate);
 	} else {
 		check_disk_size_change(bdev->bd_disk, bdev, !invalidate);
 		bdev->bd_invalidated = 0;
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 8b5330dd5ac0..fd7774e64f0b 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -622,8 +622,8 @@ extern dev_t blk_lookup_devt(const char *name, int partno);
 extern char *disk_name (struct gendisk *hd, int partno, char *buf);
 
 extern int disk_expand_part_tbl(struct gendisk *disk, int target);
-extern int rescan_partitions(struct gendisk *disk, struct block_device *bdev);
-extern int invalidate_partitions(struct gendisk *disk, struct block_device *bdev);
+int rescan_partitions(struct gendisk *disk, struct block_device *bdev,
+		bool invalidate);
 extern struct hd_struct * __must_check add_partition(struct gendisk *disk,
 						     int partno, sector_t start,
 						     sector_t len, int flags,
-- 
2.20.1

