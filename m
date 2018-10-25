Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	linux-ide@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 28/28] block: get rid of blk_queued_rq()
Date: Thu, 25 Oct 2018 15:10:39 -0600
Message-Id: <20181025211039.11559-29-axboe@kernel.dk>
In-Reply-To: <20181025211039.11559-1-axboe@kernel.dk>
References: <20181025211039.11559-1-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

No point in hiding what this does, just open code it in the
one spot where we are still using it.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-mq.c         | 2 +-
 include/linux/blkdev.h | 2 --
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index d43c9232c77c..21e4147c4810 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -692,7 +692,7 @@ void blk_mq_requeue_request(struct request *rq, bool kick_requeue_list)
 	/* this request will be re-inserted to io scheduler queue */
 	blk_mq_sched_requeue_request(rq);
 
-	BUG_ON(blk_queued_rq(rq));
+	BUG_ON(!list_empty(&rq->queuelist));
 	blk_mq_add_to_requeue_list(rq, true, kick_requeue_list);
 }
 EXPORT_SYMBOL(blk_mq_requeue_request);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 95e119409490..82b6cf45c6e0 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -678,8 +678,6 @@ static inline bool blk_account_rq(struct request *rq)
 
 #define blk_rq_cpu_valid(rq)	((rq)->cpu != -1)
 #define blk_bidi_rq(rq)		((rq)->next_rq != NULL)
-/* rq->queuelist of dequeued request must be list_empty() */
-#define blk_queued_rq(rq)	(!list_empty(&(rq)->queuelist))
 
 #define list_entry_rq(ptr)	list_entry((ptr), struct request, queuelist)
 
-- 
2.17.1
