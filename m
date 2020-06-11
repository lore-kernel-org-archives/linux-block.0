Return-Path: <SRS0=H7KM=7Y=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95013C433E0
	for <linux-block@archiver.kernel.org>; Thu, 11 Jun 2020 06:45:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7275E20812
	for <linux-block@archiver.kernel.org>; Thu, 11 Jun 2020 06:45:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QaTPdcdt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726147AbgFKGo7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Jun 2020 02:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbgFKGo7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Jun 2020 02:44:59 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65177C08C5C2
        for <linux-block@vger.kernel.org>; Wed, 10 Jun 2020 23:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=m5nFf9z3UBA9AcU1s4n8Gynw5/3rDnrWaAS0l9EP/cw=; b=QaTPdcdtqUmfm6Mmm1QukbtP0y
        ujFIswj7i+Fud3APgQbjdUac9iEkzp9+T/Yy8QkatHd98ofnq4YXoUbSgwozrNeZyQwBuuoKNUzcv
        57cOgUFoAtJL4vvCEMrioACPySnQQm+GXe264WULsp9GZnOVUa/V5VzOcm68uQu43efrZhZh/XoZ/
        7cMJ/nusdtRk35tbXr+VQsBPf/er/dVWhlnTf4ly7cHEqFbKLfxYkMIujScyBU4mifkOO4uTa/WhC
        YYU9YDT6bP6xRVncdR/UidtS1va/K1TTlUdEgVZwnsmORQmiXEShJ5049EYuUxrGLa76rQbJnz2g+
        3dCeruWw==;
Received: from [2001:4bb8:18c:317f:efe9:d6fc:cdd9:b4ec] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jjGxO-0004su-5H; Thu, 11 Jun 2020 06:44:58 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Peter Zijlstra <peterz@infradead.org>, linux-block@vger.kernel.org,
        linux-nvme@lists.infrdead.org
Subject: [PATCH 01/12] blk-mq: merge blk-softirq.c into blk-mq.c
Date:   Thu, 11 Jun 2020 08:44:41 +0200
Message-Id: <20200611064452.12353-2-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200611064452.12353-1-hch@lst.de>
References: <20200611064452.12353-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

__blk_complete_request is only called from the blk-mq code, and
duplicates a lot of code from blk-mq.c.  Move it there to prepare
for better code sharing and simplifications.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/Makefile         |   2 +-
 block/blk-mq.c         | 135 +++++++++++++++++++++++++++++++++++
 block/blk-softirq.c    | 156 -----------------------------------------
 include/linux/blkdev.h |   1 -
 4 files changed, 136 insertions(+), 158 deletions(-)
 delete mode 100644 block/blk-softirq.c

diff --git a/block/Makefile b/block/Makefile
index 78719169fb2af8..8d841f5f986fe4 100644
--- a/block/Makefile
+++ b/block/Makefile
@@ -5,7 +5,7 @@
 
 obj-$(CONFIG_BLOCK) := bio.o elevator.o blk-core.o blk-sysfs.o \
 			blk-flush.o blk-settings.o blk-ioc.o blk-map.o \
-			blk-exec.o blk-merge.o blk-softirq.o blk-timeout.o \
+			blk-exec.o blk-merge.o blk-timeout.o \
 			blk-lib.o blk-mq.o blk-mq-tag.o blk-stat.o \
 			blk-mq-sysfs.o blk-mq-cpumap.o blk-mq-sched.o ioctl.o \
 			genhd.o ioprio.o badblocks.o partitions/ blk-rq-qos.o
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 9a36ac1c1fa1d8..bbdc6c97bd42db 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -41,6 +41,8 @@
 #include "blk-mq-sched.h"
 #include "blk-rq-qos.h"
 
+static DEFINE_PER_CPU(struct list_head, blk_cpu_done);
+
 static void blk_mq_poll_stats_start(struct request_queue *q);
 static void blk_mq_poll_stats_fn(struct blk_stat_callback *cb);
 
@@ -574,6 +576,130 @@ void blk_mq_end_request(struct request *rq, blk_status_t error)
 }
 EXPORT_SYMBOL(blk_mq_end_request);
 
