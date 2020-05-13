Return-Path: <SRS0=8+4U=63=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EA86C2D0FC
	for <linux-block@archiver.kernel.org>; Wed, 13 May 2020 12:36:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A9FE2176D
	for <linux-block@archiver.kernel.org>; Wed, 13 May 2020 12:36:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CHyx/j5k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731644AbgEMMgH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 May 2020 08:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731346AbgEMMgG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 May 2020 08:36:06 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA563C061A0F
        for <linux-block@vger.kernel.org>; Wed, 13 May 2020 05:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=RRWOst3M+eQm8m5tWJXbhhaFu1V8OlZ92magIS0yfSs=; b=CHyx/j5kETwuKi4g8kjKB+ZNrw
        cFhU/ICUP7xB2hSMP+SZrAyncrBOfOh0ijkywkvaW1WYGXWiUyTWKvJ4y8PETmDZtW64AgSPVpDsJ
        +VjzWWn7lz7VK9T+EBgx7xe7UZCL0OY8mrtnO0HK93R7T/3M7zbTue/IMIlJaeA8gaXEd4eqtCUwx
        l1+7gIFBYRVqSqnaqahhsMG20OUQPuTDfgEoGybGPjHFf3+SUFwhnDlHVIIuFZMapdkEJzvzD8Q42
        l/H+hf0+TPpJAE+AXnbp+Sk+Ku2FGEBP9SjA4JKCyZwUErbLMku8WJ0yfngLBmR0amCdz1Z95iRG6
        PfhTShZA==;
Received: from [2001:4bb8:180:9d3f:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jYqcI-0004Qo-4R; Wed, 13 May 2020 12:36:06 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 1/2] block: remove the error_sector argument to blkdev_issue_flush
Date:   Wed, 13 May 2020 14:36:00 +0200
Message-Id: <20200513123601.2465370-2-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200513123601.2465370-1-hch@lst.de>
References: <20200513123601.2465370-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The argument isn't used by any caller, and drivers don't fill out
bi_sector for flush requests either.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-flush.c                 | 17 ++---------------
 drivers/md/dm-integrity.c         |  2 +-
 drivers/md/dm-zoned-metadata.c    |  6 +++---
 drivers/md/raid5-ppl.c            |  2 +-
 drivers/nvme/target/io-cmd-bdev.c |  2 +-
 fs/block_dev.c                    |  2 +-
 fs/ext4/fsync.c                   |  2 +-
 fs/ext4/ialloc.c                  |  2 +-
 fs/ext4/super.c                   |  2 +-
 fs/fat/file.c                     |  2 +-
 fs/hfsplus/inode.c                |  2 +-
 fs/hfsplus/super.c                |  2 +-
 fs/jbd2/checkpoint.c              |  2 +-
 fs/jbd2/commit.c                  |  4 ++--
 fs/jbd2/recovery.c                |  2 +-
 fs/libfs.c                        |  2 +-
 fs/nilfs2/the_nilfs.h             |  2 +-
 fs/ocfs2/file.c                   |  2 +-
 fs/reiserfs/file.c                |  2 +-
 fs/xfs/xfs_super.c                |  2 +-
 fs/zonefs/super.c                 |  2 +-
 include/linux/blkdev.h            |  2 +-
 22 files changed, 26 insertions(+), 39 deletions(-)

diff --git a/block/blk-flush.c b/block/blk-flush.c
index c7f396e3d5e29..dc23d5177f9bb 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -433,15 +433,11 @@ void blk_insert_flush(struct request *rq)
  * blkdev_issue_flush - queue a flush
  * @bdev:	blockdev to issue flush for
  * @gfp_mask:	memory allocation flags (for bio_alloc)
- * @error_sector:	error sector
  *
  * Description:
- *    Issue a flush for the block device in question. Caller can supply
- *    room for storing the error offset in case of a flush error, if they
- *    wish to.
+ *    Issue a flush for the block device in question.
  */
