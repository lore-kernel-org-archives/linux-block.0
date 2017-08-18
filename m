Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f53.google.com ([74.125.83.53]:36689 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750993AbdHRT1r (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Aug 2017 15:27:47 -0400
Received: by mail-pg0-f53.google.com with SMTP id i12so70097018pgr.3
        for <linux-block@vger.kernel.org>; Fri, 18 Aug 2017 12:27:47 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: linux-block@vger.kernel.org
Cc: kernel-team@fb.com, Hannes Reinecke <hare@suse.de>,
        Ming Lei <ming.lei@redhat.com>, Karel Zak <kzak@redhat.com>
Subject: [PATCH v2 2/3] loop: use queue limit instead of private lo_logical_blocksize
Date: Fri, 18 Aug 2017 12:27:36 -0700
Message-Id: <561f8505816afb6d0dacd4697087141c95566225.1503084216.git.osandov@fb.com>
In-Reply-To: <cover.1503084216.git.osandov@fb.com>
References: <cover.1503084216.git.osandov@fb.com>
In-Reply-To: <cover.1503084216.git.osandov@fb.com>
References: <cover.1503084216.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

There's no reason to track this separately; just use the
logical_block_size queue limit.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 drivers/block/loop.c | 44 ++++++++++++++++++--------------------------
 drivers/block/loop.h |  1 -
 2 files changed, 18 insertions(+), 27 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 26548e07bc31..94227a327ce2 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -221,8 +221,7 @@ static void __loop_update_dio(struct loop_device *lo, bool dio)
 }
 
 static int
-figure_loop_size(struct loop_device *lo, loff_t offset, loff_t sizelimit,
-		 loff_t logical_blocksize)
+figure_loop_size(struct loop_device *lo, loff_t offset, loff_t sizelimit)
 {
 	loff_t size = get_size(offset, sizelimit, lo->lo_backing_file);
 	sector_t x = (sector_t)size;
@@ -234,12 +233,6 @@ figure_loop_size(struct loop_device *lo, loff_t offset, loff_t sizelimit,
 		lo->lo_offset = offset;
 	if (lo->lo_sizelimit != sizelimit)
 		lo->lo_sizelimit = sizelimit;
-	if (lo->lo_flags & LO_FLAGS_BLOCKSIZE) {
-		lo->lo_logical_blocksize = logical_blocksize;
-		blk_queue_physical_block_size(lo->lo_queue, lo->lo_blocksize);
-		blk_queue_logical_block_size(lo->lo_queue,
-					     lo->lo_logical_blocksize);
-	}
 	set_capacity(lo->lo_disk, x);
 	bd_set_size(bdev, (loff_t)get_capacity(bdev->bd_disk) << 9);
 	/* let user-space know about the new size */
@@ -820,7 +813,7 @@ static void loop_config_discard(struct loop_device *lo)
 	struct file *file = lo->lo_backing_file;
 	struct inode *inode = file->f_mapping->host;
 	struct request_queue *q = lo->lo_queue;
-	int lo_bits = 9;
+	int lo_bits = blksize_bits(queue_logical_block_size(q));
 
 	/*
 	 * We use punch hole to reclaim the free space used by the
@@ -840,8 +833,6 @@ static void loop_config_discard(struct loop_device *lo)
 
 	q->limits.discard_granularity = inode->i_sb->s_blocksize;
 	q->limits.discard_alignment = 0;
-	if (lo->lo_flags & LO_FLAGS_BLOCKSIZE)
-		lo_bits = blksize_bits(lo->lo_logical_blocksize);
 
 	blk_queue_max_discard_sectors(q, UINT_MAX >> lo_bits);
 	blk_queue_max_write_zeroes_sectors(q, UINT_MAX >> lo_bits);
@@ -938,7 +929,6 @@ static int loop_set_fd(struct loop_device *lo, fmode_t mode,
 
 	lo->use_dio = false;
 	lo->lo_blocksize = lo_blocksize;
-	lo->lo_logical_blocksize = 512;
 	lo->lo_device = bdev;
 	lo->lo_flags = lo_flags;
 	lo->lo_backing_file = file;
@@ -950,6 +940,9 @@ static int loop_set_fd(struct loop_device *lo, fmode_t mode,
 
 	if (!(lo_flags & LO_FLAGS_READ_ONLY) && file->f_op->fsync)
 		blk_queue_write_cache(lo->lo_queue, true, false);
+	blk_queue_logical_block_size(lo->lo_queue, 512);
+	blk_queue_physical_block_size(lo->lo_queue, 512);
+	blk_queue_io_min(lo->lo_queue, 512);
 
 	loop_update_dio(lo);
 	set_capacity(lo->lo_disk, size);
@@ -1137,14 +1130,7 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 	} else
 		xfer = NULL;
 
-	err = loop_init_xfer(lo, xfer, info);
-	if (err)
-		goto exit;
-
 	if (info->lo_flags & LO_FLAGS_BLOCKSIZE) {
-		if (!(lo->lo_flags & LO_FLAGS_BLOCKSIZE))
-			lo->lo_logical_blocksize = 512;
-		lo->lo_flags |= LO_FLAGS_BLOCKSIZE;
 		if (LO_INFO_BLOCKSIZE(info) != 512 &&
 		    LO_INFO_BLOCKSIZE(info) != 1024 &&
 		    LO_INFO_BLOCKSIZE(info) != 2048 &&
@@ -1158,18 +1144,25 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 		}
 	}
 
+	err = loop_init_xfer(lo, xfer, info);
+	if (err)
+		goto exit;
+
 	if (lo->lo_offset != info->lo_offset ||
 	    lo->lo_sizelimit != info->lo_sizelimit ||
-	    lo->lo_flags != lo_flags ||
-	    ((lo->lo_flags & LO_FLAGS_BLOCKSIZE) &&
-	     lo->lo_logical_blocksize != LO_INFO_BLOCKSIZE(info))) {
-		if (figure_loop_size(lo, info->lo_offset, info->lo_sizelimit,
-				     LO_INFO_BLOCKSIZE(info))) {
+	    lo->lo_flags != lo_flags) {
+		if (figure_loop_size(lo, info->lo_offset, info->lo_sizelimit)) {
 			err = -EFBIG;
 			goto exit;
 		}
 	}
 
+	if (info->lo_flags & LO_FLAGS_BLOCKSIZE) {
+		blk_queue_logical_block_size(lo->lo_queue, LO_INFO_BLOCKSIZE(info));
+		blk_queue_physical_block_size(lo->lo_queue, LO_INFO_BLOCKSIZE(info));
+		blk_queue_io_min(lo->lo_queue, LO_INFO_BLOCKSIZE(info));
+	}
+
 	loop_config_discard(lo);
 
 	memcpy(lo->lo_file_name, info->lo_file_name, LO_NAME_SIZE);
@@ -1356,8 +1349,7 @@ static int loop_set_capacity(struct loop_device *lo)
 	if (unlikely(lo->lo_state != Lo_bound))
 		return -ENXIO;
 
-	return figure_loop_size(lo, lo->lo_offset, lo->lo_sizelimit,
-				lo->lo_logical_blocksize);
+	return figure_loop_size(lo, lo->lo_offset, lo->lo_sizelimit);
 }
 
 static int loop_set_dio(struct loop_device *lo, unsigned long arg)
diff --git a/drivers/block/loop.h b/drivers/block/loop.h
index 2c096b9a17b8..fecd3f97ef8c 100644
--- a/drivers/block/loop.h
+++ b/drivers/block/loop.h
@@ -49,7 +49,6 @@ struct loop_device {
 	struct file *	lo_backing_file;
 	struct block_device *lo_device;
 	unsigned	lo_blocksize;
-	unsigned	lo_logical_blocksize;
 	void		*key_data; 
 
 	gfp_t		old_gfp_mask;
-- 
2.14.1
