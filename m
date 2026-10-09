Received: from proxmox-new.maurer-it.com (proxmox-new.maurer-it.com [94.136.29.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAEAE43991C;
	Fri,  9 Oct 2026 09:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.136.29.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791539886; cv=none; b=UKQUawhaoa/lDtd7/aMd1txjkHXdI1o5gMtx/AUxERlST2J+ZGzRqleSw4QutvU3asd6fxTsaOvZev1/+WE92XRDDO6/KBf3zYIqHPqPocpaJr5rGHO1LziPJahxoKLP5exHk7rHcb8GkprwjzggPT4f2LGeHTA0rSdpFPdfVB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791539886; c=relaxed/simple;
	bh=sXVwK4v7XyVdNptnwdx7FEAbDz0vPDle3w8jN8YczOs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ppap6ofcXcliF+t7n4gz4e+lk7SAVcSRd9wnmrgvs8a7VtXN+ugr7TVysv9QOvdeGCm1wd7WoBi9kEb9YuA5tCyWiVfocKQetqdhEKG9t+i8gw3lOeAJecYDlU+Y8cmyrrVfBeVZud3ow8L9zWGCAyh4O8N749sj2IrkireVEkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com; spf=pass smtp.mailfrom=proxmox.com; arc=none smtp.client-ip=94.136.29.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proxmox.com
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
	by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 5141347971;
	Fri, 09 Oct 2026 11:58:03 +0200 (CEST)
From: Lukas Sichert <l.sichert@proxmox.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Sichert <l.sichert@proxmox.com>
Subject: [RFC PATCH 3/4] block: coalesce bios across folios in blkdev_writepages
Date: Fri,  9 Oct 2026 11:57:50 +0200
Message-ID: <20261009095754.430875-4-l.sichert@proxmox.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261009095754.430875-1-l.sichert@proxmox.com>
References: <20261009095754.430875-1-l.sichert@proxmox.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1791539881825

Writeback of a block device ends the bio at every folio, even when
consecutive dirty folios are contiguous on disk. To aggregate data
across folios, keep one bio open for the whole writeback pass instead of
for a single folio. Each folio appends its buffers to it as long as they
continue the data already in the bio, and the bio is submitted once
the pass is done. Allocate it with room for the maximum number of
segments so it can grow. Other users of the folio writeback path still
submit one bio per folio as before.

Signed-off-by: Lukas Sichert <l.sichert@proxmox.com>
---
 block/fops.c                |  9 +++++-
 fs/buffer.c                 | 62 +++++++++++++++++++++++++------------
 include/linux/buffer_head.h |  3 ++
 3 files changed, 54 insertions(+), 20 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index c915ec0126d7..eeeb0ad1ca68 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -7,6 +7,7 @@
 #include <linux/init.h>
 #include <linux/mm.h>
 #include <linux/blkdev.h>
+#include <linux/blk-crypto.h>
 #include <linux/blk-integrity.h>
 #include <linux/buffer_head.h>
 #include <linux/mpage.h>
@@ -485,11 +486,17 @@ static int blkdev_writepages(struct address_space *mapping,
 {
 	struct folio *folio = NULL;
 	struct blk_plug plug;
+	struct bio *bio = NULL;
 	int err;
 
 	blk_start_plug(&plug);
 	while ((folio = writeback_iter(mapping, wbc, folio, &err)))
-		err = block_write_full_folio(folio, wbc, blkdev_get_block);
+		err = block_write_full_folio_bio(folio, wbc, blkdev_get_block,
+				&bio, BIO_MAX_VECS);
+	if (bio) {
+		guard_bio_eod(bio);
+		blk_crypto_submit_bio(bio);
+	}
 	blk_finish_plug(&plug);
 
 	return err;
diff --git a/fs/buffer.c b/fs/buffer.c
index ae350d443b27..ac01d8be886f 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -1093,8 +1093,8 @@ static void buffer_set_crypto_ctx(struct bio *bio, const struct buffer_head *bh,
 			folio_pos(bh->b_folio) + bh_offset(bh), gfp_mask);
 }
 
-static struct bio *bh_bio_alloc(struct buffer_head *bh, blk_opf_t opf,
-				enum rw_hint write_hint, bio_end_io_t end_bio)
+static struct bio *bh_bio_alloc(struct buffer_head *bh, unsigned short nr_vecs,
+				blk_opf_t opf, enum rw_hint write_hint, bio_end_io_t end_bio)
 {
 	struct bio *bio;
 
@@ -1103,7 +1103,7 @@ static struct bio *bh_bio_alloc(struct buffer_head *bh, blk_opf_t opf,
 	if (buffer_prio(bh))
 		opf |= REQ_PRIO;
 
-	bio = bio_alloc(bh->b_bdev, 1, opf, GFP_NOIO);
+	bio = bio_alloc(bh->b_bdev, nr_vecs, opf, GFP_NOIO);
 
 	if (folio_test_dropbehind(bh->b_folio) && op_is_write(opf))
 		bio_set_flag(bio, BIO_COMPLETE_IN_TASK);
@@ -1136,7 +1136,7 @@ static void __bh_submit(struct buffer_head *bh, blk_opf_t opf,
 	if (test_set_buffer_req(bh) && (op == REQ_OP_WRITE))
 		clear_buffer_write_io_error(bh);
 
-	bio = bh_bio_alloc(bh, opf, write_hint, end_bio);
+	bio = bh_bio_alloc(bh, 1, opf, write_hint, end_bio);
 
 	bio_add_folio_nofail(bio, bh->b_folio, bh->b_size, bh_offset(bh));
 	bio->bi_private = bh;
@@ -1168,7 +1168,7 @@ void bh_submit(struct buffer_head *bh, blk_opf_t opf, bio_end_io_t end_io)
 EXPORT_SYMBOL(bh_submit);
 
 static void __bh_bio_append(struct bio **biop, struct buffer_head *bh,
-			    blk_opf_t opf, enum rw_hint write_hint,
+			    unsigned short nr_vecs, blk_opf_t opf, enum rw_hint write_hint,
 			    struct writeback_control *wbc, bio_end_io_t end_bio)
 {
 	const enum req_op op = opf & REQ_OP_MASK;
@@ -1222,7 +1222,7 @@ static void __bh_bio_append(struct bio **biop, struct buffer_head *bh,
 	}
 
 	if (!bio) {
-		bio = bh_bio_alloc(bh, opf, write_hint, end_bio);
+		bio = bh_bio_alloc(bh, nr_vecs, opf, write_hint, end_bio);
 		if (wbc)
 			wbc_init_bio(wbc, bio);
 		bio_add_folio_nofail(bio, bh->b_folio, bh->b_size, bh_offset(bh));
@@ -1832,8 +1832,9 @@ static struct buffer_head *folio_create_buffers(struct folio *folio,
  * WB_SYNC_ALL, the writes are posted using REQ_SYNC; this
  * causes the writes to be flagged as synchronous writes.
  */
-int __block_write_full_folio(struct inode *inode, struct folio *folio,
-			get_block_t *get_block, struct writeback_control *wbc)
+static int __block_write_full_folio_bio(struct inode *inode, struct folio *folio,
+			get_block_t *get_block, struct writeback_control *wbc,
+			struct bio **biop, unsigned short nr_vecs)
 {
 	int err;
 	sector_t block;
@@ -1842,7 +1843,6 @@ int __block_write_full_folio(struct inode *inode, struct folio *folio,
 	size_t blocksize;
 	int nr_underway = 0;
 	blk_opf_t write_flags = wbc_to_write_flags(wbc);
-	struct bio *bio;
 
 	head = folio_create_buffers(folio, inode,
 				    (1 << BH_Dirty) | (1 << BH_Uptodate));
@@ -1926,23 +1926,16 @@ int __block_write_full_folio(struct inode *inode, struct folio *folio,
 	BUG_ON(folio_test_writeback(folio));
 	folio_start_writeback(folio);
 
-	bio = NULL;
 	do {
 		struct buffer_head *next = bh->b_this_page;
 		if (buffer_async_write(bh)) {
-			__bh_bio_append(&bio, bh, REQ_OP_WRITE | write_flags,
+			__bh_bio_append(biop, bh, nr_vecs, REQ_OP_WRITE | write_flags,
 					inode->i_write_hint, wbc,
 					bh_end_async_write_range);
 			nr_underway++;
 		}
 		bh = next;
 	} while (bh != head);
-
-	if (bio) {
-		guard_bio_eod(bio);
-		blk_crypto_submit_bio(bio);
-	}
-
 	folio_unlock(folio);
 
 	err = 0;
@@ -2001,6 +1994,20 @@ int __block_write_full_folio(struct inode *inode, struct folio *folio,
 	folio_unlock(folio);
 	goto done;
 }
+
+int __block_write_full_folio(struct inode *inode, struct folio *folio,
+			get_block_t *get_block, struct writeback_control *wbc)
+{
+	struct bio *bio = NULL;
+	int err;
+
+	err = __block_write_full_folio_bio(inode, folio, get_block, wbc, &bio, 1);
+	if (bio) {
+		guard_bio_eod(bio);
+		blk_crypto_submit_bio(bio);
+	}
+	return err;
+}
 EXPORT_SYMBOL(__block_write_full_folio);
 
 /*
@@ -2761,13 +2768,29 @@ EXPORT_SYMBOL(block_truncate_page);
  */
 int block_write_full_folio(struct folio *folio, struct writeback_control *wbc,
 		void *get_block)
+{
+	struct bio *bio = NULL;
+	int err;
+
+	err = block_write_full_folio_bio(folio, wbc, get_block, &bio, 1);
+	if (bio) {
+		guard_bio_eod(bio);
+		blk_crypto_submit_bio(bio);
+	}
+	return err;
+}
+
+int block_write_full_folio_bio(struct folio *folio,
+		struct writeback_control *wbc, void *get_block,
+		struct bio **biop, unsigned short nr_vecs)
 {
 	struct inode * const inode = folio->mapping->host;
 	loff_t i_size = i_size_read(inode);
 
 	/* Is the folio fully inside i_size? */
 	if (folio_next_pos(folio) <= i_size)
-		return __block_write_full_folio(inode, folio, get_block, wbc);
+		return __block_write_full_folio_bio(inode, folio, get_block,
+				wbc, biop, nr_vecs);
 
 	/* Is the folio fully outside i_size? (truncate in progress) */
 	if (folio_pos(folio) >= i_size) {
@@ -2784,7 +2807,8 @@ int block_write_full_folio(struct folio *folio, struct writeback_control *wbc,
 	 */
 	folio_zero_segment(folio, offset_in_folio(folio, i_size),
 			folio_size(folio));
-	return __block_write_full_folio(inode, folio, get_block, wbc);
+	return __block_write_full_folio_bio(inode, folio, get_block, wbc,
+			biop, nr_vecs);
 }
 
 sector_t generic_block_bmap(struct address_space *mapping, sector_t block,
diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index fd2c7115c054..930ea641429c 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -252,6 +252,9 @@ void __bh_read_batch(int nr, struct buffer_head *bhs[],
 void block_invalidate_folio(struct folio *folio, size_t offset, size_t length);
 int block_write_full_folio(struct folio *folio, struct writeback_control *wbc,
 		void *get_block);
+int block_write_full_folio_bio(struct folio *folio,
+		struct writeback_control *wbc, void *get_block,
+		struct bio **biop, unsigned short nr_vecs);
 int __block_write_full_folio(struct inode *inode, struct folio *folio,
 		get_block_t *get_block, struct writeback_control *wbc);
 int block_read_full_folio(struct folio *, get_block_t *);

