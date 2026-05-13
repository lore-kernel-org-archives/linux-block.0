Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021076.outbound.protection.outlook.com [52.101.95.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0104B2BEC2E;
	Wed, 13 May 2026 00:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778633723; cv=fail; b=hYA+Y1lHYFu7DMibKU4qL5KDYpo/m0bVC18EK3rE+y0IBOsMlnMsnC++oe6KtiA+6WlAA6LxPxkZEFPET1WD5E6TRVWG/Ehmpk3BxEDZP1ACFzNFYYkHjzVvF0NRyccv8jE0r4mmWfQXIuXP8c/tKLsiyUWriPwpwa2scS//4HU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778633723; c=relaxed/simple;
	bh=H1RSijiFZwChg42ZDOQha8MtLlUmmuZbVL920hVLQGg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mc7fkuPQE3jg8oyfERwqmeXNi/i8KvIVhrZFaBb1pikvt0XMAfRsfCyEINzeYxtAsj8TIYfGz1P6fnppg2NWwviNMnsCRlxwIUFvY+L8Ct32TL5qmlJVwvFGO8w7XMwKXCTexR6eEEPSQw9nATTXsVgWD39DmfehPSZuxLFeyB4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.95.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wjhCVWDcWdd0VtSkUKejwpqpn+ZsyO63BH7oa8ctV4zzOZ9h/+yijwTJJ1u92engcois+FO+p/Ox5C5dMVh/8RgGlB6D3ip3l5zUqijfHdTOBv0rgQ6JFxHngoFz43B9r07ykfIO71Sv84a2zDELVEysMh+IWXdReInvi7ZoCUYa1YK0uDuj7KaaheEOoXvRjPPeXhC2ZvAyIp4C2JFwGWsil3P4mV1930O9WygB6XpWBa0wd/geUDiaSrAhQLlPhX0jeMGvQ56aBp/YRiU50tXtudesM/QJEV7zY0RC2+af48woMIadl6n6jG2esWzuoE3ZA8wo8EE4b8CZ4oUMsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mNamlmCMt57K1U2lDW4kZvmBXMIcKl5Ky/MTc/Rmaw4=;
 b=ToBEf9JTaGtTfFfYRkvB0B3O+hNuPNEReoKYmVtF1EKLBvfWES7LlEIOwW2WoxCqsSNp6x19UxwcPU8znJh1Q2YeNcmUMFhXePGuk+arvR6tun8eWLzDY4biTxeqfjOmWp9yN4GzLk7EY8QJy37k0k5Ph0esrQM6zR3zeeAWDmkzqduSVRDlmew+Zw34218Paxm2gNoaw+GWaQgvowHp+4kCXk/QV8NZKP1hZWs/1CM9OdeyCMH8EGBwWDYP1qEoenruWZ0fO9OM2KB6O7ziL4pZ8sqxRuia3fMjEJZbd3o8HxJEKG6PTy7ZznEkmw9xVp2IvDJ2BF3itmPzqAEzwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by CWLP123MB4226.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:bb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.17; Wed, 13 May
 2026 00:55:20 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%2]) with mapi id 15.20.9846.025; Wed, 13 May 2026
 00:55:20 +0000
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
Subject: [PATCH v13 2/8] lib/group_cpus: remove dead !SMP code
Date: Tue, 12 May 2026 20:55:03 -0400
Message-ID: <20260513005509.135966-3-atomlin@atomlin.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260513005509.135966-1-atomlin@atomlin.com>
References: <20260513005509.135966-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0580.namprd03.prod.outlook.com
 (2603:10b6:408:10d::15) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|CWLP123MB4226:EE_
