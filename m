Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5DDB18CBEC;
	Fri, 18 Oct 2024 07:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729238074; cv=none; b=WFdjAPObL+FndS7FmLmrcBNfuf31yK9w113yxyBdMT9XgK0vjRmKjUcLRGEi0/d34oFRsRfUVtQcHJV30MMtFQUBy+92gyzc3QEpl6SvJzNqy3c6sR8js/hLgs0i0u+ixibqICbau458zUSXaPK7gCXe/nFaThPTBFtBKNdyqdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729238074; c=relaxed/simple;
	bh=VYb4AXeRfDuSPexQUmqF2/JPGM2xgfoqbX7SzxfRB5g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pqAFbJf9FeJty9iwG7lIdNIr4YMJOU4gxx5Bm65MJ1S4Bqx0BHakhYIjuTspIuqgr6um4rhRtFFQ2NA6973HZuTgQ2suWl4ByzfEug7tviVu0qJE2FhctarsNY0L46lZv3j7kqMnjJZkMKmiARfQjHABiEaQOIUZDpADpJO1V5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K+qzlvoN; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K+qzlvoN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729238073; x=1760774073;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VYb4AXeRfDuSPexQUmqF2/JPGM2xgfoqbX7SzxfRB5g=;
  b=K+qzlvoNWCRTFXp5eODqoCih4+AHIFc2LOeur3PVWAvFYuf1bAkgrSqW
   ZrHOWhyDlu4uM2wg1F8fSEtrlJa2E8OHMEC3o13HrsmCh0Fr7JDrFVO8H
   lZgombz3OV4rGBzbxkoYYhv9Lvc6DpP/WDCMdlF/Yh0uVGGqr5uH/NKau
   YRytlhMyBC+hyTweHapXB8rX1YSuqqV4i9joaP4ESlTdATGAyu39J4sZW
   U4hBw0o/iNZxiapLEAPM/ZrmmPszGbzPnJ94qrK9aP/m/3D41jhsJhPc/
   1hO/pYz1MH+M6af+oO/XPE3bqtHQimU9HSE62zxef7f4Zb5uVX4CoFWaW
   Q==;
X-CSE-ConnectionGUID: beZaYOjEQDW1uktY6jFqOg==
X-CSE-MsgGUID: 3QgOGX5/RcOgwCZhz6HWew==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28549560"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="28549560"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 00:54:33 -0700
X-CSE-ConnectionGUID: C6HyQPG8RaaWj0C89faR3g==
X-CSE-MsgGUID: f1pdlETeRN6DD9MxxgeLWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,213,1725346800"; 
   d="scan'208";a="79604071"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO tkristo-desk.intel.com) ([10.245.246.169])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 00:54:27 -0700
From: Tero Kristo <tero.kristo@linux.intel.com>
To: axboe@kernel.dk
Cc: hch@lst.de,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCHv2 2/2] blk-mq: add support for CPU latency limits
Date: Fri, 18 Oct 2024 10:30:38 +0300
Message-ID: <20241018075416.436916-3-tero.kristo@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241018075416.436916-1-tero.kristo@linux.intel.com>
References: <20241018075416.436916-1-tero.kristo@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for setting CPU latency limits when a request is dispatched
to driver layer, and removing it once the device is idle. The latency
limits use the dev PM QoS framework for setting per-cpu limits for
active CPUs. The feature is user configurable via sysfs knobs under the
block device.

Signed-off-by: Tero Kristo <tero.kristo@linux.intel.com>
---
 block/blk-mq.c         | 54 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/blk-mq.h | 12 ++++++++++
 2 files changed, 66 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 4b2c8e940f59..f8906e2aff6d 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -29,6 +29,7 @@
 #include <linux/blk-crypto.h>
 #include <linux/part_stat.h>
 #include <linux/sched/isolation.h>
+#include <linux/pm_qos.h>
 
 #include <trace/events/block.h>
 
