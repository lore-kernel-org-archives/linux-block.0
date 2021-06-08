Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59AC1C48BD1
	for <linux-block@archiver.kernel.org>; Tue,  8 Jun 2021 23:07:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4483261361
	for <linux-block@archiver.kernel.org>; Tue,  8 Jun 2021 23:07:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235255AbhFHXJe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Jun 2021 19:09:34 -0400
Received: from mail-pj1-f43.google.com ([209.85.216.43]:42773 "EHLO
        mail-pj1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235066AbhFHXJe (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Jun 2021 19:09:34 -0400
Received: by mail-pj1-f43.google.com with SMTP id md2-20020a17090b23c2b029016de4440381so247031pjb.1
        for <linux-block@vger.kernel.org>; Tue, 08 Jun 2021 16:07:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gBFsEB9EnxjTh68lBTEfYlcHmXH6z+4Ffq6g5I1YRPI=;
        b=lTGmBqnrY44cXeInD96POwCHLT4C6+tROGzunrXx3BE0PmM6t5M9/gJYG9EBow6ypC
         UZs+VwZ4L9E5/cfpeF9aS3tAKJrWnC9BFfWmajjNqXhKqrRleR+ke3wxN9cyDNJkgEvl
         3wVQdht+2YeG67EkYfVCgryHM9yvRz6DBVli2Tm2jJxiQUaynMie0yY6dmOMe7irvcqw
         bTc4LOTlzTXIEwYyhHz+v1nfnusFAQN4SWo3mNSNrhYSyaxqqJAiNxlYlXbQnnCju+HT
         hric5h1GqZolz1aDDhhnybtZKqFXqfdyN78/FoYxcpd2NV1lRb1kDE7j2B53oh9mcorn
         pwyg==
X-Gm-Message-State: AOAM530UKWuDmy+WTziuGFR5znE2mJ8WNfr59wNycOfO6FsreYKnTpAC
        KiapAp6ZYrJL0sQmFFb5lZ4=
X-Google-Smtp-Source: ABdhPJyz8E/p4ps6cDLIHqcTHDZsg2N+zJ6MDv4zgTQTB7GAEM5EeBoQX2UAET2IShT+T+ymYC1QLQ==
X-Received: by 2002:a17:903:2281:b029:113:1edb:97d0 with SMTP id b1-20020a1709032281b02901131edb97d0mr2109313plh.64.1623193650532;
        Tue, 08 Jun 2021 16:07:30 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id s21sm11395838pfw.57.2021.06.08.16.07.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 16:07:29 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: [PATCH 13/14] block/mq-deadline: Add cgroup support
Date:   Tue,  8 Jun 2021 16:07:02 -0700
Message-Id: <20210608230703.19510-14-bvanassche@acm.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210608230703.19510-1-bvanassche@acm.org>
References: <20210608230703.19510-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Maintain statistics per cgroup and export these to user space. These
statistics are essential for verifying whether the proper I/O priorities
have been assigned to requests. With this patch applied the output of
(cd /sys/fs/cgroup/blkio/ && ls) is as follows:
blkio.dd.dispatched_pri0  blkio.dd.inserted_pri3  cgroup.clone_children
blkio.dd.dispatched_pri1  blkio.dd.merged_pri0    cgroup.procs
blkio.dd.dispatched_pri2  blkio.dd.merged_pri1    cgroup.sane_behavior
blkio.dd.dispatched_pri3  blkio.dd.merged_pri2    notify_on_release
blkio.dd.inserted_pri0    blkio.dd.merged_pri3    release_agent
blkio.dd.inserted_pri1    blkio.prio.class        tasks
blkio.dd.inserted_pri2    blkio.reset_stats

Cc: Damien Le Moal <damien.lemoal@wdc.com>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: Himanshu Madhani <himanshu.madhani@oracle.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/Kconfig.iosched                       |   6 +
 block/Makefile                              |   2 +
 block/mq-deadline-cgroup.c                  | 185 ++++++++++++++++++++
 block/mq-deadline-cgroup.h                  | 112 ++++++++++++
 block/{mq-deadline.c => mq-deadline-main.c} |  85 +++++++--
 5 files changed, 376 insertions(+), 14 deletions(-)
 create mode 100644 block/mq-deadline-cgroup.c
 create mode 100644 block/mq-deadline-cgroup.h
 rename block/{mq-deadline.c => mq-deadline-main.c} (94%)

diff --git a/block/Kconfig.iosched b/block/Kconfig.iosched
index 2f2158e05a91..64053d67a97b 100644
--- a/block/Kconfig.iosched
+++ b/block/Kconfig.iosched
@@ -9,6 +9,12 @@ config MQ_IOSCHED_DEADLINE
 	help
 	  MQ version of the deadline IO scheduler.
 
+config MQ_IOSCHED_DEADLINE_CGROUP
+       tristate
+       default y
+       depends on MQ_IOSCHED_DEADLINE
+       depends on BLK_CGROUP
+
 config MQ_IOSCHED_KYBER
 	tristate "Kyber I/O scheduler"
 	default y
diff --git a/block/Makefile b/block/Makefile
index af3d044abaf1..b9db5d4edfc8 100644
--- a/block/Makefile
+++ b/block/Makefile
@@ -21,6 +21,8 @@ obj-$(CONFIG_BLK_CGROUP_IOPRIO)	+= blk-ioprio.o
 obj-$(CONFIG_BLK_CGROUP_IOLATENCY)	+= blk-iolatency.o
 obj-$(CONFIG_BLK_CGROUP_IOCOST)	+= blk-iocost.o
 obj-$(CONFIG_MQ_IOSCHED_DEADLINE)	+= mq-deadline.o
+mq-deadline-y += mq-deadline-main.o
+mq-deadline-$(CONFIG_MQ_IOSCHED_DEADLINE_CGROUP)+= mq-deadline-cgroup.o
 obj-$(CONFIG_MQ_IOSCHED_KYBER)	+= kyber-iosched.o
 bfq-y				:= bfq-iosched.o bfq-wf2q.o bfq-cgroup.o
 obj-$(CONFIG_IOSCHED_BFQ)	+= bfq.o
diff --git a/block/mq-deadline-cgroup.c b/block/mq-deadline-cgroup.c
new file mode 100644
index 000000000000..73b04e5a577f
--- /dev/null
+++ b/block/mq-deadline-cgroup.c
@@ -0,0 +1,185 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/blk-cgroup.h>
+#include <linux/ioprio.h>
+
+#include "mq-deadline-cgroup.h"
+
+static struct blkcg_policy dd_blkcg_policy;
+
+static struct dd_blkcg *dd_blkcg_from_css(struct cgroup_subsys_state *css)
+{
+	struct blkcg *blkcg = css_to_blkcg(css);
+	struct blkcg_policy_data *cpd = blkcg_to_cpd(blkcg, &dd_blkcg_policy);
+
+	return container_of(cpd, struct dd_blkcg, cpd);
+}
+
+/*
+ * Number of inserted but not completed requests for priority class
+ * cft->private.
+ */
+static u64 dd_show_inserted(struct cgroup_subsys_state *css,
+			      struct cftype *cft)
+{
+	struct dd_blkcg *blkcg = dd_blkcg_from_css(css);
+	const u8 prio = cft->private;
+
+	return ddcg_sum(blkcg, inserted, prio) -
+		ddcg_sum(blkcg, completed, prio);
+}
+
+/* Number of merged requests for priority class cft->private. */
+static u64 dd_show_merged(struct cgroup_subsys_state *css, struct cftype *cft)
+{
+	struct dd_blkcg *blkcg = dd_blkcg_from_css(css);
+	const u8 prio = cft->private;
+
+	return ddcg_sum(blkcg, merged, prio);
+}
+
+/*
+ * Number of dispatched but not completed requests for priority class
+ * cft->private.
+ */
+static u64 dd_show_dispatched(struct cgroup_subsys_state *css,
+			      struct cftype *cft)
+{
+	struct dd_blkcg *blkcg = dd_blkcg_from_css(css);
+	const u8 prio = cft->private;
+
+	return ddcg_sum(blkcg, dispatched, prio) +
+		ddcg_sum(blkcg, merged, prio) -
+		ddcg_sum(blkcg, completed, prio);
+}
+
+#define IOPRI_ATTRS(pfx, cft_flags, callback)		\
+	{						\
+		.name		= pfx "0",		\
+		.private	= IOPRIO_CLASS_NONE,	\
+		.flags		= cft_flags,		\
+		.read_u64	= callback,		\
+	},						\
+	{						\
+		.name		= pfx "1",		\
+		.private	= IOPRIO_CLASS_RT,	\
+		.flags		= cft_flags,		\
+		.read_u64	= callback,		\
+	},						\
+	{						\
+		.name		= pfx "2",		\
+		.private	= IOPRIO_CLASS_BE,	\
+		.flags		= cft_flags,		\
+		.read_u64	= callback,		\
+	},						\
+	{						\
+		.name		= pfx "3",		\
+		.private	= IOPRIO_CLASS_IDLE,	\
+		.flags		= cft_flags,		\
+		.read_u64	= callback,		\
+	}
+
+#define DD_ATTRS							\
+	IOPRI_ATTRS("dd.inserted_pri", 0, dd_show_inserted),		\
+	IOPRI_ATTRS("dd.merged_pri", 0, dd_show_merged),		\
+	IOPRI_ATTRS("dd.dispatched_pri", 0, dd_show_dispatched),	\
+	{ } /* sentinel */
+
+/* cgroup v2 attributes */
+static struct cftype dd_blkcg_files[] = {
+	DD_ATTRS
+};
+
+/* cgroup v1 attributes */
+static struct cftype dd_blkcg_legacy_files[] = {
+	DD_ATTRS
+};
+
+static struct blkcg_policy_data *dd_cpd_alloc(gfp_t gfp)
+{
+	struct dd_blkcg *pd;
+
+	pd = kzalloc(sizeof(*pd), gfp);
+	if (!pd)
+		return NULL;
+	pd->stats = alloc_percpu_gfp(typeof(*pd->stats),
+				     GFP_KERNEL | __GFP_ZERO);
+	if (!pd->stats) {
+		kfree(pd);
+		return NULL;
+	}
+	return &pd->cpd;
+}
+
+static void dd_cpd_free(struct blkcg_policy_data *cpd)
+{
+	struct dd_blkcg *dd_blkcg = container_of(cpd, typeof(*dd_blkcg), cpd);
+
+	free_percpu(dd_blkcg->stats);
+	kfree(dd_blkcg);
+}
+
+/*
+ * Convert an association between a block cgroup and a request queue into a
+ * pointer to the mq-deadline information associated with a (blkcg, queue) pair.
+ */
+struct dd_blkcg *dd_blkcg_from_bio(struct bio *bio)
+{
+	struct blkg_policy_data *pd;
+
+	pd = blkg_to_pd(bio->bi_blkg, &dd_blkcg_policy);
+	if (!pd)
+		return NULL;
+
+	return container_of(blkcg_to_cpd(pd->blkg->blkcg, &dd_blkcg_policy),
+			    struct dd_blkcg, cpd);
+}
+
+static struct blkg_policy_data *dd_pd_alloc(gfp_t gfp, struct request_queue *q,
+					    struct blkcg *blkcg)
+{
+	struct dd_blkg *pd;
+
+	pd = kzalloc(sizeof(*pd), gfp);
+	if (!pd)
+		return NULL;
+	return &pd->pd;
+}
+
+static void dd_pd_free(struct blkg_policy_data *pd)
+{
+	struct dd_blkg *dd_blkg = container_of(pd, typeof(*dd_blkg), pd);
+
+	kfree(dd_blkg);
+}
+
+static struct blkcg_policy dd_blkcg_policy = {
+	.dfl_cftypes		= dd_blkcg_files,
+	.legacy_cftypes		= dd_blkcg_legacy_files,
+
+	.cpd_alloc_fn		= dd_cpd_alloc,
+	.cpd_free_fn		= dd_cpd_free,
+
+	.pd_alloc_fn		= dd_pd_alloc,
+	.pd_free_fn		= dd_pd_free,
+};
+
+int dd_activate_policy(struct request_queue *q)
+{
+	return blkcg_activate_policy(q, &dd_blkcg_policy);
+}
+
+void dd_deactivate_policy(struct request_queue *q)
+{
+	blkcg_deactivate_policy(q, &dd_blkcg_policy);
+}
+
+int __init dd_blkcg_init(void)
+{
+	return blkcg_policy_register(&dd_blkcg_policy);
+}
+
+void __exit dd_blkcg_exit(void)
+{
+	blkcg_policy_unregister(&dd_blkcg_policy);
+}
diff --git a/block/mq-deadline-cgroup.h b/block/mq-deadline-cgroup.h
new file mode 100644
index 000000000000..1e263557c881
--- /dev/null
+++ b/block/mq-deadline-cgroup.h
@@ -0,0 +1,112 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#if !defined(_MQ_DEADLINE_CGROUP_H_)
+#define _MQ_DEADLINE_CGROUP_H_
+
+#include <linux/blk-cgroup.h>
+
+struct request_queue;
+
+/**
+ * struct io_stats_per_prio - I/O statistics per I/O priority class.
+ * @inserted: Number of inserted requests.
+ * @merged: Number of merged requests.
+ * @dispatched: Number of dispatched requests.
+ * @completed: Number of I/O completions.
+ */
+struct io_stats_per_prio {
+	local_t inserted;
+	local_t merged;
+	local_t dispatched;
+	local_t completed;
+};
+
+/* I/O statistics per I/O cgroup per I/O priority class (IOPRIO_CLASS_*). */
+struct blkcg_io_stats {
+	struct io_stats_per_prio stats[4];
+};
+
+/**
+ * struct dd_blkcg - Per cgroup data.
+ * @cpd: blkcg_policy_data structure.
+ * @stats: I/O statistics.
+ */
+struct dd_blkcg {
+	struct blkcg_policy_data cpd;	/* must be the first member */
+	struct blkcg_io_stats __percpu *stats;
+};
+
+/*
+ * Count one event of type 'event_type' and with I/O priority class
+ * 'prio_class'.
+ */
+#define ddcg_count(ddcg, event_type, prio_class) do {			\
+	struct blkcg_io_stats *io_stats = get_cpu_ptr((ddcg)->stats);	\
+									\
+	BUILD_BUG_ON(!__same_type((ddcg), struct dd_blkcg *));		\
+	BUILD_BUG_ON(!__same_type((prio_class), u8));			\
+	local_inc(&io_stats->stats[(prio_class)].event_type);		\
+	put_cpu_ptr(io_stats);						\
+} while (0)
+
+/*
+ * Returns the total number of ddcg_count(ddcg, event_type, prio_class) calls
+ * across all CPUs. No locking or barriers since it is fine if the returned
+ * sum is slightly outdated.
+ */
+#define ddcg_sum(ddcg, event_type, prio) ({				\
+	unsigned int cpu;						\
+	u32 sum = 0;							\
+									\
+	BUILD_BUG_ON(!__same_type((ddcg), struct dd_blkcg *));		\
+	BUILD_BUG_ON(!__same_type((prio), u8));				\
+	for_each_present_cpu(cpu)					\
+		sum += local_read(&per_cpu_ptr((ddcg)->stats, cpu)->	\
+				  stats[(prio)].event_type);		\
+	sum;								\
+})
+
+#ifdef CONFIG_BLK_CGROUP
+
+/**
+ * struct dd_blkg - Per (cgroup, request queue) data.
+ * @pd: blkg_policy_data structure.
+ */
+struct dd_blkg {
+	struct blkg_policy_data pd;	/* must be the first member */
+};
+
+struct dd_blkcg *dd_blkcg_from_bio(struct bio *bio);
+int dd_activate_policy(struct request_queue *q);
+void dd_deactivate_policy(struct request_queue *q);
+int __init dd_blkcg_init(void);
+void __exit dd_blkcg_exit(void);
+
+#else /* CONFIG_BLK_CGROUP */
+
+static inline struct dd_blkcg *dd_blkcg_from_bio(struct bio *bio)
+{
+	return NULL;
+}
+
+static inline int dd_activate_policy(struct request_queue *q)
+{
+	return 0;
+}
+
+static inline void dd_deactivate_policy(struct request_queue *q)
+{
+}
+
+static inline int dd_blkcg_init(void)
+{
+	return 0;
+}
+
+static inline void dd_blkcg_exit(void)
+{
+}
+
+#endif /* CONFIG_BLK_CGROUP */
+
+#endif /* _MQ_DEADLINE_CGROUP_H_ */
diff --git a/block/mq-deadline.c b/block/mq-deadline-main.c
similarity index 94%
rename from block/mq-deadline.c
rename to block/mq-deadline-main.c
index 776ff49713c3..1b2b6c1de5b8 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline-main.c
@@ -25,6 +25,7 @@
 #include "blk-mq-debugfs.h"
 #include "blk-mq-tag.h"
 #include "blk-mq-sched.h"
