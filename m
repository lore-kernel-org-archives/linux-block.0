Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C851813CFAD
	for <linux-block@vger.kernel.org>; Tue, 26 Mar 2024 15:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711467347; cv=none; b=aVgaxNbktRFBb2FU+d0l5um1ZUYWI83arVIFq2KC1Esk7uOVJW04UIBO+p+phdZIScKBVbUw7jCA670pPZn7C3DFKlnoJvCC5GCxIlYhjGvL7eqf3IZ0TK7C79pNeR8GKA9yG+R4Y++6a5F1UdHfjuWCoBTAxS5kC7MZLk4jkhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711467347; c=relaxed/simple;
	bh=jSfctXy7iDh+sBDb0pWQLL9/YC37kXemBr4r3BoKB7U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LACrMEy+i58iXWFwqMsKMdQ3aBq5MaWBtR9W1JRecLUajEhr7/IK81AMN24HTXAAVJ8L0pGI907/QOUDGcN7u+K8uxWmcgXQIl4hwkItIZYjZKuF3zgRd/OAd1ge/QOLNhFEvHEm3PLnh8EVb176Gqq58JSnVJRWO5wYxoLeC2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=onkOG1WP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="onkOG1WP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A56DDC43390;
	Tue, 26 Mar 2024 15:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711467347;
	bh=jSfctXy7iDh+sBDb0pWQLL9/YC37kXemBr4r3BoKB7U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=onkOG1WPlADuSF/bLp7Hus7hl0/mSWLWSTji13W7JAggiNml/jpO5DmbkAnEt9wF5
	 kmj5GfEq0oNzcA9SfncF3WXU9cnlT+c+wQSjaieWi+VgL3xE+VboGalenJhmdl+bzy
	 s0g6F6FLp30AQRLrPdgM4g3EdGq0KOHbhpYbOBm3FVdQwnF1OGG1ZJpNFiMawhKtkE
	 C/YXSUxVbnLG9MqTCrk02Ee3BZzhCL28JfQsYgPEHJyErBDXfxd6aD5E0Q1Y3e0l4I
	 Z2odzmR1pwseHqaQeRTICss3XV6MWSDcAl1ljlSYN6LfMrZeTk6Kk8RfgT5k4Ut/4k
	 s7NBt/+cRgk1g==
From: Hannes Reinecke <hare@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 1/2] block: track per-node I/O latency
Date: Tue, 26 Mar 2024 16:35:28 +0100
Message-Id: <20240326153529.75989-2-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240326153529.75989-1-hare@kernel.org>
References: <20240326153529.75989-1-hare@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new option 'BLK_NODE_LATENCY' to track per-node I/O latency.
This can be used by I/O scheduler to determine the 'best' queue
to send I/O to.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 block/Kconfig          |   7 +
 block/Makefile         |   1 +
 block/blk-mq-debugfs.c |   2 +
 block/blk-nodelat.c    | 368 +++++++++++++++++++++++++++++++++++++++++
 block/blk-rq-qos.h     |   6 +
 include/linux/blk-mq.h |  11 ++
 6 files changed, 395 insertions(+)
 create mode 100644 block/blk-nodelat.c

diff --git a/block/Kconfig b/block/Kconfig
index 1de4682d48cc..7ce60becfb1d 100644
--- a/block/Kconfig
+++ b/block/Kconfig
@@ -186,6 +186,13 @@ config BLK_CGROUP_IOPRIO
 	scheduler and block devices process requests. Only some I/O schedulers
 	and some block devices support I/O priorities.
 
+config BLK_NODE_LATENCY
+       bool "Track per-node I/O latency"
+       help
+       Enable the .nlat interface for tracking per-node I/O latency.
+       This can be used by I/O schedulers to determine the queue with the
+       least latency.
+
 config BLK_DEBUG_FS
 	bool "Block layer debugging information in debugfs"
 	default y
