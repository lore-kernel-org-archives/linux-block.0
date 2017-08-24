Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f43.google.com ([74.125.83.43]:38803 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751183AbdHXHDx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Aug 2017 03:03:53 -0400
Received: by mail-pg0-f43.google.com with SMTP id m133so12451466pga.5
        for <linux-block@vger.kernel.org>; Thu, 24 Aug 2017 00:03:53 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: linux-block@vger.kernel.org
Cc: kernel-team@fb.com, Hannes Reinecke <hare@suse.de>,
        Ming Lei <ming.lei@redhat.com>, Karel Zak <kzak@redhat.com>,
        Milan Broz <gmazyland@gmail.com>
Subject: [PATCH 1/4] loop: get rid of lo_blocksize
Date: Thu, 24 Aug 2017 00:03:41 -0700
Message-Id: <ef0f206cb2c75da3b850c59ea7b7efc0b94f4b32.1503558155.git.osandov@fb.com>
In-Reply-To: <cover.1503558155.git.osandov@fb.com>
References: <cover.1503558155.git.osandov@fb.com>
In-Reply-To: <cover.1503558155.git.osandov@fb.com>
References: <cover.1503558155.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

This is only used for setting the soft block size on the struct
block_device once and then never used again.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 drivers/block/loop.c | 10 ++--------
 drivers/block/loop.h |  1 -
 2 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index f321b96405f5..54e091887199 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -573,8 +573,6 @@ static void do_loop_switch(struct loop_device *lo, struct switch_request *p)
 	mapping = file->f_mapping;
 	mapping_set_gfp_mask(old_file->f_mapping, lo->old_gfp_mask);
 	lo->lo_backing_file = file;
-	lo->lo_blocksize = S_ISBLK(mapping->host->i_mode) ?
-		mapping->host->i_bdev->bd_block_size : PAGE_SIZE;
 	lo->old_gfp_mask = mapping_gfp_mask(mapping);
 	mapping_set_gfp_mask(mapping, lo->old_gfp_mask & ~(__GFP_IO|__GFP_FS));
 	loop_update_dio(lo);
@@ -867,7 +865,6 @@ static int loop_set_fd(struct loop_device *lo, fmode_t mode,
 	struct file	*file, *f;
 	struct inode	*inode;
 	struct address_space *mapping;
-	unsigned lo_blocksize;
 	int		lo_flags = 0;
 	int		error;
 	loff_t		size;
@@ -911,9 +908,6 @@ static int loop_set_fd(struct loop_device *lo, fmode_t mode,
 	    !file->f_op->write_iter)
 		lo_flags |= LO_FLAGS_READ_ONLY;
 
-	lo_blocksize = S_ISBLK(inode->i_mode) ?
-		inode->i_bdev->bd_block_size : PAGE_SIZE;
-
 	error = -EFBIG;
 	size = get_loop_size(lo, file);
 	if ((loff_t)(sector_t)size != size)
@@ -927,7 +921,6 @@ static int loop_set_fd(struct loop_device *lo, fmode_t mode,
 	set_device_ro(bdev, (lo_flags & LO_FLAGS_READ_ONLY) != 0);
 
 	lo->use_dio = false;
-	lo->lo_blocksize = lo_blocksize;
 	lo->lo_device = bdev;
 	lo->lo_flags = lo_flags;
 	lo->lo_backing_file = file;
@@ -947,7 +940,8 @@ static int loop_set_fd(struct loop_device *lo, fmode_t mode,
 	/* let user-space know about the new size */
 	kobject_uevent(&disk_to_dev(bdev->bd_disk)->kobj, KOBJ_CHANGE);
 
-	set_blocksize(bdev, lo_blocksize);
+	set_blocksize(bdev, S_ISBLK(inode->i_mode) ?
+		      block_size(inode->i_bdev) : PAGE_SIZE);
 
 	lo->lo_state = Lo_bound;
 	if (part_shift)
diff --git a/drivers/block/loop.h b/drivers/block/loop.h
index fecd3f97ef8c..efe57189d01e 100644
--- a/drivers/block/loop.h
+++ b/drivers/block/loop.h
@@ -48,7 +48,6 @@ struct loop_device {
 
 	struct file *	lo_backing_file;
 	struct block_device *lo_device;
-	unsigned	lo_blocksize;
 	void		*key_data; 
 
 	gfp_t		old_gfp_mask;
-- 
2.14.1
