Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020130.outbound.protection.outlook.com [52.101.196.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E27265623;
	Sat, 23 May 2026 20:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779567015; cv=fail; b=AiI5Q6bSp7lUMaw6uDE8+xEPBlb/igKjT3cySepphqLZIQcBE9GnNw/TAQZiOX3NOqIZ2aOZAl3LsxXFu0/zl8Rszh5BrwOFVEnTO8aSxWS9mc9EbaawVF98IYjesq5Z7h2mrc5j6aTyJR5GL5Sac/xXe+Sm2kGtNh1WyaZwE64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779567015; c=relaxed/simple;
	bh=+vedgn782Zh1zlvWmcJO/lUBCiOP2DQ0heZeGbPpbHc=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Blji1KFQeZ+kQovs3n8w++H0AS1FUbTCw6a2rJ8ukRJ1goWqTZsrt1NLpqsnGMLzVKzzzEcRakX+WS86ar3PE8TY6/1ONGWCEbW1+F/qsHDODSdMQTKjJUNRXFAV7BCNzY+7jbuBWxVxuoN4L1kkP/028MGJwo0XkfNHckIuLjc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.196.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WRgum4SvbeO7okHyHdR3cPQ09mADFzYkdF/3iWJKCLBApPWBCdllXatgMTP4Zrg9uJOP8xcL2v+y2ITkFHL0gSqpWlcLPINSBGh9FUbJ6R6e5Q+z/65GJeLT0NJ468IAeGYxEzF7mZuTzyp1W+67+74Km8rehK5lvySsk31V/ROdFnujLo3DSDJzBerm0REavs1qtFCJbX7gzmHPiPCHYo0ZMLZlaj4aTu8sLbu7cH4r2Pt9m5FcCGIm0iyIV/FTFoKhckNPid4/Gwr/0rosmkzeA2mbbZXtJ6JLm89RwwS/3noyRT2d2a4WxcxQQD0OEkMbK+zNRHug/q+pK0Y8ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EbKx8pX38exrObctv+1zZl+opMfVLrW52E/6gX5ds2g=;
 b=ORg7sY2M6LGkKnyKhh3Nr45uawMaBXWuvPC5J5VDHqyp+oBbF5LinMU67UKPmHwx0f4rEuT6mBMbixk1RG32z2qvSM/EsIocymb+JY4gEYm/+9vxvuMxP6I/hSRkFjhnBUhac/pydYL/a6giT3PQoabZmeetffnfR9QJiEXy/rQsGYlhgPDvY4tniIqBo03zoHbAJMkwU5ZokNL66r0qMHdPPzDXIW96haHgZRuEoIn+eNTVGMQGaO5vq+kpVZXOx3HT4x9zufZq3fVLCdy05G6rkQue6ZWLVhpXlCDAePaWSgExfu9+mPdxucqu52SbOzEPSVWKacYP4ZB827cIWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LOYP123MB3406.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:110::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.18; Sat, 23 May
 2026 20:09:47 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0048.016; Sat, 23 May 2026
 20:09:46 +0000
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
Subject: [PATCH v7] blk-mq: add tracepoint block_rq_tag_wait
Date: Sat, 23 May 2026 16:09:42 -0400
Message-ID: <20260523200942.587199-1-atomlin@atomlin.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0170.namprd03.prod.outlook.com
 (2603:10b6:408:f4::25) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LOYP123MB3406:EE_
X-MS-Office365-Filtering-Correlation-Id: 72e608e9-fe8f-471e-d725-08deb9073c26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|1800799024|376014|18002099003|56012099003|5023799004|6133799003;
X-Microsoft-Antispam-Message-Info:
	A1+RGTitX4NLlD+LXkmgceMvOqysCDVBw238us86jg3mcB8KMqq/m3DXbvMizTY8VDw0tiHXjL7xSstDjJ2cyjabEobv4+gDME4PUAcv3z5LjyLteWyechoQzkSo0+oGzG3ufes7ylx1/7hBC5AzQzfQ4J5/C6Y4V1gzMBKMUh3DQ7a/2GATDsAzVv61KBOg7h+xtYaMJBU8fkWEBSFbTEKitRbR+TQfNrmasSLWL3yYPFSoJo5pJ/OkWN9Pl0okaG9F5LZlB3FcMERSfgkPEXb6BN8QXkd6dthEmWf1L6lgi3SFzsGvbojeE2/0/H8zQkPNTyFLIE/+7eduu2i2zfVoZR+APw9eZ32KDogxtbwTk5gAS5ew8/7DUaKUGyKMjIe0X9KYf+9MkNTwsteYsHvq7L56m20Lf+7WkN2tPmtUs9rBxQXiTEbfy6ajQ3eucPjWv6UJGLL4y2SFvmheV103BFSXTIu2ObaF4CBco+C4FXU9GDM0sEcoPS/RIk8XD9lHx1tBawYUcBNws7p+ADqWOTSMh8GfKh/ASiFfLc3gkvrll5D0L5b7WWlWephe2LEiFHI9TCXKmuI3EonDjOxKAjZGDRaXBt1/fMRtp7yxn2uQ0MQRiTHRYVr09kERiEgPezXSHxRe5BHntI2hp5Mgmss1J+lykPUjQmgJXWVg/EkyS5t6SZOEEgiDyyvmuJq4eDzIU4inwGzG5A6qZg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(18002099003)(56012099003)(5023799004)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mE4mOTPHZYfsf9O9uWCVwWw9H14VKF3d1qjk+azTb8/CmGS8/kJRCQHhmTVu?=
 =?us-ascii?Q?UgVj9R9ZswgWBZJDGQad4rmTp4PBITUhcmBuva8GOcLcIzsh2WD+kucQZmDW?=
 =?us-ascii?Q?ziuokwZ8rgYX4rUIF4eOM58m+iZw2bsUSJNtfqDzGDp1pP40ehowC1R7Jwi8?=
 =?us-ascii?Q?XYVEWswYNwhOh4LTb1lEwO9tPqTlS4T4LaHonS48XQo96fyMC8g0WxaqWs/N?=
 =?us-ascii?Q?cblISADvbllPj52obrBO8RtIRMty8gsLWroHMcbNX0DffedJ3aWeha9oV4Jk?=
 =?us-ascii?Q?4Xhxu/Xbr4H6+uVGBioQPfkP4n4jYvx267In82FZQELO/L4cGElwm8HPjyL3?=
 =?us-ascii?Q?LyhsvSOfH91nMQTAVlezzFLf1nvA7q3qvUK3jmUNW7csmsWGmTXjXhuBODIi?=
 =?us-ascii?Q?E1FuCcVhNQ7bAj0YijVFHfdGHQT3xBEoRvvyuVoEDVIzQNQLaephnJvfAHdq?=
 =?us-ascii?Q?QoSzAJpY57LTAzRjPd6V9LqZ3b8ks38Kpws3jvSQjk0/7ah/MvIpnFuUp/pM?=
 =?us-ascii?Q?79GwUU40ggLqy4S4rVMPD+h1OvwVxOd1gvs4d5hzmAkevlp4QpT9p2i/arc0?=
 =?us-ascii?Q?oJL1hYsJ5V/XhWDIJc58DrNKBJxfABuQ9QXa2FI2hk3DoODQNPi2pgL3TRPd?=
 =?us-ascii?Q?+CXpTDxNIgfafdkKgo7Bhm1GiuXgyrOx0DsyZU9MTnKoKNxCx3vV8P7Fn2fN?=
 =?us-ascii?Q?0wMZ5lVMEu3jpPrPtMxUZ2+mOf+KeGrU5Yp2PNHag4vgocxypMwiIJYW0gH2?=
 =?us-ascii?Q?+EIIn9TmsQxYUc6ZKuQpWJNjeNt7Wy/tEO9f+jNbyEzKLOuDPkkYCh2SPrM6?=
 =?us-ascii?Q?PdARYYNx/lNh8Ng6IQ2aN8floIO1HPFPnUZkPRXtYMe+OBe7qVrCipVK/8+q?=
 =?us-ascii?Q?/CxoWoV3HLyhNpp9r3NFocv0FP3mc5z6OwYwNHHQfucWUcS/E0OwOiJ7AX2n?=
 =?us-ascii?Q?X+yTwfPkNIzhWEDsK/yRBU0EpT243MqlxVW0PsCfsBFlTnPeF1dwE9tX8SGg?=
 =?us-ascii?Q?u7X5IUD5iYfff5XwkadAowzjTSQ9ET8o3fR17LiJUgY7HgjGhDspwOcm/BS5?=
 =?us-ascii?Q?fua1U42O7ViUUp9pMj2dU7QmJj1dolwC0e4tW93T7BZArF2kHKLnQp3lb0FC?=
 =?us-ascii?Q?Cnz2SucZ29WZS70BtKTRSMFZUzw3IqorvguD0/gu2vXlFFZ2p2w4REsXPIkZ?=
 =?us-ascii?Q?Hl2OntvmMYY1tyVQ+md+LHMkUSDqCKlwemuIQaxahcGPq9nRSJoPTVDcd0vh?=
 =?us-ascii?Q?5Q3Omisf0oCYU9zkuxvSRf6OIkiZAD474k348Op1O8liYRRNz3wWGk096IkE?=
 =?us-ascii?Q?8H2o2ult6NosEfaSiPoCzrp3T9pR6huW2Yuw/k4oorTX+/iE7Km1Jg9Rv0VL?=
 =?us-ascii?Q?1fYun6jkcceU4FDVK25pqTp1LudVcrW2lZoXKXVryrR9yW+84NhEdmPQ9LM2?=
 =?us-ascii?Q?8+iD9lnRWwF9XWaihn5y3QHJDsr8o+ENvEWbfMfB2HLPe/RMqMinlZjU9c4A?=
 =?us-ascii?Q?88cG8qVFR5rruAdB8S+B/eAL7kuK/UqJypk25rSzRw8/CdyYGihvSJSN4ZFL?=
 =?us-ascii?Q?Yf/j0hIXK0SqJ9b6+UIahikHrGV9u1qD+yY21NQ5LcH0zQjVpOsg70JOStLp?=
 =?us-ascii?Q?DTg85oEzq96985SEM4Gl9byZJB7LwncC61DPLneMwEplqu9xHA9Dz7HGqZtl?=
 =?us-ascii?Q?UwcphuOZp4F98aT3y/wpyKQGZ6F89nS+v/BLcb0XYyFNguSnh1qSVGkMCrTB?=
 =?us-ascii?Q?jtHuI8+Sag=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72e608e9-fe8f-471e-d725-08deb9073c26
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2026 20:09:46.1954
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F9v3gnKdR6THLgUQDuTLlexyrjHqKtmt2OD3J0qL4vvsvqCPFXbZuXsrPNsheGKDU2zjrifx/0TqQ0TGcJNOSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOYP123MB3406

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

Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Laurence Oberman <loberman@redhat.com>
Tested-by: Laurence Oberman <loberman@redhat.com>
Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
Changes since v6 [1]:
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

Changes since v5 [2]:
 - Replaced this_cpu_inc() with raw_cpu_inc() within
   blk_mq_debugfs_inc_wait_tags(). This resolves a preemption warning
   triggered under CONFIG_DEBUG_PREEMPT=y, as the routine is invoked from a
   preemptible context immediately prior to io_schedule(). This adjustment
   deliberately prioritises the reduction of execution overhead over
   absolute statistical precision for this diagnostic interface.

Changes since v4 [3]:
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

Changes since v3 [4]:
 - Transitioned tracking architecture from shared atomic_t variables to
   dynamically allocated per-CPU counters to resolve cache line bouncing
   (Bart Van Assche)

Changes since v2 [5]:
 - Added "Reviewed-by:" and "Tested-by:" tags for patch 1

 - Evaluate is_sched_tag directly within TP_fast_assign (Steven Rostedt)

 - Introduced atomic counters via debugfs

Changes since v1 [6]:
 - Improved the description of the trace point (Damien Le Moal)

 - Removed the redundant "active requests" (Laurence Oberman)

 - Introduced pool-specific starvation tracking

[1]: https://lore.kernel.org/lkml/20260517213614.350367-1-atomlin@atomlin.com/
[2]: https://lore.kernel.org/lkml/20260427020142.358912-1-atomlin@atomlin.com/
[3]: https://lore.kernel.org/lkml/20260419023036.1419514-1-atomlin@atomlin.com/
[4]: https://lore.kernel.org/lkml/20260319221956.332770-1-atomlin@atomlin.com/
[5]: https://lore.kernel.org/lkml/20260319015300.287653-1-atomlin@atomlin.com/
[6]: https://lore.kernel.org/lkml/20260317182835.258183-1-atomlin@atomlin.com/
---
 block/blk-mq-tag.c           |  6 +++++
 include/trace/events/block.h | 50 ++++++++++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+)

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
index 6aa79e2d799c..15b2e0edd2d4 100644
--- a/include/trace/events/block.h
+++ b/include/trace/events/block.h
@@ -226,6 +226,56 @@ DECLARE_EVENT_CLASS(block_rq,
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
+ * via io_schedule() until an active request completes and relinquishes its
+ * assigned tag.
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
+	),
+
+	TP_fast_assign(
+		__entry->dev		= q->disk ? disk_devt(q->disk) : 0;
+		__entry->hctx_id	= hctx->queue_num;
+		__entry->is_sched_tag	= is_sched_tag;
+
+		if (is_sched_tag) {
+			__entry->nr_tags = hctx->sched_tags->nr_tags;
+		} else if (alloc_flags & BLK_MQ_REQ_RESERVED) {
+			__entry->nr_tags = hctx->tags->nr_reserved_tags;
+		} else {
+			__entry->nr_tags = hctx->tags->nr_tags;
+		}
+
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

base-commit: 6779b50faa562e6cca1aa6a4649a4d764c6c7e28
-- 
2.51.0

