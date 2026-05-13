Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022114.outbound.protection.outlook.com [52.101.101.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC4229BDBD;
	Wed, 13 May 2026 00:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778633731; cv=fail; b=pWf1NP8MUaMzrDY3Zgia3Hu18YeBG/AB3ZQedy1IZup20tLI6cs0O6HPZ0HGxNBlfrFcHgCnoaVd6xvXs5Z3Se8odO7IJs9e50/JBDlCf4FhwnTdZ3au53M+sASR+3l/mILTvHPYGqB9om232QIgWTZiMQGL2yAnQCNNFN3PIiU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778633731; c=relaxed/simple;
	bh=e+GLj/od8aW6hP+C4zeK/EV8wQghaKWNz13PZblqiTE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YE82C5rIsw0wAzF97HX58Cai2ZqMoMBGdsMiHynqbzx1DoQfxDuwT9lWBgRLVrZOsADiqUXOIaR/gbKRoGLt7GwIu5IAkVe9fNuMwFvR9NWJbpvKEkeMZyYOkk8OgLAdpTq8Di59vof/dP+AeGaMxox+MBNFQ4AYjfequQU5Foo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.101.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MoJDABMYCGJYSXD24ypZXlRGEtWQDRvhAhilCC+O95rC8tsMimhJ1RPCd1ooLY9GqBkQOZd7nTpguui7FgFaP85XLBuSuwLWRFvnW1btVovlqUzSrnzUDI37t6HNv7lSqB/EZ9/exTpWc5texfqG8jGp6TXXbAJvraPL5pjgyngetJJs71UG+NuV/vGExkd0nwCGYpwkLGBC4O2jymufNgPvU4lCjfiEIDNzbkcbIPye9EQLVF5a7n+1ZWaoCGRn+DEkXxB5mAj5ErczqxPAbGW3e2IBXeRtCS7T8MOlXquZdixzJPnf7sTIoTLnlPfEirjoSFZQVMxWV6UfGViRHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yxmsVF9BcruDQVuzOgTuQiNP4A1fOg7rMbhpo0DxUE0=;
 b=Z1tZO4clD1yAsFw4rPUOy64hxvd9sUxlUkYSCRGLm2AbadgfSfejZtP226SQC1xoE+TNf8qAwoTGXmA6aeX+t/Re5HG1lM40B5rHCJTl/d1x0tycmQM4yirZpZgFep5dh3WumzS1eIFixPgdM4UFNy6/fQRjZkh4BiYJMCIZoIuqa85Z8aIPRmBRixfmPCv1+kSOVeZtsocka2H2K6WlfqKWmnXfl0pRHYoG0Nicy82h+esHBo+5X/tsGHIP+yE9TvQ5wLgT3AdPVD7REXPP3RbJFytas/0RlpMpzjvytRy9Ht2Qd9amh9+VfGdfrLXMqqcu0xBu2LspFoJZDs2gEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by CWLP123MB4226.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:bb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.17; Wed, 13 May
 2026 00:55:27 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%2]) with mapi id 15.20.9846.025; Wed, 13 May 2026
 00:55:27 +0000
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
Subject: [PATCH v13 4/8] isolation: Introduce io_queue isolcpus type
Date: Tue, 12 May 2026 20:55:05 -0400
Message-ID: <20260513005509.135966-5-atomlin@atomlin.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260513005509.135966-1-atomlin@atomlin.com>
References: <20260513005509.135966-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR03CA0004.namprd03.prod.outlook.com
 (2603:10b6:408:e6::9) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|CWLP123MB4226:EE_
