Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B121C7618E
	for <linux-block@archiver.kernel.org>; Fri, 21 Apr 2023 04:31:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbjDUEbJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 Apr 2023 00:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbjDUEbI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Apr 2023 00:31:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92D27525C
        for <linux-block@vger.kernel.org>; Thu, 20 Apr 2023 21:31:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2BAC764958
        for <linux-block@vger.kernel.org>; Fri, 21 Apr 2023 04:31:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 085B4C433EF;
        Fri, 21 Apr 2023 04:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682051463;
        bh=osLGsYQS/2pnvOhDCr7oFyjZa9QKpJU1+eguW3l9g44=;
        h=From:To:Subject:Date:From;
        b=PwKAbRWugwXdip/7fFDFtNeumUkkB7cEkxnXI8cAUeREVi/vO3ePHM3vEinbU8Bcl
         WGezkSx+GlOs7tqPPn3mrlNa1UJE1NAsM6sT1Qo4z0NBXl3zafimaqOXgEqyLbPwv2
         DOTRcLn0dbJLn3cyd+jyTDbx4Bz/Je9ESIUrxfZ8pSsXE29O46E2WQe/P7QqGDli/H
         4Al9HrcFpqeahaWVCFS8mL4+k5PK7lAyRJJU0ZtIK1LkdXTxoy3EXvxLQirnGFXbc3
         nQgqSlWzI33QDoCrR7BSAHb/lypRCeXfK5VC+epf4JJR5ga2qvoTAP/0bjbSLndSEk
         gYMipbtwPxRYA==
From:   Damien Le Moal <dlemoal@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: [PATCH] block: Cleanup set_capacity()/bdev_set_nr_sectors()
Date:   Fri, 21 Apr 2023 13:31:01 +0900
Message-Id: <20230421043101.3079-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The code for setting a block device capacity (bd_nr_sectors field of
struct block_device) is duplicated in set_capacity() and
bdev_set_nr_sectors(). Clean this up by turning set_capacity() into an
inline function calling bdev_set_nr_sectors() and move
bdev_set_nr_sectors() code to block/bdev.c instead of having this
function in block/partitions/core.c.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 block/bdev.c            |  9 +++++++++
 block/genhd.c           | 11 -----------
 block/partitions/core.c |  8 --------
 include/linux/blkdev.h  |  8 +++++++-
 4 files changed, 16 insertions(+), 20 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index 850852fe4b78..6fc21f30b870 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -428,6 +428,15 @@ struct block_device *bdev_alloc(struct gendisk *disk, u8 partno)
 	return bdev;
 }
 
+void bdev_set_nr_sectors(struct block_device *bdev, sector_t sectors)
+{
+	spin_lock(&bdev->bd_size_lock);
+	i_size_write(bdev->bd_inode, (loff_t)sectors << SECTOR_SHIFT);
+	bdev->bd_nr_sectors = sectors;
+	spin_unlock(&bdev->bd_size_lock);
+}
+EXPORT_SYMBOL_GPL(bdev_set_nr_sectors);
+
 void bdev_add(struct block_device *bdev, dev_t dev)
 {
 	bdev->bd_dev = dev;
diff --git a/block/genhd.c b/block/genhd.c
index cadcb472dfc3..7d44d25f2a54 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -55,17 +55,6 @@ static atomic64_t diskseq;
 #define NR_EXT_DEVT		(1 << MINORBITS)
 static DEFINE_IDA(ext_devt_ida);
 
-void set_capacity(struct gendisk *disk, sector_t sectors)
-{
-	struct block_device *bdev = disk->part0;
-
-	spin_lock(&bdev->bd_size_lock);
-	i_size_write(bdev->bd_inode, (loff_t)sectors << SECTOR_SHIFT);
-	bdev->bd_nr_sectors = sectors;
-	spin_unlock(&bdev->bd_size_lock);
-}
-EXPORT_SYMBOL(set_capacity);
-
 /*
  * Set disk capacity and notify if the size is not currently zero and will not
  * be set to zero.  Returns true if a uevent was sent, otherwise false.
diff --git a/block/partitions/core.c b/block/partitions/core.c
index 7b8ef6296abd..49e0496ff23c 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -85,14 +85,6 @@ static int (*check_part[])(struct parsed_partitions *) = {
 	NULL
 };
 
-static void bdev_set_nr_sectors(struct block_device *bdev, sector_t sectors)
-{
-	spin_lock(&bdev->bd_size_lock);
-	i_size_write(bdev->bd_inode, (loff_t)sectors << SECTOR_SHIFT);
-	bdev->bd_nr_sectors = sectors;
-	spin_unlock(&bdev->bd_size_lock);
-}
-
 static struct parsed_partitions *allocate_partitions(struct gendisk *hd)
 {
 	struct parsed_partitions *state;
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 6ede578dfbc6..ea8f95e0754c 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -770,6 +770,8 @@ static inline sector_t get_start_sect(struct block_device *bdev)
 	return bdev->bd_start_sect;
 }
 
+void bdev_set_nr_sectors(struct block_device *bdev, sector_t sectors);
+
 static inline sector_t bdev_nr_sectors(struct block_device *bdev)
 {
 	return bdev->bd_nr_sectors;
@@ -780,6 +782,11 @@ static inline loff_t bdev_nr_bytes(struct block_device *bdev)
 	return (loff_t)bdev_nr_sectors(bdev) << SECTOR_SHIFT;
 }
 
+static inline void set_capacity(struct gendisk *disk, sector_t sectors)
+{
+	bdev_set_nr_sectors(disk->part0, sectors);
+}
+
 static inline sector_t get_capacity(struct gendisk *disk)
 {
 	return bdev_nr_sectors(disk->part0);
@@ -820,7 +827,6 @@ void unregister_blkdev(unsigned int major, const char *name);
 
 bool bdev_check_media_change(struct block_device *bdev);
 int __invalidate_device(struct block_device *bdev, bool kill_dirty);
-void set_capacity(struct gendisk *disk, sector_t size);
 
 #ifdef CONFIG_BLOCK_HOLDER_DEPRECATED
 int bd_link_disk_holder(struct block_device *bdev, struct gendisk *disk);
-- 
2.40.0

