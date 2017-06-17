Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
To: linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org
Cc: adilger@dilger.ca,
	hch@infradead.org,
	martin.petersen@oracle.com,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 02/11] block: add support for write hints in a bio
Date: Sat, 17 Jun 2017 13:59:45 -0600
Message-Id: <1497729594-4707-3-git-send-email-axboe@kernel.dk>
In-Reply-To: <1497729594-4707-1-git-send-email-axboe@kernel.dk>
References: <1497729594-4707-1-git-send-email-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

No functional changes in this patch, we just set aside 3 bits
in the bio/request flags, which can be used to hold a WRITE_HINT_*
life time hint.

Ensure that we don't merge requests that have different life time
hints assigned to them.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-merge.c         | 16 ++++++++++++++++
 include/linux/blk_types.h | 15 +++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 3990ae406341..7d299df3b12b 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -693,6 +693,14 @@ static struct request *attempt_merge(struct request_queue *q,
 		return NULL;
 
 	/*
+	 * Don't allow merge of different streams, or for a stream with
+	 * non-stream IO.
+	 */
+	if ((req->cmd_flags & REQ_WRITE_LIFE_MASK) !=
+	    (next->cmd_flags & REQ_WRITE_LIFE_MASK))
+		return NULL;
+
+	/*
 	 * If we are allowed to merge, then append bio list
 	 * from next to rq and release next. merge_requests_fn
 	 * will have updated segment counts, update sector
@@ -811,6 +819,14 @@ bool blk_rq_merge_ok(struct request *rq, struct bio *bio)
 	    !blk_write_same_mergeable(rq->bio, bio))
 		return false;
 
+	/*
+	 * Don't allow merge of different streams, or for a stream with
+	 * non-stream IO.
+	 */
+	if ((rq->cmd_flags & REQ_WRITE_LIFE_MASK) !=
+	    (bio->bi_opf & REQ_WRITE_LIFE_MASK))
+		return false;
+
 	return true;
 }
 
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 61339bc44400..0dd8d569d52f 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -7,6 +7,7 @@
 
 #include <linux/types.h>
 #include <linux/bvec.h>
+#include <linux/fs.h>
 
 struct bio_set;
 struct bio;
@@ -201,6 +202,9 @@ enum req_flag_bits {
 	__REQ_PREFLUSH,		/* request for cache flush */
 	__REQ_RAHEAD,		/* read ahead, can fail anytime */
 	__REQ_BACKGROUND,	/* background IO */
+	__REQ_WRITE_HINT_SHIFT,	/* 3 bits for life time hint */
+	__REQ_WRITE_HINT_PAD1,
+	__REQ_WRITE_HINT_PAD2,
 
 	/* command specific flags for REQ_OP_WRITE_ZEROES: */
 	__REQ_NOUNMAP,		/* do not free blocks when zeroing */
@@ -221,6 +225,12 @@ enum req_flag_bits {
 #define REQ_PREFLUSH		(1ULL << __REQ_PREFLUSH)
 #define REQ_RAHEAD		(1ULL << __REQ_RAHEAD)
 #define REQ_BACKGROUND		(1ULL << __REQ_BACKGROUND)
+#define REQ_WRITE_SHORT		(WRITE_LIFE_SHORT << __REQ_WRITE_HINT_SHIFT)
+#define REQ_WRITE_MEDIUM	(WRITE_LIFE_MEDIUM << __REQ_WRITE_HINT_SHIFT)
+#define REQ_WRITE_LONG		(WRITE_LIFE_LONG << __REQ_WRITE_HINT_SHIFT)
+#define REQ_WRITE_EXTREME	(WRITE_LIFE_EXTREME << __REQ_WRITE_HINT_SHIFT)
+
+#define REQ_WRITE_LIFE_MASK	(0x7 << __REQ_WRITE_HINT_SHIFT)
 
 #define REQ_NOUNMAP		(1ULL << __REQ_NOUNMAP)
 
@@ -312,4 +322,9 @@ struct blk_rq_stat {
 	u64 batch;
 };
 
+static inline unsigned int write_hint_to_opf(enum rw_hint hint)
+{
+	return hint << __REQ_WRITE_HINT_SHIFT;
+}
+
 #endif /* __LINUX_BLK_TYPES_H */
-- 
2.7.4