X-MS-Office365-Filtering-Correlation-Id: dc40397e-d952-40c6-512a-08deb08a4e6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|7416014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	ESlcqxoCSffWINM5I6AYiV07z8uMO9c8MHQBFRdOUTb53pWbVNXceSR5vruIIub8Du8ZgmZgMkGbhUFPwu6uxrOKd/F8ioV1oRG6+l6mojj9O0XB+HpbS5AcPBqSlACDAm0N2pdBwcgd7xKtM9ope0x+iTcHUgcAAKCGbyTwBu9C9zgQQ2jq/+AkGrM7IZj98mD7Em26bzi1Wyh/YOkm9RyVNB5Iv7oCXdT4jAJf9X15JARagtzTjXy0JJND3A79iUCpoEPFzzt78deQvzqMWY1PbYfPTH9ZnFalvDfUvygTeBseHhcOLCEjbP5OTGdk/TSAcfs8nxj1V12rRwHa2U9VXA5gL8/BWDccvWEhO1rUUATsh+PnMUmRlSKtpSbSU0S0PodSerfJO/0rA1m2w97I2amOYek3aQFENUw9DJXeJWc+TYDW2KSTLJjN3ennXUpiU14Wka9a8s9YquQdO2gM+ddXlELSTg1oE3ZFqA67Ys9OGPg9M7XpwXYGsSxP8Wz+6RFC5z7qyuTbWmVLAgZ0HpLPssJjja35nE2i76sK/SixTT2eOxz3zFmlhUIznNGyxtQsHlOeLCDPn2jjd8jrlQmNNCx7kSTbEOp8SWXawSyeUwDyaxTqi9VeMA7VX1AtyPoFSl9fdyOkq355F4KUWEeeEgz6JxTSjIUp7g6xMI+HHCSNuL4r0NVZfUp8
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YW68+7J2jGzpj5xjX1Se5bFBZaHrKfTrK7TEMajuy1MEZS7qt9DfPaZjJ6ni?=
 =?us-ascii?Q?C3//TcVqQJEzJlz+dRHX786ssKdysOwtZmn6j2eI7SMoCEIgNkF6Jwi/fUK8?=
 =?us-ascii?Q?7qK4kHmUBjYDEy/1OgHBjSmvjf/OfXxl4hRlRxl8upXqlz5er1fJMJ4hzGFE?=
 =?us-ascii?Q?o2sufJImqTS3uTB+GFQPT2qiHZqCMRmUhk1gY/R2FBjH5pRXjAXeXsSbW9wI?=
 =?us-ascii?Q?hmlwh81KHSNzfSMYRRTSdyE6XxVPw2Q02fdnMT5Y2B+CkwjRZAOnS8LsL6yM?=
 =?us-ascii?Q?K7G51kpakadeBjsWrfVLKr8wRTJDQDFzYmmgH++jlkvxXjaG3sTCtMPCMsc2?=
 =?us-ascii?Q?iKa4/u6sY6+MaTrTCi9kNKXqM95jXeV53s0WK5a1sVgasF9ZIsRvwURO3Jok?=
 =?us-ascii?Q?mHxgBI909o2c5MDV2WUxb05Wr39DKGcq+ZQMKdDWB97pU/+hP0ilSoTWRP6E?=
 =?us-ascii?Q?nmtSdXaxRfnSni+JOOZnz8I53Fc2KfpO+/1ZGnMjytQHMb0PDjj6WY7BIyIr?=
 =?us-ascii?Q?ek9Xb8kqvcvLT7zNpyacLAZtRXRfldO3FRfb6+8bFt9IPKmsRTbrDVLWpKXV?=
 =?us-ascii?Q?WuFavhOSNFTirQAdJHZxbKXLjEUojgus19LL8+n3TIOXH8dLccXzd70FGevd?=
 =?us-ascii?Q?myu85nh+5Im5MCDHjlS2ODW6ejQWFPD4QOUJajyBz1sWQ3wH5jablxGQcDii?=
 =?us-ascii?Q?SVoBoh44AIwUKRCODszaCmMps+kvhFNeyKHq3FzwDZMrsWL/M3eJ6Q86ziTU?=
 =?us-ascii?Q?AK6e5N/tlzFQzihFFeDHJ56mJOEXzHJqbHHcXxTNlf0i0Mau4l4Ni1kuXBip?=
 =?us-ascii?Q?1UUilglCAqpwzP0xWgCGixGNMJy3rDz1XpsnDp+HPbvuoJZtKgrCJQ73oeGG?=
 =?us-ascii?Q?8vhC7K0we0BQGPE79nT3n9Q3rnh6+n9jVTIhtKgHVcVeEDoUn5LOQZKmEwwz?=
 =?us-ascii?Q?sIlooZ3lOHrWv/ev15ug6TbX+L1bTaloAB01kwfhk6dsW4YhblpAVVWpVxIb?=
 =?us-ascii?Q?eIi507nzkhXU8pH9v68uLky+ELt+/2oXUjHHdsL1sYFtGasldk2ldAPICEE+?=
 =?us-ascii?Q?HzOGCkJHUNbB/Vw1CUdL2eTE/edGIiBvvXuoc3Fn9SV8pokhY2a4zU0c/FrZ?=
 =?us-ascii?Q?AL0fJN4/5Bi+XwsTSlNYyfS/+VcgyU1yF4dBZBAc0kzP1MF9N6tMqjbsc0OS?=
 =?us-ascii?Q?uPjwqMTroSQb60JeSYRm8Uxwm4p67Ap9GcRAeLdjmpV64b2104SJ9sX+Vh6M?=
 =?us-ascii?Q?oIn8c0NCgfXzLVgEgP+0gglxkiAB1rA4ZxHLPWt5MZJ5rWTgEQAgyCP8aLdD?=
 =?us-ascii?Q?q5yXCRPU55kw/ZDoGkiWGCcJrBAkbPcP5sFCLlj48x6s9nBV9/Vrc7foqB1S?=
 =?us-ascii?Q?1mz/MQ2igBP6SIy2HOXZeZUwtmOR3hqJ7+IxaLujAeW2SwA+D8Ygeb/I+2av?=
 =?us-ascii?Q?SNVyqIdqJai4J9A6MUrNNs6SdC6+Jk7JNfCmci0f1y0BzMA85S/W16Ly7r5U?=
 =?us-ascii?Q?QZpl+rKK9gDgMccQACzICbZcKxnZ9asVtmzm8e6hTbl7pLZc/cp7z6kpfVSH?=
 =?us-ascii?Q?SxcrBIlO0z8lBOuOobcVryl2QHm3fAcURZsCM/Mna32eOQxX1AnEAQ9yZMJw?=
 =?us-ascii?Q?Xt2obP9Bf3RyJoEqrkgqq/VFsKi+ZJv0LzRfDj1L4wgpXvc634WARzfSiQGP?=
 =?us-ascii?Q?cr8T9HCts7w1BKsSYfO0rsw/tZW8A9D7auZx93BUYfDEl15r6WOxriw8OnpA?=
 =?us-ascii?Q?FWCeVbNjAw=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc40397e-d952-40c6-512a-08deb08a4e6b
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 00:55:20.2653
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0IdM6SAcXJidDMaujV0Il2jjIhKmSt/69+UP1A+wkmaOTpTgT0ytSb0Uz7NEb3JDi777H0KiVN1GhTCWn9KYxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP123MB4226

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

