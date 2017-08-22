Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f52.google.com ([74.125.83.52]:35731 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752381AbdHVRdR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Aug 2017 13:33:17 -0400
Received: by mail-pg0-f52.google.com with SMTP id u191so43290229pgc.2
        for <linux-block@vger.kernel.org>; Tue, 22 Aug 2017 10:33:17 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: linux-block@vger.kernel.org
Cc: kernel-team@fb.com, Hannes Reinecke <hare@suse.de>,
        Ming Lei <ming.lei@redhat.com>, Karel Zak <kzak@redhat.com>,
        Milan Broz <gmazyland@gmail.com>
Subject: [PATCH v3 3/4] loop: use queue limit instead of private lo_logical_blocksize
Date: Tue, 22 Aug 2017 10:33:00 -0700
Message-Id: <cda9076854b30eb4c05092b90fae747e7f1f6542.1503422996.git.osandov@fb.com>
In-Reply-To: <cover.1503422996.git.osandov@fb.com>
References: <cover.1503422996.git.osandov@fb.com>
In-Reply-To: <cover.1503422996.git.osandov@fb.com>
References: <cover.1503422996.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

There's no reason to track this separately; just use the
logical_block_size queue limit. This also fixes an issue where the
physical block size would get changed unnecessarily.

Tested-by: Milan Broz <gmazyland@gmail.com>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 drivers/block/loop.c | 40 +++++++++++++++++-----------------------
 drivers/block/loop.h |  1 -
 2 files changed, 17 insertions(+), 24 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index a444dc2d5977..28026f0abaa9 100644
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
@@ -934,7 +927,6 @@ static int loop_set_fd(struct loop_device *lo, fmode_t mode,
 
 	lo->use_dio = false;
 	lo->lo_blocksize = lo_blocksize;
-	lo->lo_logical_blocksize = 512;
 	lo->lo_device = bdev;
 	lo->lo_flags = lo_flags;
 	lo->lo_backing_file = file;
@@ -946,6 +938,9 @@ static int loop_set_fd(struct loop_device *lo, fmode_t mode,
 
 	if (!(lo_flags & LO_FLAGS_READ_ONLY) && file->f_op->fsync)
 		blk_queue_write_cache(lo->lo_queue, true, false);
+	blk_queue_logical_block_size(lo->lo_queue, 512);
+	blk_queue_physical_block_size(lo->lo_queue, 512);
+	blk_queue_io_min(lo->lo_queue, 512);
 
 	loop_update_dio(lo);
 	set_capacity(lo->lo_disk, size);
@@ -1133,14 +1128,7 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
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
@@ -1154,18 +1142,25 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
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
@@ -1352,8 +1347,7 @@ static int loop_set_capacity(struct loop_device *lo)
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
