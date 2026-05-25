Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021141.outbound.protection.outlook.com [52.101.95.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2031DDC1B;
	Mon, 25 May 2026 00:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779670295; cv=fail; b=Ag91KDkT0vkVShYXuT/t+wFjgjYbZWPndDMdoqPcCqQIOMtle0ViVoSF6mDKVVvIy9g8WB57scCLCJ7hutYZxg7Awmnvd7SzbLhvYm3KccbqtCYtV5QBDkXFoTd+rUb6gTG0v0bTlIeMVGaFtb3ig0NRrRGZC4pP4b97gfqJhPk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779670295; c=relaxed/simple;
	bh=p8F8XnV6bW+ho/aE1p4KEj5ma1rQsKBi61nXJ/FNnDs=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=E7150VmDWoDvdIVqx/pew7Wro6D8sXW8oEZlA/dcNz6v0lFOQAQ1BwoRgLAUYoDI99jyHtHypxWm0JYAmykL6IInzZC1B0oOGlXlSXBgjpMoK6L921tZzrd5nGTyc9c0xKIf+rtOx+nUZDIwfgW7fT8rq//qNU2PICr62mIV1Zs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.95.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M1hDZ2hA1gderBdLxr+oP1M48NsxBqexxM3lYH1a5dafORRRscZWmhVrmVjTnDVYt+1Bzxc9fdgb9sOKDQhfyY4637RCN5lSopWMo3zRgZr4hh0svKVF/tEmdBANXfdjy/SAWvjoIukTwHUREMYa9rUkF5zsvfSy52rkvusZTCZ3kvpW1fmRkyGKh3FEqEytgTPZ8wBpannqgJiaBCCKh82pUmsdU8OT0culphcBqMMlQlDcq2RF8fzM0O0fQReGDIBwRwDHHekaRUqOvhjPAwv6NiWChb7W5/ouUQ0mQt6n8fR/8JdhjvCinAqCUaznz4wINubU7dGiPcvnB3PKiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ey0WmP/p1ZhGosx9WAgT6iKJcyBlXGtLxVhp+NVV638=;
 b=mp2thNow5vk8g9f2jc7UbZNCi6d1sz0Ux1LvuD2UZiZQe31Wlb8m6/LaaLO81DjtCkOflwb3TBCOXUOpxh3Ce8f6BLZMHsoD5uFxlErSntl/s6OWF+rfqQxLTGXCVtMVfbszDgdkG4sGLPWOYslhav4RRnAEeSu7a6jFUyxpR1JW+mDnuwXy9rCKFUlKs/xubnq5l/Y6p7xt12Ceu8FLXdog7XqGMGow278pbLh79MDDvh/+HL25/Mzz0c5+0fgrO+H1N8YbczTqwbR3H4iMYcoa5L1YD/TlztFKoHQLd2PTsegbTh9vI349PQbfY8JmOEsTK+pzNVNGGntOXcFjhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO7P123MB8467.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:45f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Mon, 25 May
 2026 00:51:29 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 00:51:28 +0000
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
	john.g.garry@oracle.com,
	loberman@redhat.com,
	neelx@suse.com,
	sean@ashe.io,
	mproche@gmail.com,
	chjohnst@gmail.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v9] blk-mq: add tracepoint block_rq_tag_wait
