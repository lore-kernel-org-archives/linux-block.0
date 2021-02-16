Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FBD6C433E9
	for <linux-block@archiver.kernel.org>; Tue, 16 Feb 2021 13:40:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20F6464DE0
	for <linux-block@archiver.kernel.org>; Tue, 16 Feb 2021 13:40:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbhBPNjv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 Feb 2021 08:39:51 -0500
Received: from mx2.suse.de ([195.135.220.15]:46134 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230162AbhBPNjf (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Feb 2021 08:39:35 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 53B54ACBF;
        Tue, 16 Feb 2021 13:38:52 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 1E7911F2AA7; Tue, 16 Feb 2021 14:38:52 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH] Revert "block: Do not discard buffers under a mounted filesystem"
Date:   Tue, 16 Feb 2021 14:38:49 +0100
Message-Id: <20210216133849.8244-1-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Apparently there are several userspace programs that depend on being
able to call BLKDISCARD ioctl without the ability to grab bdev
exclusively - namely FUSE filesystems have the device open without
O_EXCL (the kernel has the bdev open with O_EXCL) so the commit breaks
fstrim(8) for such filesystems. Also LVM when shrinking LV opens PV and
discards ranges released from LV but that PV may be already open
exclusively by someone else (see bugzilla link below for more details).

This reverts commit 384d87ef2c954fc58e6c5fd8253e4a1984f5fe02.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=211167
Signed-off-by: Jan Kara <jack@suse.cz>
---
 block/ioctl.c          | 16 ++++++----------
 fs/block_dev.c         | 33 ++++-----------------------------
 include/linux/blkdev.h |  7 -------
 3 files changed, 10 insertions(+), 46 deletions(-)

diff --git a/block/ioctl.c b/block/ioctl.c
index d61d652078f4..d523f134f7db 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -103,7 +103,8 @@ static int blk_ioctl_discard(struct block_device *bdev, fmode_t mode,
 	uint64_t range[2];
 	uint64_t start, len;
 	struct request_queue *q = bdev_get_queue(bdev);
-	int err;
+	struct address_space *mapping = bdev->bd_inode->i_mapping;
+
 
 	if (!(mode & FMODE_WRITE))
 		return -EBADF;
@@ -124,11 +125,7 @@ static int blk_ioctl_discard(struct block_device *bdev, fmode_t mode,
 
 	if (start + len > i_size_read(bdev->bd_inode))
 		return -EINVAL;
-
-	err = truncate_bdev_range(bdev, mode, start, start + len - 1);
-	if (err)
-		return err;
-
+	truncate_inode_pages_range(mapping, start, start + len - 1);
 	return blkdev_issue_discard(bdev, start >> 9, len >> 9,
 				    GFP_KERNEL, flags);
 }
@@ -137,8 +134,8 @@ static int blk_ioctl_zeroout(struct block_device *bdev, fmode_t mode,
 		unsigned long arg)
 {
 	uint64_t range[2];
+	struct address_space *mapping;
 	uint64_t start, end, len;
-	int err;
 
 	if (!(mode & FMODE_WRITE))
 		return -EBADF;
@@ -160,9 +157,8 @@ static int blk_ioctl_zeroout(struct block_device *bdev, fmode_t mode,
 		return -EINVAL;
 
 	/* Invalidate the page cache, including dirty pages */
-	err = truncate_bdev_range(bdev, mode, start, end);
-	if (err)
-		return err;
+	mapping = bdev->bd_inode->i_mapping;
+	truncate_inode_pages_range(mapping, start, end);
 
 	return blkdev_issue_zeroout(bdev, start >> 9, len >> 9, GFP_KERNEL,
 			BLKDEV_ZERO_NOUNMAP);
diff --git a/fs/block_dev.c b/fs/block_dev.c
index 3b8963e228a1..bfd97eb4b5f5 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -103,31 +103,6 @@ void invalidate_bdev(struct block_device *bdev)
 }
 EXPORT_SYMBOL(invalidate_bdev);
 
-/*
- * Drop all buffers & page cache for given bdev range. This function bails
- * with error if bdev has other exclusive owner (such as filesystem).
- */
-int truncate_bdev_range(struct block_device *bdev, fmode_t mode,
-			loff_t lstart, loff_t lend)
-{
-	/*
-	 * If we don't hold exclusive handle for the device, upgrade to it
-	 * while we discard the buffer cache to avoid discarding buffers
-	 * under live filesystem.
-	 */
-	if (!(mode & FMODE_EXCL)) {
-		int err = bd_prepare_to_claim(bdev, truncate_bdev_range);
-		if (err)
-			return err;
-	}
-
-	truncate_inode_pages_range(bdev->bd_inode->i_mapping, lstart, lend);
-	if (!(mode & FMODE_EXCL))
-		bd_abort_claiming(bdev, truncate_bdev_range);
-	return 0;
-}
-EXPORT_SYMBOL(truncate_bdev_range);
-
 static void set_init_blocksize(struct block_device *bdev)
 {
 	bdev->bd_inode->i_blkbits = blksize_bits(bdev_logical_block_size(bdev));
@@ -1748,6 +1723,7 @@ static long blkdev_fallocate(struct file *file, int mode, loff_t start,
 			     loff_t len)
 {
 	struct block_device *bdev = I_BDEV(bdev_file_inode(file));
+	struct address_space *mapping;
 	loff_t end = start + len - 1;
 	loff_t isize;
 	int error;
@@ -1775,9 +1751,8 @@ static long blkdev_fallocate(struct file *file, int mode, loff_t start,
 		return -EINVAL;
 
 	/* Invalidate the page cache, including dirty pages. */
-	error = truncate_bdev_range(bdev, file->f_mode, start, end);
-	if (error)
-		return error;
+	mapping = bdev->bd_inode->i_mapping;
+	truncate_inode_pages_range(mapping, start, end);
 
 	switch (mode) {
 	case FALLOC_FL_ZERO_RANGE:
@@ -1804,7 +1779,7 @@ static long blkdev_fallocate(struct file *file, int mode, loff_t start,
 	 * the caller will be given -EBUSY.  The third argument is
 	 * inclusive, so the rounding here is safe.
 	 */
-	return invalidate_inode_pages2_range(bdev->bd_inode->i_mapping,
+	return invalidate_inode_pages2_range(mapping,
 					     start >> PAGE_SHIFT,
 					     end >> PAGE_SHIFT);
 }
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index f94ee3089e01..dcce654e8201 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -2015,18 +2015,11 @@ void bdput(struct block_device *);
 
 #ifdef CONFIG_BLOCK
 void invalidate_bdev(struct block_device *bdev);
-int truncate_bdev_range(struct block_device *bdev, fmode_t mode, loff_t lstart,
-			loff_t lend);
 int sync_blockdev(struct block_device *bdev);
 #else
 static inline void invalidate_bdev(struct block_device *bdev)
 {
 }
-static inline int truncate_bdev_range(struct block_device *bdev, fmode_t mode,
-				      loff_t lstart, loff_t lend)
-{
-	return 0;
-}
 static inline int sync_blockdev(struct block_device *bdev)
 {
 	return 0;
-- 
2.26.2

