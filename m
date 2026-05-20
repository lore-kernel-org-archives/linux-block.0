Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021073.outbound.protection.outlook.com [52.101.95.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C633A0E85;
	Wed, 20 May 2026 21:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779313844; cv=fail; b=cgwsTzQK55qEWJZyZiKXQk0FMDvXt2R9jrltr63v80WJYn6KIOcqjdIKXutSsVHklVhlAmFkOk3NTdbjl9nBaD4Vwt8PEIolUZgIlw6PCwbYahlaYOm3dBCNpNRUcCsmusXtpZ6WPN+cPwq5Rh5xSjDCz8/K7dtce2RP01utRWk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779313844; c=relaxed/simple;
	bh=H1RSijiFZwChg42ZDOQha8MtLlUmmuZbVL920hVLQGg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uUifJPWnz4unxr3ymH7NTpVX6zOkDuxMH03WlChYFRpq78zdOcWyO4dUbFMNS7aemLdy5DqvnpQHwYGTyTH/WEAIJdOB3PB/yNt8xsfrQn6flQ97AyHhU7iZ4097ep70ZGDed/mZ/kvyyvzqUfOKwIOqs5R2udqedtSQS5cqO0g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.95.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aoBOrAD49EDvgLVQkb8poCwevyFCv3+AI1LQ0FRkpy6zeuFXvrNMpvg6mgiTv/FzzxecLS1TomPxc4ZLYVCl2DKjvu2Sd+yiEylyaDHOk8TzGN5YJ0Hy/Ihko+y1Iy2ODoxTtHB4tXvnA1GacapWhl5UuY6RLJcmxoMaWbFnKji9mKtDogXR46iKKXxnz3RS409RZ7JNpM+A3qqBQKWjjy4CcVohOhfNW1tOsSflntiM2tILUzAE5a/w5vdIb62vVsH3286US1LxA5ZuIFNHI8Ot6J0OdRrw2MtvRpwdrH0erHS83PVrK5aJXQ4MsIx/ew1jqk31kV8CQCNiCKXMFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mNamlmCMt57K1U2lDW4kZvmBXMIcKl5Ky/MTc/Rmaw4=;
 b=bEezhEz1lZUT5v4TKlbrkbpzMHk5tsm+7KZF2D9Nt63XwmmzQSmNixf7X1d/G0WfLfb//rg2hFtY3RkA8yZ+0e8Y3/7/7tQsqw+Sk2YXSTZVTFMkrKtk7xXXq18n1OpIIu09nce54iUIClPHUhnYIeCZhNi9z89anC8ue3Ro+WEBCDcYojUn3qw4NYsL8osXpmKaWNcfbOW9ubhNvHapnZyQEW7PsC7cW7bVl4PBkVZsXvB5X4C32NnfPb63+ey8AzZWLCc8qPjAXeNVVKXMR8gHjAvMxMGmHD1dOXHOWo9qhvjn6rg8sxHMJL/ToUc5Wzx9Isps7sCGX9EgTEXjcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by LO4P123MB6626.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:278::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.16; Wed, 20 May
 2026 21:50:41 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%2]) with mapi id 15.20.9846.025; Wed, 20 May 2026
 21:50:41 +0000
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
Subject: [PATCH v14 2/8] lib/group_cpus: remove dead !SMP code
Date: Wed, 20 May 2026 17:50:24 -0400
Message-ID: <20260520215030.496803-3-atomlin@atomlin.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260520215030.496803-1-atomlin@atomlin.com>
References: <20260520215030.496803-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0PR05CA0022.namprd05.prod.outlook.com
 (2603:10b6:208:52c::22) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|LO4P123MB6626:EE_
