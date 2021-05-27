Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B98C6C47082
	for <linux-block@archiver.kernel.org>; Thu, 27 May 2021 01:02:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99FFF6128B
	for <linux-block@archiver.kernel.org>; Thu, 27 May 2021 01:02:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233817AbhE0BDe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 May 2021 21:03:34 -0400
Received: from mail-pg1-f169.google.com ([209.85.215.169]:35362 "EHLO
        mail-pg1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233592AbhE0BDe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 May 2021 21:03:34 -0400
Received: by mail-pg1-f169.google.com with SMTP id m190so2425620pga.2
        for <linux-block@vger.kernel.org>; Wed, 26 May 2021 18:02:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RoFE4Kf4cG+tMimiDO0vvQxxNfLoJUV32uixhmxPv1M=;
        b=HKmnfXrXpDCdxaHZLs16uIF5hP4dzAYI7P7K6Jqy/jnivkoSyWPOV6aaw7oaWRO88T
         nvaDDiUo690IszuwtyUymcWf7JzbdBab4vz6rFwj7STbMxkgRr5ixClcVKMBpoTG6op7
         AlzYwVZ2w7oJNngOvvT1l7ES0BOlAOi6hAxvK5FKjDiQmMmziHB4PBgAnTyeTIjYZFf2
         kTLe0T60PYB6Syr8GUDTy8DBADSMhcd5E8Ykq+5ggE4vvgETuFfhEC3PWFS+tGI6/+sZ
         wqWNKm1p/7GfIul+EVvoK6F60kJRM/UiJqtaFKb7TsjZ4K4gnbwT1uox2WLjeI3+dZ7M
         hSCA==
X-Gm-Message-State: AOAM530oHsAragkBNv3EeghIrlqwmPHqKmjv2YI7+F0Q40Xhw8JRzQcp
        4IALHAK1REd9MqLMJRbW+vE=
X-Google-Smtp-Source: ABdhPJzthpcWHxisIl+f/FIO0hpmZOPLBCIbhG0BrIAIUDGOfjzyrBj4DNaKd2qR9DTrOKXSs3faRg==
X-Received: by 2002:a65:4887:: with SMTP id n7mr1267012pgs.284.1622077320897;
        Wed, 26 May 2021 18:02:00 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id j22sm310707pfd.215.2021.05.26.18.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 18:02:00 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Adam Manzanares <adam.manzanares@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 9/9] block/mq-deadline: Add cgroup support
Date:   Wed, 26 May 2021 18:01:34 -0700
Message-Id: <20210527010134.32448-10-bvanassche@acm.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210527010134.32448-1-bvanassche@acm.org>
References: <20210527010134.32448-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add support for configuring I/O priority per block cgroup. Assign the lowest
of the following two priorities to a request: rq->ioprio and blkcg->ioprio.
Maintain statistics per cgroup and make these available in sysfs.

This patch has been tested as follows:

SHELL 1

