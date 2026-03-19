Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022105.outbound.protection.outlook.com [52.101.96.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AFF2382289;
	Thu, 19 Mar 2026 22:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773958817; cv=fail; b=GiOhe6cpKddQCwWXgWR9Zp0Wknfjb9L4yUdNZNJpQdknvftAfL2iwcdauGH9H2EQEXPjjVi02UWu4M+DHobJKAqidS6BkiiX75ZKznreKCk/tGbdCLomtkLidmZ+P7bSGJ92dWOpK3IUNXv+4lLWXGDCbICW7lrCZY7+NEyg1FE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773958817; c=relaxed/simple;
	bh=TGc3LKXwkrGGio7qa2YHUblAoE1TQEa6MzhX/8PCp8w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DfXYlSJVYZNd8rB7Jp4+ElytWk9RlNMRme/eC+gDez6OE12EIFeo5LYLhIsuhb08k1qH5TOFAUeXMuZShnk8letkeBhim5tjkcQXlV/LemlcpkxPE9hpYwy94Hu1KyJhHJ3ZROB46y3Bzc1U5zW9bqY4+wGo+9vEOvj5qdLNYzI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.96.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v5Kr3Ku310Q3HwtwXlMnXKJL71gyr5i41gQj8B+P6hKP8QwMRpeh9hA1jV+zoHhbq5gkLbx3siehsmkJWsnx+EMq5rVP/pLYmHMf6oF39ufJyamPJEwbd74d8jy/SQ+KQ3uN57fJO8EFfnisPb0oWme4b8W+kM8ICE9tgXjgelNzpke8ZNMrRq/pQGcSEGMDocD/FHUAxMAxw+EIZUFbYRDF3S85qlQCvOVN5bl6XARJ/QvQo5TNTbQW31oLzRE3lKqsUUFHRbzjzKnp/LzAZb6czm9izrCKrj/sacXEoZwZlzvjIqiete6A6pZ5AKcdQwe0XgS7fVu8ycq9xH/ekg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ejeWccQTQzGV3N8e/GZfyDeQoYtI0qPsliQzJ+w8PE=;
 b=YB2/yY1HbsDshPGxXELIz/0i+1qAqVQK/5dTbzp9nDKRaouYmqQsdRkiBOSdSHqr68KUgEbkeKmmy5KqLom83AUOEOvVDGBph9BbvHcUsVMn+CKjIol6k+ylUR75Fdb6VGD+VH0zHWNYU5LdUov6zOQosCfQj8DOMOLnC+IWRC8vsyA2+HVji7tJ3Xmy9CrJMoHqX3lOh8v1mUG0sC/ikew6hycQf7HzzwmkL57dfi4HfPloCAxXaCgTGghzvGUxbn+RBHl7sZ4iv3meWbjV3q7Sf4CebPJlLxHzu99PsV755sRQ887MzK0rd4MISnc3STg2w+0VUHi3oUSF34P2dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by LO4P123MB6712.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:2e2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.22; Thu, 19 Mar
 2026 22:20:12 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%2]) with mapi id 15.20.9723.018; Thu, 19 Mar 2026
 22:20:13 +0000
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
Subject: [PATCH v3 2/2] blk-mq: expose tag starvation counts via debugfs
Date: Thu, 19 Mar 2026 18:19:56 -0400
Message-ID: <20260319221956.332770-3-atomlin@atomlin.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260319221956.332770-1-atomlin@atomlin.com>
References: <20260319221956.332770-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7PR13CA0017.namprd13.prod.outlook.com
 (2603:10b6:510:174::13) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|LO4P123MB6712:EE_
