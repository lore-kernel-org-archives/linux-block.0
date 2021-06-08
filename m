Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA234C47082
	for <linux-block@archiver.kernel.org>; Tue,  8 Jun 2021 23:07:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9277761364
	for <linux-block@archiver.kernel.org>; Tue,  8 Jun 2021 23:07:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232310AbhFHXJK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Jun 2021 19:09:10 -0400
Received: from mail-pg1-f180.google.com ([209.85.215.180]:38429 "EHLO
        mail-pg1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232208AbhFHXJK (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Jun 2021 19:09:10 -0400
Received: by mail-pg1-f180.google.com with SMTP id t17so1252798pga.5
        for <linux-block@vger.kernel.org>; Tue, 08 Jun 2021 16:07:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K5VjFrX5EZz8KxWa/6vPDxuEdxlNFseJ5efdQkCIwWQ=;
        b=Ehv9pQnYNBDIE9nQOCw9k4IrVgCAx7YF8ujdr6NWAbTrH7DNVZDqScfN9ylicjGRoS
         J0xn85jxEaIIHCMHRi3jz4y0cdPIWlmY8SBkD7CuMprqsg0ytI3MrFmReoPfbcrL1eSm
         Bip7XqQS/jwEaFhcso/l4TtE3HGWbHxNTbw4/YPiPurvyLqijYjT49zWwvMnDzIZ9ESJ
         Ya/P7tKKgtN9evQmZxNnUR7y4lJs7vefUEc5uBHL481J1A9TEAepnIA+XlN/qlmRvLVn
         PDNNZ4goP+66tgxNQIC5K5ejQpZxd90ql9B4at7uBo2n8iuKyfQCTcu2d6rVLYGe5q7c
         H9pw==
X-Gm-Message-State: AOAM533tHoyZIyfW0MR8MRFjIZkddeHNK0Cz79lrAjAtyz4aZ5EZuskx
        HUYv1q90rtSBS9YUaaQzw/P2ziPMROI=
X-Google-Smtp-Source: ABdhPJzadO1cZWiWxXFxpMGtYpgDDkUJseRXthffOwrzPQCKGKt1tTio174ARlg5T06KHF7+A5XnpQ==
X-Received: by 2002:a63:a805:: with SMTP id o5mr638979pgf.328.1623193636720;
        Tue, 08 Jun 2021 16:07:16 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id s21sm11395838pfw.57.2021.06.08.16.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 16:07:16 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: [PATCH 04/14] block: Introduce the ioprio rq-qos policy
Date:   Tue,  8 Jun 2021 16:06:53 -0700
Message-Id: <20210608230703.19510-5-bvanassche@acm.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210608230703.19510-1-bvanassche@acm.org>
References: <20210608230703.19510-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Introduce an rq-qos policy that assigns an I/O priority to requests based
on blk-cgroup configuration settings. This policy has the following
advantages over the ioprio_set() system call:
- This policy is cgroup based so it has all the advantages of cgroups.
- While ioprio_set() does not affect page cache writeback I/O, this rq-qos
  controller affects page cache writeback I/O for filesystems that support
  assiociating a cgroup with writeback I/O. See also
  Documentation/admin-guide/cgroup-v2.rst.

Cc: Damien Le Moal <damien.lemoal@wdc.com>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: Himanshu Madhani <himanshu.madhani@oracle.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 Documentation/admin-guide/cgroup-v2.rst |  26 +++
 block/Kconfig                           |   9 +
 block/Makefile                          |   1 +
 block/blk-cgroup.c                      |   5 +
 block/blk-ioprio.c                      | 236 ++++++++++++++++++++++++
 block/blk-ioprio.h                      |  19 ++
 block/blk-rq-qos.c                      |   2 +
 block/blk-rq-qos.h                      |   1 +
 8 files changed, 299 insertions(+)
 create mode 100644 block/blk-ioprio.c
 create mode 100644 block/blk-ioprio.h

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index b1e81aa8598a..cf8c8073b474 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -56,6 +56,7 @@ v1 is available under :ref:`Documentation/admin-guide/cgroup-v1/index.rst <cgrou
        5-3-3. IO Latency
          5-3-3-1. How IO Latency Throttling Works
          5-3-3-2. IO Latency Interface Files
+       5-3-4. IO Priority
      5-4. PID
        5-4-1. PID Interface Files
      5-5. Cpuset
@@ -1866,6 +1867,31 @@ IO Latency Interface Files
 		duration of time between evaluation events.  Windows only elapse
 		with IO activity.  Idle periods extend the most recent window.
 
+IO Priority
+~~~~~~~~~~~
+
+A single attribute controls the behavior of the I/O priority cgroup policy,
+namely the blkio.prio.class attribute. The following values are accepted for
+that attribute:
+
+  0
+	Do not modify the I/O priority class.
+
+  1
+	For requests that do not have an I/O priority class (IOPRIO_CLASS_NONE),
+	change the I/O priority class into 1 (IOPRIO_CLASS_RT). Do not modify
+	the I/O priority class of other requests.
+
+  2
+	For requests that do not have an I/O priority class, change the I/O
+	priority class into IOPRIO_CLASS_BE. For requests that have the
+	priority class RT, change it into BE (2). Do not modify
+	the I/O priority class of requests that have priority 3 (IDLE).
+
+  3
+	Change the I/O priority class of all requests into 3 (IDLE),
+	the lowest I/O priority class.
+
 PID
 ---
 
diff --git a/block/Kconfig b/block/Kconfig
index 6685578b2a20..319816058298 100644
--- a/block/Kconfig
+++ b/block/Kconfig
@@ -162,6 +162,15 @@ config BLK_CGROUP_IOCOST
 	distributes IO capacity between different groups based on
 	their share of the overall weight distribution.
 
+config BLK_CGROUP_IOPRIO
+	bool "Cgroup I/O controller for assigning I/O priority"
+	depends on BLK_CGROUP
+	help
+	Enable the .prio interface for assigning an I/O priority to requests.
+	The I/O priority affects the order in which an I/O scheduler and block
+	devices process requests. Only some I/O schedulers and some block
+	devices support I/O priorities.
+
 config BLK_DEBUG_FS
 	bool "Block layer debugging information in debugfs"
 	default y
diff --git a/block/Makefile b/block/Makefile
index 8d841f5f986f..af3d044abaf1 100644
--- a/block/Makefile
+++ b/block/Makefile
@@ -17,6 +17,7 @@ obj-$(CONFIG_BLK_DEV_BSGLIB)	+= bsg-lib.o
 obj-$(CONFIG_BLK_CGROUP)	+= blk-cgroup.o
 obj-$(CONFIG_BLK_CGROUP_RWSTAT)	+= blk-cgroup-rwstat.o
 obj-$(CONFIG_BLK_DEV_THROTTLING)	+= blk-throttle.o
+obj-$(CONFIG_BLK_CGROUP_IOPRIO)	+= blk-ioprio.o
 obj-$(CONFIG_BLK_CGROUP_IOLATENCY)	+= blk-iolatency.o
 obj-$(CONFIG_BLK_CGROUP_IOCOST)	+= blk-iocost.o
 obj-$(CONFIG_MQ_IOSCHED_DEADLINE)	+= mq-deadline.o
diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 3b0f6efaa2b6..7b06a5fa3cac 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -31,6 +31,7 @@
 #include <linux/tracehook.h>
 #include <linux/psi.h>
 #include "blk.h"
+#include "blk-ioprio.h"
 
 /*
  * blkcg_pol_mutex protects blkcg_policy[] and policy [de]activation.
@@ -1187,6 +1188,10 @@ int blkcg_init_queue(struct request_queue *q)
 	if (ret)
 		goto err_destroy_all;
 
+	ret = blk_ioprio_init(q);
+	if (ret)
+		goto err_destroy_all;
+
 	ret = blk_throtl_init(q);
 	if (ret)
 		goto err_destroy_all;
diff --git a/block/blk-ioprio.c b/block/blk-ioprio.c
new file mode 100644
index 000000000000..d7292cdef67d
--- /dev/null
+++ b/block/blk-ioprio.c
@@ -0,0 +1,236 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Block rq-qos policy for assigning an I/O priority to requests.
+ *
+ * Using an rq-qos policy for assigning I/O priority has two advantages over
+ * using the ioprio_set() system call:
+ *
+ * - This policy is cgroup based so it has all the advantages of cgroups.
+ * - While ioprio_set() does not affect page cache writeback I/O, this rq-qos
+ *   controller affects page cache writeback I/O for filesystems that support
+ *   assiociating a cgroup with writeback I/O. See also
+ *   Documentation/admin-guide/cgroup-v2.rst.
+ */
+
+#include <linux/blk-cgroup.h>
+#include <linux/blk-mq.h>
+#include <linux/blk_types.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include "blk-ioprio.h"
+#include "blk-rq-qos.h"
+
+/*
+ * The accepted I/O priority values are 0..IOPRIO_CLASS_MAX(3). 0 (default)
+ * means do not modify the I/O priority. Values 1..3 are used to restrict the
+ * I/O priority for a cgroup to the specified priority. See also
+ * <linux/ioprio.h>.
+ */
+#define IOPRIO_CLASS_MAX IOPRIO_CLASS_IDLE
+
+static struct blkcg_policy ioprio_policy;
+
+/**
+ * struct ioprio_blkg - Per (cgroup, request queue) data.
+ * @pd: blkg_policy_data structure.
+ */
+struct ioprio_blkg {
+	struct blkg_policy_data pd;
+};
+
+/**
+ * struct ioprio_blkcg - Per cgroup data.
+ * @cpd: blkcg_policy_data structure.
+ * @prio_class: One of the IOPRIO_CLASS_* values. See also <linux/ioprio.h>.
+ */
+struct ioprio_blkcg {
+	struct blkcg_policy_data cpd;
+	u8			 prio_class;
+};
+
+static inline struct ioprio_blkg *pd_to_ioprio(struct blkg_policy_data *pd)
+{
+	return pd ? container_of(pd, struct ioprio_blkg, pd) : NULL;
+}
+
+static struct ioprio_blkcg *
+ioprio_blkcg_from_css(struct cgroup_subsys_state *css)
+{
+	struct blkcg *blkcg = css_to_blkcg(css);
+	struct blkcg_policy_data *cpd = blkcg_to_cpd(blkcg, &ioprio_policy);
+
+	return container_of(cpd, struct ioprio_blkcg, cpd);
+}
+
+static struct ioprio_blkcg *ioprio_blkcg_from_bio(struct bio *bio)
+{
+	struct blkg_policy_data *pd;
+
+	pd = blkg_to_pd(bio->bi_blkg, &ioprio_policy);
+	if (!pd)
+		return NULL;
+
+	return container_of(blkcg_to_cpd(pd->blkg->blkcg, &ioprio_policy),
+			    struct ioprio_blkcg, cpd);
+}
+
+static u64 ioprio_show_prio_class(struct cgroup_subsys_state *css,
+				  struct cftype *cft)
+{
+	struct ioprio_blkcg *blkcg = ioprio_blkcg_from_css(css);
+
+	return blkcg->prio_class;
+}
+
+static int ioprio_set_prio_class(struct cgroup_subsys_state *css,
+				 struct cftype *cft, u64 val)
+{
+	struct ioprio_blkcg *blkcg = ioprio_blkcg_from_css(css);
+
+	if (val > IOPRIO_CLASS_MAX)
+		return -EINVAL;
+
+	blkcg->prio_class = val;
+	return 0;
+}
+
+static struct blkg_policy_data *ioprio_alloc_pd(gfp_t gfp,
+						struct request_queue *q,
+						struct blkcg *blkcg)
+{
+	struct ioprio_blkg *ioprio_blkg;
+
+	ioprio_blkg = kzalloc(sizeof(*ioprio_blkg), gfp);
+	if (!ioprio_blkg)
+		return NULL;
+
+	return &ioprio_blkg->pd;
+}
+
+static void ioprio_free_pd(struct blkg_policy_data *pd)
+{
+	struct ioprio_blkg *ioprio_blkg = pd_to_ioprio(pd);
+
+	kfree(ioprio_blkg);
+}
+
+static struct blkcg_policy_data *ioprio_alloc_cpd(gfp_t gfp)
+{
+	struct ioprio_blkcg *blkcg;
+
+	blkcg = kzalloc(sizeof(*blkcg), gfp);
+	if (!blkcg)
+		return NULL;
+	blkcg->prio_class = IOPRIO_CLASS_NONE;
+	return &blkcg->cpd;
+}
+
+static void ioprio_free_cpd(struct blkcg_policy_data *cpd)
+{
+	struct ioprio_blkcg *blkcg = container_of(cpd, typeof(*blkcg), cpd);
+
+	kfree(blkcg);
+}
+
+#define IOPRIO_ATTRS						\
+	{							\
+		.name		= "prio.class",			\
+		.read_u64	= ioprio_show_prio_class,	\
+		.write_u64	= ioprio_set_prio_class,	\
+	},							\
+	{ } /* sentinel */
+
+/* cgroup v2 attributes */
+static struct cftype ioprio_files[] = {
+	IOPRIO_ATTRS
+};
+
+/* cgroup v1 attributes */
+static struct cftype ioprio_legacy_files[] = {
+	IOPRIO_ATTRS
+};
+
+static struct blkcg_policy ioprio_policy = {
+	.dfl_cftypes	= ioprio_files,
+	.legacy_cftypes = ioprio_legacy_files,
+
+	.cpd_alloc_fn	= ioprio_alloc_cpd,
+	.cpd_free_fn	= ioprio_free_cpd,
+
+	.pd_alloc_fn	= ioprio_alloc_pd,
+	.pd_free_fn	= ioprio_free_pd,
+};
+
+struct blk_ioprio {
+	struct rq_qos rqos;
+};
+
+static void blkcg_ioprio_track(struct rq_qos *rqos, struct request *rq,
+			       struct bio *bio)
+{
+	struct ioprio_blkcg *blkcg = ioprio_blkcg_from_bio(bio);
+
+	/*
+	 * Except for IOPRIO_CLASS_NONE, higher I/O priority numbers
+	 * correspond to a lower priority. Hence, the max_t() below selects
+	 * the lower priority of bi_ioprio and the cgroup I/O priority class.
+	 * If the cgroup priority has been set to IOPRIO_CLASS_NONE == 0, the
+	 * bio I/O priority is not modified. If the bio I/O priority equals
+	 * IOPRIO_CLASS_NONE, the cgroup I/O priority is assigned to the bio.
+	 */
+	bio->bi_ioprio = max_t(u16, bio->bi_ioprio,
+			       IOPRIO_PRIO_VALUE(blkcg->prio_class, 0));
+}
+
+static void blkcg_ioprio_exit(struct rq_qos *rqos)
+{
+	struct blk_ioprio *blkioprio_blkg =
+		container_of(rqos, typeof(*blkioprio_blkg), rqos);
+
+	blkcg_deactivate_policy(rqos->q, &ioprio_policy);
+	kfree(blkioprio_blkg);
+}
+
+static struct rq_qos_ops blkcg_ioprio_ops = {
+	.track = blkcg_ioprio_track,
+	.exit = blkcg_ioprio_exit,
+};
+
+int blk_ioprio_init(struct request_queue *q)
+{
+	struct blk_ioprio *blkioprio_blkg;
+	struct rq_qos *rqos;
+	int ret;
+
+	blkioprio_blkg = kzalloc(sizeof(*blkioprio_blkg), GFP_KERNEL);
+	if (!blkioprio_blkg)
+		return -ENOMEM;
+
+	ret = blkcg_activate_policy(q, &ioprio_policy);
+	if (ret) {
+		kfree(blkioprio_blkg);
+		return ret;
+	}
+
+	rqos = &blkioprio_blkg->rqos;
+	rqos->id = RQ_QOS_IOPRIO;
+	rqos->ops = &blkcg_ioprio_ops;
+	rqos->q = q;
+
+	rq_qos_add(q, rqos);
+
+	return 0;
+}
+
+static int __init ioprio_init(void)
+{
+	return blkcg_policy_register(&ioprio_policy);
+}
+
+static void __exit ioprio_exit(void)
+{
+	blkcg_policy_unregister(&ioprio_policy);
+}
+
+module_init(ioprio_init);
+module_exit(ioprio_exit);
diff --git a/block/blk-ioprio.h b/block/blk-ioprio.h
new file mode 100644
index 000000000000..a7785c2f1aea
--- /dev/null
+++ b/block/blk-ioprio.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _BLK_IOPRIO_H_
+#define _BLK_IOPRIO_H_
+
+#include <linux/kconfig.h>
+
+struct request_queue;
+
+#ifdef CONFIG_BLK_CGROUP_IOPRIO
+int blk_ioprio_init(struct request_queue *q);
+#else
+static inline int blk_ioprio_init(struct request_queue *q)
+{
+	return 0;
+}
+#endif
+
+#endif /* _BLK_IOPRIO_H_ */
diff --git a/block/blk-rq-qos.c b/block/blk-rq-qos.c
index 61dccf584c68..3a5400b11af7 100644
--- a/block/blk-rq-qos.c
+++ b/block/blk-rq-qos.c
@@ -11,6 +11,8 @@ const char *rq_qos_id_to_name(enum rq_qos_id id)
 		return "latency";
 	case RQ_QOS_COST:
 		return "cost";
+	case RQ_QOS_IOPRIO:
+		return "ioprio";
 	}
 	return "unknown";
 }
diff --git a/block/blk-rq-qos.h b/block/blk-rq-qos.h
index 6b5f9ae69883..1d4c6e951aa6 100644
--- a/block/blk-rq-qos.h
+++ b/block/blk-rq-qos.h
@@ -16,6 +16,7 @@ enum rq_qos_id {
 	RQ_QOS_WBT,
 	RQ_QOS_LATENCY,
 	RQ_QOS_COST,
+	RQ_QOS_IOPRIO,
 };
 
 struct rq_wait {
