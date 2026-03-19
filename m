Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022105.outbound.protection.outlook.com [52.101.96.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05363806A3;
	Thu, 19 Mar 2026 22:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773958813; cv=fail; b=Y8jPJNohhQYtIe7PJFFseZIqtjcaH+yNCctr/JELK1WCuTKtGXqpUkvQzxiWfZUl8cMcGgKLnX+u4hRNOGeK2utZvnvRl7Gk7xk4H6C/Zkzt5qqWCV/juwuMS2AvQ8DRQfN3GCXlHMftgzFAXO+36SuaJxBc95Y06kcFyC8RaiM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773958813; c=relaxed/simple;
	bh=DcUMG/mFHiJSMbnOo8LHGCIX2Rj6v2bHaQYibl8DHgU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uRLP62QANajM3xhLaBYaX+qalSTDfdMC2mG/5Wc1KcsVb+ogDPMHDOXT4mQh5RGxsNGrX97UVIK5vLyPelvWlaB7ZcCaD+blVqvrX/D/vJI6X+gNTKtp8bKyhBckvdkb0OFOKPXSnGDhq+F5bffScnvLjbInMO1G1UL+1PU+iBE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.96.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UlpEFzVTOy7YunfcFTXHejHqbxGwqApNkk6/V4vG8Pf6U8phGT9OL03acBfJXnn7sG1DsVYUHdPfAoP1CQ/xA0lgcNKSvt3kzmcjPV/S0Q7xOo2bIzH650KDv8QEiHWU+LssEiQbQ7oGy7mVtMtONEKTLNOAEsEEMohS8QKURkFbugCDcvrfo1UjAFJHD10s41KGQ6m8A6qSioLpQtAjjEhippxkuV5TLhzvneczwqRrs1Pbd8Py7Tp08yO7r40ep/RW4/Z3kZrEzwvFT1/uIvyvFGEJSSRzR/W+0QhPr6Es6Gv42nJ+/o/3YvdsJjQ/38OZ9moxUCWjr7k8aunomw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A708yZEe1c1rgOksMrwGYIzKsIR0+YQekVfsQwvvwFk=;
 b=uK4JJ02WHJ8Cu6uPRWWqvfJs5YrFeRi9wtqiEPh67djDHPQScxQlvpGtjyXmnDQKiAaGBRmxPo3WyjME30QRhMcwEs+O3v+pybv+fVESMRgwMgF6NgNbtpQtiGK3KX1Q/AxWJBXYrmE8Cvzf1zl9fKtn02Ob4hNqunS1XcANqwM0GWbxaEQl8KWaIGLkVUaqfmcle1GiYHTC8fqh85Fa4N8lQxnbQX1zATN68QV7+B8y/j3Byzsnyy0fMC5wMTJlmPhLKop5Dyxg22iN87DQRKSfXmxSoMXpwHZ+FnZc3E/fa/d+/1nRUnrtnT7THKFQQqtp+hztYv0uz7w5RGaEaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by LO4P123MB6712.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:2e2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.22; Thu, 19 Mar
 2026 22:20:06 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%2]) with mapi id 15.20.9723.018; Thu, 19 Mar 2026
 22:20:07 +0000
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
	loberman@redhat.com,
	neelx@suse.com,
	sean@ashe.io,
	mproche@gmail.com,
	chjohnst@gmail.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] blk-mq: add tracepoint block_rq_tag_wait
Date: Thu, 19 Mar 2026 18:19:55 -0400
Message-ID: <20260319221956.332770-2-atomlin@atomlin.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260319221956.332770-1-atomlin@atomlin.com>
References: <20260319221956.332770-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7PR17CA0003.namprd17.prod.outlook.com
 (2603:10b6:510:324::23) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|LO4P123MB6712:EE_
