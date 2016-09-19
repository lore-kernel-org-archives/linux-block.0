Return-Path: <tglx@linutronix.de>
Message-Id: <20160919212601.094034281@linutronix.de>
Date: Mon, 19 Sep 2016 21:28:20 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwing <hch@lst.de>, Sebastian Siewior <bigeasy@linutronix.de>,
 Peter Zijlstra <peterz@infradead.org>, rt@linutronix.de
Subject: [patch 2/3] blk/mq/cpu-notif: Convert to hotplug state machine
References: <20160919212207.161583394@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
List-ID: <linux-block@vger.kernel.org>

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Install the callbacks via the state machine so we can phase out the cpu
hotplug notifiers..

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: rt@linutronix.de
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---

 block/blk-mq-cpu.c     |   15 +++++++--------
 block/blk-mq.c         |   21 +++++----------------
 block/blk-mq.h         |    2 +-
 include/linux/blk-mq.h |    2 +-
 4 files changed, 14 insertions(+), 26 deletions(-)

--- a/block/blk-mq-cpu.c
+++ b/block/blk-mq-cpu.c
@@ -18,18 +18,16 @@
 static LIST_HEAD(blk_mq_cpu_notify_list);
 static DEFINE_RAW_SPINLOCK(blk_mq_cpu_notify_lock);
 
-static int blk_mq_main_cpu_notify(struct notifier_block *self,
-				  unsigned long action, void *hcpu)
+static int blk_mq_cpu_dead(unsigned int cpu)
 {
-	unsigned int cpu = (unsigned long) hcpu;
 	struct blk_mq_cpu_notifier *notify;
-	int ret = NOTIFY_OK;
+	int ret;
 
 	raw_spin_lock(&blk_mq_cpu_notify_lock);
 
 	list_for_each_entry(notify, &blk_mq_cpu_notify_list, list) {
-		ret = notify->notify(notify->data, action, cpu);
-		if (ret != NOTIFY_OK)
+		ret = notify->notify(notify->data, cpu);
+		if (ret)
 			break;
 	}
 
@@ -54,7 +52,7 @@ void blk_mq_unregister_cpu_notifier(stru
 }
 
 void blk_mq_init_cpu_notifier(struct blk_mq_cpu_notifier *notifier,
-			      int (*fn)(void *, unsigned long, unsigned int),
+			      int (*fn)(void *, unsigned int),
 			      void *data)
 {
 	notifier->notify = fn;
@@ -63,5 +61,6 @@ void blk_mq_init_cpu_notifier(struct blk
 
 void __init blk_mq_cpu_init(void)
 {
-	hotcpu_notifier(blk_mq_main_cpu_notify, 0);
+	cpuhp_setup_state_nocalls(CPUHP_BLK_MQ_DEAD, "block/mq:dead", NULL,
+				  blk_mq_cpu_dead);
 }
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1590,30 +1590,19 @@ static int blk_mq_hctx_cpu_offline(struc
 	spin_unlock(&ctx->lock);
 
 	if (list_empty(&tmp))
-		return NOTIFY_OK;
+		return 0;
 
 	spin_lock(&hctx->lock);
 	list_splice_tail_init(&tmp, &hctx->dispatch);
 	spin_unlock(&hctx->lock);
 
 	blk_mq_run_hw_queue(hctx, true);
-	return NOTIFY_OK;
+	return 0;
 }
 
-static int blk_mq_hctx_notify(void *data, unsigned long action,
-			      unsigned int cpu)
+static int blk_mq_hctx_notify_dead(void *hctx, unsigned int cpu)
 {
-	struct blk_mq_hw_ctx *hctx = data;
-
-	if (action == CPU_DEAD || action == CPU_DEAD_FROZEN)
-		return blk_mq_hctx_cpu_offline(hctx, cpu);
-
-	/*
-	 * In case of CPU online, tags may be reallocated
-	 * in blk_mq_map_swqueue() after mapping is updated.
-	 */
-
-	return NOTIFY_OK;
+	return blk_mq_hctx_cpu_offline(hctx, cpu);
 }
 
 /* hctx->ctxs will be freed in queue's release handler */
@@ -1681,7 +1670,7 @@ static int blk_mq_init_hctx(struct reque
 	hctx->flags = set->flags & ~BLK_MQ_F_TAG_SHARED;
 
 	blk_mq_init_cpu_notifier(&hctx->cpu_notifier,
-					blk_mq_hctx_notify, hctx);
+					blk_mq_hctx_notify_dead, hctx);
 	blk_mq_register_cpu_notifier(&hctx->cpu_notifier);
 
 	hctx->tags = set->tags[hctx_idx];
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -34,7 +34,7 @@ void blk_mq_wake_waiters(struct request_
  */
 struct blk_mq_cpu_notifier;
 void blk_mq_init_cpu_notifier(struct blk_mq_cpu_notifier *notifier,
-			      int (*fn)(void *, unsigned long, unsigned int),
+			      int (*fn)(void *, unsigned int),
 			      void *data);
 void blk_mq_register_cpu_notifier(struct blk_mq_cpu_notifier *notifier);
 void blk_mq_unregister_cpu_notifier(struct blk_mq_cpu_notifier *notifier);
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -10,7 +10,7 @@ struct blk_flush_queue;
 struct blk_mq_cpu_notifier {
 	struct list_head list;
 	void *data;
-	int (*notify)(void *data, unsigned long action, unsigned int cpu);
+	int (*notify)(void *data, unsigned int cpu);
 };
 
 struct blk_mq_hw_ctx {
