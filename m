Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022080.outbound.protection.outlook.com [52.101.101.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B40230171C;
	Thu, 21 May 2026 23:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779406229; cv=fail; b=sM0VuGzu43Kuch/1IrMcBcBdOG5Olebk0VwrRNOA96GzzVa+RgqPUak/dw0XtE5M3GCNe2nDj+yFRhj6FirBFc+BEmV8z68DP50ok6hfArsjjk1jzJU5UAARMaC2VdBBuGPksk1j7QWJ8NZXdqPWeeE87D9UN2sPlOHC2YAOwC8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779406229; c=relaxed/simple;
	bh=OdWs1ceZuEZ71bGNu0xzYRu6CB0pW0uYrTHr4NIOhgg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PkkkfcxjViRxhMTsN113tLxbTdflhwOzDE5szJyiHuxARO/5QMxiQ7yKHRCePug0j2Jk++7qPjOqIxMTt9ruzz+Xhfe+ZX83hSm5b4Vln5DVPhdveb0V9efsEt4FFBe8UR8uO9u7b9X4iqK7pS/pbTV/m87cJwfkZO/IOYeUg0k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.101.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UAjDc2hGhtviQgkZoENmoNN+NDi0XmdVo0kdx1mTBdxMyLof89hcn8C7CFIKG7TTaibAoUrEDMH9BxuLLF2ImUGvM7lwIumfDmwhCKxpOf3bjJYMVpS1iA3urML6/c/PGGTPHv/vPJF5SeKgfv7cjlCAW+0xpLo7KWXAPzOokdpxiova9C8BN/nKSic8Mh2k2gmOZACt9Bsjv6QnUR760SuEo+5jTfcUC/PawwGK0rjOQnboTldjIlvqRjnrGW9VZJjl08/5ogHgvRAyh6EmhUUv92jYFn6thW8Y+cifJ0Uh5fyQOTgYcziiUU5IiCbBb3jBlM8E3nHwI4uE2wyHXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y4PX8b0OAm0JQBto5bTCOyRI0qc67fJoLfgrC2yRoK0=;
 b=YFrFtXGDkHF31XvObyD9rUVdtn7m0aIbd0q4DI7YkuniacTddr7fmzD1st9eA4y5tFmVNPZFbzA5FyCItAS4NI4kXlHwlafjt6MX/deorVd1li+6/oVKSt28YfEeMwO3w6L63LVmPv7tM7US+IeKwiitAaX+eRHnFQkRekvCmeAjVdKeUDeL0Q1TVCrDBnhR/yuECFpl+En4P2Wv0odZl9jgf8Xy4R+5OZ7BcbXV13yeqzugz+LejB+p8Z2mZAsoQ6FwDzTohJNefq/3GSaXys+WGtAVHQPl/PMS4EU73nczQUxUzWslsmcozoacg2P9i3+PLWs5e7MFPPYbKzJbRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by CWLP123MB6796.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:1e9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Thu, 21 May
 2026 23:30:24 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0048.016; Thu, 21 May 2026
 23:30:24 +0000
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
Subject: [PATCH v15 6/8] blk-mq: prevent offlining hk CPUs with associated online isolated CPUs
Date: Thu, 21 May 2026 19:29:54 -0400
Message-ID: <20260521232956.553287-7-atomlin@atomlin.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260521232956.553287-1-atomlin@atomlin.com>
References: <20260521232956.553287-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0197.namprd03.prod.outlook.com
 (2603:10b6:408:f9::22) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|CWLP123MB6796:EE_
X-MS-Office365-Filtering-Correlation-Id: d2428867-67d3-4d66-7a63-08deb790eec4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|56012099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	19J4qrvhfCtrb0MSyWzblPmRxnnjpEoJgdhGF4ZBU+9iX6UNITYPG47jL/NJGvItzCuPWSUMt931eo3iBRUkXJan9uOch99l825gwinQWbJT0jdSGKcbHyguY4OmmmW02ujJ6I/BYAtD+GV0bFZ6PYPfdo+fX0BEtr3K/HXraqpn45N3zGqmVpsy6AWQPIWX8Fgqfydf91CwXY2IO6l8T5ovotViNWVWJEaVs6QvjYBURbswwL4DKv0dE05fqSYLU98OEDmnkKqsvb1jIa5YrXqi3ynxFD+nIBKfLETVD7MsBn9joMYMPRhqcQQB+PD1hzZAiisoItIGRUwzG9czXmdjVDeIxJAQiDQLa5tFKWUD/k9f+YwlwhKCiZebxrryO3EvHpwtwGRIS6EyZG0tQXEMpex2WzTSr5XjaNxcHkTbxhoEL2U90Mq0xP3Ntd1qP0beKsLUOFl0L3eu4yU+ZI5jxeSFA8lr72qGgUUHka7XPG1n9jPfE9T680lNYoZIFyuS2O6GPtws7nqWZoapdnnHk6Gw6H+iAbDE8sKmY9R3Ilw4HfOhCoalK/NKYRJ7tOiZ6Jpa5RBw3DRkMS4u+k9+8194+O4JKZ4gopoACwi/aYLqXpj5sAhnKzhPZYvPxlKOHADhSQFImufgfEZ2WXFhNmS/mulOgL1Lt+8AIsik1SrHojZ0yG8/yRqfq5tU
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(56012099003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?a+mFIWlKj0rE4bYGvKfxNaJLSxoyX2M7SWqQzP1GrZSad7qMfiP/9maQu7mF?=
 =?us-ascii?Q?DabUXaLlO//UKejS3l7if3xEICwc94KQyHNRXAx9gxgBQSjRBVOhrgXV2sVW?=
 =?us-ascii?Q?1rjjysRtm5hIK5gw3UW2slBmG8LEvy5koFQJFIezz4U71/J0qLizCQNj3PPJ?=
 =?us-ascii?Q?d0FCjZvmXtcSPzPyqWOs9nTBaz7U1YxdOsg3Kdg3L3o/CHn5+cf3/AFtaai2?=
 =?us-ascii?Q?OdUxIXCXCNUlbOT2/hrJZmeWgGHb36Ap9EpFBVxv5y7WhrYC0BJAudVmBxqK?=
 =?us-ascii?Q?ImBb3UXQLRdgksnT+BUqnTfInQnTqnm29k5xxyXlgXA1MFxnhaNdYcsA2SxY?=
 =?us-ascii?Q?NpqwM7LLT4k0sYsH6pSVWc+vB1aPribx9jZ+vnnefzEz6/4ffvs7BnCtJrP9?=
 =?us-ascii?Q?i33/p/k3+JfUQJlIfCySAfLhVXj/aGgareWXuqNOT2C8PgvgtPWROQbdhhjY?=
 =?us-ascii?Q?5fseFIT7MR1HQw5DNUPgbRCztE/0qJETGDa/+6ioaXiV7rDk0U9Agxp3nTSB?=
 =?us-ascii?Q?dfJ1McR8GPTr5WSVGlV340yjxHOx3Q5xrhliAvV6mWM/EdH+xTHZFIoQ11iY?=
 =?us-ascii?Q?bJxCgA8UF335SNorhDP+JZVvdUxl8gN0lR9YcJ2IfzIguKUEWy/AobtqJbLI?=
 =?us-ascii?Q?PR7RCK9GeR9U52LovdNqlu15231ayFcvhfFRi+r/IfvuA5o7WMbEzc9Vnw15?=
 =?us-ascii?Q?vMWrw/C+40HOhuPdazCOChyR3r+DZMlM9z3O/u19SFT4VrrfNZzd/y9fhgVS?=
 =?us-ascii?Q?CHBCZMsnkfZKbQWtb67G2wp3l8papKRpSDkYK+68fEnLl0sAy3cYj8N23ebw?=
 =?us-ascii?Q?nkqVpIHdKKMa8Kys3HSrt5zukBYdPawwYv7cs1mTW8tMHomF0eXkAkfJY2Tl?=
 =?us-ascii?Q?XjB804Z0fzRUNo9O63442+9n5tKECkXfwqHY/5A+mKl4bpToBTuY1vd5IEKm?=
 =?us-ascii?Q?h049xpFfwfQBBsvWz0OHSK6qWUO2DHULJUpIUvsWiSyvGFus/IGY38bLVr5+?=
 =?us-ascii?Q?KWVSzJ8+99HKTV/xo1tp+rkB73UYm2+8/xto9GPu4yFcQuNrcFZRRfcZLqOr?=
 =?us-ascii?Q?4rL3ye+C84D3S+ypbguIpr2b8PPyf1p3AMLUZ1jFuUvflNk/arK5H7M2Sqiq?=
 =?us-ascii?Q?PqN0sdc8qFZZfHVz133cNT1RQakrXGCQrV1jW449fJatsvS34a69bQ7FUIDN?=
 =?us-ascii?Q?gn9bbbKkIuPWo3fUdc/fBnKDQ0HQtnidWKH9lnIfjF0ZFhcaRn+Qg0bCf6Fj?=
 =?us-ascii?Q?Snxo0Z2ui45VWbkt+gUyQ/dMLpq70ieQWysPO8iL2/SS2YBodWvAABanEaAx?=
 =?us-ascii?Q?MN1rF4xLO22MTZ0s+SN9EcoeDj7ApuWXDy7OvC9j0pq3ufRbA0XTEcx2iTAv?=
 =?us-ascii?Q?z0yH1mMDB43VACHorrVbpV+wVIXB3IUWvIe1xqAqbSC3/iMYG1fYBrP3yDYD?=
 =?us-ascii?Q?UJUPMVBLu8ECzC/QwvV6EThxd2zgkaTzH8rZeH6kr9H1Jk7FndfwP90JHVuv?=
 =?us-ascii?Q?K2K+uCrpHXXCrzXaJntdq1jN0GqwRCWSurKX/L9j4H1V03ymrH1mmOwlHSMA?=
 =?us-ascii?Q?HRpSLDEiT+a3egxVFKCg+IYaOTcFGrrHWDhZ1vHkZ3UDNW2gCNggpiINihB9?=
 =?us-ascii?Q?3Br62TvCn+34MXANEFuRCOwTCNnO3pqMd6ThHv0A1bya4J9kkxSSzOP+VvGA?=
 =?us-ascii?Q?r5zgM2ByWT+UPPA20GPEXOBCzPJxb4ov2DRghd0fJRBjazmN2AZraJ6R5vsq?=
 =?us-ascii?Q?A27XzpYNkw=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2428867-67d3-4d66-7a63-08deb790eec4
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 23:30:24.3927
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vZtInB+PG0iIm4oOSu0dM1oy3lMaH1p0NrM2n0pEtcvkE/17Ws8zqru7kLSO6DDXV06aFRxVskHdmitZTzWgrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP123MB6796

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
    - Drop hctx->queue->disk->disk_name from warning to avoid UAF bug
    - Ensure isolation constraints are only enforced for CPUs actively
      mapped to the evaluated hardware queue
    - Correct pr_warn format specifier]
Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 block/blk-mq.c | 55 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index d0c37daf568f..7c3f4d6546f0 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3739,6 +3739,56 @@ static bool blk_mq_hctx_has_requests(struct blk_mq_hw_ctx *hctx)
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
+	 * If this CPU is not mapped to this specific hardware context,
+	 * offlining it will not affect the context's I/O routing. Allow it.
+	 */
+	if (blk_mq_map_queue_type(hctx->queue, hctx->type, this_cpu) != hctx)
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
+		pr_warn("blk-mq: trying to offline hctx%u but online isolated CPU %d is still mapped to it\n",
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
@@ -3771,6 +3821,11 @@ static int blk_mq_hctx_notify_offline(unsigned int cpu, struct hlist_node *node)
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

