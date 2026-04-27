Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022111.outbound.protection.outlook.com [52.101.96.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2986326CE2C;
	Mon, 27 Apr 2026 02:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777255317; cv=fail; b=S2TK4sUQfJBjVhV6lCI72eCszPM22ooO3A9m0OfZl1zjiQ79uP0ayQb3eRvsvwW55QCLXesAljOmWclMBFhDC7PqZKWpBsryd8eugsLXmPc+MA9OdubVAOa8Z/6KdPeiXtF+Lvk6gRFd+9jAF7Y0XgtbYND90lpY4nSngm4h05c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777255317; c=relaxed/simple;
	bh=jNorWFhU7Atlkfzl2xutxitJJhiPQYDyzmpPJGO1baw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eZbg88bzisPRkmQJCDwrXg26R1M+OXLnZRbsFRqbzJ9JY8qj/wz1GLZkIjNBYkq1amYwckNO1Y1lM/pLZJ53CA6EtLDC+szTFRiLMeJoKyjntkXzX+eafkz6Md3EvKx4KZFca0NCRWdohj0mwUT3QFw5V8ZeXtYLIqa/aopAlrg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.96.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j8FzOfZflLVGOaKe+3hm4HPKiGDRHj3NZJOV2yGe8nbTz4/Xzcws8JJ9UP0SQ44ihG8mFlbZIjHbzc1+Yw+CmbhpaePuMWmAOltxR3zWFiUNaFwoOiFM4DCXxHgvgkvr4iKR/XhAYcQ/SncFX5Iu6lceVhfwjur+gUznuQqkmeg5cyZSS/WQV2gGUaQDzK0o8OWiPf4oDetDbQPlVyYXZntcLCJUj1LVlkgBwUG1cjt88i9w7BYzqTR8/ZD+z/8KtzZWvTlSFWiPo6HYbgPZI/kc6D0TZingf/oysaNznlrqDHoSzOZgbQbp/5S3N+8dZgZrCsYBVnagtoYW3FZtIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MRy6pEIlti4pShW9b5jcwHaRth+gEnbDHPEo2miCoHY=;
 b=UJA/9edaKpM6QfAOd+j8tAydgi/dHUtB00x3ggFfq1KUx1OGzJwzcGCv+WHLFC/QbNYwhLyHUdCyPDk/Ce3TtEukLAtX0iirW3d6rLnZjnaJwB7KaLiCfg2h2YjgDeopXEVkT7/quVLDEqz2hAUIDUmo0Y6fqCJy6AKZN6d2gYQ4I2YdUgHt9cV5N5Nr9zflViNnul2HYcKC/8PivG1Qez3lKkCtiFQbOMl8b53e/bG6lWMjVcvc5wA/2dFUyOtSLHlfiLgljumERV6CzVrDu8+dnhk6qhofoBV+1b6aQ0GmaGXJeC9OeukksXSzeEMhGa5SF8YnPP+2RhcIBpGyyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by CWXP123MB3559.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:7e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Mon, 27 Apr
 2026 02:01:53 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%2]) with mapi id 15.20.9846.025; Mon, 27 Apr 2026
 02:01:53 +0000
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
Subject: [PATCH v5 2/2] blk-mq: expose tag starvation counts via debugfs
Date: Sun, 26 Apr 2026 22:01:42 -0400
Message-ID: <20260427020142.358912-3-atomlin@atomlin.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260427020142.358912-1-atomlin@atomlin.com>
References: <20260427020142.358912-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR03CA0045.namprd03.prod.outlook.com
 (2603:10b6:408:e7::20) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|CWXP123MB3559:EE_
