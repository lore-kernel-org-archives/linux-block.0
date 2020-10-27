Return-Path: <SRS0=+SaT=EC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 882AFC55178
	for <linux-block@archiver.kernel.org>; Tue, 27 Oct 2020 20:58:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AE8B2222C
	for <linux-block@archiver.kernel.org>; Tue, 27 Oct 2020 20:58:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OCXS40Fv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GHAeAruU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S373474AbgJ0U6L (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Oct 2020 16:58:11 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49188 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S373468AbgJ0U6K (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Oct 2020 16:58:10 -0400
Date:   Tue, 27 Oct 2020 21:58:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603832287;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=F0fJAkaJOg8MghLZ3WG/sCJuQU/mVqUutTyE3oHxMzk=;
        b=OCXS40Fvu9bQ6xCZaPug1KgaEmYKhXN/ZJ0k4P8VVRI2Tn6uMCLWJWkjnf8gIxEngul2+X
        mXTIHdNex5s7rq9bE9hgbcOB73QRTEDlIjtYfQDWyP8SvmKxKyHXGwCt5loVW0lOUXk+gs
        F7c3CaXAedTVsLkrnGdg7SJxnkpvTEF3v+8tXTCL5ErFaz2KMq/Shhqr7xu3EjgpEt4+68
        IXHwkYjnj1GfmhodJFblNq8QlHtIvnATLxy/q2ZEz9b1m1YC4q+3okhAK9iiB2J9QR/zTd
        Y+Te+uDDyJ7yW2qi6cdra41TXaphnfHmfogxYU1cp2F07uREdQ4iq0J1XkZIuQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603832287;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=F0fJAkaJOg8MghLZ3WG/sCJuQU/mVqUutTyE3oHxMzk=;
        b=GHAeAruUaSSLW9G3JOZouivv79VFgzdGEu5igh8KPJTlMXQq2AlG8Sy380jTg6FjuJJEod
        Rr7B6BYfwg2clIBw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        David Runge <dave@sleepmap.de>, linux-rt-users@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Wagner <dwagner@suse.de>
Subject: Re: [PATCH RFC] blk-mq: Don't IPI requests on PREEMPT_RT
Message-ID: <20201027205806.s7qau5xf4lzuslcu@linutronix.de>
References: <20201021175059.GA4989@hmbx>
 <20201023110400.bx3uzsb7xy5jtsea@linutronix.de>
 <20201023112130.GA23790@infradead.org>
 <20201023135219.mzzl76eqqy6tqwhe@linutronix.de>
 <20201027092606.GA20805@infradead.org>
 <20201027101102.cvczdb3mkvtoguo5@linutronix.de>
 <20201027160742.GA19073@infradead.org>
 <87eelj1tx0.fsf@nanos.tec.linutronix.de>
 <20201027172309.GA15004@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201027172309.GA15004@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020-10-27 17:23:09 [+0000], Christoph Hellwig wrote:
> Ok.  I was hoping we could hide this in core code somehow, especially
> a peterz didn't like the use of smp_call_function_single_async in the
> blk-mq completion code very much.

No idea how you could efficiently avoid smp_call_function_single_async():
- workqueue (okay)
- a timer_list timer which expires now. More code plus it may delay up
  to HZ.

> Sebastian, would this solve your preempt-rt and lockdep issues?

the problem with that is that on RT/force-threaded it will always wake
ksoftirqd thread and complete there. That are extra steps which should
be probably avoided.

Now.
The hunk in blk_mq_complete_need_ipi() will avoid the waking a thread
with force-threaded enabled.

The remaining part is a switch to llist which avoids locking (IRQ
off/on) and it allows invoke the IPI/raise softirq only if something was
added. The entries are now processed in the reverse order but this
shouldn't matter right?

I would split this into two patches (the blk_mq_complete_need_ipi() hunk
and the llist part) unless there are objections.

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 55bcee5dc0320..d2452ee9b0e2c 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -41,7 +41,7 @@
 #include "blk-mq-sched.h"
 #include "blk-rq-qos.h"
 
-static DEFINE_PER_CPU(struct list_head, blk_cpu_done);
+static DEFINE_PER_CPU(struct llist_head, blk_cpu_done);
 
 static void blk_mq_poll_stats_start(struct request_queue *q);
 static void blk_mq_poll_stats_fn(struct blk_stat_callback *cb);
@@ -565,80 +565,31 @@ void blk_mq_end_request(struct request *rq, blk_status_t error)
 }
 EXPORT_SYMBOL(blk_mq_end_request);
 
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
 
-	local_irq_disable();
-	cpu_list = this_cpu_ptr(&blk_cpu_done);
-	list_replace_init(cpu_list, &local_list);
-	local_irq_enable();
+	entry = llist_del_all(cpu_list);
 
-	while (!list_empty(&local_list)) {
-		struct request *rq;
-
-		rq = list_entry(local_list.next, struct request, ipi_list);
-		list_del_init(&rq->ipi_list);
+	llist_for_each_entry_safe(rq, rq_next, entry, ipi_list)
 		rq->q->mq_ops->complete(rq);
-	}
 }
 
