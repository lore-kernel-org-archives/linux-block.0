Return-Path: <tglx@linutronix.de>
Message-Id: <20160920152108.010490382@linutronix.de>
Date: Tue, 20 Sep 2016 15:21:55 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwing <hch@lst.de>, Sebastian Siewior <bigeasy@linutronix.de>,
 Peter Zijlstra <peterz@infradead.org>, rt@linutronix.de
Subject: [patch V2 1/2] blk/mq/cpu-notif: Convert to hotplug state machine
References: <20160920152020.777561324@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
List-ID: <linux-block@vger.kernel.org>

Replace the block-mq notifier list management with the multi instance
facility in the cpu hotplug state machine.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: linux-block@vger.kernel.org
Cc: rt@linutronix.de
Cc: Christoph Hellwing <hch@lst.de>

---

 block/Makefile         |    2 -
 block/blk-mq-cpu.c     |   67 -------------------------------------------------
 block/blk-mq.c         |   36 +++++++++-----------------
 block/blk-mq.h         |    7 -----
 include/linux/blk-mq.h |    8 -----
 5 files changed, 15 insertions(+), 105 deletions(-)

--- a/block/Makefile
+++ b/block/Makefile
@@ -6,7 +6,7 @@ obj-$(CONFIG_BLOCK) := bio.o elevator.o
 			blk-flush.o blk-settings.o blk-ioc.o blk-map.o \
 			blk-exec.o blk-merge.o blk-softirq.o blk-timeout.o \
 			blk-lib.o blk-mq.o blk-mq-tag.o \
-			blk-mq-sysfs.o blk-mq-cpu.o blk-mq-cpumap.o ioctl.o \
+			blk-mq-sysfs.o blk-mq-cpumap.o ioctl.o \
 			genhd.o scsi_ioctl.o partition-generic.o ioprio.o \
 			badblocks.o partitions/
 
--- a/block/blk-mq-cpu.c
+++ /dev/null
@@ -1,67 +0,0 @@
-/*
- * CPU notifier helper code for blk-mq
- *
- * Copyright (C) 2013-2014 Jens Axboe
- */
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/init.h>
-#include <linux/blkdev.h>
-#include <linux/list.h>
-#include <linux/llist.h>
-#include <linux/smp.h>
-#include <linux/cpu.h>
-
-#include <linux/blk-mq.h>
-#include "blk-mq.h"
-
-static LIST_HEAD(blk_mq_cpu_notify_list);
-static DEFINE_RAW_SPINLOCK(blk_mq_cpu_notify_lock);
-
-static int blk_mq_main_cpu_notify(struct notifier_block *self,
-				  unsigned long action, void *hcpu)
-{
-	unsigned int cpu = (unsigned long) hcpu;
-	struct blk_mq_cpu_notifier *notify;
-	int ret = NOTIFY_OK;
-
-	raw_spin_lock(&blk_mq_cpu_notify_lock);
-
-	list_for_each_entry(notify, &blk_mq_cpu_notify_list, list) {
-		ret = notify->notify(notify->data, action, cpu);
-		if (ret != NOTIFY_OK)
-			break;
-	}
-
-	raw_spin_unlock(&blk_mq_cpu_notify_lock);
-	return ret;
-}
-
-void blk_mq_register_cpu_notifier(struct blk_mq_cpu_notifier *notifier)
-{
-	BUG_ON(!notifier->notify);
-
-	raw_spin_lock(&blk_mq_cpu_notify_lock);
-	list_add_tail(&notifier->list, &blk_mq_cpu_notify_list);
-	raw_spin_unlock(&blk_mq_cpu_notify_lock);
-}
-
-void blk_mq_unregister_cpu_notifier(struct blk_mq_cpu_notifier *notifier)
-{
-	raw_spin_lock(&blk_mq_cpu_notify_lock);
-	list_del(&notifier->list);
-	raw_spin_unlock(&blk_mq_cpu_notify_lock);
-}
-
-void blk_mq_init_cpu_notifier(struct blk_mq_cpu_notifier *notifier,
-			      int (*fn)(void *, unsigned long, unsigned int),
-			      void *data)
-{
-	notifier->notify = fn;
-	notifier->data = data;
-}
-
-void __init blk_mq_cpu_init(void)
-{
-	hotcpu_notifier(blk_mq_main_cpu_notify, 0);
-}
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1575,11 +1575,13 @@ static struct blk_mq_tags *blk_mq_init_r
  * software queue to the hw queue dispatch list, and ensure that it
  * gets run.
  */