Date: Sun, 24 May 2026 20:51:23 -0400
Message-ID: <20260525005123.722277-1-atomlin@atomlin.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9P223CA0019.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:408:10b::24) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO7P123MB8467:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c4130ff-5942-4511-fedf-08deb9f7c10a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|56012099003|18002099003|6133799003|5023799004;
X-Microsoft-Antispam-Message-Info:
	Go8RPoNFSP5BNfYH74vuOJ90Xw4MDNZyk2LT5aIZZjpciE83j0LWIVnyP4XkTEkYdiZ9hKZBvYndgZqhQUzmbjGupJbA7nvSfpPud875qAXE8HVDB7OJ3Wkxt7bPQpjCi88WQFBY/j8lC16vZ36onoVwDU+/hkRaoGxkvvpnTmn+UBgzygxvhUZTX/Fx+EXWGIHDH5KCnq9250exb7vqlnaOoDc7OxUDJQWtAMPrrid3LFhtel0klnRHGrrmwSIbz4AA6/mlxtSc3dddNdXNjJucIpK92AE1vT17GXO1sfGZPsSby94+QUo3fbs597X18XeF5xYnvxB7YqmnhP5SrtFp0esyzidsjNPojJUrULdUkLLVEoZBDOGwptEIXJSRhApg6USGTfirmxWVhHEAzs1IL79iVz5MVduNSYRXfmn/4dGkuDZYp7uaE0ZXS0gOBY1yWLI7YPwAu3Qi2mSa5SP22UcBPVwdXv2RjZtSX36i0cxOAjYBOKplGX1Fg+qVS60ONaJMFO+igotKKjo2FSRaiRcVAeXlzxWEK9/LR7dAOtd9U2gv1ikY1M71Bj+2Q2F+YdOYysU4zTNLYSz9M+jH1eDo3WEZJub9fA9Yd1onYwQ/R07DT3t/ixGeigwi2SgUBgpbMn3opS7Nrm7jLDBCW4X51aiKlRK2f9FnyBGGQ78iVePHPuyX6KecdcUZIXrcXne0Iz5hX0eIbdnbxA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(56012099003)(18002099003)(6133799003)(5023799004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AK2bIpUqV2meNvKxyYNxxsNWNLnGSx9ZSO23hjpfSiXddRHaROE5Sgm2Atv1?=
 =?us-ascii?Q?GOEKWBKNxWLXeqC2dBg0nAdyIyc+2Z62NVGw5BgRt/vQi238UBQWSGWHVRZX?=
 =?us-ascii?Q?SD3Jno0FKQL9c5t2uyFz8WJtAj+q3xBV3Y7mIGpu9tbLxprkoNRqQSqEYJKl?=
 =?us-ascii?Q?FtU7N0OfYbPUqwv/wXuOZx2F3yMPv1ddrBrR2HboytHCJCvKKSxQq6iGL5No?=
 =?us-ascii?Q?4pFLnlT0RhuSqQHdMK4s5FCuOhiy6Kw48neynDb5mH+Lq9vDQySY91ddKmp1?=
 =?us-ascii?Q?1uAuJ1T9DGd8xbFii9m5ZQn1H4EawoVzBQPepWDIYLmK6SMEpHm1XpouDfLn?=
 =?us-ascii?Q?MoIC8YIZVjDtdRfydfBMiZ1K5ShaWeSiMRwG5mZ5JProU4197NhTHljXxYko?=
 =?us-ascii?Q?ooTHymTskXxBFb0cqqvSPdbZL8ad/c1NVbRekpWTAgGa4ooFd/LhCh/YzfFt?=
 =?us-ascii?Q?4y8v9VsRIM2wLn34OFuj/f81jDNL5o7CnG4mYgc4EA2u8X1AJVXUTBS6k5OU?=
 =?us-ascii?Q?P4URZQDJmugkmEU5jH/eGn2qNMPGo5UCTZEcnKJEW1EbcQkP3hByD1RjX3f4?=
 =?us-ascii?Q?SmqDXZD+EYKqs1TOY2C6e3Q/AT7CKDo4ZKjliCHvPxY1o8n8BTzVAcdiCm+E?=
 =?us-ascii?Q?ILyFghlKj5a5A4BDzpCB16pOqLD9cSynrLKvwsV5LYJ30JdLgEHR4lK7VlSg?=
 =?us-ascii?Q?ltEea4EktYq8w7LJLDH5HYVcQxc0FKy7k+WpJtC7g/bzyFIjHRYtMbs/I+K0?=
 =?us-ascii?Q?5Ylo8a2LPJNv+UBfTpluYoLcDSUZGx/f/gIQYiBa9LvnxK53GmkgMzImbRPt?=
 =?us-ascii?Q?3gXAl++XSbkDVLhNbtYeW7MB06oyTD5XqRPOsq/oSvkLu9372Tlr110x3M/e?=
 =?us-ascii?Q?a1yXGS8BJe5RWUFHSXkgFnzv3lfOlClNkf6ORcGBxroyj7vr6McCBam5dHY2?=
 =?us-ascii?Q?9lwOpZvsU4bmqL57urZ4tT/szyJpvb4HtKOiNDOHqvaX+TPgOQHeqfEv2PoX?=
 =?us-ascii?Q?/wyxaippCa/+TwAHK/r/EHJ6N9QbRaeBl+6L82/WwmOqBivj52q8gNlMYRsi?=
 =?us-ascii?Q?Ep/l9ahofJ3VAJE4VVRrhe5Te80IH5gs6FxOtGkO2jQY1H1ABnq/w3u7aVYH?=
 =?us-ascii?Q?WzlUJX/E5zV3N9cU70lyJhxBZOtLweJeIi3TnSlOsjLWRViTlnFj1G0L28fC?=
 =?us-ascii?Q?Vbu+p6kEaXE6lnygwxp5ZSBd61RJmVh+cs/AFIbdXea9DCLFjn8d3U53Qdf6?=
 =?us-ascii?Q?8GOONydpdGC+3DcppSSZR1uKZmwc4RSqk+RmQBehktW0IBo7wRJSoomdlQtf?=
 =?us-ascii?Q?eodrVV7syRk8YwwXTLgHg9XlbQVdttYTFAtM5kBs8etWBo5f63Zbi8t9XTj3?=
 =?us-ascii?Q?mJlAZ6t6m/vf2o1Lxzx1l8M/zn+DGKRBeTZFj7ZvfLRM9oVDhePwWJHt7V12?=
 =?us-ascii?Q?Pl2cHA81WxU/kzi3lXWEfTtVcB3DCpeyb4IqsyfgVOVQnpc39NPueliAVdCe?=
 =?us-ascii?Q?Ou1TFLdgnYhcdyVWnAhYNrZrj8yOCIchXLuw9neVUMV74JfdjElshZvKQ5ww?=
 =?us-ascii?Q?xCdlCQOl5s9gx2OPclHW5TqxiSMRz6yCPhsBJ1l/kk4V5uGC0IdK97bpAiqt?=
 =?us-ascii?Q?H1h7eN8IV4rtHTiiTcdaxY0cktzFQF6cvrnsjvDj7Pcrh3RSMdofYPUcWN/o?=
 =?us-ascii?Q?XUvFujBIV9MFiViIobvFbEgRnnDUDHKxl1ps1Igm2WIHIPIwhZozRBjfMEND?=
 =?us-ascii?Q?0Wf0Mcffrg=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c4130ff-5942-4511-fedf-08deb9f7c10a
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 00:51:28.1497
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wMd4KUYiDQIFSptT6fBGSWc5o/vxCEF7SFmGFRTDdG+p2PrqqsX4tgKJkTQuYdi9Qy3SQffaVnSV48omCJZ5yA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO7P123MB8467

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

This patch introduces the block_rq_tag_wait tracepoint in the tag
allocation slow-path. It triggers immediately before the task state
is altered to TASK_UNINTERRUPTIBLE (ensuring safety for PREEMPT_RT
locks). It exposes the exact hardware context (hctx) that is starved,
the specific pool experiencing starvation (driver, software scheduler,
or reserved), and the exact pool depth.

This provides storage engineers with a zero-configuration, low-overhead
mechanism to definitively identify shared-tag bottlenecks. For example,
userspace can trivially replicate tag starvation counters using bpftrace:

    # bpftrace -e 'tracepoint:block:block_rq_tag_wait { @tag_waits[cpu] = count(); }'
    Attaching 1 probe...
    ^C
    @tag_waits[4]: 12
    @tag_waits[12]: 87

Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
Hi Johannes, Damien, Chaitanya, Laurence,

I have dropped the earlier "Reviewed-by:" and "Tested-by:" tags because
of functional logic changes in the tracepoint assignment block. A fresh
review would be highly appreciated. Thank you.

Changes since v8 [1]:
 - Fixed the standard pool depth calculation in TP_fast_assign to
   accurately report the unreserved capacity by mathematically
   subtracting nr_reserved_tags from nr_tags

 - Removed "Reviewed-by:" and "Tested-by:" tags due to the functional
   logic updates in the tracepoint assignment block

Changes since v7 [2]:
 - Added an is_reserved boolean to the trace record to explicitly expose
   reserved pool starvation to userspace

 - Fixed TP_fast_assign to report the correct nr_reserved_tags depth
   when I/O schedulers utilise the reserved pool

Changes since v6 [3]:
 - Dropped Patch 2. Observability is now driven entirely by the tracepoint,
   with the commit message updated to demonstrate how userspace (e.g.,
   bpftrace) can safely replicate counting out-of-band (Jens Axboe)

 - Moved tracepoint call above sbitmap_prepare_to_wait(). This prevents
   inadvertently resetting the task state under PREEMPT_RT locks

 - Updated the tracepoint signature and TP_fast_assign block to evaluate
   the allocation flags. If the submitting context is starved of a reserved
   tag (BLK_MQ_REQ_RESERVED), the tracepoint now accurately reports the
   severely constrained nr_reserved_tags depth instead of the total nr_tags
   depth.

Changes since v5 [4]:
 - Replaced this_cpu_inc() with raw_cpu_inc() within
   blk_mq_debugfs_inc_wait_tags(). This resolves a preemption warning
   triggered under CONFIG_DEBUG_PREEMPT=y, as the routine is invoked from a
   preemptible context immediately prior to io_schedule(). This adjustment
   deliberately prioritises the reduction of execution overhead over
   absolute statistical precision for this diagnostic interface.

Changes since v4 [5]:
 - Prevented a NULL pointer dereference in the tracepoint fast-assign for
   disk-less request queues by safely checking q->disk before resolving the
   dev_t

 - Fixed a Use-After-Free (UAF) and permanent memory leak by decoupling
   the per-CPU counter allocation from the volatile debugfs lifecycle and
   tying it directly to the core hctx lifecycle (i.e., blk_mq_init_hctx()
   and blk_mq_exit_hctx())

 - Fixed a potential compiler double-fetch bug by wrapping the per-CPU
   pointer evaluations with READ_ONCE() in blk_mq_debugfs_inc_wait_tags()

 - Passed the appropriate gfp_t flags down to the allocation routines to
   maintain the strict GFP_NOIO context

 - Updated kernel-doc descriptions to clarify that the NULL pointer
   checks guard against memory allocation failures under pressure, rather
   than initialisation race conditions

Changes since v3 [6]:
 - Transitioned tracking architecture from shared atomic_t variables to
   dynamically allocated per-CPU counters to resolve cache line bouncing
   (Bart Van Assche)

Changes since v2 [7]:
 - Added "Reviewed-by:" and "Tested-by:" tags for patch 1

 - Evaluate is_sched_tag directly within TP_fast_assign (Steven Rostedt)

 - Introduced atomic counters via debugfs

Changes since v1 [8]:
 - Improved the description of the trace point (Damien Le Moal)

 - Removed the redundant "active requests" (Laurence Oberman)

 - Introduced pool-specific starvation tracking

[1]: https://lore.kernel.org/lkml/20260524014204.622699-1-atomlin@atomlin.com/
[2]: https://lore.kernel.org/lkml/20260523200942.587199-1-atomlin@atomlin.com/
[3]: https://lore.kernel.org/lkml/20260517213614.350367-1-atomlin@atomlin.com/
[4]: https://lore.kernel.org/lkml/20260427020142.358912-1-atomlin@atomlin.com/
[5]: https://lore.kernel.org/lkml/20260419023036.1419514-1-atomlin@atomlin.com/
[6]: https://lore.kernel.org/lkml/20260319221956.332770-1-atomlin@atomlin.com/
[7]: https://lore.kernel.org/lkml/20260319015300.287653-1-atomlin@atomlin.com/
[8]: https://lore.kernel.org/lkml/20260317182835.258183-1-atomlin@atomlin.com/
---
 block/blk-mq-tag.c           |  6 ++++
 include/trace/events/block.h | 59 ++++++++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 33946cdb5716..35deee5bbc73 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -13,6 +13,7 @@
 #include <linux/kmemleak.h>
 
 #include <linux/delay.h>
+#include <trace/events/block.h>
 #include "blk.h"
 #include "blk-mq.h"
 #include "blk-mq-sched.h"
@@ -181,6 +182,11 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
 		if (tag != BLK_MQ_NO_TAG)
 			break;
 
+		/* Log the starvation event before altering task state */
+		trace_block_rq_tag_wait(data->q, data->hctx,
+					data->rq_flags & RQF_SCHED_TAGS,
+					data->flags);
+
 		sbitmap_prepare_to_wait(bt, ws, &wait, TASK_UNINTERRUPTIBLE);
 
 		tag = __blk_mq_get_tag(data, bt);
diff --git a/include/trace/events/block.h b/include/trace/events/block.h
index 6aa79e2d799c..9c97a16850b9 100644
--- a/include/trace/events/block.h
+++ b/include/trace/events/block.h
@@ -226,6 +226,65 @@ DECLARE_EVENT_CLASS(block_rq,
 		  IOPRIO_PRIO_LEVEL(__entry->ioprio), __entry->comm)
 );
 
