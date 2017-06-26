Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	hch@lst.de,
	martin.petersen@oracle.com,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 2/9] block: add support for write hints in a bio
Date: Mon, 26 Jun 2017 09:37:53 -0600
Message-Id: <1498491480-16306-3-git-send-email-axboe@kernel.dk>
In-Reply-To: <1498491480-16306-1-git-send-email-axboe@kernel.dk>
References: <1498491480-16306-1-git-send-email-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

No functional changes in this patch, we just set aside 3 bits
in the bio/request flags, which can be used to hold a WRITE_LIFE_*
life time hint.

Ensure that we don't merge requests that have different life time
hints assigned to them.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-merge.c         | 16 ++++++++++++++++
 fs/inode.c                |  9 +++++++++
 include/linux/blk_types.h | 31 +++++++++++++++++++++++++++++++
 include/linux/fs.h        |  2 ++
 4 files changed, 58 insertions(+)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 5df13041b851..be1e955db75e 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -673,6 +673,14 @@ static struct request *attempt_merge(struct request_queue *q,
 		return NULL;
 
 	/*
+	 * Don't allow merge of different write hints, or for a hint with
+	 * non-hint IO.
+	 */
+	if ((req->cmd_flags & REQ_WRITE_LIFE_MASK) !=
+	    (next->cmd_flags & REQ_WRITE_LIFE_MASK))
+		return NULL;
+
+	/*
 	 * If we are allowed to merge, then append bio list
 	 * from next to rq and release next. merge_requests_fn
 	 * will have updated segment counts, update sector
@@ -791,6 +799,14 @@ bool blk_rq_merge_ok(struct request *rq, struct bio *bio)
 	    !blk_write_same_mergeable(rq->bio, bio))
 		return false;
 
+	/*
+	 * Don't allow merge of different write hints, or for a hint with
+	 * non-hint IO.
+	 */
+	if ((rq->cmd_flags & REQ_WRITE_LIFE_MASK) !=
+	    (bio->bi_opf & REQ_WRITE_LIFE_MASK))
+		return false;
+
 	return true;
 }
 
diff --git a/fs/inode.c b/fs/inode.c
index defb015a2c6d..66cc431c9a96 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -2131,3 +2131,12 @@ void inode_set_write_hint(struct inode *inode, enum rw_hint hint)
 		inode_unlock(inode);
 	}
 }
+
+/*
+ * Returns block write hint mask for the inode
+ */
+unsigned int inode_hint_to_opf(struct inode *inode)
+{
+	return write_hint_to_opf(inode_write_hint(inode));
+}
+EXPORT_SYMBOL(inode_hint_to_opf);
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index e210da6d14b8..0d44dce19d9f 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -7,6 +7,7 @@
 
 #include <linux/types.h>
 #include <linux/bvec.h>
+#include <linux/fs.h>
 
 struct bio_set;
 struct bio;
@@ -223,6 +224,10 @@ enum req_flag_bits {
 	__REQ_RAHEAD,		/* read ahead, can fail anytime */
 	__REQ_BACKGROUND,	/* background IO */
 
+	__REQ_WRITE_HINT_SHIFT,	/* 3 bits for life time hint */
+	__REQ_WRITE_HINT_PAD1,
+	__REQ_WRITE_HINT_PAD2,
+
 	/* command specific flags for REQ_OP_WRITE_ZEROES: */
 	__REQ_NOUNMAP,		/* do not free blocks when zeroing */
 
@@ -244,6 +249,13 @@ enum req_flag_bits {
 #define REQ_RAHEAD		(1ULL << __REQ_RAHEAD)
 #define REQ_BACKGROUND		(1ULL << __REQ_BACKGROUND)
 
+#define REQ_WRITE_SHORT		(WRITE_LIFE_SHORT << __REQ_WRITE_HINT_SHIFT)
+#define REQ_WRITE_MEDIUM	(WRITE_LIFE_MEDIUM << __REQ_WRITE_HINT_SHIFT)
+#define REQ_WRITE_LONG		(WRITE_LIFE_LONG << __REQ_WRITE_HINT_SHIFT)
+#define REQ_WRITE_EXTREME	(WRITE_LIFE_EXTREME << __REQ_WRITE_HINT_SHIFT)
+
+#define REQ_WRITE_LIFE_MASK	(0x7 << __REQ_WRITE_HINT_SHIFT)
+
 #define REQ_NOUNMAP		(1ULL << __REQ_NOUNMAP)
 #define REQ_NOWAIT		(1ULL << __REQ_NOWAIT)
 
@@ -335,4 +347,23 @@ struct blk_rq_stat {
 	u64 batch;
 };
 
+static inline unsigned int write_hint_to_opf(enum rw_hint hint)
+{
+	return hint << __REQ_WRITE_HINT_SHIFT;
+}
+
+/*
+ * Don't let drivers see WRITE_LIFE_NOT_SET, return NONE for that
+ */
+static inline enum rw_hint opf_to_write_hint(unsigned int opf)
+{
+	enum rw_hint ret;
+
+	ret = (opf & REQ_WRITE_LIFE_MASK) >> __REQ_WRITE_HINT_SHIFT;
+	if (ret == WRITE_LIFE_NOT_SET)
+		ret = WRITE_LIFE_NONE;
+
+	return ret;
+}
+
 #endif /* __LINUX_BLK_TYPES_H */
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 0ef5d110d2bc..86888a6ccad1 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1912,6 +1912,8 @@ static inline bool HAS_UNMAPPED_ID(struct inode *inode)
 	return !uid_valid(inode->i_uid) || !gid_valid(inode->i_gid);
 }
 
+extern unsigned int inode_hint_to_opf(struct inode *inode);
+
 static inline unsigned int write_hint_to_mask(enum rw_hint hint,
 					      unsigned int shift)
 {
-- 
2.7.4