-static int blk_mq_hctx_cpu_offline(struct blk_mq_hw_ctx *hctx, int cpu)
+static int blk_mq_hctx_notify_dead(unsigned int cpu, struct hlist_node *node)
 {
+	struct blk_mq_hw_ctx *hctx;
 	struct blk_mq_ctx *ctx;
 	LIST_HEAD(tmp);
 
+	hctx = hlist_entry_safe(node, struct blk_mq_hw_ctx, cpuhp_dead);
 	ctx = __blk_mq_get_ctx(hctx->queue, cpu);
 
 	spin_lock(&ctx->lock);
@@ -1590,30 +1592,20 @@ static int blk_mq_hctx_cpu_offline(struc
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
+static void blk_mq_remove_cpuhp(struct blk_mq_hw_ctx *hctx)
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
+	cpuhp_state_remove_instance_nocalls(CPUHP_BLK_MQ_DEAD,
+					    &hctx->cpuhp_dead);
 }
 
 /* hctx->ctxs will be freed in queue's release handler */
@@ -1633,7 +1625,7 @@ static void blk_mq_exit_hctx(struct requ
 	if (set->ops->exit_hctx)
 		set->ops->exit_hctx(hctx, hctx_idx);
 
-	blk_mq_unregister_cpu_notifier(&hctx->cpu_notifier);
+	blk_mq_remove_cpuhp(hctx);
 	blk_free_flush_queue(hctx->fq);
 	sbitmap_free(&hctx->ctx_map);
 }
@@ -1680,9 +1672,7 @@ static int blk_mq_init_hctx(struct reque
 	hctx->queue_num = hctx_idx;
 	hctx->flags = set->flags & ~BLK_MQ_F_TAG_SHARED;
 
-	blk_mq_init_cpu_notifier(&hctx->cpu_notifier,
-					blk_mq_hctx_notify, hctx);
-	blk_mq_register_cpu_notifier(&hctx->cpu_notifier);
+	cpuhp_state_add_instance_nocalls(CPUHP_BLK_MQ_DEAD, &hctx->cpuhp_dead);
 
 	hctx->tags = set->tags[hctx_idx];
 
@@ -1727,8 +1717,7 @@ static int blk_mq_init_hctx(struct reque
  free_ctxs:
 	kfree(hctx->ctxs);
  unregister_cpu_notifier:
-	blk_mq_unregister_cpu_notifier(&hctx->cpu_notifier);
-
+	blk_mq_remove_cpuhp(hctx);
 	return -1;
 }
 
@@ -2390,7 +2379,8 @@ void blk_mq_enable_hotplug(void)
 
 static int __init blk_mq_init(void)
 {
-	blk_mq_cpu_init();
+	cpuhp_setup_state_multi(CPUHP_BLK_MQ_DEAD, "block/mq:dead", NULL,
+				blk_mq_hctx_notify_dead);
 
 	hotcpu_notifier(blk_mq_queue_reinit_notify, 0);
 
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -32,13 +32,6 @@ void blk_mq_wake_waiters(struct request_
 /*
  * CPU hotplug helpers
  */
-struct blk_mq_cpu_notifier;
-void blk_mq_init_cpu_notifier(struct blk_mq_cpu_notifier *notifier,
-			      int (*fn)(void *, unsigned long, unsigned int),
-			      void *data);
-void blk_mq_register_cpu_notifier(struct blk_mq_cpu_notifier *notifier);
-void blk_mq_unregister_cpu_notifier(struct blk_mq_cpu_notifier *notifier);
-void blk_mq_cpu_init(void);
 void blk_mq_enable_hotplug(void);
 void blk_mq_disable_hotplug(void);
 
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -7,12 +7,6 @@
 struct blk_mq_tags;
 struct blk_flush_queue;
 
-struct blk_mq_cpu_notifier {
-	struct list_head list;
-	void *data;
-	int (*notify)(void *data, unsigned long action, unsigned int cpu);
-};
-
 struct blk_mq_hw_ctx {
 	struct {
 		spinlock_t		lock;
@@ -53,7 +47,7 @@ struct blk_mq_hw_ctx {
 
 	struct delayed_work	delay_work;
 
-	struct blk_mq_cpu_notifier	cpu_notifier;
+	struct hlist_node	cpuhp_dead;
 	struct kobject		kobj;
 
 	unsigned long		poll_considered;