diff --git a/block/Makefile b/block/Makefile
index 46ada9dc8bbf..e2683f55d15f 100644
--- a/block/Makefile
+++ b/block/Makefile
@@ -21,6 +21,7 @@ obj-$(CONFIG_BLK_DEV_THROTTLING)	+= blk-throttle.o
 obj-$(CONFIG_BLK_CGROUP_IOPRIO)	+= blk-ioprio.o
 obj-$(CONFIG_BLK_CGROUP_IOLATENCY)	+= blk-iolatency.o
 obj-$(CONFIG_BLK_CGROUP_IOCOST)	+= blk-iocost.o
+obj-$(CONFIG_BLK_NODE_LATENCY) += blk-nodelat.o
 obj-$(CONFIG_MQ_IOSCHED_DEADLINE)	+= mq-deadline.o
 obj-$(CONFIG_MQ_IOSCHED_KYBER)	+= kyber-iosched.o
 bfq-y				:= bfq-iosched.o bfq-wf2q.o bfq-cgroup.o
diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 94668e72ab09..cb38228b95d8 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -762,6 +762,8 @@ static const char *rq_qos_id_to_name(enum rq_qos_id id)
 		return "latency";
 	case RQ_QOS_COST:
 		return "cost";
+	case RQ_QOS_NLAT:
+		return "node-latency";
 	}
 	return "unknown";
 }
