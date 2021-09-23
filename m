Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FC52C433F5
	for <linux-block@archiver.kernel.org>; Thu, 23 Sep 2021 23:27:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA2E960F6D
	for <linux-block@archiver.kernel.org>; Thu, 23 Sep 2021 23:27:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243552AbhIWX2p (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Sep 2021 19:28:45 -0400
Received: from mail-pl1-f179.google.com ([209.85.214.179]:39767 "EHLO
        mail-pl1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236363AbhIWX2k (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Sep 2021 19:28:40 -0400
Received: by mail-pl1-f179.google.com with SMTP id c4so5040455pls.6
        for <linux-block@vger.kernel.org>; Thu, 23 Sep 2021 16:27:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7DswubuL4v7lfs81DkcozPb+N+w6XsFHRTyzmjebNwU=;
        b=k7p1F5AGHpzQfwIx03XU+idgFLfVVhcj72cUELbYJn2PwkJ5M2XOon7KXXZ7ManfOO
         +FGPIMqnJMjk+YCKEusK30fJf0I9lq+97JDtAWU6smqi5TuGaaURFi/yb5bHAy7ggfib
         Yj6BlRIvpKZGKik3w1eMORQEAQRC6bhvDYJlRLxHZrSUwA5FPRMc4HQLiDX25bkdE6da
         OWPCXIGUZmana6lDx2eRZAgqTFdS2C0+EDVEsHxFwrtpxv8CGDNKV//bPFORegQO/zin
         x0VIQneZA7aQe+jv9t4kY+QELFy1mNwRptl2xWxiC0iCWVxfUBbGX25l+6CPVhmqNlFR
         FScw==
X-Gm-Message-State: AOAM530Z1EEID6FcBwKRaNEoqlyKd9OUUvyU2qLWQaUSz9+t46sxEJco
        0A2+XsooZPtpy8CQHULARBw=
X-Google-Smtp-Source: ABdhPJypvelVapEXJ3kmYWPCHlQRPeRZ0co1szDlNoy/4o6FIudY5PRcwOzwhVVuK1AUU8wqcU+fkQ==
X-Received: by 2002:a17:902:d2c8:b0:13a:54b2:81c9 with SMTP id n8-20020a170902d2c800b0013a54b281c9mr5964652plc.21.1632439628419;
        Thu, 23 Sep 2021 16:27:08 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:bf91:ebe7:eabf:7473])
        by smtp.gmail.com with ESMTPSA id o14sm6969807pfh.84.2021.09.23.16.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 16:27:07 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH 3/4] block/mq-deadline: Stop using per-CPU counters
Date:   Thu, 23 Sep 2021 16:26:54 -0700
Message-Id: <20210923232655.3907383-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.33.0.685.g46640cef36-goog
In-Reply-To: <20210923232655.3907383-1-bvanassche@acm.org>
References: <20210923232358.3907118-1-bvanassche@acm.org>
 <20210923232655.3907383-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Calculating the sum over all CPUs of per-CPU counters frequently is
inefficient. Hence switch from per-CPU to individual counters. Three
counters are protected by the mq-deadline spinlock since these are
only accessed from contexts that already hold that spinlock. The fourth
counter is atomic because protecting it with the mq-deadline spinlock
would trigger lock contention.