-static void blk_mq_trigger_softirq(struct request *rq)
+static __latent_entropy void blk_done_softirq(struct softirq_action *h)
 {
-	struct list_head *list;
-	unsigned long flags;
-
-	local_irq_save(flags);
-	list = this_cpu_ptr(&blk_cpu_done);
-	list_add_tail(&rq->ipi_list, list);
-
-	/*
-	 * If the list only contains our just added request, signal a raise of
-	 * the softirq.  If there are already entries there, someone already
-	 * raised the irq but it hasn't run yet.
-	 */
-	if (list->next == &rq->ipi_list)
-		raise_softirq_irqoff(BLOCK_SOFTIRQ);
-	local_irq_restore(flags);
+	blk_complete_reqs(this_cpu_ptr(&blk_cpu_done));
 }
 
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
 
-
 static void __blk_mq_complete_request_remote(void *data)
 {
-	struct request *rq = data;
-
-	/*
-	 * For most of single queue controllers, there is only one irq vector
-	 * for handling I/O completion, and the only irq's affinity is set
-	 * to all possible CPUs.  On most of ARCHs, this affinity means the irq
-	 * is handled on one specific CPU.
-	 *
-	 * So complete I/O requests in softirq context in case of single queue
-	 * devices to avoid degrading I/O performance due to irqsoff latency.
-	 */
-	if (rq->q->nr_hw_queues == 1)
-		blk_mq_trigger_softirq(rq);
-	else
-		rq->q->mq_ops->complete(rq);
+	__raise_softirq_irqoff(BLOCK_SOFTIRQ);
 }
 
 static inline bool blk_mq_complete_need_ipi(struct request *rq)
@@ -648,6 +599,14 @@ static inline bool blk_mq_complete_need_ipi(struct request *rq)
 	if (!IS_ENABLED(CONFIG_SMP) ||
 	    !test_bit(QUEUE_FLAG_SAME_COMP, &rq->q->queue_flags))
 		return false;
+	/*
+	 * With force threaded interrupts enabled, raising softirq from an SMP
+	 * function call will always result in waking the ksoftirqd thread.
+	 * This is probably worse than completing the request on a different
+	 * cache domain.
+	 */
+       if (force_irqthreads)
+               return false;
 
 	/* same CPU or cache domain?  Complete locally */
 	if (cpu == rq->mq_ctx->cpu ||
@@ -661,6 +620,7 @@ static inline bool blk_mq_complete_need_ipi(struct request *rq)
 
 bool blk_mq_complete_request_remote(struct request *rq)
 {
+	struct llist_head *cpu_list;
 	WRITE_ONCE(rq->state, MQ_RQ_COMPLETE);
 
 	/*
@@ -671,14 +631,21 @@ bool blk_mq_complete_request_remote(struct request *rq)
 		return false;
 
 	if (blk_mq_complete_need_ipi(rq)) {
-		rq->csd.func = __blk_mq_complete_request_remote;
-		rq->csd.info = rq;
-		rq->csd.flags = 0;
-		smp_call_function_single_async(rq->mq_ctx->cpu, &rq->csd);
+		unsigned int cpu;
+
+		cpu = rq->mq_ctx->cpu;
+		cpu_list = &per_cpu(blk_cpu_done, cpu);
+		if (llist_add(&rq->ipi_list, cpu_list)) {
+			rq->csd.func = __blk_mq_complete_request_remote;
+			rq->csd.flags = 0;
+			smp_call_function_single_async(cpu, &rq->csd);
+		}
 	} else {
 		if (rq->q->nr_hw_queues > 1)
 			return false;
-		blk_mq_trigger_softirq(rq);
+		cpu_list = this_cpu_ptr(&blk_cpu_done);
+		if (llist_add(&rq->ipi_list, cpu_list))
+			raise_softirq(BLOCK_SOFTIRQ);
 	}
 
 	return true;
@@ -3909,7 +3876,7 @@ static int __init blk_mq_init(void)
 	int i;
 
 	for_each_possible_cpu(i)
-		INIT_LIST_HEAD(&per_cpu(blk_cpu_done, i));
+		init_llist_head(&per_cpu(blk_cpu_done, i));
 	open_softirq(BLOCK_SOFTIRQ, blk_done_softirq);
 
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
 
 	/*
