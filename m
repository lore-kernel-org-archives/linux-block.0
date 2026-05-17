Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020075.outbound.protection.outlook.com [52.101.196.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F64B31A045;
	Sun, 17 May 2026 21:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779053788; cv=fail; b=qS9TQItY7+6Zc/PrA904JOq0/8EFhJjIQR4ASmxZYJVYvKHkVfPqD8R5hbrDamvhI9XHMyqfQOagSQOXBS6F1NFiLcd2qx3Uw2gO/nl3I6hLxK0dZxWh6ffEg+3+teM8cvdt1o4O6+nsPGsTsmmGDWmGOU+Kp3MOgeP97nZMxco=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779053788; c=relaxed/simple;
	bh=h3gjWoG/gi06w0AKXIvFHSqAy4tWW+j6pxrp0bSp9ic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gBMTDBs8bCkv184FvASmEmxyrkN8Ih1eTMNWpw1M0A9B0Evsc7adYDoKddBjwMC6s+QLsQdMZFFbXZg15ou4CIfug18pQcpJ50FyQlpb0VrcQ1TvtsVteCnSWJSuL6m5vKmoZBMWKqAl6FXJa7ZAnZR9Ur1i9ZbfOQzkrqEc8ek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.196.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jObsI0/SXhNHnMux7v8jvq3Xd86yGdrPrbrXY8Y/0m8gXUSorMJol/GJjs/529TUSDXViccFbrk3VdkMexYRBvi93xPqJVQhIOdO8a+4NYx8ClDCzNDs/Nn5uJEaHWZzHSzHiQfPpCmvf4v1jQP8WwTFdORnQ48U5b1Vk33kbgvnxPrZ5/djSstAWVuS5JxMnPCrmb/2NhxbAbuwDpHkbkuxLKIwrU/MYU93yixY4qJrQHjHv7Me+Nc0uwmmjHjUGbo3QRfzSlSQB1P3MK5eaSICyLrORuAN6KzE8I93rG5diDF6qRfis61gRn3yvNdoDcxkb2dlBt/BLCAuOxD6cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lNM+2Q4HH/9x3x6JMDqzl3ODmKtEWVaGamWmTHccP8E=;
 b=Gno7WEBYLzz6OG5DAZ6ttQ/WDhibZixHjmY7ypRzJKCMzJKgFYxDP4SZcywmgk0kMCCLppjcMw3WFr1CDTTSMBbaFeHTucu5gt0KCn6mhTg3aiiL2XuC99T3ngbZMDaSIN97temP9DZHZx1w/Yft3bCKkFXzeW22XU2r884Ud0jCJ8Y2KG6TExTX5MvVxwLUa3YjIbEhmWrPyAdT8RUG/Obphjn7teCKAR4A0ecxcuVrmAdubBuGnWPo1TCAktHCHRliBdJtj3Ze6/oN1Kie86rCZbTZmfy+4Jsoe+6off5uNtGHV/Y1+2zyAXWv96fbAELlQR+YT50QUzFW7OZqwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by CWLP123MB7236.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:1f7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Sun, 17 May
 2026 21:36:24 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%2]) with mapi id 15.20.9846.025; Sun, 17 May 2026
 21:36:24 +0000
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
Subject: [PATCH v6 2/2] blk-mq: expose tag starvation counts via debugfs
Date: Sun, 17 May 2026 17:36:14 -0400
Message-ID: <20260517213614.350367-3-atomlin@atomlin.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260517213614.350367-1-atomlin@atomlin.com>
References: <20260517213614.350367-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN1PR13CA0011.namprd13.prod.outlook.com
 (2603:10b6:408:e2::16) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|CWLP123MB7236:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e63d930-a823-42ae-1636-08deb45c580a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|3023799003|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	nU5aQ57usDFWz8XU3vjogNV7IOBna7dcutiS4KJHhsGTlML6Lg3WNQHxLz39kJjxKzsqQ2bS4BsSWkf85h/k6eiFxkHsZoYviih1izF22CgrA8xfVVVVzO/VhkXVbacozGNG6F8plb/YxQwUfj/Kt6HivDJlrzkE1U28COeH1D+iyptWQJ1c3DkvqdzaIaVNCxX7+Dv4Of9RGnqeOPLeQ84dCBr12ldWRGhe6RA9+c58SekPeWI5hpi4eL4i/X5xqqGrGFuo+x2/2FaU3t8MTq9w4UYaEPHifHf00w7HK/hvO/kxM+RFcpHQw1sdxLqy9DuV/kI1H5B5xecSQXCDhRRr4oUDWmcaU8V2CAewH3t442pPP/h5Zl1qBsTZRHg3S++OD1f8d30ynrKQ8rWJ5W02YSCo6A5GK9A8OkucBrg2ehtLjR9zGud/CKIWT1fz3xp3WxEO7YF7jPe632KB2ZGVwH0zsxebEafVgpH3wibOLFPK5hx3/vjW/U2hxDpoBTzhAou682ewrXMZmwnZeGPXax9q6spbzVT0o3yAM+QNLti0LmoA/Pi5nkS4skHTt5D6y870V/JgkvHAop/0aOTEhxsb35lKtEPIghiQBdh5e5SC/Nt8x7mRC6o4oh3ChGoDi4oOXFscsNXXw3SylLdrgxRjCCklS0SJICthvN7oVRxxnm3VOTlvFYSWEund
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(3023799003)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1iknUuSBRXfVMcY+ksGkANR8ex/eqoekWx0W+Tjp/wFNI6Qe9dTIbl4SAVct?=
 =?us-ascii?Q?7u7p2qlCbO2QCE0utjwbWF8R8sacSHzwJfPAlVV27DfGU+fyTPCfLRncDzT2?=
 =?us-ascii?Q?d3kjKHLjFA2FASkbeufq+QiuyJtqsIyFCfBX19S30/qjJtmSuv0/+cmWGE2S?=
 =?us-ascii?Q?nx21Vz0SdaZQjC1Z2FIOXHOHPXvyi4EMF02AKKbVWhDgOLjEwM+wvs//SX8x?=
 =?us-ascii?Q?sibqK9zU7xA6JZ6Ss3tpfO2OPLC1me4aGzTewnZCN68Sijz3gg0FfU9t4jZu?=
 =?us-ascii?Q?GlY2mhoHDDx4Xtlq9Wm2U0vQTMwaB/9sn5XQlfDnajBvRJyQjEzTvfCmrVFZ?=
 =?us-ascii?Q?1QVygzlzBruCG/1hoq7/U7+Bp3Z7tpd+OLVnBKYAWwDJFmO6H6zVvGwpTtus?=
 =?us-ascii?Q?LkwQsSBRrPT9c7e9O6MVLqKh9t9GnW2zRFGx32aeqibWyfq1KCu8F4FyjEjA?=
 =?us-ascii?Q?5O3MiXPhwLHM2ij4/FGOKUsRwnobnX11hihQ/1pt+tmzw9BfYap6DynigkyM?=
 =?us-ascii?Q?l5bznusk/4dnTLJrkobDiNtyVz+9acMzW96hzsu8Gskj1Bintl4oOkdZU+c8?=
 =?us-ascii?Q?btO2/2MLhMR7qZmXS9nrOTX/UV4LtUuTKjsdFPjR+gg/7JyS/T8kNJvlUutb?=
 =?us-ascii?Q?fxCHTujPXNcFVZpp4/nnGXBWzKKlFpS1zUD/aqBqJmzwOKMbJjlNTt+4UNQK?=
 =?us-ascii?Q?6IvEXf9eyRiglVoLISONvX7+jgmdt6v8hq3JQZEqiK8vpeqe69hkQ3+isNmI?=
 =?us-ascii?Q?ZhNCwOaTcQVkH6xhcsMigpLOZ8BmpHXbxvx4cYEnsH+UXRJOPmj0/Kp5GUFt?=
 =?us-ascii?Q?WWsQT1XHapB0qm66ihb5NRFXfCXn6HkM9xS63e2Fr7vgFCsQqsASGb5kJvS7?=
 =?us-ascii?Q?cWeVQm7NTIPtWo4C+cb4Z6YEE0GeumamooFWDUyf9ojD8gKNRbcGP654e5XR?=
 =?us-ascii?Q?Ola/CrS40b4l8+14qqtbonGmE5KJyOajqbPA0AUONMSX3Wo1r18s1xIfjkBg?=
 =?us-ascii?Q?KNazjN6BEeECuV/o2l7hAV5NmUy5A1duwPYcITK4mNx1QxQzFeYEzNkgXRHC?=
 =?us-ascii?Q?WUO+q2B7w7kbVqcVt1pPoZhzRL7ElzxrDWLLkeWl2cCSokFUKLP4yZLEgvMD?=
 =?us-ascii?Q?GKBqXayAhba96x3+sGATsoZdKBrhNw/Lfazidq6YuSeeVZ1Umy+WXXfOHEjF?=
 =?us-ascii?Q?1li9S0SPPyf44BrKje47XVFLrCIfguljKZxsAxCkiPX7s6Boh9Zabm9LM0qq?=
 =?us-ascii?Q?3sE4oEOt4pgXI/KiXQC7Eorqs6of0Lo66QHu/1qnWKINsPyTZzksF3U0zDhr?=
 =?us-ascii?Q?3aZkCNNuH5IvsXWxmvp1HEqkfG+0CRd4hrQEI0ZHnXULsKxR3Amq+GfKXFiy?=
 =?us-ascii?Q?A7gUpLBFlSEa/OnTNGhqn98GqC/YhwyKppyh5U9h805htHA5xv4ZrDZxOgOJ?=
 =?us-ascii?Q?6n0eY6GBSwaTiJmYUOE5CbjMeqE0IQRfPIhLQZv3x2XiYwFvSXYl+1N1+miS?=
 =?us-ascii?Q?vXHLkbLEhue+ZKvD1UpALJ+YeS6AsvwkCIXBkxQECsA6u1uPuDxqDPc5NuEG?=
 =?us-ascii?Q?3YWXh2F8pGLEZJPCaP3cci5I8K3qmNQgyKZNVDq8XLJoJlOHAjLpDy0TUimK?=
 =?us-ascii?Q?jnTodjl7UMWSYsjVeO4CT93x00ZmkvH5Gyec8FYJa6OmCRzgn5dDvUI/iyTy?=
 =?us-ascii?Q?EoksfrMgumqyuIDVPCiT198j0H2ry7+uQT01U0zP3zpzr66FzaLFmpXbmQUd?=
 =?us-ascii?Q?TyZy0aQovQ=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e63d930-a823-42ae-1636-08deb45c580a
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2026 21:36:24.1375
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hYiUJjAa0mM+kqPfelqZcuj52NtKgTI2VyzP1rGEpHPS4CaSufC0fjTs0SejLAbwOf6zUAmwvBs+wzEP5h3dZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP123MB7236

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
 block/blk-mq-debugfs.c | 109 +++++++++++++++++++++++++++++++++++++++++
 block/blk-mq-debugfs.h |  19 +++++++
 block/blk-mq-tag.c     |   4 ++
 block/blk-mq.c         |   5 ++
 include/linux/blk-mq.h |  12 +++++
 5 files changed, 149 insertions(+)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 047ec887456b..a94ffc2eacdf 100644
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
 
