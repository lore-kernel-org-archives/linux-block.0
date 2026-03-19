Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022108.outbound.protection.outlook.com [52.101.101.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3CF3815E9;
	Thu, 19 Mar 2026 01:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773885194; cv=fail; b=hCUmdAG/HLdMb80bWopXG9ToRh/80kA7CCfw4QRg8/CFGaqtKN6XR6jUouPSLLFAawlqqLEmmKSI3u14oCEcfm4XqzDH3nVzyibX96doDnvCpLIXYLmbidl3MrgSOoq340mjpimxoa8+BcUSIQRzue+3B9ByqcIqNQnH9XRX3b8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773885194; c=relaxed/simple;
	bh=9ej5lJ4eR60x37ZYQlsPveUwKhC1QfxVxQGpAhtSq9c=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=lajJGcwmfPkefPnlUOwhIu5g0skD49rAqf57HEiJ364AAmZbnyxJHDNmSE/m/wrHRJnaXNVyaksXM3Dl6WTmrTDOBDa0jMnI5GQU8FVP/gpkedfc2edZHTaTp6Z5z5948aimnSmW3KWNPAbfLd31PNFG1mp5sNQ6qPU1xtnjTRs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.101.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DBxkCDAS/lUooDoTia5WJBjxoGmFaSan8PiT9olSRblHHmuImOzQWSD+kgVT9pRVIbCcLCTcicap3C5V0NtECsJtnTjJ6CFOl9bHe55z5LrV0eCNnGVk9IDOXDodKVN+Gc9sdk1JZ1tD8fJGodKoz5l88Pw+HxAxx53jurbhEoFXX7rcUNibQ/Um/sRbA862okQG8Vz72huo3yn08LoPXyGQhsmLTo5AGr4ewrF3MvgVdyZapSLSahB4v/V2LXEiknubTCMK6m6MrBkGzAPBKiCh24P8ginh2JU9KtyEcyDjQ6pZy3l2BjYUDfFHyLXgKLPxGM+VnH4W90EF61aLoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ryvryFOXtGAPyzXNRB7LYL+BDp60S2r5/2bk2Z4krf0=;
 b=eWpJpnJFvY5B6NZVPcIfPa2vqi8qzUGom1rqeegwvMwGX2mMUaY/lfpKehQwCKoboAuMCxL73GfZORo5W+C7saPaGo4J6f+ZFwHcTxPyp58i/Z2en5HjQUo+YWjfEqcCT0P4bKpLc7+Q80gXEC+t+uYtYU3fmTOTOYEvM9GwsBMjxa7gg8rrIjVwCwZL9sk39LkU5BrIJRVIrWnwrXssvFOcp7/UpMcTGoM945veD2ieajwtfGzQQWvHFi6e4fp7mhY220P4MuGuALULTTd12uSl27MvBQSq8a5zfdd04AmCuwLHYGjBiMQVD3UzlKJiFKbmZgalE2pd38qsBRo1KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by LOBP123MB8372.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:43e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 19 Mar
 2026 01:52:57 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%2]) with mapi id 15.20.9723.018; Thu, 19 Mar 2026
 01:53:04 +0000
From: Aaron Tomlin <atomlin@atomlin.com>
To: axboe@kernel.dk,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com
Cc: johannes.thumshirn@wdc.com,
	kch@nvidia.com,
	bvanassche@acm.org,
	dlemoal@kernel.org,
	ritesh.list@gmail.com,
	neelx@suse.com,
	sean@ashe.io,
	mproche@gmail.com,
	chjohnst@gmail.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2] blk-mq: add tracepoint block_rq_tag_wait
Date: Wed, 18 Mar 2026 21:53:00 -0400
Message-ID: <20260319015300.287653-1-atomlin@atomlin.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0673.namprd03.prod.outlook.com
 (2603:10b6:408:10e::18) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|LOBP123MB8372:EE_