+/*
+ * Softirq action handler - move entries to local list and loop over them
+ * while passing them to the queue registered handler.
+ */
+static __latent_entropy void blk_done_softirq(struct softirq_action *h)
+{
+	struct list_head *cpu_list, local_list;
+
+	local_irq_disable();
+	cpu_list = this_cpu_ptr(&blk_cpu_done);
+	list_replace_init(cpu_list, &local_list);
+	local_irq_enable();
+
+	while (!list_empty(&local_list)) {
+		struct request *rq;
+
+		rq = list_entry(local_list.next, struct request, ipi_list);
+		list_del_init(&rq->ipi_list);
+		rq->q->mq_ops->complete(rq);
+	}
+}
+
+#ifdef CONFIG_SMP
+static void trigger_softirq(void *data)
+{
+	struct request *rq = data;
+	struct list_head *list;
+
+	list = this_cpu_ptr(&blk_cpu_done);
+	list_add_tail(&rq->ipi_list, list);
+
+	if (list->next == &rq->ipi_list)
+		raise_softirq_irqoff(BLOCK_SOFTIRQ);
+}
+
+/*
+ * Setup and invoke a run of 'trigger_softirq' on the given cpu.
+ */
+static int raise_blk_irq(int cpu, struct request *rq)
+{
+	if (cpu_online(cpu)) {
+		call_single_data_t *data = &rq->csd;
+
+		data->func = trigger_softirq;
+		data->info = rq;
+		data->flags = 0;
+
+		smp_call_function_single_async(cpu, data);
+		return 0;
+	}
+
+	return 1;
+}
+#else /* CONFIG_SMP */
+static int raise_blk_irq(int cpu, struct request *rq)
+{
+	return 1;
+}
+#endif
+
+static int blk_softirq_cpu_dead(unsigned int cpu)
+{
+	/*
+	 * If a CPU goes away, splice its entries to the current CPU
+	 * and trigger a run of the softirq
+	 */
+	local_irq_disable();
+	list_splice_init(&per_cpu(blk_cpu_done, cpu),
+			 this_cpu_ptr(&blk_cpu_done));
+	raise_softirq_irqoff(BLOCK_SOFTIRQ);
+	local_irq_enable();
+
+	return 0;
+}
+
+static void __blk_complete_request(struct request *req)
+{
+	struct request_queue *q = req->q;
+	int cpu, ccpu = req->mq_ctx->cpu;
+	unsigned long flags;
+	bool shared = false;
+
+	BUG_ON(!q->mq_ops->complete);
+
+	local_irq_save(flags);
+	cpu = smp_processor_id();
+
+	/*
+	 * Select completion CPU
+	 */
+	if (test_bit(QUEUE_FLAG_SAME_COMP, &q->queue_flags) && ccpu != -1) {
+		if (!test_bit(QUEUE_FLAG_SAME_FORCE, &q->queue_flags))
+			shared = cpus_share_cache(cpu, ccpu);
+	} else
+		ccpu = cpu;
+
+	/*
+	 * If current CPU and requested CPU share a cache, run the softirq on
+	 * the current CPU. One might concern this is just like
+	 * QUEUE_FLAG_SAME_FORCE, but actually not. blk_complete_request() is
+	 * running in interrupt handler, and currently I/O controller doesn't
+	 * support multiple interrupts, so current CPU is unique actually. This
+	 * avoids IPI sending from current CPU to the first CPU of a group.
+	 */
+	if (ccpu == cpu || shared) {
+		struct list_head *list;
+do_local:
+		list = this_cpu_ptr(&blk_cpu_done);
+		list_add_tail(&req->ipi_list, list);
+
+		/*
+		 * if the list only contains our just added request,
+		 * signal a raise of the softirq. If there are already
+		 * entries there, someone already raised the irq but it
+		 * hasn't run yet.
+		 */
+		if (list->next == &req->ipi_list)
+			raise_softirq_irqoff(BLOCK_SOFTIRQ);
+	} else if (raise_blk_irq(ccpu, req))
+		goto do_local;
+
+	local_irq_restore(flags);
+}
+
 static void __blk_mq_complete_request_remote(void *data)
 {
 	struct request *rq = data;
@@ -3787,6 +3913,15 @@ EXPORT_SYMBOL(blk_mq_rq_cpu);
 
 static int __init blk_mq_init(void)
 {
+	int i;
+
+	for_each_possible_cpu(i)
+		INIT_LIST_HEAD(&per_cpu(blk_cpu_done, i));
+	open_softirq(BLOCK_SOFTIRQ, blk_done_softirq);
+
+	cpuhp_setup_state_nocalls(CPUHP_BLOCK_SOFTIRQ_DEAD,
+				  "block/softirq:dead", NULL,
+				  blk_softirq_cpu_dead);
 	cpuhp_setup_state_multi(CPUHP_BLK_MQ_DEAD, "block/mq:dead", NULL,
 				blk_mq_hctx_notify_dead);
 	cpuhp_setup_state_multi(CPUHP_AP_BLK_MQ_ONLINE, "block/mq:online",
diff --git a/block/blk-softirq.c b/block/blk-softirq.c
deleted file mode 100644
index 6e7ec87d49faa1..00000000000000
--- a/block/blk-softirq.c
+++ /dev/null
@@ -1,156 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Functions related to softirq rq completions
- */
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/init.h>
-#include <linux/bio.h>
-#include <linux/blkdev.h>
-#include <linux/interrupt.h>
-#include <linux/cpu.h>
-#include <linux/sched.h>
-#include <linux/sched/topology.h>
-
-#include "blk.h"
-
-static DEFINE_PER_CPU(struct list_head, blk_cpu_done);
-
-/*
- * Softirq action handler - move entries to local list and loop over them
- * while passing them to the queue registered handler.
- */
-static __latent_entropy void blk_done_softirq(struct softirq_action *h)
-{
-	struct list_head *cpu_list, local_list;
-
-	local_irq_disable();
-	cpu_list = this_cpu_ptr(&blk_cpu_done);
-	list_replace_init(cpu_list, &local_list);
-	local_irq_enable();
-
-	while (!list_empty(&local_list)) {
-		struct request *rq;
-
-		rq = list_entry(local_list.next, struct request, ipi_list);
-		list_del_init(&rq->ipi_list);
-		rq->q->mq_ops->complete(rq);
-	}
-}
-
-#ifdef CONFIG_SMP
-static void trigger_softirq(void *data)
-{
-	struct request *rq = data;
-	struct list_head *list;
-
-	list = this_cpu_ptr(&blk_cpu_done);
-	list_add_tail(&rq->ipi_list, list);
-
-	if (list->next == &rq->ipi_list)
-		raise_softirq_irqoff(BLOCK_SOFTIRQ);
-}
-
-/*
- * Setup and invoke a run of 'trigger_softirq' on the given cpu.
- */
-static int raise_blk_irq(int cpu, struct request *rq)
-{
-	if (cpu_online(cpu)) {
-		call_single_data_t *data = &rq->csd;
-
-		data->func = trigger_softirq;
-		data->info = rq;
-		data->flags = 0;
-
-		smp_call_function_single_async(cpu, data);
-		return 0;
-	}
-
-	return 1;
-}
-#else /* CONFIG_SMP */
-static int raise_blk_irq(int cpu, struct request *rq)
-{
-	return 1;
-}
-#endif
-
-static int blk_softirq_cpu_dead(unsigned int cpu)
-{
-	/*
-	 * If a CPU goes away, splice its entries to the current CPU
-	 * and trigger a run of the softirq
-	 */
-	local_irq_disable();
-	list_splice_init(&per_cpu(blk_cpu_done, cpu),
-			 this_cpu_ptr(&blk_cpu_done));
-	raise_softirq_irqoff(BLOCK_SOFTIRQ);
-	local_irq_enable();
-
-	return 0;
-}
-
-void __blk_complete_request(struct request *req)
-{
-	struct request_queue *q = req->q;
-	int cpu, ccpu = req->mq_ctx->cpu;
-	unsigned long flags;
-	bool shared = false;
-
-	BUG_ON(!q->mq_ops->complete);
-
-	local_irq_save(flags);
-	cpu = smp_processor_id();
-
-	/*
-	 * Select completion CPU
-	 */
-	if (test_bit(QUEUE_FLAG_SAME_COMP, &q->queue_flags) && ccpu != -1) {
-		if (!test_bit(QUEUE_FLAG_SAME_FORCE, &q->queue_flags))
-			shared = cpus_share_cache(cpu, ccpu);
-	} else
-		ccpu = cpu;
-
-	/*
-	 * If current CPU and requested CPU share a cache, run the softirq on
-	 * the current CPU. One might concern this is just like
-	 * QUEUE_FLAG_SAME_FORCE, but actually not. blk_complete_request() is
-	 * running in interrupt handler, and currently I/O controller doesn't
-	 * support multiple interrupts, so current CPU is unique actually. This
-	 * avoids IPI sending from current CPU to the first CPU of a group.
-	 */
-	if (ccpu == cpu || shared) {
-		struct list_head *list;
-do_local:
-		list = this_cpu_ptr(&blk_cpu_done);
-		list_add_tail(&req->ipi_list, list);
-
-		/*
-		 * if the list only contains our just added request,
-		 * signal a raise of the softirq. If there are already
-		 * entries there, someone already raised the irq but it
-		 * hasn't run yet.
-		 */
-		if (list->next == &req->ipi_list)
-			raise_softirq_irqoff(BLOCK_SOFTIRQ);
-	} else if (raise_blk_irq(ccpu, req))
-		goto do_local;
-
-	local_irq_restore(flags);
-}
-
-static __init int blk_softirq_init(void)
-{
-	int i;
-
-	for_each_possible_cpu(i)
-		INIT_LIST_HEAD(&per_cpu(blk_cpu_done, i));
-
-	open_softirq(BLOCK_SOFTIRQ, blk_done_softirq);
-	cpuhp_setup_state_nocalls(CPUHP_BLOCK_SOFTIRQ_DEAD,
-				  "block/softirq:dead", NULL,
-				  blk_softirq_cpu_dead);
-	return 0;
-}
-subsys_initcall(blk_softirq_init);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 8fd900998b4e2e..98712cfc7a3489 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1078,7 +1078,6 @@ void blk_steal_bios(struct bio_list *list, struct request *rq);
 extern bool blk_update_request(struct request *rq, blk_status_t error,
 			       unsigned int nr_bytes);
 
-extern void __blk_complete_request(struct request *);
 extern void blk_abort_request(struct request *);
 
 /*
-- 
2.26.2

