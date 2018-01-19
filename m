Return-Path: <prvs=550bc9d12=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Mike Snitzer <snitzer@redhat.com>,
	Ming Lei <ming.lei@redhat.com>,
	Bart Van Assche <bart.vanassche@wdc.com>
Subject: [PATCH 1/3] blk-mq: Rename blk_mq_request_direct_issue() into blk_mq_request_issue_directly()
Date: Fri, 19 Jan 2018 08:58:54 -0800
Message-Id: <20180119165856.17677-2-bart.vanassche@wdc.com>
In-Reply-To: <20180119165856.17677-1-bart.vanassche@wdc.com>
References: <20180119165856.17677-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Most blk-mq functions have a name that follows the pattern blk_mq_${action}.
However, the function name blk_mq_request_direct_issue is an exception.
Hence rename this function. This patch does not change any functionality.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
---
 block/blk-core.c | 2 +-
 block/blk-mq.c   | 4 ++--
 block/blk-mq.h   | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 4ae295c1be2d..5c21d6b97985 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -2525,7 +2525,7 @@ blk_status_t blk_insert_cloned_request(struct request_queue *q, struct request *
 		 * bypass a potential scheduler on the bottom device for
 		 * insert.
 		 */
-		return blk_mq_request_direct_issue(rq);
+		return blk_mq_request_issue_directly(rq);
 	}
 
 	spin_lock_irqsave(q->queue_lock, flags);
diff --git a/block/blk-mq.c b/block/blk-mq.c
index f7515dd95a36..6859b5492509 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1787,7 +1787,7 @@ static blk_status_t __blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
 	 * RCU or SRCU read lock is needed before checking quiesced flag.
 	 *
 	 * When queue is stopped or quiesced, ignore 'bypass_insert' from
-	 * blk_mq_request_direct_issue(), and return BLK_STS_OK to caller,
+	 * blk_mq_request_issue_directly(), and return BLK_STS_OK to caller,
 	 * and avoid driver to try to dispatch again.
 	 */
 	if (blk_mq_hctx_stopped(hctx) || blk_queue_quiesced(q)) {
@@ -1835,7 +1835,7 @@ static void blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
 	hctx_unlock(hctx, srcu_idx);
 }
 
-blk_status_t blk_mq_request_direct_issue(struct request *rq)
+blk_status_t blk_mq_request_issue_directly(struct request *rq)
 {
 	blk_status_t ret;
 	int srcu_idx;
diff --git a/block/blk-mq.h b/block/blk-mq.h
index e3ebc93646ca..88c558f71819 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -75,7 +75,7 @@ void blk_mq_insert_requests(struct blk_mq_hw_ctx *hctx, struct blk_mq_ctx *ctx,
 				struct list_head *list);
 
 /* Used by blk_insert_cloned_request() to issue request directly */
-blk_status_t blk_mq_request_direct_issue(struct request *rq);
+blk_status_t blk_mq_request_issue_directly(struct request *rq);
 
 /*
  * CPU -> queue mappings
-- 
2.15.1
