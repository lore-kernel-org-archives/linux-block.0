Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020104.outbound.protection.outlook.com [52.101.196.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD149262FD0;
	Sun, 19 Apr 2026 02:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776565848; cv=fail; b=tbKHsarohtzSxhq1WeZ6ScuCfWdh2DSmFMRTNrLmKLlyut5niz8effcENWxU0EmWwowTHcLvQs0gFGmlEtPdFteuztZCf42pqLHGytEc50ZoFuasKfS0MM6/xSWpZcR8JFPCaFLWkpzcHXCx7+DilVpxc55Ipjk6SlgZpoc+C74=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776565848; c=relaxed/simple;
	bh=VUGXg0qr+d1A1JdCNeOSJHOPd3wtLZ7ieN5UEZ0OAP0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ljakZfeHC0BB+RgDu6Vz6hrJfIHnds9HxocNdsh9lovctSVhUcH7capBIMxQ8P2eSOB+rd+TxVZFayJL7rXDE5e+bsNB0jGlatM+dzERz4Pzl3ZY89xp5g6u00MIH8v5mq8atbAnfWWZUS5gN/GA9Jz9qLhWGbUADJTupNsSToQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.196.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Afr1mSETwm5A0tODuGpoTcq87aH0WTvD9Hc7ykKbjYxIyFEhysHLR4AXWMidjDsWhTG0ukur5qTUDFlOZ+waspSOnwSm4ZUtBx/JbTwxQMUyUPk5FaSiMnv54p1QW40ZwpzLhgp2a+8r4bk/RsDKT2fJ/MJtmUfGm+rm4xA89gSgi+lJD522MRtQm/FzM0TWS0HcLjRg1bjQWLhHjUDtAU2k8CM4JA2KHN4/KwHiO0OYD2e8zM4FvIbgq732dTFDUNZh0A1+NIEr3e2XaVkUlchyxemAUI21Hz0JPgibnLjuk7eEBAJfCe+gLBF9ITEHx/Zk5hLRNWwpCYEeK+rrBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L+QHXPLlanixVeDyvsPf8AI29xOirJeK0KqPbvmtv1s=;
 b=HU0BeSq0k2//anfU2AIbVUcrqKuLiJpSZkzwPPYBfnxci8JvnPEUtV6LZ/vVx7TdOw0lV0nJqi4on74ANXWo41fMO/x6mRiCCflTIqdg005c4OyTMdkqYhilry89LaYtEeqVKNvaVLGBTsYhdPWNfD/hlR7yGWWTJBJU2pCgS54gBevevEWX2gFV27b/kntuD3QSq0V/KRLRpdJyhw/qtEX0HPNZj61bpKkj0x/Ld+67XD9Bvj+x9Z5/JiLJgLdmBt2mFmfK4b4/9ypX6MWJI52hoOsvjRg5B461LRYLPpllbGUUUqTGTUBYBu6I3P4tWaF/s8MkGVhfEi0MV8xzPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by LO2P123MB5960.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:255::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.31; Sun, 19 Apr
 2026 02:30:44 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%2]) with mapi id 15.20.9769.046; Sun, 19 Apr 2026
 02:30:44 +0000
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
Subject: [PATCH v4 1/2] blk-mq: add tracepoint block_rq_tag_wait
Date: Sat, 18 Apr 2026 22:30:35 -0400
Message-ID: <20260419023036.1419514-2-atomlin@atomlin.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260419023036.1419514-1-atomlin@atomlin.com>
References: <20260419023036.1419514-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR02CA0049.namprd02.prod.outlook.com
 (2603:10b6:408:e5::24) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|LO2P123MB5960:EE_
