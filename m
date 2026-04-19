Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020079.outbound.protection.outlook.com [52.101.195.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3555279DB3;
	Sun, 19 Apr 2026 02:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776565852; cv=fail; b=LVqmikJ98tKdp94uJAOUOhpWFpht0J4/ikK8wEw4F54ndCRs4BeXgxKIE7UNK9zlw0OVwy1+T1QNEASou+Yxyh8ZXGOxEANfQgKfqagZtYLun2Z/6zsuwU3VEzsrTirujBpgIJC8U2kZnjBP9s4WQvAvyHZC9C81lkouURPTYoA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776565852; c=relaxed/simple;
	bh=uaaarnnigyOz2hSE8V896hY8CUoXSACaMm+OZG8dbVI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Dl1/3kYeXNSa4vFqQZLM58DYVxYVgpgq7zjPe0AolkFoPJ3rxwd+1+3lwnCKkhg/l5kWIeKAagPef/+B/CAIZfkhtXmRTBBfKNQ+ERW3whAv4Fz2/9HeE67tXhxbsZjo4e8YvoKNEiDuS3wll0I7S40CSBNAM9cgOeno0dgStBg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.195.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wQcyVfnDfAnOKvIyJbTYuwDN9zGuhN6pOLyjgwsf63MgDgBXp52We8Q60WAttONDEV0sJcSLq4Z2N7k2HiCfTiGFrL05bsrwuqDFA0KE0wyQ6zLbrg+xBS3B6isSQk3Yw7JWAtT513JY8ttf0wjF3lXgV/VBUzY8Wz5/RqxMyKcJ/TvLUg5DY1Sj8Tij5zz5dA0idG5CFR9rUpG2cNx/1JI/fnesSLCit98dwrAjyo3KpoL0h8nPP2lpXU0NviRhPUFVxcmjJF+G55Er8L5M3VsW8q+0B9bVSbaaI+IWK7KIbcS8GkkK/xAWLBP0geHwxy1zTaL59MWjTzKVyiSPAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mUcGUDhjWUooYRRlF/14NUYfw35YqjzdytWavXpkpxY=;
 b=NGw1tuBFoBZDjvtPEugDSzISTLGErICKb9ykqAsNOFwlt/GntaXa0wqddxw5gfEs3cIx5R/ShPZxqQ8ao4enxA/Vt/EVFd4o3ToAUV5/UDWyaT+WFkc/tNk+S1d+FfuTCNu3pKhIw9kroWCaHyNxSR6n4HT5Jof64hOqVS7c/EJWzpoARhsICSM9gAeyKn9RLlCKHAqU3eqnw/YqS6aTzgaLfQg6jqE6ZSjbb+fNgZYpFQwyAswIHxvr9ZN6f5eXuEFrUe3TrzCaITwpoJJsbqwzJdOxQVtgldKkxakW9gxIf9ALCvSb+QcjRHzEjAkp62DFlDAscXNQS3mW2lCzQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by LO2P123MB5960.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:255::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.31; Sun, 19 Apr
 2026 02:30:48 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%2]) with mapi id 15.20.9769.046; Sun, 19 Apr 2026
 02:30:48 +0000
From: Aaron Tomlin <atomlin@atomlin.com>
To: axboe@kernel.dk,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com
Cc: bvanassche@acm.org,
	johannes.thumshirn@wdc.com,
	kch@nvidia.com,
	dlemoal@kernel.org,
	ritesh.list@gmail.com,
	loberman@redhat.com,
	neelx@suse.com,
	sean@ashe.io,
	mproche@gmail.com,
	chjohnst@gmail.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v4 2/2] blk-mq: expose tag starvation counts via debugfs
Date: Sat, 18 Apr 2026 22:30:36 -0400
Message-ID: <20260419023036.1419514-3-atomlin@atomlin.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260419023036.1419514-1-atomlin@atomlin.com>
References: <20260419023036.1419514-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR04CA0138.namprd04.prod.outlook.com
 (2603:10b6:408:ed::23) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|LO2P123MB5960:EE_
