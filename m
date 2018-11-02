Return-Path: <jianchao.w.wang@oracle.com>
From: Jianchao Wang <jianchao.w.wang@oracle.com>
To: axboe@kernel.dk
Cc: ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V4 1/5] blk-mq: make __blk_mq_issue_directly be able to accept NULL cookie pointer
Date: Fri,  2 Nov 2018 15:08:52 +0800
Message-Id: <1541142536-1431-2-git-send-email-jianchao.w.wang@oracle.com>
In-Reply-To: <1541142536-1431-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1541142536-1431-1-git-send-email-jianchao.w.wang@oracle.com>
List-ID: <linux-block@vger.kernel.org>

Make __blk_mq_issue_directly be able to accept a NULL cookie pointer
and remove the dummy unused_cookie in blk_mq_request_issue_directly.

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---
 block/blk-mq.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index dcf10e3..af5b591 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1700,8 +1700,6 @@ static blk_status_t __blk_mq_issue_directly(struct blk_mq_hw_ctx *hctx,
 	blk_qc_t new_cookie;
 	blk_status_t ret;
 
-	new_cookie = request_to_qc_t(hctx, rq);
-
 	/*
 	 * For OK queue, we are done. For error, caller may kill it.
 	 * Any other error (busy), just add it to our list as we
@@ -1711,19 +1709,23 @@ static blk_status_t __blk_mq_issue_directly(struct blk_mq_hw_ctx *hctx,
 	switch (ret) {
 	case BLK_STS_OK:
 		blk_mq_update_dispatch_busy(hctx, false);
-		*cookie = new_cookie;
+		new_cookie = request_to_qc_t(hctx, rq);
 		break;
 	case BLK_STS_RESOURCE:
 	case BLK_STS_DEV_RESOURCE:
 		blk_mq_update_dispatch_busy(hctx, true);
 		__blk_mq_requeue_request(rq);
+		new_cookie = BLK_QC_T_NONE;
 		break;
 	default:
 		blk_mq_update_dispatch_busy(hctx, false);
-		*cookie = BLK_QC_T_NONE;
+		new_cookie = BLK_QC_T_NONE;
 		break;
 	}
 
+	if (cookie)
+		*cookie = new_cookie;
+
 	return ret;
 }
 
@@ -1791,12 +1793,11 @@ blk_status_t blk_mq_request_issue_directly(struct request *rq)
 {
 	blk_status_t ret;
 	int srcu_idx;
-	blk_qc_t unused_cookie;
 	struct blk_mq_ctx *ctx = rq->mq_ctx;
 	struct blk_mq_hw_ctx *hctx = blk_mq_map_queue(rq->q, ctx->cpu);
 
 	hctx_lock(hctx, &srcu_idx);
-	ret = __blk_mq_try_issue_directly(hctx, rq, &unused_cookie, true);
+	ret = __blk_mq_try_issue_directly(hctx, rq, NULL, true);
 	hctx_unlock(hctx, srcu_idx);
 
 	return ret;
-- 
2.7.4
