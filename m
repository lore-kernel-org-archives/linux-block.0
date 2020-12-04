Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54F3EC4167B
	for <linux-block@archiver.kernel.org>; Fri,  4 Dec 2020 19:14:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 019E822CAE
	for <linux-block@archiver.kernel.org>; Fri,  4 Dec 2020 19:14:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbgLDTOw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 4 Dec 2020 14:14:52 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:49392 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728079AbgLDTOs (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 4 Dec 2020 14:14:48 -0500
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607109245;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sBZVA+aUErTEHExNncbFL8kYuUQMpfZGtQo4vtsCy2c=;
        b=HBCiux5IzSNRxBSR/n3Sinu760jNxDTg9mB1HEgzPCIjKRvrmGEDX0jL7cYQCdprY2/Tr1
        QvWh8CBYIc+l3p3Dp4Q5uqUcLZNf2DJQAbvOl7vU9zYOHg9XaUYiwV3Ki7B2eNB2ebYtM0
        sn3SJdU2cbGgvkVCUWA2M89qb6ClD/Iw5GS15E83oqkkHg3VsFQYWt6tN0mM5UjlpwGgoW
        Aaw9+wpDWryHfPnn0zfVlPWpjXAF+qE1uwyF53t0gbymcHxpkiDzJXwgvgQ5T1LXnrr6gb
        JgE/m/iRUAHbHi/RGqLqyqjEvrmsTAhN9o0H0hpYqxfGqLtRY8+F5i/M7X1t7A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607109245;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sBZVA+aUErTEHExNncbFL8kYuUQMpfZGtQo4vtsCy2c=;
        b=GOwMbCjVDKMonuC3piKobx2KCG9xwLAf9Q78PU/WxZvz5+x0fdtW70gzNBvgm3FJANwqW5
        tZdgo64j0qUIvMDQ==
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Wagner <dwagner@suse.de>,
        Mike Galbraith <efault@gmx.de>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 3/3] blk-mq: Use llist_head for blk_cpu_done
Date:   Fri,  4 Dec 2020 20:13:56 +0100
Message-Id: <20201204191356.2516405-4-bigeasy@linutronix.de>
In-Reply-To: <20201204191356.2516405-1-bigeasy@linutronix.de>
References: <20201204191356.2516405-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

With llist_head it is possible to avoid the locking (the irq-off region)
when items are added. This makes it possible to add items on a remote
CPU.
llist_add() returns true if the list was previously empty. This can be
used to invoke the SMP function call / raise sofirq only if the first
item was added (otherwise it is already pending).
This simplifies the code a little and reduces the IRQ-off regions. With
this change it possible to reduce the SMP-function call a simple
__raise_softirq_irqoff().
blk_mq_complete_request_remote() needs a preempt-disable section if the
request needs to complete on the local CPU. Some callers (USB-storage)
invoke this preemptible context and the request needs to be enqueued on
the same CPU as the softirq is raised.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 block/blk-mq.c         | 77 ++++++++++++++----------------------------
 include/linux/blkdev.h |  2 +-
 2 files changed, 27 insertions(+), 52 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 3c0e94913d874..b5138327952a4 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -41,7 +41,7 @@
 #include "blk-mq-sched.h"
 #include "blk-rq-qos.h"
=20
-static DEFINE_PER_CPU(struct list_head, blk_cpu_done);
+static DEFINE_PER_CPU(struct llist_head, blk_cpu_done);
=20
 static void blk_mq_poll_stats_start(struct request_queue *q);
 static void blk_mq_poll_stats_fn(struct blk_stat_callback *cb);
@@ -567,68 +567,32 @@ void blk_mq_end_request(struct request *rq, blk_statu=
s_t error)
 }
 EXPORT_SYMBOL(blk_mq_end_request);