@@ -815,3 +866,61 @@ void blk_mq_debugfs_unregister_sched_hctx(struct blk_mq_hw_ctx *hctx)
 	debugfs_remove_recursive(hctx->sched_debugfs_dir);
 	hctx->sched_debugfs_dir = NULL;
 }
+
+/**
+ * blk_mq_debugfs_alloc_hctx_stats - Allocate per-cpu starvation statistics
+ * @hctx: hardware context associated with the tag allocation
+ * @gfp: memory allocation flags
+ *
+ * Allocates the per-cpu memory for tracking hardware and scheduler tag
+ * starvation.
+ */
+void blk_mq_debugfs_alloc_hctx_stats(struct blk_mq_hw_ctx *hctx, gfp_t gfp)
+{
+	if (!hctx->wait_on_hw_tag)
+		hctx->wait_on_hw_tag = alloc_percpu_gfp(unsigned long,
+							gfp);
+	if (!hctx->wait_on_sched_tag)
+		hctx->wait_on_sched_tag = alloc_percpu_gfp(unsigned long,
+							   gfp);
+}
+
+/**
+ * blk_mq_debugfs_free_hctx_stats - Free per-cpu starvation statistics
+ * @hctx: hardware context associated with the tag allocation
+ *
+ * Frees the per-cpu memory used for tracking hardware and scheduler tag
+ * starvation. This must only be called during hardware queue teardown when
+ * the queue is safely frozen and no active I/O submissions can race to
+ * increment the statistics.
+ */
+void blk_mq_debugfs_free_hctx_stats(struct blk_mq_hw_ctx *hctx)
+{
+	free_percpu(hctx->wait_on_hw_tag);
+	hctx->wait_on_hw_tag = NULL;
+	free_percpu(hctx->wait_on_sched_tag);
+	hctx->wait_on_sched_tag = NULL;
+}
+
+/**
+ * blk_mq_debugfs_inc_wait_tags - increment the tag starvation counters
+ * @hctx: hardware context associated with the tag allocation
+ * @is_sched: true if the starved pool is the software scheduler
+ *
+ * Evaluates the exhausted tag pool and safely increments the appropriate
+ * per-cpu debugfs starvation counter.
+ *
+ * Note: The per-cpu pointers are explicitly checked to prevent a NULL
+ * pointer dereference in the event that the system was under heavy memory
+ * pressure and the initial per-cpu allocation failed.
+ */
+void blk_mq_debugfs_inc_wait_tags(struct blk_mq_hw_ctx *hctx,
+				  bool is_sched)
+{
+	unsigned long __percpu *tags = is_sched ?
+			READ_ONCE(hctx->wait_on_sched_tag) :
+			READ_ONCE(hctx->wait_on_hw_tag);
+
+	if (likely(tags))
+		raw_cpu_inc(*tags);
+}
diff --git a/block/blk-mq-debugfs.h b/block/blk-mq-debugfs.h
index 49bb1aaa83dc..7a7c0f376a2b 100644
--- a/block/blk-mq-debugfs.h
+++ b/block/blk-mq-debugfs.h
@@ -17,6 +17,8 @@ struct blk_mq_debugfs_attr {
 	const struct seq_operations *seq_ops;
 };
 
