Return-Path: <jianchao.w.wang@oracle.com>
From: Jianchao Wang <jianchao.w.wang@oracle.com>
To: axboe@kernel.dk
Cc: ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V5 6/6] blk-mq: replace and kill blk_mq_request_issue_directly
Date: Mon, 12 Nov 2018 17:23:29 +0800
Message-Id: <1542014609-1769-7-git-send-email-jianchao.w.wang@oracle.com>
In-Reply-To: <1542014609-1769-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1542014609-1769-1-git-send-email-jianchao.w.wang@oracle.com>
List-ID: <linux-block@vger.kernel.org>

Replace blk_mq_request_issue_directly with blk_mq_try_issue_directly
in blk_insert_cloned_request and remove blk_mq_request_issue_directly
as nobody uses it.

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---
 block/blk-core.c | 2 +-
 block/blk-mq.c   | 7 +------
 block/blk-mq.h   | 6 ++++--
 3 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index fdc0ad2..5cae9ef 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1436,7 +1436,7 @@ blk_status_t blk_insert_cloned_request(struct request_queue *q, struct request *
 	 * bypass a potential scheduler on the bottom device for
 	 * insert.
 	 */
-	return blk_mq_request_issue_directly(rq);
+	return blk_mq_try_issue_directly(rq->mq_hctx, rq, NULL, true);
 }
 EXPORT_SYMBOL_GPL(blk_insert_cloned_request);
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index f27d547..f016028 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1797,7 +1797,7 @@ static inline enum mq_issue_decision
 	return dec;
 }
 
-static blk_status_t blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
+blk_status_t blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
 						struct request *rq,
 						blk_qc_t *cookie,
 						bool bypass)
@@ -1871,11 +1871,6 @@ static blk_status_t blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
 	return BLK_STS_OK;
 }
 
-blk_status_t blk_mq_request_issue_directly(struct request *rq)
-{
-	return blk_mq_try_issue_directly(rq->mq_hctx, rq, NULL, true);
-}
-
 void blk_mq_try_issue_list_directly(struct blk_mq_hw_ctx *hctx,
 		struct list_head *list)
 {
diff --git a/block/blk-mq.h b/block/blk-mq.h
index facb6e9..deee3a4 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -62,8 +62,10 @@ void blk_mq_request_bypass_insert(struct request *rq, bool run_queue);
 void blk_mq_insert_requests(struct blk_mq_hw_ctx *hctx, struct blk_mq_ctx *ctx,
 				struct list_head *list);
 
-/* Used by blk_insert_cloned_request() to issue request directly */
-blk_status_t blk_mq_request_issue_directly(struct request *rq);
+blk_status_t blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
+				       struct request *rq,
+				       blk_qc_t *cookie,
+				       bool bypass);
 void blk_mq_try_issue_list_directly(struct blk_mq_hw_ctx *hctx,
 				    struct list_head *list);
 
-- 
2.7.4
