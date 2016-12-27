Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35124 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933007AbcL0QGz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Dec 2016 11:06:55 -0500
From: Ming Lei <tom.leiming@gmail.com>
To: Jens Axboe <axboe@fb.com>, linux-kernel@vger.kernel.org
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Ming Lei <tom.leiming@gmail.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <jbacik@fb.com>, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org (open list:BTRFS FILE SYSTEM)
Subject: [PATCH v1 47/54] fs/btrfs: convert to bio_for_each_segment_all_sp()
Date: Wed, 28 Dec 2016 00:04:56 +0800
Message-Id: <1482854706-14128-16-git-send-email-tom.leiming@gmail.com>
In-Reply-To: <1482854706-14128-1-git-send-email-tom.leiming@gmail.com>
References: <1482854706-14128-1-git-send-email-tom.leiming@gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 fs/btrfs/check-integrity.c |  5 +++--
 fs/btrfs/compression.c     |  3 ++-
 fs/btrfs/disk-io.c         |  3 ++-
 fs/btrfs/extent_io.c       |  9 ++++++---
 fs/btrfs/file-item.c       |  6 ++++--
 fs/btrfs/inode.c           | 15 ++++++++++-----
 fs/btrfs/raid56.c          |  6 ++++--
 7 files changed, 31 insertions(+), 16 deletions(-)

diff --git a/fs/btrfs/check-integrity.c b/fs/btrfs/check-integrity.c
index ab14c2e635ca..e3cc7b18fe8b 100644
--- a/fs/btrfs/check-integrity.c
+++ b/fs/btrfs/check-integrity.c
@@ -2828,6 +2828,7 @@ static void __btrfsic_submit_bio(struct bio *bio)
 		struct bio_vec *bvec;
 		int bio_is_patched;
 		char **mapped_datav;
+		struct bvec_iter_all bia;
 
 		dev_bytenr = 512 * bio->bi_iter.bi_sector;
 		bio_is_patched = 0;
@@ -2844,7 +2845,7 @@ static void __btrfsic_submit_bio(struct bio *bio)
 			goto leave;
 		cur_bytenr = dev_bytenr;
 
