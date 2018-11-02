Return-Path: <jianchao.w.wang@oracle.com>
From: Jianchao Wang <jianchao.w.wang@oracle.com>
To: axboe@kernel.dk
Cc: ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V4 3/5] blk-mq: fix issue directly case when q is stopped or quiesced
Date: Fri,  2 Nov 2018 15:08:54 +0800
Message-Id: <1541142536-1431-4-git-send-email-jianchao.w.wang@oracle.com>
In-Reply-To: <1541142536-1431-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1541142536-1431-1-git-send-email-jianchao.w.wang@oracle.com>
List-ID: <linux-block@vger.kernel.org>

When try to issue request directly, if the queue is stopped or
quiesced, 'bypass' will be ignored and return BLK_STS_OK to caller
to avoid it dispatch request again. Then the request will be
inserted with blk_mq_sched_insert_request. This is not correct
for dm-rq case where we should avoid to pass through the underlying
path's io scheduler.

To fix it, add new mq_issue_decision entry MQ_ISSUE_INSERT_DISPATCH
for above case where the request need to be inserted forcibly.
And use blk_mq_request_bypass_insert to insert the request into
hctx->dispatch directly.

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---
 block/blk-mq.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 962fdfc..a0b9b6c 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1731,12 +1731,13 @@ static blk_status_t __blk_mq_issue_directly(struct blk_mq_hw_ctx *hctx,
 
 enum mq_issue_decision {
 	MQ_ISSUE_INSERT_QUEUE,
+	MQ_ISSUE_INSERT_DISPATCH,
 	MQ_ISSUE_END_REQUEST,
 	MQ_ISSUE_DO_NOTHING,
 };
 
 static inline enum mq_issue_decision
-	blk_mq_make_dicision(blk_status_t ret, bool bypass)
+	blk_mq_make_dicision(blk_status_t ret, bool bypass, bool force)
 {
 	enum mq_issue_decision dec;
 
@@ -1746,7 +1747,10 @@ static inline enum mq_issue_decision
 		break;
 	case BLK_STS_DEV_RESOURCE:
 	case BLK_STS_RESOURCE:
-		dec = bypass ? MQ_ISSUE_DO_NOTHING : MQ_ISSUE_INSERT_QUEUE;
+		if (force)
+			dec = bypass ? MQ_ISSUE_INSERT_DISPATCH : MQ_ISSUE_INSERT_QUEUE;
+		else
+			dec = bypass ? MQ_ISSUE_DO_NOTHING : MQ_ISSUE_INSERT_QUEUE;
 		break;
 	default:
 		dec = bypass ? MQ_ISSUE_DO_NOTHING : MQ_ISSUE_END_REQUEST;
@@ -1762,7 +1766,7 @@ static blk_status_t blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
 						bool bypass)
 {
 	struct request_queue *q = rq->q;
-	bool run_queue = true;
+	bool run_queue = true, force = false;
 	blk_status_t ret = BLK_STS_RESOURCE;
 	enum mq_issue_decision dec;
 	int srcu_idx;
@@ -1778,7 +1782,7 @@ static blk_status_t blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
 	 */
 	if (blk_mq_hctx_stopped(hctx) || blk_queue_quiesced(q)) {
 		run_queue = false;
-		bypass = false;
+		force = true;
 		goto out_unlock;
 	}
 
@@ -1798,11 +1802,14 @@ static blk_status_t blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
 out_unlock:
 	hctx_unlock(hctx, srcu_idx);
 
-	dec = blk_mq_make_dicision(ret, bypass);
+	dec = blk_mq_make_dicision(ret, bypass, force);
 	switch(dec) {
 	case MQ_ISSUE_INSERT_QUEUE:
 		blk_mq_sched_insert_request(rq, false, run_queue, false);
 		break;
+	case MQ_ISSUE_INSERT_DISPATCH:
+		blk_mq_request_bypass_insert(rq, run_queue);
+		break;
 	case MQ_ISSUE_END_REQUEST:
 		blk_mq_end_request(rq, ret);
 		break;
-- 
2.7.4