-int blkdev_issue_flush(struct block_device *bdev, gfp_t gfp_mask,
-		sector_t *error_sector)
+int blkdev_issue_flush(struct block_device *bdev, gfp_t gfp_mask)
 {
 	struct request_queue *q;
 	struct bio *bio;
@@ -459,15 +455,6 @@ int blkdev_issue_flush(struct block_device *bdev, gfp_t gfp_mask,
 	bio->bi_opf = REQ_OP_WRITE | REQ_PREFLUSH;
 
 	ret = submit_bio_wait(bio);
-
-	/*
-	 * The driver must store the error location in ->bi_sector, if
-	 * it supports it. For non-stacked drivers, this should be
-	 * copied from blk_rq_pos(rq).
-	 */
-	if (error_sector)
-		*error_sector = bio->bi_iter.bi_sector;
-
 	bio_put(bio);
 	return ret;
 }
diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
index 4094c47eca7f2..84cb04904fab7 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -2657,7 +2657,7 @@ static void bitmap_flush_work(struct work_struct *work)
 
 	dm_integrity_flush_buffers(ic);
 	if (ic->meta_dev)
-		blkdev_issue_flush(ic->dev->bdev, GFP_NOIO, NULL);
+		blkdev_issue_flush(ic->dev->bdev, GFP_NOIO);
 
 	limit = ic->provided_data_sectors;
 	if (ic->sb->flags & cpu_to_le32(SB_FLAG_RECALCULATING)) {
diff --git a/drivers/md/dm-zoned-metadata.c b/drivers/md/dm-zoned-metadata.c
index 369de15c4e80c..bf22453703055 100644
--- a/drivers/md/dm-zoned-metadata.c
+++ b/drivers/md/dm-zoned-metadata.c
@@ -661,7 +661,7 @@ static int dmz_write_sb(struct dmz_metadata *zmd, unsigned int set)
 
 	ret = dmz_rdwr_block(zmd, REQ_OP_WRITE, block, mblk->page);
 	if (ret == 0)
-		ret = blkdev_issue_flush(zmd->dev->bdev, GFP_NOIO, NULL);
+		ret = blkdev_issue_flush(zmd->dev->bdev, GFP_NOIO);
 
 	return ret;
 }
@@ -703,7 +703,7 @@ static int dmz_write_dirty_mblocks(struct dmz_metadata *zmd,
 
 	/* Flush drive cache (this will also sync data) */
 	if (ret == 0)
-		ret = blkdev_issue_flush(zmd->dev->bdev, GFP_NOIO, NULL);
+		ret = blkdev_issue_flush(zmd->dev->bdev, GFP_NOIO);
 
 	return ret;
 }
@@ -772,7 +772,7 @@ int dmz_flush_metadata(struct dmz_metadata *zmd)
 
 	/* If there are no dirty metadata blocks, just flush the device cache */
 	if (list_empty(&write_list)) {
-		ret = blkdev_issue_flush(zmd->dev->bdev, GFP_NOIO, NULL);
+		ret = blkdev_issue_flush(zmd->dev->bdev, GFP_NOIO);
 		goto err;
 	}
 
diff --git a/drivers/md/raid5-ppl.c b/drivers/md/raid5-ppl.c
index d50238d0a85db..a750f4bbb5d96 100644
--- a/drivers/md/raid5-ppl.c
+++ b/drivers/md/raid5-ppl.c
@@ -1037,7 +1037,7 @@ static int ppl_recover(struct ppl_log *log, struct ppl_header *pplhdr,
 	}
 
 	/* flush the disk cache after recovery if necessary */
-	ret = blkdev_issue_flush(rdev->bdev, GFP_KERNEL, NULL);
+	ret = blkdev_issue_flush(rdev->bdev, GFP_KERNEL);
 out:
 	__free_page(page);
 	return ret;
diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index ea0e596be15dc..26f50c23b82e9 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -226,7 +226,7 @@ static void nvmet_bdev_execute_flush(struct nvmet_req *req)
 
 u16 nvmet_bdev_flush(struct nvmet_req *req)
 {
-	if (blkdev_issue_flush(req->ns->bdev, GFP_KERNEL, NULL))
+	if (blkdev_issue_flush(req->ns->bdev, GFP_KERNEL))
 		return NVME_SC_INTERNAL | NVME_SC_DNR;
 	return 0;
 }
diff --git a/fs/block_dev.c b/fs/block_dev.c
index ebd1507789d29..d1e08bba925a4 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -672,7 +672,7 @@ int blkdev_fsync(struct file *filp, loff_t start, loff_t end, int datasync)
 	 * i_mutex and doing so causes performance issues with concurrent
 	 * O_SYNC writers to a block device.
 	 */
-	error = blkdev_issue_flush(bdev, GFP_KERNEL, NULL);
+	error = blkdev_issue_flush(bdev, GFP_KERNEL);
 	if (error == -EOPNOTSUPP)
 		error = 0;
 
diff --git a/fs/ext4/fsync.c b/fs/ext4/fsync.c
index e10206e7f4bbe..35ff9a56db679 100644
--- a/fs/ext4/fsync.c
+++ b/fs/ext4/fsync.c
@@ -176,7 +176,7 @@ int ext4_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 		ret = ext4_fsync_journal(inode, datasync, &needs_barrier);
 
 	if (needs_barrier) {
-		err = blkdev_issue_flush(inode->i_sb->s_bdev, GFP_KERNEL, NULL);
+		err = blkdev_issue_flush(inode->i_sb->s_bdev, GFP_KERNEL);
 		if (!ret)
 			ret = err;
 	}
diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
index 4b8c9a9bdf0c8..499f08d8522e2 100644
--- a/fs/ext4/ialloc.c
+++ b/fs/ext4/ialloc.c
@@ -1440,7 +1440,7 @@ int ext4_init_inode_table(struct super_block *sb, ext4_group_t group,
 	if (ret < 0)
 		goto err_out;
 	if (barrier)
-		blkdev_issue_flush(sb->s_bdev, GFP_NOFS, NULL);
+		blkdev_issue_flush(sb->s_bdev, GFP_NOFS);
 
 skip_zeroout:
 	ext4_lock_group(sb, group);
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index bf5fcb477f667..629a56b5c859f 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5256,7 +5256,7 @@ static int ext4_sync_fs(struct super_block *sb, int wait)
 		needs_barrier = true;
 	if (needs_barrier) {
 		int err;
-		err = blkdev_issue_flush(sb->s_bdev, GFP_KERNEL, NULL);
+		err = blkdev_issue_flush(sb->s_bdev, GFP_KERNEL);
 		if (!ret)
 			ret = err;
 	}
diff --git a/fs/fat/file.c b/fs/fat/file.c
index bdc4503c00a38..42134c58c87e1 100644
--- a/fs/fat/file.c
+++ b/fs/fat/file.c
@@ -195,7 +195,7 @@ int fat_file_fsync(struct file *filp, loff_t start, loff_t end, int datasync)
 	if (err)
 		return err;
 
-	return blkdev_issue_flush(inode->i_sb->s_bdev, GFP_KERNEL, NULL);
+	return blkdev_issue_flush(inode->i_sb->s_bdev, GFP_KERNEL);
 }
 
 
diff --git a/fs/hfsplus/inode.c b/fs/hfsplus/inode.c
index 94bd83b366442..e3da9e96b8357 100644
--- a/fs/hfsplus/inode.c
+++ b/fs/hfsplus/inode.c
@@ -340,7 +340,7 @@ int hfsplus_file_fsync(struct file *file, loff_t start, loff_t end,
 	}
 
 	if (!test_bit(HFSPLUS_SB_NOBARRIER, &sbi->flags))
-		blkdev_issue_flush(inode->i_sb->s_bdev, GFP_KERNEL, NULL);
+		blkdev_issue_flush(inode->i_sb->s_bdev, GFP_KERNEL);
 
 	inode_unlock(inode);
 
diff --git a/fs/hfsplus/super.c b/fs/hfsplus/super.c
index 2b9e5743105e2..129dca3f4b78f 100644
--- a/fs/hfsplus/super.c
+++ b/fs/hfsplus/super.c
@@ -239,7 +239,7 @@ static int hfsplus_sync_fs(struct super_block *sb, int wait)
 	mutex_unlock(&sbi->vh_mutex);
 
 	if (!test_bit(HFSPLUS_SB_NOBARRIER, &sbi->flags))
-		blkdev_issue_flush(sb->s_bdev, GFP_KERNEL, NULL);
+		blkdev_issue_flush(sb->s_bdev, GFP_KERNEL);
 
 	return error;
 }
