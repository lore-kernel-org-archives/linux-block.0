Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:46071 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751817AbdBBQGU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 2 Feb 2017 11:06:20 -0500
From: Jens Axboe <axboe@fb.com>
To: <linux-block@vger.kernel.org>
CC: <paolo.valente@linaro.org>, <osandov@osandov.com>,
        Jens Axboe <axboe@fb.com>
Subject: [PATCH 2/2] block: free merged request in the caller
Date: Thu, 2 Feb 2017 09:06:13 -0700
Message-ID: <1486051573-13445-3-git-send-email-axboe@fb.com>
In-Reply-To: <1486051573-13445-1-git-send-email-axboe@fb.com>
References: <1486051573-13445-1-git-send-email-axboe@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

If we end up doing a request-to-request merge when we have completed
a bio-to-request merge, we free the request from deep down in that
path. For blk-mq-sched, the merge path has to hold the appropriate
lock, but we don't need it for freeing the request. And in fact
holding the lock is problematic, since we are now calling the
mq sched put_rq_private() hook with the lock held. Other call paths
do not hold this lock.

Fix this inconsistency by ensuring that the caller frees a merged
request. Then we can do it outside of the lock, making it both more
efficient and fixing the blk-mq-sched problem of invoking parts of
the scheduler with an unknown lock state.

