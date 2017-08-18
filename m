Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-yw0-f174.google.com ([209.85.161.174]:34757 "EHLO
        mail-yw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750748AbdHRGPg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Aug 2017 02:15:36 -0400
Received: by mail-yw0-f174.google.com with SMTP id s143so53530295ywg.1
        for <linux-block@vger.kernel.org>; Thu, 17 Aug 2017 23:15:36 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: linux-block@vger.kernel.org
Cc: kernel-team@fb.com, Hannes Reinecke <hare@suse.de>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 1/2] loop: always return block size in LOOP_GET_STATUS
Date: Thu, 17 Aug 2017 23:15:25 -0700
Message-Id: <9ff9b291e3e872698a040a281549c39c0637565f.1503036471.git.osandov@fb.com>
In-Reply-To: <cover.1503036471.git.osandov@fb.com>
References: <cover.1503036471.git.osandov@fb.com>
In-Reply-To: <cover.1503036471.git.osandov@fb.com>
References: <cover.1503036471.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

When I was writing a test for the new loop device block size
functionality, I realized that the interface is kind of dumb:

- lo_init[0] is never filled in with the logical block size we
  previously set
- lo_flags returned from LOOP_GET_STATUS will have LO_FLAGS_BLOCKSIZE
  set if we previously called LOOP_SET_STATUS with LO_FLAGS_BLOCKSIZE
  set, which doesn't really mean anything

Instead, for LOOP_GET_STATUS, let's always fill in lo_init[0] and set
the LO_FLAGS_BLOCKSIZE flag to indicate we support it.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 drivers/block/loop.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index ef8334949b42..39fa7f48e0c7 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -234,7 +234,7 @@ figure_loop_size(struct loop_device *lo, loff_t offset, loff_t sizelimit,
 		lo->lo_offset = offset;
 	if (lo->lo_sizelimit != sizelimit)
 		lo->lo_sizelimit = sizelimit;
-	if (lo->lo_flags & LO_FLAGS_BLOCKSIZE) {
+	if (lo->lo_logical_blocksize != logical_blocksize) {
 		lo->lo_logical_blocksize = logical_blocksize;
 		blk_queue_physical_block_size(lo->lo_queue, lo->lo_blocksize);
 		blk_queue_logical_block_size(lo->lo_queue,
@@ -820,7 +820,7 @@ static void loop_config_discard(struct loop_device *lo)
 	struct file *file = lo->lo_backing_file;
 	struct inode *inode = file->f_mapping->host;
 	struct request_queue *q = lo->lo_queue;
-	int lo_bits = 9;
+	int lo_bits = blksize_bits(lo->lo_logical_blocksize);
 
 	/*
 	 * We use punch hole to reclaim the free space used by the
@@ -840,8 +840,6 @@ static void loop_config_discard(struct loop_device *lo)
 
 	q->limits.discard_granularity = inode->i_sb->s_blocksize;
 	q->limits.discard_alignment = 0;
-	if (lo->lo_flags & LO_FLAGS_BLOCKSIZE)
-		lo_bits = blksize_bits(lo->lo_logical_blocksize);
 
 	blk_queue_max_discard_sectors(q, UINT_MAX >> lo_bits);
 	blk_queue_max_write_zeroes_sectors(q, UINT_MAX >> lo_bits);
@@ -1061,6 +1059,7 @@ static int loop_clr_fd(struct loop_device *lo)
 	lo->lo_offset = 0;
 	lo->lo_sizelimit = 0;
 	lo->lo_encrypt_key_size = 0;
+	lo->lo_logical_blocksize = 512;
 	memset(lo->lo_encrypt_key, 0, LO_KEY_SIZE);
 	memset(lo->lo_crypt_name, 0, LO_NAME_SIZE);
 	memset(lo->lo_file_name, 0, LO_NAME_SIZE);
@@ -1105,6 +1104,7 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 	struct loop_func_table *xfer;
 	kuid_t uid = current_uid();
 	int lo_flags = lo->lo_flags;
+	unsigned lo_logical_blocksize;
 
 	if (lo->lo_encrypt_key_size &&
 	    !uid_eq(lo->lo_key_owner, uid) &&
@@ -1138,25 +1138,24 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 		goto exit;
 
 	if (info->lo_flags & LO_FLAGS_BLOCKSIZE) {
-		if (!(lo->lo_flags & LO_FLAGS_BLOCKSIZE))
-			lo->lo_logical_blocksize = 512;
-		lo->lo_flags |= LO_FLAGS_BLOCKSIZE;
-		if (LO_INFO_BLOCKSIZE(info) != 512 &&
-		    LO_INFO_BLOCKSIZE(info) != 1024 &&
-		    LO_INFO_BLOCKSIZE(info) != 2048 &&
-		    LO_INFO_BLOCKSIZE(info) != 4096)
+		lo_logical_blocksize = LO_INFO_BLOCKSIZE(info);
+		if (lo_logical_blocksize != 512 &&
+		    lo_logical_blocksize != 1024 &&
+		    lo_logical_blocksize != 2048 &&
+		    lo_logical_blocksize != 4096)
 			return -EINVAL;
-		if (LO_INFO_BLOCKSIZE(info) > lo->lo_blocksize)
+		if (lo_logical_blocksize > lo->lo_blocksize)
 			return -EINVAL;
+	} else {
+		lo_logical_blocksize = lo->lo_logical_blocksize;
 	}
 
 	if (lo->lo_offset != info->lo_offset ||
 	    lo->lo_sizelimit != info->lo_sizelimit ||
 	    lo->lo_flags != lo_flags ||
-	    ((lo->lo_flags & LO_FLAGS_BLOCKSIZE) &&
-	     lo->lo_logical_blocksize != LO_INFO_BLOCKSIZE(info))) {
+	    lo->lo_logical_blocksize != lo_logical_blocksize) {
 		if (figure_loop_size(lo, info->lo_offset, info->lo_sizelimit,
-				     LO_INFO_BLOCKSIZE(info))) {
+				     lo_logical_blocksize)) {
 			err = -EFBIG;
 			goto exit;
 		}
@@ -1223,7 +1222,7 @@ loop_get_status(struct loop_device *lo, struct loop_info64 *info)
 	info->lo_rdevice = huge_encode_dev(lo->lo_device ? stat.rdev : stat.dev);
 	info->lo_offset = lo->lo_offset;
 	info->lo_sizelimit = lo->lo_sizelimit;
-	info->lo_flags = lo->lo_flags;
+	info->lo_flags = lo->lo_flags | LO_FLAGS_BLOCKSIZE;
 	memcpy(info->lo_file_name, lo->lo_file_name, LO_NAME_SIZE);
 	memcpy(info->lo_crypt_name, lo->lo_crypt_name, LO_NAME_SIZE);
 	info->lo_encrypt_type =
@@ -1233,6 +1232,7 @@ loop_get_status(struct loop_device *lo, struct loop_info64 *info)
 		memcpy(info->lo_encrypt_key, lo->lo_encrypt_key,
 		       lo->lo_encrypt_key_size);
 	}
+	LO_INFO_BLOCKSIZE(info) = lo->lo_logical_blocksize;
 	return 0;
 }
 
@@ -1835,6 +1835,7 @@ static int loop_add(struct loop_device **l, int i)
 	mutex_init(&lo->lo_ctl_mutex);
 	atomic_set(&lo->lo_refcnt, 0);
 	lo->lo_number		= i;
+	lo->lo_logical_blocksize = 512;
 	spin_lock_init(&lo->lo_lock);
 	disk->major		= LOOP_MAJOR;
 	disk->first_minor	= i << part_shift;
-- 
2.14.1
