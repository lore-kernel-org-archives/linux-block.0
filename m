Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1165C48BE5
	for <linux-block@archiver.kernel.org>; Fri, 18 Jun 2021 00:45:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFFA5613B9
	for <linux-block@archiver.kernel.org>; Fri, 18 Jun 2021 00:45:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233336AbhFRArj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Jun 2021 20:47:39 -0400
Received: from mail-pg1-f179.google.com ([209.85.215.179]:44894 "EHLO
        mail-pg1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233357AbhFRArg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Jun 2021 20:47:36 -0400
Received: by mail-pg1-f179.google.com with SMTP id t13so6337134pgu.11
        for <linux-block@vger.kernel.org>; Thu, 17 Jun 2021 17:45:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G/NbPIPk6Fbqg0V4a4oKvZtObYD2ZQ0ESKFfnDpkuTw=;
        b=Qo9qksV8dnbY2A02/xXQTw1gcfGOvxQO871blhvHNiBoM8gelahO6BGl+oQKq/kRLb
         B5w+YNEOgnFodLrbELPqkVAToBdPrh3qlUNSXJtzUIuW1MNE/pZjxZHaRM8HAceB74Sj
         iflz5LQg+JDGPEUslvR02kmb6ls92tExRVv9IkrA1wuGTSCX2xWk7fzNhjQsndSxumJz
         oYunPLkGbVHN2hTNqO/JiUoU6bAi3p3m2b3wBvftDBS3nWSFfqIPNnuL4zRqknk5pVGS
         lO3fjMlYp98uzPVBmAx/OBJdQJb5X6lYrYrvpZq6aVy54Lvxznca2Msq+6N3uFhyjSvU
         NenA==
X-Gm-Message-State: AOAM530octE4w1K+n4DOOODf4xNwa2XG/mH3nlQzbllD4tMxqnajB+rC
        6luAWPq4HR/ww7oziuIgsfQ=
X-Google-Smtp-Source: ABdhPJxAwz/zff1sjtKGDCfOZqUWEgdZ+gXcIkoHHgLqb0I7wNon3J/nfkHFhJC8vUWOn0BVGaxnEQ==
X-Received: by 2002:a62:7cca:0:b029:2e9:c89d:d8a9 with SMTP id x193-20020a627cca0000b02902e9c89dd8a9mr2330431pfc.55.1623977126651;
        Thu, 17 Jun 2021 17:45:26 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id b10sm6215573pff.14.2021.06.17.17.45.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 17:45:26 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: [PATCH v3 14/16] block/mq-deadline: Track I/O statistics
Date:   Thu, 17 Jun 2021 17:44:54 -0700
Message-Id: <20210618004456.7280-15-bvanassche@acm.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618004456.7280-1-bvanassche@acm.org>
References: <20210618004456.7280-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Track I/O statistics per I/O priority and export these statistics to
debugfs. These statistics help developers of the deadline scheduler.

Cc: Damien Le Moal <damien.lemoal@wdc.com>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: Himanshu Madhani <himanshu.madhani@oracle.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/mq-deadline.c | 100 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 100 insertions(+)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index aba672a5be1e..04d9d6b3745b 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -51,6 +51,19 @@ enum dd_prio {
 
 enum { DD_PRIO_COUNT = 3 };
 
+/* I/O statistics per I/O priority. */
+struct io_stats_per_prio {
+	local_t inserted;
+	local_t merged;
+	local_t dispatched;
+	local_t completed;
+};
+
+/* I/O statistics for all I/O priorities (enum dd_prio). */
+struct io_stats {
+	struct io_stats_per_prio stats[DD_PRIO_COUNT];
+};
+
 /*
  * Deadline scheduler data per I/O priority (enum dd_prio). Requests are
  * present on both sort_list[] and fifo_list[].
@@ -75,6 +88,8 @@ struct deadline_data {
 	unsigned int batching;		/* number of sequential requests made */
 	unsigned int starved;		/* times reads have starved writes */
 
+	struct io_stats __percpu *stats;
+
 	/*
 	 * settings that change how the i/o scheduler behaves
 	 */
@@ -88,6 +103,33 @@ struct deadline_data {
 	spinlock_t zone_lock;
 };
 
+/* Count one event of type 'event_type' and with I/O priority 'prio' */
+#define dd_count(dd, event_type, prio) do {				\
+	struct io_stats *io_stats = get_cpu_ptr((dd)->stats);		\
+									\
+	BUILD_BUG_ON(!__same_type((dd), struct deadline_data *));	\
+	BUILD_BUG_ON(!__same_type((prio), enum dd_prio));		\
+	local_inc(&io_stats->stats[(prio)].event_type);			\
+	put_cpu_ptr(io_stats);						\
+} while (0)
+
+/*
+ * Returns the total number of dd_count(dd, event_type, prio) calls across all
+ * CPUs. No locking or barriers since it is fine if the returned sum is slightly
+ * outdated.
+ */
+#define dd_sum(dd, event_type, prio) ({					\
+	unsigned int cpu;						\
+	u32 sum = 0;							\
+									\
+	BUILD_BUG_ON(!__same_type((dd), struct deadline_data *));	\
+	BUILD_BUG_ON(!__same_type((prio), enum dd_prio));		\
+	for_each_present_cpu(cpu)					\
+		sum += local_read(&per_cpu_ptr((dd)->stats, cpu)->	\
+				  stats[(prio)].event_type);		\
+	sum;								\
+})
+
 /* Maps an I/O priority class to a deadline scheduler priority. */
 static const enum dd_prio ioprio_class_to_prio[] = {
 	[IOPRIO_CLASS_NONE]	= DD_BE_PRIO,
@@ -187,9 +229,12 @@ static void dd_request_merged(struct request_queue *q, struct request *req,
 static void dd_merged_requests(struct request_queue *q, struct request *req,
 			       struct request *next)
 {
+	struct deadline_data *dd = q->elevator->elevator_data;
 	const u8 ioprio_class = dd_rq_ioclass(next);
 	const enum dd_prio prio = ioprio_class_to_prio[ioprio_class];
 
+	dd_count(dd, merged, prio);
+
 	/*
 	 * if next expires before rq, assign its expire time to rq
 	 * and move into next position (next will be deleted) in fifo
@@ -225,6 +270,12 @@ deadline_move_request(struct deadline_data *dd, struct dd_per_prio *per_prio,
 	deadline_remove_request(rq->q, per_prio, rq);
 }
 
+/* Number of requests queued for a given priority level. */
+static u32 dd_queued(struct deadline_data *dd, enum dd_prio prio)
+{
+	return dd_sum(dd, inserted, prio) - dd_sum(dd, completed, prio);
+}
+
 /*
  * deadline_check_fifo returns 0 if there are no expired requests on the fifo,
  * 1 otherwise. Requires !list_empty(&dd->fifo_list[data_dir])
@@ -319,6 +370,8 @@ static struct request *__dd_dispatch_request(struct deadline_data *dd,
 {
 	struct request *rq, *next_rq;
 	enum dd_data_dir data_dir;
+	enum dd_prio prio;
+	u8 ioprio_class;
 
 	lockdep_assert_held(&dd->lock);
 
@@ -408,6 +461,9 @@ static struct request *__dd_dispatch_request(struct deadline_data *dd,
 	dd->batching++;
 	deadline_move_request(dd, per_prio, rq);
 done:
+	ioprio_class = dd_rq_ioclass(rq);
+	prio = ioprio_class_to_prio[ioprio_class];
+	dd_count(dd, dispatched, prio);
 	/*
 	 * If the request needs its target zone locked, do it.
 	 */
@@ -491,6 +547,8 @@ static void dd_exit_sched(struct elevator_queue *e)
 		WARN_ON_ONCE(!list_empty(&per_prio->fifo_list[DD_WRITE]));
 	}
 
+	free_percpu(dd->stats);
+
 	kfree(dd);
 }
 
@@ -514,6 +572,11 @@ static int dd_init_sched(struct request_queue *q, struct elevator_type *e)
 
 	eq->elevator_data = dd;
 
+	dd->stats = alloc_percpu_gfp(typeof(*dd->stats),
+				     GFP_KERNEL | __GFP_ZERO);
+	if (!dd->stats)
+		goto free_dd;
+
 	for (prio = 0; prio <= DD_PRIO_MAX; prio++) {
 		struct dd_per_prio *per_prio = &dd->per_prio[prio];
 
@@ -535,6 +598,9 @@ static int dd_init_sched(struct request_queue *q, struct elevator_type *e)
 	q->elevator = eq;
 	return 0;
 
+free_dd:
+	kfree(dd);
+
 put_eq:
 	kobject_put(&eq->kobj);
 	return ret;
@@ -614,6 +680,7 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
 	blk_req_zone_write_unlock(rq);
 
 	prio = ioprio_class_to_prio[ioprio_class];
+	dd_count(dd, inserted, prio);
 
 	if (blk_mq_sched_try_insert_merge(q, rq))
 		return;
@@ -692,6 +759,8 @@ static void dd_finish_request(struct request *rq)
 	const enum dd_prio prio = ioprio_class_to_prio[ioprio_class];
 	struct dd_per_prio *per_prio = &dd->per_prio[prio];
 
+	dd_count(dd, completed, prio);
+
 	if (blk_queue_is_zoned(q)) {
 		unsigned long flags;
 
@@ -873,6 +942,35 @@ static int dd_async_depth_show(void *data, struct seq_file *m)
 	return 0;
 }
 
+static int dd_queued_show(void *data, struct seq_file *m)
+{
+	struct request_queue *q = data;
+	struct deadline_data *dd = q->elevator->elevator_data;
+
+	seq_printf(m, "%u %u %u\n", dd_queued(dd, DD_RT_PRIO),
+		   dd_queued(dd, DD_BE_PRIO),
+		   dd_queued(dd, DD_IDLE_PRIO));
+	return 0;
+}
+
+/* Number of requests owned by the block driver for a given priority. */
+static u32 dd_owned_by_driver(struct deadline_data *dd, enum dd_prio prio)
+{
+	return dd_sum(dd, dispatched, prio) + dd_sum(dd, merged, prio)
+		- dd_sum(dd, completed, prio);
+}
+
+static int dd_owned_by_driver_show(void *data, struct seq_file *m)
+{
+	struct request_queue *q = data;
+	struct deadline_data *dd = q->elevator->elevator_data;
+
+	seq_printf(m, "%u %u %u\n", dd_owned_by_driver(dd, DD_RT_PRIO),
+		   dd_owned_by_driver(dd, DD_BE_PRIO),
+		   dd_owned_by_driver(dd, DD_IDLE_PRIO));
+	return 0;
+}
+
 #define DEADLINE_DISPATCH_ATTR(prio)					\
 static void *deadline_dispatch##prio##_start(struct seq_file *m,	\
 					     loff_t *pos)		\
@@ -941,6 +1039,8 @@ static const struct blk_mq_debugfs_attr deadline_queue_debugfs_attrs[] = {
 	{"dispatch0", 0400, .seq_ops = &deadline_dispatch0_seq_ops},
 	{"dispatch1", 0400, .seq_ops = &deadline_dispatch1_seq_ops},
 	{"dispatch2", 0400, .seq_ops = &deadline_dispatch2_seq_ops},
+	{"owned_by_driver", 0400, dd_owned_by_driver_show},
+	{"queued", 0400, dd_queued_show},
 	{},
 };
 #undef DEADLINE_QUEUE_DDIR_ATTRS
