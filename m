Return-Path: <jianchao.w.wang@oracle.com>
From: Jianchao Wang <jianchao.w.wang@oracle.com>
To: axboe@kernel.dk
Cc: ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V5 2/6] blk-mq: refactor the code of issue request directly
Date: Mon, 12 Nov 2018 17:23:25 +0800
Message-Id: <1542014609-1769-3-git-send-email-jianchao.w.wang@oracle.com>
In-Reply-To: <1542014609-1769-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1542014609-1769-1-git-send-email-jianchao.w.wang@oracle.com>
List-ID: <linux-block@vger.kernel.org>

Merge blk_mq_try_issue_directly and __blk_mq_try_issue_directly
into one interface to unify the interfaces to issue requests
directly. The merged interface takes over the requests totally,
it could insert, end or do nothing based on the return value of
.queue_rq and 'bypass' parameter. Then caller needn't any other
handling any more.

To make code clearer, introduce new helpers enum mq_issue_decision
and blk_mq_make_decision to decide how to handle the non-issued
requests.

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---
 block/blk-mq.c | 108 +++++++++++++++++++++++++++++++++------------------------
 1 file changed, 63 insertions(+), 45 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 364a53f..48b7a7c 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1766,77 +1766,95 @@ static blk_status_t __blk_mq_issue_directly(struct blk_mq_hw_ctx *hctx,
 	return ret;
 }
 
-static blk_status_t __blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
+enum mq_issue_decision {
+	MQ_ISSUE_INSERT_QUEUE,
+	MQ_ISSUE_END_REQUEST,
+	MQ_ISSUE_DO_NOTHING,
+};
+
+static inline enum mq_issue_decision
+	blk_mq_make_dicision(blk_status_t ret, bool bypass)
+{
+	enum mq_issue_decision dec;
+
+	switch(ret) {
+	case BLK_STS_OK:
+		dec = MQ_ISSUE_DO_NOTHING;
+		break;
+	case BLK_STS_DEV_RESOURCE:
+	case BLK_STS_RESOURCE:
+		dec = bypass ? MQ_ISSUE_DO_NOTHING : MQ_ISSUE_INSERT_QUEUE;
+		break;
+	default:
+		dec = bypass ? MQ_ISSUE_DO_NOTHING : MQ_ISSUE_END_REQUEST;
+		break;
+	}
+
+	return dec;
+}
+
+static blk_status_t blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
 						struct request *rq,
 						blk_qc_t *cookie,
-						bool bypass_insert)
+						bool bypass)
 {
 	struct request_queue *q = rq->q;
 	bool run_queue = true;
+	blk_status_t ret = BLK_STS_RESOURCE;
+	enum mq_issue_decision dec;
+	int srcu_idx;
 
+	hctx_lock(hctx, &srcu_idx);
 	/*
-	 * RCU or SRCU read lock is needed before checking quiesced flag.
+	 * hctx_lock is needed before checking quiesced flag.
 	 *
-	 * When queue is stopped or quiesced, ignore 'bypass_insert' from
-	 * blk_mq_request_issue_directly(), and return BLK_STS_OK to caller,
-	 * and avoid driver to try to dispatch again.
+	 * When queue is stopped or quiesced, ignore 'bypass', insert
+	 * and return BLK_STS_OK to caller, and avoid driver to try to
+	 * dispatch again.
 	 */
 	if (blk_mq_hctx_stopped(hctx) || blk_queue_quiesced(q)) {
 		run_queue = false;
-		bypass_insert = false;
-		goto insert;
+		bypass = false;
+		goto out_unlock;
 	}
 
-	if (q->elevator && !bypass_insert)
-		goto insert;
+	/*
+	 * Bypass the potential scheduler on the bottom device.
+	 */
+	if (q->elevator && !bypass)
+		goto out_unlock;
 
 	if (!blk_mq_get_dispatch_budget(hctx))
-		goto insert;
+		goto out_unlock;
 
 	if (!blk_mq_get_driver_tag(rq)) {
 		blk_mq_put_dispatch_budget(hctx);
-		goto insert;
+		goto out_unlock;
 	}
 
-	return __blk_mq_issue_directly(hctx, rq, cookie);
-insert:
-	if (bypass_insert)
-		return BLK_STS_RESOURCE;
-
-	blk_mq_sched_insert_request(rq, false, run_queue, false);
-	return BLK_STS_OK;
-}
-
-static void blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
-		struct request *rq, blk_qc_t *cookie)
-{
-	blk_status_t ret;
-	int srcu_idx;
+	ret = __blk_mq_issue_directly(hctx, rq, cookie);
 
-	might_sleep_if(hctx->flags & BLK_MQ_F_BLOCKING);
-
-	hctx_lock(hctx, &srcu_idx);
+out_unlock:
+	hctx_unlock(hctx, srcu_idx);
 
-	ret = __blk_mq_try_issue_directly(hctx, rq, cookie, false);
-	if (ret == BLK_STS_RESOURCE || ret == BLK_STS_DEV_RESOURCE)
-		blk_mq_sched_insert_request(rq, false, true, false);
-	else if (ret != BLK_STS_OK)
+	dec = blk_mq_make_dicision(ret, bypass);
+	switch(dec) {
+	case MQ_ISSUE_INSERT_QUEUE:
+		blk_mq_sched_insert_request(rq, false, run_queue, false);
+		break;
+	case MQ_ISSUE_END_REQUEST:
 		blk_mq_end_request(rq, ret);
+		break;
+	default:
+		return ret;
+	}
 
-	hctx_unlock(hctx, srcu_idx);
+	return BLK_STS_OK;
 }
 
 blk_status_t blk_mq_request_issue_directly(struct request *rq)
 {
-	blk_status_t ret;
-	int srcu_idx;
-	struct blk_mq_hw_ctx *hctx = rq->mq_hctx;
-
-	hctx_lock(hctx, &srcu_idx);
-	ret = __blk_mq_try_issue_directly(hctx, rq, NULL, true);
-	hctx_unlock(hctx, srcu_idx);
-
-	return ret;
+	return blk_mq_try_issue_directly(rq->mq_hctx, rq, NULL, true);
 }
 
 void blk_mq_try_issue_list_directly(struct blk_mq_hw_ctx *hctx,
@@ -1957,13 +1975,13 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
 		if (same_queue_rq) {
 			data.hctx = same_queue_rq->mq_hctx;
 			blk_mq_try_issue_directly(data.hctx, same_queue_rq,
-					&cookie);
+					&cookie, false);
 		}
 	} else if ((q->nr_hw_queues > 1 && is_sync) || (!q->elevator &&
 			!data.hctx->dispatch_busy)) {
 		blk_mq_put_ctx(data.ctx);
 		blk_mq_bio_to_request(rq, bio);
-		blk_mq_try_issue_directly(data.hctx, rq, &cookie);
+		blk_mq_try_issue_directly(data.hctx, rq, &cookie, false);
 	} else {
 		blk_mq_put_ctx(data.ctx);
 		blk_mq_bio_to_request(rq, bio);
-- 
2.7.4