X-MS-Office365-Filtering-Correlation-Id: f10967d6-016b-449f-e05a-08de8605ad06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	mcxPELL6ngFXNa7IUiq+WtsYi9q8Ssj4x8Xe2F92DOp4EMe+uc2m2Gujqkho5/5YynnelfghRzN8MzPqI7RjVncoVrolpI/F+zbYVSIyvazKeWTEtNTIiGoXMevITYhT+PFoC9I9zQjPFNrTXLOr7atBnf0trIhTp/fB27S7AGvY7L8a6tz+Qp/sdZkIqkt4A0LgiDC/1NWteiqzA7PCswMZ0M3UWH2QwWt5lbPuP54hUahDp+y6PqGd4VmeBfHCJA3172JDJEF5aohLvAPci5Ge8UlH3KS2OVoOBEek2fO4xkL+KaenXNooI/xNpoq2BoW+EA4bLyXVAntMPEtgvLX211nsKl0UBfKlQdsQj307+rD4x8tdORHhhpg0pLebrUSdxqIRh+13YaEXQQ4T7SFiRbRbAJUnbqc+1wDGID57AFm8cofrPoz1+eF27VPoVm+dk8KIMSvlCtMJG2BpU164c8Bl5aQavRK4/V2Qiw7hne9QC2Sv9WJh54XDxMS5WkYxkogjNl3x/T+PMhvsxXxsRo5XpO8aHOfs6pcwwE/9hqX0pBBwB5aqPJi/8mXfeTI5vl1eHM+QUMSoWjwrundo7ahcJN3PLs+GJl46EDIHS1k+9Kclw1xHcB1awcnHS878G1Gzlpv7TojstontwXtt2zH2QvBL9BXzuT+4Ms25BdhRqmdlFM7gg+J3MqYjJVE2notmez3MQxGgHGuvZFarOM8qYDBd0Z1MTRe+nFQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ToQOPpcCY9A64HOHRivgfoRscB7QVW/1BF2D1uwhrfB7/VqV8yg89o9nY/Zd?=
 =?us-ascii?Q?gwOfUn5fz7fPBgx642m6T27Mhuy7/B3ef7qu7dZ+6CPOcOKRlwWGayJj3FA+?=
 =?us-ascii?Q?c4sLkIwycDDMO0sFbo2kOhTr4fxepZzUKVzOz2t41SmsA+4W1hwqcgHfG7Da?=
 =?us-ascii?Q?6b2bkS2m52gPAvWx8Qo+Y2VYWabvFlaJkPn6UOTnwMVBcKjnEDmiVaXWUOdT?=
 =?us-ascii?Q?X8Q3g+a4IVsw8XYI1LpMBgo9V7zXCAWi35XY9eZYqLBOtMFfGO5aNSi5/N+0?=
 =?us-ascii?Q?wfxIiRNSYC0dZ6Mmrbl4FkFjvi7/vo355hZ5sJCgOGw0/nQ5wScVFPAvfdq2?=
 =?us-ascii?Q?hVw/PiBDqjJWef9kspn1ZlQ/qaWDv5jwT5rVBd89xKcEQJeyzsHl7X1UWsCk?=
 =?us-ascii?Q?VxsgfQlbJwJVo2CixiuD4yVTZjuK3QL1kIoTcz+98bX0MZSSd98aIrTOJrt5?=
 =?us-ascii?Q?TDxcx7fvzD2ZAWhVWW+AMQMX9vC/01W0iKrNE4SIcCSAHQUXIcIqRMYGzIBl?=
 =?us-ascii?Q?l0DNgCz5dPVMnKo7OZBFDdYp3BAtNQ8b38n2r+Ax2JEYTfinIcG3U4dka4+I?=
 =?us-ascii?Q?S5pJPq9Jqx9aoX4U2F2Bg0Es7NPbgG2h+OQ7AZWQ2y0zzZBxL1dcVy5B4o7U?=
 =?us-ascii?Q?dsLnxmeyVoQWU7gBsHfdRMX/sWOsR3qTUuHJfP8bnVTby82+K0lEGlSnEGBi?=
 =?us-ascii?Q?mmrpazfdbev4AT8Quxnipc66H6FzonX0gVZ+sh1t86sCAjTM4QDPvN6MfJTv?=
 =?us-ascii?Q?RMrHwwfSovPV9dzYaju/8CmgJSm5xnd0esX3DOsZ/WL/LoqjGmWMrlmO+8X8?=
 =?us-ascii?Q?WicaaKpXyQ8mYLuLxy+wBC3vgAu9ajqUYA/XByLD4JZxdwBubaWoNv7KAr43?=
 =?us-ascii?Q?sW3364RjOnCcfBjHk2AGsIATCmdvZ5R2zOdBaWA2WvLngxPNrbt06GQZWaGc?=
 =?us-ascii?Q?xNP+Yn8ZmgCiysfN655sm3Xg42PGUF1FK1ehJVsnfays2zW8dCZaGNGvsqsB?=
 =?us-ascii?Q?6cDHKf6aHS4+SdroRiVFvhM4LpxOpbYwHJIXrSOMZ6HoTAoMHOuidtQ3Yoeb?=
 =?us-ascii?Q?/OIvxQNDKPT2bmLSw11SbAEN+Dgn8g+Xfu8E4+hlIvTPnKdxPirTTL/j78kJ?=
 =?us-ascii?Q?EIyv5Cu7B6wmFFeorr8wZJOVsiVBA56hWxn9pPnLBwEeJ8U9j6Yi7ORWlBk9?=
 =?us-ascii?Q?W9PDVusQIaCqhe7MZWPuC5taFjuDuQbHa2fnMTMIyDeUmd868XrVYLI8LGah?=
 =?us-ascii?Q?Mh8GTlYmyMES0ZNBWCiuaXRETiBuG96+bMLhdyDEPWTkgfWIVVKhwNzc68QU?=
 =?us-ascii?Q?IHnQsvV3WnVvAOCSWWAPzuD68nVxJ+ZK4PH4iOlnOaXHfKzL5e6+BYY0TF2n?=
 =?us-ascii?Q?EXzTKS7Kc3JPJJghxjUeUalAReffRVtjR3ttl/D1M6HH7ZxZTQyLbOkjzNzO?=
 =?us-ascii?Q?LCP/Hm6jZKUW4MM81Zttt26nufnyZz+dTRVFAYdEU9Cv22eNu9a02V1iocig?=
 =?us-ascii?Q?lq7v7WvlO3yp5W5Q1Jae6YPj7dJfztbLcAVjIhi3EBX8v7EkwzHGP336X4Dt?=
 =?us-ascii?Q?OE3ZR/I+z709rppyzRfOxyqiIC/hXI9hJAvgBA+15rbKgIQ6FKIpz1LAAKYK?=
 =?us-ascii?Q?sdbl3YQS8LzV5D4mioaOrU1EpH9n/9HFM3YBqb5E1klk0PeeI+2Jfh/NqO9N?=
 =?us-ascii?Q?XeTRse4gUp1TlH9Pn4Rsws8CyMqVk+1Xk+aDB4l8kH/FnxgyN88XPdPuQOGX?=
 =?us-ascii?Q?lDWmO8L1sw=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f10967d6-016b-449f-e05a-08de8605ad06
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 22:20:07.0969
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z9hpfluLK/r2QKLj61r9J0W6R8q1e68QsTJ+6rZodF8fudQq0bMUed8fsTsZmNXgxt6/8CvC2sh7JJ4C3xe99w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P123MB6712

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

Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Laurence Oberman <loberman@redhat.com>
Tested-by: Laurence Oberman <loberman@redhat.com>
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
index 6aa79e2d799c..71554b94e4d0 100644
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

