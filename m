Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022143.outbound.protection.outlook.com [52.101.101.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78060233945;
	Thu, 21 May 2026 23:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.143
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779406211; cv=fail; b=KRgP5jcuLrNbWlxnwPpozaUnNMlzaDOb9f5XuGXU9Z3novfEZc9jyM4szoBc6laS8IPCo3KN+XdEM4WV+/n8HrR41tTc/88G4i5L+jE1ELjzcTmFTrz+jBBMcpfsbq+LppHrUzmfRxcJYUb1Zs0j+Y+tRTNWie4rSqbBt95El+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779406211; c=relaxed/simple;
	bh=H1RSijiFZwChg42ZDOQha8MtLlUmmuZbVL920hVLQGg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iGe9WArMwtO5XazK7lhi2mu2USNbhL4nZR041PcWs3KlY95kC35aZ9xVwChRTV8i7fQ0PuyQ/4UiH7M+lS/HRDUNAPZjWTWqOKNcOLFBnwSuGPabMud5PNH/coI5OMuqyXa9phjCaQPdfEt8rg7Ylhn3BAWSPAJpUA7hrXVNf8Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.101.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TabDCxCICTpEZ7coxKjMnnDLYXvabZ0r53/vz9ASNEtXSf8XKlcghSQNrU1G1JPc2MMYRdIxbD8c7AgZb1ros+KDETgAM7KFMzhZ6aQS7iQFnowosqDdOQznt6mXbN7Ta3IX8PoBfGqjcnTOm8oZ1qbxey/weltZcuKZmOE8Zui/kllKSIHmRENu0uwNu/XX98mrC1EBpezv+7pcp3xf3P92qiLVizjpeCUW6c8z148Te3r+A/8PbS10B1wnYNQhMpTzR77rIjSydHQfQwO9e21065KHfS/dGg4pfzFhl/o8bALFzKyiN5WJwyIA2upXAkzAxzD0q1uOlwiRcnvB1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mNamlmCMt57K1U2lDW4kZvmBXMIcKl5Ky/MTc/Rmaw4=;
 b=RLAKQMrz+h11Ga+e/qwWa6xLKS3KX/L66C2zDm5PgGQxeEg0EuHXnQ9mFlTK8pD9RHHhpyJXNjqnfbrqmX20Yrrw6s6KNngy/BbfeHsZkz5OStL01KhPiAIj1YnpbdMjaI9gffO8wbILFeFdIdHfZWN95pn0+/vnGMztPoRLKBLH9SXRVJhVGTBdiDcp9WpU1N8xDBvkVnUDBhPoQEXPjbXxgI13hmwlVYomYFk4j9m2bxb4bDtksYdMIZvr4Mvg5FLlufKm7K5PgeaQ8aOVuCt+aAQaBhuhdu9VHs/WEIcmg7cjJxSe6GRcQryQXdi2vFoM5OBplTgpEeCrgZgbcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by CWLP123MB6796.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:1e9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Thu, 21 May
 2026 23:30:08 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0048.016; Thu, 21 May 2026
 23:30:08 +0000
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
Subject: [PATCH v15 2/8] lib/group_cpus: remove dead !SMP code
Date: Thu, 21 May 2026 19:29:50 -0400
Message-ID: <20260521232956.553287-3-atomlin@atomlin.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260521232956.553287-1-atomlin@atomlin.com>
References: <20260521232956.553287-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0507.namprd03.prod.outlook.com
 (2603:10b6:408:130::32) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|CWLP123MB6796:EE_
X-MS-Office365-Filtering-Correlation-Id: 041e262e-194f-443c-a153-08deb790e517
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|56012099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	Bgc66qgABsGETBH3AtZAFQw9WwaQ4m8UNFfEzC+namgNLCantm6xgDFQvH6C5NnFFJ60B21tryjUdF4fNYruOAMcEEQG8Kg1ZQPuz9IJunF5dKEDxtp61gKgX5YrcHPGo/l0y5jvrNmYYsFO65YAOHJrtdHSohTspBzKbAX2NcnANK7bkA0q9oIvcDiRKpkc0+y/hDw/3YLwL3gVb1I+KmJEo+fGLoteU4FabmM8X7PWhrh7mGGe6K1vNiUOpXefelvxfzFHuAnDFyTL9CeZnpzxQjfQATxSvXbvR9DCvL2fQbbOF0Lz66RKl/NSNy63LGKdhHWJWwEU2BYFhAsTDYY75S9z3LImlAylqdZmcZ1KDs2uuHnYqcy9YsTJMyMsXh33QRsTvGG8MMKMcvRfKgFiof851uXQhesThh1N4/3Ewv0U0f7ceqQNTSinP9jHMal0u6iAA+ZAqyA6W0BnhuZfpRPVztwv+eqAwOQ29kCrGMbf9aQgz9Q/z6JHOK2KO7HOxHzLFWToA5Ywv2cPLzpNNoxJk8St/4jQgMo4Cjd6MZbqf31uDr35tynupOCuR65/60y8f8RdYsNE5rtWorxvJ5gXQv/sWz3tAE07J07DRjGsK0UgZsofadvWudLk137HI5OvMUvsmTrfO5wz1FFmQ79FVZV3a4+mUAiWX2UJSFOB4tWlNlH92fePhcCx
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(56012099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+2UEo3SI86JK5jy4MMayfHZrAz6LPTBEbbjKcOYUpaGzOL6TmgVPE1iR/2zg?=
 =?us-ascii?Q?7BcVIK/1P0sL+tjjGyu/5qaLKVOPagjUR3RmHJkzdKEsqWgDYrFI1r2mpy77?=
 =?us-ascii?Q?JrvWyVCvTwLEOUHFQHqpKPD9pCPK9aS9pkosi5dbrreuM9Ju7DUIcGedlUYb?=
 =?us-ascii?Q?A9fHNp1Da4XXXQaBvAkJTj9Su2kdemU4UsbmWO8S7IXk4qY2aBi1VqX7cT2E?=
 =?us-ascii?Q?X9Gp03EAcLCxV+Id9RLoWR8ivgokJMkwAy7Q9kdubIukqPU3JOTRYLnY+bo1?=
 =?us-ascii?Q?IGktwCFSuZYrSOnfwA3+HtlJSVlOzHVV3NxADOlQIlDS6J1MY/25qKqDyGef?=
 =?us-ascii?Q?aWHAG3PJj83qbSW53ocmpt2/U6T4FyMGF8q/1t8vpgtLblZe5rsj+IDuFIUZ?=
 =?us-ascii?Q?2CDFIJDw826lLevqGvPOpMkXfQP3nW/qaWn7O+aLxPSRmAXTSJ9KYQsgF4+F?=
 =?us-ascii?Q?UunlNJ1zzxBZ3FuKL9ODdw7MpCnB2r5CfD9Es0P1kZrpdjrP3lkCj/AlRbOH?=
 =?us-ascii?Q?JhKQSgWXzaCvNYK43JbJokEjKhN2A3mDsyuzW59y6aprpjogejNOT554YLfm?=
 =?us-ascii?Q?xOg/1NhJplPc87VnRIMCMN96fV5WYPTNxmPZZflewknqzuz3HqaJ0p3h44BE?=
 =?us-ascii?Q?9VZ1D/LcTnNJWFoeCCz4vIoq4H5dKnFrm/l5svhGa1vYxHEDDKvjw9P9Huk6?=
 =?us-ascii?Q?FFXU7WdJuzffN+8mP8X4mQMbqh1In9OS160U0eaDuqcktzLr7qDoT8yuTkzO?=
 =?us-ascii?Q?smDXnpvQb0YSDLlxQlHA4Otdh54800w9NU8ZEjTL4gZtKWvd3tVy1Vc0Bd4r?=
 =?us-ascii?Q?LyTE+uN1/cU3pRDvohYq3rnT9pvy3EfcfvWSPsLbphgqmAdV9GOJ0LGOegsU?=
 =?us-ascii?Q?wqxvlODrDKQcWbNA/D7Cy+qS171HNn5VCe6L1MpRU62PplXj8uweyj7/ebiW?=
 =?us-ascii?Q?SalZXMOoX2NZ2raTz0/COIOBB/+O/mzofdHIt9Cv/eMbeSiY8iOznvw0QYV+?=
 =?us-ascii?Q?R0OasMLw8+MT0sjlMekM5ZxoZz+RlvH0mzwt1em2rZUGGVPauEJEIfXmXhnC?=
 =?us-ascii?Q?bFRdc/N7PlHbQDulM6PzaptUuIfHaGNzV63OKpzf/MnUnBe3BaPgAUrrEBRR?=
 =?us-ascii?Q?NlPewtGYnMozdbw27Xe5AgQ/yxAMW5Q8b1Vq8iVzZyg9fxz8SYbVL15ibHMG?=
 =?us-ascii?Q?nu8VOmK1FKmxAP4+jyXRCLXA0D3I8NVz2svhh6yyMcmqU5Xs965W6KA7pB+i?=
 =?us-ascii?Q?8q3Z0q51AxWec9X4XgZu/bPfwDhAWbn/GF8balF6rK1yvNdlEGAkSaZ1vixm?=
 =?us-ascii?Q?2W6KuWufnLl/7J+nt9s8LyxuR6X/4egCD3Qy6N8i1s2pdwbYbCMNZpaeRUeq?=
 =?us-ascii?Q?H2DEFSTqY/7emk0gNIIzbakLheh8fAYjX3n3VjOEoiupxIXiEpxoYfISXJTr?=
 =?us-ascii?Q?mov53+9fTlo0DCp47fe+/UWX8857oELtMATfesWXEa9lmfKHclFCRVoD3H6a?=
 =?us-ascii?Q?gwTi8p8sSd3D2iDLZCnqUq0xUA92nPQR7Ge3s1r2eSU+SYvg/cBnhHZtsw4W?=
 =?us-ascii?Q?CiiFTks2w33TVNm+RqhXi7mIG4ryrdXN5WI7jEX+g+YSDwlLlJsC414bgdky?=
 =?us-ascii?Q?j46PvEU74jqxD1U62FC6hcBQS+WV4AFZYPwDQspHnbKhPzmngZqSUSsgVDCP?=
 =?us-ascii?Q?Y6x1ORZHfL8J1rGhlq5A6o3w4dtgiLNSoRCDHPvAxFjZO+ogrnR90fQBtOHh?=
 =?us-ascii?Q?20cxhm/GRw=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 041e262e-194f-443c-a153-08deb790e517
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 23:30:08.1447
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UFoiPDxDHh1TwDao8/Tbksqid83B8595P3fzsh0ubGflprGR03GyyO32z9QOb96aj9ryTpTaFMyXGhlCkUOwWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP123MB6796

From: Daniel Wagner <wagi@kernel.org>

The core scheduler recently transitioned to compiling SMP data
structures unconditionally to reduce code complexity - see commit
cac5cefbade9 ("sched/smp: Make SMP unconditional").

In alignment with this philosophy of reducing dual-path maintenance,
this patch removes the #ifdef CONFIG_SMP guards and the dedicated !SMP
fallback logic here.

While the !SMP path provided a slightly simpler execution flow for
uniprocessor kernels (avoiding SMP-specific overhead), maintaining these
separate code paths adds unnecessary complexity and testing burden.
Removing these guards simplifies the codebase by standardizing entirely
on the SMP logic, which safely resolves to single-CPU operations on UP
configurations.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
[atomlin: Updated commit message to clarify !SMP removal context]
Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 lib/group_cpus.c | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/lib/group_cpus.c b/lib/group_cpus.c
index e6e18d7a49bb..b8d54398f88a 100644
--- a/lib/group_cpus.c
+++ b/lib/group_cpus.c
@@ -9,8 +9,6 @@
 #include <linux/sort.h>
 #include <linux/group_cpus.h>
 
-#ifdef CONFIG_SMP
-
 static void grp_spread_init_one(struct cpumask *irqmsk, struct cpumask *nmsk,
 				unsigned int cpus_per_grp)
 {
@@ -564,22 +562,4 @@ struct cpumask *group_cpus_evenly(unsigned int numgrps, unsigned int *nummasks)
 	*nummasks = min(nr_present + nr_others, numgrps);
 	return masks;
 }
-#else /* CONFIG_SMP */
-struct cpumask *group_cpus_evenly(unsigned int numgrps, unsigned int *nummasks)
-{
-	struct cpumask *masks;
-
-	if (numgrps == 0)
-		return NULL;
-
-	masks = kzalloc_objs(*masks, numgrps);
-	if (!masks)
-		return NULL;
-
-	/* assign all CPUs(cpu 0) to the 1st group only */
-	cpumask_copy(&masks[0], cpu_possible_mask);
-	*nummasks = 1;
-	return masks;
-}
-#endif /* CONFIG_SMP */
 EXPORT_SYMBOL_GPL(group_cpus_evenly);
-- 
2.51.0

