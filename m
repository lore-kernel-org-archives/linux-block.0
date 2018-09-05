Return-Path: <jianchao.w.wang@oracle.com>
From: Jianchao Wang <jianchao.w.wang@oracle.com>
To: axboe@kernel.dk, ming.lei@redhat.com, bart.vanassche@wdc.com,
        sagi@grimberg.me, keith.busch@intel.com, jthumshirn@suse.de,
        jsmart2021@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
Subject: [PATCH 2/3] blk-core: introduce queue close feature
Date: Wed,  5 Sep 2018 12:09:45 +0800
Message-Id: <1536120586-3378-3-git-send-email-jianchao.w.wang@oracle.com>
In-Reply-To: <1536120586-3378-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1536120586-3378-1-git-send-email-jianchao.w.wang@oracle.com>
List-ID: <linux-block@vger.kernel.org>

blk queue freeze is often used to prevent new IO from entering
request queue. However, becuase we kill the percpu-ref
q_usage_counter when freeze queue, we have to drain the request
queue when unfreeze. This is unnecessary for just preventing new
IO. In addition, If there is IO timeout or other issue when unfreeze
the queue, the scenario could be very tricky.

So we introduce BLK_QUEUE_GATE_CLOSED to implement a light-weight
queue close feature base on the queue_gate to prevent new IO from
comming in queue which will not need to drain the queue any more.

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---
 block/blk-core.c       | 17 +++++++++++++++++
 block/blk.h            |  1 +
 include/linux/blkdev.h |  3 +++
 3 files changed, 21 insertions(+)

diff --git a/block/blk-core.c b/block/blk-core.c
index d1bdded..b073c68 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -449,6 +449,23 @@ void blk_clear_preempt_only(struct request_queue *q)
 }
 EXPORT_SYMBOL_GPL(blk_clear_preempt_only);
 
+int blk_set_queue_closed(struct request_queue *q)
+{
+	if (test_and_set_bit(BLK_QUEUE_GATE_CLOSED, &q->queue_gate))
+		return 1;
+
+	synchronize_rcu();
+	return 0;
+}
+EXPORT_SYMBOL_GPL(blk_set_queue_closed);
+
+void blk_clear_queue_closed(struct request_queue *q)
+{
+	clear_bit(BLK_QUEUE_GATE_CLOSED, &q->queue_gate);
+	wake_up_all(&q->mq_freeze_wq);
+}
+EXPORT_SYMBOL_GPL(blk_clear_queue_closed);
+
 /**
  * __blk_run_queue_uncond - run a queue whether or not it has been stopped
  * @q:	The queue to run
diff --git a/block/blk.h b/block/blk.h
index cdef4c1..90ff6bb 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -21,6 +21,7 @@ extern struct dentry *blk_debugfs_root;
 
 enum blk_queue_gate_flag_t {
 	BLK_QUEUE_GATE_PREEMPT_ONLY,
+	BLK_QUEUE_GATE_CLOSED,
 };
 
 struct blk_flush_queue {
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 4a33814..a7f77da 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -741,6 +741,9 @@ bool blk_queue_flag_test_and_clear(unsigned int flag, struct request_queue *q);
 extern int blk_set_preempt_only(struct request_queue *q);
 extern void blk_clear_preempt_only(struct request_queue *q);
 
+extern int blk_set_queue_closed(struct request_queue *q);
+extern void blk_clear_queue_closed(struct request_queue *q);
+
 static inline int queue_in_flight(struct request_queue *q)
 {
 	return q->in_flight[0] + q->in_flight[1];
-- 
2.7.4
