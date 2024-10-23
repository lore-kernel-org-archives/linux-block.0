Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6DC1ADFF1;
	Wed, 23 Oct 2024 14:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729692476; cv=none; b=FSiK5+2VEepM2SgkDSYXHqwM+Ie+zC7wORYJSq3uyySjqfnHXeLh0UwtHC4Z/TsMysdmqmTbfdRSX1g858natdgi2d65FW1TtQS4MvgkXv3ay0cB5qkM50iOmsuS7dec+CfEhHR0A/FhPgWV9NKqYEOOQ6blte1qN87ZblKBv4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729692476; c=relaxed/simple;
	bh=BGfya1zO/7KRe/QXpwkCe7fgxTJA3GU1aZOOwokCgRc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DG3+AfvH9lK0OG5a5fxR+L8XdjPVarZAdCfHmq2q1FKnuUPCbCZ4fHYqziTMeuW8SQLqwgGH1NbLX92lzo7xzD+qyXsN4Z3pfAe8OcVCsBFB+pNvJ7juvLQPWxp/HbNY+ibd9rtyT+jlz1Iqsarehz+aU2RLNlUWEgpRK4FlgQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cUUrsS76; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cUUrsS76"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729692474; x=1761228474;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BGfya1zO/7KRe/QXpwkCe7fgxTJA3GU1aZOOwokCgRc=;
  b=cUUrsS76qm36n65bfIxauV2RGsnyzNk+89wZckUICacEPjwoPlcB9RoJ
   bHsovjdPraQfGHQzKTjT4A59+bw8DRHpieOEK3RAsMvTNn+Ev6K6T8Uit
   SSaJSq4h7jsLkbXx6GpaFdcdODG/mO4TCCnGn7SU0BIn5Ul7dw7PdO0M9
   Z+p9AlY3oYHiQiCqSoRjqDBA7OkGR/UFiJ3/V8j5PNBGjTYkerj2OVYXN
   5Mn9dL2ZdrzWhO56Fmm06zcSEM59QnRQ/it3EApn6JHMKzTlG5hrS30e7
   t0j8hOjgEiLFa/58zmoZnbZWyTcGQKNXGpxKwCH7NcSilPqzqfaacQf88
   A==;
X-CSE-ConnectionGUID: jbpmO3mKRAylId/Q7zLlyQ==
X-CSE-MsgGUID: fDivbJInR3mn8MZ7gh6Hyw==
X-IronPort-AV: E=McAfee;i="6700,10204,11234"; a="16903297"
X-IronPort-AV: E=Sophos;i="6.11,226,1725346800"; 
   d="scan'208";a="16903297"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 07:06:07 -0700
X-CSE-ConnectionGUID: G3DNUeWGRpmxsUBbkKyi8g==
X-CSE-MsgGUID: ME0MdL5CQ5G8C9hoXxaMyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,226,1725346800"; 
   d="scan'208";a="117692788"
Received: from lfiedoro-mobl.ger.corp.intel.com (HELO tkristo-desk.intel.com) ([10.245.246.76])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 07:06:04 -0700
From: Tero Kristo <tero.kristo@linux.intel.com>
To: axboe@kernel.dk
Cc: hch@lst.de,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] blk-mq: add support for CPU latency limits
Date: Wed, 23 Oct 2024 17:06:00 +0300
Message-ID: <20241023140601.839546-1-tero.kristo@linux.intel.com>
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
to driver layer, and removing it once the device is idle. A delayed work
is scheduled from the first block layer activity, and the workqueue ticks
with the configurable timeout period, checking if there has been any
activity. After the initial kick of the workqueue, only the last activity
time is updated with the current jiffies value, minimizing overhead.
The feature is user configurable via sysfs knobs under each individual
block device.

Signed-off-by: Tero Kristo <tero.kristo@linux.intel.com>
---
v2:
  * moved implementation back to block layer, to the request queue
    dispatch section

v3:
  * further optimization; fast path now only updates the jiffies value,
    and kicks off the workqueue for handling the PM QoS activities if
    not already active
  * moved the fast path handling under individual request handling, to
    avoid iterating the whole request queue

 block/blk-mq.c         | 51 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/blk-mq.h | 12 ++++++++++
 2 files changed, 63 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 4b2c8e940f59..e8d82601471d 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -29,6 +29,7 @@
 #include <linux/blk-crypto.h>
 #include <linux/part_stat.h>
 #include <linux/sched/isolation.h>
+#include <linux/pm_qos.h>
 
 #include <trace/events/block.h>
 
@@ -1303,6 +1304,12 @@ static void blk_add_rq_to_plug(struct blk_plug *plug, struct request *rq)
 	rq->rq_next = NULL;
 	rq_list_add(&plug->mq_list, rq);
 	plug->rq_count++;
+
+	if (rq->q->disk->cpu_lat_limit >= 0) {
+		rq->mq_hctx->last_active = jiffies;
+		if (!delayed_work_pending(&rq->mq_hctx->cpu_latency_work))
+			schedule_delayed_work(&rq->mq_hctx->cpu_latency_work, 0);
+	}
 }
 
 /**
@@ -2705,6 +2712,45 @@ static void __blk_mq_flush_plug_list(struct request_queue *q,
 	q->mq_ops->queue_rqs(&plug->mq_list);
 }
 
+static void blk_mq_cpu_latency_work(struct work_struct *work)
+{
+	struct blk_mq_hw_ctx *hctx = container_of(work, struct blk_mq_hw_ctx,
+						  cpu_latency_work.work);
+	int cpu;
+	bool add_req = false;
+	bool remove_req = false;
+	unsigned long timeout;
+
+	timeout = msecs_to_jiffies(hctx->queue->disk->cpu_lat_timeout);
+
+	if (time_after(jiffies, hctx->last_active + timeout)) {
+		remove_req = true;
+		hctx->cpu_lat_limit_active = false;
+	} else {
+		if (!hctx->cpu_lat_limit_active) {
+			hctx->cpu_lat_limit_active = true;
+			add_req = true;
+		}
+		schedule_delayed_work(&hctx->cpu_latency_work,
+				      hctx->last_active + timeout - jiffies);
+	}
+
+	if (!add_req && !remove_req)
+		return;
+
+	for_each_cpu(cpu, hctx->cpumask) {
+		struct dev_pm_qos_request *qos;
+
+		qos = per_cpu_ptr(hctx->cpu_lat_qos, cpu);
+		if (add_req)
+			dev_pm_qos_add_request(get_cpu_device(cpu), qos,
+					       DEV_PM_QOS_RESUME_LATENCY,
+					       hctx->queue->disk->cpu_lat_limit);
+		else
+			dev_pm_qos_remove_request(qos);
+	}
+}
+
 static void blk_mq_dispatch_plug_list(struct blk_plug *plug, bool from_sched)
 {
 	struct blk_mq_hw_ctx *this_hctx = NULL;
@@ -3729,6 +3775,11 @@ static int blk_mq_init_hctx(struct request_queue *q,
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
index 4fecf46ef681..4442c18bf3d9 100644
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

