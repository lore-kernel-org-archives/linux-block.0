Return-Path: <tglx@linutronix.de>
Message-Id: <20160920152108.092081086@linutronix.de>
Date: Tue, 20 Sep 2016 15:21:55 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwing <hch@lst.de>, Sebastian Siewior <bigeasy@linutronix.de>,
 Peter Zijlstra <peterz@infradead.org>, rt@linutronix.de
Subject: [patch V2 2/2] blk/mq: Convert to hotplug state machine
References: <20160920152020.777561324@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
List-ID: <linux-block@vger.kernel.org>

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Install the callbacks via the state machine so we can phase out the cpu
hotplug notifiers mess.


Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: linux-block@vger.kernel.org
Cc: rt@linutronix.de
Cc: Christoph Hellwing <hch@lst.de>
Link: http://lkml.kernel.org/r/20160919212601.180033814@linutronix.de
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---

 block/blk-mq.c |   87 ++++++++++++++++++++++++++++-----------------------------
 1 file changed, 43 insertions(+), 44 deletions(-)

--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2090,50 +2090,18 @@ static void blk_mq_queue_reinit(struct r
 	blk_mq_sysfs_register(q);
 }
 
-static int blk_mq_queue_reinit_notify(struct notifier_block *nb,
-				      unsigned long action, void *hcpu)
+/*
+ * New online cpumask which is going to be set in this hotplug event.
+ * Declare this cpumasks as global as cpu-hotplug operation is invoked
+ * one-by-one and dynamically allocating this could result in a failure.
+ */
+static struct cpumask cpuhp_online_new;
+
+static void blk_mq_queue_reinit_work(void)
 {
 	struct request_queue *q;
-	int cpu = (unsigned long)hcpu;
-	/*
-	 * New online cpumask which is going to be set in this hotplug event.
-	 * Declare this cpumasks as global as cpu-hotplug operation is invoked
-	 * one-by-one and dynamically allocating this could result in a failure.
-	 */
-	static struct cpumask online_new;
-
-	/*
-	 * Before hotadded cpu starts handling requests, new mappings must
-	 * be established.  Otherwise, these requests in hw queue might
-	 * never be dispatched.
-	 *
-	 * For example, there is a single hw queue (hctx) and two CPU queues
-	 * (ctx0 for CPU0, and ctx1 for CPU1).
-	 *
-	 * Now CPU1 is just onlined and a request is inserted into
-	 * ctx1->rq_list and set bit0 in pending bitmap as ctx1->index_hw is
-	 * still zero.
-	 *
-	 * And then while running hw queue, flush_busy_ctxs() finds bit0 is
-	 * set in pending bitmap and tries to retrieve requests in
-	 * hctx->ctxs[0]->rq_list.  But htx->ctxs[0] is a pointer to ctx0,
-	 * so the request in ctx1->rq_list is ignored.
-	 */
-	switch (action & ~CPU_TASKS_FROZEN) {
-	case CPU_DEAD:
-	case CPU_UP_CANCELED:
-		cpumask_copy(&online_new, cpu_online_mask);
-		break;
-	case CPU_UP_PREPARE:
-		cpumask_copy(&online_new, cpu_online_mask);
-		cpumask_set_cpu(cpu, &online_new);
-		break;
-	default:
-		return NOTIFY_OK;
-	}
 
 	mutex_lock(&all_q_mutex);
-
 	/*
 	 * We need to freeze and reinit all existing queues.  Freezing
 	 * involves synchronous wait for an RCU grace period and doing it
@@ -2154,13 +2122,43 @@ static int blk_mq_queue_reinit_notify(st
 	}
 
 	list_for_each_entry(q, &all_q_list, all_q_node)
-		blk_mq_queue_reinit(q, &online_new);
+		blk_mq_queue_reinit(q, &cpuhp_online_new);
 
 	list_for_each_entry(q, &all_q_list, all_q_node)
 		blk_mq_unfreeze_queue(q);
 
 	mutex_unlock(&all_q_mutex);
-	return NOTIFY_OK;
+}
+
+static int blk_mq_queue_reinit_dead(unsigned int cpu)
+{
+	cpumask_clear_cpu(cpu, &cpuhp_online_new);
+	blk_mq_queue_reinit_work();
+	return 0;
+}
+
+/*
+ * Before hotadded cpu starts handling requests, new mappings must be
+ * established.  Otherwise, these requests in hw queue might never be
+ * dispatched.
+ *
+ * For example, there is a single hw queue (hctx) and two CPU queues (ctx0
+ * for CPU0, and ctx1 for CPU1).
+ *
+ * Now CPU1 is just onlined and a request is inserted into ctx1->rq_list
+ * and set bit0 in pending bitmap as ctx1->index_hw is still zero.
+ *
+ * And then while running hw queue, flush_busy_ctxs() finds bit0 is set in
+ * pending bitmap and tries to retrieve requests in hctx->ctxs[0]->rq_list.
+ * But htx->ctxs[0] is a pointer to ctx0, so the request in ctx1->rq_list
+ * is ignored.
+ */
+static int blk_mq_queue_reinit_prepare(unsigned int cpu)
+{
+	cpumask_copy(&cpuhp_online_new, cpu_online_mask);
+	cpumask_set_cpu(cpu, &cpuhp_online_new);
+	blk_mq_queue_reinit_work();
+	return 0;
 }
 
 static int __blk_mq_alloc_rq_maps(struct blk_mq_tag_set *set)
@@ -2382,8 +2380,9 @@ static int __init blk_mq_init(void)
 	cpuhp_setup_state_multi(CPUHP_BLK_MQ_DEAD, "block/mq:dead", NULL,
 				blk_mq_hctx_notify_dead);
 
-	hotcpu_notifier(blk_mq_queue_reinit_notify, 0);
-
+	cpuhp_setup_state_nocalls(CPUHP_BLK_MQ_PREPARE, "block/mq:prepare",
+				  blk_mq_queue_reinit_prepare,
+				  blk_mq_queue_reinit_dead);
 	return 0;
 }
 subsys_initcall(blk_mq_init);