X-MS-Office365-Filtering-Correlation-Id: d9acc5e9-ee9a-45d1-af23-08de8605b092
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	8/ymXN/RwiIcP2TySJM0ucGdj524EfvMRsVbf0fNpx/DRo59hXC1rvUsOeMR+wX3nYvZQA1mlxiJQtfAQIspZddOAgCQm1sWv7jMmOTTxAy+6T301P7JNyZULxnKU5eMeMrwKLsi7I1m+HZJ1cBwMeSCfDn+ThYqowEJIaN7ieQH3IMLALWO2cstd8lGjvWZOlnOMQnAiEmlFaHIItkjxL3TEACbfejRHANZZIzPQpuoXchuBEJYT6UJaPnQdcW5FZHGmqzMJHyCCB7AYWJIlAPxqdWi0Y62/+knYVDD3072PzqyGDwKs15rpKI+FF6h5FUVxvQVCMregZGXadrJkP8UBQcijJrESScPsEOajx4PI3w6TQ9cr1vCSw6CrcgkvJ5U4sQrpZRVeXvwnzpgNwhkwBz2jX4mCqKvEGGHDw+U7+fe+0wq0kURu+sdSGYnsNQy/jbWyV0ssBgD6p/sx3fU0W6nAwi5cQEZAAbKNnGmo0wd6+z0JS8mazx0h9thgkXoU8sB3E9Zm/wCMbabEBxF7LKur1b0xs3h6T0yaAykH11XS/+Z9Q6NQoMNeRXdjeROFxxFHb1FWNr3fRXN16Pc2bz0e0AS3UY1Ht1Gy2c24g/VAEX4igVep5BCoeGTIsx3Qt9BE3QCdH7g+RbLtimC4yo9TgBsaEowOh5k9sBSQstM/ZdB5S6RWql4xA3S4bd9hl+ZW6CNaqSORCLRBYUeDGN0eHjibpY/MBZqgzw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jRXmBteRbeQFKgeGW1X7f/9QDhlCfnxHXOvBKjRZvd+inLYZxKqDEHIDECdW?=
 =?us-ascii?Q?6X0XtfIsO99uVEKQ/zHCdFFIyTW7GvxWsc94ieWPbuh0En1v4qtTKoEzx2Or?=
 =?us-ascii?Q?duVOVTNltJjWQgwaKn2ZXxxMBchZYLeFRTBgFBZZQcaTokXczN+OvjrHldaS?=
 =?us-ascii?Q?6ndXyiumcNIXFZtFrYGJN2e7XLq+LEVIEQ1hytwv9Zb6TNo3AYSQQjyQx/js?=
 =?us-ascii?Q?W/5bA4Dwk7CNGOJHRh8+4b88Cz1P4uC4YLPS2URuiZUdUsVboKbkkTtL+UTz?=
 =?us-ascii?Q?YB+ke9stz6D187tSVY9ZmPxxa9mPwRmwfS1VYIzeukHyGP/RWc4AKzK2Wu2p?=
 =?us-ascii?Q?D+2lkpdNwoiesUO5mzcO0p+aYyXpHYKqnexWABzMrhrxuDq1uK+pF2iVeDnC?=
 =?us-ascii?Q?EKVleqyy2zZCdGOORLHczTSLI5RVIyC0oHROc5Jbm1Oqwghc7bieDNDj8/gj?=
 =?us-ascii?Q?PD+eWjZNAY1SHBT5IqYuJwomppYIz2jlGUgUpyP6FDDCImKvnfYLD+XTNUOp?=
 =?us-ascii?Q?McfgP4uy2pWiuPpwJ2F9HxABHExcqKtI19Z60x46sZildA9yZiXnmszY0BXS?=
 =?us-ascii?Q?mz8vsPFBM0mWsKrAYn4YeK0TTaFJhsygzlH9kXccUxOVKOGhmxMgsMed8s6u?=
 =?us-ascii?Q?hNfx6Hj7jhJX0yFsKLs/5GRbz9XioDmJStXL5wI56Cuc2pD47i/LrG/9Akk2?=
 =?us-ascii?Q?71OGAcUSHiZ0/r+93li7OZDFQawvL32OPYiem3fH+pVXgxiXqz3FE/8RQTx5?=
 =?us-ascii?Q?UE7hGdkP6PwwwugjRi8oY+4WjjUQ56TjFauBlNLGmaSi7LLcAsf+W9Nyk41U?=
 =?us-ascii?Q?A5/LE0/8RoXopQHK4BOxPcDpWSWisHxNBLEXRx2cB1M9gO7a9aVlxp2YLxIB?=
 =?us-ascii?Q?16Js5oefnfuOs4WBycgO3bc+fGJ1xJDu9ZlAEYGNkig+ebo2JewqHhVAUt/X?=
 =?us-ascii?Q?72F8btxLFHysdUNHlkhjUKJaaOTMFm0N0Ljyyn2M1qN6jZ3zIKpkfEPU0RR1?=
 =?us-ascii?Q?I8zPbpiQAPxmqXRU/44g0lhJGXsGM0F/fe/a5dkeJy0bMI+ENpL9Cz8z8WBv?=
 =?us-ascii?Q?3ge80aRcNFd3d7v9g9hgHXLacfyd22l06MkEtqUr5Jz2u7Do4octFLXW5/RH?=
 =?us-ascii?Q?26tzCODxCpkEFJG0WnH7Ydi2qgA7IlNDhf8NVBjFIDDYu6k6nT/i5ZosKAYJ?=
 =?us-ascii?Q?kpX9YudO1Uxo7y0ezlL7QlAsbRsqSbnQ7CJTPZRUxNYNU0jPhYt39xmh4An8?=
 =?us-ascii?Q?mC9UcdlN57EvNLXaSHBX9KftMLWIlZnuOcCIOm5NfOVD04Xl8rJQv/H+vikd?=
 =?us-ascii?Q?QsO1QgEuKG7SxMZTto8t9vCZiND+BTGywql9vAK+8Ts/K3YNBY1gVayTO4va?=
 =?us-ascii?Q?aSNzSohRWGOSG+q8sgrqQZ6/RaHcGOiZy5qLSvvrCn8GmZYiax4lpRXe0u2A?=
 =?us-ascii?Q?RZJNWV/qA0+tvN/k4xFc3H4WJu/0DQKxLSfbiZO76afMxRlhQNXklWAOLFPH?=
 =?us-ascii?Q?R6Ni9Zooi+ft16sV0h0BcqkGogpQP2gByDZuyFT+9SLadHPSVrvTz3sgYVjp?=
 =?us-ascii?Q?y3lrFS6WnlNIznYhiLrKnAXrFb1v+gNEU14LBACt2l8LMO69paKuxn9QiPE2?=
 =?us-ascii?Q?EVF89Q6swqA6dfmDdU32e3TvhicCaQFQY3Vl/nCcZD+7GakY9gXFb8QYkp9s?=
 =?us-ascii?Q?EDGb9w+wuVZksIAxMjX8oSlR1sUwheT32BcQ0kjYQLUUhfqrgUhcnP2Ss5Ux?=
 =?us-ascii?Q?9ESscibbJQ=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9acc5e9-ee9a-45d1-af23-08de8605b092
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 22:20:13.0814
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PRUkNBIC/MLwkoCQWwF7UBawN4yjYecGicGSrxmK/dbGqzIPsSyYWibsiwaJBbF+jRXNEgviHToJvAAw9vSP1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P123MB6712

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