Reported-by: Paolo Valente <paolo.valente@linaro.org>
Signed-off-by: Jens Axboe <axboe@fb.com>
---
 block/blk-core.c     | 12 +++++++++---
 block/blk-merge.c    | 15 ++++++++++++---
 block/blk-mq-sched.c |  9 ++++++---
 block/blk-mq-sched.h |  3 ++-
 block/mq-deadline.c  |  8 ++++++--
 5 files changed, 35 insertions(+), 12 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index a5726e01f839..00c90f8cd682 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1591,7 +1591,7 @@ static blk_qc_t blk_queue_bio(struct request_queue *q, struct bio *bio)
 {
 	struct blk_plug *plug;
 	int el_ret, where = ELEVATOR_INSERT_SORT;
-	struct request *req;
+	struct request *req, *free;
 	unsigned int request_count = 0;
 	unsigned int wb_acct;
 
@@ -1632,15 +1632,21 @@ static blk_qc_t blk_queue_bio(struct request_queue *q, struct bio *bio)
 	if (el_ret == ELEVATOR_BACK_MERGE) {
 		if (bio_attempt_back_merge(q, req, bio)) {
 			elv_bio_merged(q, req, bio);
-			if (!attempt_back_merge(q, req))
+			free = attempt_back_merge(q, req);
+			if (!free)
 				elv_merged_request(q, req, el_ret);
+			else
+				__blk_put_request(q, free);
 			goto out_unlock;
 		}
 	} else if (el_ret == ELEVATOR_FRONT_MERGE) {
 		if (bio_attempt_front_merge(q, req, bio)) {
 			elv_bio_merged(q, req, bio);
-			if (!attempt_front_merge(q, req))
+			free = attempt_front_merge(q, req);
+			if (!free)
 				elv_merged_request(q, req, el_ret);
+			else
+				__blk_put_request(q, free);
 			goto out_unlock;
 		}
 	}
diff --git a/block/blk-merge.c b/block/blk-merge.c
index 3826fc32b72c..a373416dbc9a 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -733,9 +733,11 @@ static struct request *attempt_merge(struct request_queue *q,
 	if (blk_rq_cpu_valid(next))
 		req->cpu = next->cpu;
 
-	/* owner-ship of bio passed from next to req */
+	/*
+	 * ownership of bio passed from next to req, return 'next' for
+	 * the caller to free
+	 */
 	next->bio = NULL;
-	__blk_put_request(q, next);
 	return next;
 }
 
@@ -763,12 +765,19 @@ int blk_attempt_req_merge(struct request_queue *q, struct request *rq,
 			  struct request *next)
 {
 	struct elevator_queue *e = q->elevator;
+	struct request *free;
 
 	if (!e->uses_mq && e->type->ops.sq.elevator_allow_rq_merge_fn)
 		if (!e->type->ops.sq.elevator_allow_rq_merge_fn(q, rq, next))
 			return 0;
 
-	return attempt_merge(q, rq, next) != NULL;
+	free = attempt_merge(q, rq, next);
+	if (free) {
+		__blk_put_request(q, free);
+		return 1;
+	}
+
+	return 0;
 }
 
 bool blk_rq_merge_ok(struct request *rq, struct bio *bio)
diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 114814ec3d49..d93b56d53c4e 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -234,7 +234,8 @@ void blk_mq_sched_move_to_dispatch(struct blk_mq_hw_ctx *hctx,
 }
 EXPORT_SYMBOL_GPL(blk_mq_sched_move_to_dispatch);
 
-bool blk_mq_sched_try_merge(struct request_queue *q, struct bio *bio)
+bool blk_mq_sched_try_merge(struct request_queue *q, struct bio *bio,
+			    struct request **merged_request)
 {
 	struct request *rq;
 	int ret;
@@ -244,7 +245,8 @@ bool blk_mq_sched_try_merge(struct request_queue *q, struct bio *bio)
 		if (!blk_mq_sched_allow_merge(q, rq, bio))
 			return false;
 		if (bio_attempt_back_merge(q, rq, bio)) {
-			if (!attempt_back_merge(q, rq))
+			*merged_request = attempt_back_merge(q, rq);
+			if (!*merged_request)
 				elv_merged_request(q, rq, ret);
 			return true;
 		}
@@ -252,7 +254,8 @@ bool blk_mq_sched_try_merge(struct request_queue *q, struct bio *bio)
 		if (!blk_mq_sched_allow_merge(q, rq, bio))
 			return false;
 		if (bio_attempt_front_merge(q, rq, bio)) {
-			if (!attempt_front_merge(q, rq))
+			*merged_request = attempt_front_merge(q, rq);
+			if (!*merged_request)
 				elv_merged_request(q, rq, ret);
 			return true;
 		}
diff --git a/block/blk-mq-sched.h b/block/blk-mq-sched.h
index 9478aaeb48c5..3643686a54b8 100644
--- a/block/blk-mq-sched.h
+++ b/block/blk-mq-sched.h
@@ -16,7 +16,8 @@ void blk_mq_sched_put_request(struct request *rq);
 
 void blk_mq_sched_request_inserted(struct request *rq);
 bool blk_mq_sched_bypass_insert(struct blk_mq_hw_ctx *hctx, struct request *rq);
-bool blk_mq_sched_try_merge(struct request_queue *q, struct bio *bio);
+bool blk_mq_sched_try_merge(struct request_queue *q, struct bio *bio,
+				struct request **merged_request);
 bool __blk_mq_sched_bio_merge(struct request_queue *q, struct bio *bio);
 bool blk_mq_sched_try_insert_merge(struct request_queue *q, struct request *rq);
 void blk_mq_sched_restart_queues(struct blk_mq_hw_ctx *hctx);
diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index 49583536698c..682fa64f55ff 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -371,12 +371,16 @@ static bool dd_bio_merge(struct blk_mq_hw_ctx *hctx, struct bio *bio)
 {
 	struct request_queue *q = hctx->queue;
 	struct deadline_data *dd = q->elevator->elevator_data;
-	int ret;
+	struct request *free = NULL;
+	bool ret;
 
 	spin_lock(&dd->lock);
-	ret = blk_mq_sched_try_merge(q, bio);
+	ret = blk_mq_sched_try_merge(q, bio, &free);
 	spin_unlock(&dd->lock);
 
+	if (free)
+		blk_mq_free_request(free);
+
 	return ret;
 }
 
-- 
2.7.4