diff --git a/block/blk-nodelat.c b/block/blk-nodelat.c
new file mode 100644
index 000000000000..45d7e622b147
--- /dev/null
+++ b/block/blk-nodelat.c
@@ -0,0 +1,368 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Per-node request latency tracking.
+ *
+ * Copyright (C) 2023 Hannes Reinecke
+ *
+ * A simple per-node latency tracker for use
+ * by I/O scheduler.
+ * Latencies are measures over 'win_usec' microseconds
+ * and stored per node.
+ * If the number of measurements falls below 'lowat'
+ * the measurement is assumed to be unreliable and
+ * will become 'stale'.
+ * These 'stale' latencies can be 'decayed', where
+ * during each measurement interval the 'stale'
+ * latency value is decreased by 'decay' percent.
+ * Once the 'stale' latency reaches zero it
+ * will be updated by the measured latency.
+ */
+#include <linux/kernel.h>
+#include <linux/blk_types.h>
+#include <linux/slab.h>
+
+#include "blk-stat.h"
+#include "blk-rq-qos.h"
+#include "blk.h"
+
+#define NLAT_DEFAULT_LOWAT 2
+#define NLAT_DEFAULT_DECAY 50
+
+struct rq_nlat {
+	struct rq_qos rqos;
+
+	u64 win_usec;		/* latency measurement window */
+	unsigned int lowat;	/* Low Watermark below which latency measurement is deemed unreliable */
+	unsigned int decay;	/* Percentage for 'decaying' latencies */
+	bool enabled;
+
+	struct blk_stat_callback *cb;
+
+	unsigned int num;
+	u64 *latency;
+	unsigned int *samples;
+};
+
+static inline struct rq_nlat *RQNLAT(struct rq_qos *rqos)
+{
+	return container_of(rqos, struct rq_nlat, rqos);
+}
+
+static u64 nlat_default_latency_usec(struct request_queue *q)
+{
+	/*
+	 * We default to 2msec for non-rotational storage, and 75msec
+	 * for rotational storage.
+	 */
+	if (blk_queue_nonrot(q))
+		return 2000ULL;
+	else
+		return 75000ULL;
+}
+
+static void nlat_timer_fn(struct blk_stat_callback *cb)
+{
+	struct rq_nlat *nlat = cb->data;
+	int n;
+
+	for (n = 0; n < cb->buckets; n++) {
+		if (cb->stat[n].nr_samples < nlat->lowat && nlat->latency[n]) {
+			/*
+			 * 'decay' the latency by the specified
+			 * percentage to ensure the nodes are
+			 * being tested to balance out temporary
+			 * latency spikes.
+			 */
+			if (nlat->decay)
+				nlat->latency[n] =
+					div64_u64(nlat->latency[n] * nlat->decay, 100);
+		} else
+			nlat->latency[n] = cb->stat[n].mean;
+		nlat->samples[n] = cb->stat[n].nr_samples;
+	}
+	if (nlat->enabled)
+		blk_stat_activate_nsecs(nlat->cb, nlat->win_usec * 1000);
+}
+
+static int nlat_node(const struct request *rq)
+{
+	if (!rq->mq_ctx)
+		return -1;
+	return cpu_to_node(blk_mq_rq_cpu((struct request *)rq));
+}
+
+static void nlat_exit(struct rq_qos *rqos)
+{
+	struct rq_nlat *nlat = RQNLAT(rqos);
+
+	blk_stat_remove_callback(nlat->rqos.disk->queue, nlat->cb);
+	blk_stat_free_callback(nlat->cb);
+	kfree(nlat->samples);
+	kfree(nlat->latency);
+	kfree(nlat);
+}
+
+u64 blk_nodelat_latency(struct request_queue *q, int node)
+{
+	struct rq_qos *rqos;
+	struct rq_nlat *nlat;
+
+	rqos = nlat_rq_qos(q);
+	if (!rqos)
+		return 0;
+	nlat = RQNLAT(rqos);
+	if (node > nlat->num)
+		return 0;
+
+	return div64_u64(nlat->latency[node], 1000);
+}
+EXPORT_SYMBOL_GPL(blk_nodelat_latency);
+
+int blk_nodelat_enable(struct request_queue *q)
+{
+	struct rq_qos *rqos;
+	struct rq_nlat *nlat;
+
+	/* Throttling already enabled? */
+	rqos = nlat_rq_qos(q);
+	if (!rqos)
+		return -EINVAL;
+	nlat = RQNLAT(rqos);
+	if (nlat->enabled)
+		return 0;
+
+	/* Queue not registered? Maybe shutting down... */
+	if (!blk_queue_registered(q))
+		return -EAGAIN;
+
+	if (queue_is_mq(q)) {
+		nlat->enabled = true;
+		blk_stat_activate_nsecs(nlat->cb, nlat->win_usec * 1000);
+	}
+	return 0;
+}
+EXPORT_SYMBOL_GPL(blk_nodelat_enable);
+
+void blk_nodelat_disable(struct request_queue *q)
+{
+	struct rq_qos *rqos = nlat_rq_qos(q);
+	struct rq_nlat *nlat;
+	if (!rqos)
+		return;
+	nlat = RQNLAT(rqos);
+	if (nlat->enabled) {
+		blk_stat_deactivate(nlat->cb);
+		nlat->enabled = false;
+	}
+}
+EXPORT_SYMBOL_GPL(blk_nodelat_disable);
+
+#ifdef CONFIG_BLK_DEBUG_FS
+static int nlat_win_usec_show(void *data, struct seq_file *m)
+{
+	struct rq_qos *rqos = data;
+	struct rq_nlat *nlat = RQNLAT(rqos);
+
+	seq_printf(m, "%llu\n", nlat->win_usec);
+	return 0;
+}
+
+static ssize_t nlat_win_usec_write(void *data, const char __user *buf,
+			size_t count, loff_t *ppos)
+{
+	struct rq_qos *rqos = data;
+	struct rq_nlat *nlat = RQNLAT(rqos);
+	char val[16] = { };
+	u64 usec;
+	int err;
+
+	if (blk_queue_dying(nlat->rqos.disk->queue))
+		return -ENOENT;
+
+	if (count >= sizeof(val))
+		return -EINVAL;
+
+	if (copy_from_user(val, buf, count))
+		return -EFAULT;
+
+	err = kstrtoull(val, 10, &usec);
+	if (err)
+		return err;
+	blk_stat_deactivate(nlat->cb);
+	nlat->win_usec = usec;
+	blk_stat_activate_nsecs(nlat->cb, nlat->win_usec * 1000);
+
+	return count;
+}
+
+static int nlat_lowat_show(void *data, struct seq_file *m)
+{
+	struct rq_qos *rqos = data;
+	struct rq_nlat *nlat = RQNLAT(rqos);
+
+	seq_printf(m, "%u\n", nlat->lowat);
+	return 0;
+}
+
+static ssize_t nlat_lowat_write(void *data, const char __user *buf,
+			size_t count, loff_t *ppos)
+{
+	struct rq_qos *rqos = data;
+	struct rq_nlat *nlat = RQNLAT(rqos);
+	char val[16] = { };
+	unsigned int lowat;
+	int err;
+
+	if (blk_queue_dying(nlat->rqos.disk->queue))
+		return -ENOENT;
+
+	if (count >= sizeof(val))
+		return -EINVAL;
+
+	if (copy_from_user(val, buf, count))
+		return -EFAULT;
+
+	err = kstrtouint(val, 10, &lowat);
+	if (err)
+		return err;
+	blk_stat_deactivate(nlat->cb);
+	nlat->lowat = lowat;
+	blk_stat_activate_nsecs(nlat->cb, nlat->win_usec * 1000);
+
+	return count;
+}
+
+static int nlat_decay_show(void *data, struct seq_file *m)
+{
+	struct rq_qos *rqos = data;
+	struct rq_nlat *nlat = RQNLAT(rqos);
+
+	seq_printf(m, "%u\n", nlat->decay);
+	return 0;
+}
+
+static ssize_t nlat_decay_write(void *data, const char __user *buf,
+			size_t count, loff_t *ppos)
+{
+	struct rq_qos *rqos = data;
+	struct rq_nlat *nlat = RQNLAT(rqos);
+	char val[16] = { };
+	unsigned int decay;
+	int err;
+
+	if (blk_queue_dying(nlat->rqos.disk->queue))
+		return -ENOENT;
+
+	if (count >= sizeof(val))
+		return -EINVAL;
+
+	if (copy_from_user(val, buf, count))
+		return -EFAULT;
+
+	err = kstrtouint(val, 10, &decay);
+	if (err)
+		return err;
+	if (decay > 100)
+		return -EINVAL;
+	blk_stat_deactivate(nlat->cb);
+	nlat->decay = decay;
+	blk_stat_activate_nsecs(nlat->cb, nlat->win_usec * 1000);
+
+	return count;
+}
+
+static int nlat_enabled_show(void *data, struct seq_file *m)
+{
+	struct rq_qos *rqos = data;
+	struct rq_nlat *nlat = RQNLAT(rqos);
+
+	seq_printf(m, "%d\n", nlat->enabled);
+	return 0;
+}
+
+static int nlat_id_show(void *data, struct seq_file *m)
+{
+	struct rq_qos *rqos = data;
+
+	seq_printf(m, "%u\n", rqos->id);
+	return 0;
+}
+
+static int nlat_latency_show(void *data, struct seq_file *m)
+{
+	struct rq_qos *rqos = data;
+	struct rq_nlat *nlat = RQNLAT(rqos);
+	int n;
+
+	for (n = 0; n < nlat->num; n++)
+		seq_printf(m, "%llu %u ", nlat->latency[n], nlat->samples[n]);
+	seq_printf(m, "\n");
+	return 0;
+}
+
+static const struct blk_mq_debugfs_attr nlat_debugfs_attrs[] = {
+	{"win_usec", 0600, nlat_win_usec_show, nlat_win_usec_write},
+	{"lowat", 0600, nlat_lowat_show, nlat_lowat_write},
+	{"decay", 0600, nlat_decay_show, nlat_decay_write},
+	{"enabled", 0400, nlat_enabled_show},
+	{"id", 0400, nlat_id_show},
+	{"latency", 0400, nlat_latency_show},
+	{},
+};
+#endif
+
+static const struct rq_qos_ops nlat_rqos_ops = {
+	.exit = nlat_exit,
+#ifdef CONFIG_BLK_DEBUG_FS
+	.debugfs_attrs = nlat_debugfs_attrs,
+#endif
+};
+
+int blk_nodelat_init(struct gendisk *disk)
+{
+	struct rq_nlat *nlat;
+	int nlat_num = num_possible_nodes();
+	int ret = -ENOMEM;
+
+	nlat = kzalloc(sizeof(*nlat), GFP_KERNEL);
+	if (!nlat)
+		return -ENOMEM;
+
+	nlat->num = nlat_num;
+	nlat->lowat = 2;
+	nlat->decay = 50;
+	nlat->latency = kzalloc(sizeof(u64) * nlat->num, GFP_KERNEL);
+	if (!nlat->latency)
+		goto err_free;
+	nlat->samples = kzalloc(sizeof(unsigned int) * nlat->num, GFP_KERNEL);
+	if (!nlat->samples)
+		goto err_free;
+	nlat->cb = blk_stat_alloc_callback(nlat_timer_fn, nlat_node,
+					   nlat->num, nlat);
+	if (!nlat->cb)
+		goto err_free;
+
+	nlat->win_usec = nlat_default_latency_usec(disk->queue);
+
+	/*
+	 * Assign rwb and add the stats callback.
+	 */
+	mutex_lock(&disk->queue->rq_qos_mutex);
+	ret = rq_qos_add(&nlat->rqos, disk, RQ_QOS_NLAT, &nlat_rqos_ops);
+	mutex_unlock(&disk->queue->rq_qos_mutex);
+	if (ret)
+		goto err_free_cb;
+
+	blk_stat_add_callback(disk->queue, nlat->cb);
+
+	return 0;
+
+err_free_cb:
+	blk_stat_free_callback(nlat->cb);
+err_free:
+	kfree(nlat->samples);
+	kfree(nlat->latency);
+	kfree(nlat);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(blk_nodelat_init);
diff --git a/block/blk-rq-qos.h b/block/blk-rq-qos.h
index 37245c97ee61..2fc11ced0c00 100644
--- a/block/blk-rq-qos.h
+++ b/block/blk-rq-qos.h
@@ -17,6 +17,7 @@ enum rq_qos_id {
 	RQ_QOS_WBT,
 	RQ_QOS_LATENCY,
 	RQ_QOS_COST,
+	RQ_QOS_NLAT,
 };
 
 struct rq_wait {
@@ -79,6 +80,11 @@ static inline struct rq_qos *iolat_rq_qos(struct request_queue *q)
 	return rq_qos_id(q, RQ_QOS_LATENCY);
 }
 
+static inline struct rq_qos *nlat_rq_qos(struct request_queue *q)
+{
+	return rq_qos_id(q, RQ_QOS_NLAT);
+}
+
 static inline void rq_wait_init(struct rq_wait *rq_wait)
 {
 	atomic_set(&rq_wait->inflight, 0);
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 390d35fa0032..daeb837b9bc6 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -1229,4 +1229,15 @@ static inline bool blk_req_can_dispatch_to_zone(struct request *rq)
 }
 #endif /* CONFIG_BLK_DEV_ZONED */
 
+#ifdef CONFIG_BLK_NODE_LATENCY
+int blk_nodelat_enable(struct request_queue *q);
+void blk_nodelat_disable(struct request_queue *q);
+u64 blk_nodelat_latency(struct request_queue *q, int node);
+int blk_nodelat_init(struct gendisk *disk);
+#else
+static inline in blk_nodelat_enable(struct request_queue *q) { return 0; }
+static inline void blk_nodelat_disable(struct request_queue *q) {}
+u64 blk_nodelat_latency(struct request_queue *q, int node) { return 0; }
+static inline in blk_nodelat_init(struct gendisk *disk) { return -ENOTSUPP; }
+#endif
 #endif /* BLK_MQ_H */
-- 
2.35.3