X-MS-Office365-Filtering-Correlation-Id: 611b4106-9342-40b2-4847-08deb08a52b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|7416014|3023799003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	P0qAPv07Ol9R17P+bQE0QuGdwCZCsHiuzu/zDbbfjdvw2Td/Gkp2hBcIQw9Tkg90sAImoYn48r2r2aA08njd6a7kV0ttqGZMnp3dkY1ooRB6/z9XcEG5oeA4sjpHHtYA/Qm0JkIwCVz6YBBMy0Gmlj8+0VU8J5dPnBjEp3BrOebUm1LfDnTLGPUGvaHju16unHA6yYN9ZLgfjbwj0SC5ehgroAKLtjPSDSu3rt6FGNPgqu/FjIOD0Q8B0YQcsnZriUAfrcnMKhl8qXNb0Ez8Ocy8XMTrCpkArGLNGC261TF2LUb84yQEVxs3eme1dmP+2rk1y3kUL2b338ICi9tvnGTQUasvY+fSsnZGkt6a2lzX4QMFSm7riux6YzfTWTwWLgIZ36uJ3ZRJhALh66UN9PHuhAQ8fYaBHccwo3/zbd5W1Gueq0a5mi9joduiFWV6iqRLmt/8hY7yukzWmUrcqRbImDJNlHdRhGGUTrX0cONbA8Siuogduq+WojBYgA1Ya+8aTXHpj1Ra3kfTc4ZA2o8omRb50rSG9fxp43PERrZz4uHJwCfQPI/UubP/3ppGhIwqeHY0HK/hfYHDttWssa7xxnKDbVk45gi29RqayJIYf9JkFpyAWICZ5+kbkP/J6fzwwSO3zU+eJjnOlCQ+pAxT276Qv0BiEGI/BZbG6bp9FsHAcr80MPWAtVSnoHKd
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(3023799003)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KJz3SpnUsuhKos2hP5f0Pp6zrDAU1Q9U2QZMCITG8kc93zE4Zw3AIDajL9cl?=
 =?us-ascii?Q?MAWCJTsNOY4ldDdUK90BxHJ8t8VjoUX1C0XXW5S999z5z0Q2a3irD/iGuZLs?=
 =?us-ascii?Q?JqgHBbf4fvtA8tFWf80NyltRbSpl4D2XfcemzbymK5SVGDoOK4Rz6esfW4KL?=
 =?us-ascii?Q?+ciI2Dm7xqhkiGP5GPjUizQKTx1t4aDZq4i3A98rGvyE2bSdYz8szAUWqFoQ?=
 =?us-ascii?Q?Fn0TIdiY4QRtfxOTXUoBM9sqXRLvCsX1Smph/8/t4pyZjYzYPjfkwYNDC8hs?=
 =?us-ascii?Q?C1p1Yk6Sq/LUmx1bCbI9uw4aYsqFSygYRdhzLDGnmyeVbIvdN92VpPmx5xSV?=
 =?us-ascii?Q?3UTmytFWbo0uPivbfg+9RQXO800rluXy81c7toStyvFroryucHXqq6qa/jDt?=
 =?us-ascii?Q?Jmv7VLBMP1C2klZuUB0nQuT3cNhEOWozxpObO9vJryaBZDqwcZImlA+sMIrc?=
 =?us-ascii?Q?Xu7epMeBXDZ7F5VDUD4wsv4EqHCQIGDNdoVKBKBk/iD4/V/9s5IjrlVls7IT?=
 =?us-ascii?Q?x1cLDAiyF8ZZOergdgjiY8NqZHSBEbMmDfO9U4EqVfixFlQOHorOAwL7V4lW?=
 =?us-ascii?Q?7Fx0q5UjQYsu06MBeZPMTVa8GX9KL//ktPCAMu+tlnKcJOdhpHEYogLxC7r7?=
 =?us-ascii?Q?xw5AcADfgAAnjRHQuOuZUWJukTxQWQaLQPrGtBWIFNg5XkDB1guDDMtbgvB6?=
 =?us-ascii?Q?mN4i2zMtMX33OtO6rBMoX4qOta9XtiytHyPETwofBuzCnchgp54jV1Fb8O6f?=
 =?us-ascii?Q?CKlB9ODFw1gkoWZwVzvrXKV2vpugCak/soGK9ZXf7SKAtkFzWc+1Q3jC9nWs?=
 =?us-ascii?Q?YfzVOtbsVvksqE6mDjNNf7Cn61pK5UvzW8s7jhWbAhTfxfrpsJAp78mB865J?=
 =?us-ascii?Q?pY0co4DFOV6BLuSualcZscjhYgrEr+LJv1bwG5PvsJ/di3SyyvZ5lngDsmqL?=
 =?us-ascii?Q?IFfrVviIdmCJvKr8MYZsG48/9eYzi+tdsOZ7d55lbv4gH8XJ7jTVE8+YERII?=
 =?us-ascii?Q?c5hunqveSPEMy+lHUNKEgxWGsZQxAgZEOa0cQlRejAiRZQqpILJUz3geJcsj?=
 =?us-ascii?Q?suKd3aB1ld4v1wHjowI9ONK1PH6kWL/IJ4DoWMrJgnfXZj4UQxmSg/hItaO8?=
 =?us-ascii?Q?jgMQVRLYa8N5YgSQFWuvT15CuuQnjiW0l+PaUQe1dsg38WC7X36n05ss9mym?=
 =?us-ascii?Q?rhlJkQZEuFfPsJPEQIlwZ0gSCWKbAoEs9hQN6nvBYnlx8OXz89/HZpSytsTj?=
 =?us-ascii?Q?lDrEInQVovej1kdccN3TNCK+6QB8t+NFDaMX+iHN12yVewDcOt00J/EQrdRE?=
 =?us-ascii?Q?cOgv2yP0KShTg+0a16kH+zIQ3ZBddxJhAu9BqiDqTc34zOB9hULX1Bb4tLwE?=
 =?us-ascii?Q?N6brrR9QLffpgw7oqbHwJJQshuKvvpNadLjdC9wOvILob0YALjSzanGSOVaf?=
 =?us-ascii?Q?JhzszFvADEvhv3Mmghc0iQMGB4tg+Yd40DPATonharp1imc6f0WGrQoS8lTs?=
 =?us-ascii?Q?fpOJIlruEZb+33FOeBNVsqqliEAGEgVdsDO3EuR0JHj9O/lu1X9xppuV3/2O?=
 =?us-ascii?Q?eTIq+Z5p6hLhCTqtetU8IhTnVZTUMl9FWznjKAClLNnZt7uPNwqjuHHPYpn3?=
 =?us-ascii?Q?lGEAzVnSDZbtfQL6UYQc4oigCmVk3zmakuWRifJs2BArxGPwSpmBhnaKReVq?=
 =?us-ascii?Q?MuDi3nlKn0e0aoS0bHi/VjCE1Lo/GkhJTtnzjbUDJS+XXT1xuGPk4HXqob0e?=
 =?us-ascii?Q?ANYcBzCfXw=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 611b4106-9342-40b2-4847-08deb08a52b6
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 00:55:27.3803
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7vZEwbqyMFcJoKGVeNnBDOTRaZgPADjoBRbOiHXC78C9H4EMpGQx/+C8QV6kCzSSR4HnZYmyGTKuK0OWG9r0fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP123MB4226