X-MS-Office365-Filtering-Correlation-Id: ad6d291b-c234-4a31-1ed6-08dea400f43a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|22082099003|18002099003|56012099003|18096099003;
X-Microsoft-Antispam-Message-Info:
	bCYMV5prS8n5BQWJEB6tGTxgnMGMiBgdDdYiikmiy/LcYQUBOWLHGf2iHZXxud1AX/KpTjWR5gqG7XXldLtN0YH6s4X54HVluleIH8mJEDI//7biFpMqBboID2e/hlVa/aE7TxKdXEkMEwFNIUakRLkraEUZiqgg3d29ghKmD3pam7UBghFfkdhNhtgmaXks1nLLBhY4yqdU8XUP1kpmJpnvzwNn/6vW8VG7J9eY9IQvPUUXS9dki+r7SgsrIcv6OLW22aRo2D0kRPyu0Rhz+fOZEs1wBJzrQQOQiMkJT5/9WU1nRSxEmRaRhRpMVH7PFCV5jS1gzu8hwm4O9LnWrq3trOCDXaSEQZa0HCrXAK4MB8Aa/llYC14TkBX6WckwHqamJYhIkbk7FM46LD0Zxz/6Jup/q1+0oAZoiKiCrizm/Ok0YCRprL8hTwDd0whhCsaGDE3OcmdQjM7HeGjQI22XZw6gXI/tmE6z08iNQFk2mrVQdva3R4DItzINT60pCGL5lszI/CfxyV1FMp1XU6oBrYCSKZsl2TcJEsrkUfZmR8KPmahtJw2f0IKLOe+pkV1W1hNC5SO1PLREtqeFoByr3vNsaD/fmC6UPcsnu7cgAGOzctwWDIOHbF1JH3EQN5z2IJ9awtajzLDQnQz4SJMlS9IXhsEOugc8rlNXVXXE0AVMQogvN/rDN4fVPcywWbMUsYeo5aoFr1cvA8Z2fQ3K7vTDnAaE9l6n1EsHwTg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(22082099003)(18002099003)(56012099003)(18096099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?npBOVB10Mw9GED+W1MV19v7fLvy3Q87E3W4mpd626fXkst+KjQWVXU5qkTl9?=
 =?us-ascii?Q?BquTVTF6rRhc3npYhsvhS6C144knPdYmqc2t2zRWXkZMreHMZQlO5pUj5QRe?=
 =?us-ascii?Q?PPztFkZNJrzyLbHpoQLUO54x8x+O9oYPrWEfviXb1+srD6LvY9oqXfnhTEig?=
 =?us-ascii?Q?1IN/30MOy+YVt/PJBNnVNVAjuSovEFj86X69DuQ+Jt9Pt+8KRNsBIDlqvxAh?=
 =?us-ascii?Q?/U7Uj6PKum33IOq1mB1StriIa6DZg/DLP7F0j18Oe6fBXKicYlplVSGUESCB?=
 =?us-ascii?Q?7/CvJ72gPelP2myqxWYMF5NjZcTNhWCztIETqrRR5mZGdyjc1M0vJA/qCd/x?=
 =?us-ascii?Q?jYD2Rr0/bpeg6nGVVnhQw5RIXOOQag/LVuDw1I3fL4b0mlEdcpzkGgJJPTbh?=
 =?us-ascii?Q?QfxxXrLU87707vbbSfkuavf0iG4U8QUT7sN1q3ibIJ3ABM1/Uu2dBE9HhaT4?=
 =?us-ascii?Q?1FDQlfa8buph16kHuEMMNStJEivE8Ul8Kx3MP7rN6rDWtzt3ZbZ9qVcbxuEV?=
 =?us-ascii?Q?858dycDfhcvAXVWgEPaV+saQAL4bmP1ZWxubt5N1p+opEb2cJQCYkAN6C0m6?=
 =?us-ascii?Q?FcCnHwlEq9oLcwXmJnurgcThh+FZ+dA123Z2mFO2Kow944ZSSauTgLmw7jcy?=
 =?us-ascii?Q?CncCKhbqMAx0ZZhZyEGQyozlZOUgpU60yiuLLWi3QJmBxLK+bt0UzJdngtd7?=
 =?us-ascii?Q?EMYiVD0uPHYVKUYvCngKmlGeT929+AC6TqmNfxmsUwLADWYBTMD6kLDg4w+T?=
 =?us-ascii?Q?wZvzhEI9KjGqTqbXG7g/Jj88ewSgE85CHV2nfuLBfWio6WI5MbxzOPnTHcpE?=
 =?us-ascii?Q?vRoIqSfDS797NHVw/fSNxw+c+6ogF/4pBRuagRNr/m82ena+LxGyD6Ui2zhv?=
 =?us-ascii?Q?Piz18Fn+Dpp826IXY09inOUv0/TLgnUqNHw3kgmLojHKoy6WFg+99sQsPf67?=
 =?us-ascii?Q?GiNPYSGLH852eIfJiTES+fpYipJfhd7doGTfAjWa6js+M9xN4I0a4kxhrks9?=
 =?us-ascii?Q?nobQp9qD/Iprg8ogyLVOGPSfKKpAgmvLFNp5lW1f2FJdr+maFIug4RB5+Q2y?=
 =?us-ascii?Q?c9jT+CRcgy2zR3Ipm8Zt4y+5yWm7YjG7jr2oRw91TkIhHqfhnox9pIyQ38qu?=
 =?us-ascii?Q?XxFINYqr4xqYtPyzAiPMxVZxREE9/cxqlsrpWiRU+RX7ZJjPZBo9LvG4W3fX?=
 =?us-ascii?Q?lj+zLxrWE47t2Tq5K4zkhN2MBrKb8+RLbgTMEtKmgO7q91O+kaMPM9j3xYuj?=
 =?us-ascii?Q?c7xhmmC862WnWjGjMTX4A++8syOhiqXGttVKsqhXp4eGuLzvCuwVaU9rTwWm?=
 =?us-ascii?Q?o6zRpjNsQbwvhfyNCnawJlge6bT35acgBkvmj/lDwNXlePkLYI5/6iD8qwFF?=
 =?us-ascii?Q?boLQXr1yAp0DaCPu3SY1AUZpg1CAax7ORWQLU1DjwDfs3kRBTKbp+3SDf2iX?=
 =?us-ascii?Q?5Plg/4Z5jfKaOGkNXN+FgKKUN5sKdJt9emWhEcpdGI6SYeh/P4swKkjY+a4K?=
 =?us-ascii?Q?OQqKJWYAcuZoIqwl4av08noR2ZeNuWxcoxCFz4P9YCtEoAeKPVtJFXtfY4Xr?=
 =?us-ascii?Q?05TDbjTxxNptccFfbcbhUuohqVKG4ze8aUrP3PryB/NZxJsSFWAjOaNBR/ND?=
 =?us-ascii?Q?WjR3VTgw22YgIuY2/NZ7zxnxG6cBDxH40YcaLcGqKRG016/htwgQuYRqJdWd?=
 =?us-ascii?Q?yx9EOWDy3G5CjlbPj4CBcXaU08t3kuL/omLM1bJyBd4huHVHF+CInoUXzg8m?=
 =?us-ascii?Q?MavKwO2IwA=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad6d291b-c234-4a31-1ed6-08dea400f43a
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 02:01:53.8733
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eEriOKS6Y+R17trAg4tzCvAeC2nB41q66S+1FJ4S7eQqRv3sxKAZRPLEbnaJieCCoqHY2HzCzGoHZ5Jh337vLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP123MB3559

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

