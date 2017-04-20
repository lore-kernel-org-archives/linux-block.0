Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <bart.vanassche@sandisk.com>
To: Jens Axboe <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, Bart Van Assche
	<bart.vanassche@sandisk.com>, Omar Sandoval <osandov@fb.com>, Hannes Reinecke
	<hare@suse.com>
Subject: [PATCH] blk-mq: Remove blk_mq_sched_move_to_dispatch()
Date: Thu, 20 Apr 2017 16:25:19 -0700
Message-ID: <20170420232519.19906-1-bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: Bart.VanAssche@sandisk.com
List-ID: <linux-block@vger.kernel.org>

commit c13660a08c8b ("blk-mq-sched: change ->dispatch_requests()
to ->dispatch_request()") removed the last user of this function.
Hence also remove the function itself.

Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Omar Sandoval <osandov@fb.com>
Cc: Hannes Reinecke <hare@suse.com>
---
 block/blk-mq-sched.c | 16 ----------------
 block/blk-mq-sched.h |  3 ---
 2 files changed, 19 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 9e3c0f92851b..e79e9f18d7c2 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -190,22 +190,6 @@ void blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx)
 	}
 }
 
-void blk_mq_sched_move_to_dispatch(struct blk_mq_hw_ctx *hctx,
-				   struct list_head *rq_list,
-				   struct request *(*get_rq)(struct blk_mq_hw_ctx *))
-{
-	do {
-		struct request *rq;
-
-		rq = get_rq(hctx);
-		if (!rq)
-			break;
-
-		list_add_tail(&rq->queuelist, rq_list);
-	} while (1);
-}
-EXPORT_SYMBOL_GPL(blk_mq_sched_move_to_dispatch);
-
 bool blk_mq_sched_try_merge(struct request_queue *q, struct bio *bio,
 			    struct request **merged_request)
 {
diff --git a/block/blk-mq-sched.h b/block/blk-mq-sched.h
index 120c6abc37cc..edafb5383b7b 100644
--- a/block/blk-mq-sched.h
+++ b/block/blk-mq-sched.h
@@ -24,9 +24,6 @@ void blk_mq_sched_insert_requests(struct request_queue *q,
 				  struct list_head *list, bool run_queue_async);
 
 void blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx);
-void blk_mq_sched_move_to_dispatch(struct blk_mq_hw_ctx *hctx,
-			struct list_head *rq_list,
-			struct request *(*get_rq)(struct blk_mq_hw_ctx *));
 
 int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e);
 void blk_mq_exit_sched(struct request_queue *q, struct elevator_queue *e);
-- 
2.12.2
