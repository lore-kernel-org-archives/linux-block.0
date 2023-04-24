Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5278C77B61
	for <linux-block@archiver.kernel.org>; Mon, 24 Apr 2023 13:13:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231756AbjDXNNX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 Apr 2023 09:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231878AbjDXNNW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Apr 2023 09:13:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B501710DF
        for <linux-block@vger.kernel.org>; Mon, 24 Apr 2023 06:13:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4FCB860BCB
        for <linux-block@vger.kernel.org>; Mon, 24 Apr 2023 13:13:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1380CC433EF;
        Mon, 24 Apr 2023 13:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682342000;
        bh=XhFPn3j7BZsf+QwlgloRh9b5cSsv9DYburzUrTy/Fpw=;
        h=From:To:Cc:Subject:Date:From;
        b=qhpxuA5466BG7UDmdU/o8HIoG5cSHZHbJtAjbtm0Ez6HCYvsw+s0Ry3zz8CK7ogd+
         YgqPe+ZhpHTEnc/kxXe6n9C/XhP0QqlaG+8sP8E9lqDoS9ZNocWUYKaubPvcUnUZLl
         UvLtDd14ibe1ipSwlGIpWWvrBA/XuGd/hOGJ2gbbGQTmQDpOdv0Tqxyyen8KWguuL6
         ewopOaARNlCIHfhUyNSnIzfVQkidDjs2SlwVOn6B9x5lFBgIwFGFBru0XkX8SDtmoc
         h1VRIptkAZX0iw+Vz+M7ArbFhVVysmNB8MXY/biuR/5khc+L/x+b8hMnpbESdTvYqA
         cCrKsK2nPGNPQ==
From:   Damien Le Moal <dlemoal@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2] block: Cleanup set_capacity()/bdev_set_nr_sectors()
Date:   Mon, 24 Apr 2023 22:13:18 +0900
Message-Id: <20230424131318.79935-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The code for setting a block device capacity (bd_nr_sectors field of
struct block_device) is duplicated in set_capacity() and
bdev_set_nr_sectors(). Clean this up by making bdev_set_nr_sectors()
a block layer internal function defined in block/bdev.c instead of
having this function statically defined in block/partitions/core.c.
With this change, set_capacity() implementation can be simplified to
only calling bdev_set_nr_sectors().

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
Changes from v1:
 - Addressed Christoph's comments: keep set_capacity as a regular
   exported function

 block/bdev.c            | 8 ++++++++
 block/blk.h             | 2 ++
 block/genhd.c           | 7 +------
 block/partitions/core.c | 8 --------
 4 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index 850852fe4b78..717089a5726f 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -428,6 +428,14 @@ struct block_device *bdev_alloc(struct gendisk *disk, u8 partno)
 	return bdev;
 }
 
+void bdev_set_nr_sectors(struct block_device *bdev, sector_t sectors)
+{
+	spin_lock(&bdev->bd_size_lock);
+	i_size_write(bdev->bd_inode, (loff_t)sectors << SECTOR_SHIFT);
+	bdev->bd_nr_sectors = sectors;
+	spin_unlock(&bdev->bd_size_lock);
+}
+
 void bdev_add(struct block_device *bdev, dev_t dev)
 {
 	bdev->bd_dev = dev;
diff --git a/block/blk.h b/block/blk.h
index 2da831103471..564119a76bc5 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -419,6 +419,8 @@ int bdev_resize_partition(struct gendisk *disk, int partno, sector_t start,
 		sector_t length);
 void blk_drop_partitions(struct gendisk *disk);
 
+void bdev_set_nr_sectors(struct block_device *bdev, sector_t sectors);
+
 struct gendisk *__alloc_disk_node(struct request_queue *q, int node_id,
 		struct lock_class_key *lkclass);
 
diff --git a/block/genhd.c b/block/genhd.c
index 2d58ac54043a..08f701cb8553 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -57,12 +57,7 @@ static DEFINE_IDA(ext_devt_ida);
 
 void set_capacity(struct gendisk *disk, sector_t sectors)
 {
-	struct block_device *bdev = disk->part0;
-
-	spin_lock(&bdev->bd_size_lock);
-	i_size_write(bdev->bd_inode, (loff_t)sectors << SECTOR_SHIFT);
-	bdev->bd_nr_sectors = sectors;
-	spin_unlock(&bdev->bd_size_lock);
+	bdev_set_nr_sectors(disk->part0, sectors);
 }
 EXPORT_SYMBOL(set_capacity);
 
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
-- 
2.40.0