modprobe scsi_debug ndelay=1000000 max_queue=16 &&
while [ -z "$sd" ]; do sd=/dev/$(basename /sys/bus/pseudo/drivers/scsi_debug/adapter*/host*/target*/*/block/*); done &&
cd /sys/fs/cgroup/blkio/ &&
echo 2 >blkio.dd.prio &&
mkdir -p hipri &&
cd hipri &&
echo 1 >blkio.dd.prio &&
echo $$ >cgroup.procs &&
max-iops -a1 -d32 -j1 -e mq-deadline $sd

SHELL 2

sd=/dev/$(basename /sys/bus/pseudo/drivers/scsi_debug/adapter*/host*/target*/*/block/*) &&
max-iops -a1 -d32 -j1 -e mq-deadline $sd

Result:
* 12000 IOPS in shell 1
*  2000 IOPS in shell 2

The max-iops script is a script that runs fio with the following arguments:
--bs=4K --gtod_reduce=1 --ioengine=libaio --ioscheduler=${arg_e} --runtime=60
--norandommap --rw=read --thread --buffered=0 --numjobs=${arg_j}
--iodepth=${arg_d}
--iodepth_batch_submit=${arg_a} --iodepth_batch_complete=$((arg_d / 2))
--name=${positional_argument_1} --filename=${positional_argument_1}

Cc: Damien Le Moal <damien.lemoal@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/Kconfig.iosched      |   6 ++
 block/Makefile             |   1 +
 block/mq-deadline-cgroup.c | 206 +++++++++++++++++++++++++++++++++++++
 block/mq-deadline-cgroup.h |  73 +++++++++++++
 block/mq-deadline.c        |  96 ++++++++++++++---
 5 files changed, 370 insertions(+), 12 deletions(-)
 create mode 100644 block/mq-deadline-cgroup.c
 create mode 100644 block/mq-deadline-cgroup.h

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
index 8d841f5f986f..7d5763d5f988 100644
--- a/block/Makefile
+++ b/block/Makefile
@@ -20,6 +20,7 @@ obj-$(CONFIG_BLK_DEV_THROTTLING)	+= blk-throttle.o
 obj-$(CONFIG_BLK_CGROUP_IOLATENCY)	+= blk-iolatency.o
 obj-$(CONFIG_BLK_CGROUP_IOCOST)	+= blk-iocost.o
 obj-$(CONFIG_MQ_IOSCHED_DEADLINE)	+= mq-deadline.o
+obj-$(CONFIG_MQ_IOSCHED_DEADLINE_CGROUP)+= mq-deadline-cgroup.o
 obj-$(CONFIG_MQ_IOSCHED_KYBER)	+= kyber-iosched.o
 bfq-y				:= bfq-iosched.o bfq-wf2q.o bfq-cgroup.o
 obj-$(CONFIG_IOSCHED_BFQ)	+= bfq.o
diff --git a/block/mq-deadline-cgroup.c b/block/mq-deadline-cgroup.c
new file mode 100644
index 000000000000..3983795dda60
--- /dev/null
+++ b/block/mq-deadline-cgroup.c
@@ -0,0 +1,206 @@
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
+static u64 dd_show_prio(struct cgroup_subsys_state *css, struct cftype *cft)
+{
+	return dd_blkcg_from_css(css)->prio;
+}
+
+static int dd_set_prio(struct cgroup_subsys_state *css, struct cftype *cft,
+		       u64 val)
+{
+	struct dd_blkcg *dd_blkcg = dd_blkcg_from_css(css);
+
+	if (val < 0 || val > 3)
+		return -EINVAL;
+	dd_blkcg->prio = val;
+	return 0;
+}
+
+/*
+ * Total number of inserted requests not associated with any cgroup and
+ * with I/O priority cft->private.
+ */
+static u64 dd_show_nocg(struct cgroup_subsys_state *css,
+			      struct cftype *cft)
+{
+	const u8 prio = cft->private;
+
+	return atomic_read(&nocg_inserted[prio]);
+}
+
+/* Number of inserted but not completed requests for priority cft->private. */
+static u64 dd_show_inserted(struct cgroup_subsys_state *css,
+			      struct cftype *cft)
+{
+	struct dd_blkcg *blkcg = dd_blkcg_from_css(css);
+	const u8 prio = cft->private;
+
+	return atomic_read(&blkcg->inserted[prio]) -
+		atomic_read(&blkcg->completed[prio]);
+}
+
+static u64 dd_show_merged(struct cgroup_subsys_state *css, struct cftype *cft)
+{
+	struct dd_blkcg *blkcg = dd_blkcg_from_css(css);
+	const u8 prio = cft->private;
+
+	return atomic_read(&blkcg->merged[prio]);
+}
+
+/* Number of dispatched but not completed requests for priority cft->private. */
+static u64 dd_show_dispatched(struct cgroup_subsys_state *css,
+			      struct cftype *cft)
+{
+	struct dd_blkcg *blkcg = dd_blkcg_from_css(css);
+	const u8 prio = cft->private;
+
+	return atomic_read(&blkcg->dispatched[prio]) +
+		atomic_read(&blkcg->merged[prio]) -
+		atomic_read(&blkcg->completed[prio]);
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
+	{								\
+		.name		= "dd.prio",				\
+		.read_u64	= dd_show_prio,				\
+		.write_u64	= dd_set_prio,				\
+	},								\
+	IOPRI_ATTRS("dd.nocg_pri", CFTYPE_ONLY_ON_ROOT, dd_show_nocg),	\
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
+	pd->prio = IOPRIO_CLASS_NONE;
+	return &pd->cpd;
+}
+
+static void dd_cpd_free(struct blkcg_policy_data *cpd)
+{
+	struct dd_blkcg *dd_blkcg = container_of(cpd, typeof(*dd_blkcg), cpd);
+
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
index 000000000000..0996a1a28412
--- /dev/null
+++ b/block/mq-deadline-cgroup.h
@@ -0,0 +1,73 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#if !defined(_MQ_DEADLINE_CGROUP_H_)
+#define _MQ_DEADLINE_CGROUP_H_
+
+#include <linux/blk-cgroup.h>
+
+struct request_queue;
+
+extern atomic_t nocg_inserted[4];
+
+/**
+ * struct dd_blkcg - Per cgroup data.
+ * @cpd: blkcg_policy_data structure.
+ * @prio: One of the IOPRIO_CLASS_* values. See also <linux/ioprio.h>.
+ * @inserted: Number of inserted requests for the given IOPRIO_CLASS_*.
+ * @merged: Number of merged requests for the given I/O priority level.
+ * @dispatched: Number of dispatched requests for the given IOPRIO_CLASS_*.
+ * @completed: Number of completions per I/O priority level.
+ */
+struct dd_blkcg {
+	struct blkcg_policy_data cpd;	/* must be the first member */
+	u8 prio;
+	atomic_t inserted[4];
+	atomic_t merged[4];
+	atomic_t dispatched[4];
+	atomic_t completed[4];
+};
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
diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index 5a703e1228fa..0aa14cc302fd 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -25,6 +25,7 @@
 #include "blk-mq-debugfs.h"
 #include "blk-mq-tag.h"
 #include "blk-mq-sched.h"
+#include "mq-deadline-cgroup.h"
 
 /*
  * See Documentation/block/deadline-iosched.rst
@@ -58,6 +59,9 @@ struct deadline_data {
 	 * run time data
 	 */
 
+	/* Request queue that owns this data structure. */
+	struct request_queue *queue;
+
 	/*
 	 * Requests are present on both sort_list[] and fifo_list[][]. The
 	 * first index of fifo_list[][] is the I/O priority class (DD_*_PRIO).
@@ -101,6 +105,9 @@ static const enum dd_prio ioprio_class_to_prio[] = {
 	[IOPRIO_CLASS_IDLE]	= DD_IDLE_PRIO,
 };
 
+/* To track requests not associated with any cgroup. */
+atomic_t nocg_inserted[4];
+
 static inline struct rb_root *
 deadline_rb_root(struct deadline_data *dd, struct request *rq)
 {
@@ -189,9 +196,11 @@ static void dd_merged_requests(struct request_queue *q, struct request *req,
 	struct deadline_data *dd = q->elevator->elevator_data;
 	const u8 ioprio_class = dd_rq_ioclass(next);
 	const enum dd_prio prio = ioprio_class_to_prio[ioprio_class];
+	struct dd_blkcg *blkcg = next->elv.priv[0];
 
-	if (next->elv.priv[0]) {
+	if (blkcg) {
 		atomic_inc(&dd->merged[prio]);
+		atomic_inc(&blkcg->merged[ioprio_class]);
 	} else {
 		WARN_ON_ONCE(true);
 	}
@@ -334,6 +343,7 @@ static struct request *__dd_dispatch_request(struct deadline_data *dd,
 {
 	struct request *rq, *next_rq;
 	enum dd_data_dir data_dir;
+	struct dd_blkcg *blkcg;
 	u8 ioprio_class;
 
 	lockdep_assert_held(&dd->lock);
@@ -426,10 +436,12 @@ static struct request *__dd_dispatch_request(struct deadline_data *dd,
 	dd->batching++;
 	deadline_move_request(dd, rq);
 done:
+	blkcg = rq->elv.priv[0];
 	ioprio_class = dd_rq_ioclass(rq);
 	prio = ioprio_class_to_prio[ioprio_class];
-	if (rq->elv.priv[0]) {
+	if (blkcg) {
 		atomic_inc(&dd->dispatched[prio]);
+		atomic_inc(&blkcg->dispatched[ioprio_class]);
 	} else {
 		WARN_ON_ONCE(true);
 	}
@@ -503,6 +515,8 @@ static void dd_exit_sched(struct elevator_queue *e)
 	struct deadline_data *dd = e->elevator_data;
 	enum dd_prio prio;
 
+	dd_deactivate_policy(dd->queue);
+
 	for (prio = 0; prio <= DD_PRIO_MAX; prio++) {
 		WARN_ON_ONCE(!list_empty(&dd->fifo_list[prio][DD_READ]));
 		WARN_ON_ONCE(!list_empty(&dd->fifo_list[prio][DD_WRITE]));
@@ -512,25 +526,33 @@ static void dd_exit_sched(struct elevator_queue *e)
 }
 
 /*
- * initialize elevator private data (deadline_data).
+ * Initialize elevator private data (deadline_data) and associate with blkcg.
  */
 static int dd_init_sched(struct request_queue *q, struct elevator_type *e)
 {
 	struct deadline_data *dd;
 	struct elevator_queue *eq;
 	enum dd_prio prio;
+	int ret = -ENOMEM;
+
+	/*
+	 * Initialization would be very tricky if the queue is not frozen,
+	 * hence the warning statement below.
+	 */
+	WARN_ON_ONCE(!percpu_ref_is_zero(&q->q_usage_counter));
 
 	eq = elevator_alloc(q, e);
 	if (!eq)
-		return -ENOMEM;
+		goto out;
 
 	dd = kzalloc_node(sizeof(*dd), GFP_KERNEL, q->node);
-	if (!dd) {
-		kobject_put(&eq->kobj);
-		return -ENOMEM;
-	}
+	if (!dd)
+		goto put_eq;
+
 	eq->elevator_data = dd;
 
+	dd->queue = q;
+
 	for (prio = 0; prio <= DD_PRIO_MAX; prio++) {
 		INIT_LIST_HEAD(&dd->fifo_list[prio][DD_READ]);
 		INIT_LIST_HEAD(&dd->fifo_list[prio][DD_WRITE]);
@@ -547,8 +569,23 @@ static int dd_init_sched(struct request_queue *q, struct elevator_type *e)
 	spin_lock_init(&dd->lock);
 	spin_lock_init(&dd->zone_lock);
 
+	ret = dd_activate_policy(q);
+	if (ret)
+		goto free_dd;
+
+	ret = 0;
 	q->elevator = eq;
-	return 0;
+
+out:
+	return ret;
+
+free_dd:
+	eq->elevator_data = NULL;
+	kfree(dd);
+
+put_eq:
+	kobject_put(&eq->kobj);
+	goto out;
 }
 
 /*
@@ -611,6 +648,7 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
 	u16 ioprio = req_get_ioprio(rq);
 	u8 ioprio_class = IOPRIO_PRIO_CLASS(ioprio);
 	enum dd_prio prio;
+	struct dd_blkcg *blkcg;
 
 	lockdep_assert_held(&dd->lock);
 
@@ -620,10 +658,27 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
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
+		ioprio_class = max(ioprio_class, blkcg->prio);
+		rq->ioprio = IOPRIO_PRIO_VALUE(ioprio_class,
+					       IOPRIO_PRIO_DATA(ioprio));
+		atomic_inc(&blkcg->inserted[ioprio_class]);
+	} else {
+		WARN_ON_ONCE(true);
+		atomic_inc(&nocg_inserted[ioprio_class]);
+	}
 	prio = ioprio_class_to_prio[ioprio_class];
 	atomic_inc(&dd->inserted[prio]);
 	WARN_ON_ONCE(rq->elv.priv[0]);
-	rq->elv.priv[0] = (void *)1ULL;
+	rq->elv.priv[0] = blkcg;
 	rq->elv.priv[1] = (void *)(uintptr_t)ioprio_class;
 
 	if (blk_mq_sched_try_insert_merge(q, rq))
@@ -696,11 +751,14 @@ static void dd_finish_request(struct request *rq)
 {
 	struct request_queue *q = rq->q;
 	struct deadline_data *dd = q->elevator->elevator_data;
+	struct dd_blkcg *blkcg = rq->elv.priv[0];
 	const u8 ioprio_class = dd_rq_ioclass(rq);
 	const enum dd_prio prio = ioprio_class_to_prio[ioprio_class];
 
-	if (rq->elv.priv[0])
+	if (blkcg) {
 		atomic_inc(&dd->completed[prio]);
+		atomic_inc(&blkcg->completed[ioprio_class]);
+	}
 
 	if (blk_queue_is_zoned(q)) {
 		unsigned long flags;
@@ -1021,11 +1079,25 @@ MODULE_ALIAS("mq-deadline-iosched");
 
 static int __init deadline_init(void)
 {
-	return elv_register(&mq_deadline);
+	int ret;
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
 
