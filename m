Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021122.outbound.protection.outlook.com [52.101.100.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C25A26B2D2;
	Mon, 27 Apr 2026 02:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777255313; cv=fail; b=PtXy6QZVulqOfYgX5zNdEPi2GwOohMAjxoQLl7RlbE+3L6DQvojrsNN/+zo95NHgsEqr8W710v1tSbg0k3yZWV8M57NoH+W/3fuBsQEl5Q8OKejLBtcee3Qnu1cpZzv4yqtm2eSlsjM5K5BJFj4CZg+qq9v4+2bSmY0dkE8C3NQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777255313; c=relaxed/simple;
	bh=q2QNYmiNq7H1WeDeP/yIgeKqvZcM1O3ci30quE3+75k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Jo1hKPIkf1LKDk5V86GzuCLKZJPC203fMTe4LmtjTCxiC7ydIXVY6+N0NwNJq/dLoYKVUvYF/jOe2u6o+8edDrbOZk938EQzZ7Xqkrr5W+baCpALnoKToELtV61IhFclOMrj6d7KGyfu8Dy2NV1JQ2ltndXXS+AYymN6UB6eg0o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.100.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F6p+UAKoFl22fYhH0aHlQ4CwTv1HJH1ZyQSHfzPZ6gDshgQeqNyZF1YOcTDb4jPxyPCyM+uS6XtcuxOnkx6MfXT/qglszMeBqkSbWzvKRKw3SIFKF+flpFWfC2oOKhAMTuUpNKWhMNPF1gUUrALWrUuUHInsKs7mHQmLMkNF1lXw4djSMj3t/lIwAao/7NZI/rzJ2hFg/3ofwIodLVII0/XA4K6ftyhqkg1nq3mYiscXWF+Lq1NJvlgqh30Sh3nxxUe6xoBeSUqDJK0lYQh6LOyGFgi9e4zPDocZ35yv/dwaUZWjt8W/8EnCHXk/xkxxZ+mrwHsk/9n993isdWMATg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/c17jx8WR4LN+rAuyoLEfcQvQ2NcKtuM73WbKDI0MOM=;
 b=mOcjhfCTplPZcf52EOz9b7y2twVKMfuz2HJGCUwhGu5cf56iFN30rYRCNh413jyfq5jlQOTj3131Ftq3Ot1dOmayuAOhah0zeK7UQo5ov1r9GD0h4uNMSVWxXClp7i0TI6AzeeP3Jh29GBusNcvU1XOZubefkOmwFHgDe2x58m11/+rYGZS95gcRLRwo2W6GODltYsoFo8Pyzdrw+UrSLKNOPFxB0DNzGMRIHIr2COQG75WeOjbbwu861mV2aMLUcxlLrwxRMrvn0UtsRIfZcu1+Z2DvTmb3a7fMumYekx14gvErI0skHYe23Omrb/CKCSO3D4C8qDGTNJDx52/0iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by CWXP123MB3559.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:7e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Mon, 27 Apr
 2026 02:01:50 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%2]) with mapi id 15.20.9846.025; Mon, 27 Apr 2026
 02:01:50 +0000
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
Subject: [PATCH v5 1/2] blk-mq: add tracepoint block_rq_tag_wait
Date: Sun, 26 Apr 2026 22:01:41 -0400
Message-ID: <20260427020142.358912-2-atomlin@atomlin.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260427020142.358912-1-atomlin@atomlin.com>
References: <20260427020142.358912-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR03CA0060.namprd03.prod.outlook.com
 (2603:10b6:408:e7::35) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|CWXP123MB3559:EE_
