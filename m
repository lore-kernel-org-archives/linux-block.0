Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:32860 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933078AbcL0QHU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Dec 2016 11:07:20 -0500
From: Ming Lei <tom.leiming@gmail.com>
To: Jens Axboe <axboe@fb.com>, linux-kernel@vger.kernel.org
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Ming Lei <tom.leiming@gmail.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <jbacik@fb.com>, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org (open list:BTRFS FILE SYSTEM)
Subject: [PATCH v1 51/54] btrfs: avoid access to .bi_vcnt directly
Date: Wed, 28 Dec 2016 00:05:00 +0800
Message-Id: <1482854706-14128-20-git-send-email-tom.leiming@gmail.com>
In-Reply-To: <1482854706-14128-1-git-send-email-tom.leiming@gmail.com>
References: <1482854706-14128-1-git-send-email-tom.leiming@gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

BTRFS uses bio->bi_vcnt to figure out page numbers, this
way becomes not correct once we start to support multipage
bvec.

So use bio_segments_all() instead.

Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 fs/btrfs/check-integrity.c | 7 ++++---
 fs/btrfs/extent_io.c       | 9 ++++++---
 fs/btrfs/extent_io.h       | 1 +
 fs/btrfs/inode.c           | 2 +-
 4 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/check-integrity.c b/fs/btrfs/check-integrity.c
index e3cc7b18fe8b..9c184a61e098 100644
--- a/fs/btrfs/check-integrity.c
+++ b/fs/btrfs/check-integrity.c
@@ -2829,17 +2829,18 @@ static void __btrfsic_submit_bio(struct bio *bio)
 		int bio_is_patched;
 		char **mapped_datav;
 		struct bvec_iter_all bia;
+		unsigned num_pages = bio_segments_all(bio);
 
 		dev_bytenr = 512 * bio->bi_iter.bi_sector;
 		bio_is_patched = 0;
 		if (dev_state->state->print_mask &
 		    BTRFSIC_PRINT_MASK_SUBMIT_BIO_BH)
 			pr_info("submit_bio(rw=%d,0x%x, bi_vcnt=%u, bi_sector=%llu (bytenr %llu), bi_bdev=%p)\n",
-			       bio_op(bio), bio->bi_opf, bio->bi_vcnt,
+			       bio_op(bio), bio->bi_opf, num_pages,
 			       (unsigned long long)bio->bi_iter.bi_sector,
 			       dev_bytenr, bio->bi_bdev);
 
-		mapped_datav = kmalloc_array(bio->bi_vcnt,
+		mapped_datav = kmalloc_array(num_pages,
 					     sizeof(*mapped_datav), GFP_NOFS);
 		if (!mapped_datav)
 			goto leave;
@@ -2856,7 +2857,7 @@ static void __btrfsic_submit_bio(struct bio *bio)
 			cur_bytenr += bvec->bv_len;
 		}
 		btrfsic_process_written_block(dev_state, dev_bytenr,
-					      mapped_datav, bio->bi_vcnt,
+					      mapped_datav, num_pages,
 					      bio, &bio_is_patched,
 					      NULL, bio->bi_opf);
 		bio_for_each_segment_all_sp(bvec, bio, i, bia)
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 137f95063c85..3c021f4dd8bf 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2273,6 +2273,7 @@ int btrfs_get_io_failure_record(struct inode *inode, u64 start, u64 end,
 }
 
 int btrfs_check_repairable(struct inode *inode, struct bio *failed_bio,
+			   unsigned num_pages,
 			   struct io_failure_record *failrec, int failed_mirror)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
@@ -2296,7 +2297,7 @@ int btrfs_check_repairable(struct inode *inode, struct bio *failed_bio,
 	 *	a) deliver good data to the caller
 	 *	b) correct the bad sectors on disk
 	 */
-	if (failed_bio->bi_vcnt > 1) {
+	if (num_pages > 1) {
 		/*
 		 * to fulfill b), we need to know the exact failing sectors, as
 		 * we don't want to rewrite any more than the failed ones. thus,
@@ -2390,6 +2391,7 @@ static int bio_readpage_error(struct bio *failed_bio, u64 phy_offset,
 	struct bio *bio;
 	int read_mode = 0;
 	int ret;
+	unsigned num_pages = bio_segments_all(failed_bio);
 
 	BUG_ON(bio_op(failed_bio) == REQ_OP_WRITE);
 
@@ -2397,13 +2399,14 @@ static int bio_readpage_error(struct bio *failed_bio, u64 phy_offset,
 	if (ret)
 		return ret;
 
-	ret = btrfs_check_repairable(inode, failed_bio, failrec, failed_mirror);
+	ret = btrfs_check_repairable(inode, failed_bio, num_pages, failrec,
+				     failed_mirror);
 	if (!ret) {
 		free_io_failure(inode, failrec);
 		return -EIO;
 	}
 
-	if (failed_bio->bi_vcnt > 1)
+	if (num_pages > 1)
 		read_mode |= REQ_FAILFAST_DEV;
 
 	phy_offset >>= inode->i_sb->s_blocksize_bits;
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 17f9ce479ed7..8fce380bc8d7 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -483,6 +483,7 @@ void btrfs_free_io_failure_record(struct inode *inode, u64 start, u64 end);
 int btrfs_get_io_failure_record(struct inode *inode, u64 start, u64 end,
 				struct io_failure_record **failrec_ret);
 int btrfs_check_repairable(struct inode *inode, struct bio *failed_bio,
+			   unsigned num_pages,
 			   struct io_failure_record *failrec, int fail_mirror);
 struct bio *btrfs_create_repair_bio(struct inode *inode, struct bio *failed_bio,
 				    struct io_failure_record *failrec,
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 544e1cf9a552..fa77cb210907 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7914,7 +7914,7 @@ static int dio_read_error(struct inode *inode, struct bio *failed_bio,
 		return -EIO;
 	}
 
-	if ((failed_bio->bi_vcnt > 1)
+	if ((bio_segments_all(failed_bio) > 1)
 		|| (failed_bio->bi_io_vec->bv_len
 			> btrfs_inode_sectorsize(inode)))
 		read_mode |= REQ_FAILFAST_DEV;
-- 
2.7.4

