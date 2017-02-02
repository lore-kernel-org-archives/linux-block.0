Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:46070 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751817AbdBBQGS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 2 Feb 2017 11:06:18 -0500
From: Jens Axboe <axboe@fb.com>
To: <linux-block@vger.kernel.org>
CC: <paolo.valente@linaro.org>, <osandov@osandov.com>,
        Jens Axboe <axboe@fb.com>
Subject: [PATCH 1/2] blk-merge: return the merged request
Date: Thu, 2 Feb 2017 09:06:12 -0700
Message-ID: <1486051573-13445-2-git-send-email-axboe@fb.com>
In-Reply-To: <1486051573-13445-1-git-send-email-axboe@fb.com>
References: <1486051573-13445-1-git-send-email-axboe@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

When we attempt to merge request-to-request, we return a 0/1 if we
ended up merging or not. Change that to return the pointer to the
request that we freed. We will use this to move the freeing of
that request out of the merge logic, so that callers can drop
locks before freeing the request.

There should be no functional changes in this patch.

Signed-off-by: Jens Axboe <axboe@fb.com>
---
 block/blk-merge.c | 31 ++++++++++++++++---------------
 block/blk.h       |  4 ++--
 2 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 6aa43dec5af4..3826fc32b72c 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -659,31 +659,32 @@ static void blk_account_io_merge(struct request *req)
 }
 
 /*
- * Has to be called with the request spinlock acquired
+ * For non-mq, this has to be called with the request spinlock acquired.
+ * For mq with scheduling, the appropriate queue wide lock should be held.
  */
-static int attempt_merge(struct request_queue *q, struct request *req,
-			  struct request *next)
+static struct request *attempt_merge(struct request_queue *q,
+				     struct request *req, struct request *next)
 {
 	if (!rq_mergeable(req) || !rq_mergeable(next))
-		return 0;
+		return NULL;
 
 	if (req_op(req) != req_op(next))
-		return 0;
+		return NULL;
 
 	/*
 	 * not contiguous
 	 */
 	if (blk_rq_pos(req) + blk_rq_sectors(req) != blk_rq_pos(next))
-		return 0;
+		return NULL;
 
 	if (rq_data_dir(req) != rq_data_dir(next)
 	    || req->rq_disk != next->rq_disk
 	    || req_no_special_merge(next))
-		return 0;
+		return NULL;
 
 	if (req_op(req) == REQ_OP_WRITE_SAME &&
 	    !blk_write_same_mergeable(req->bio, next->bio))
-		return 0;
+		return NULL;
 
 	/*
 	 * If we are allowed to merge, then append bio list
@@ -692,7 +693,7 @@ static int attempt_merge(struct request_queue *q, struct request *req,
 	 * counts here.
 	 */
 	if (!ll_merge_requests_fn(q, req, next))
-		return 0;
+		return NULL;
 
 	/*
 	 * If failfast settings disagree or any of the two is already
@@ -735,27 +736,27 @@ static int attempt_merge(struct request_queue *q, struct request *req,
 	/* owner-ship of bio passed from next to req */
 	next->bio = NULL;
 	__blk_put_request(q, next);
-	return 1;
+	return next;
 }
 
-int attempt_back_merge(struct request_queue *q, struct request *rq)
+struct request *attempt_back_merge(struct request_queue *q, struct request *rq)
 {
 	struct request *next = elv_latter_request(q, rq);
 
 	if (next)
 		return attempt_merge(q, rq, next);
 
-	return 0;
+	return NULL;
 }
 
-int attempt_front_merge(struct request_queue *q, struct request *rq)
+struct request *attempt_front_merge(struct request_queue *q, struct request *rq)
 {
 	struct request *prev = elv_former_request(q, rq);
 
 	if (prev)
 		return attempt_merge(q, prev, rq);
 
-	return 0;
+	return NULL;
 }
 
 int blk_attempt_req_merge(struct request_queue *q, struct request *rq,
@@ -767,7 +768,7 @@ int blk_attempt_req_merge(struct request_queue *q, struct request *rq,
 		if (!e->type->ops.sq.elevator_allow_rq_merge_fn(q, rq, next))
 			return 0;
 
-	return attempt_merge(q, rq, next);
+	return attempt_merge(q, rq, next) != NULL;
 }
 
 bool blk_rq_merge_ok(struct request *rq, struct bio *bio)
diff --git a/block/blk.h b/block/blk.h
index c1bd4bf9e645..918cea38d51e 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -204,8 +204,8 @@ int ll_back_merge_fn(struct request_queue *q, struct request *req,
 		     struct bio *bio);
 int ll_front_merge_fn(struct request_queue *q, struct request *req, 
 		      struct bio *bio);
-int attempt_back_merge(struct request_queue *q, struct request *rq);
-int attempt_front_merge(struct request_queue *q, struct request *rq);
+struct request *attempt_back_merge(struct request_queue *q, struct request *rq);
+struct request *attempt_front_merge(struct request_queue *q, struct request *rq);
 int blk_attempt_req_merge(struct request_queue *q, struct request *rq,
 				struct request *next);
 void blk_recalc_rq_segments(struct request *rq);
-- 
2.7.4

