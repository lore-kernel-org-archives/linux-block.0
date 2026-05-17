Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022137.outbound.protection.outlook.com [52.101.96.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D0230F957;
	Sun, 17 May 2026 21:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779053784; cv=fail; b=Ezsvw1H5Cs/1XV0dYP7aacwnh18otLesGN+Hv5lAgU47+SJyXSKMayzzv/F8KhmDdSQ0+OXDg/x3h0xDhUlI0dhkOtptF8SPii8EcSO4sucClXyx1jMFvJKKHY+Ogt1GqN76hPoIdRTehFKF7rKPvBFRy4CvpmP4Z1LwGTgmQ4A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779053784; c=relaxed/simple;
	bh=d4IDGJTgun62WaE//UBvF6pWiJ/RVgCjTg554i773Wg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BeYpD0NVC3kv+YEVN16e2l0kwDWXeGMlC4Def148blGx5Zzx13xJqGVD6yb38MqC8rmf4DBSUPguLLclBy2grgBhZ6E8xb2KH2b+pDxEj64ezXdqYLEWXdHz2PikKuIVoY1hBhIfd2wEHadyyS/+evu0anDeZxTCffT8zI5/TcQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.96.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LMsVpS3b55MXF/weM0sOw9GSkhwc+TeD7pGudrho+2QZEGFH5DQWIVD1HpC3tyn/oHzFdS6JXD6PRCGq+77rcwFwD63aKCtqGIaVmSXVD/j+18izqmR+Ey8fTku48HIYHtDwtqDXdKrOkUchJs+BLchjl1l94nmGENddMV83hR+K+zPd1mtHyts1M+BBgz5g7EoLjmG6AOxRwhCQCGo2ZLvLb1bQIRVwusGgb7+dult5C37SczqUHqwpwBbZpM9GphmH5J7oB1oENsGfPHhn3jWfoW+A6sojcjLCM6IZ3wcwvJEeLC7fCrdCPWtXs8FGCS2M+oQsOlGcR+c98XK/VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wJojEypOHlwVxdt/rTFsEyZW/Hazdx6k1aBOi8w7jQQ=;
 b=W/elUtUplSloMIXlNuueCJ10N0lvscsBQxKQ3MZtFapZrWSsDntVIhpk67qsjaw5hZOUmdjgck/Vma0DXL2uhYw73dF+AlZAmFsh3qMvzeC2vBnmI5UAvBtNY6S3VtWcrzG68qstc/tiaQruO84xHcDmzzFr86YGL7AeC8QK5tefjqVoV9va4yLe8HIBr8pUNb3E3/Lb/1UkZgnHwrlcHiJ1yrHyLiKZ8pNvwnv4iHQpVYEKd+mCXFsmOizPBLhZLIWj5HbDYaHuS5TeJT2BCu7BSlJflC3LltgDPFb8+qwrvtAPcsOdZfnYP48VvYlG83lpWV3dMgOE+f/S9KgcYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by CWLP123MB7236.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:1f7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Sun, 17 May
 2026 21:36:20 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%2]) with mapi id 15.20.9846.025; Sun, 17 May 2026
 21:36:20 +0000
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
Subject: [PATCH v6 1/2] blk-mq: add tracepoint block_rq_tag_wait
Date: Sun, 17 May 2026 17:36:13 -0400
Message-ID: <20260517213614.350367-2-atomlin@atomlin.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260517213614.350367-1-atomlin@atomlin.com>
References: <20260517213614.350367-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR04CA0154.namprd04.prod.outlook.com
 (2603:10b6:408:eb::9) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|CWLP123MB7236:EE_