X-MS-Office365-Filtering-Correlation-Id: b6e47df7-06b7-45f1-d7bc-08de9dbbaab7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|18096099003|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	eXlQgdAzQsIpLyVy31eXtjU3KMAf0ZoAzka4b4+xdGM6dzLra3kaRzHTC8R/fbkbEjUNh1kTVYPAXAkHm4iLU2feagKcCxMA2qR59czM6D++3sNpJ1h+3MbrOTnuHHsFNQcSyukuR5f53AWsB3THixZZpBIGPXqJP8zHoNIClRObF3wc6Bt2e3jZxPx7ylOfgpIdSxD82McOf0l5iJPZncnSpkZ1dOZGtwtO41gNFi9vY811Dmca7qUM0AXqeoVzVJNgWUBvajeAWjmo5s3SUj3rMJjheZK3N+GRtbkssUdMNb6pdGeqVMQx9d4rBwLr8zJfjFC7CMeHww0AC0hxtmsL986UBm9FZBt7sLF7l9aSpW7A0rusJJUa8jg2voQZKdE3MSJMtPC3gsS+y4a28rH51BCKPwauHnvSKJouET1F8c6fLAUvlHK577/nx4Ntm/29lEOfg4sGsOl1i5gDtz5L27vH0C1BeNurnihhRoOSM35vuCULYreqKth8CzBw1vEz04ZqkvBOg0pQCnNk5eTiyLvJ3TE/JlmnzEczjnXmwtBtuBL1WZiCTARAywK9Q+FY2IuN74utsYwV1QXdjEytFcq6+/ifcUBuP7NkLusDTb8zIkLSowXmbrSaS3jdsz3qA2zDKCmmuC7o3T2+ZYDlEiu15ciREq244QtGdZFHTfMm9vgu1vdCYKlkYcsupV6XZwCk50pB4ZeygTWWdwK7VRUngABsPVVHsNMcXdE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(18096099003)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SdivcP8vL5bgqe0AtYgCD9ecPIOUsZqo6buTvyIey15KYDHEK50v1qtAKwry?=
 =?us-ascii?Q?jIauvq4XAtj+Bq0bNnRXteu0RPFfYaRyckLKkkkdJlkon+G76YkpZFgTQAHP?=
 =?us-ascii?Q?dOOlKT7hg7kDya/X4QgXrm2PCno6Mn4GEQeinB0WISzOv1gloDDH1caLMgbo?=
 =?us-ascii?Q?ywTSE1wcZEDqk7Z+AkhcYN6ZIlGbVZL1B0CruopUkIDcyfC+NsiGEGkqmu+D?=
 =?us-ascii?Q?dwWlyr4aIYdHge9RCdAcatW3FXoCywANa8JugnGvj7++wrGODK8je0hB2Rp3?=
 =?us-ascii?Q?yDOMit3O+ER+GLNA+ughxYo36+DFh7JnyqOpZz2NOyNAa1q8d17zLKY6iPh1?=
 =?us-ascii?Q?voRgZQvgWXg2m6xx9klSGuNenqgJJePPugSaSOudn4aaSgPDjYZglu8Ue/l2?=
 =?us-ascii?Q?0WCt04EhYrfB5Ylj4nliOS3V4yTh1we5b+98///faK0rlZByu64pxSAvPKEq?=
 =?us-ascii?Q?0BOXlJoD7WpBuAwTWpssPkDWZnJGtQnvvMs46mKq6ZWmY/entRxb2BcNWjbs?=
 =?us-ascii?Q?ubhazUD1C0FdWGaWq+TBO/M/er/RWMcNUyG9g0dvpC97JgVEIzyS5IPzswCD?=
 =?us-ascii?Q?SAGfbEifHVveygJKlm+cGV6JaRSzsYnsnKNWfZ2KM5697NpS5OSI2tFvZ4UC?=
 =?us-ascii?Q?kk5m4fSHRKmmGljemaB5V/4Y2uQu90tVjBZE/7R8G5gvJFWwD8BgyEzAhTYV?=
 =?us-ascii?Q?ie4FQa5+lylEPxxHbXxfixPqguN5vjw1hrZK64Fx7pWnP+UxDiGIQUFyFPQN?=
 =?us-ascii?Q?8CloTOSgFftXpMdacqaPCnm1ehS+UlPC4QESCvaoZsfNP3DLLTDNSeKGL6UJ?=
 =?us-ascii?Q?TTSrPt/jTbYydRuTGMlVzl+XNdj2dE7sGxr0wR8xuhte2FLVP2o7O5z+lGs5?=
 =?us-ascii?Q?57JXgu4s8km8SkNZrbfpWs+9hs5yxW7RyVwYmO0O3S72hz9o7poI2CX8OttO?=
 =?us-ascii?Q?kt4mx1UGex0wdk7K/3ANDHMaFAseaCCnLOEZMpl0pB0NyU8GmxPgb0DTBzMP?=
 =?us-ascii?Q?VnQ81d/2nlIdA8cca4inxAvHOIHeuWkqGEnnRR4+9pn7i+K5VUO29fYU0vXZ?=
 =?us-ascii?Q?mMKVV4MyEqvoS1lY/IYi+egNDFN5CsogoZuRrttlcQHPFh+hCZdhvxCzlKPt?=
 =?us-ascii?Q?ksju23lC6ajqWNwu+w5CCaRy+Eh4GrSHuxZsrYWORff6X3KRdOckzLGjYhdx?=
 =?us-ascii?Q?+4QwrO5ohvbrHnajbQl/ckheYyIe+jpeVt1TaLMh7IkE4G1K09ycKwbHNSf7?=
 =?us-ascii?Q?Y+2IV6n3r+rVwHsaHy8PIqWFtpM2Y/wpghvh6HI3ntfwXDqDVKW5h9yZiDFQ?=
 =?us-ascii?Q?QX8T/Y9Hjr73ob71wuMeMKzLg6vJHibF2KfBZsSANoxuAqOa1E3yaVeLUh9c?=
 =?us-ascii?Q?HxFFwz43xMMzBtY9Pb5w3q4xjC7L1fzEDQBosv7qgLEYK9xFFscifRcLxQ9m?=
 =?us-ascii?Q?wuUze+gPddUxIYtLvl5jMi5VbDqoxJJ74d6r/dp0wE5TCpAp2ORHmRw6Sywm?=
 =?us-ascii?Q?WrRPMcet/xPLts7qZQdslKTbYt9tY02znmwaskXA2rhpV24imkIbYpplJEEC?=
 =?us-ascii?Q?3AzpAGUCtDcZgeGeYUYJH52XZ01GmZkYIDFeqlYIFfvSoYSO+ox7fV9LqB37?=
 =?us-ascii?Q?mVsu5b43sblY2c6MvWzv/f/j6hkRj/+xUBJh9S5MEMZLxL3m2BZQ9+c5EAr7?=
 =?us-ascii?Q?ECtWx3PtQ/oQjOErmdx2lCQPDbLFhV4FAHqZ1SebAwK0o4nVHY8OJgmIO0BS?=
 =?us-ascii?Q?OV1oXLi0Cg=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6e47df7-06b7-45f1-d7bc-08de9dbbaab7
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2026 02:30:48.3279
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jc8myD1MG1w1zDKDVBA+SmmYhJYWTd09UjkTuebukunGn3wIMlRuFXhT8qdUmktWsp0dD3TaXbBByWPlfoJoIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P123MB5960