+/**
+ * block_rq_tag_wait - triggered when a request is starved of a tag
+ * @q: request queue of the target device
+ * @hctx: hardware context of the request experiencing starvation
+ * @is_sched_tag: indicates whether the starved pool is the software scheduler
+ * @alloc_flags: allocation flags dictating the specific tag pool
+ *
+ * Called immediately before the submitting context is forced to block due
+ * to the exhaustion of available tags (i.e., physical hardware driver
+ * tags, software scheduler tags, or reserved tags). This trace point
+ * indicates that the context will be placed into an uninterruptible state
+ * via sbitmap_prepare_to_wait(). If a tag is not acquired in the final
+ * lockless retry, the context will yield the CPU via io_schedule() until
+ * an active request completes and relinquishes its assigned tag.
+ */
+TRACE_EVENT(block_rq_tag_wait,
+
+	TP_PROTO(struct request_queue *q, struct blk_mq_hw_ctx *hctx,
+		 bool is_sched_tag, unsigned int alloc_flags),
+
+	TP_ARGS(q, hctx, is_sched_tag, alloc_flags),
+
+	TP_STRUCT__entry(
+		__field( dev_t,		dev			)
+		__field( u32,		hctx_id			)
+		__field( u32,		nr_tags			)
+		__field( bool,		is_sched_tag		)
+		__field( bool,		is_reserved		)
+	),
+
+	TP_fast_assign(
+		__entry->dev		= q->disk ? disk_devt(q->disk) : 0;
+		__entry->hctx_id	= hctx->queue_num;
+		__entry->is_sched_tag	= is_sched_tag;
+		__entry->is_reserved	= alloc_flags & BLK_MQ_REQ_RESERVED;
+
+		if (__entry->is_reserved) {
+			__entry->nr_tags = is_sched_tag ?
+					   hctx->sched_tags->nr_reserved_tags :
+					   hctx->tags->nr_reserved_tags;
+		} else {
+			if (is_sched_tag)
+				__entry->nr_tags = hctx->sched_tags->nr_tags -
+						   hctx->sched_tags->nr_reserved_tags;
+			else
+				__entry->nr_tags = hctx->tags->nr_tags -
+						   hctx->tags->nr_reserved_tags;
+		}
+
+	),
+
+	TP_printk("%d,%d hctx=%u starved on %s%s tags (depth=%u)",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		  __entry->hctx_id,
+		  __entry->is_sched_tag ? "scheduler" : "hardware",
+		  __entry->is_reserved ? " reserved" : "",
+		  __entry->nr_tags)
+);
+
 /**
  * block_rq_insert - insert block operation request into queue
  * @rq: block IO operation request

base-commit: 6779b50faa562e6cca1aa6a4649a4d764c6c7e28
-- 
2.51.0