+#include "mq-deadline-cgroup.h"
 
 /*
  * See Documentation/block/deadline-iosched.rst
@@ -51,14 +52,6 @@ enum dd_prio {
 
 enum { DD_PRIO_COUNT = 3 };
 
-/* I/O statistics per I/O priority. */
-struct io_stats_per_prio {
-	local_t inserted;
-	local_t merged;
-	local_t dispatched;
-	local_t completed;
-};
-
 /* I/O statistics for all I/O priorities (enum dd_prio). */
 struct io_stats {
 	struct io_stats_per_prio stats[DD_PRIO_COUNT];
@@ -69,6 +62,9 @@ struct deadline_data {
 	 * run time data
 	 */
 
+	/* Request queue that owns this data structure. */
+	struct request_queue *queue;
+
 	/*
 	 * Requests are present on both sort_list[] and fifo_list[][]. The
 	 * first index of fifo_list[][] is the I/O priority class (DD_*_PRIO).
@@ -226,11 +222,15 @@ static void dd_merged_requests(struct request_queue *q, struct request *req,
 	struct deadline_data *dd = q->elevator->elevator_data;
 	const u8 ioprio_class = dd_rq_ioclass(next);
 	const enum dd_prio prio = ioprio_class_to_prio[ioprio_class];
+	struct dd_blkcg *blkcg = next->elv.priv[0];
 
-	if (next->elv.priv[0]) {
+	if (blkcg) {
 		dd_count(dd, merged, prio);
+		ddcg_count(blkcg, merged, ioprio_class);
 	} else {
+#if defined(CONFIG_BLK_CGROUP)
 		WARN_ON_ONCE(true);
+#endif
 	}
 
 	/*
@@ -370,6 +370,7 @@ static struct request *__dd_dispatch_request(struct deadline_data *dd,
 {
 	struct request *rq, *next_rq;
 	enum dd_data_dir data_dir;
+	struct dd_blkcg *blkcg;
 	u8 ioprio_class;
 
 	lockdep_assert_held(&dd->lock);
@@ -462,12 +463,16 @@ static struct request *__dd_dispatch_request(struct deadline_data *dd,
 	dd->batching++;
 	deadline_move_request(dd, rq);
 done:
+	blkcg = rq->elv.priv[0];
 	ioprio_class = dd_rq_ioclass(rq);
 	prio = ioprio_class_to_prio[ioprio_class];
-	if (rq->elv.priv[0]) {
+	if (blkcg) {
 		dd_count(dd, dispatched, prio);
+		ddcg_count(blkcg, dispatched, ioprio_class);
 	} else {
+#if defined(CONFIG_BLK_CGROUP)
 		WARN_ON_ONCE(true);
+#endif
 	}
 	/*
 	 * If the request needs its target zone locked, do it.
@@ -545,6 +550,8 @@ static void dd_exit_sched(struct elevator_queue *e)
 	struct deadline_data *dd = e->elevator_data;
 	enum dd_prio prio;
 
+	dd_deactivate_policy(dd->queue);
+
 	for (prio = 0; prio <= DD_PRIO_MAX; prio++) {
 		WARN_ON_ONCE(!list_empty(&dd->fifo_list[prio][DD_READ]));
 		WARN_ON_ONCE(!list_empty(&dd->fifo_list[prio][DD_WRITE]));
@@ -556,7 +563,7 @@ static void dd_exit_sched(struct elevator_queue *e)
 }
 
 /*
- * initialize elevator private data (deadline_data).
+ * Initialize elevator private data (deadline_data) and associate with blkcg.
  */
 static int dd_init_sched(struct request_queue *q, struct elevator_type *e)
 {
@@ -565,6 +572,12 @@ static int dd_init_sched(struct request_queue *q, struct elevator_type *e)
 	enum dd_prio prio;
 	int ret = -ENOMEM;
 
+	/*
+	 * Initialization would be very tricky if the queue is not frozen,
+	 * hence the warning statement below.
+	 */
+	WARN_ON_ONCE(!percpu_ref_is_zero(&q->q_usage_counter));
+
 	eq = elevator_alloc(q, e);
 	if (!eq)
 		return ret;
@@ -580,6 +593,8 @@ static int dd_init_sched(struct request_queue *q, struct elevator_type *e)
 	if (!dd->stats)
 		goto free_dd;
 
+	dd->queue = q;
+
 	for (prio = 0; prio <= DD_PRIO_MAX; prio++) {
 		INIT_LIST_HEAD(&dd->fifo_list[prio][DD_READ]);
 		INIT_LIST_HEAD(&dd->fifo_list[prio][DD_WRITE]);
@@ -595,9 +610,17 @@ static int dd_init_sched(struct request_queue *q, struct elevator_type *e)
 	spin_lock_init(&dd->lock);
 	spin_lock_init(&dd->zone_lock);
 
+	ret = dd_activate_policy(q);
+	if (ret)
+		goto free_stats;
+
+	ret = 0;
 	q->elevator = eq;
 	return 0;
 
+free_stats:
+	free_percpu(dd->stats);
+
 free_dd:
 	kfree(dd);
 
@@ -666,6 +689,7 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
 	u16 ioprio = req_get_ioprio(rq);
 	u8 ioprio_class = IOPRIO_PRIO_CLASS(ioprio);
 	enum dd_prio prio;
+	struct dd_blkcg *blkcg;
 
 	lockdep_assert_held(&dd->lock);
 
@@ -675,10 +699,25 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
 	 */
 	blk_req_zone_write_unlock(rq);
 
+	/*
+	 * If a block cgroup has been associated with the submitter and if an
+	 * I/O priority has been set in the associated block cgroup, use the
+	 * lowest of the cgroup priority and the request priority for the
+	 * request. If no priority has been set in the request, use the cgroup
+	 * priority.
+	 */
+	blkcg = dd_blkcg_from_bio(rq->bio);
+	if (blkcg) {
+		ddcg_count(blkcg, inserted, ioprio_class);
+	} else {
+#if defined(CONFIG_BLK_CGROUP)
+		WARN_ON_ONCE(true);
+#endif
+	}
 	prio = ioprio_class_to_prio[ioprio_class];
 	dd_count(dd, inserted, prio);
 	WARN_ON_ONCE(rq->elv.priv[0]);
-	rq->elv.priv[0] = (void *)1ULL;
+	rq->elv.priv[0] = blkcg;
 
 	if (blk_mq_sched_try_insert_merge(q, rq))
 		return;
@@ -750,11 +789,14 @@ static void dd_finish_request(struct request *rq)
 {
 	struct request_queue *q = rq->q;
 	struct deadline_data *dd = q->elevator->elevator_data;
+	struct dd_blkcg *blkcg = rq->elv.priv[0];
 	const u8 ioprio_class = dd_rq_ioclass(rq);
 	const enum dd_prio prio = ioprio_class_to_prio[ioprio_class];
 
-	if (rq->elv.priv[0])
+	if (blkcg) {
 		dd_count(dd, completed, prio);
+		ddcg_count(blkcg, completed, ioprio_class);
+	}
 
 	if (blk_queue_is_zoned(q)) {
 		unsigned long flags;
@@ -1066,11 +1108,26 @@ MODULE_ALIAS("mq-deadline-iosched");
 
 static int __init deadline_init(void)
 {
-	return elv_register(&mq_deadline);
+	int ret;
+
+	ret = elv_register(&mq_deadline);
+	if (ret)
+		goto out;
+	ret = dd_blkcg_init();
+	if (ret)
+		goto unreg;
+
+out:
+	return ret;
+
+unreg:
+	elv_unregister(&mq_deadline);
+	goto out;
 }
 
 static void __exit deadline_exit(void)
 {
+	dd_blkcg_exit();
 	elv_unregister(&mq_deadline);
 }
 