In high-performance storage environments, particularly when utilising
RAID controllers with shared tag sets (BLK_MQ_F_TAG_HCTX_SHARED), severe
latency spikes can occur when fast devices are starved of available
tags.

This patch introduces two new debugfs attributes for each block
hardware queue:
  - /sys/kernel/debug/block/[device]/hctxN/wait_on_hw_tag
  - /sys/kernel/debug/block/[device]/hctxN/wait_on_sched_tag

These files expose atomic counters that increment each time a submitting
context is forced into an uninterruptible sleep via io_schedule() due to
the complete exhaustion of physical driver tags or software scheduler
tags, respectively.

To ensure negligible performance overhead even in production
environments where CONFIG_BLK_DEBUG_FS is actively enabled, this
tracking logic utilises dynamically allocated per-CPU counters. When
this configuration is disabled, the tracking logic compiles down to a
safe no-op.

Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 block/blk-mq-debugfs.c | 84 ++++++++++++++++++++++++++++++++++++++++++
 block/blk-mq-debugfs.h |  7 ++++
 block/blk-mq-tag.c     |  4 ++
 include/linux/blk-mq.h | 12 ++++++
 4 files changed, 107 insertions(+)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 047ec887456b..a3effed55d90 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -7,6 +7,7 @@
 #include <linux/blkdev.h>
 #include <linux/build_bug.h>
 #include <linux/debugfs.h>
