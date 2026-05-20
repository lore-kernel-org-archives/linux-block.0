Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022079.outbound.protection.outlook.com [52.101.96.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425873A2571;
	Wed, 20 May 2026 21:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779313860; cv=fail; b=fARgtAEl2xB0Yp5BbScORILemHNl5oW7d2/sW+89S0Tc2TUKzehxT9yevMPpsa1IuS0jsnLKwk2+lWHpuyQyaCmXEYvVCzjz+tS1Clq8ergWzSUYeFlMfWvrzMJhVNEXP6hL31a7oKpXC7rS39ewgglb1pRhWwPrj6S56gQuS2Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779313860; c=relaxed/simple;
	bh=+4ey0pFOAOh0wLuV6mzkMu7G+JqmdYqAqChNM6pz9eo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JDcaQbGTZCUJ7j5o+IsjqcdI3Q5wbiohaxOzpfODalM2wL+6kIbJOXvBZBMrJxzdIf2JXPqACEuYUw45vEj7vC02rPyOKC9qC0xvwFa8ayGdm3/aH1aFhhxSA06jbxjHyh8UAimr2sKBVC0+8AFycM8WHHLPc355566udxBboqA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.96.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KgOzV8/5ywZSe/zNAzoBBIrYhJ0EQukHZJeTX1YeunFb5qAY/zc2USYRFsUNkBwMqADIcOzJhKLob9DfEiMCLsmu9X5o+VDOLCpKKy1HXnY7/EeOaZSG8OQprfSAkSXMfRM95jHb20U/l0X4XAdSqi6GDpEJaUyQ/zlbNkcjeTVVJIch44l179nrofUQCPGnx2tRMWPYRzcq9132uG0fOS+Dxn3zIzvU5ZjxTy2508yR49wYUKcfLV2SvsmEeyP629x+iQGsAwR89Tb9wLrhKlCGN7WbG2GSCf02mnURqor4wpEXgRSR0wrOayOo42cvC/0YEn00ixfOGznCMwB6gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tMeAMyL5AalujLTADX1QVXlE7SuHd1EEZxY12y/54U4=;
 b=I4L6xoypxlmy+irLJ7EFXj0UK6gr+wLcYaKOzZFnMxZei6Uk/QdJ8YKmqJjeuT+Yo75XduTeHLn0H21EvSqAirWdLHQAIPTkIMrwClzK9ju9NO/QP1VKAWCxitxlJjejkeZEhveImy3UKMcKyYAeYEG7HNKfQuYgdxAvu80UJ+VN6v+nICYKefa+bpwUXW+Uk7eX0Ly5jH2UcbJExZVppmL2HptLK/uWAMs9m+Qy4s0tllHNLgLrryjfmbb0x7FP3SgP6V5dNuNcLpFQiq2GWeohJEq5VfxDxF//540AGZe70m7N3sYB7csEfQHXgHGyNOJtNI5k+NZIRS2y5zyoSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by LO4P123MB6626.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:278::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.16; Wed, 20 May
 2026 21:50:55 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%2]) with mapi id 15.20.9846.025; Wed, 20 May 2026
 21:50:55 +0000
From: Aaron Tomlin <atomlin@atomlin.com>
To: axboe@kernel.dk,
	kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me,
	mst@redhat.com
Cc: atomlin@atomlin.com,
	aacraid@microsemi.com,
	James.Bottomley@HansenPartnership.com,
	martin.petersen@oracle.com,
	liyihang9@h-partners.com,
	kashyap.desai@broadcom.com,
	sumit.saxena@broadcom.com,
	shivasharan.srikanteshwara@broadcom.com,
	chandrakanth.patil@broadcom.com,
	sathya.prakash@broadcom.com,
	sreekanth.reddy@broadcom.com,
	suganath-prabu.subramani@broadcom.com,
	ranjan.kumar@broadcom.com,
	jinpu.wang@cloud.ionos.com,
	tglx@kernel.org,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	akpm@linux-foundation.org,
	maz@kernel.org,
	ruanjinjie@huawei.com,
	bigeasy@linutronix.de,
	yphbchou0911@gmail.com,
	wagi@kernel.org,
	frederic@kernel.org,
	longman@redhat.com,
	chenridong@huawei.com,
	hare@suse.de,
	kch@nvidia.com,
	ming.lei@redhat.com,
	tom.leiming@gmail.com,
	steve@abita.co,
	sean@ashe.io,
	chjohnst@gmail.com,
	neelx@suse.com,
	mproche@gmail.com,
	nick.lange@gmail.com,
	marco.crivellari@suse.com,
	rishil1999@outlook.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v14 6/8] blk-mq: prevent offlining hk CPUs with associated online isolated CPUs