X-MS-Office365-Filtering-Correlation-Id: 20f2f262-1e76-4835-47dd-08de9dbba88d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	Gkeb/9T90mgzJXnioDtCSl6ik4K9+Mjzp7/zx5k8ktYN6YqF8QLf7VXVPAYZ4AffhznQYqa0Okk1UkfJ9O4pMBo8EkUdBzs6Vulis7Nml96p9qRQSd2MPZubqiomBRz39sPctC70y15pCM5a/bItlVFxqjIpA4sTRFufrJTGjL+dw5uEZN+pOBgy/XDrm6m0126AhrFr4cINI5h9wQP94wSN/IjdpZjglrC5uckHUCJOMSo2J/kKkC1jar9Q/T3DWXuq/O7xza59qvKzGInDPzLnBP2y5oRnM1hEKV4m3b9W8sSWiRtvwe5NUzF+5+iv9dvQKbzi2t13IPY0p5mszMTsBMMWO1ejzxBjglX+NW0HvrN8vuWSukXePAfnSOz91XTGS0tVI+mrFTG2H0qjOEjrlKiAtYE82L6y34ffdSl/KSpHBYyqgb1lXcE97YD9k3NkWiaTe3hbdz/d+rUdJVqp0mZkdZ69dc5weUS0sqQgKPliIbKI49kNESacMzSUgYHYmrTBURA4TIlgYkv66e+9j8W9fwqnFjnw44n3S/gXlzQGxCqgnbNdQrUlw8HOBVzjlVds18EjNSZpHrUCbVeLUqveZyfVRBmU6vZBorUnqMg72tdJCuS9w2ZIJn/gLoG7UTDAClQO0BNeAJm8JbhhxSFdWu4pOOaOOaNQ/NAtLQM8+MDkrnjtw0nqxXhQs1soxaf8VOSQF5D2n2Viyr9fx0t5SnqzaQLLC0cpRPo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YN5H7PlS3hOoSqIUgd5OZcGeke2BaEnxC8n8YK4pki6/BdDOMY9kwY+ia+eM?=
 =?us-ascii?Q?71qvypY6L7+a4PGk6dJev46xW9hEiYwEKx4/3Zv8TKBkn3/nt/d3SFTCUNVx?=
 =?us-ascii?Q?iElwzN0meM2GSB+ojfJto1PTFYCZ6ELTdSXRMhkd3j2K7HssowXCOJ72rJDE?=
 =?us-ascii?Q?JFXfK9xvFSWmEYVNUYNHjudaFugWMkAWHZag4St0xVjXazkkB3hbCJIVuF7g?=
 =?us-ascii?Q?GXcIr46Tjypchek0ZmP+9nBJ20CXThxWalfqZAOYHYNCfEqn3uqdmu5MP12S?=
 =?us-ascii?Q?qjfO2C6vYES74ayhdNYhvJCoKPChLWl3zqBCOAaZ0iaijre0C8lyo39m1TXx?=
 =?us-ascii?Q?qkPRMIWTY1T2QJIqTf5Th3J/iLybiUfOF/zWCY3rhz5TuBl1TdJ7j5nFjlfq?=
 =?us-ascii?Q?9AUcan/2+SlfbAeD94mmOTbdv8toBGXRuw+OPOjRCjzauMuSebJeXsyCP/ds?=
 =?us-ascii?Q?yy2XHjuaausQnPJreot3eeoVenam6MJGSxGUThtypiA17YIbmcJnYvpVYhQ1?=
 =?us-ascii?Q?KtWZwNHYJxvog/hb3YEofPEZs9J4GTTM7G2Ox2scLJc4zlvVWg0GayOAarnC?=
 =?us-ascii?Q?eZNqUct/WBwpVb7NV1NpeZWvscOf20jaBK0/KTUZTbVcTYet4Y60PloEXboj?=
 =?us-ascii?Q?Ph4/wAjDE4Ky82zZcEY1aZo+UVckE3x9M9GE+XdK5T4AVXx8hTWk9Ii+9BVg?=
 =?us-ascii?Q?0rteFFGpclPVKVRE8DJEsNL4xGz334rNiQo1kn6pekNCrDPhViq/EMExpr1T?=
 =?us-ascii?Q?XYzhwD8N1K0Z5aHzrCCVTQDGi0LRzrLGEMdCk4qNSCcYSFJlUbQ5MBw4RecM?=
 =?us-ascii?Q?6fpe5AtBIH5DLLk6ElInnS6Y+NZfYrc8Pyv2RLj51nWmbxPM+X9RdVex1vLq?=
 =?us-ascii?Q?8QXdUMNPiExavYEiMcoA6V7y+BV7y03gS6/Q7bCWvDsr5YZIYHBKtRM8q/eF?=
 =?us-ascii?Q?KB4bX6ktJ/3JRcX1DOaJHYOItzwaxLYnE/6cJTpeEg52yEAsez8eXVxf+U+s?=
 =?us-ascii?Q?Q5XzpXjcmgtrZikiSaYpvqWeaOr7M/0pjcJfIHRnDGFfMT8Q3fAUD2uQKah+?=
 =?us-ascii?Q?vng3QPdxz96ouHQho916G2EKm7o51doCNpOBvkSrulIud9bqgx89RVgVsbP5?=
 =?us-ascii?Q?1B5+9uYw5oGeoW1tG120D+OyZSrvIduJt2GMW28NI2y/ylOfhyu5gZEh+/31?=
 =?us-ascii?Q?qLJybfe3pvPwWWp/4OcNBaAwJk7x4BpCnxWIKyZnOoLvLXV7A4uoEvx078dK?=
 =?us-ascii?Q?5Nifoz6gvr2TslPKq6KG5yCHnd+38Vqh04hzJdsKXYfEFwYSiiK15r8Va8e8?=
 =?us-ascii?Q?vZZFAS+RKzxkwlxwEJdKQw86zwSTDk8kIez8edfgEiypl0iPS8QIU2qBMwYI?=
 =?us-ascii?Q?OJ0jqT546qRCzHcWISglpCiN4+vCr3UVuOjOON8a/3AFz28bkK/oPIw0PLsC?=
 =?us-ascii?Q?d/kBZBwRnd7aCDXZY0RcKb75MUMyJw/GrQafVKvM8zzT/eGKsTTLetmDtc8d?=
 =?us-ascii?Q?2Np5meuFbI+D+FCU0aCvsxkMdpD97d5xaMx7E3ATpUvDWVBklB+9k0AC5cz4?=
 =?us-ascii?Q?GZ8uj0xv9ye9tRL4ZtlIsRVZoFroZCTKXtaVcEhHd24GWGuDKcmaz1RkWx2r?=
 =?us-ascii?Q?nJLr635FEXsUagdZ+8bKK018Un0htComvbQONGMHaelGgMX4OiZ/w6yPjQag?=
 =?us-ascii?Q?iPBWGPYgNVJ3PDZdNKdLmZlfC0x7wz5KusgzwPFurLT3HpXWrOV9dVMGFHaE?=
 =?us-ascii?Q?HTWuOAamMA=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20f2f262-1e76-4835-47dd-08de9dbba88d
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2026 02:30:44.7270
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WXZEUeML5HurVOrJ9Q6xsNcBU9GEMFxXkONT42xQkDz9N06anfiE6zF536yj5a9bNk+0l4hZkzjH5O98bil0pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P123MB5960

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

