Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021092.outbound.protection.outlook.com [52.101.95.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2AD35674A;
	Thu, 21 May 2026 23:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779406221; cv=fail; b=cyGttQ1NSEqsBBUJbzTbxyQK5uRRSR2ldrqu2AwXXh1UiIf2WxDOSa288uXKNOXc4ljIsrYsMUY03dhNpk6VrpP66g4znT7WumEBryseLX8/RsibNnKMJiGEVfd6LiqZC/lQBWbiTIdO+nqRneaAfYsZtsq0aYffZ7NSJt/Irg4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779406221; c=relaxed/simple;
	bh=e+GLj/od8aW6hP+C4zeK/EV8wQghaKWNz13PZblqiTE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Lo/UMK4aMty72ETeHhwmX+owYidH0SrZWTF3zBOOM4RdkHwu7Wk1c4uQDyr0hARqSd+/4NUhe4FaWTDdhZOXZjz2DPKUO8R8Q+0peEePPrPP94LHqCxGvLxmPhmtVKllfHhxmOTQRXbqbQcsSWAf3NQHSFKtNtZdWlySWIDkpo8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.95.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GlyA3sXymHHLZPyIkUA54UqGeu9V+tcGu/KhMaK01w/z3Ph6c9ejWEgAM7JU/7xKKWe2PTWA1MfTV8ba1pxoTZUAnotMTemZ1nfvxQDMb7PovPMvWdZRwmYMHDHPzRH7dEbHRhTmy1Pvtcg7cmmB+QvvmPsEg6fcPuhVuN7icuHRzotKuyl8PMOWXBlY/3RFxPwtRS6Va5CkUM6DYch+nUvC1II42f3QDntU4NXdaXe+VT1iKlRXqKoHmyvlbYwa0OlxyBe5QcYadaDf0CRkBnGaz4/07vkoWSrQkKgESxrsTw8WMeI1yT7ILMF3VyEN8zJuj+unZ8gHJMmp4ZNn9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yxmsVF9BcruDQVuzOgTuQiNP4A1fOg7rMbhpo0DxUE0=;
 b=ejxKDVjatftLQNh9DGqT2xXxkZpPTNXmGT659x3UXwFTJCIM5D3hopVI/iJhMHFwniB+y62NM4sK6nnyMaEWVBuVecLqEzfK6HDQnypEjRG/NfixXLqdg4VeKL9rSFmPelGG4sjlQbp0FfAFeOwqcIEiAXUAwOgJzr8Bd3xqq9FLux51o2CYEf2ffUA/2NWvPGE8mL77YSlTttTPkwsFZp8NLSa1b+TabRdeOG8X1djxMKstySS+hQNzIETBWW7SOg8WIgavgE60zaQdMwH9fd8gF2oJ9J9Dtz4Rg+E0uuzalWZaTr48lNcGiAHAspW+hdE9n0DSswIgs02uAgrA3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by CWLP123MB6796.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:1e9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Thu, 21 May
 2026 23:30:16 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0048.016; Thu, 21 May 2026
 23:30:16 +0000
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
Subject: [PATCH v15 4/8] isolation: Introduce io_queue isolcpus type
Date: Thu, 21 May 2026 19:29:52 -0400
Message-ID: <20260521232956.553287-5-atomlin@atomlin.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260521232956.553287-1-atomlin@atomlin.com>
References: <20260521232956.553287-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR04CA0161.namprd04.prod.outlook.com
 (2603:10b6:408:eb::16) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|CWLP123MB6796:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c4356d7-0bd2-4408-4dd7-08deb790e9e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|56012099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	etNTooTkpJeA6QF3NNTWgjOlx9oi6DWnaDug86Wn6KDIoFQPsieveyDsmHU/iPkkqkJXBHgp//mFRQpkw0eEXrCEJBpwIA9bnzmb3G85NWAT4ftfjoisxrZ3vo8W5E1MeQzb7nSiDXKR419NOEkvQfpUGvEUaCtgyw4Kkl9Gp0fXG4quZYpSJ7YbZDqxoeJKUhjhSB06D6kKWOMSypdvVrG1yGeGx1G+PxH6OXU0YQPY6nsU1cPY5qOkBzXNkRhK8gM+xmZxk5jcb9aKy9IUC0zbCSlaH87FTBBZ0f/p8xE/QpqHohW76fLO0ptXH+E6z40mLEkjYdMJ63HRIShBV+IFPtYUxImOBZpnNEKLFFO2BSOrHNcEILOgZRHsM3XFyyP0x5x2DjkbEBX+hmI+RW39p11pYUO6nEi244Qw86LoNAvJhwbCusKRHUhO4kl9+BNqqo7txgNjvT/YKBJFenRbMi3r6Urhirr5jR/PmCVpz4r3iD8P/gEY8q4sb0cVJHThtNAuCKBNAboMgjURlRfxzQaSXxBCOiPP+Pl4YMTHSuPMcrhmuoipXGoKmd7yS4Y6IQN56pfEyRGwFnVyagLHN+TPibYtLOmDUZ0KgJnDHSX/j0FxlHhhE3ITO3ZXr8TkLlYAeSwxe8vhQbwPAuh3rpr86OJGF5wq0LAV2jXOYV+i+8rjI+/BB8Ni3sAm
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(56012099003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?imvsfoC504Crl+pMNkV6icqvvJLl1QBggMTq9UOuhlU3ltP2njACqpapEO/T?=
 =?us-ascii?Q?XGVi+rJBM9c5RaIgyDlhc8sM0h4ParZc/70XUoxyTpijiS8GfOtz88VQ3osE?=
 =?us-ascii?Q?lUTK4wDY5eTWZwUpYmRcnWErXdyxk3TSht9DnC0JbGvH4Zjfpy91a9UAASB4?=
 =?us-ascii?Q?a6mLjcUhi5INmtg+QguzYx3QPg0bP2eyWtcB2i38xT4S5Nf1tg4Ys3qgnmda?=
 =?us-ascii?Q?dJgl1KjFUqG64NFdvIzDVNhvNBGrzcMbgEO/uNtpHtbRjEUCpay6vEcHFAYT?=
 =?us-ascii?Q?63Zu6pUC+/kWUi3P0E8Re0op+rxAnlF20uEQBm2BUmpQJsxLUJojUy1yMGsc?=
 =?us-ascii?Q?u7HDEQ3h4UMS/oZ+40jXWRuke1UIxv01YQPJnpwgTTcwhbuNx8mKPdhC+GPz?=
 =?us-ascii?Q?63OMWr98T45sfS92W0/xMybzhNev4nHqEA6nUL2Ottmet7CmVwwmzbu214BX?=
 =?us-ascii?Q?+qDJ03LIC2wQaKcsJvCMORKmbFrD2FUyrr1uj64yNx0R15+NmSHIJCqQgfXC?=
 =?us-ascii?Q?DT31/jV9ZSLQ/mBHMhzZPDdrDEJKABqmi3bH93GXe3z8hblrCIweQY4uxK3H?=
 =?us-ascii?Q?3gP6Q2zONOVnK1H007waVNztMzqSb11X2w3gpE1Ivyb6CcGblV4iE35LO3bw?=
 =?us-ascii?Q?J8nlKOHucT7QdDddlf2SGGRVpACiJS1P16k0hSmpD1TPwAEhLxQiKeYl0JqB?=
 =?us-ascii?Q?qW3tJOfNiIw/9HmrRyPx5h0wVkMqJwy5HMorb3ce2fTaB/YDp6yKXp4AWUtY?=
 =?us-ascii?Q?bAyL0EyCfRQ9niV0oQMzrgZHv2gSI1GhI+3ARijrrR5zlw16gVbV/UiK196A?=
 =?us-ascii?Q?eF2/QSpWGxVPomI9KRR0BtTn12Cdc16dNtCEH0XsZ9BfJQy4O2acSV3fD5hF?=
 =?us-ascii?Q?sUsjr5rzdEtuohlt+cATv26jkKxGeMiSwC18DSYSFJLrkv08sDISxFumNJCK?=
 =?us-ascii?Q?g0CaBThZWBL9onUrqPvo08fTHJ7pWAYwrRbpqm3OSfnP+0jUBUn2M83KWRSI?=
 =?us-ascii?Q?dMa5iphXYT1iUpEyj38rV26Y+7aNyWsDEknYbI0Bt/X9luRXDrSbIIQmgKQ0?=
 =?us-ascii?Q?cydLg4VVOuTPE3rIDiSlyFednsRjKKSaBxd0FOQs24Rv2hAIagwGYvDrRFBP?=
 =?us-ascii?Q?VtpmCvKBR4bDHDfOJBKw6zEUEKclbmqCT+0sSqLxur2n13oypFGQbEjwtWOi?=
 =?us-ascii?Q?mId3vI8wBx5lxOtkRicdm4B6Xm3OHkchp2V7JGP5rNwsA7RTJFzcLirFY1yZ?=
 =?us-ascii?Q?RRlkFm9X1ZFXThNLY82+GDdi6HZrbXjjpoyaZqlCs3LnxfO2QOef+o085nz+?=
 =?us-ascii?Q?dRpu/oG/zeVH8waIlTgbolJlbFO/dl/ItGn52dMPsB9WVVfiHJYjaFbaMUp8?=
 =?us-ascii?Q?xqUVJ7qAJ6dOg8Agx9lX62M2CeYjRZmWzQccg5SAV4E4257dCY4DkR8q0gKS?=
 =?us-ascii?Q?FN/ROtgmFeWqsbjhEGIqUq4MpNqx5Rhq0UnHRR5FM9vOpijjZ0V3LG5FJr7L?=
 =?us-ascii?Q?JIn3dbCdSR/qiu951IyKnmKSLFi24+c9SrHFMzJ0O6F/SfB6acFqcQEWiFj/?=
 =?us-ascii?Q?QtrBognx4nQ96RVmgLhIXZFko7OZwVhyLe5DKWqVudJADpLo49Hg9uGdIYQW?=
 =?us-ascii?Q?QBpev0pra2OSfzqx2RyaKULhg8H/7W3/iiu4HOFCTJYrCj6Ww/Hx+h5jeC4U?=
 =?us-ascii?Q?I2Q8BqjJHqe4n2vJ+SeGuwDmIOWZ266htQT6bfOyJdsbtItELQ36TXsRVKf8?=
 =?us-ascii?Q?IWI1rDbtCQ=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c4356d7-0bd2-4408-4dd7-08deb790e9e0
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 23:30:16.1809
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1gL4s/2bvrEGbNFLvJf2YNvcSnhV8LfZOwFTxncEM9mIBmnZ5yIWPhGNIRHIOvxEilhhq0vJbKG08Y+OOqpCwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP123MB6796

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

