Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:29728 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1036481AbdEYSni (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 May 2017 14:43:38 -0400
From: Bart Van Assche <bart.vanassche@sandisk.com>
To: Jens Axboe <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, Christoph Hellwig <hch@lst.de>,
        "Bart Van Assche" <bart.vanassche@sandisk.com>,
        Hannes Reinecke <hare@suse.com>,
        "Omar Sandoval" <osandov@fb.com>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 10/19] blk-mq: Change blk_mq_hw_ctx.queue_rq_srcu into an array
Date: Thu, 25 May 2017 11:43:18 -0700
Message-ID: <20170525184327.23570-11-bart.vanassche@sandisk.com>
In-Reply-To: <20170525184327.23570-1-bart.vanassche@sandisk.com>
References: <20170525184327.23570-1-bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

This patch does not change any functionality but makes the next
patch easier to read.

Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Omar Sandoval <osandov@fb.com>
Cc: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c         | 14 +++++++-------
 include/linux/blk-mq.h |  2 +-
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index a1620b36b95c..bc96e6007e53 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -172,7 +172,7 @@ void blk_mq_quiesce_queue(struct request_queue *q)
 
 	queue_for_each_hw_ctx(q, hctx, i) {
 		if (hctx->flags & BLK_MQ_F_BLOCKING)
-			synchronize_srcu(&hctx->queue_rq_srcu);
+			synchronize_srcu(hctx->queue_rq_srcu);
 		else
 			rcu = true;
 	}
@@ -1122,9 +1122,9 @@ static void __blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx)
 	} else {
 		might_sleep();
 
-		srcu_idx = srcu_read_lock(&hctx->queue_rq_srcu);
+		srcu_idx = srcu_read_lock(hctx->queue_rq_srcu);
 		blk_mq_sched_dispatch_requests(hctx);
-		srcu_read_unlock(&hctx->queue_rq_srcu, srcu_idx);
+		srcu_read_unlock(hctx->queue_rq_srcu, srcu_idx);
 	}
 }
 
@@ -1537,9 +1537,9 @@ static void blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
 
 		might_sleep();
 
-		srcu_idx = srcu_read_lock(&hctx->queue_rq_srcu);
+		srcu_idx = srcu_read_lock(hctx->queue_rq_srcu);
 		__blk_mq_try_issue_directly(rq, cookie, true);
-		srcu_read_unlock(&hctx->queue_rq_srcu, srcu_idx);
+		srcu_read_unlock(hctx->queue_rq_srcu, srcu_idx);
 	}
 }
 
@@ -1879,7 +1879,7 @@ static void blk_mq_exit_hctx(struct request_queue *q,
 		set->ops->exit_hctx(hctx, hctx_idx);
 
 	if (hctx->flags & BLK_MQ_F_BLOCKING)
-		cleanup_srcu_struct(&hctx->queue_rq_srcu);
+		cleanup_srcu_struct(hctx->queue_rq_srcu);
 
 	blk_mq_remove_cpuhp(hctx);
 	blk_free_flush_queue(hctx->fq);
@@ -1952,7 +1952,7 @@ static int blk_mq_init_hctx(struct request_queue *q,
 		goto free_fq;
 
 	if (hctx->flags & BLK_MQ_F_BLOCKING)
-		init_srcu_struct(&hctx->queue_rq_srcu);
+		init_srcu_struct(hctx->queue_rq_srcu);
 
 	blk_mq_debugfs_register_hctx(q, hctx);
 
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index c47aa248c640..c63d1d98404a 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -39,7 +39,7 @@ struct blk_mq_hw_ctx {
 	struct blk_mq_tags	*tags;
 	struct blk_mq_tags	*sched_tags;
 
-	struct srcu_struct	queue_rq_srcu;
+	struct srcu_struct	queue_rq_srcu[1];
 
 	unsigned long		queued;
 	unsigned long		run;
-- 
2.12.2