To ensure negligible performance overhead even in production
environments where CONFIG_BLK_DEBUG_FS is actively enabled, this
tracking logic utilises dynamically allocated per-CPU counters. When
this configuration is disabled, the tracking logic compiles down to a
safe no-op.

Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 block/blk-mq-debugfs.c | 109 +++++++++++++++++++++++++++++++++++++++++
 block/blk-mq-debugfs.h |  19 +++++++
 block/blk-mq-tag.c     |   4 ++
 block/blk-mq.c         |   5 ++
 include/linux/blk-mq.h |  12 +++++
 5 files changed, 149 insertions(+)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 047ec887456b..1a993bcea5c9 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -7,6 +7,7 @@
 #include <linux/blkdev.h>
 #include <linux/build_bug.h>
 #include <linux/debugfs.h>
+#include <linux/percpu.h>
 
 #include "blk.h"
 #include "blk-mq.h"
@@ -484,6 +485,54 @@ static int hctx_dispatch_busy_show(void *data, struct seq_file *m)
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
+	unsigned long count = 0;
+	int cpu;
+
+	if (hctx->wait_on_hw_tag) {
+		for_each_possible_cpu(cpu)
+			count += *per_cpu_ptr(hctx->wait_on_hw_tag, cpu);
+	}
+	seq_printf(m, "%lu\n", count);
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
+	unsigned long count = 0;
+	int cpu;
+
+	if (hctx->wait_on_sched_tag) {
+		for_each_possible_cpu(cpu)
+			count += *per_cpu_ptr(hctx->wait_on_sched_tag, cpu);
+	}
+	seq_printf(m, "%lu\n", count);
+	return 0;
+}
+
 #define CTX_RQ_SEQ_OPS(name, type)					\
 static void *ctx_##name##_rq_list_start(struct seq_file *m, loff_t *pos) \
 	__acquires(&ctx->lock)						\