=20
-/*
- * Softirq action handler - move entries to local list and loop over them
- * while passing them to the queue registered handler.
- */
-static __latent_entropy void blk_done_softirq(struct softirq_action *h)
+static void blk_complete_reqs(struct llist_head *cpu_list)
 {
-	struct list_head *cpu_list, local_list;
+	struct llist_node *entry;
+	struct request *rq, *rq_next;
=20
-	local_irq_disable();
-	cpu_list =3D this_cpu_ptr(&blk_cpu_done);
-	list_replace_init(cpu_list, &local_list);
-	local_irq_enable();
+	entry =3D llist_del_all(cpu_list);
+	entry =3D llist_reverse_order(entry);
=20
-	while (!list_empty(&local_list)) {
-		struct request *rq;
-
-		rq =3D list_entry(local_list.next, struct request, ipi_list);
-		list_del_init(&rq->ipi_list);
+	llist_for_each_entry_safe(rq, rq_next, entry, ipi_list)
 		rq->q->mq_ops->complete(rq);
-	}
 }
=20
-static void blk_mq_trigger_softirq(struct request *rq)
+static __latent_entropy void blk_done_softirq(struct softirq_action *h)
 {
-	struct list_head *list;
-	unsigned long flags;
-
-	local_irq_save(flags);
-	list =3D this_cpu_ptr(&blk_cpu_done);
-	list_add_tail(&rq->ipi_list, list);
-
-	/*
-	 * If the list only contains our just added request, signal a raise of
-	 * the softirq.  If there are already entries there, someone already
-	 * raised the irq but it hasn't run yet.
-	 */
-	if (list->next =3D=3D &rq->ipi_list)
-		raise_softirq_irqoff(BLOCK_SOFTIRQ);
-	local_irq_restore(flags);
+	blk_complete_reqs(this_cpu_ptr(&blk_cpu_done));
 }
=20
 static int blk_softirq_cpu_dead(unsigned int cpu)
 {
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
+	blk_complete_reqs(&per_cpu(blk_cpu_done, cpu));
 	return 0;
 }
=20
-
 static void __blk_mq_complete_request_remote(void *data)
 {
-	struct request *rq =3D data;
-
-	blk_mq_trigger_softirq(rq);
+	__raise_softirq_irqoff(BLOCK_SOFTIRQ);
 }
=20
 static inline bool blk_mq_complete_need_ipi(struct request *rq)
@@ -659,6 +623,7 @@ static inline bool blk_mq_complete_need_ipi(struct requ=
est *rq)
=20
 bool blk_mq_complete_request_remote(struct request *rq)
 {
+	struct llist_head *cpu_list;
 	WRITE_ONCE(rq->state, MQ_RQ_COMPLETE);
=20
 	/*
@@ -669,12 +634,22 @@ bool blk_mq_complete_request_remote(struct request *r=
q)
 		return false;
=20
 	if (blk_mq_complete_need_ipi(rq)) {
-		INIT_CSD(&rq->csd, __blk_mq_complete_request_remote, rq);
-		smp_call_function_single_async(rq->mq_ctx->cpu, &rq->csd);
+		unsigned int cpu;
+
+		cpu =3D rq->mq_ctx->cpu;
+		cpu_list =3D &per_cpu(blk_cpu_done, cpu);
+		if (llist_add(&rq->ipi_list, cpu_list)) {
+			INIT_CSD(&rq->csd, __blk_mq_complete_request_remote, rq);
+			smp_call_function_single_async(cpu, &rq->csd);
+		}
 	} else {
 		if (rq->q->nr_hw_queues > 1)
 			return false;
-		blk_mq_trigger_softirq(rq);
+		preempt_disable();
+		cpu_list =3D this_cpu_ptr(&blk_cpu_done);
+		if (llist_add(&rq->ipi_list, cpu_list))
+			raise_softirq(BLOCK_SOFTIRQ);
+		preempt_enable();
 	}
=20
 	return true;
@@ -3905,7 +3880,7 @@ static int __init blk_mq_init(void)
 	int i;
=20
 	for_each_possible_cpu(i)
-		INIT_LIST_HEAD(&per_cpu(blk_cpu_done, i));
+		init_llist_head(&per_cpu(blk_cpu_done, i));
 	open_softirq(BLOCK_SOFTIRQ, blk_done_softirq);
=20
 	cpuhp_setup_state_nocalls(CPUHP_BLOCK_SOFTIRQ_DEAD,
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 17cedf0dc83db..7b05390766eec 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -156,7 +156,7 @@ struct request {
 	 */
 	union {
 		struct hlist_node hash;	/* merge hash */
-		struct list_head ipi_list;
+		struct llist_node ipi_list;
 	};
=20
 	/*
--=20
2.29.2