Cc: Damien Le Moal <damien.lemoal@wdc.com>
Cc: Niklas Cassel <Niklas.Cassel@wdc.com>
Cc: Hannes Reinecke <hare@suse.de>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/mq-deadline.c | 124 ++++++++++++++++++++------------------------
 1 file changed, 56 insertions(+), 68 deletions(-)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index 6deb4306bcf3..b0cfc84a4e6b 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -51,17 +51,16 @@ enum dd_prio {
 
 enum { DD_PRIO_COUNT = 3 };
 
-/* I/O statistics per I/O priority. */
+/*
+ * I/O statistics per I/O priority. It is fine if these counters overflow.
+ * What matters is that these counters are at least as wide as
+ * log2(max_outstanding_requests).
+ */
 struct io_stats_per_prio {
-	local_t inserted;
-	local_t merged;
-	local_t dispatched;
-	local_t completed;
-};
-
-/* I/O statistics for all I/O priorities (enum dd_prio). */
-struct io_stats {
-	struct io_stats_per_prio stats[DD_PRIO_COUNT];
+	uint32_t inserted;
+	uint32_t merged;
+	uint32_t dispatched;
+	atomic_t completed;
 };
 
 /*
@@ -74,6 +73,7 @@ struct dd_per_prio {
 	struct list_head fifo_list[DD_DIR_COUNT];
 	/* Next request in FIFO order. Read, write or both are NULL. */
 	struct request *next_rq[DD_DIR_COUNT];
+	struct io_stats_per_prio stats;
 };
 
 struct deadline_data {
@@ -88,8 +88,6 @@ struct deadline_data {
 	unsigned int batching;		/* number of sequential requests made */
 	unsigned int starved;		/* times reads have starved writes */
 
-	struct io_stats __percpu *stats;
-
 	/*
 	 * settings that change how the i/o scheduler behaves
 	 */
@@ -103,33 +101,6 @@ struct deadline_data {
 	spinlock_t zone_lock;
 };
 
-/* Count one event of type 'event_type' and with I/O priority 'prio' */
-#define dd_count(dd, event_type, prio) do {				\
-	struct io_stats *io_stats = get_cpu_ptr((dd)->stats);		\
-									\
-	BUILD_BUG_ON(!__same_type((dd), struct deadline_data *));	\
-	BUILD_BUG_ON(!__same_type((prio), enum dd_prio));		\
-	local_inc(&io_stats->stats[(prio)].event_type);			\
-	put_cpu_ptr(io_stats);						\
-} while (0)
-
-/*
- * Returns the total number of dd_count(dd, event_type, prio) calls across all
- * CPUs. No locking or barriers since it is fine if the returned sum is slightly
- * outdated.
- */
-#define dd_sum(dd, event_type, prio) ({					\
-	unsigned int cpu;						\
-	u32 sum = 0;							\
-									\
-	BUILD_BUG_ON(!__same_type((dd), struct deadline_data *));	\
-	BUILD_BUG_ON(!__same_type((prio), enum dd_prio));		\
-	for_each_present_cpu(cpu)					\
-		sum += local_read(&per_cpu_ptr((dd)->stats, cpu)->	\
-				  stats[(prio)].event_type);		\
-	sum;								\
-})
-
 /* Maps an I/O priority class to a deadline scheduler priority. */
 static const enum dd_prio ioprio_class_to_prio[] = {
 	[IOPRIO_CLASS_NONE]	= DD_BE_PRIO,
@@ -233,7 +204,9 @@ static void dd_merged_requests(struct request_queue *q, struct request *req,
 	const u8 ioprio_class = dd_rq_ioclass(next);
 	const enum dd_prio prio = ioprio_class_to_prio[ioprio_class];
 
-	dd_count(dd, merged, prio);
+	lockdep_assert_held(&dd->lock);
+
+	dd->per_prio[prio].stats.merged++;
 
 	/*
 	 * if next expires before rq, assign its expire time to rq
@@ -273,7 +246,11 @@ deadline_move_request(struct deadline_data *dd, struct dd_per_prio *per_prio,
 /* Number of requests queued for a given priority level. */
 static u32 dd_queued(struct deadline_data *dd, enum dd_prio prio)
 {
-	return dd_sum(dd, inserted, prio) - dd_sum(dd, completed, prio);
+	const struct io_stats_per_prio *stats = &dd->per_prio[prio].stats;
+
+	lockdep_assert_held(&dd->lock);
+
+	return stats->inserted - atomic_read(&stats->completed);
 }
 
 /*
@@ -463,7 +440,7 @@ static struct request *__dd_dispatch_request(struct deadline_data *dd,
 done:
 	ioprio_class = dd_rq_ioclass(rq);
 	prio = ioprio_class_to_prio[ioprio_class];
-	dd_count(dd, dispatched, prio);
+	dd->per_prio[prio].stats.dispatched++;
 	/*
 	 * If the request needs its target zone locked, do it.
 	 */
@@ -542,19 +519,22 @@ static void dd_exit_sched(struct elevator_queue *e)
 
 	for (prio = 0; prio <= DD_PRIO_MAX; prio++) {
 		struct dd_per_prio *per_prio = &dd->per_prio[prio];
+		const struct io_stats_per_prio *stats = &per_prio->stats;
+		uint32_t queued;
 
 		WARN_ON_ONCE(!list_empty(&per_prio->fifo_list[DD_READ]));
 		WARN_ON_ONCE(!list_empty(&per_prio->fifo_list[DD_WRITE]));
-		WARN_ONCE(dd_queued(dd, prio) != 0,
+
+		spin_lock(&dd->lock);
+		queued = dd_queued(dd, prio);
+		spin_unlock(&dd->lock);
+
+		WARN_ONCE(queued,
 			  "statistics for priority %d: i %u m %u d %u c %u\n",
-			  prio, dd_sum(dd, inserted, prio),
-			  dd_sum(dd, merged, prio),
-			  dd_sum(dd, dispatched, prio),
-			  dd_sum(dd, completed, prio));
+			  prio, stats->inserted, stats->merged,
+			  stats->dispatched, atomic_read(&stats->completed));
 	}
 
-	free_percpu(dd->stats);
-
 	kfree(dd);
 }
 
@@ -578,11 +558,6 @@ static int dd_init_sched(struct request_queue *q, struct elevator_type *e)
 
 	eq->elevator_data = dd;
 
-	dd->stats = alloc_percpu_gfp(typeof(*dd->stats),
-				     GFP_KERNEL | __GFP_ZERO);
-	if (!dd->stats)
-		goto free_dd;
-
 	for (prio = 0; prio <= DD_PRIO_MAX; prio++) {
 		struct dd_per_prio *per_prio = &dd->per_prio[prio];
 
@@ -604,9 +579,6 @@ static int dd_init_sched(struct request_queue *q, struct elevator_type *e)
 	q->elevator = eq;
 	return 0;
 
-free_dd:
-	kfree(dd);
-
 put_eq:
 	kobject_put(&eq->kobj);
 	return ret;
@@ -689,8 +661,9 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
 	blk_req_zone_write_unlock(rq);
 
 	prio = ioprio_class_to_prio[ioprio_class];
+	per_prio = &dd->per_prio[prio];
 	if (!rq->elv.priv[0]) {
-		dd_count(dd, inserted, prio);
+		per_prio->stats.inserted++;
 		rq->elv.priv[0] = (void *)(uintptr_t)1;
 	}
 
@@ -701,7 +674,6 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
 
 	trace_block_rq_insert(rq);
 
-	per_prio = &dd->per_prio[prio];
 	if (at_head) {
 		list_add(&rq->queuelist, &per_prio->dispatch);
 	} else {
@@ -779,7 +751,7 @@ static void dd_finish_request(struct request *rq)
 	if (!rq->elv.priv[0])
 		return;
 
-	dd_count(dd, completed, prio);
+	atomic_inc(&per_prio->stats.completed);
 
 	if (blk_queue_is_zoned(q)) {
 		unsigned long flags;
@@ -966,28 +938,44 @@ static int dd_queued_show(void *data, struct seq_file *m)
 {
 	struct request_queue *q = data;
 	struct deadline_data *dd = q->elevator->elevator_data;
+	u32 rt, be, idle;
+
+	spin_lock(&dd->lock);
+	rt = dd_queued(dd, DD_RT_PRIO);
+	be = dd_queued(dd, DD_BE_PRIO);
+	idle = dd_queued(dd, DD_IDLE_PRIO);
+	spin_unlock(&dd->lock);
+
+	seq_printf(m, "%u %u %u\n", rt, be, idle);
 
-	seq_printf(m, "%u %u %u\n", dd_queued(dd, DD_RT_PRIO),
-		   dd_queued(dd, DD_BE_PRIO),
-		   dd_queued(dd, DD_IDLE_PRIO));
 	return 0;
 }
 
 /* Number of requests owned by the block driver for a given priority. */
 static u32 dd_owned_by_driver(struct deadline_data *dd, enum dd_prio prio)
 {
-	return dd_sum(dd, dispatched, prio) + dd_sum(dd, merged, prio)
-		- dd_sum(dd, completed, prio);
+	const struct io_stats_per_prio *stats = &dd->per_prio[prio].stats;
+
+	lockdep_assert_held(&dd->lock);
+
+	return stats->dispatched + stats->merged -
+		atomic_read(&stats->completed);
 }
 
 static int dd_owned_by_driver_show(void *data, struct seq_file *m)
 {
 	struct request_queue *q = data;
 	struct deadline_data *dd = q->elevator->elevator_data;
+	u32 rt, be, idle;
+
+	spin_lock(&dd->lock);
+	rt = dd_owned_by_driver(dd, DD_RT_PRIO);
+	be = dd_owned_by_driver(dd, DD_BE_PRIO);
+	idle = dd_owned_by_driver(dd, DD_IDLE_PRIO);
+	spin_unlock(&dd->lock);
+
+	seq_printf(m, "%u %u %u\n", rt, be, idle);
 
-	seq_printf(m, "%u %u %u\n", dd_owned_by_driver(dd, DD_RT_PRIO),
-		   dd_owned_by_driver(dd, DD_BE_PRIO),
-		   dd_owned_by_driver(dd, DD_IDLE_PRIO));
 	return 0;
 }
 
