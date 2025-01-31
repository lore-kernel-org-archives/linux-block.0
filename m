Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942361ACEAC
	for <linux-block@vger.kernel.org>; Fri, 31 Jan 2025 12:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738324899; cv=none; b=OpoEUtm/58hXCOqh4GrmSTcCyhEQtUbTawRAIKN22e8C40Q8z0FDvpw4t+MaKjlB0D9GqCiw8LUtj8A/uh8OLGVmhP4sruKaSZAxJNgLJOevvo/L1kSAg4XoZGVKsocKdx0UYmbXMxLyc1H064/IE/g4u1z9epAG9QDpZY/VaM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738324899; c=relaxed/simple;
	bh=2lgQxDw3uqZE2K7qSOjpxP3MmP+4avbA7ag/P/lZPEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=khaoqb7/XGlYOwcpucA8khkRgWiOMFBxLlg1rvVmKpJiGOO5FwlehR5qTZ/he07okcswRmnNGOIT4U3XtCaJKhytsEfVE3xF6Yy4WjepwKSCeVMdreGQc4Augw/PLNgWdl+oLTwHmA8D3Q9V6CPrgu/jj0XnrxJibzUPmWmdrWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=0Fuolnep; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0Fuolnep"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=TOxmbHnPV1NuDJsjbezoPZXmY5xU80JxoXt5teTXuWI=; b=0Fuolnepn0IwlFe1sEc5aMMIJN
	7HJpSRI71rntmOOoulLitZtUItSYo9KqddioT/rWxYXwJU0GJoLxcm/2HuP2TV5tzccuC+D/LWEPT
	zmHyUr0cUeAAaAWMHXgJC5z0sHYybLxWU08rDOh1auJo9aW+eSuGTvB2Ak0MuNK6Ed+thhFVcKedQ
	kfaVkDv5OyumbALEq+chJhcmS0GQcaqNbeISQt+EjxZEIeU6WI/I9HXWNMZFNfKW4XD5rFinwPr2S
	OFPhF4xZo7/2tUj1EVH5khLgNP99wFGioOQYIDmfq1LIJGF/Zg6Qzza5au336qsbWdXaMMKLNQFeI
	hherXJCw==;
Received: from 2a02-8389-2341-5b80-85a0-dd45-e939-a129.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:85a0:dd45:e939:a129] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tdpiK-0000000AZDA-1ZBr;
	Fri, 31 Jan 2025 12:01:37 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	linux-block@vger.kernel.org
Subject: [PATCH 4/4] loop: take the file system minimum dio alignment into account
Date: Fri, 31 Jan 2025 13:00:41 +0100
Message-ID: <20250131120120.1315125-5-hch@lst.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250131120120.1315125-1-hch@lst.de>
References: <20250131120120.1315125-1-hch@lst.de>
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
 drivers/block/loop.c | 60 +++++++++++++++++++++++++-------------------
 1 file changed, 34 insertions(+), 26 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 36b01c36e06b..89352a85b704 100644
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
 
@@ -539,6 +525,28 @@ static void loop_reread_partitions(struct loop_device *lo)
 			__func__, lo->lo_number, lo->lo_file_name, rc);
 }
 
+static unsigned int loop_query_min_dio_size(struct loop_device *lo)
+{
+	struct file *file = lo->lo_backing_file;
+	struct block_device *sb_bdev = file->f_mapping->host->i_sb->s_bdev;
+	struct kstat st;
+
+	/*
+	 * Use the minimal dio alignment of the file system if provided.
+	 */
+	if (!vfs_getattr(&file->f_path, &st, STATX_DIOALIGN, 0) &&
+	    (st.result_mask & STATX_DIOALIGN))
+		return st.dio_offset_align;
+
+	/*
+	 * In a perfect world this wouldn't be needed, but as of Linux 6.13 only
+	 * a handful of file systems support the STATX_DIOALIGN flag.
+	 */
+	if (sb_bdev)
+		return bdev_logical_block_size(sb_bdev);
+	return SECTOR_SIZE;
+}
+
 static inline int is_loop_device(struct file *file)
 {
 	struct inode *i = file->f_mapping->host;
@@ -579,6 +587,7 @@ static void loop_assign_backing_file(struct loop_device *lo, struct file *file)
 			lo->old_gfp_mask & ~(__GFP_IO | __GFP_FS));
 	if (lo->lo_backing_file->f_flags & O_DIRECT)
 		lo->lo_flags |= LO_FLAGS_DIRECT_IO;
+	lo->lo_min_dio_size = loop_query_min_dio_size(lo);
 }
 
 /*
@@ -975,12 +984,11 @@ loop_set_status_from_info(struct loop_device *lo,
 	return 0;
 }
 
-static unsigned int loop_default_blocksize(struct loop_device *lo,
-		struct block_device *backing_bdev)
+static unsigned int loop_default_blocksize(struct loop_device *lo)
 {
-	/* In case of direct I/O, match underlying block size */
-	if ((lo->lo_flags & LO_FLAGS_DIRECT_IO) && backing_bdev)
-		return bdev_logical_block_size(backing_bdev);
+	/* In case of direct I/O, match underlying minimum I/O size */
+	if (lo->lo_flags & LO_FLAGS_DIRECT_IO)
+		return lo->lo_min_dio_size;
 	return SECTOR_SIZE;
 }
 
@@ -998,7 +1006,7 @@ static void loop_update_limits(struct loop_device *lo, struct queue_limits *lim,
 		backing_bdev = inode->i_sb->s_bdev;
 
 	if (!bsize)
-		bsize = loop_default_blocksize(lo, backing_bdev);
+		bsize = loop_default_blocksize(lo);
 
 	loop_get_discard_config(lo, &granularity, &max_discard_sectors);
 
-- 
2.45.2