@@ -2700,11 +2701,62 @@ static void blk_mq_plug_issue_direct(struct blk_plug *plug)
 static void __blk_mq_flush_plug_list(struct request_queue *q,
 				     struct blk_plug *plug)
 {
+	struct request *req, *next;
+	struct blk_mq_hw_ctx *hctx;
+	int cpu;
+
 	if (blk_queue_quiesced(q))
 		return;
+
+	rq_list_for_each_safe(&plug->mq_list, req, next) {
+		hctx = req->mq_hctx;
+
+		if (next && next->mq_hctx == hctx)
+			continue;
+
+		if (q->disk->cpu_lat_limit < 0)
+			continue;
+
+		hctx->last_active = jiffies + msecs_to_jiffies(q->disk->cpu_lat_timeout);
+
+		if (!hctx->cpu_lat_limit_active) {
+			hctx->cpu_lat_limit_active = true;
+			for_each_cpu(cpu, hctx->cpumask) {
+				struct dev_pm_qos_request *qos;
+
+				qos = per_cpu_ptr(hctx->cpu_lat_qos, cpu);
+				dev_pm_qos_add_request(get_cpu_device(cpu), qos,
+						       DEV_PM_QOS_RESUME_LATENCY,
+						       q->disk->cpu_lat_limit);
+			}
+			schedule_delayed_work(&hctx->cpu_latency_work,
+					      msecs_to_jiffies(q->disk->cpu_lat_timeout));
+		}
+	}
+
 	q->mq_ops->queue_rqs(&plug->mq_list);
 }
 
+static void blk_mq_cpu_latency_work(struct work_struct *work)
+{
+	struct blk_mq_hw_ctx *hctx = container_of(work, struct blk_mq_hw_ctx,
+						  cpu_latency_work.work);
+	int cpu;
+
+	if (time_after(jiffies, hctx->last_active)) {
+		for_each_cpu(cpu, hctx->cpumask) {
+			struct dev_pm_qos_request *qos;
+
+			qos = per_cpu_ptr(hctx->cpu_lat_qos, cpu);
+			dev_pm_qos_remove_request(qos);
+		}
+		hctx->cpu_lat_limit_active = false;
+	} else {
+		schedule_delayed_work(&hctx->cpu_latency_work,
+				      msecs_to_jiffies(hctx->queue->disk->cpu_lat_timeout));
+	}
+}
+
 static void blk_mq_dispatch_plug_list(struct blk_plug *plug, bool from_sched)
 {
 	struct blk_mq_hw_ctx *this_hctx = NULL;
@@ -3729,6 +3778,11 @@ static int blk_mq_init_hctx(struct request_queue *q,
 	if (xa_insert(&q->hctx_table, hctx_idx, hctx, GFP_KERNEL))
 		goto exit_flush_rq;
 
+	hctx->cpu_lat_qos = alloc_percpu(struct dev_pm_qos_request);
+	if (!hctx->cpu_lat_qos)
+		goto exit_flush_rq;
+	INIT_DELAYED_WORK(&hctx->cpu_latency_work, blk_mq_cpu_latency_work);
+
 	return 0;
 
  exit_flush_rq:
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index b751cc92209b..2b61942490d6 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -435,6 +435,18 @@ struct blk_mq_hw_ctx {
 	/** @kobj: Kernel object for sysfs. */
 	struct kobject		kobj;
 
+	/** @cpu_latency_work: Work to handle CPU latency PM limits. */
+	struct delayed_work	cpu_latency_work;
+
+	/** @cpu_lat_limit_active: If CPU latency limits are active or not. */
+	bool			cpu_lat_limit_active;
+
+	/** @last_active: Jiffies value when the queue was last active. */
+	unsigned long		last_active;
+
+	/** @cpu_lat_qos: PM QoS latency limits for individual CPUs. */
+	struct dev_pm_qos_request __percpu *cpu_lat_qos;
+
 #ifdef CONFIG_BLK_DEBUG_FS
 	/**
 	 * @debugfs_dir: debugfs directory for this hardware queue. Named
-- 
2.43.1