X-MS-Office365-Filtering-Correlation-Id: f4582e41-3c16-44cb-5acd-08dea400f23a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	JrPt7T/a9vRzcAhp1sM/dRQEQufPz3sJymN/g1sY8NxkiJQ/udGcajOZK7hBqzFbyK1AGSSzIc+LhumEMFYxFjP6QwT21pJF3SbJExCld21oVDlTvYpakfqwq/vik8I169ERej5xypU8rp1hpflzuUMrbtekTyqQB1N+uRUAfw56Itr6Xego3sRVA17XJ+wViBUYppcfRuAt/H8OQQvxLc7uxqhE51dlPsIaY3iHiqzS3eLhlCcw5hmr4i5Pn96iFnjN5dmTUwzPRhr35xTnteMH9sYjAGml634TbRccykFW3pqjJonvAjJbUsJpDi891MPZcbpikWtPpHCZZy1i5SIG3k2BFDYA4X/KblSZmUI2zLBRPjQPqb9FYip4M5ku20SnUaDrnOVgRWdvwOV3IZ2qbtfAoLFDHMF2zGtyurBs72FRQAVpa8rmODfABhqQhPhM+wgN0tmFYkBFnDWnK83sLhg+Ye8CCharoAwO/YyCJ+vAzqNg6T6KBCR8pu3lWOzSKKyRQMKmQiIV08cTj3qN621jjjzfPHMadc9SLutcj+cYp24N5ykcH3HLNB7u+ludGoulg3nGLG5IguUS00OIRq/S+q8i7YP5kQmttrfV1v8HU7fc/EFLylF436sX/YIAIg3Op/DQtqyW6Duc4+ZqMrVnG0IVM1OUG6s0fJC+WX+e00HflP5f7cOYlafp+ozvk0L3ZRJQSLn7t0kDE8OSqzYjgrYJD7aNPLQD+Yg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?c8eFgaxOgRHHHzEzvrKyxfRdKV2H9RwaYx27jVNh5JA6kMLipy3XAIuTaGpG?=
 =?us-ascii?Q?NPErvSr0E/OQBYrSOUjkMlz1vk7B7eNEhs/CsS/IWoLm5+s/uDkG0LckgsMF?=
 =?us-ascii?Q?BsGDvMxx7bbodgZBAesuZh79x/PARlq7G/3UKPtsiE/V4LDEY2QP0QDOds/D?=
 =?us-ascii?Q?taMgxi61/BdckbKzUN5GHL8aRa0THQkLYtqh+GkysULOqCJ1n/DMsZ/dX/dY?=
 =?us-ascii?Q?TZ+fbNOwoGBKks2kDiIfTyBmB1JDR+6+HMNgh8nk19nPgdX7c5t7UYUq03Sb?=
 =?us-ascii?Q?K/OegO6rhrWOC/MesXfAvLYhOrZomux3PYxoZWAnPAw2XEX0O4lqWLflprW3?=
 =?us-ascii?Q?j9kYhSCmo5QWo3574AC8KUjlul/eLCJBdjl+g6LAoe8xddNmEphSzLkNVs5z?=
 =?us-ascii?Q?VXKjXufMaZNdbCFHLq69d/gfhdArWlyI44iDrH4M+Tk3/ItvkKGbsqVR6vAV?=
 =?us-ascii?Q?M+eoXLt29QZezjSwUicPtOrHAB9GoYg2GpHvuz1g+MxV7OqtyUjQg/J6MSls?=
 =?us-ascii?Q?5Y7VgALJiq2lz8QPQICeakHQuMeHdsodR+hr3raCfFQHWf9dk0sJX7L3ZviU?=
 =?us-ascii?Q?WoKVR+paRIb00T+TDiQpCvlTheRtwWp5OZSy96RNjLPSWCUfMiYEyU1LIfm4?=
 =?us-ascii?Q?GKJYC763gRtEReK/gqflAFG5nbmog/LnTC1KuL4fJ82g023vKCMK6D9LN8Ej?=
 =?us-ascii?Q?NE3RLhfxy5EKQm37NcJvotSsoimNEUsrNy8Iplcm6o+ZDn6hNWxl8d4czHv+?=
 =?us-ascii?Q?gwjc+lT9928yknMMYDeljD/l3SvjvToqBvzNCllhaEhmVi2RA+N2ooCrpMXi?=
 =?us-ascii?Q?Dwe0tv4JrIkB4TrFRJUtX0op3B8Ve2sg+JelP1gaRO+RbgWMRsvVV+jnmnMg?=
 =?us-ascii?Q?Cuz/LCrfv9RnwjZCb+3Bi8wb/3H/rbV9yDcDo6+Jn8LFEcpgR3k8LUo61UrV?=
 =?us-ascii?Q?EWlCLBWI9B2+lPhlSn6o7plbrzqhkSaLpUQRDEY4UebbiuMZuGfBgkM9vhvv?=
 =?us-ascii?Q?Rv+AgTUwJXKdMPS6LcCXSqtuJ7nIUWa+01bJuiYfeQrP20kBUil+ntm2na1A?=
 =?us-ascii?Q?JelA9wkkhXhLVyBrb9mCyO5qIoaJVqk/buMT8U2wsi61hRkW8wrfbLLs5EpN?=
 =?us-ascii?Q?yBJYCgUmOP+DjEz2N8eSnlR/XMPhpc1YI7mtQYRqjYMUOtqwh8lAFGBpuzit?=
 =?us-ascii?Q?33vPzCa8MVwbrOi1O5BAQ17EpKCWRGzJMOaSHyLHj5itmgL+44+nrX8G0P47?=
 =?us-ascii?Q?EuXet1iaAOKcJV85IzO1zAKhKMB6M6h/KlrSKnaXWi2D1LfxrTGpytyfpZvk?=
 =?us-ascii?Q?jwVqn749L8rt6cRGhgTJfa/x3GqsifBgijqyjA61AGfG7rPkHpiNIcPOsFc7?=
 =?us-ascii?Q?kSlAtqTA8GGY57iiRftUWYs05CfDqBXYRej8uDcHemIeqriVzxYTJFnJUxix?=
 =?us-ascii?Q?XztOKd6FpETdDrRimfdCDhEedzb2u7xQRFKxXb3PjA1WL+4UV8S6wxCI5NXq?=
 =?us-ascii?Q?OOHnKoqq0MPAmvsAEIxYf0OoHFjsRy0vNYdoe0MQTmAhYBy5Y76GXdDUQsU2?=
 =?us-ascii?Q?1bVVWg+x9TQ87aXioBzfvzKELfjRsgC1Q5vReo4ivIb9zaU8wXbJVyIo2c1y?=
 =?us-ascii?Q?hhD0NWVYDHGlIeu6zAOay+vimXucZXPBBrXwuhh9dcUrKzZznM7lH3UWnZx/?=
 =?us-ascii?Q?aoF8p01u33SGYs4zFDlM2lS4EXEiTh6+jXuuR8P8HTHx9BSpdH395j71dUl1?=
 =?us-ascii?Q?uYpfHocfdQ=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4582e41-3c16-44cb-5acd-08dea400f23a
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 02:01:50.5903
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6g2d4QW7vawZ1GnjQzDAuxZrcU054rN+KFt4QrvLcXeYnGUAILb6E+YicPHCLrTVlS89RsUdI614Eb4AqSKoBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP123MB3559

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

This patch introduces the block_rq_tag_wait trace point in the tag
allocation slow-path. It triggers immediately before the thread yields
the CPU, exposing the exact hardware context (hctx) that is starved, the
specific pool experiencing starvation (hardware or software scheduler),
and the total pool depth.

This provides storage engineers and performance monitoring agents
with a zero-configuration, low-overhead mechanism to definitively
identify shared-tag bottlenecks and tune I/O schedulers or cgroup
throttling accordingly.

Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Laurence Oberman <loberman@redhat.com>
Tested-by: Laurence Oberman <loberman@redhat.com>
Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 block/blk-mq-tag.c           |  4 ++++
 include/trace/events/block.h | 43 ++++++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 33946cdb5716..66138dd043d4 100644
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
+					data->rq_flags & RQF_SCHED_TAGS);
+
 		bt_prev = bt;
 		io_schedule();
 
diff --git a/include/trace/events/block.h b/include/trace/events/block.h
index 6aa79e2d799c..7c1026d1cb35 100644
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
+		__entry->dev		= q->disk ? disk_devt(q->disk);
+		__entry->hctx_id	= hctx->queue_num;
+		__entry->is_sched_tag	= is_sched_tag;
+
+		if (is_sched_tag)
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

