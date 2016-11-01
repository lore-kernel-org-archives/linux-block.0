Return-Path: <prvs=011358c635=axboe@fb.com>
From: Jens Axboe <axboe@fb.com>
To: <axboe@kernel.dk>, <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>
CC: <jack@suse.cz>, <hch@lst.de>, Jens Axboe <axboe@fb.com>
Subject: [PATCH 2/8] writeback: add wbc_to_write_flags()
Date: Tue, 1 Nov 2016 15:08:45 -0600
Message-ID: <1478034531-28559-3-git-send-email-axboe@fb.com>
In-Reply-To: <1478034531-28559-1-git-send-email-axboe@fb.com>
References: <1478034531-28559-1-git-send-email-axboe@fb.com>
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
 fs/xfs/xfs_aops.c         | 8 ++------
 include/linux/writeback.h | 9 +++++++++
 mm/page_io.c              | 5 +----
 8 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index bc7c2bb30a9b..af5776da814a 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -1697,7 +1697,7 @@ int __block_write_full_page(struct inode *inode, struct page *page,
 	struct buffer_head *bh, *head;
 	unsigned int blocksize, bbits;
 	int nr_underway = 0;
-	int write_flags = (wbc->sync_mode == WB_SYNC_ALL ? REQ_SYNC : 0);
+	int write_flags = wbc_to_write_flags(wbc);
 
 	head = create_page_buffers(page, inode,
 					(1 << BH_Dirty)|(1 << BH_Uptodate));
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index b80bf10603d7..9e5561fa4cb6 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1249,7 +1249,7 @@ static int f2fs_write_data_page(struct page *page,
 		.sbi = sbi,
 		.type = DATA,
 		.op = REQ_OP_WRITE,
-		.op_flags = (wbc->sync_mode == WB_SYNC_ALL) ? REQ_SYNC : 0,
+		.op_flags = wbc_to_write_flags(wbc),
 		.page = page,
 		.encrypted_page = NULL,
 	};
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 932f3f8bb57b..d1e29deb4598 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1570,7 +1570,7 @@ static int f2fs_write_node_page(struct page *page,
 		.sbi = sbi,
 		.type = NODE,
 		.op = REQ_OP_WRITE,
-		.op_flags = (wbc->sync_mode == WB_SYNC_ALL) ? REQ_SYNC : 0,
+		.op_flags = wbc_to_write_flags(wbc),
 		.page = page,
 		.encrypted_page = NULL,
 	};
diff --git a/fs/gfs2/meta_io.c b/fs/gfs2/meta_io.c
index e562b1191c9c..49db8ef13fdf 100644
--- a/fs/gfs2/meta_io.c
+++ b/fs/gfs2/meta_io.c
@@ -37,8 +37,7 @@ static int gfs2_aspace_writepage(struct page *page, struct writeback_control *wb
 {
 	struct buffer_head *bh, *head;
 	int nr_underway = 0;
-	int write_flags = REQ_META | REQ_PRIO |
-		(wbc->sync_mode == WB_SYNC_ALL ? REQ_SYNC : 0);
+	int write_flags = REQ_META | REQ_PRIO | wbc_to_write_flags(wbc);
 
 	BUG_ON(!PageLocked(page));
 	BUG_ON(!page_has_buffers(page));
diff --git a/fs/mpage.c b/fs/mpage.c
index f35e2819d0c6..98fc11aa7e0b 100644
--- a/fs/mpage.c
+++ b/fs/mpage.c
@@ -489,7 +489,7 @@ static int __mpage_writepage(struct page *page, struct writeback_control *wbc,
 	struct buffer_head map_bh;
 	loff_t i_size = i_size_read(inode);
 	int ret = 0;
-	int op_flags = (wbc->sync_mode == WB_SYNC_ALL ? REQ_SYNC : 0);
+	int op_flags = wbc_to_write_flags(wbc);
 
 	if (page_has_buffers(page)) {
 		struct buffer_head *head = page_buffers(page);
diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index 594e02c485b2..6be5204a06d3 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -495,9 +495,7 @@ xfs_submit_ioend(
 
 	ioend->io_bio->bi_private = ioend;
 	ioend->io_bio->bi_end_io = xfs_end_bio;
-	ioend->io_bio->bi_opf = REQ_OP_WRITE;
-	if (wbc->sync_mode == WB_SYNC_ALL)
-		ioend->io_bio->bi_opf |= REQ_SYNC;
+	ioend->io_bio->bi_opf = REQ_OP_WRITE | wbc_to_write_flags(wbc);
 
 	/*
 	 * If we are failing the IO now, just mark the ioend with an
@@ -569,9 +567,7 @@ xfs_chain_bio(
 
 	bio_chain(ioend->io_bio, new);
 	bio_get(ioend->io_bio);		/* for xfs_destroy_ioend */
-	ioend->io_bio->bi_opf = REQ_OP_WRITE;
-	if (wbc->sync_mode == WB_SYNC_ALL)
-		ioend->io_bio->bi_opf |= REQ_SYNC;
+	ioend->io_bio->bi_opf = REQ_OP_WRITE | wbc_to_write_flags(wbc);
 	submit_bio(ioend->io_bio);
 	ioend->io_bio = new;
 }
diff --git a/include/linux/writeback.h b/include/linux/writeback.h
index e4c38703bf4e..50c96ee8108f 100644
--- a/include/linux/writeback.h
+++ b/include/linux/writeback.h
@@ -9,6 +9,7 @@
 #include <linux/fs.h>
 #include <linux/flex_proportions.h>
 #include <linux/backing-dev-defs.h>
+#include <linux/blk_types.h>
 
 struct bio;
 
@@ -102,6 +103,14 @@ struct writeback_control {
 #endif
 };
 
+static inline int wbc_to_write_flags(struct writeback_control *wbc)
+{
+	if (wbc->sync_mode == WB_SYNC_ALL)
+		return REQ_SYNC;
+
+	return 0;
+}
+
 /*
  * A wb_domain represents a domain that wb's (bdi_writeback's) belong to
  * and are measured against each other in.  There always is one global
diff --git a/mm/page_io.c b/mm/page_io.c
index a2651f58c86a..23f6d0d3470f 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -320,10 +320,7 @@ int __swap_writepage(struct page *page, struct writeback_control *wbc,
 		ret = -ENOMEM;
 		goto out;
 	}
-	if (wbc->sync_mode == WB_SYNC_ALL)
-		bio_set_op_attrs(bio, REQ_OP_WRITE, REQ_SYNC);
-	else
-		bio_set_op_attrs(bio, REQ_OP_WRITE, 0);
+	bio->bi_opf = REQ_OP_WRITE | wbc_to_write_flags(wbc);
 	count_vm_event(PSWPOUT);
 	set_page_writeback(page);
 	unlock_page(page);
-- 
2.7.4