+#include <linux/percpu.h>
 
 #include "blk.h"
 #include "blk-mq.h"
@@ -484,6 +485,54 @@ static int hctx_dispatch_busy_show(void *data, struct seq_file *m)
 	return 0;
 }
 
+/**
+ * hctx_wait_on_hw_tag_show - display hardware tag starvation count
+ * @data: generic pointer to the associated hardware context (hctx)
+ * @m: seq_file pointer for debugfs output formatting
+ *
+ * Prints the cumulative number of times a submitting context was forced
+ * to block due to the exhaustion of physical hardware driver tags.
+ *
+ * Return: 0 on success.
+ */
+static int hctx_wait_on_hw_tag_show(void *data, struct seq_file *m)
+{
+	struct blk_mq_hw_ctx *hctx = data;
+	unsigned long count = 0;
+	int cpu;
+
+	if (hctx->wait_on_hw_tag) {
+		for_each_possible_cpu(cpu)
+			count += *per_cpu_ptr(hctx->wait_on_hw_tag, cpu);
+	}
+	seq_printf(m, "%lu\n", count);
+	return 0;
+}
+
+/**
+ * hctx_wait_on_sched_tag_show - display scheduler tag starvation count
+ * @data: generic pointer to the associated hardware context (hctx)
+ * @m: seq_file pointer for debugfs output formatting
+ *
+ * Prints the cumulative number of times a submitting context was forced
+ * to block due to the exhaustion of software scheduler tags.
+ *
+ * Return: 0 on success.
+ */
+static int hctx_wait_on_sched_tag_show(void *data, struct seq_file *m)
+{
+	struct blk_mq_hw_ctx *hctx = data;
+	unsigned long count = 0;
+	int cpu;
+
+	if (hctx->wait_on_sched_tag) {
+		for_each_possible_cpu(cpu)
+			count += *per_cpu_ptr(hctx->wait_on_sched_tag, cpu);
+	}
+	seq_printf(m, "%lu\n", count);
+	return 0;
+}
+
 #define CTX_RQ_SEQ_OPS(name, type)					\
 static void *ctx_##name##_rq_list_start(struct seq_file *m, loff_t *pos) \
 	__acquires(&ctx->lock)						\
@@ -599,6 +648,8 @@ static const struct blk_mq_debugfs_attr blk_mq_debugfs_hctx_attrs[] = {
 	{"active", 0400, hctx_active_show},
 	{"dispatch_busy", 0400, hctx_dispatch_busy_show},
 	{"type", 0400, hctx_type_show},
+	{"wait_on_hw_tag", 0400, hctx_wait_on_hw_tag_show},
+	{"wait_on_sched_tag", 0400, hctx_wait_on_sched_tag_show},
 	{},
 };
 
@@ -670,6 +721,11 @@ void blk_mq_debugfs_register_hctx(struct request_queue *q,
 	snprintf(name, sizeof(name), "hctx%u", hctx->queue_num);
 	hctx->debugfs_dir = debugfs_create_dir(name, q->debugfs_dir);
 
+	if (!hctx->wait_on_hw_tag)
+		hctx->wait_on_hw_tag = alloc_percpu(unsigned long);
+	if (!hctx->wait_on_sched_tag)
+		hctx->wait_on_sched_tag = alloc_percpu(unsigned long);
+
 	debugfs_create_files(q, hctx->debugfs_dir, hctx,
 			     blk_mq_debugfs_hctx_attrs);
 
@@ -684,6 +740,11 @@ void blk_mq_debugfs_unregister_hctx(struct blk_mq_hw_ctx *hctx)
 	debugfs_remove_recursive(hctx->debugfs_dir);
 	hctx->sched_debugfs_dir = NULL;
 	hctx->debugfs_dir = NULL;
+
+	free_percpu(hctx->wait_on_hw_tag);
+	hctx->wait_on_hw_tag = NULL;
+	free_percpu(hctx->wait_on_sched_tag);
+	hctx->wait_on_sched_tag = NULL;
 }
 
 void blk_mq_debugfs_register_hctxs(struct request_queue *q)
