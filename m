Return-Path: <jianchao.w.wang@oracle.com>
From: Jianchao Wang <jianchao.w.wang@oracle.com>
To: axboe@kernel.dk
Cc: ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V5 1/6] blk-mq: make __blk_mq_issue_directly be able to accept NULL cookie pointer
Date: Mon, 12 Nov 2018 17:23:24 +0800
Message-Id: <1542014609-1769-2-git-send-email-jianchao.w.wang@oracle.com>
In-Reply-To: <1542014609-1769-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1542014609-1769-1-git-send-email-jianchao.w.wang@oracle.com>
List-ID: <linux-block@vger.kernel.org>

Make __blk_mq_issue_directly be able to accept a NULL cookie pointer
and remove the dummy unused_cookie in blk_mq_request_issue_directly.

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---
 block/blk-mq.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 411be60..364a53f 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1736,11 +1736,9 @@ static blk_status_t __blk_mq_issue_directly(struct blk_mq_hw_ctx *hctx,
 		.rq = rq,
 		.last = true,
 	};
-	blk_qc_t new_cookie;
+	blk_qc_t new_cookie = BLK_QC_T_NONE;
 	blk_status_t ret;
 
-	new_cookie = request_to_qc_t(hctx, rq);
-
 	/*
 	 * For OK queue, we are done. For error, caller may kill it.
 	 * Any other error (busy), just add it to our list as we
@@ -1750,7 +1748,7 @@ static blk_status_t __blk_mq_issue_directly(struct blk_mq_hw_ctx *hctx,
 	switch (ret) {
 	case BLK_STS_OK:
 		blk_mq_update_dispatch_busy(hctx, false);
-		*cookie = new_cookie;
+		new_cookie = request_to_qc_t(hctx, rq);
 		break;
 	case BLK_STS_RESOURCE:
 	case BLK_STS_DEV_RESOURCE:
@@ -1759,10 +1757,12 @@ static blk_status_t __blk_mq_issue_directly(struct blk_mq_hw_ctx *hctx,
 		break;
 	default:
 		blk_mq_update_dispatch_busy(hctx, false);
-		*cookie = BLK_QC_T_NONE;
 		break;
 	}
 
+	if (cookie)
+		*cookie = new_cookie;
+
 	return ret;
 }
 
@@ -1830,11 +1830,10 @@ blk_status_t blk_mq_request_issue_directly(struct request *rq)
 {
 	blk_status_t ret;
 	int srcu_idx;
-	blk_qc_t unused_cookie;
 	struct blk_mq_hw_ctx *hctx = rq->mq_hctx;
 
 	hctx_lock(hctx, &srcu_idx);
-	ret = __blk_mq_try_issue_directly(hctx, rq, &unused_cookie, true);
+	ret = __blk_mq_try_issue_directly(hctx, rq, NULL, true);
 	hctx_unlock(hctx, srcu_idx);
 
 	return ret;
-- 
2.7.4
