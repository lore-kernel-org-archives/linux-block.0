Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E81F8837
	for <linux-block@vger.kernel.org>; Mon, 27 Jan 2025 15:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737991363; cv=none; b=CFtNork13Al/KE1uG8Id6yWlw89YET4RFnqN/RHK+lOgYKONkB1MZNe4+0rTRr/lYU4FcN8JbvOpNnlPZNtBWo2Ct0yLec2KoG1NxFX8HVeVoGhKzB29SYoaBa44WRkg2bPF3/oURktxp2FLhQsKVc3n+co3qpuNOanHVC+hBIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737991363; c=relaxed/simple;
	bh=0ynk7ndU1jivvo/ZEQnYjK+cLrSa+xxA9CcO9a+/M7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q941+0a02EzzJkQntiO0NGjQaWHjtr5viZOwWHluxNf2LjY0K0adMJ3kTksHuvES01igHExUjK33+b373Wcm+XdUuDwLRgwxNY79bJKwh++z2JHN1vHJthRpafs2dtSKvTUcroKxeunpjj/SawZN8frc1a0mRcWHTT+dner5pd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qQjoobz+; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qQjoobz+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=nQIYlth5/SosC9aSvpoeuOTf59ddrduNWisWejmm280=; b=qQjoobz+eE09aCDt1SaKqbZjop
	6wolUuuTHAg451PbV5BzzttnsXPgoKr2N0AFvaHgR7/YL+7Vm92dQo5wheZkFIRgx0RXdI4p3G/nm
	aVHeWarEZ4Czn8M++3W+wdJlUVdRhoVCnguWtw44f8qwD4/erm9Uwrw0uWbB8OPEKJBxZ1D9OS1/L
	RcxOCIrrql52i5v9+SFbKnYqZDDv1EMnKByKjY+zsZZdOcWWrjP4Z7sSbBvjLsV/C14amE3ghWHKv
	mvm2yx7dJAgsEanFfK1xquOaDIz0iIutIP6klOo8fl3d/eTIlKCe1ynMvS0hdL5hMThOTwbYQ3N1C
	+ER3MAUw==;
Received: from 2a02-8389-2341-5b80-b8ca-be22-b5e2-4029.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:b8ca:be22:b5e2:4029] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tcQwg-00000002aLl-1yvb;
	Mon, 27 Jan 2025 15:22:39 +0000
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org
Subject: [PATCH] loop: take the file system minimum dio alignment into account
Date: Mon, 27 Jan 2025 16:22:36 +0100
Message-ID: <20250127152236.612108-1-hch@lst.de>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

The loop driver currently uses the logical block size of the underlying
bdev as the lower bound of the loop device block size.  While this works
for many cases, it fails for file systems made up of multiple devices
with different logic block size (e.g. XFS with a RT device that has a
larger logical block size), or when the file systems doesn't support
direct I/O writes at the sector size granularity (e.g. because it does
out of place writes with a file system block size larger than the sector
size).

Fix this by querying the minimum direct I/O alignment from statx when
available.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/loop.c | 58 ++++++++++++++++++++++++--------------------
 1 file changed, 32 insertions(+), 26 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index d1f1d6bef2e6..84b810b0f278 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -54,7 +54,8 @@ struct loop_device {
 	int		lo_flags;
 	char		lo_file_name[LO_NAME_SIZE];
 
-	struct file *	lo_backing_file;
+	struct file	*lo_backing_file;
+	unsigned int	lo_min_dio_size;
 	struct block_device *lo_device;
 
 	gfp_t		old_gfp_mask;
@@ -169,29 +170,14 @@ static loff_t get_loop_size(struct loop_device *lo, struct file *file)
  * of backing device, and the logical block size of loop is bigger than that of
  * the backing device.
  */
-static bool lo_bdev_can_use_dio(struct loop_device *lo,
-		struct block_device *backing_bdev)
-{
-	unsigned int sb_bsize = bdev_logical_block_size(backing_bdev);
-
-	if (queue_logical_block_size(lo->lo_queue) < sb_bsize)
-		return false;
-	if (lo->lo_offset & (sb_bsize - 1))
-		return false;
-	return true;
-}
-
 static bool lo_can_use_dio(struct loop_device *lo)
 {
-	struct inode *inode = lo->lo_backing_file->f_mapping->host;
-
 	if (!(lo->lo_backing_file->f_mode & FMODE_CAN_ODIRECT))
 		return false;
-
-	if (S_ISBLK(inode->i_mode))
-		return lo_bdev_can_use_dio(lo, I_BDEV(inode));
-	if (inode->i_sb->s_bdev)
-		return lo_bdev_can_use_dio(lo, inode->i_sb->s_bdev);
+	if (queue_logical_block_size(lo->lo_queue) < lo->lo_min_dio_size)
+		return false;
+	if (lo->lo_offset & (lo->lo_min_dio_size - 1))
+		return false;
 	return true;
 }
 
@@ -541,6 +527,25 @@ static void loop_reread_partitions(struct loop_device *lo)
 			__func__, lo->lo_number, lo->lo_file_name, rc);
 }
 
