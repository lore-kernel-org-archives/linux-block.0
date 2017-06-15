Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
To: linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org
Cc: adilger@dilger.ca,
	hch@infradead.org,
	martin.petersen@oracle.com,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 01/11] block: add support for carrying stream information in a bio
Date: Wed, 14 Jun 2017 21:45:02 -0600
Message-Id: <1497498312-17704-2-git-send-email-axboe@kernel.dk>
In-Reply-To: <1497498312-17704-1-git-send-email-axboe@kernel.dk>
References: <1497498312-17704-1-git-send-email-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

No functional changes in this patch, we just add four flags
that will be used to denote a stream type, and ensure that we
don't merge across different stream types.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-merge.c         | 16 ++++++++++++++++
 include/linux/blk_types.h | 11 +++++++++++
 2 files changed, 27 insertions(+)

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
index 61339bc44400..57d1eb530799 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -201,6 +201,10 @@ enum req_flag_bits {
 	__REQ_PREFLUSH,		/* request for cache flush */
 	__REQ_RAHEAD,		/* read ahead, can fail anytime */
 	__REQ_BACKGROUND,	/* background IO */
+	__REQ_WRITE_SHORT,	/* short life time write */
+	__REQ_WRITE_MEDIUM,	/* medium life time write */
+	__REQ_WRITE_LONG,	/* long life time write */
+	__REQ_WRITE_EXTREME,	/* extremely long life time write */
 
 	/* command specific flags for REQ_OP_WRITE_ZEROES: */
 	__REQ_NOUNMAP,		/* do not free blocks when zeroing */
@@ -221,6 +225,13 @@ enum req_flag_bits {
 #define REQ_PREFLUSH		(1ULL << __REQ_PREFLUSH)
 #define REQ_RAHEAD		(1ULL << __REQ_RAHEAD)
 #define REQ_BACKGROUND		(1ULL << __REQ_BACKGROUND)
+#define REQ_WRITE_SHORT		(1ULL << __REQ_WRITE_SHORT)
+#define REQ_WRITE_MEDIUM	(1ULL << __REQ_WRITE_MEDIUM)
+#define REQ_WRITE_LONG		(1ULL << __REQ_WRITE_LONG)
+#define REQ_WRITE_EXTREME	(1ULL << __REQ_WRITE_EXTREME)
+
+#define REQ_WRITE_LIFE_MASK	(REQ_WRITE_SHORT | REQ_WRITE_MEDIUM | \
+					REQ_WRITE_LONG | REQ_WRITE_EXTREME)
 
 #define REQ_NOUNMAP		(1ULL << __REQ_NOUNMAP)
 
-- 
2.7.4