From: Daniel Wagner <wagi@kernel.org>

Multiqueue drivers spread I/O queues across all CPUs for optimal
performance. However, these drivers are not aware of CPU isolation
requirements and will distribute queues without considering the isolcpus
configuration.

Introduce a new isolcpus mask that allows users to define which CPUs
should have I/O queues assigned. This is similar to managed_irq, but
intended for drivers that do not use the managed IRQ infrastructure

Signed-off-by: Daniel Wagner <wagi@kernel.org>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 include/linux/sched/isolation.h | 1 +
 kernel/sched/isolation.c        | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/include/linux/sched/isolation.h b/include/linux/sched/isolation.h
index cf0fd03dd7a2..30cb9a44365e 100644
--- a/include/linux/sched/isolation.h
+++ b/include/linux/sched/isolation.h
@@ -18,6 +18,7 @@ enum hk_type {
 	HK_TYPE_MANAGED_IRQ,
 	/* Inverse of boot-time nohz_full= or isolcpus=nohz arguments */
 	HK_TYPE_KERNEL_NOISE,
+	HK_TYPE_IO_QUEUE,
 	HK_TYPE_MAX,
 
 	/*
diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index ef152d401fe2..3406e3024fd4 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -16,6 +16,7 @@ enum hk_flags {
 	HK_FLAG_DOMAIN		= BIT(HK_TYPE_DOMAIN),
 	HK_FLAG_MANAGED_IRQ	= BIT(HK_TYPE_MANAGED_IRQ),
 	HK_FLAG_KERNEL_NOISE	= BIT(HK_TYPE_KERNEL_NOISE),
+	HK_FLAG_IO_QUEUE	= BIT(HK_TYPE_IO_QUEUE),
 };
 
 DEFINE_STATIC_KEY_FALSE(housekeeping_overridden);
@@ -340,6 +341,12 @@ static int __init housekeeping_isolcpus_setup(char *str)
 			continue;
 		}
 
+		if (!strncmp(str, "io_queue,", 9)) {
+			str += 9;
+			flags |= HK_FLAG_IO_QUEUE;
+			continue;
+		}
+
 		/*
 		 * Skip unknown sub-parameter and validate that it is not
 		 * containing an invalid character.
-- 
2.51.0

