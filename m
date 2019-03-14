Return-Path: <SRS0=8xnz=RR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9E07C43381
	for <linux-block@archiver.kernel.org>; Thu, 14 Mar 2019 14:18:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82B142184E
	for <linux-block@archiver.kernel.org>; Thu, 14 Mar 2019 14:18:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727511AbfCNOSL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Mar 2019 10:18:11 -0400
Received: from mga17.intel.com ([192.55.52.151]:8481 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727479AbfCNOSL (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Mar 2019 10:18:11 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Mar 2019 07:18:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,478,1544515200"; 
   d="scan'208";a="328611013"
Received: from mdziegie-mobl.ger.corp.intel.com (HELO localhost.igk.intel.com) ([10.237.143.15])
  by fmsmga005.fm.intel.com with ESMTP; 14 Mar 2019 07:18:09 -0700
From:   Marcin Dziegielewski <marcin.dziegielewski@intel.com>
To:     mb@lightnvm.io, javier@javigon.com, hans.holmberg@cnexlabs.com
Cc:     linux-block@vger.kernel.org, marcin.dziegielewski@intel.com,
        igor.j.konopko@intel.com
Subject: [PATCH] lightnvm: pblk: set write thread affinity to particular cpu
Date:   Thu, 14 Mar 2019 15:17:59 +0100
Message-Id: <1552573079-12712-1-git-send-email-marcin.dziegielewski@intel.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In some cases write thread migration between cpus can cause
sending writes in improper order and in consequence a lot of
errors from device.

Write thread affinity to particular cpu prevent before it.

Signed-off-by: Marcin Dziegielewski <marcin.dziegielewski@intel.com>
---
 drivers/lightnvm/pblk-init.c | 30 +++++++++++++++++++++++++++++-
 drivers/lightnvm/pblk.h      |  1 +
 drivers/nvme/host/lightnvm.c |  1 +
 include/linux/lightnvm.h     |  2 ++
 4 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index 81e8ed4..bd25004 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -21,6 +21,8 @@
 
 #include "pblk.h"
 #include "pblk-trace.h"
+#include <linux/cpumask.h>
+#include <linux/numa.h>
 
 static unsigned int write_buffer_size;
 
@@ -47,6 +49,8 @@ struct pblk_global_caches {
 
 struct bio_set pblk_bio_set;
 
+cpumask_t free_cpumask;
+
 static int pblk_rw_io(struct request_queue *q, struct pblk *pblk,
 			  struct bio *bio)
 {
@@ -1098,6 +1102,9 @@ static int pblk_lines_init(struct pblk *pblk)
 
 static int pblk_writer_init(struct pblk *pblk)
 {
+	cpumask_t tmp_cpumask, cpumask;
+	int cpu;
+
 	pblk->writer_ts = kthread_create(pblk_write_ts, pblk, "pblk-writer-t");
 	if (IS_ERR(pblk->writer_ts)) {
 		int err = PTR_ERR(pblk->writer_ts);
@@ -1108,6 +1115,22 @@ static int pblk_writer_init(struct pblk *pblk)
 		return err;
 	}
 
+	cpumask_and(&tmp_cpumask, cpumask_of_node(pblk->dev->parent->node),
+			cpu_online_mask);
+	cpumask_and(&cpumask, &tmp_cpumask, &free_cpumask);
+
+	if (!cpumask_weight(&free_cpumask)) {
+		free_cpumask = CPU_MASK_ALL;
+		cpumask_and(&cpumask, &tmp_cpumask, &free_cpumask);
+	}
+
+	cpu = cpumask_last(&cpumask);
+
+	kthread_bind(pblk->writer_ts, cpu);
+
+	cpumask_clear_cpu(cpu, &free_cpumask);
+	pblk->writer_cpu = cpu;
+
 	timer_setup(&pblk->wtimer, pblk_write_timer_fn, 0);
 	mod_timer(&pblk->wtimer, jiffies + msecs_to_jiffies(100));
 
@@ -1126,8 +1149,11 @@ static void pblk_writer_stop(struct pblk *pblk)
 			"Stopping not fully synced write buffer\n");
 
 	del_timer_sync(&pblk->wtimer);
-	if (pblk->writer_ts)
+	if (pblk->writer_ts) {
+		set_cpus_allowed_ptr(pblk->writer_ts, cpu_online_mask);
 		kthread_stop(pblk->writer_ts);
+		cpumask_set_cpu(pblk->writer_cpu, &free_cpumask);
+	}
 }
 
 static void pblk_free(struct pblk *pblk)
@@ -1328,6 +1354,8 @@ static int __init pblk_module_init(void)
 {
 	int ret;
 
+	free_cpumask = CPU_MASK_ALL;
+
 	ret = bioset_init(&pblk_bio_set, BIO_POOL_SIZE, 0, 0);
 	if (ret)
 		return ret;
diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index 381f074..650f983 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -690,6 +690,7 @@ struct pblk {
 	atomic_t inflight_io;		/* General inflight I/O counter */
 
 	struct task_struct *writer_ts;
+	int writer_cpu;
 
 	/* Simple translation map of logical addresses to physical addresses.
 	 * The logical addresses is known by the host system, while the physical
diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index 949e29e..971a19f 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -982,6 +982,7 @@ int nvme_nvm_register(struct nvme_ns *ns, char *disk_name, int node)
 	memcpy(dev->name, disk_name, DISK_NAME_LEN);
 	dev->ops = &nvme_nvm_dev_ops;
 	dev->private_data = ns;
+	dev->node = node;
 	ns->ndev = dev;
 
 	return nvm_register(dev);
diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
index 5d865a5..312029e 100644
--- a/include/linux/lightnvm.h
+++ b/include/linux/lightnvm.h
@@ -427,6 +427,8 @@ struct nvm_dev {
 	char name[DISK_NAME_LEN];
 	void *private_data;
 
+	int node;
+
 	void *rmap;
 
 	struct mutex mlock;
-- 
1.8.3.1

