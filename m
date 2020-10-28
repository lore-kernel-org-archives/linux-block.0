Return-Path: <SRS0=cVCO=ED=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BE7DC61DD8
	for <linux-block@archiver.kernel.org>; Wed, 28 Oct 2020 22:30:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D509D20724
	for <linux-block@archiver.kernel.org>; Wed, 28 Oct 2020 22:30:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HzvbuTuL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/7MKsyss"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387686AbgJ1WaS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Oct 2020 18:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387591AbgJ1W30 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Oct 2020 18:29:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64850C0613D1;
        Wed, 28 Oct 2020 15:29:26 -0700 (PDT)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603894383;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xAg1BaHG/AZLtW1SO42OcM1WhPRxIwOOiKwVxj2LdUk=;
        b=HzvbuTuL9FAatRJUhaiCNAEO3dtoOAvRzWn4x4rKT26LYhC0Hf0WWkxJkMzvtfVy6F89AV
        4TZ7TQLF8NaIKCe0DIWsF7hDVdS2vvfrfiFh30zCqIJcPmgbMLmM9J2fzcrnDg1KSrP3dK
        mufhIe4B5YfkXtfLLGj0okqmABaA9xXN8ZOQfuoOks/14++y4iD1MgEAmBUfUt8HgzKWtR
        GrwlqvPSRXpHlO94JGU3T9jw0ShlI6snMuFHoHmgNsG0v+iHNSqic2TRKz6OGLu7ter5E1
        eS1wwwFmYIKN2b4OccwGS6852cvfIafH8K9ED+f44efuIbklvEa2EDnssyYXNw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603894383;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xAg1BaHG/AZLtW1SO42OcM1WhPRxIwOOiKwVxj2LdUk=;
        b=/7MKsyssu4XRfWBWZENu9a437cT7IlvNe45GcutcSvzWOGoZJtWwhumpkAXOBWRyQptSYq
        HEt54fZq+3MVSCCA==
To:     linux-block@vger.kernel.org
Cc:     Christoph Hellwig <hch@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        David Runge <dave@sleepmap.de>, linux-rt-users@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Wagner <dwagner@suse.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 3/3] blk-mq: Use llist_head for blk_cpu_done
Date:   Wed, 28 Oct 2020 15:12:51 +0100
Message-Id: <20201028141251.3608598-3-bigeasy@linutronix.de>
In-Reply-To: <20201028141251.3608598-1-bigeasy@linutronix.de>
References: <20201028065616.GA24449@infradead.org>
 <20201028141251.3608598-1-bigeasy@linutronix.de>
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

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 block/blk-mq.c         | 78 ++++++++++++++----------------------------
 include/linux/blkdev.h |  2 +-
 2 files changed, 26 insertions(+), 54 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 769d2d532a825..4f53de48e5038 100644
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
@@ -565,68 +565,32 @@ void blk_mq_end_request(struct request *rq, blk_statu=
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
@@ -657,6 +621,7 @@ static inline bool blk_mq_complete_need_ipi(struct requ=
est *rq)
=20
 bool blk_mq_complete_request_remote(struct request *rq)
 {
+	struct llist_head *cpu_list;
 	WRITE_ONCE(rq->state, MQ_RQ_COMPLETE);
=20
 	/*
@@ -667,14 +632,21 @@ bool blk_mq_complete_request_remote(struct request *r=
q)
 		return false;
=20
 	if (blk_mq_complete_need_ipi(rq)) {
-		rq->csd.func =3D __blk_mq_complete_request_remote;
-		rq->csd.info =3D rq;
-		rq->csd.flags =3D 0;
-		smp_call_function_single_async(rq->mq_ctx->cpu, &rq->csd);
+		unsigned int cpu;
+
+		cpu =3D rq->mq_ctx->cpu;
+		cpu_list =3D &per_cpu(blk_cpu_done, cpu);
+		if (llist_add(&rq->ipi_list, cpu_list)) {
+			rq->csd.func =3D __blk_mq_complete_request_remote;
+			rq->csd.flags =3D 0;
+			smp_call_function_single_async(cpu, &rq->csd);
+		}
 	} else {
 		if (rq->q->nr_hw_queues > 1)
 			return false;
-		blk_mq_trigger_softirq(rq);
+		cpu_list =3D this_cpu_ptr(&blk_cpu_done);
+		if (llist_add(&rq->ipi_list, cpu_list))
+			raise_softirq(BLOCK_SOFTIRQ);
 	}
=20
 	return true;
@@ -3905,7 +3877,7 @@ static int __init blk_mq_init(void)
 	int i;
=20
 	for_each_possible_cpu(i)
-		INIT_LIST_HEAD(&per_cpu(blk_cpu_done, i));
+		init_llist_head(&per_cpu(blk_cpu_done, i));
 	open_softirq(BLOCK_SOFTIRQ, blk_done_softirq);
=20
 	cpuhp_setup_state_nocalls(CPUHP_BLOCK_SOFTIRQ_DEAD,
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 639cae2c158b5..331b2b675b417 100644
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
2.28.0