@@ -599,6 +648,8 @@ static const struct blk_mq_debugfs_attr blk_mq_debugfs_hctx_attrs[] = {
 	{"active", 0400, hctx_active_show},
 	{"dispatch_busy", 0400, hctx_dispatch_busy_show},
 	{"type", 0400, hctx_type_show},
+	{"wait_on_hw_tag", 0400, hctx_wait_on_hw_tag_show},
+	{"wait_on_sched_tag", 0400, hctx_wait_on_sched_tag_show},
 	{},
 };
 
@@ -815,3 +866,61 @@ void blk_mq_debugfs_unregister_sched_hctx(struct blk_mq_hw_ctx *hctx)
 	debugfs_remove_recursive(hctx->sched_debugfs_dir);
 	hctx->sched_debugfs_dir = NULL;
 }
+
+/**
+ * blk_mq_debugfs_alloc_hctx_stats - Allocate per-cpu starvation statistics
+ * @hctx: hardware context associated with the tag allocation
+ * @gfp: memory allocation flags
+ *
+ * Allocates the per-cpu memory for tracking hardware and scheduler tag
+ * starvation.
+ */
+void blk_mq_debugfs_alloc_hctx_stats(struct blk_mq_hw_ctx *hctx, gfp_t gfp)
+{
+	if (!hctx->wait_on_hw_tag)
+		hctx->wait_on_hw_tag = alloc_percpu_gfp(unsigned long,
+							gfp);
+	if (!hctx->wait_on_sched_tag)
+		hctx->wait_on_sched_tag = alloc_percpu_gfp(unsigned long,
+							   gfp);
+}
+
+/**
+ * blk_mq_debugfs_free_hctx_stats - Free per-cpu starvation statistics
+ * @hctx: hardware context associated with the tag allocation
+ *
+ * Frees the per-cpu memory used for tracking hardware and scheduler tag
+ * starvation. This must only be called during hardware queue teardown when
+ * the queue is safely frozen and no active I/O submissions can race to
+ * increment the statistics.
+ */
+void blk_mq_debugfs_free_hctx_stats(struct blk_mq_hw_ctx *hctx)
+{
+	free_percpu(hctx->wait_on_hw_tag);
+	hctx->wait_on_hw_tag = NULL;
+	free_percpu(hctx->wait_on_sched_tag);
+	hctx->wait_on_sched_tag = NULL;
+}
+
+/**
+ * blk_mq_debugfs_inc_wait_tags - increment the tag starvation counters
+ * @hctx: hardware context associated with the tag allocation
+ * @is_sched: true if the starved pool is the software scheduler
+ *
+ * Evaluates the exhausted tag pool and safely increments the appropriate
+ * per-cpu debugfs starvation counter.
+ *
+ * Note: The per-cpu pointers are explicitly checked to prevent a NULL
+ * pointer dereference in the event that the system was under heavy memory
+ * pressure and the initial per-cpu allocation failed.
+ */
+void blk_mq_debugfs_inc_wait_tags(struct blk_mq_hw_ctx *hctx,
+				  bool is_sched)
+{
+	unsigned long __percpu *tags = is_sched ?
+			READ_ONCE(hctx->wait_on_sched_tag) :
+			READ_ONCE(hctx->wait_on_hw_tag);
+
+	if (likely(tags))
+		this_cpu_inc(*tags);
+}
diff --git a/block/blk-mq-debugfs.h b/block/blk-mq-debugfs.h
index 49bb1aaa83dc..7a7c0f376a2b 100644
--- a/block/blk-mq-debugfs.h
+++ b/block/blk-mq-debugfs.h
@@ -17,6 +17,8 @@ struct blk_mq_debugfs_attr {
 	const struct seq_operations *seq_ops;
 };
 