Date: Wed, 20 May 2026 17:50:28 -0400
Message-ID: <20260520215030.496803-7-atomlin@atomlin.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260520215030.496803-1-atomlin@atomlin.com>
References: <20260520215030.496803-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0PR05CA0012.namprd05.prod.outlook.com
 (2603:10b6:208:52c::35) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|LO4P123MB6626:EE_
X-MS-Office365-Filtering-Correlation-Id: 4dd7c1be-aba7-4a02-4bfd-08deb6b9de8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	vOUVG3W1Lc2IhOp03Kjfx63ZTaB7m/2ivGOiEj2mm15VFWOj6sI5/gZAjuI3X+xfnE6/1IyQcUXYCU2wHsfLL3RJx+O22+tzDnFEZrfHyQ5q0tGxcGIUvQtcj+ACeWucamWrVn5p2pnjY8T3F4bYdSqT3d3sACTK3PKKThjTqH8ymz4xNStkBcqTciXrMLfZ3Ce9RrPUmPh9ZiNrZSFE1bVXF5npOR3H7nrkiTyhATqCN9vNGyjFi1HLIpiVucHJmZtDLaTCVPQE7S/Szg1GFLV8STkMHdScFrzEGbPWvK3mXI5caB9163GR7kZ+LEgI8cIsfzvkj2WI+wbl7i/E0iUS+Wv7pufJxl5NTL/iSJJZs3y5dYzd0tDQFb+1B2Uqji7twxHbtYzcc2mza8wDS7yPdp07rAxy6p1dd0nm0mXHd9zhmMJF9vwtAcR74FurywgumSc1WpCMwO6ISKD7j6B6dTPcbRghopWCa3R2xFywj7UAMdA5izbvAW2sbGJ5ZuSLESmqwo98peqWJGPn5rPFkR+L8k6BJ4FOqR8fWzEfyYeLvtrJu2DCRsOXLzzLJgrueb8IyXRJ0eCfbyM/x0atua1DyrIClmU9HEp63i+Oe21SwdDGXB8EYEGVK108jtJ3deG0t78sgDIAJS4G3m6EiOETGfl1eGDUbZFNVwU98umFxhqhqehhVtYDoc6E
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UjbXTGyRLPY3tIUWmqqrXK1RLfiZKr1Iybd/VRBphBhMeTZOocLESHxy2Igl?=
 =?us-ascii?Q?hk4kkkjJBiy+5YRRFKksqERwwNHlvwLFmBfHMgLlpCazxZNRmR4zTNzRfEc8?=
 =?us-ascii?Q?oQnDPFCYGWy5/yTyMcbWlQRQNoYaIX3CKQVtjxq7LEjCBE28Yd6LjpKLAlfW?=
 =?us-ascii?Q?S81+YpE0JjHT+0zRrRrWQOytgGnW4EUAAUpOx9cF517Fh/HEuH7tzcQMIcdu?=
 =?us-ascii?Q?z3gIBaBLioLyqqxMOYwRY+8B1G+TKEPv3lYP/jsaTJsN9blsNtxCTwZjJ0f4?=
 =?us-ascii?Q?/jAK5OW7GcHOFEAH4teFDFuLQX8h5MC/V4AXNkDyiefbKgbF8gzCmF7zFBOQ?=
 =?us-ascii?Q?xtq9vg/p3KCz1X6/0Va1Rgw6m09WxOh8tjN+zTFQ58uNYfR/PKTcOESMm4K8?=
 =?us-ascii?Q?q61E0Oy0hClrr/g7N6+pdvV6SX3wffSSCJ2ZVvBl/tcNGm1gXK9usRQNg14u?=
 =?us-ascii?Q?53CGXY5MH+WxlF51JhSMGRoW92mEq4zGi6e8TslGFmFuk3GG4W/U1Gl727Ry?=
 =?us-ascii?Q?bPZzQokJO501lcxC0TuqlgKj4ITEPhdL5A8Hj326+xdbJEYnTYE+77fDQn+Q?=
 =?us-ascii?Q?GtiQ+ZTZ024f2VxRRjxYTQC+/4Y4d/dBCBn4hbjYMY56Izx552C76TsTAsZe?=
 =?us-ascii?Q?7pR6iIJVCitbC5eBCT7FVJt2Hys8v69UUwcS55rWDL/dQiByJ8V6dAcU9PFG?=
 =?us-ascii?Q?7wnYdXvXdcDazuZKzX1zs7rpsFA7dwcYNsp1ny04WbNMzgll3130/+6s2UEK?=
 =?us-ascii?Q?54w1X5mh5cjOs0vHWc6JmFy//4BWA3N3NmNTvQi9R6kHMslV9gs0lhZ44+0/?=
 =?us-ascii?Q?6kqLS6EXpxO4E5ZX7cdNAQ1S/TU4tJDCDlS+FRBo1dTbq0mLD1kngzxeEgCP?=
 =?us-ascii?Q?O2Agf91EUGl7NDTeK7f66I65RNnJAFXgtUjngMx58iKxO7hgsKI5ZTwz93Ph?=
 =?us-ascii?Q?3jZUh+9/1lHPXxKSCLT7/yetRVo4MoJ5L6PoKXOVR4vvOhkUbUweaPY4gabi?=
 =?us-ascii?Q?QtF+78rRgAIl6Zp4WRou2q3Ks38qzjMUjsWro6f1iD23i+dEtjZ03Z7x7jB9?=
 =?us-ascii?Q?25NPPFKl9+dpf8mX4YZ3Qc+lJJPqW+RgUjZj6HeOu0kImTYk0YDaaXIILA4Y?=
 =?us-ascii?Q?SWtGNVkj/1H3x9ZFAKMOETg9YJ3wzbDPHclV6QXJC3wJ+behbwO2JNWBLqIX?=
 =?us-ascii?Q?Wqv4R2WT2S2nZfAaa6M/55A0LdKtdEVwwSB99cICb5yp++3u4tSqW+S5P3AN?=
 =?us-ascii?Q?WOEZYqvDUwSiktjAbI0ziKj1gJcxl06OQmB3rLIYEIRZhhbbWU7FMCn0lrOf?=
 =?us-ascii?Q?bGkGS3vqN/a+2q7mNWcnwVYzQJ+8YIHusMC+Zk9z0w3ZYClgjR6NGcHQaiOf?=
 =?us-ascii?Q?2PRb+5gMxl1rtGuD8BHpdwBmQ78s+rQqe5sg2NQ7CDBqufU4dCkKpNy6QfJ4?=
 =?us-ascii?Q?CdZgj6PtzS8m03auo2IfLvT2O7DHUkDWKPEFdFWnOo+2qTfWn1jbMiwH+kPq?=
 =?us-ascii?Q?1y+XFpLHGUfSKrF8J2Db7A2u3ByMjqn0EGI1TOvjWc5X7tyBF/5pRiNH4Jsd?=
 =?us-ascii?Q?s2AiNtQGW/9drDGU6gG4tioRV5ZAlGkz0kn/xlK+8tEL8QgC1uKFhkIxNR0O?=
 =?us-ascii?Q?YXPmPjkqyJ1FzShYfWSuttELdOImtYTFgRSgqQVzaqxlK/6FTQbtthAdtnM8?=
 =?us-ascii?Q?6hKt7GdTzlAPnFzj/RXG+dQnQ5JiQEvRjh+/IefKdsm9ofUIXj5sv8ZRXsb8?=
 =?us-ascii?Q?WexxcFr99w=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dd7c1be-aba7-4a02-4bfd-08deb6b9de8d
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 21:50:55.8043
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Oc1iw9bPb13IIBXsatoxiK0D/1Hh9yO6SpMDJ2Q8Dy2by0kPiqW4ooTc2jrTn3Qby7EV1kmiQhjpczTxMvhE/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P123MB6626

