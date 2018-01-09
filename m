Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 2/4] block: add accessors for setting/querying request deadline
Date: Tue,  9 Jan 2018 11:27:00 -0700
Message-Id: <1515522422-21596-3-git-send-email-axboe@kernel.dk>
In-Reply-To: <1515522422-21596-1-git-send-email-axboe@kernel.dk>
References: <1515522422-21596-1-git-send-email-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

We reduce the resolution of request expiry, but since we're already
using jiffies for this where resolution depends on the kernel
configuration and since the timeout resolution is coarse anyway,
that should be fine.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-mq.c         |  2 +-
 block/blk-timeout.c    | 14 ++++++++------
 block/blk.h            | 13 +++++++++++++
 include/linux/blkdev.h |  4 +++-
 4 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index faa31814983c..d875c51bcff8 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -858,7 +858,7 @@ static void blk_mq_check_expired(struct blk_mq_hw_ctx *hctx,
 	while (true) {
 		start = read_seqcount_begin(&rq->gstate_seq);
 		gstate = READ_ONCE(rq->gstate);
-		deadline = rq->deadline;
+		deadline = blk_rq_deadline(rq);
 		if (!read_seqcount_retry(&rq->gstate_seq, start))
 			break;
 		cond_resched();
diff --git a/block/blk-timeout.c b/block/blk-timeout.c
index ebe99963386c..a05e3676d24a 100644
--- a/block/blk-timeout.c
+++ b/block/blk-timeout.c
@@ -112,7 +112,9 @@ static void blk_rq_timed_out(struct request *req)
 static void blk_rq_check_expired(struct request *rq, unsigned long *next_timeout,
 			  unsigned int *next_set)
 {
-	if (time_after_eq(jiffies, rq->deadline)) {
+	const unsigned long deadline = blk_rq_deadline(rq);
+
+	if (time_after_eq(jiffies, deadline)) {
 		list_del_init(&rq->timeout_list);
 
 		/*
@@ -120,8 +122,8 @@ static void blk_rq_check_expired(struct request *rq, unsigned long *next_timeout
 		 */
 		if (!blk_mark_rq_complete(rq))
 			blk_rq_timed_out(rq);
-	} else if (!*next_set || time_after(*next_timeout, rq->deadline)) {
-		*next_timeout = rq->deadline;
+	} else if (!*next_set || time_after(*next_timeout, deadline)) {
+		*next_timeout = deadline;
 		*next_set = 1;
 	}
 }
@@ -162,7 +164,7 @@ void blk_abort_request(struct request *req)
 		 * immediately and that scan sees the new timeout value.
 		 * No need for fancy synchronizations.
 		 */
-		req->deadline = jiffies;
+		blk_rq_set_deadline(req, jiffies);
 		mod_timer(&req->q->timeout, 0);
 	} else {
 		if (blk_mark_rq_complete(req))
@@ -213,7 +215,7 @@ void blk_add_timer(struct request *req)
 	if (!req->timeout)
 		req->timeout = q->rq_timeout;
 
-	req->deadline = jiffies + req->timeout;
+	blk_rq_set_deadline(req, jiffies + req->timeout);
 	req->rq_flags &= ~RQF_MQ_TIMEOUT_EXPIRED;
 
 	/*
@@ -228,7 +230,7 @@ void blk_add_timer(struct request *req)
 	 * than an existing one, modify the timer. Round up to next nearest
 	 * second.
 	 */
-	expiry = blk_rq_timeout(round_jiffies_up(req->deadline));
+	expiry = blk_rq_timeout(round_jiffies_up(blk_rq_deadline(req)));
 
 	if (!timer_pending(&q->timeout) ||
 	    time_before(expiry, q->timeout.expires)) {
diff --git a/block/blk.h b/block/blk.h
index eb306c52121e..8b26a8872e05 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -237,6 +237,19 @@ static inline void req_set_nomerge(struct request_queue *q, struct request *req)
 }
 
 /*
+ * Steal a bit from this field for legacy IO path atomic IO marking
+ */
+static inline void blk_rq_set_deadline(struct request *rq, unsigned long time)
+{
+	rq->__deadline = time & ~0x1;
+}
+
+static inline unsigned long blk_rq_deadline(struct request *rq)
+{
+	return rq->__deadline & ~0x1;
+}
+
+/*
  * Internal io_context interface
  */
 void get_io_context(struct io_context *ioc);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index ba31674d8581..aa6698cf483c 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -257,7 +257,9 @@ struct request {
 	struct u64_stats_sync aborted_gstate_sync;
 	u64 aborted_gstate;
 
-	unsigned long deadline;
+	/* access through blk_rq_set_deadline, blk_rq_deadline */
+	unsigned long __deadline;
+
 	struct list_head timeout_list;
 
 	/*
-- 
2.7.4
