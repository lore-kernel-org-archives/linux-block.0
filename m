Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022083.outbound.protection.outlook.com [52.101.101.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78942BE630;
	Wed, 13 May 2026 00:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778633739; cv=fail; b=Cu1McYSOBD7hH/2aBL1pF+xP/i+zmgYMZrul7s2NFVYwRQuRhd3uz5mSjGrMAfxAtonC7DFqH/x6EJXuwiwvboCgPz/jkrfBDLyod+HBjU4zX1KsKvToq6+T4/+m9Azc7DovkObDT2b/ZDcGGJX8P0kBsm/j5GBVCopkqky/DrM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778633739; c=relaxed/simple;
	bh=BZi6CoSMomgvyxg4XZ8HMdDGJEzWjxIZBF5hgCEGMsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=T9CHwRkxLGvbXhZftVbWCpMNaIRijgYLaZm3xoIm3x0dEjOu5nnTcbqoZER9/lSRm61Uv7A5kGOW+BmEa1B/D2fQcdJmnG6wPQQ9kA5iLWgVdpBeuetqpIDPjnZiNZl8pS6U7uU5pN8AQXnwg8l7HHV/MpWaaeiQiy94s32Hiic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.101.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZeeatgzmbQLj6dacNyVwsv7Uy9pu67ftVMlDJc1Vpz2Y+k+LP4L/kMiVUFWPr0Xmje6B8OSRLYAcQGffrBUDa9AaI6WOS1E0lVBkNbcfnXdrveDO4s6zTP+ISx455CtAIpB9bEjDaXx/Xmbt2wZRMH+P1VO8k2Hi30pbOwZbhodVWgXojmQvckOw1dhY08LJdNIalOUXfRhow3NI2lc3KjMZycWOtkGa726T9GczXrM0ek+WQfK+XtKMoMEUPuKcnXLw+xTwZ919hOxCT8MyDKoW6iO9zyhPc11LD6RLU3uYlFC4xAQM90kFfisjlx47DF7n6cS7ZiZDRPUSxHJ43w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qETuxfAcbBAi1xLg2hO7FaJh6Ed4lHQZxJRkI57pZHQ=;
 b=rLRxlkN81Zq3WIFDMLfmutX1V/9I3W1NBc+lcOzia1yft7/QNQCTUSPgIMKquO5CigAxzfb1SJxa0WfVAFt5hBU+T2C5eb3dKpnp8npyFssKtwl8Ea+xWfN/nuKfRFRfl2XJRzWiRSde9k9lu9trAXMHZ43I7RKXW9mlFx2QEcSLvQ14HrYsw/ecd/0wVqnU6AHbX/pG7iS8QMXDVfkUQ16sFBYI4RL2xy/bfpVRLQpmkc+2drOTLw5kpGKne7mJK1/T9OLLtKtQmQ4PL6bw71ywu/yBsSLCKjcnPIOL2Lqtzi9fwtqMjPhDkM4kFh6TIj1y/vHc201UHcb/Dpu/TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by CWLP123MB4226.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:bb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.17; Wed, 13 May
 2026 00:55:34 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%2]) with mapi id 15.20.9846.025; Wed, 13 May 2026
 00:55:34 +0000
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
Subject: [PATCH v13 6/8] blk-mq: prevent offlining hk CPUs with associated online isolated CPUs
Date: Tue, 12 May 2026 20:55:07 -0400
Message-ID: <20260513005509.135966-7-atomlin@atomlin.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260513005509.135966-1-atomlin@atomlin.com>
References: <20260513005509.135966-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0103.namprd03.prod.outlook.com
 (2603:10b6:408:fd::18) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|CWLP123MB4226:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b67dd48-5620-4b9e-5a01-08deb08a56fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|7416014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	CiNRfukn2/x8WC4+uXOSfALBajSPAOTx/thvWTLK4v3JagKhDPsIjyf7AZ7QFGUAofbYsYpWHs5YlsnEhJ+j5ci+qP0NV2rRitvkldX+dcQte8Q4hatnaydIyj+vKBf4Nn21gSRtkLy6NkKB3sVLZDAikaErQv4zjqoR3Omefhvhuc/nTilHaeeoDyC8NIcaDwlKV4WX/HpbZ5wCL648x9ZW09sHzlh1BXGxqx0H6wkl7LmQ3ikIZFz2iMMm1xrkPJUUDLh+jTjXfh1lj2QTE05nmxJTfK3te3mIh1uKNNoKLJ5/6odtELM2IXjXZwEABdyym81hD21v9q0qXVW8pbLdW2hU9o4awBWID/D0ZafUyqzI0fimIguk8uUqPGO1t57xO1bNUH9AMxeBQYkS3DHol1xnVDVkIP0LTSIwxdb6lSnmOUqEGkoccT2dOvfbL6+1xp2XPCDy6F2sXdFR1e/gA5t5fELp05sehMJ4yWitD1tdgpOfd/pVAajOFD7VbxEu0RxcreU/FZs8rE7g9t22hqqM/TMQS/Wqks2EOUUsxDwXMAE2TT6rYSPeg9KUSOmr3BMlhzcyny8Jz7lpmQb/P9o5zYBZvyWGveMd4ssyLHKusKrt4mhBt1k5oMqTZk+HLxeZv8JYZxs8YocS2a0OM7p5m2nRrzJB4fvV1G0BvyjPS9kXQq6eVPCfvZlx
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JmlmD4bQJ6UZwjTNdkrWzF1cMDZRem3nckkpc5h5SehKNMN7NdzigH0dW1t0?=
 =?us-ascii?Q?qUnCa3FSvgDp3Zlwhjv4hXHjJeHLxap7vl/cNvPSRUGD5NUFIeu90E2KcsOJ?=
 =?us-ascii?Q?jMLkMIexwoGySaYXHEDvRIbWOP/izwhVExMYj/e/KXUyUfopbh2bux/QNb62?=
 =?us-ascii?Q?/FXufnUoug6GlSzFsxlAG61AO/J3iLWKvELLbL9kilfHayhHqBn5pt4qP80g?=
 =?us-ascii?Q?syUCW9LXoAIpscHeeShUWnwozawHznGNH9yiEdWfxKDs1DBsvW0tZ6LG/69t?=
 =?us-ascii?Q?ZjeT4VZf+OTpFYiZ6DcHWEA8ezFBesV9lPyuBwdAmz6XqRFvnbNSczmReubs?=
 =?us-ascii?Q?yIY/nSf+2A/Y5LFP+KWL2riKuxNOacBgHc9xssBbgvu19pLVuimFkMvBUX/m?=
 =?us-ascii?Q?EqLa7apaS56LgU96/TcTXSvS3lfKfqroB+pn9tIgM5DL9kXFV/eJlEi+OZnv?=
 =?us-ascii?Q?sF9eWQX8bumu/zY9p0hDasqa+E6e/BFWCK1i5g+xGisU7PUjSCueYkHqaiaf?=
 =?us-ascii?Q?1EURx/f5ErJWaUvZv7QeD9iAQeU2epvraxAxCCcDCMPGx3wyQaWdI4SsD+73?=
 =?us-ascii?Q?E4tPa7kw5SceGx5hY+A/iQRJJzCBwnrV4RJ7Prl2gKsa1ilxLpwAR/Etc2EX?=
 =?us-ascii?Q?QA6b8mlO4xyfQi+i3Xd0W/hRf7zgT67J93z30pKRei3tQzWawPhE7qcQE5zV?=
 =?us-ascii?Q?+pVKCPLnZZQPwmyiDqj6n4YCKIN8DowvWgPzaao8oPuUZYNuI8PLr4OPvDKj?=
 =?us-ascii?Q?81UxbqX2uYlJTqPTQ2mSy60VjRkOv36tJsfORAprtl7iAkwmGazJfSoTIW4R?=
 =?us-ascii?Q?NtkE83bVtWq+f8JEekLmrtjv1tC+dV9dn//s7V6EI5boTB4jH3TnL/jrifMr?=
 =?us-ascii?Q?sTYZ4x6rL2EuMEmtqcEp5/MOgmePxN0Pg3bOO1xlOXTxxUEm3Sz6kCD63xJ7?=
 =?us-ascii?Q?D6RiE07xFaNdVarxG1HTGDEM5tg3fAapIS95mGAPyjs9+XpgAZJpvyBn3WdS?=
 =?us-ascii?Q?xNyVEGU52RpwgVJMyXcM308W/BxqkDDN+jEI3icnL2jj6Vz6PuDry/2jwqfI?=
 =?us-ascii?Q?HeoVSAmH2SGOfv130Oj+qRqMObP7r399f4RJ9dgRsV/qB0ZoUBvQSnxHdphG?=
 =?us-ascii?Q?vrb5/FTthWZdZGOkdG53Q2fo7vqiYf9YCXbgrMNNgkQ2Txi5fUc9iWItZVrb?=
 =?us-ascii?Q?r4OLN1SOOtf7R6Wm7zVpM5YOZolASoa5If9UMYn8/gC7hKR4G4Xj1SAsuEV3?=
 =?us-ascii?Q?lmFAKOSJhLAYKtQUckZdev+e7GI3Xg48DnTAkvPHVqzcx7vuv63YyShJEPup?=
 =?us-ascii?Q?SWz2H0TynHc5PnAF8uH8TaQyuJoX7oZM5IgqLiq5YUO0CZYvdBIvDNxqUg+h?=
 =?us-ascii?Q?wmhh3SJRv0ypO6n5yNkzU049jsbAgToKkU4niVEqYGte6yo5WE7R2DqZY07h?=
 =?us-ascii?Q?elPhOyo/ZsUrHEa08fkdB2DfDKRdPFmxp4364/LPQrTggBnfyMsyRlCk4g27?=
 =?us-ascii?Q?UZU7HkaVvBF3swj9BPrg81fS1XYR9autHcxY/U84MPOqNOrgVQXWvTuGFmO9?=
 =?us-ascii?Q?H/tr8aarOdIVCIaxJBAVUbZY+PWAVWf28TkLRqTQE1owmPqvloJqlVrKlzQM?=
 =?us-ascii?Q?kRh2jKZJ4bRSooZf6AknC+zAet1x8dva4Zkb7/Je+BGxG4apQg9IQxsa5ABO?=
 =?us-ascii?Q?bF1wU661QMbDbqHqgXj3LFyvEfvQ5lqPcQOxil0JfSpCela6A6Tvs7pSaMn6?=
 =?us-ascii?Q?s18Tlh1Jrg=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b67dd48-5620-4b9e-5a01-08deb08a56fb
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 00:55:34.5757
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kQjiEWr2YWOTveXCAKM/wrGA4KoqT4U/5qxzJtbHKgYNm0VfEaZhkhBRuISMq9CQfFQ0JTrTalROoDhJ4zZCZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP123MB4226

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
    - Prevented a TOCTOU NULL pointer dereference race against
      concurrent device teardown by using READ_ONCE() to fetch the disk
      pointer]
Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 block/blk-mq.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 4c5c16cce4f8..afe0c0bf7e8a 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3720,6 +3720,57 @@ static bool blk_mq_hctx_has_requests(struct blk_mq_hw_ctx *hctx)
 	return data.has_rq;
 }
 
+static bool blk_mq_hctx_can_offline_hk_cpu(struct blk_mq_hw_ctx *hctx,
+					   unsigned int this_cpu)
+{
+	const struct cpumask *hk_mask = housekeeping_cpumask(HK_TYPE_IO_QUEUE);
+	struct gendisk *disk;
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
+		/*
+		 * Use READ_ONCE() to prevent compiler double-fetch TOCTOU
+		 * issues if the disk is removed concurrently.
+		 */
+		disk = READ_ONCE(hctx->queue->disk);
+		pr_warn("%s: trying to offline hctx%d but online isolated CPU %d is still mapped to it\n",
+			disk ? disk->disk_name : "?", hctx->queue_num,
+			fallback_isolated_cpu);
+		return false;
+	}
+
+	return true;
+}
+
 static bool blk_mq_hctx_has_online_cpu(struct blk_mq_hw_ctx *hctx,
 		unsigned int this_cpu)
 {
@@ -3752,6 +3803,11 @@ static int blk_mq_hctx_notify_offline(unsigned int cpu, struct hlist_node *node)
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

