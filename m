Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF75AC2BBCD
	for <linux-block@archiver.kernel.org>; Mon, 14 Dec 2020 20:22:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 820D42250F
	for <linux-block@archiver.kernel.org>; Mon, 14 Dec 2020 20:22:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503178AbgLNUWC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Dec 2020 15:22:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503168AbgLNUVx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Dec 2020 15:21:53 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0001DC0617B0
        for <linux-block@vger.kernel.org>; Mon, 14 Dec 2020 12:20:33 -0800 (PST)
Date:   Mon, 14 Dec 2020 21:20:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607977232;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lgL1tCW7FY8sMUSn4SRzYgB1M93WvNiach1gSgMwwSA=;
        b=JPXu00F0XR/WepyWDOHmv/AsuiYvPEx64G54+x4Vu6EBSSHXS7L2ozKtecRkfgdPz+k6VR
        V8Cdt/ZwiQZ/UFsGCbrrtpQQmMrPDElwxLzodBln6orIUJTb7DcNwYOi13K08i68tdsxiT
        LHol6Bu3xe0owUZv7hdOLFFJSzhCu0n9j1IdQEFtO1DRnZkeJ08uAi/Ppf3OpZ7bV8ZEsr
        QLiST6vE+H2tCo21N5muPSnT93KHJbyopj8YtP8Jdebm8OZpYWTpukWxiXjP+r6+wBaehl
        aWG1gBvScCQXSF6jUjmVEnTH4dW6pVwr6Y37t3lrj0INccq0K0aXULoLZ5nLLg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607977232;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lgL1tCW7FY8sMUSn4SRzYgB1M93WvNiach1gSgMwwSA=;
        b=TlEx60fTFgWgel1TCStDtmQHM/cRhezsqQvG9YvWywEsLq82ux+HmVK+f+tVB6L9WaY9TO
        TaS3KZJZyAWMB4AA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Wagner <dwagner@suse.de>,
        Mike Galbraith <efault@gmx.de>,
        Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 3/3] blk-mq: Use llist_head for blk_cpu_done
Message-ID: <20201214202030.izhm4byeznfjoobe@linutronix.de>
References: <20201204191356.2516405-1-bigeasy@linutronix.de>
 <20201204191356.2516405-4-bigeasy@linutronix.de>
 <20201208132004.GC22219@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20201208132004.GC22219@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020-12-08 13:20:04 [+0000], Christoph Hellwig wrote:
