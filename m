Return-Path: <prvs=80586c83e0=axboe@fb.com>
From: Jens Axboe <axboe@fb.com>
To: <axboe@kernel.dk>, <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>
CC: Jens Axboe <axboe@fb.com>
Subject: [PATCH 2/8] writeback: add wbc_to_write_flags()
Date: Wed, 7 Sep 2016 08:46:44 -0600
Message-ID: <1473259610-3295-3-git-send-email-axboe@fb.com>
In-Reply-To: <1473259610-3295-1-git-send-email-axboe@fb.com>
References: <1473259610-3295-1-git-send-email-axboe@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

Add wbc_to_write_flags(), which returns the write modifier flags to use,
based on a struct writeback_control. No functional changes in this
patch, but it prepares us for factoring other wbc fields for write type.

Signed-off-by: Jens Axboe <axboe@fb.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/buffer.c               | 2 +-
 fs/f2fs/data.c            | 2 +-
 fs/f2fs/node.c            | 2 +-
 fs/gfs2/meta_io.c         | 3 +--
 fs/mpage.c                | 2 +-
 fs/xfs/xfs_aops.c         | 7 +++----
 include/linux/writeback.h | 8 ++++++++
 7 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 9c8eb9b6db6a..6a5f1a01102e 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -1698,7 +1698,7 @@ int __block_write_full_page(struct inode *inode, struct page *page,
 	struct buffer_head *bh, *head;
 	unsigned int blocksize, bbits;
 	int nr_underway = 0;
-	int write_flags = (wbc->sync_mode == WB_SYNC_ALL ? WRITE_SYNC : 0);
+	int write_flags = wbc_to_write_flags(wbc);
 
 	head = create_page_buffers(page, inode,
 					(1 << BH_Dirty)|(1 << BH_Uptodate));
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index ccb401eebc11..cb0528b31eb0 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1240,7 +1240,7 @@ static int f2fs_write_data_page(struct page *page,
 		.sbi = sbi,
 		.type = DATA,
 		.op = REQ_OP_WRITE,
-		.op_flags = (wbc->sync_mode == WB_SYNC_ALL) ? WRITE_SYNC : 0,
+		.op_flags = wbc_to_write_flags(wbc),
 		.page = page,
 		.encrypted_page = NULL,
 	};
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index f75d197d5beb..c1713da2542f 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1561,7 +1561,7 @@ static int f2fs_write_node_page(struct page *page,
 		.sbi = sbi,
 		.type = NODE,
 		.op = REQ_OP_WRITE,
-		.op_flags = (wbc->sync_mode == WB_SYNC_ALL) ? WRITE_SYNC : 0,
+		.op_flags = wbc_to_write_flags(wbc),
 		.page = page,
 		.encrypted_page = NULL,
 	};
diff --git a/fs/gfs2/meta_io.c b/fs/gfs2/meta_io.c
index 950b8be68e41..7991c62e9d6f 100644
--- a/fs/gfs2/meta_io.c
+++ b/fs/gfs2/meta_io.c
@@ -37,8 +37,7 @@ static int gfs2_aspace_writepage(struct page *page, struct writeback_control *wb
 {
 	struct buffer_head *bh, *head;
 	int nr_underway = 0;
-	int write_flags = REQ_META | REQ_PRIO |
-		(wbc->sync_mode == WB_SYNC_ALL ? WRITE_SYNC : 0);
+	int write_flags = REQ_META | REQ_PRIO | wbc_to_write_flags(wbc);
 
 	BUG_ON(!PageLocked(page));
 	BUG_ON(!page_has_buffers(page));
diff --git a/fs/mpage.c b/fs/mpage.c
index d2413af0823a..d6f1afe3397a 100644
--- a/fs/mpage.c
+++ b/fs/mpage.c
@@ -489,7 +489,7 @@ static int __mpage_writepage(struct page *page, struct writeback_control *wbc,
 	struct buffer_head map_bh;
 	loff_t i_size = i_size_read(inode);
 	int ret = 0;
-	int op_flags = (wbc->sync_mode == WB_SYNC_ALL ?  WRITE_SYNC : 0);
+	int op_flags = wbc_to_write_flags(wbc);
 
 	if (page_has_buffers(page)) {
 		struct buffer_head *head = page_buffers(page);
diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index 7575cfc3ad15..a68645abde56 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -447,8 +447,8 @@ xfs_submit_ioend(
 
 	ioend->io_bio->bi_private = ioend;
 	ioend->io_bio->bi_end_io = xfs_end_bio;
-	bio_set_op_attrs(ioend->io_bio, REQ_OP_WRITE,
-			 (wbc->sync_mode == WB_SYNC_ALL) ? WRITE_SYNC : 0);
+	bio_set_op_attrs(ioend->io_bio, REQ_OP_WRITE, wbc_to_write_flags(wbc));
+
 	/*
 	 * If we are failing the IO now, just mark the ioend with an
 	 * error and finish it. This will run IO completion immediately
@@ -519,8 +519,7 @@ xfs_chain_bio(
 
 	bio_chain(ioend->io_bio, new);
 	bio_get(ioend->io_bio);		/* for xfs_destroy_ioend */
-	bio_set_op_attrs(ioend->io_bio, REQ_OP_WRITE,
-			  (wbc->sync_mode == WB_SYNC_ALL) ? WRITE_SYNC : 0);
+	bio_set_op_attrs(ioend->io_bio, REQ_OP_WRITE, wbc_to_write_flags(wbc));
 	submit_bio(ioend->io_bio);
 	ioend->io_bio = new;
 }
diff --git a/include/linux/writeback.h b/include/linux/writeback.h
index fc1e16c25a29..608afd39b1c2 100644
--- a/include/linux/writeback.h
+++ b/include/linux/writeback.h
@@ -100,6 +100,14 @@ struct writeback_control {
 #endif
 };
 
+static inline int wbc_to_write_flags(struct writeback_control *wbc)
+{
+	if (wbc->sync_mode == WB_SYNC_ALL)
+		return WRITE_SYNC;
+
+	return 0;
+}
+
 /*
  * A wb_domain represents a domain that wb's (bdi_writeback's) belong to
  * and are measured against each other in.  There always is one global
-- 
2.7.4
