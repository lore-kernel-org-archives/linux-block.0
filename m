Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021121.outbound.protection.outlook.com [52.101.95.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E402DECA1;
	Tue, 17 Mar 2026 18:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773772126; cv=fail; b=FHR6qeRULYqVN8m+0ZnaQtDjlQ2I7gKx+wdFSWPLYoV93QoWnHF9E2hAEOTiRqvkalknkgGBXR4+lqmldcif/i9aZ+WoUKh1ZUmhY0BtbL7Ao439R6E/WQ3B/7dhJf7z/XO08w4JPorCdsxy97U0+uUbflhR/WukmIgGJs8uN1o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773772126; c=relaxed/simple;
	bh=qAMJmqGHea/X9HiUeC3z+to4wOPqDBKH/zwQBTNSKdE=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=WYCQm0TSnWshf8OontW9mugsCVc3hV7rnmiStAd01kEO2+3Z9mM8O4GYTzP0rEYn7ckdbPI7P/52vNRWTJtGyUjTA8p4ac15FhGJmSFx3w1jN3/pj9hAxEreJ3Ozrgku6AtAbTUBi4r66TdWQMrlBzuRw7OunSnzQmOIs233BPg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.95.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IYApiKn6l9IgjXsHwF17vXOC3x/ozh4nslEQzgHDbYlR9VdQ1Inc46mBJZCDbSc9ujbWvDbnaIYC38NVqHKUn/ggaDXdMJd2jMhbVvr8P6NomGvQrQJ9dDctZiJXbF6WY8TrLqYHa/X2lXNfUPFKGPIjvOfO+1ZfXU7CZ1tPlyf/DE53LUEAInx5cDML9EktHgV3WJ65xK1vnf5azvvxjWclZqjSRz185JopOf0ngZ3G8HLE6lSxhUasqLfAbKKIx2HgEchTdVHtOwN80iVDYXDyVvtHxv+glasYZA24Kls6RqHdxu+Jlxx3S1t1eaj2xkvgN0zPVdYM0p7p7OW06g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HPadHUGzoOg+N9Jh6gw4rC2zBPeamSuLGCrW0VD8vGk=;
 b=ZM45gZN4av8LJE1qd9jnX1txiapxUd5koajh46MbLPk5iSIf5VGB2r5Zuyr4HEJ7WZuVzKjRLskb6AFh3jTJCXbAGe5hFjzc1cKlbkx5MbOLgyBV1WL/NyAyMlhy0hOqCfjz4BAxszawOD3X6DWFFxGvgfAGvqeeMfDoqujQQgNzfml+YjhfDSknhB6YyUAEwwTyKCei+zdm069Jdqa/k/T5e53d4BIc0omUb3SSklyekLzksvPOGiTahlpK5L4TSQAmwgxaLcc7YhxXLVjQLlLueTQKRD4FzRo2I3cvrqFUm+F++loAWLLHWNn0ebyR30NPztnaRPuBgBdxdDW72Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by CW1P123MB8375.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:25d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.27; Tue, 17 Mar
 2026 18:28:16 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%2]) with mapi id 15.20.9700.024; Tue, 17 Mar 2026
 18:28:41 +0000
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
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH] blk-mq: add tracepoint block_rq_tag_wait
Date: Tue, 17 Mar 2026 14:28:35 -0400
Message-ID: <20260317182835.258183-1-atomlin@atomlin.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7P220CA0119.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:32d::6) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|CW1P123MB8375:EE_
X-MS-Office365-Filtering-Correlation-Id: 9691d46d-0b32-4afd-2d33-08de84530369
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	g1I098bajUR8s4mfKENUav7twdUjD/mop8oWyrZLrWWRuxfTakslv3sh/8EDXuWIiusgJWpX4ku86+f/zLbq/rukoQixJh/3y688K5FTuUJ8918mH6K838frA5LWahs6fZ/vX6eZsSAm5jaZk839Pzoi0GNle+rHgVYSgvyJWAZPTRsnQnhN3VIZaEcL1fXE19QJeGPd1Z/1U8tJTMYURCSFf5JuS5U8jDamV6I317ZWTmtbPotp56sUh9AJE0h00iMZlrifzjN8q5UsaI9/W7oMwCl49AhqdoNdZtgCV6tgu1mEbalIoLbdCACoTMX8dxWlGkUmyOMvTZLsfhgoSUmkb+VqeE6voIdOQ1pYEiAQUcCP9HTszho6Z7T0nnaBRXUp5bjYRTWBbh3TvLRQv+1Sy3nPLTYyFRaDf6ZkOhGSXJRC80qYHH4+ABrTOtwHqtMAmMwh9vM/sePlyZSRTHG4ZlWfPOLR3LmP7rJF8IETVdRPxWSTH2Au39aiUj5u4CC+/jp+Hdsy1XQZIcvv8xMfTy7m8CVej4GWiGAj9/AyAnmhzF8C2AMCrLXoPE7uriF/DFKBmQ2uab2MYROKmGc3Ghc3tsaI0P1CFNl2DVl94jWhgQfXWsepUGMXZ+damGvOAMpeg69xyM/mvW9X7gQ/2Yo5v3boOj8wQk1wdlOkXiTcDUZk5mnIgAhG7oR5MshHhR5voN+qLAZSZzq3G8IXedOiS55LVOU9obZkq6Y=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(18002099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sg9ky6IVQR5fy6KvMBFqdZCcbV9VwtzQ8GtxzH/eNPAYsO+b096bZA8LGmgc?=
 =?us-ascii?Q?LXQPakKw6eykP82Yxub6lRkVznIJYHotPATRDXMriatZbEGNVu6MVumz/105?=
 =?us-ascii?Q?rZfVXKbamWrKL0hco/JZe8r15RvWNAsA4DwH+bggRIjEhzyuKNkN+1kF/jWZ?=
 =?us-ascii?Q?46UI6ZYNvMbu7rbfi7g6JPXAPuMPBQmXSqwDQ6r12EbQyuafu64kO33KIcTj?=
 =?us-ascii?Q?H5IHhrsrrw4fV8jX9BTRNbPhV6ZiXupTqiw3Jy3olmMHvwGBfV6vOMTkEBYW?=
 =?us-ascii?Q?Xqx3fPpgKVWhKr4OVqckhPH9/O6F0o8/055YGWp7toP+3ek7+GQzEzJvK3IX?=
 =?us-ascii?Q?t27z26/lUCta09syTdMuyAsRN53UeC1jYG5SjdUb4vnuVIIUUkCh3VXPRMGF?=
 =?us-ascii?Q?QKwZOzl6JLVc/zd9KpCUCZ7K8hiCXQxvtUUZhUBjzyc4H9d0fC7Uniuudg/4?=
 =?us-ascii?Q?1hZprVNWiqa8tVP7p7QO6VzdZLPEs+xdHHJWy76337eh2htLJYoNUGbdASav?=
 =?us-ascii?Q?fH+vEngURFpIUdHX0lLJ+NtiqApERYN7I00PgQjYru177k+04+xhlSEdVdnz?=
 =?us-ascii?Q?aTv02PK4VTFFpCaHms8i8yFYQXW/FqSq7zoSPk6kbhS5G21YB7CIqahy4Axv?=
 =?us-ascii?Q?aLBbF7I7I1wQNDZJDMA6ey5qVsyD/UXWnaJs3HZKKqWNwQUW60GJmFKu/mGB?=
 =?us-ascii?Q?IsbSEjQTBLs8+4SKJxb/jhU+td35CL/5t4aIf1Nga5bW4KQLXDixN0nJQyxD?=
 =?us-ascii?Q?nk6wlkx3qq52iZThVtOz9siX+HdRlTnu3ZcW09a90a3rcvWi3LGN2SsilaDr?=
 =?us-ascii?Q?RnPo6ryMGPYCj/kpmv7ey+g/YY6ZomMTto4/al3WwOFxeJOcL4K/RzI2u3wa?=
 =?us-ascii?Q?qMTwR8I4KM9ahL7KqtlE9Zoqi7fPbQcGxHsqnD2iAH+/Q5eOjFV38UTTltHo?=
 =?us-ascii?Q?YWFH9vBKb5q4EdV/hGIuiQI9u6YipBq+Jdv4D3chhwe47s06o+05U3JzGQh4?=
 =?us-ascii?Q?ovFURktAWXBIV97RnJjXM9s4Fpi2JVFqvrW+g/akTvOQR6G8QqP8uoBERL0+?=
 =?us-ascii?Q?wOLJexUz5BlP/b4PgcBnSK0/aDy01uGM9ImASKcldy+GiKyciA5YPBpXQjVu?=
 =?us-ascii?Q?3rl1puegf73jc9m+wNK2QcaNV+CRdkROIUjIAn52ZYpWkY6aiPgiLEfj7dka?=
 =?us-ascii?Q?DoPWuvQWQ1Kkk8qweoQsPVgrWKGQewpXmV3kwksGNG6GaBFQ+tDQO2bKfcMi?=
 =?us-ascii?Q?i3v3QMRfTFWdg5+F9BCPeINcsq1HItcrWY0/Ui2tG9gs8D1xe2W4tJiVNHIj?=
 =?us-ascii?Q?JFPhsNd3X5+i6ZgGlclxAP+MP8z4i53GeUT+p2R4Nzf/B2z+w3BcLSMcnTRV?=
 =?us-ascii?Q?Sf4o3YQVYxPgdvT9b9BuCF4O16WkkIfS2raqcRJ/qgzIpeWXzhZq9eJsNmPj?=
 =?us-ascii?Q?7W3dFgBY++bQWZIWOpFOZB5OEPrwadrB0bMRp08GDn5p86XJDS4sVVcGKAXI?=
 =?us-ascii?Q?sBIDdxykwphw44Zk1ZK7t0KPM17RB19kRwCP4K03l2z4awtlESjvMucBhQ6/?=
 =?us-ascii?Q?cnij7G58tbLd4CbbkVDDIAs0C4HJvq55xUgbLgYXm4YzMRXSbB7DVzwbjMjw?=
 =?us-ascii?Q?UCXvRAe8i8fm8gi7HttHkzjbJQj8lPUYJEoc7OjzLh+Rfs8wF/eIJcJfBw1O?=
 =?us-ascii?Q?s5w4cpSKCIyHnbn3URpTPwPYSV8vJyJuWk3KDR3YCs1JRPXyW9ktrR3/hB0j?=
 =?us-ascii?Q?mvj4X/MyVw=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9691d46d-0b32-4afd-2d33-08de84530369
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 18:28:41.1562
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c0taom1E4jS8wi106ju/4BXeecjlbqsgP+9zN4X/3/I29GsWb7t717svFOVOeopzjaluNw+taqSiFuLOg90F+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CW1P123MB8375

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

This patch introduces the block_rq_tag_wait static tracepoint in
the tag allocation slow-path. It triggers immediately before the
thread yields the CPU, exposing the exact hardware context (hctx)
that is starved, the total pool size, and the current active request
count.

This provides storage engineers and performance monitoring agents
with a zero-configuration, low-overhead mechanism to definitively
identify shared-tag bottlenecks and tune I/O schedulers or cgroup
throttling accordingly.

Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 block/blk-mq-tag.c           |  3 +++
 include/trace/events/block.h | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 33946cdb5716..f50993e86ca5 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -13,6 +13,7 @@
 #include <linux/kmemleak.h>
 
 #include <linux/delay.h>
+#include <trace/events/block.h>
 #include "blk.h"
 #include "blk-mq.h"
 #include "blk-mq-sched.h"
@@ -187,6 +188,8 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
 		if (tag != BLK_MQ_NO_TAG)
 			break;
 
+		trace_block_rq_tag_wait(data->q, data->hctx);
+
 		bt_prev = bt;
 		io_schedule();
 
diff --git a/include/trace/events/block.h b/include/trace/events/block.h
index 6aa79e2d799c..48e2ba433c87 100644
--- a/include/trace/events/block.h
+++ b/include/trace/events/block.h
@@ -226,6 +226,42 @@ DECLARE_EVENT_CLASS(block_rq,
 		  IOPRIO_PRIO_LEVEL(__entry->ioprio), __entry->comm)
 );
 