diff --git a/fs/jbd2/checkpoint.c b/fs/jbd2/checkpoint.c
index 96bf33986d030..263f02ad8ebf8 100644
--- a/fs/jbd2/checkpoint.c
+++ b/fs/jbd2/checkpoint.c
@@ -414,7 +414,7 @@ int jbd2_cleanup_journal_tail(journal_t *journal)
 	 * jbd2_cleanup_journal_tail() doesn't get called all that often.
 	 */
 	if (journal->j_flags & JBD2_BARRIER)
-		blkdev_issue_flush(journal->j_fs_dev, GFP_NOFS, NULL);
+		blkdev_issue_flush(journal->j_fs_dev, GFP_NOFS);
 
 	return __jbd2_update_log_tail(journal, first_tid, blocknr);
 }
diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
index e855d8260433a..6d2da8ad0e6f5 100644
--- a/fs/jbd2/commit.c
+++ b/fs/jbd2/commit.c
@@ -775,7 +775,7 @@ void jbd2_journal_commit_transaction(journal_t *journal)
 	if (commit_transaction->t_need_data_flush &&
 	    (journal->j_fs_dev != journal->j_dev) &&
 	    (journal->j_flags & JBD2_BARRIER))
-		blkdev_issue_flush(journal->j_fs_dev, GFP_NOFS, NULL);
+		blkdev_issue_flush(journal->j_fs_dev, GFP_NOFS);
 
 	/* Done it all: now write the commit record asynchronously. */
 	if (jbd2_has_feature_async_commit(journal)) {
@@ -882,7 +882,7 @@ void jbd2_journal_commit_transaction(journal_t *journal)
 	stats.run.rs_blocks_logged++;
 	if (jbd2_has_feature_async_commit(journal) &&
 	    journal->j_flags & JBD2_BARRIER) {
-		blkdev_issue_flush(journal->j_dev, GFP_NOFS, NULL);
+		blkdev_issue_flush(journal->j_dev, GFP_NOFS);
 	}
 
 	if (err)
diff --git a/fs/jbd2/recovery.c b/fs/jbd2/recovery.c
index a4967b27ffb63..2ed278f0dcede 100644
--- a/fs/jbd2/recovery.c
+++ b/fs/jbd2/recovery.c
@@ -286,7 +286,7 @@ int jbd2_journal_recover(journal_t *journal)
 		err = err2;
 	/* Make sure all replayed data is on permanent storage */
 	if (journal->j_flags & JBD2_BARRIER) {
-		err2 = blkdev_issue_flush(journal->j_fs_dev, GFP_KERNEL, NULL);
+		err2 = blkdev_issue_flush(journal->j_fs_dev, GFP_KERNEL);
 		if (!err)
 			err = err2;
 	}
diff --git a/fs/libfs.c b/fs/libfs.c
index 3759fbacf5222..4d08edf19c782 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -1113,7 +1113,7 @@ int generic_file_fsync(struct file *file, loff_t start, loff_t end,
 	err = __generic_file_fsync(file, start, end, datasync);
 	if (err)
 		return err;
-	return blkdev_issue_flush(inode->i_sb->s_bdev, GFP_KERNEL, NULL);
+	return blkdev_issue_flush(inode->i_sb->s_bdev, GFP_KERNEL);
 }
 EXPORT_SYMBOL(generic_file_fsync);
 
diff --git a/fs/nilfs2/the_nilfs.h b/fs/nilfs2/the_nilfs.h
index 380a543c5b19b..b55cdeb4d1699 100644
--- a/fs/nilfs2/the_nilfs.h
+++ b/fs/nilfs2/the_nilfs.h
@@ -375,7 +375,7 @@ static inline int nilfs_flush_device(struct the_nilfs *nilfs)
 	 */
 	smp_wmb();
 
-	err = blkdev_issue_flush(nilfs->ns_bdev, GFP_KERNEL, NULL);
+	err = blkdev_issue_flush(nilfs->ns_bdev, GFP_KERNEL);
 	if (err != -EIO)
 		err = 0;
 	return err;
diff --git a/fs/ocfs2/file.c b/fs/ocfs2/file.c
index 6cd5e4924e4d2..85979e2214b39 100644
--- a/fs/ocfs2/file.c
+++ b/fs/ocfs2/file.c
@@ -194,7 +194,7 @@ static int ocfs2_sync_file(struct file *file, loff_t start, loff_t end,
 		needs_barrier = true;
 	err = jbd2_complete_transaction(journal, commit_tid);
 	if (needs_barrier) {
-		ret = blkdev_issue_flush(inode->i_sb->s_bdev, GFP_KERNEL, NULL);
+		ret = blkdev_issue_flush(inode->i_sb->s_bdev, GFP_KERNEL);
 		if (!err)
 			err = ret;
 	}
diff --git a/fs/reiserfs/file.c b/fs/reiserfs/file.c
index 84cf8bdbec9cb..0b641ae694f12 100644
--- a/fs/reiserfs/file.c
+++ b/fs/reiserfs/file.c
@@ -159,7 +159,7 @@ static int reiserfs_sync_file(struct file *filp, loff_t start, loff_t end,
 	barrier_done = reiserfs_commit_for_inode(inode);
 	reiserfs_write_unlock(inode->i_sb);
 	if (barrier_done != 1 && reiserfs_barrier_flush(inode->i_sb))
-		blkdev_issue_flush(inode->i_sb->s_bdev, GFP_KERNEL, NULL);
+		blkdev_issue_flush(inode->i_sb->s_bdev, GFP_KERNEL);
 	inode_unlock(inode);
 	if (barrier_done < 0)
 		return barrier_done;
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index 424bb9a2d5325..a123cd8267d98 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -305,7 +305,7 @@ void
 xfs_blkdev_issue_flush(
 	xfs_buftarg_t		*buftarg)
 {
-	blkdev_issue_flush(buftarg->bt_bdev, GFP_NOFS, NULL);
+	blkdev_issue_flush(buftarg->bt_bdev, GFP_NOFS);
 }
 
 STATIC void
diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index 0bf7009f50a27..25afcf55aa41e 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -479,7 +479,7 @@ static int zonefs_file_fsync(struct file *file, loff_t start, loff_t end,
 	if (ZONEFS_I(inode)->i_ztype == ZONEFS_ZTYPE_CNV)
 		ret = file_write_and_wait_range(file, start, end);
 	if (!ret)
-		ret = blkdev_issue_flush(inode->i_sb->s_bdev, GFP_KERNEL, NULL);
+		ret = blkdev_issue_flush(inode->i_sb->s_bdev, GFP_KERNEL);
 
 	if (ret)
 		zonefs_io_error(inode, true);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 5360696d85ff7..72a3e9ebe7677 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1221,7 +1221,7 @@ static inline bool blk_needs_flush_plug(struct task_struct *tsk)
 		 !list_empty(&plug->cb_list));
 }
 
-extern int blkdev_issue_flush(struct block_device *, gfp_t, sector_t *);
+int blkdev_issue_flush(struct block_device *, gfp_t);
 extern int blkdev_issue_write_same(struct block_device *bdev, sector_t sector,
 		sector_t nr_sects, gfp_t gfp_mask, struct page *page);
 
-- 
2.26.2

