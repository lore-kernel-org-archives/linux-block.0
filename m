Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34263 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750728AbdCZEC4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 26 Mar 2017 00:02:56 -0400
From: Eric Biggers <ebiggers3@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-block@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Biggers <ebiggers@google.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>
Subject: [PATCH] fs: remove _submit_bh()
Date: Sat, 25 Mar 2017 21:02:18 -0700
Message-Id: <20170326040218.28519-1-ebiggers3@gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

_submit_bh() allowed submitting a buffer_head for I/O using custom
bio_flags.  It used to be used by jbd to set BIO_SNAP_STABLE, introduced
by commit 713685111774 ("mm: make snapshotting pages for stable writes a
per-bio operation").  However, the code and flag has since been removed
and no _submit_bh() users remain.

These days, bio_flags are mostly used internally by the block layer to
track the state of bio's.  As such, it doesn't really make sense for
filesystems to use them instead of op_flags when wanting special
behavior for block requests.

Therefore, remove _submit_bh() and trim the bio_flags argument from
submit_bh_wbc().

Cc: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/buffer.c                 | 19 +++++--------------
 include/linux/buffer_head.h |  2 --
 2 files changed, 5 insertions(+), 16 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 9196f2a270da..68dc05ce06a5 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -49,7 +49,6 @@
 
 static int fsync_buffers_list(spinlock_t *lock, struct list_head *list);
 static int submit_bh_wbc(int op, int op_flags, struct buffer_head *bh,
-			 unsigned long bio_flags,
 			 struct writeback_control *wbc);
 
 #define BH_ENTRY(list) list_entry((list), struct buffer_head, b_assoc_buffers)
@@ -1830,7 +1829,7 @@ int __block_write_full_page(struct inode *inode, struct page *page,
 	do {
 		struct buffer_head *next = bh->b_this_page;
 		if (buffer_async_write(bh)) {
-			submit_bh_wbc(REQ_OP_WRITE, write_flags, bh, 0, wbc);
+			submit_bh_wbc(REQ_OP_WRITE, write_flags, bh, wbc);
 			nr_underway++;
 		}
 		bh = next;
@@ -1884,7 +1883,7 @@ int __block_write_full_page(struct inode *inode, struct page *page,
 		struct buffer_head *next = bh->b_this_page;
 		if (buffer_async_write(bh)) {
 			clear_buffer_dirty(bh);
-			submit_bh_wbc(REQ_OP_WRITE, write_flags, bh, 0, wbc);
+			submit_bh_wbc(REQ_OP_WRITE, write_flags, bh, wbc);
 			nr_underway++;
 		}
 		bh = next;
@@ -3095,7 +3094,7 @@ void guard_bio_eod(int op, struct bio *bio)
 }
 
 static int submit_bh_wbc(int op, int op_flags, struct buffer_head *bh,
-			 unsigned long bio_flags, struct writeback_control *wbc)
+			 struct writeback_control *wbc)
 {
 	struct bio *bio;
 
@@ -3130,7 +3129,6 @@ static int submit_bh_wbc(int op, int op_flags, struct buffer_head *bh,
 
 	bio->bi_end_io = end_bio_bh_io_sync;
 	bio->bi_private = bh;
-	bio->bi_flags |= bio_flags;
 
 	/* Take care of bh's that straddle the end of the device */
 	guard_bio_eod(op, bio);
@@ -3145,16 +3143,9 @@ static int submit_bh_wbc(int op, int op_flags, struct buffer_head *bh,
 	return 0;
 }
 
-int _submit_bh(int op, int op_flags, struct buffer_head *bh,
-	       unsigned long bio_flags)
+int submit_bh(int op, int op_flags, struct buffer_head *bh)
 {
-	return submit_bh_wbc(op, op_flags, bh, bio_flags, NULL);
-}
-EXPORT_SYMBOL_GPL(_submit_bh);
-
-int submit_bh(int op, int op_flags,  struct buffer_head *bh)
-{
-	return submit_bh_wbc(op, op_flags, bh, 0, NULL);
+	return submit_bh_wbc(op, op_flags, bh, NULL);
 }
 EXPORT_SYMBOL(submit_bh);
 
diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index 79591c3660cc..bd029e52ef5e 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -196,8 +196,6 @@ void ll_rw_block(int, int, int, struct buffer_head * bh[]);
 int sync_dirty_buffer(struct buffer_head *bh);
 int __sync_dirty_buffer(struct buffer_head *bh, int op_flags);
 void write_dirty_buffer(struct buffer_head *bh, int op_flags);
-int _submit_bh(int op, int op_flags, struct buffer_head *bh,
-	       unsigned long bio_flags);
 int submit_bh(int, int, struct buffer_head *);
 void write_boundary_block(struct block_device *bdev,
 			sector_t bblock, unsigned blocksize);
-- 
2.12.1