@@ -815,3 +876,26 @@ void blk_mq_debugfs_unregister_sched_hctx(struct blk_mq_hw_ctx *hctx)
 	debugfs_remove_recursive(hctx->sched_debugfs_dir);
 	hctx->sched_debugfs_dir = NULL;
 }
+
+/**
+ * blk_mq_debugfs_inc_wait_tags - increment the tag starvation counters
+ * @hctx: hardware context associated with the tag allocation
+ * @is_sched: true if the starved pool is the software scheduler
+ *
+ * Evaluates the exhausted tag pool and safely increments the appropriate
+ * per-cpu debugfs starvation counter.
+ *
+ * Note: A race window exists during rapid device probe or CPU hotplug
+ * where I/O might be submitted before blk_mq_debugfs_register_hctx() has
+ * completed allocating the per-CPU counters. Therefore, the pointer is
+ * explicitly checked to prevent a NULL pointer dereference.
+ */
+void blk_mq_debugfs_inc_wait_tags(struct blk_mq_hw_ctx *hctx,
+				  bool is_sched)
+{
+	unsigned long __percpu *tags = is_sched ? hctx->wait_on_sched_tag :
+						  hctx->wait_on_hw_tag;
+
+	if (likely(tags))
+		this_cpu_inc(*tags);
+}
diff --git a/block/blk-mq-debugfs.h b/block/blk-mq-debugfs.h
index 49bb1aaa83dc..a0094d004d08 100644
--- a/block/blk-mq-debugfs.h
+++ b/block/blk-mq-debugfs.h
@@ -17,6 +17,8 @@ struct blk_mq_debugfs_attr {
 	const struct seq_operations *seq_ops;
 };
 
+void blk_mq_debugfs_inc_wait_tags(struct blk_mq_hw_ctx *hctx,
+				  bool is_sched);
 int __blk_mq_debugfs_rq_show(struct seq_file *m, struct request *rq);
 int blk_mq_debugfs_rq_show(struct seq_file *m, void *v);
 
@@ -35,6 +37,11 @@ void blk_mq_debugfs_unregister_sched_hctx(struct blk_mq_hw_ctx *hctx);
 
 void blk_mq_debugfs_register_rq_qos(struct request_queue *q);
 #else
+static inline void blk_mq_debugfs_inc_wait_tags(struct blk_mq_hw_ctx *hctx,
+						bool is_sched)
+{
+}
+
 static inline void blk_mq_debugfs_register(struct request_queue *q)
 {
 }
diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 66138dd043d4..3cc6a97a87a0 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -17,6 +17,7 @@
 #include "blk.h"
 #include "blk-mq.h"
 #include "blk-mq-sched.h"
+#include "blk-mq-debugfs.h"
 
 /*
  * Recalculate wakeup batch when tag is shared by hctx.
@@ -191,6 +192,9 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
 		trace_block_rq_tag_wait(data->q, data->hctx,
 					data->rq_flags & RQF_SCHED_TAGS);
 
+		blk_mq_debugfs_inc_wait_tags(data->hctx,
+					     data->rq_flags & RQF_SCHED_TAGS);
+
 		bt_prev = bt;
 		io_schedule();
 
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index ebc45557aee8..17cd6221bb93 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -453,6 +453,18 @@ struct blk_mq_hw_ctx {
 	struct dentry		*debugfs_dir;
 	/** @sched_debugfs_dir:	debugfs directory for the scheduler. */
 	struct dentry		*sched_debugfs_dir;
+	/**
+	 * @wait_on_hw_tag: Cumulative per-cpu counter incremented each
+	 * time a submitting context is forced to block due to physical
+	 * hardware tag exhaustion.
+	 */
+	unsigned long __percpu	*wait_on_hw_tag;
+	/**
+	 * @wait_on_sched_tag: Cumulative per-cpu counter incremented each
+	 * time a submitting context is forced to block due to software
+	 * scheduler tag exhaustion.
+	 */
+	unsigned long __percpu	*wait_on_sched_tag;
 #endif
 
 	/**
-- 
2.51.0

