Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
To: linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org
Cc: adilger@dilger.ca,
	hch@infradead.org,
	martin.petersen@oracle.com,
	linux-nvme@lists.infradead.org,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5/9] fs: add support for buffered writeback to pass down write hints
Date: Mon, 19 Jun 2017 11:04:58 -0600
Message-Id: <1497891902-25737-6-git-send-email-axboe@kernel.dk>
In-Reply-To: <1497891902-25737-1-git-send-email-axboe@kernel.dk>
References: <1497891902-25737-1-git-send-email-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

Reviewed-by: Andreas Dilger <adilger@dilger.ca>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/buffer.c | 14 +++++++++-----
 fs/mpage.c  |  1 +
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 306b720f7383..1259524715c8 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -49,7 +49,7 @@
 
 static int fsync_buffers_list(spinlock_t *lock, struct list_head *list);
 static int submit_bh_wbc(int op, int op_flags, struct buffer_head *bh,
-			 struct writeback_control *wbc);
+			 unsigned int stream, struct writeback_control *wbc);
 
 #define BH_ENTRY(list) list_entry((list), struct buffer_head, b_assoc_buffers)
 
@@ -1829,7 +1829,8 @@ int __block_write_full_page(struct inode *inode, struct page *page,
 	do {
 		struct buffer_head *next = bh->b_this_page;
 		if (buffer_async_write(bh)) {
-			submit_bh_wbc(REQ_OP_WRITE, write_flags, bh, wbc);
+			submit_bh_wbc(REQ_OP_WRITE, write_flags, bh,
+					inode_write_hint(inode), wbc);
 			nr_underway++;
 		}
 		bh = next;
@@ -1883,7 +1884,8 @@ int __block_write_full_page(struct inode *inode, struct page *page,
 		struct buffer_head *next = bh->b_this_page;
 		if (buffer_async_write(bh)) {
 			clear_buffer_dirty(bh);
-			submit_bh_wbc(REQ_OP_WRITE, write_flags, bh, wbc);
+			submit_bh_wbc(REQ_OP_WRITE, write_flags, bh,
+					inode_write_hint(inode), wbc);
 			nr_underway++;
 		}
 		bh = next;
@@ -3091,7 +3093,7 @@ void guard_bio_eod(int op, struct bio *bio)
 }
 
 static int submit_bh_wbc(int op, int op_flags, struct buffer_head *bh,
-			 struct writeback_control *wbc)
+			 unsigned int write_hint, struct writeback_control *wbc)
 {
 	struct bio *bio;
 
@@ -3134,6 +3136,8 @@ static int submit_bh_wbc(int op, int op_flags, struct buffer_head *bh,
 		op_flags |= REQ_META;
 	if (buffer_prio(bh))
 		op_flags |= REQ_PRIO;
+
+	op_flags |= write_hint_to_opf(write_hint);
 	bio_set_op_attrs(bio, op, op_flags);
 
 	submit_bio(bio);
@@ -3142,7 +3146,7 @@ static int submit_bh_wbc(int op, int op_flags, struct buffer_head *bh,
 
 int submit_bh(int op, int op_flags, struct buffer_head *bh)
 {
-	return submit_bh_wbc(op, op_flags, bh, NULL);
+	return submit_bh_wbc(op, op_flags, bh, 0, NULL);
 }
 EXPORT_SYMBOL(submit_bh);
 
diff --git a/fs/mpage.c b/fs/mpage.c
index 9524fdde00c2..d8a750873bf4 100644
--- a/fs/mpage.c
+++ b/fs/mpage.c
@@ -615,6 +615,7 @@ static int __mpage_writepage(struct page *page, struct writeback_control *wbc,
 			goto confused;
 
 		wbc_init_bio(wbc, bio);
+		bio->bi_opf |= write_hint_to_opf(inode_write_hint(inode));
 	}
 
 	/*
-- 
2.7.4