> > --- a/block/blk-mq.c
> > +++ b/block/blk-mq.c
> > @@ -41,7 +41,7 @@
> >  #include "blk-mq-sched.h"
> >  #include "blk-rq-qos.h"
> > =20
> > +static DEFINE_PER_CPU(struct llist_head, blk_cpu_done);
> > =20
> >  static void blk_mq_poll_stats_start(struct request_queue *q);
> >  static void blk_mq_poll_stats_fn(struct blk_stat_callback *cb);
> > @@ -567,68 +567,32 @@ void blk_mq_end_request(struct request *rq, blk_s=
tatus_t error)
> >  }
> >  EXPORT_SYMBOL(blk_mq_end_request);
> > =20
> > +static void blk_complete_reqs(struct llist_head *cpu_list)
> >  {
> > +	struct llist_node *entry;
> > +	struct request *rq, *rq_next;
> > =20
> > +	entry =3D llist_del_all(cpu_list);
> > +	entry =3D llist_reverse_order(entry);
>=20
> I find the variable naming and split of the assignments a little
> strange.  What about:
>=20
> static void blk_complete_reqs(struct llist_head *list)
> {
> 	struct llist_node *first =3D llist_reverse_order(llist_del_all(list));
> 	struct request *rq, *next;
>=20
> ?

Sure.

> > +	llist_for_each_entry_safe(rq, rq_next, entry, ipi_list)
> >  		rq->q->mq_ops->complete(rq);
> >  }
>=20
> Aren't some sanitizers going to be unhappy if we never delete the
> request from the list?

I don't think so. If so there is more to complain about like,
flush_smp_call_function_queue(), delayed_mntput(),
irq_work_run_list(), ...


> >  bool blk_mq_complete_request_remote(struct request *rq)
> >  {
> > +	struct llist_head *cpu_list;
> >  	WRITE_ONCE(rq->state, MQ_RQ_COMPLETE);
> > =20
> >  	/*
> > @@ -669,12 +634,22 @@ bool blk_mq_complete_request_remote(struct reques=
t *rq)
> >  		return false;
> > =20
> >  	if (blk_mq_complete_need_ipi(rq)) {
> > +		unsigned int cpu;
> > +
> > +		cpu =3D rq->mq_ctx->cpu;
> > +		cpu_list =3D &per_cpu(blk_cpu_done, cpu);
> > +		if (llist_add(&rq->ipi_list, cpu_list)) {
> > +			INIT_CSD(&rq->csd, __blk_mq_complete_request_remote, rq);
> > +			smp_call_function_single_async(cpu, &rq->csd);
> > +		}
>=20
> I think the above code section inside the conditional should go into a
> little helper instead of being open coded here in the fast path routine.
> I laso don't really see the =B6oint of the cpu and cpulist locl variables.
>=20
> >  	} else {
> >  		if (rq->q->nr_hw_queues > 1)
> >  			return false;
> > +		preempt_disable();
> > +		cpu_list =3D this_cpu_ptr(&blk_cpu_done);
> > +		if (llist_add(&rq->ipi_list, cpu_list))
> > +			raise_softirq(BLOCK_SOFTIRQ);
> > +		preempt_enable();
>=20
> I think the section after the return false here also would benefit from
> a little helper with a descriptive name.
>=20
> Otherwise this looks good to me.

Please see below.

----->8-------

=46rom: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Date: Wed, 28 Oct 2020 11:08:21 +0100
Subject: [PATCH] blk-mq: Use llist_head for blk_cpu_done

With llist_head it is possible to avoid the locking (the irq-off region)
when items are added. This makes it possible to add items on a remote
CPU without additional locking.
llist_add() returns true if the list was previously empty. This can be
used to invoke the SMP function call / raise sofirq only if the first
item was added (otherwise it is already pending).
This simplifies the code a little and reduces the IRQ-off regions.

blk_mq_raise_softirq() needs a preempt-disable section to ensure the
request is enqueued on the same CPU as the softirq is raised.
Some callers (USB-storage) invoke this path in preemptible context.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 block/blk-mq.c         | 97 ++++++++++++++++++------------------------
 include/linux/blkdev.h |  2 +-
 2 files changed, 42 insertions(+), 57 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 9baa681f6ee67..959b45fd41882 100644
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
@@ -567,68 +567,29 @@ void blk_mq_end_request(struct request *rq, blk_statu=
s_t error)
 }
 EXPORT_SYMBOL(blk_mq_end_request);
=20
-/*
- * Softirq action handler - move entries to local list and loop over them
- * while passing them to the queue registered handler.
- */
-static __latent_entropy void blk_done_softirq(struct softirq_action *h)
+static void blk_complete_reqs(struct llist_head *list)
 {
-	struct list_head *cpu_list, local_list;
+	struct llist_node *entry =3D llist_reverse_order(llist_del_all(list));
+	struct request *rq, *next;
=20
-	local_irq_disable();
-	cpu_list =3D this_cpu_ptr(&blk_cpu_done);
-	list_replace_init(cpu_list, &local_list);
-	local_irq_enable();
-
-	while (!list_empty(&local_list)) {
-		struct request *rq;
-
-		rq =3D list_entry(local_list.next, struct request, ipi_list);
-		list_del_init(&rq->ipi_list);
+	llist_for_each_entry_safe(rq, next, entry, ipi_list)
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
@@ -657,6 +618,30 @@ static inline bool blk_mq_complete_need_ipi(struct req=
uest *rq)
 	return cpu_online(rq->mq_ctx->cpu);
 }
=20
+static void blk_mq_complete_send_ipi(struct request *rq)
+{
+	struct llist_head *list;
+	unsigned int cpu;
+
+	cpu =3D rq->mq_ctx->cpu;
+	list =3D &per_cpu(blk_cpu_done, cpu);
+	if (llist_add(&rq->ipi_list, list)) {
+		INIT_CSD(&rq->csd, __blk_mq_complete_request_remote, rq);
+		smp_call_function_single_async(cpu, &rq->csd);
+	}
+}
+
+static void blk_mq_raise_softirq(struct request *rq)
+{
+	struct llist_head *list;
+
+	preempt_disable();
+	list =3D this_cpu_ptr(&blk_cpu_done);
+	if (llist_add(&rq->ipi_list, list))
+		raise_softirq(BLOCK_SOFTIRQ);
+	preempt_enable();
+}
+
 bool blk_mq_complete_request_remote(struct request *rq)
 {
 	WRITE_ONCE(rq->state, MQ_RQ_COMPLETE);
@@ -669,15 +654,15 @@ bool blk_mq_complete_request_remote(struct request *r=
q)
 		return false;
=20
 	if (blk_mq_complete_need_ipi(rq)) {
-		INIT_CSD(&rq->csd, __blk_mq_complete_request_remote, rq);
-		smp_call_function_single_async(rq->mq_ctx->cpu, &rq->csd);
-	} else {
-		if (rq->q->nr_hw_queues > 1)
-			return false;
-		blk_mq_trigger_softirq(rq);
+		blk_mq_complete_send_ipi(rq);
+		return true;
 	}
=20
-	return true;
+	if (rq->q->nr_hw_queues =3D=3D 1) {
+		blk_mq_raise_softirq(rq);
+		return true;
+	}
+	return false;
 }
 EXPORT_SYMBOL_GPL(blk_mq_complete_request_remote);
=20
@@ -3917,7 +3902,7 @@ static int __init blk_mq_init(void)
 	int i;
=20
 	for_each_possible_cpu(i)
-		INIT_LIST_HEAD(&per_cpu(blk_cpu_done, i));
+		init_llist_head(&per_cpu(blk_cpu_done, i));
 	open_softirq(BLOCK_SOFTIRQ, blk_done_softirq);
=20
 	cpuhp_setup_state_nocalls(CPUHP_BLOCK_SOFTIRQ_DEAD,
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index f94ee3089e015..89a444c5a5833 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -153,7 +153,7 @@ struct request {
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