From: Daniel Wagner <wagi@kernel.org>

When isolcpus=io_queue is enabled and the last housekeeping CPU
for a given hctx goes offline, no CPU would be left to handle I/O.
To prevent I/O stalls, disallow offlining housekeeping CPUs that are
still serving isolated CPUs.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
[atomlin:
    - Removed duplicate paragraph from commit message
    - Allow offlining of non-housekeeping CPUs
    - Fix logic flaw that prematurely rejected valid offline requests
    - Iterated over cpu_online_mask and manually reverse-mapped CPUs to
      correctly detect isolated CPUs, as blk_mq_map_swqueue()
      intentionally prunes them from hctx->cpumask
    - Drop hctx->queue->disk->disk_name from warning to avoid UAF]
Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 block/blk-mq.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index d0c37daf568f..bc1ae8c055a8 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3739,6 +3739,50 @@ static bool blk_mq_hctx_has_requests(struct blk_mq_hw_ctx *hctx)
 	return data.has_rq;
 }
 
+static bool blk_mq_hctx_can_offline_hk_cpu(struct blk_mq_hw_ctx *hctx,
+					   unsigned int this_cpu)
+{
+	const struct cpumask *hk_mask = housekeeping_cpumask(HK_TYPE_IO_QUEUE);
+	int cpu, fallback_isolated_cpu = -1;
+
+	/*
+	 * If the CPU being offlined is not a housekeeping CPU,
+	 * offlining it will not strand isolated CPUs. Allow it.
+	 */
+	if (!cpumask_test_cpu(this_cpu, hk_mask))
+		return true;
+	/*
+	 * Iterate over all online CPUs and manually check their mapping.
+	 * We cannot use hctx->cpumask here because blk_mq_map_swqueue()
+	 * intentionally strips isolated CPUs from it to prevent kworker
+	 * routing.
+	 */
+	for_each_online_cpu(cpu) {
+		struct blk_mq_hw_ctx *h;
+
+		if (cpu == this_cpu)
+			continue;
+
+		h = blk_mq_map_queue_type(hctx->queue, hctx->type, cpu);
+		if (h != hctx)
+			continue;
+
+		if (cpumask_test_cpu(cpu, hk_mask))
+			return true;
+
+		if (fallback_isolated_cpu == -1)
+			fallback_isolated_cpu = cpu;
+	}
+
+	if (fallback_isolated_cpu != -1) {
+		pr_warn("blk-mq: trying to offline hctx%d but online isolated CPU %d is still mapped to it\n",
+			hctx->queue_num, fallback_isolated_cpu);
+		return false;
+	}
+
+	return true;
+}
+
 static bool blk_mq_hctx_has_online_cpu(struct blk_mq_hw_ctx *hctx,
 		unsigned int this_cpu)
 {
@@ -3771,6 +3815,11 @@ static int blk_mq_hctx_notify_offline(unsigned int cpu, struct hlist_node *node)
 			struct blk_mq_hw_ctx, cpuhp_online);
 	int ret = 0;
 
+	if (housekeeping_enabled(HK_TYPE_IO_QUEUE)) {
+		if (!blk_mq_hctx_can_offline_hk_cpu(hctx, cpu))
+			return -EINVAL;
+	}
+
 	if (!hctx->nr_ctx || blk_mq_hctx_has_online_cpu(hctx, cpu))
 		return 0;
 
-- 
2.51.0