X-MS-Office365-Filtering-Correlation-Id: 92fc7957-9136-4d27-31f6-08deb6b9d66f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|6133799003|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Ygqn3vxwSt4e9mZRd+yzGhGiU1DAGgiEFvWbjc3ZJNuzMd1gzcHgPj/e4nPmdJjGxU591yUcBONx1cEKLcZQg01heZQOuqSs6WtP9uUGgJV68/zc/60b78CPYdnrh1nCZSOrxGVsdKXpM7qk3jRx/M8P4+HQpmg+3rY3Tq1tRvCgqKBNYtvKVWKSi2tdOf1elZkvaR7hlssXUpBUk8ATVdocZLNGVqlD6/j8t/jKSbRPt1dvGBI4ScI4pcOLF+8yejcBTy8Bu6mtUuDFWJEEOPV5duNQ2xE/hRTE/gerToB/Bp/e2WB5hBlYUJJ+/KY8DJRalI+virTcI3FJOCaVT+jnVGTw94BHCN8mctaNXI5RSsOTjz52RR1AvCrPht7z4XxmvqbbQCoql5cEmoxbn0H4SA66XRrh5xeqrw8xIkNCWI/QNPcnrXfnhWct2mQAs7SiP0lQNzBY01i0udesbcFL8WQ7Z6uS3e78NwH+JEiMVaOVdwSqeTZ739fetNGVUlDHuAm580rSc62mLLYbMG6rJgslhbkqwizGFJHSJJtUKCHr6m3S+tm+5xfXgxAWaHjpU0Wk7jY+5RgyAPYbC5AIzz5XipiaFpd2Pynj12fPgh+mdBUMYFTH5h9SPraMFXxjzgLmEetXaHB1KhTkBr5TIj+tTYcrGuPdf25T2VqGwfTnrBhcLBogvH1sAOt2
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(6133799003)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yaBjRBPEIDGCeXq8OQSwz5tLM14iwaTb51IdLDXHPqFRRTJo28nlch26uXHu?=
 =?us-ascii?Q?AZM9WqMxiGB1rwCHPHPcHOBut4sG3WrGK/1f/Y+6aWtd8CiesV8zs9GisJwu?=
 =?us-ascii?Q?iYXKvNA66wa9Vbo8unWR425zpROecJ1O2XQJVi3Y7FB0h16NRF8Pdl4DM3Ih?=
 =?us-ascii?Q?afksEoQMInncV1oOhBQIkZo6ZXdKSLuvwqzVotFALgQXdWL8gfhCvd1fqku1?=
 =?us-ascii?Q?2kYNMcjHVaGFno8JxEtO95AxG6kBtyjG47sYDF3PecxKekYvOOmQj/FCnoQE?=
 =?us-ascii?Q?p38+RJNu6ISRXitPZYuWfKyksyzs1rGnQ7HNZwwx6I5M0OL3KM4odbUS1n9u?=
 =?us-ascii?Q?qYYQDcnNsEnK35nRiyZdMhsXRZz97QjrZCZI0nZqVHhOw1Aycp8F6RM7kRxH?=
 =?us-ascii?Q?BwXoPnu5jCgA2uOTq1/wAIjc0tO4RXltERE3EWnyqY6ZZ2nUqFmlUaKy3Fec?=
 =?us-ascii?Q?ge9QFo9tivSO1iTot1sZxyOrTcFuFZmj7mKCgSwa8RTmn332g270aAccxvMG?=
 =?us-ascii?Q?hHA0ySjNLVJUHBelitL9sZ0OdffvnHgGdZdExzqjwPtucLekXGumzt7trVvK?=
 =?us-ascii?Q?aaU1po2MUY3rUi8h/aGB1pO2HkIRPgKTfhFVn1hh4N5LjIp8UfXM1BRvLfa4?=
 =?us-ascii?Q?tBhkQJe/1mRtEjA3ST8Hpp1Xq4K9xxaKm0/rzmsviFsif2CEsgtmhhHWFKlg?=
 =?us-ascii?Q?L8ry6TofrLbIgCISW/8uCLY2aGefvI+BFrRi62t5EtJ95wmI+UKWhnffg8I+?=
 =?us-ascii?Q?ZrNGGBA86vq1uY3JM6xhNd3D9n9aalvBkN3cm9/VlOco2gr88/tHEaVrW83i?=
 =?us-ascii?Q?+B5wrGXQyUo5TGC/vJXPJ7Cswl2J19pLQD+wB7a4kcjFK1oYabBL+yF9jTs+?=
 =?us-ascii?Q?MguNgweQAwClWVPODK8W8JvEgTjPvcrY1DLqOSzo0Ar4CPdfHr0brm9Vz+m7?=
 =?us-ascii?Q?+0AGL10R+Uoz4QNOMsLLleA0kWf3MfPSLQJ0rEB1zVx7eQqfY8AwcTY9kOkA?=
 =?us-ascii?Q?It0KdSioKNyeJs2rVp7+gqisUmvwI1UHxLm2NlJJrr+laEu6U6EfYsKWNBfc?=
 =?us-ascii?Q?qD1qJ/OaUIXDmhRTQ01xXe8RONNdNn+ZNEHtPDWEdmohJuoek4Y0B8Lb6C8n?=
 =?us-ascii?Q?d69v4INlOuYENQmjds9tG7UbFdGnnVE21Uuj8GOfoZsv7R10guDAT8Iahl7Q?=
 =?us-ascii?Q?vCgcHFSmUEUmtQOvTJ7U7tHrXxLxmDnooXS79Og4vLWqJr5vfpBub//kypJ9?=
 =?us-ascii?Q?HHuISgZI+dtQdb6hsj7lWjRV6RCb5ApLkDnbEeXf4j0sXowXnmnd21WTjRfw?=
 =?us-ascii?Q?im/z4HjN9QrmUkVUMZcBhlrfzrBfBgSP9MILc09Wdi5TSh6/Hk0sBBdF3dmB?=
 =?us-ascii?Q?gchJZllu/xUKweYJRCydNIE75Svj7zpVCSpIKZZHswkpECjofbWiPOMTGSPE?=
 =?us-ascii?Q?AscjHUFOtZgxIzkLKdXfF7XOk4i2GAK2JjMgsrRxQ/S3VgliXVvgw8b4n8/p?=
 =?us-ascii?Q?wDH/ypMq6AchIVLKa70I2LHNWLaKA34F2t8IEGJq15G4Vp1YUoAf6BPLIdhq?=
 =?us-ascii?Q?de+zIX4wGLXKINvJCCUVOmmqxJ8LA4dWgw+p+/D6zlZeZ6aZlVPc65DmUivZ?=
 =?us-ascii?Q?dOEmm2r0Q3ELGU9m68HHULvQzbzGp7ryCz0Wv1/vHx0tzHGdDwxRtcCKOfqL?=
 =?us-ascii?Q?y0MI5Cf/IdNow02WcBRrDy3EwwgP8LSFvGSopA77kEXCzc+QOvNVs+Otx+og?=
 =?us-ascii?Q?OxkyaaPsBQ=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92fc7957-9136-4d27-31f6-08deb6b9d66f
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 21:50:41.8176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aN1XvS5bI8h+aoMwYbBaRodVA+THGjJHhhAcgRfmf4tJq0GnmnyCGRtP+aidNpT/dt8f4OzP/2M7B0yMvO+9dQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P123MB6626

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

