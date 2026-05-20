Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022104.outbound.protection.outlook.com [52.101.101.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4644A39FCAD;
	Wed, 20 May 2026 21:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779313851; cv=fail; b=IUE2LLL8izKAlFHqE+XcXIWKOH9/yWZjmXues2dQkTM/Y0TtdaH5NFJOq/76BhgYALZ6wmlc/G0kYCeR3GOKJPzQUXH7ktAAdowaqJ0TO8udksDlj1t+oMt3l6n52m5BjQvhmxciUQRxRy9DJF6ed0MmOH6mvSiujjgbtzLYX4U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779313851; c=relaxed/simple;
	bh=e+GLj/od8aW6hP+C4zeK/EV8wQghaKWNz13PZblqiTE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rx2kpCr/9gzXBfUl/A7yrFhVVJ4FfnxFYoVtZjGjDW9gYOQ1GKzFCSbTO7FA27AzeDuS4vpr9ztsfYiMY9rKfbRiKs1xfDSQIqIP1i5LkgUACCUB+h3Q4RcMo0FuNhIaPTcAdiliEAIe+8l+9e0CrH1gw3SdKt10LDcwCuWqCRU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.101.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bqE2OWgJc62FVA4OfYpvH7YJLAhO6+qmgcEsZd1NE7hTaIRwYj86LOkPx/G9LHdGuN/4Vz65aZ4kbo6Pma4OHDgFPQBcU3YXT9hEAOHgP6inBj20FaRJQ8sZBMewLqgWv9wZ0bFJW/F4asq0QRk1Uh1raqeUFpD8Pf2TrguABuM6B/lfAAoEfAcF/YfrfMpLQCGB0tYdFyn00Rw+IHyQzTg3Ib6vfkw6Hp7zHw4+NNoLyX3FcBqd1vXCDUQcK2BPmhR9RW0jFBPViUEc1q9yjz+L3rxvCBrNfxPjQC40y8DGhZ2QQkf8v6dfySu31w0R5qNT/WFpe2onKh9xHayoXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yxmsVF9BcruDQVuzOgTuQiNP4A1fOg7rMbhpo0DxUE0=;
 b=VWfNIFOdq7PlkvYqtknWQo8PPFu9mxbPtFqAf4ORVa9JMFQ61AZvIG181KP5xYK3iSfk1WgadDyIoeCKHhGLSWCyCi9C11qQArp/SNNGpqqB3EqLyobfqFNwrddsO6rHZVNDR1yEtpvqInkAXUNryRrm8+Z0Z3UrJ2vJNN5Sz1a4TI00czkwmvCpIIxuC1tgFjygtMTaWmI9RAC9LL3AD39CnJY4XuFPHDpWpG8v/JA7mQP9Q6tM1LT1ue/uRcsMtSbEGr9GcLfnIJ67VGtHe6TngfStvkHAbcbgR16UZI8OeTj0ub8e6b3Hz50HDCVlRM6/q0QvjXSveAmE6hanTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by LO4P123MB6626.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:278::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.16; Wed, 20 May
 2026 21:50:48 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%2]) with mapi id 15.20.9846.025; Wed, 20 May 2026
 21:50:48 +0000
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
Subject: [PATCH v14 4/8] isolation: Introduce io_queue isolcpus type
Date: Wed, 20 May 2026 17:50:26 -0400
Message-ID: <20260520215030.496803-5-atomlin@atomlin.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260520215030.496803-1-atomlin@atomlin.com>
References: <20260520215030.496803-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1P221CA0031.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:5b5::10) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|LO4P123MB6626:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c99ee8f-bfeb-4714-f2c2-08deb6b9da75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|6133799003|22082099003|56012099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	dXQMFN0WIqMHTeNd2cgtGpWvMGlk/L5udpROuRnz7pboDuwNsl+lNP0g3DKVd9CwHId0e73+MXfQfrbsdLk0CwS6JTzyded8CNBXcJx9G4hvbOch5k4r/BBTl5XiEfJyhi5l+ruqnR/IkxWW7QgBuSSTivHaHa0COfB8rXpEK/E6EvL57dMIqNgamjMCeEmqaHHkUyQ4cafa73RBrBIwZwbm5V5Hzp3BYZPzCDSGoKkD+xZMlS6BYg8PYnPuVhg+Ux5g4lZa+b9oAe7slunBA1lUo7ZGXbjZVCg+uyUkOoEJTkSSmQsILgXU0SpKSyMYDe6VOOJu1kC/zlQpOZduuFs02sZCQbzbmvpTlWK36RBJEE99uFXgA6WYMx2wLRU+V/LCNGXdVGn2HtrzJHHR5BjyGg1L6LDWD3O+HA1B4/3gOsGrOSI10c6WJG4qmj/f8rCHV7BJST6qooDqU/J8iS/poAkp8Cj58BAC++RP1vg6e0aMcCWDD4xvgbWgkZYwMXoT5zuHtORmrc8OalyDNozMFLeHSQvdLdQ8KgQD3g/3LUiwuw+/mVGkJpPnyEu0N3G5SpavDf30jyAGTdxeO2SujjDOfGmRgNmqPTloPLHDgbYVer9szEI8lwnOE5tWhF7SGLgaedl+hoE8ZH4v+USmlOgWZYn70wJq/f8majD6ncpfSs4AN2PcFGlo+Je1
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(6133799003)(22082099003)(56012099003)(18002099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?00ilHV6GQPZNVF2p+jllT+fK5DOKOuPM2E4gsevLycQ8T9WRR4BqE5j2u54y?=
 =?us-ascii?Q?pZRPVKNlLldbFRMRS+5FR6Y7cX9YpkexCuWX1cAQ00r7H40w2/cCGjVk16e1?=
 =?us-ascii?Q?FD1HoiC6OiqWEbOKr20RTC0Upsaqxs3wb2L5DovtIXBzwHxN6qKDuE81KPnj?=
 =?us-ascii?Q?kEgAgvZ9Qd5dyfb13ymHtpsOV4nh+jchhr62k0fxzgCWat6mTj4GrhMOtqnG?=
 =?us-ascii?Q?oQ8tTqbMrrY65hYe4vf3FuBYIayq+hfhedy4boFL7L/NNmEqhz0301Gkiz8T?=
 =?us-ascii?Q?ddX530uCzLYJcJh7KuvSDsXsjt28vVre4EEhOemvAYzkizrX5zbtfQIRR7VY?=
 =?us-ascii?Q?TkTexpBnjE8HIFMRbOR9GNCcOZGAw9YJ0rxulNzyK/Yx5bVYBgTSb3hakNRl?=
 =?us-ascii?Q?ViM3wRHuYajc70FfkcElADEph2P7kQo6gNrCkb4tUT5Gr3GgFc9pqTFn9Rmf?=
 =?us-ascii?Q?YL7nugeVWJyD6GnE4VkV5naXfTz2ChzbpqI4w2ymAfgKTHfX5TXY1S7y4BII?=
 =?us-ascii?Q?py5S2XOWOIeFFx5RPbSrHzcHkn+wvTTPd1EPAaP8l/4b1GeT2eCcSXuL6VYi?=
 =?us-ascii?Q?pLDqwwubs2goOsR1SPNI0b4yJgppxusyI/kd4Y4SU70/NFWuY7WVVZSYbp8N?=
 =?us-ascii?Q?6yX+4snO4rWAaNp/f7mxwFxNfaFG5jYWUCG2oLr7vaguTkCmTXxkWp8WvHVQ?=
 =?us-ascii?Q?2dplLZkJEMUnw8kd55ZSoMzqHaLX4wDLO2GEyZSf82uzsckhtfFrCxvb/zHZ?=
 =?us-ascii?Q?i43Rwucs/CQN3KX0KyH1NA0rW85jpgQRFL111sV+K3GgUiEJAPW8rtzY6u8n?=
 =?us-ascii?Q?ovOaSaYhlZCekZzyP+dy18nRrJqM6t3HX04v0f4uNFFK+0GQtoVdj7r7RD8E?=
 =?us-ascii?Q?OHn7DrBrTXrgSfueuxBmV2XI0VyFiA8wdFgg8zHtjfjcw0VuAemaGlunjo35?=
 =?us-ascii?Q?CpCoYABW5R4PDx4/Zq5+5IsSN/Qq0ODnk3jGVh0Z6TugLSOeF2c3oioC9mIg?=
 =?us-ascii?Q?i65EdQLMNKyMBTOnUkFISIDzGTaojrnLHBtZwpramPBgP1GgoLr/mOc2q29V?=
 =?us-ascii?Q?IGGgX59DZyuXVT4jeMWng7/mMpCBBUqJBPE0GZTGE7Y/v+W04+BpYwiD2wxz?=
 =?us-ascii?Q?QfmgAQ5p4309uqCEfHLj+bRfzzs1IIk7dKbd8PKkTY5O2vdWS745+DssAbrb?=
 =?us-ascii?Q?pi7O5rSTaeGD5/8lXkUjG0rki6zGguSyEKMsRK1uKCr4rJVoSQuHfufV7124?=
 =?us-ascii?Q?U2YPSTUxP1CQL/BRt7Cd+fG4NkWrQ+6HNU3jmz93WA4N+xUxQLNKNgeycAUu?=
 =?us-ascii?Q?tSbT4goefqgMsZxZljP+AA09/UBPiYSikshW9w43Nn5vJ9lbaIsRhezDwNTe?=
 =?us-ascii?Q?nzc0/UpNEabIFGPwLdJiiAnGjQR/P2qUNsPnvmIo5qmjOGaKaAXkgeeDhdOS?=
 =?us-ascii?Q?QoGiqa0vNYkYd3igMhBy5SmcH5JrHCQbuHOjmg2lSHv93JroCWeL3QpLC+u+?=
 =?us-ascii?Q?+j5cGnTGXJjRIGe6BvMR+JrQzP6gAJbRHryy//qfcdvxWtycLA9/c9e2V5kP?=
 =?us-ascii?Q?J++SE9No/3tSxo+Y8nQLj/RWpu0n5cnKLSgTS7IMxfNzslFuOULpUFrBZ3vV?=
 =?us-ascii?Q?TOfJLpvYLvMxe8M/9nxpOe7Yyt3UoDqYo+1LMP4BuC+5kKs7KIMhY7HYf3Na?=
 =?us-ascii?Q?7O/X2iTnnhMCeM62W44oSeYcqVt+G+U/7H4ykdlK5xspq2NQEdRP00S28bOp?=
 =?us-ascii?Q?nkg1Pv+Kqw=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c99ee8f-bfeb-4714-f2c2-08deb6b9da75
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 21:50:48.6696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R9l9yBp8as99dfoPg5JPQJ6cKCdu4mrqC+abQLIR+IS1V7Rbv3Tmgt72pdi2eqxg+VxuXt2kdct5Rh0bXOr2XA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P123MB6626

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