+static void loop_query_min_dio_size(struct loop_device *lo)
+{
+	struct file *file = lo->lo_backing_file;
+	struct block_device *sb_bdev = file->f_mapping->host->i_sb->s_bdev;
+	struct kstat st;
+
+	if (!vfs_getattr(&file->f_path, &st, STATX_DIOALIGN, 0) &&
+	    (st.result_mask & STATX_DIOALIGN))
+		lo->lo_min_dio_size = st.dio_offset_align;
+	/*
+	 * In a perfect world this wouldn't be needed, but as of Linux 6.13 only
+	 * a handful of file systems support the STATX_DIOALIGN flag.
+	 */
+	else if (sb_bdev)
+		lo->lo_min_dio_size = bdev_logical_block_size(sb_bdev);
+	else
+		lo->lo_min_dio_size = SECTOR_SIZE;
+}
+
 static inline int is_loop_device(struct file *file)
 {
 	struct inode *i = file->f_mapping->host;
@@ -629,6 +634,7 @@ static int loop_change_fd(struct loop_device *lo, struct block_device *bdev,
 	lo->old_gfp_mask = mapping_gfp_mask(file->f_mapping);
 	mapping_set_gfp_mask(file->f_mapping,
 			     lo->old_gfp_mask & ~(__GFP_IO|__GFP_FS));
+	loop_query_min_dio_size(lo);
 	loop_update_dio(lo);
 	blk_mq_unfreeze_queue(lo->lo_queue);
 	partscan = lo->lo_flags & LO_FLAGS_PARTSCAN;
@@ -970,12 +976,11 @@ loop_set_status_from_info(struct loop_device *lo,
 	return 0;
 }
 
-static unsigned int loop_default_blocksize(struct loop_device *lo,
-		struct block_device *backing_bdev)
+static unsigned int loop_default_blocksize(struct loop_device *lo)
 {
-	/* In case of direct I/O, match underlying block size */
-	if ((lo->lo_backing_file->f_flags & O_DIRECT) && backing_bdev)
-		return bdev_logical_block_size(backing_bdev);
+	/* In case of direct I/O, match underlying minimum I/O size */
+	if (lo->lo_backing_file->f_flags & O_DIRECT)
+		return lo->lo_min_dio_size;
 	return SECTOR_SIZE;
 }
 
@@ -993,7 +998,7 @@ static void loop_update_limits(struct loop_device *lo, struct queue_limits *lim,
 		backing_bdev = inode->i_sb->s_bdev;
 
 	if (!bsize)
-		bsize = loop_default_blocksize(lo, backing_bdev);
+		bsize = loop_default_blocksize(lo);
 
 	loop_get_discard_config(lo, &granularity, &max_discard_sectors);
 
@@ -1090,6 +1095,7 @@ static int loop_configure(struct loop_device *lo, blk_mode_t mode,
 	lo->lo_backing_file = file;
 	lo->old_gfp_mask = mapping_gfp_mask(mapping);
 	mapping_set_gfp_mask(mapping, lo->old_gfp_mask & ~(__GFP_IO|__GFP_FS));
+	loop_query_min_dio_size(lo);
 
 	lim = queue_limits_start_update(lo->lo_queue);
 	loop_update_limits(lo, &lim, config->block_size);
-- 
2.45.2