X-MS-Office365-Filtering-Correlation-Id: 48dc688f-592f-40ed-e3c7-08de855a4243
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|1800799024|376014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	7l/tsGu8xLSOSQWY635HM6b+HmibPyqe1LuZ2aKZJNvUtuSrZApVlpgchiMkCtXRz62Zhw6thfVS1cxKEVNx2rkWJaoulCIjnn1AcsEjrmc4tbVrf1yD0ywsoMOAPY7QIDtjs76eOa1+cMO1rmy7xuq6se6k8m2r5n9gLpUV0bzA6DyaHl9yV1+IwRMzw9y/7mqt5lxvJKfBhCh+AQvU7B8av111+Fk0rlft3Yd0BUbwucWN8iP7oQUdi0HPYURysagfqvfFFFWFxiNKayWCuSDVxvI7F4SBs8Z2VhcMXmDhZV9aqR2nZzL/aB64Ou6ZtNqv+nJiaZO69Acdojij2rQc5s3ZAb7TNiYysM8PbpIEBgWDu4WgmqGKN0igZfM5hqjYq2YBVmHxzaA9Ehx+Eijx4/78FfYo0RcrNC1NZCZwqMnY1vUgWbRAlI7u7RiqBCfZkB15G/bYAzeV7loBtnNz8SzAtJhLEmXEImXE6O/s+TbthJ3EMfv4KkEASgY81iBFxVRmA1KavKLWKRjeCzjFRFS08CyTGRhCqHFvbT890PFyo210J1AvlouOFmqfVYvw23yWORelZcMHD39A5w3W1fjn06N6TuDk5mWWTfigVbgKj8Gq6NeNYBNlGKPqwN6et+VrTEAEHu7cTSfEpatgvEauAX2JuLAoN1gyxPCmQfqEn4Eqdj+/z2rtd4Gu1YGhds/0HGfU+IpEWHquyLfHO24LO4YKdehbBwxrOtI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(56012099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qIOHAeFB37sEPiTKScLaBGo85hgMdsu7tYJEXEKZ4vTjrbCkRzBbHaVVCgzK?=
 =?us-ascii?Q?mqzn0Nd4jeXkTSXYVbIeTJ8vCHIgHUYVKRpdIpsUAVruR1c/2WuM88q0F0Ta?=
 =?us-ascii?Q?vXUOLXpuq1YK1qZfR7TeRsxGC+zr0X2LfbkxZ2crxIzHEGyDXqodF0vMllTs?=
 =?us-ascii?Q?QlZaHKgFy2k4z2Dvjzk69bsRynCbudObJgWgFuT6f/384ghrZg65WwnV0wvv?=
 =?us-ascii?Q?KIkchNZ0zYRFsnB4axX5gsJvYLLsOg4qLrqfXnS8nBxOyCO4lmBKyuvX5ezj?=
 =?us-ascii?Q?oXKchLovspRDQ61hrIJLEQfFjyNDW8L+VUwuI93TNkl7EK++bjsSy5GTrKtM?=
 =?us-ascii?Q?CIZJyiZxasKmTHOVP9Re8cYPU3bfLsfvI1oKHa4D/061erD9HSWwiGhXxvxD?=
 =?us-ascii?Q?0p+TaEDGD9LittGGpuqFWlVmdpqjcuYVo4pRRrUYeNtLqtZJEEADgBMg84l/?=
 =?us-ascii?Q?3/ymrYfAEiWw/1XzJMh/eEps1ixHCgZgi1G018IeCl51QjgL6GfGNESCiGQF?=
 =?us-ascii?Q?nFXAsLtG2ZrtRX/0ZcC/k0yxkZ0e4lvQ7NgAriKUPgYhN87X2pzfRFBcArGK?=
 =?us-ascii?Q?1+sK7DUuYL6ZBlA0oZXnmIvrQEYnVKWtpiNt0adGy1s9+0+kYP3ikDt8TQpT?=
 =?us-ascii?Q?LOAMyoSovOj8gYd48kwjGi8yEzCvbP2Bfy74nDxsNukV+AWQ5T4jO5o1ZzMs?=
 =?us-ascii?Q?Tk6a0S1jGmZbyq2oQPc+TdJ0sd8VjZi2q5KUQf5S5PruUzgf2pMcYsRHuq9R?=
 =?us-ascii?Q?GeWN07Gikxt3PgxbCCr3RCzWSf3wvijMWqIBX+tzpHuyhyr8x/2p/OxRdzVn?=
 =?us-ascii?Q?kmYYRLk+nSuIuRZN198uLHgkz01/u5jdufkPv8FiLXsvW5RVQE2XWgDHiHhD?=
 =?us-ascii?Q?EjGS1TiyggZoiWGnw3oI/UnV22yNZpMOnBDNr3486X+yZeM2fkaVs5deM10m?=
 =?us-ascii?Q?IDLq7CCoTpN4ajEFtF97/cWdXQ/rXyZqZFxFUGSyRrU80za8X4JIzQy6ubsW?=
 =?us-ascii?Q?15qZc/nvEJvjThjsi0WqrZWG3+gfvT8tApgs0zHpC961tCD34f/VIe8XxqI4?=
 =?us-ascii?Q?Fy7pSCdJiu73w8rsLGElNE80eOKd82pPEhYLMWelIZ4TEdGYAPSAtJbj6xrr?=
 =?us-ascii?Q?9Pdnbfl7fhdSPNZItBi7iUTXF3zpCwn3RpijCoOuIqn5MfAs3ZZkr9h3lA1O?=
 =?us-ascii?Q?LhhXklmIEUwA7SXKLXOPTouiMO0hDvM6PD+JaDZDuxCtxBQg44ZhgZh9l5F7?=
 =?us-ascii?Q?jrmnEPyCiwaJGnTZhghnmcuolXxQTAyLZWeBc50zQ8vkppBzNMIrZ/u/rhge?=
 =?us-ascii?Q?MK2TdzDv4LGqcf6FFwjkQRF10AKlHq7hnXLZuqatsSm+1CRlmcaod35E7eh/?=
 =?us-ascii?Q?lWZYaQEgV6t2iwOuwYo/sFCEJtE5syaJPKn61ZpKIDPVZYRyGM1Fp8UuZiEl?=
 =?us-ascii?Q?zLzZfxvWXxklgFuTH0AZ7ARkF80ZqaDUnlX1IWXkwlf5fYcLLE8J5Opjoz59?=
 =?us-ascii?Q?E4nWS65Pk3S5BOdbOm72FMY6ZEbFiSxZSyuaamNaXOOgyfBpiJ5ppAjUru4r?=
 =?us-ascii?Q?We7lYBQkwknZ188YfYigcOqVudeghFKEnyr985yq8r7PZtRwUV5Ww97p5OG1?=
 =?us-ascii?Q?0+YnFJNRWx3O3gECfVVJu2nEeynTepxHwkwfyqdZ5ZAcnXLohJdwJJDRTSd6?=
 =?us-ascii?Q?GtC2rmK8IYvumkJ1tf7AV4u0QXwxp9JBNNOSWkMeTR8HjIjDCTHXopyHWZQH?=
 =?us-ascii?Q?nMGbnOWBPg=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48dc688f-592f-40ed-e3c7-08de855a4243
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 01:53:04.0336
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MQ+Syrc6+wefrB2eticIbEVPXItzMRk/5lOFemTmsVaeSJwEcpU90Lylo5VFWA+GpFhOP1wOhGEwZf65Bk+O/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOBP123MB8372

In high-performance storage environments, particularly when utilising
RAID controllers with shared tag sets (BLK_MQ_F_TAG_HCTX_SHARED), severe
latency spikes can occur when fast devices (SSDs) are starved of hardware
tags when sharing the same blk_mq_tag_set.

Currently, diagnosing this specific hardware queue contention is
difficult. When a CPU thread exhausts the tag pool, blk_mq_get_tag()
forces the current thread to block uninterruptible via io_schedule().
While this can be inferred via sched:sched_switch or dynamically
traced by attaching a kprobe to blk_mq_mark_tag_wait(), there is no
dedicated, out-of-the-box observability for this event.

This patch introduces the block_rq_tag_wait static trace point in the
tag allocation slow-path. It triggers immediately before the thread
yields the CPU, exposing the exact hardware context (hctx) that is
starved, the specific pool experiencing starvation (hardware or software
scheduler), and the total pool depth.

This provides storage engineers and performance monitoring agents
with a zero-configuration, low-overhead mechanism to definitively
identify shared-tag bottlenecks and tune I/O schedulers or cgroup
throttling accordingly.

Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
Changes in v1 [1]:
 - Improved the description of the trace point (Damien Le Moal)
 - Removed the redundant "active requests" (Laurence Oberman)
 - Introduced pool-specific starvation tracking

[1]: https://lore.kernel.org/lkml/20260317182835.258183-1-atomlin@atomlin.com/

 block/blk-mq-tag.c           |  4 ++++
 include/trace/events/block.h | 43 ++++++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 33946cdb5716..a6691a4fe7a7 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -13,6 +13,7 @@
 #include <linux/kmemleak.h>
 
 #include <linux/delay.h>
+#include <trace/events/block.h>
 #include "blk.h"
 #include "blk-mq.h"
 #include "blk-mq-sched.h"
@@ -187,6 +188,9 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
 		if (tag != BLK_MQ_NO_TAG)
 			break;
 
+		trace_block_rq_tag_wait(data->q, data->hctx,
+					!!(data->rq_flags & RQF_SCHED_TAGS));
+
 		bt_prev = bt;
 		io_schedule();
 
diff --git a/include/trace/events/block.h b/include/trace/events/block.h
index 6aa79e2d799c..f7708d0d7a0c 100644
--- a/include/trace/events/block.h
+++ b/include/trace/events/block.h
@@ -226,6 +226,49 @@ DECLARE_EVENT_CLASS(block_rq,
 		  IOPRIO_PRIO_LEVEL(__entry->ioprio), __entry->comm)
 );
 