+/**
+ * block_rq_tag_wait - triggered when an I/O request is starved of a tag
+ * @q: queue containing the request
+ * @hctx: hardware context (queue) experiencing starvation
+ *
+ * Called immediately before the submitting thread is forced to block due
+ * to the exhaustion of available hardware tags. This tracepoint indicates
+ * that the thread will be placed into an uninterruptible state via
+ * io_schedule() until an active block I/O operation completes and
+ * relinquishes its assigned tag.
+ */
+TRACE_EVENT(block_rq_tag_wait,
+
+	TP_PROTO(struct request_queue *q, struct blk_mq_hw_ctx *hctx),
+
+	TP_ARGS(q, hctx),
+
+	TP_STRUCT__entry(
+		__field( dev_t,		dev			)
+		__field( u32,		hctx_id			)
+		__field( u32,		nr_tags			)
+		__field( u32,		active_requests		)
+	),
+
+	TP_fast_assign(
+		__entry->dev		  = q->disk ? disk_devt(q->disk) : 0;
+		__entry->hctx_id	  = hctx ? hctx->queue_num : 0;
+		__entry->nr_tags	  = hctx && hctx->tags ? hctx->tags->nr_tags : 0;
+		__entry->active_requests  = hctx ? atomic_read(&hctx->nr_active) : 0;
+	),
+
+	TP_printk("%d,%d hctx=%u starved (active=%u/%u)",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		  __entry->hctx_id, __entry->active_requests, __entry->nr_tags)
+);
+
 /**
  * block_rq_insert - insert block operation request into queue
  * @rq: block IO operation request
-- 
2.51.0