+void blk_mq_debugfs_inc_wait_tags(struct blk_mq_hw_ctx *hctx,
+				  bool is_sched);
 int __blk_mq_debugfs_rq_show(struct seq_file *m, struct request *rq);
 int blk_mq_debugfs_rq_show(struct seq_file *m, void *v);
 
@@ -26,6 +28,9 @@ void blk_mq_debugfs_register_hctx(struct request_queue *q,
 void blk_mq_debugfs_unregister_hctx(struct blk_mq_hw_ctx *hctx);
 void blk_mq_debugfs_register_hctxs(struct request_queue *q);
 void blk_mq_debugfs_unregister_hctxs(struct request_queue *q);
+void blk_mq_debugfs_alloc_hctx_stats(struct blk_mq_hw_ctx *hctx,
+				     gfp_t gfp);
+void blk_mq_debugfs_free_hctx_stats(struct blk_mq_hw_ctx *hctx);
 
 void blk_mq_debugfs_register_sched(struct request_queue *q);
 void blk_mq_debugfs_unregister_sched(struct request_queue *q);
@@ -35,6 +40,11 @@ void blk_mq_debugfs_unregister_sched_hctx(struct blk_mq_hw_ctx *hctx);
 
 void blk_mq_debugfs_register_rq_qos(struct request_queue *q);
 #else
+static inline void blk_mq_debugfs_inc_wait_tags(struct blk_mq_hw_ctx *hctx,
+						bool is_sched)
+{
+}
+
 static inline void blk_mq_debugfs_register(struct request_queue *q)
 {
 }
@@ -56,6 +66,15 @@ static inline void blk_mq_debugfs_unregister_hctxs(struct request_queue *q)
 {
 }
 
+static inline void blk_mq_debugfs_alloc_hctx_stats(struct blk_mq_hw_ctx *hctx,
+						   gfp_t gfp)
+{
+}
+
+static inline void blk_mq_debugfs_free_hctx_stats(struct blk_mq_hw_ctx *hctx)
+{
+}
+
 static inline void blk_mq_debugfs_register_sched(struct request_queue *q)
 {
 }
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
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 4c5c16cce4f8..cd52bf6f82ce 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3991,6 +3991,8 @@ static void blk_mq_exit_hctx(struct request_queue *q,
 			blk_free_flush_queue_callback);
 	hctx->fq = NULL;
 
+	blk_mq_debugfs_free_hctx_stats(hctx);
+
 	spin_lock(&q->unused_hctx_lock);
 	list_add(&hctx->hctx_list, &q->unused_hctx_list);
 	spin_unlock(&q->unused_hctx_lock);
@@ -4016,6 +4018,8 @@ static int blk_mq_init_hctx(struct request_queue *q,
 {
 	gfp_t gfp = GFP_NOIO | __GFP_NOWARN | __GFP_NORETRY;
 
+	blk_mq_debugfs_alloc_hctx_stats(hctx, gfp);
+
 	hctx->fq = blk_alloc_flush_queue(hctx->numa_node, set->cmd_size, gfp);
 	if (!hctx->fq)
 		goto fail;
@@ -4041,6 +4045,7 @@ static int blk_mq_init_hctx(struct request_queue *q,
 	blk_free_flush_queue(hctx->fq);
 	hctx->fq = NULL;
  fail:
+	blk_mq_debugfs_free_hctx_stats(hctx);
 	return -1;
 }
 
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 18a2388ba581..41d61488d683 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -453,6 +453,18 @@ struct blk_mq_hw_ctx {
 	struct dentry		*debugfs_dir;
 	/** @sched_debugfs_dir:	debugfs directory for the scheduler. */
 	struct dentry		*sched_debugfs_dir;
+	/**
+	 * @wait_on_hw_tag: Cumulative per-cpu counter incremented each
+	 * time a submitting context is forced to block due to physical
+	 * hardware tag exhaustion.
+	 */
+	unsigned long __percpu	*wait_on_hw_tag;
+	/**
+	 * @wait_on_sched_tag: Cumulative per-cpu counter incremented each
+	 * time a submitting context is forced to block due to software
+	 * scheduler tag exhaustion.
+	 */
+	unsigned long __percpu	*wait_on_sched_tag;
 #endif
 
 	/**
-- 
2.51.0

