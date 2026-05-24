Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020101.outbound.protection.outlook.com [52.101.195.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F911DDC38;
	Sun, 24 May 2026 01:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779586935; cv=fail; b=Pj25+0j4qgoR8lUZnCTWCn+GWNDjRw9fIpLCmlyfVeq69GDBBxp/Fu/Pa2CxroJ+iEn4PMgzTINBGUSshy9VkzXM9sDqlLcaa+GeSJGieX8AUPse2T08iynOeDEMfmJWyi4NPx5UH5zv1HYOhC07hQkAiDJNsMQRfK+fBf0m5x0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779586935; c=relaxed/simple;
	bh=njN9//lF9fA2EwaJ5fwtvzmBPrl4Ki0sOECKovN2E/8=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=OAtfOCrcb9ptypNCEkvfewN3awdUYmiDcPo2wH3c5YRICSb4hAYxT+6S1vxVyqJ3qWEY+bAoeXRRQ7zy9DaSc+ycTfFuZwvt2JDQUIcpxyLeBBLIhekP/nBgietrcTI+9DoTuDItwSYRw16r7YhS5tKf3POhPI5W+4x2vr+KJZo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.195.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vde5A8h8FIXpB4/CtGJFsUploxlXRo1Mhpy6oNKmPF7g7JsdPLMU2sMj+PXRZ10nIexbTFvwu73nS4ezqOTVpZLaJ+v933/7eGJzsAuQjtzi63Ej5disdhjlJ83yA1A/ZxGEgq0aX78AD631yrqZnnZFAWgBNxNcWTqf2VV8m0ZyDFauXwcr3PdT6SOWm5LWaV1yOGml+qtDZgjFyqx67elzwUV2mg+v9AMgFDbK1rZL9rLR+QkeLYjZ2j0dpgvXH293GK0hT21NDR+z2HLxY2rKBSs0LVa9PUmZc7zOv3P54+D8q4FLGpbTcrRzQNXE4v1tUlSMJumt98Fm1NKMrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sUefUQC2aqDTj3I+z5IpuXtzCUA+O8IKyQsl8VqKb3U=;
 b=JXNJWTNNW7KXymMOx+myrTDBFd+fMM7/UhDV5KDUpnrGvpOJ24CVLEIqCph9Rhn5UfGZAvdlVFVqVPxBhWy3FA4wLx8mSsx8bjC7HUV/KLZX3ge63ljPoqFqgWuZ9kSQwfZerRTrBkuFyNyy1U0nCxEBECLkWD1AsdovYWN2f1Yz7Mn2rxGti2EJnKMy0YxULO0DqUxVnsqhC7OPzXm+Ujkfc+FrThUAaEf8wkhgFCp2SIrpgaMibtXU6VSCnJYHYojlSxE5JWYFt/SQx8CgHC2n580OZRZqBEoBOk7JYfB897nK8JIO2tYTkSLRE1sVCiUcxGU3xSBmYT/LDpDHnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO0P123MB7231.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:31f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Sun, 24 May
 2026 01:42:09 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0048.016; Sun, 24 May 2026
 01:42:08 +0000
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
Subject: [PATCH v8] blk-mq: add tracepoint block_rq_tag_wait
Date: Sat, 23 May 2026 21:42:04 -0400
Message-ID: <20260524014204.622699-1-atomlin@atomlin.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0549.namprd03.prod.outlook.com
 (2603:10b6:408:138::14) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO0P123MB7231:EE_
X-MS-Office365-Filtering-Correlation-Id: 152e2e28-fedf-4472-fb09-08deb935aabb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|56012099003|18002099003|6133799003|5023799004;
X-Microsoft-Antispam-Message-Info:
	Ny67yEPa3FebKCNmYrdw4vaXFlJLVeZUJiaFPUXn1h67sAIntjajOGtEE5GTnnwuwDuLWhEPQiP93hGnj+Edvxv3dfGynCVDREcTi0irS2mGN78wxxZ7H0o5GPk0wm0ZJZ54KjA+83BTqhMKkR1NPR1O7U/f637n+FvEvW7+/LBE6lcfE5UO6eswo5wz2ot0i22M1DsyZjr2uCUIfHZclPGmG3F60HFMYOQcvCMP/CjY3I7j9g65T3ay0Snrgkg92OzbYIw/f6S2XDvoPc7TKsm2K0AS2cD1a0GcMxOGoeU1ww9MyQhqnK8XILf3yro6ELsumYa3o62Qa9C815wVOOvLfkFRVwFodPT0hVj834Dls8s7DVGZACRPIn1ReE/WxHOTK9kU/em3b0lfBug5NEus3T5CVyPUMnXFEQnqrEB3Hq5fBaHOfGMwmmSjKzwhT1OUAETDzhQHlvwyF8oKeHbB8Xirat+iIEdbjmpAQWXah8zVzsTj+fskZvD9DwjbzC7OlCKzuwO93sL71FVcvRaw1WEe3W37vxrME3Ua1Eda9ePmNXNhcj2TElu+VDYjgmbElyM1p/vWlkOzEV7g7xlO7nunwZll7roMm+b3Dj+FRfPJTc+lJXuQLp0L0l5IfKibd5kXokTZEQ5rzE7LVENrKelq/lsS5MMNOi+6hWLDxE6fRKalZp/TOZVbVlh7aHiWms0veSEIyLnxtnHt7w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(56012099003)(18002099003)(6133799003)(5023799004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FROG4EbsntpDzW/fR6VIKocITBmMI/HELFDxe6Si/62u9nlFJxGdnFJI0o08?=
 =?us-ascii?Q?8zCtHHlaUOieRh8wZC6G5Qap3GvYnHeRX35zRdD4TiNVKXZXdnQzlbkog7hM?=
 =?us-ascii?Q?bpWIGhby1RogI22MuDhJUDwbnIKA84bnBH7R1LmdwLiqXT5/Q/fncS49k0tn?=
 =?us-ascii?Q?MyyMG32TaSIRmpMd4y1e93pbEB8EoxAqVDxRDDQR2CD5RNI+iLaDGlT76Jru?=
 =?us-ascii?Q?j7364J8loXDLfq8ULuQakVNYmJ3tPcqYIxJtpztwXk+8tUlXBDYfdcIJl9Ny?=
 =?us-ascii?Q?GPGHc8q9lb7pv5llONaqAKyz7AmjsAPWyEKXUl1s2dPAo7TM6QBAq6sgEXs8?=
 =?us-ascii?Q?Ge1UTT/hEMXaqNSx3AP0CSDDj57S6v09cNcdwH+H/o2D8ULM1eJkDtEkkhh7?=
 =?us-ascii?Q?XJPnO3VMR+AcyXzPkJlg2rKbcIevf0byTmXQHBVLV+qqelIV5rErgh24OYzY?=
 =?us-ascii?Q?k2Pi5n9lg3V7VfCKTfmAZw3pgdescQDugVxukXjkZedbMuquGBEbTMNwMOuN?=
 =?us-ascii?Q?2v85kEQIjvDvzNkXQwwl3jnD/32N557KEgtyB+HkXUK7+KGFmyOGLWln3IDK?=
 =?us-ascii?Q?VTSpsqROUaZBmg9+9n93zsADbKV8LaJwlXSTAKhrz0VIU+DB8CtuAxyaN/YI?=
 =?us-ascii?Q?mMqFPXdTpaj2286mmxN4z6BJ0Z0kt/bZunBpd5yRNKMjsKYyrJStVydn4kz3?=
 =?us-ascii?Q?DaWz9kA9XDHG8zSO6gK4IYZXkQXOjDFtUrGcNdf7y53MV7+y+mqqliY1UK9y?=
 =?us-ascii?Q?F5/TEYrccEJog0l+Rwun42LaUXykWuyjM8KUQjQxMUx+2WrINfiUVWi3ArAV?=
 =?us-ascii?Q?Vnn+RCxlyyaNi2qalZWfqZQM7fNJhxmVCqlNFG/Y430xrjoZlv2aWY2QCvn+?=
 =?us-ascii?Q?CZWhOuIyG/l5GU0MxUUQjA2q7z/N5uUagNDJUKc5AehqQLt9QoVyItp1tWas?=
 =?us-ascii?Q?usXnOYgChOLVOiVuSE+TYsgdQb9cX95bDVPyHJ9wB5I9TYEvMkqVydiTvJtH?=
 =?us-ascii?Q?pU1nen/DGF/Rzj0IvzHxcBQmLNs6anNFAM8mPvgqJWDCW9/v6QNgZkm/ahrI?=
 =?us-ascii?Q?afIIkxfOVpRefut7R6+7NXHJEGc1fJqUOaprYu6V0+6YbqzS/Ms2DRb9K2gA?=
 =?us-ascii?Q?GZQDSIziB0A/PiFNYK/z+6kvJcQqbxuaTEXy0Wli7/K7I7U43U3/iV6RCOsG?=
 =?us-ascii?Q?MhwFhNjWjYhFHJsttxi2AOXu+IIODaYfCyFSGu2WP6/Jl5AcoTBrlM43CXDC?=
 =?us-ascii?Q?m6aJUCzFgOUOTZKws/BsM+TbIh9cZr7VhLvpXn5Yde4ApIL4G6+wXAZG6rJe?=
 =?us-ascii?Q?5CAFnsUseqhLydytlfFzMQuRJINCBqVSqJD7kcenBk7rHRpL5g5q8r/VS0/I?=
 =?us-ascii?Q?JgJK+nKbl1vgfvEc09XaY9lxwuCkhwI9rvNc5xDgEfiX/vIHCzVb7uk27U+O?=
 =?us-ascii?Q?huBPE3OG9rDnYtm/WOPxVNQlfY41nZVqfzFYcrwiwJKkC4Xcu1QH6qJKrWSi?=
 =?us-ascii?Q?IuNmaXmvHJYCqOEQ94aAQHxKm2wpFGszYYDd2rw/CLP9Nl6uBnEi0ffNBZ8V?=
 =?us-ascii?Q?CrXM5USNiTKfVg3gfLyrsdUVCNwuUf1gAqRJDTSroTxVwA34YmT3HiVZ31KQ?=
 =?us-ascii?Q?q2hhgOAdrLHlJR2JKU1EgPh1PE4FqUYPByXoYZtcgF83gPvS11uFqyk32ulH?=
 =?us-ascii?Q?Dy56X51NRhsiQNECldKhBi8WDjaevmw148iZwHpKBWQaklQNssOvMIqCgfX+?=
 =?us-ascii?Q?ub9m/og7HA=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 152e2e28-fedf-4472-fb09-08deb935aabb
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2026 01:42:08.4684
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: npJSCvHPRorFvxJ3ETllng+P0EAMs5wZhOcNuUG+Sw5YXJXuSmAd2zo4FQGgLYDWpaZNd+1byUwkB3zw7slRRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P123MB7231

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
Changes since v7 [1]:
 - Added an is_reserved boolean to the trace record to explicitly expose
   reserved pool starvation to userspace

 - Fixed TP_fast_assign to report the correct nr_reserved_tags depth
   when I/O schedulers utilise the reserved pool

Changes since v6 [2]:
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

Changes since v5 [3]:
 - Replaced this_cpu_inc() with raw_cpu_inc() within
   blk_mq_debugfs_inc_wait_tags(). This resolves a preemption warning
   triggered under CONFIG_DEBUG_PREEMPT=y, as the routine is invoked from a
   preemptible context immediately prior to io_schedule(). This adjustment
   deliberately prioritises the reduction of execution overhead over
   absolute statistical precision for this diagnostic interface.

Changes since v4 [4]:
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

Changes since v3 [5]:
 - Transitioned tracking architecture from shared atomic_t variables to
   dynamically allocated per-CPU counters to resolve cache line bouncing
   (Bart Van Assche)

Changes since v2 [6]:
 - Added "Reviewed-by:" and "Tested-by:" tags for patch 1

 - Evaluate is_sched_tag directly within TP_fast_assign (Steven Rostedt)

 - Introduced atomic counters via debugfs

Changes since v1 [7]:
 - Improved the description of the trace point (Damien Le Moal)

 - Removed the redundant "active requests" (Laurence Oberman)

 - Introduced pool-specific starvation tracking

[1]: https://lore.kernel.org/lkml/20260523200942.587199-1-atomlin@atomlin.com/
[2]: https://lore.kernel.org/lkml/20260517213614.350367-1-atomlin@atomlin.com/
[3]: https://lore.kernel.org/lkml/20260427020142.358912-1-atomlin@atomlin.com/
[4]: https://lore.kernel.org/lkml/20260419023036.1419514-1-atomlin@atomlin.com/
[5]: https://lore.kernel.org/lkml/20260319221956.332770-1-atomlin@atomlin.com/
[6]: https://lore.kernel.org/lkml/20260319015300.287653-1-atomlin@atomlin.com/
[7]: https://lore.kernel.org/lkml/20260317182835.258183-1-atomlin@atomlin.com/
---
 block/blk-mq-tag.c           |  6 ++++
 include/trace/events/block.h | 55 ++++++++++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+)

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
index 6aa79e2d799c..736e176f6d17 100644
--- a/include/trace/events/block.h
+++ b/include/trace/events/block.h
@@ -226,6 +226,61 @@ DECLARE_EVENT_CLASS(block_rq,
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
+			__entry->nr_tags = is_sched_tag ?
+					   hctx->sched_tags->nr_tags :
+					   hctx->tags->nr_tags;
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