X-MS-Office365-Filtering-Correlation-Id: 05e774a9-2917-470f-2546-08deb45c560d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	CtGwdQUm7vCwbWxmZpA8CwuDbZs7B11I/6OdT89HJGuoyQxRqjMWrfyafHxVaR5ERmmm5pJfCVoxJrVz9sZ0YHQUbldD6n/CtcnRK3Lv+kb7C53nhWZKfanU0Ba+8c2ap9KeP71H4vSMoO8wwNzKqaRZTMMx9XkDUtd3FsCufFy1Kau/mA1YTBNiV1OxG2c7uKW3dEuWoEkKflUpE7bfPFNWMncncWTuByU801LFStvFKzzO0LuS2qbDeeumB0yfdVL7zSyPgqtpc9bRAuvDBD7zJEMDZm2hO6EzdyB1jEObtJH44EyczuEVydBA3RI9yw5i0stTZeWoa+DHHvppMEHGy9fv5OwzdI0bz7fa7LE1bqsKds58L7SxO7KyQtvdrxE/66ckp1Ax4iMFbMBPo3zMn3JH6baq+wgIB73Q/3Of9T4xG0kh8Jy+7coD0t3Ag2yVqu8A0h/m56p6Bs2C/rlghWcFRTXOxIo3Oy8WydThZNjCmz9EbonYTpANcwwh8Re3BhJRYrLSATqaiSNn6QSwGWGj+G+4OiuGgocvoo3xN7HyeaAfK9uHSyaaPohmvgWm40t5y+eZf6FOwJE/B+c3kcKoNqi9DmQgxS6xVOEzz7ywXC0Te0/SsJl0OeclDbKz2LSIJwqpcOaean2jLfp2PZvggVPMJPY1SDfyIfCgfNIdTkr97JNnTzBcfHkb
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qObFbGRDRvuo/ZPHKuZMKiMtKRif0P9t81B/9D6MbFpLSxR1E8Dt3IjrmCG7?=
 =?us-ascii?Q?ZxAds+hnzx/jbqbXkrrt9HA0Jf+iZFSzcauThQ/6fKaX70KNaQlVFiUDGsj0?=
 =?us-ascii?Q?IGTV5AJYKNvrxWtb+E0mV+aZKH5XvNEKTMtyzIxjKTi3jMEWRyS3de8+xPlE?=
 =?us-ascii?Q?pkiuWIzg55ahRtxBuSegeKgcQyEX3bKmW+/LUuHyyFKBhAq+JfjHaNHHnKkd?=
 =?us-ascii?Q?vbi7+ERVUBEeo1vI8AsPxYNUvP9+PeLQpA82x6ASgI0LhusrkrNuobkHJQcP?=
 =?us-ascii?Q?VVn41tOrjszvGUqBdgbnk2Hj6rJIDRaII+KsBu68ZNN5HKlgS6Y1YyozaocK?=
 =?us-ascii?Q?XMaqB0ErPrVvn33cCYb4uVBLcMWRgsBud6JkdssgwJLl5cMiXF1gWITJJrsA?=
 =?us-ascii?Q?HC7j32pFdFsT38zN2KeKCriyQ46b539MSTIC7Sr6nMCY6QmukSku9rvCZi+f?=
 =?us-ascii?Q?fJDFagMnfy9wclbrJmiJmJtzt5rJ4nyiynM62N6O6Qi4Aj8pwrlEtNTOw/LL?=
 =?us-ascii?Q?O2Ccss3caqxPc8qo5Nl79Th9hMvyhsNUE6kCxvlwRpsfbgucXPavB30ag8Hh?=
 =?us-ascii?Q?xTBcOG2tTVzPvXU7Ji2qu8B4fAr4mzgTHOUqPkPRbV8nFgK5BmfiS/e+ZdaW?=
 =?us-ascii?Q?GCHzrGHnYbSHkUNmXXhwLxy9sOuYBFXaOb+90hiL0a2+d9cES4my3Wc93D9I?=
 =?us-ascii?Q?6bWKuSIT16eclAZmNiieoLnf+/reNf0CsHDv7fBKaearqFZqLBpkN3KkfxeM?=
 =?us-ascii?Q?n3Cu9iMD3GAvWHdBqqa7P9mhCtyWQsLlSthHwCE3xFbCfFSiNL9Lrx0BwLEy?=
 =?us-ascii?Q?DSerYpOCuIDZTr2Ff1cSGQhM86DkdOb0GwWzyXW6FaN7S9Hhz3xreReDfSbz?=
 =?us-ascii?Q?lwv1g301CmogIo3Qrw237Eim5qOQjtdIVyWscYR6KQs7VMCVAFIRNDg+Ptcx?=
 =?us-ascii?Q?Z2yoWa2uG+l2pPxIpDiDSELYto8vqQdZiEqO8fOuWm/lc/n2rZGb8Nk9+dl6?=
 =?us-ascii?Q?MNLyuKo+Od+GQsFVPFlazVq23uuwIfhXyv9EADID1ELtgw7vyke51IWx0jEc?=
 =?us-ascii?Q?/nsBt0uGEL+eJXdWXm7gf8RbWoTSKQokgl5t/ykfLq/f+Qdy79MVn4WNItym?=
 =?us-ascii?Q?UsR78PhwWEW0NyffI2zT3RvE3c74/EUmMymXlCwEgxw9we8+c/unhxfBFEnd?=
 =?us-ascii?Q?te9WZD4wxr6okRh4PjfKLR7uABCNFeKTnGEbmnoLg3VE4/QRpO/iMVtGHtNj?=
 =?us-ascii?Q?wLRFYg6H+pLwHFkSXRozosPrv2mvoukMXoGYDn5Gw+N2U4V95mdmZ0Dfb0gd?=
 =?us-ascii?Q?AhNAVmsA9SfmOv1UbGsmUXU7HU8YoCtj2LN8+Ird7FujPLklHOlzFKGoc5Uc?=
 =?us-ascii?Q?GQd+kcfikuqvom6QqRZUz4YzojmWeeQampUkB2ezvOqwykl2D3+zYcdKSxAT?=
 =?us-ascii?Q?TFx6G0TXyPLn7GksN0lW07kqPE3ktlSfiim7u3kdpC7hb7Haw9f6LwgYIajF?=
 =?us-ascii?Q?u1e8ziLh4YGyj7cARSMFD7A/pCFXT4/rGl6ZLCCH9hh5bnkrSGWu1Xu37tx5?=
 =?us-ascii?Q?1YpR1ozfunIXN+FEDLdu78fa4xwCRumZX+gmHfkewZadCxTvv6VEHHLyAeCm?=
 =?us-ascii?Q?Ze7S9VutOxRdh0bY5LMbl0nju/tmiyxyexILIdmUEPvkWAFYFhlDSbLn8nbj?=
 =?us-ascii?Q?kZjcp8tX9JFk/T2AO9SSQhYwOf5ACbWoFGNicGQFf57L7eOYIj7xKNnmdirw?=
 =?us-ascii?Q?JTOA8etuag=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05e774a9-2917-470f-2546-08deb45c560d
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2026 21:36:20.7933
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N17l0agDkB99jk4hs4E0E7vfRb19If+0zg9+cdD6HNkZvDhJtQOQMJdLX/rCPLKxSu39gTldCKrQaj2NZT1Ogg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP123MB7236

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
index 6aa79e2d799c..d6b9a6bc3c63 100644
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
+		__entry->dev		= q->disk ? disk_devt(q->disk) : 0;
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