+void blk_mq_debugfs_inc_wait_tags(struct blk_mq_hw_ctx *hctx,
+				  bool is_sched);
 int __blk_mq_debugfs_rq_show(struct seq_file *m, struct request *rq);
 int blk_mq_debugfs_rq_show(struct seq_file *m, void *v);
 
@@ -26,6 +28,9 @@ void blk_mq_debugfs_register_hctx(struct request_queue *q,
 void blk_mq_debugfs_unregister_hctx(struct blk_mq_hw_ctx *hctx);
 void blk_mq_debugfs_register_hctxs(struct request_queue *q);
 void blk_mq_debugfs_unregister_hctxs(struct request_queue *q);
+void blk_mq_debugfs_alloc_hctx_stats(struct blk_mq_hw_ctx *hctx,
+				     gfp_t gfp);
+void blk_mq_debugfs_free_hctx_stats(struct blk_mq_hw_ctx *hctx);
 
 void blk_mq_debugfs_register_sched(struct request_queue *q);
 void blk_mq_debugfs_unregister_sched(struct request_queue *q);
@@ -35,6 +40,11 @@ void blk_mq_debugfs_unregister_sched_hctx(struct blk_mq_hw_ctx *hctx);
 
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
@@ -56,6 +66,15 @@ static inline void blk_mq_debugfs_unregister_hctxs(struct request_queue *q)
 {
 }
 
+static inline void blk_mq_debugfs_alloc_hctx_stats(struct blk_mq_hw_ctx *hctx,
+						   gfp_t gfp)
+{
+}
+
+static inline void blk_mq_debugfs_free_hctx_stats(struct blk_mq_hw_ctx *hctx)
+{
+}
+
 static inline void blk_mq_debugfs_register_sched(struct request_queue *q)
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
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 4c5c16cce4f8..cd52bf6f82ce 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3991,6 +3991,8 @@ static void blk_mq_exit_hctx(struct request_queue *q,
 			blk_free_flush_queue_callback);
 	hctx->fq = NULL;
 
+	blk_mq_debugfs_free_hctx_stats(hctx);
+
 	spin_lock(&q->unused_hctx_lock);
 	list_add(&hctx->hctx_list, &q->unused_hctx_list);
 	spin_unlock(&q->unused_hctx_lock);
@@ -4016,6 +4018,8 @@ static int blk_mq_init_hctx(struct request_queue *q,
 {
 	gfp_t gfp = GFP_NOIO | __GFP_NOWARN | __GFP_NORETRY;
 
+	blk_mq_debugfs_alloc_hctx_stats(hctx, gfp);
+
 	hctx->fq = blk_alloc_flush_queue(hctx->numa_node, set->cmd_size, gfp);
 	if (!hctx->fq)
 		goto fail;
@@ -4041,6 +4045,7 @@ static int blk_mq_init_hctx(struct request_queue *q,
 	blk_free_flush_queue(hctx->fq);
 	hctx->fq = NULL;
  fail:
+	blk_mq_debugfs_free_hctx_stats(hctx);
 	return -1;
 }
 
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 18a2388ba581..41d61488d683 100644
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