To guarantee zero performance overhead for production kernels compiled
without debugfs, the underlying atomic_t variables and their associated
increment routines are strictly guarded behind CONFIG_BLK_DEBUG_FS.
When this configuration is disabled, the tracking logic compiles down
to a safe no-op.

Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 block/blk-mq-debugfs.c | 56 ++++++++++++++++++++++++++++++++++++++++++
 block/blk-mq-debugfs.h |  7 ++++++
 block/blk-mq-tag.c     |  4 +++
 include/linux/blk-mq.h | 10 ++++++++
 4 files changed, 77 insertions(+)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 28167c9baa55..078561d7da38 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -483,6 +483,42 @@ static int hctx_dispatch_busy_show(void *data, struct seq_file *m)
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
+
+	seq_printf(m, "%d\n", atomic_read(&hctx->wait_on_hw_tag));
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
+
+	seq_printf(m, "%d\n", atomic_read(&hctx->wait_on_sched_tag));
+	return 0;
+}
+
 #define CTX_RQ_SEQ_OPS(name, type)					\
 static void *ctx_##name##_rq_list_start(struct seq_file *m, loff_t *pos) \
 	__acquires(&ctx->lock)						\
@@ -598,6 +634,8 @@ static const struct blk_mq_debugfs_attr blk_mq_debugfs_hctx_attrs[] = {
 	{"active", 0400, hctx_active_show},
 	{"dispatch_busy", 0400, hctx_dispatch_busy_show},
 	{"type", 0400, hctx_type_show},
+	{"wait_on_hw_tag", 0400, hctx_wait_on_hw_tag_show},
+	{"wait_on_sched_tag", 0400, hctx_wait_on_sched_tag_show},
 	{},
 };
 