-		bio_for_each_segment_all(bvec, bio, i) {
+		bio_for_each_segment_all_sp(bvec, bio, i, bia) {
 			BUG_ON(bvec->bv_len != PAGE_SIZE);
 			mapped_datav[i] = kmap(bvec->bv_page);
 
@@ -2858,7 +2859,7 @@ static void __btrfsic_submit_bio(struct bio *bio)
 					      mapped_datav, bio->bi_vcnt,
 					      bio, &bio_is_patched,
 					      NULL, bio->bi_opf);
-		bio_for_each_segment_all(bvec, bio, i)
+		bio_for_each_segment_all_sp(bvec, bio, i, bia)
 			kunmap(bvec->bv_page);
 		kfree(mapped_datav);
 	} else if (NULL != dev_state && (bio->bi_opf & REQ_PREFLUSH)) {
diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 7f390849343b..adcf5568f010 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -198,12 +198,13 @@ static void end_compressed_bio_read(struct bio *bio)
 	} else {
 		int i;
 		struct bio_vec *bvec;
+		struct bvec_iter_all bia;
 
 		/*
 		 * we have verified the checksum already, set page
 		 * checked so the end_io handlers know about it
 		 */
-		bio_for_each_segment_all(bvec, cb->orig_bio, i)
+		bio_for_each_segment_all_sp(bvec, cb->orig_bio, i, bia)
 			SetPageChecked(bvec->bv_page);
 
 		bio_endio(cb->orig_bio);
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 18004169552c..c2f9a42cd200 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -965,8 +965,9 @@ static int btree_csum_one_bio(struct bio *bio)
 	struct bio_vec *bvec;
 	struct btrfs_root *root;
 	int i, ret = 0;
+	struct bvec_iter_all bia;
 
-	bio_for_each_segment_all(bvec, bio, i) {
+	bio_for_each_segment_all_sp(bvec, bio, i, bia) {
 		root = BTRFS_I(bvec->bv_page->mapping->host)->root;
 		ret = csum_dirty_buffer(root->fs_info, bvec->bv_page);
 		if (ret)
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 4ac383a3a649..137f95063c85 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2471,8 +2471,9 @@ static void end_bio_extent_writepage(struct bio *bio)
 	u64 start;
 	u64 end;
 	int i;
+	struct bvec_iter_all bia;
 
-	bio_for_each_segment_all(bvec, bio, i) {
+	bio_for_each_segment_all_sp(bvec, bio, i, bia) {
 		struct page *page = bvec->bv_page;
 		struct inode *inode = page->mapping->host;
 		struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
@@ -2541,8 +2542,9 @@ static void end_bio_extent_readpage(struct bio *bio)
 	int mirror;
 	int ret;
 	int i;
+	struct bvec_iter_all bia;
 
-	bio_for_each_segment_all(bvec, bio, i) {
+	bio_for_each_segment_all_sp(bvec, bio, i, bia) {
 		struct page *page = bvec->bv_page;
 		struct inode *inode = page->mapping->host;
 		struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
@@ -3692,8 +3694,9 @@ static void end_bio_extent_buffer_writepage(struct bio *bio)
 	struct bio_vec *bvec;
 	struct extent_buffer *eb;
 	int i, done;
+	struct bvec_iter_all bia;
 
-	bio_for_each_segment_all(bvec, bio, i) {
+	bio_for_each_segment_all_sp(bvec, bio, i, bia) {
 		struct page *page = bvec->bv_page;
 
 		eb = (struct extent_buffer *)page->private;
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index e97e322c28f0..c281df0e6485 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -179,6 +179,7 @@ static int __btrfs_lookup_bio_sums(struct inode *inode, struct bio *bio,
 	int nblocks;
 	int count = 0, i;
 	u16 csum_size = btrfs_super_csum_size(fs_info->super_copy);
+	struct bvec_iter_all bia;
 
 	path = btrfs_alloc_path();
 	if (!path)
@@ -223,7 +224,7 @@ static int __btrfs_lookup_bio_sums(struct inode *inode, struct bio *bio,
 	if (dio)
 		offset = logical_offset;
 
-	bio_for_each_segment_all(bvec, bio, i) {
+	bio_for_each_segment_all_sp(bvec, bio, i, bia) {
 		page_bytes_left = bvec->bv_len;
 		if (count)
 			goto next;
@@ -447,6 +448,7 @@ int btrfs_csum_one_bio(struct inode *inode, struct bio *bio,
 	unsigned long total_bytes = 0;
 	unsigned long this_sum_bytes = 0;
 	u64 offset;
+	struct bvec_iter_all bia;
 
 	WARN_ON(bio->bi_vcnt <= 0);
 	sums = kzalloc(btrfs_ordered_sum_size(fs_info, bio->bi_iter.bi_size),
@@ -465,7 +467,7 @@ int btrfs_csum_one_bio(struct inode *inode, struct bio *bio,
 	sums->bytenr = (u64)bio->bi_iter.bi_sector << 9;
 	index = 0;
 
-	bio_for_each_segment_all(bvec, bio, j) {
+	bio_for_each_segment_all_sp(bvec, bio, j, bia) {
 		if (!contig)
 			offset = page_offset(bvec->bv_page) + bvec->bv_offset;
 
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index f2b281ad7af6..544e1cf9a552 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7955,6 +7955,7 @@ static void btrfs_retry_endio_nocsum(struct bio *bio)
 	struct inode *inode;
 	struct bio_vec *bvec;
 	int i;
+	struct bvec_iter_all bia;
 
 	if (bio->bi_error)
 		goto end;
@@ -7964,7 +7965,7 @@ static void btrfs_retry_endio_nocsum(struct bio *bio)
 	ASSERT(bio->bi_io_vec->bv_len == btrfs_inode_sectorsize(inode));
 
 	done->uptodate = 1;
-	bio_for_each_segment_all(bvec, bio, i)
+	bio_for_each_segment_all_sp(bvec, bio, i, bia)
 		clean_io_failure(done->inode, done->start, bvec->bv_page, 0);
 end:
 	complete(&done->done);
@@ -7983,6 +7984,7 @@ static int __btrfs_correct_data_nocsum(struct inode *inode,
 	int nr_sectors;
 	int i;
 	int ret;
+	struct bvec_iter_all bia;
 
 	fs_info = BTRFS_I(inode)->root->fs_info;
 	sectorsize = fs_info->sectorsize;
@@ -7990,7 +7992,7 @@ static int __btrfs_correct_data_nocsum(struct inode *inode,
 	start = io_bio->logical;
 	done.inode = inode;
 
-	bio_for_each_segment_all(bvec, &io_bio->bio, i) {
+	bio_for_each_segment_all_sp(bvec, &io_bio->bio, i, bia) {
 		nr_sectors = BTRFS_BYTES_TO_BLKS(fs_info, bvec->bv_len);
 		pgoff = bvec->bv_offset;
 
@@ -8034,6 +8036,7 @@ static void btrfs_retry_endio(struct bio *bio)
 	int uptodate;
 	int ret;
 	int i;
+	struct bvec_iter_all bia;
 
 	if (bio->bi_error)
 		goto end;
@@ -8046,7 +8049,7 @@ static void btrfs_retry_endio(struct bio *bio)
 	inode = bio->bi_io_vec->bv_page->mapping->host;
 	ASSERT(bio->bi_io_vec->bv_len == btrfs_inode_sectorsize(inode));
 
-	bio_for_each_segment_all(bvec, bio, i) {
+	bio_for_each_segment_all_sp(bvec, bio, i, bia) {
 		ret = __readpage_endio_check(done->inode, io_bio, i,
 					bvec->bv_page, bvec->bv_offset,
 					done->start, bvec->bv_len);
@@ -8077,6 +8080,7 @@ static int __btrfs_subio_endio_read(struct inode *inode,
 	int csum_pos;
 	int i;
 	int ret;
+	struct bvec_iter_all bia;
 
 	fs_info = BTRFS_I(inode)->root->fs_info;
 	sectorsize = fs_info->sectorsize;
@@ -8085,7 +8089,7 @@ static int __btrfs_subio_endio_read(struct inode *inode,
 	start = io_bio->logical;
 	done.inode = inode;
 
-	bio_for_each_segment_all(bvec, &io_bio->bio, i) {
+	bio_for_each_segment_all_sp(bvec, &io_bio->bio, i, bia) {
 		nr_sectors = BTRFS_BYTES_TO_BLKS(fs_info, bvec->bv_len);
 
 		pgoff = bvec->bv_offset;
@@ -8380,6 +8384,7 @@ static int btrfs_submit_direct_hook(struct btrfs_dio_private *dip,
 	int nr_sectors;
 	int ret;
 	int i, j;
+	struct bvec_iter_all bia;
 
 	map_length = orig_bio->bi_iter.bi_size;
 	ret = btrfs_map_block(fs_info, btrfs_op(orig_bio), start_sector << 9,
@@ -8409,7 +8414,7 @@ static int btrfs_submit_direct_hook(struct btrfs_dio_private *dip,
 	btrfs_io_bio(bio)->logical = file_offset;
 	atomic_inc(&dip->pending_bios);
 
-	bio_for_each_segment_all(bvec, orig_bio, j) {
+	bio_for_each_segment_all_sp(bvec, orig_bio, j, bia) {
 		nr_sectors = BTRFS_BYTES_TO_BLKS(fs_info, bvec->bv_len);
 		i = 0;
 next_block:
diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index d2a9a1ee5361..b218c4084c26 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -1150,6 +1150,7 @@ static void index_rbio_pages(struct btrfs_raid_bio *rbio)
 	unsigned long stripe_offset;
 	unsigned long page_index;
 	int i;
+	struct bvec_iter_all bia;
 
 	spin_lock_irq(&rbio->bio_list_lock);
 	bio_list_for_each(bio, &rbio->bio_list) {
@@ -1157,7 +1158,7 @@ static void index_rbio_pages(struct btrfs_raid_bio *rbio)
 		stripe_offset = start - rbio->bbio->raid_map[0];
 		page_index = stripe_offset >> PAGE_SHIFT;
 
-		bio_for_each_segment_all(bvec, bio, i)
+		bio_for_each_segment_all_sp(bvec, bio, i, bia)
 			rbio->bio_pages[page_index + i] = bvec->bv_page;
 	}
 	spin_unlock_irq(&rbio->bio_list_lock);
@@ -1434,8 +1435,9 @@ static void set_bio_pages_uptodate(struct bio *bio)
 {
 	struct bio_vec *bvec;
 	int i;
+	struct bvec_iter_all bia;
 
-	bio_for_each_segment_all(bvec, bio, i)
+	bio_for_each_segment_all_sp(bvec, bio, i, bia)
 		SetPageUptodate(bvec->bv_page);
 }
 
-- 
2.7.4

