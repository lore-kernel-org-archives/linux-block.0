Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
To: linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org
Cc: adilger@dilger.ca,
	hch@infradead.org,
	martin.petersen@oracle.com,
	linux-nvme@lists.infradead.org,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 2/9] block: add support for write hints in a bio
Date: Mon, 19 Jun 2017 11:04:55 -0600
Message-Id: <1497891902-25737-3-git-send-email-axboe@kernel.dk>
In-Reply-To: <1497891902-25737-1-git-send-email-axboe@kernel.dk>
References: <1497891902-25737-1-git-send-email-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

No functional changes in this patch, we just set aside 3 bits
in the bio/request flags, which can be used to hold a WRITE_LIFE_*
life time hint.

Ensure that we don't merge requests that have different life time
hints assigned to them.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-merge.c         | 16 ++++++++++++++++
 include/linux/blk_types.h | 20 ++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index cea544ec5d96..17cd0c3f872d 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -670,6 +670,14 @@ static struct request *attempt_merge(struct request_queue *q,
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
@@ -788,6 +796,14 @@ bool blk_rq_merge_ok(struct request *rq, struct bio *bio)
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
index dcd45b15a3a5..fde216924aa3 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -7,6 +7,7 @@
 
 #include <linux/types.h>
 #include <linux/bvec.h>
+#include <linux/fs.h>
 
 struct bio_set;
 struct bio;
@@ -220,6 +221,9 @@ enum req_flag_bits {
 	__REQ_PREFLUSH,		/* request for cache flush */
 	__REQ_RAHEAD,		/* read ahead, can fail anytime */
 	__REQ_BACKGROUND,	/* background IO */
+	__REQ_WRITE_HINT_SHIFT,	/* 3 bits for life time hint */
+	__REQ_WRITE_HINT_PAD1,
+	__REQ_WRITE_HINT_PAD2,
 
 	/* command specific flags for REQ_OP_WRITE_ZEROES: */
 	__REQ_NOUNMAP,		/* do not free blocks when zeroing */
@@ -240,6 +244,12 @@ enum req_flag_bits {
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
 
@@ -331,4 +341,14 @@ struct blk_rq_stat {
 	u64 batch;
 };
 
+static inline unsigned int write_hint_to_opf(enum rw_hint hint)
+{
+	return hint << __REQ_WRITE_HINT_SHIFT;
+}
+
+static inline enum rw_hint opf_to_write_hint(unsigned int opf)
+{
+	return (opf & REQ_WRITE_LIFE_MASK) >> __REQ_WRITE_HINT_SHIFT;
+}
+
 #endif /* __LINUX_BLK_TYPES_H */
-- 
2.7.4