@@ -814,3 +852,21 @@ void blk_mq_debugfs_unregister_sched_hctx(struct blk_mq_hw_ctx *hctx)
 	debugfs_remove_recursive(hctx->sched_debugfs_dir);
 	hctx->sched_debugfs_dir = NULL;
 }
+
+/**
+ * blk_mq_debugfs_inc_wait_tags - increment the tag starvation counters
+ * @hctx: hardware context associated with the tag allocation
+ * @is_sched: boolean indicating whether the starved pool is the software scheduler
+ *
+ * Evaluates the exhausted tag pool and increments the appropriate debugfs
+ * starvation counter. This is invoked immediately before the submitting
+ * context is forced into an uninterruptible sleep via io_schedule().
+ */
+void blk_mq_debugfs_inc_wait_tags(struct blk_mq_hw_ctx *hctx,
+				  bool is_sched)
+{
+	if (is_sched)
+		atomic_inc(&hctx->wait_on_sched_tag);
+	else
+		atomic_inc(&hctx->wait_on_hw_tag);
+}
diff --git a/block/blk-mq-debugfs.h b/block/blk-mq-debugfs.h
index 49bb1aaa83dc..2cda555d5730 100644
--- a/block/blk-mq-debugfs.h
+++ b/block/blk-mq-debugfs.h
@@ -34,6 +34,8 @@ void blk_mq_debugfs_register_sched_hctx(struct request_queue *q,
 void blk_mq_debugfs_unregister_sched_hctx(struct blk_mq_hw_ctx *hctx);
 
 void blk_mq_debugfs_register_rq_qos(struct request_queue *q);
+void blk_mq_debugfs_inc_wait_tags(struct blk_mq_hw_ctx *hctx,
+				  bool is_sched);
 #else
 static inline void blk_mq_debugfs_register(struct request_queue *q)
 {
@@ -77,6 +79,11 @@ static inline void blk_mq_debugfs_register_rq_qos(struct request_queue *q)
 {
 }
 
+static inline void blk_mq_debugfs_inc_wait_tags(struct blk_mq_hw_ctx *hctx,
+						bool is_sched)
+{
+}
+
 #endif
 
 #if defined(CONFIG_BLK_DEV_ZONED) && defined(CONFIG_BLK_DEBUG_FS)
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
 
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 18a2388ba581..f3d8ea93b23f 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -453,6 +453,16 @@ struct blk_mq_hw_ctx {
 	struct dentry		*debugfs_dir;
 	/** @sched_debugfs_dir:	debugfs directory for the scheduler. */
 	struct dentry		*sched_debugfs_dir;
+	/**
+	 * @wait_on_hw_tag: Cumulative counter incremented each time a submitting
+	 * context is forced to block due to physical hardware driver tag exhaustion.
+	 */
+	atomic_t		wait_on_hw_tag;
+	/**
+	 * @wait_on_sched_tag: Cumulative counter incremented each time a submitting
+	 * context is forced to block due to software scheduler tag exhaustion.
+	 */
+	atomic_t		wait_on_sched_tag;
 #endif
 
 	/**
-- 
2.51.0