+/**
+ * block_rq_tag_wait - triggered when a request is starved of a tag
+ * @q: request queue of the target device
+ * @hctx: hardware context of the request experiencing starvation
+ * @is_sched_tag: indicates whether the starved pool is the software scheduler
+ *
+ * Called immediately before the submitting context is forced to block due
+ * to the exhaustion of available tags (i.e., physical hardware driver tags
+ * or software scheduler tags). This trace point indicates that the context
+ * will be placed into an uninterruptible state via io_schedule() until an
+ * active request completes and relinquishes its assigned tag.
+ */
+TRACE_EVENT(block_rq_tag_wait,
+
+	TP_PROTO(struct request_queue *q, struct blk_mq_hw_ctx *hctx, bool is_sched_tag),
+
+	TP_ARGS(q, hctx, is_sched_tag),
+
+	TP_STRUCT__entry(
+		__field( dev_t,		dev			)
+		__field( u32,		hctx_id			)
+		__field( u32,		nr_tags			)
+		__field( bool,		is_sched_tag		)
+	),
+
+	TP_fast_assign(
+		__entry->dev		= disk_devt(q->disk);
+		__entry->hctx_id	= hctx->queue_num;
+		__entry->is_sched_tag	= is_sched_tag;
+
+		if (__entry->is_sched_tag)
+			__entry->nr_tags = hctx->sched_tags->nr_tags;
+		else
+			__entry->nr_tags = hctx->tags->nr_tags;
+	),
+
+	TP_printk("%d,%d hctx=%u starved on %s tags (depth=%u)",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		  __entry->hctx_id,
+		  __entry->is_sched_tag ? "scheduler" : "hardware",
+		  __entry->nr_tags)
+);
+
 /**
  * block_rq_insert - insert block operation request into queue
  * @rq: block IO operation request
-- 
2.51.0

