Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 12/17] blk-mq-sched: export way for drivers to insert request
Date: Thu, 11 Oct 2018 10:59:04 -0600
Message-Id: <20181011165909.32615-13-axboe@kernel.dk>
In-Reply-To: <20181011165909.32615-1-axboe@kernel.dk>
References: <20181011165909.32615-1-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

We'll need this for the IDE conversion, which queues sense requests.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-mq-sched.c   | 1 +
 block/blk-mq-sched.h   | 2 --
 include/linux/blk-mq.h | 2 ++
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 29bfe8017a2d..f307af1a42bc 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -395,6 +395,7 @@ void blk_mq_sched_insert_request(struct request *rq, bool at_head,
 	if (run_queue)
 		blk_mq_run_hw_queue(hctx, async);
 }
+EXPORT_SYMBOL_GPL(blk_mq_sched_insert_request);
 
 void blk_mq_sched_insert_requests(struct request_queue *q,
 				  struct blk_mq_ctx *ctx,
diff --git a/block/blk-mq-sched.h b/block/blk-mq-sched.h
index 4e028ee42430..6b3e8255f3af 100644
--- a/block/blk-mq-sched.h
+++ b/block/blk-mq-sched.h
@@ -17,8 +17,6 @@ bool __blk_mq_sched_bio_merge(struct request_queue *q, struct bio *bio);
 bool blk_mq_sched_try_insert_merge(struct request_queue *q, struct request *rq);
 void blk_mq_sched_restart(struct blk_mq_hw_ctx *hctx);
 
-void blk_mq_sched_insert_request(struct request *rq, bool at_head,
-				 bool run_queue, bool async);
 void blk_mq_sched_insert_requests(struct request_queue *q,
 				  struct blk_mq_ctx *ctx,
 				  struct list_head *list, bool run_queue_async);
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 1da59c16f637..1d4f8588701d 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -260,6 +260,8 @@ void blk_mq_add_to_requeue_list(struct request *rq, bool at_head,
 				bool kick_requeue_list);
 void blk_mq_kick_requeue_list(struct request_queue *q);
 void blk_mq_delay_kick_requeue_list(struct request_queue *q, unsigned long msecs);
+void blk_mq_sched_insert_request(struct request *rq, bool at_head,
+				 bool run_queue, bool async);
 void blk_mq_complete_request(struct request *rq);
 bool blk_mq_bio_list_merge(struct request_queue *q, struct list_head *list,
 			   struct bio *bio);
-- 
2.17.1
