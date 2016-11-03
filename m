Return-Path: <prvs=0115b0b9d1=axboe@fb.com>
From: Jens Axboe <axboe@fb.com>
To: <axboe@kernel.dk>, <linux-kernel@vger.kernel.org>,
        <linux-block@vger.kernel.org>
CC: <hch@lst.de>, Jens Axboe <axboe@fb.com>
Subject: [PATCH 3/5] block: move poll code to blk-mq
Date: Thu, 3 Nov 2016 13:45:05 -0600
Message-ID: <1478202307-1947-4-git-send-email-axboe@fb.com>
In-Reply-To: <1478202307-1947-1-git-send-email-axboe@fb.com>
References: <1478202307-1947-1-git-send-email-axboe@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

The poll code is blk-mq specific, let's move it to blk-mq.c. This
is a prep patch for improving the polling code.

Signed-off-by: Jens Axboe <axboe@fb.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-core.c | 36 +++++-------------------------------
 block/blk-mq.c   | 33 +++++++++++++++++++++++++++++++++
 block/blk-mq.h   |  2 ++
 3 files changed, 40 insertions(+), 31 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 9dc7e9314d4c..e500d4b0e3fd 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -3299,47 +3299,21 @@ EXPORT_SYMBOL(blk_finish_plug);
 
 bool blk_poll(struct request_queue *q, blk_qc_t cookie)
 {
-	struct blk_plug *plug;
-	long state;
-	unsigned int queue_num;
 	struct blk_mq_hw_ctx *hctx;
+	struct blk_plug *plug;
+	struct request *rq;
 
 	if (!q->mq_ops || !q->mq_ops->poll || !blk_qc_t_valid(cookie) ||
 	    !test_bit(QUEUE_FLAG_POLL, &q->queue_flags))
 		return false;
 
-	queue_num = blk_qc_t_to_queue_num(cookie);
-	hctx = q->queue_hw_ctx[queue_num];
-	hctx->poll_considered++;
-
 	plug = current->plug;
 	if (plug)
 		blk_flush_plug_list(plug, false);
 
-	state = current->state;
-	while (!need_resched()) {
-		int ret;
-
-		hctx->poll_invoked++;
-
-		ret = q->mq_ops->poll(hctx, blk_qc_t_to_tag(cookie));
-		if (ret > 0) {
-			hctx->poll_success++;
-			set_current_state(TASK_RUNNING);
-			return true;
-		}
-
-		if (signal_pending_state(state, current))
-			set_current_state(TASK_RUNNING);
-
-		if (current->state == TASK_RUNNING)
-			return true;
-		if (ret < 0)
-			break;
-		cpu_relax();
-	}
-
-	return false;
+	hctx = q->queue_hw_ctx[blk_qc_t_to_queue_num(cookie)];
+	rq = blk_mq_tag_to_rq(hctx->tags, blk_qc_t_to_tag(cookie));
+	return blk_mq_poll(hctx, rq);
 }
 EXPORT_SYMBOL_GPL(blk_poll);
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 476b18e1991c..4883c2d97ea9 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2357,6 +2357,39 @@ void blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set, int nr_hw_queues)
 }
 EXPORT_SYMBOL_GPL(blk_mq_update_nr_hw_queues);
 
+bool blk_mq_poll(struct blk_mq_hw_ctx *hctx, struct request *rq)
+{
+	struct request_queue *q = hctx->queue;
+	long state;
+
+	hctx->poll_considered++;
+
+	state = current->state;
+	while (!need_resched()) {
+		int ret;
+
+		hctx->poll_invoked++;
+
+		ret = q->mq_ops->poll(hctx, rq->tag);
+		if (ret > 0) {
+			hctx->poll_success++;
+			set_current_state(TASK_RUNNING);
+			return true;
+		}
+
+		if (signal_pending_state(state, current))
+			set_current_state(TASK_RUNNING);
+
+		if (current->state == TASK_RUNNING)
+			return true;
+		if (ret < 0)
+			break;
+		cpu_relax();
+	}
+
+	return false;
+}
+
 void blk_mq_disable_hotplug(void)
 {
 	mutex_lock(&all_q_mutex);
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 8cf16cb69f64..79ea86e0ed49 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -61,6 +61,8 @@ extern void blk_mq_rq_timed_out(struct request *req, bool reserved);
 
 void blk_mq_release(struct request_queue *q);
 
+extern bool blk_mq_poll(struct blk_mq_hw_ctx *, struct request *);
+
 static inline struct blk_mq_ctx *__blk_mq_get_ctx(struct request_queue *q,
 					   unsigned int cpu)
 {
-- 
2.7.4
