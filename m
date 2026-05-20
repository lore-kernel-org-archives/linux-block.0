Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021081.outbound.protection.outlook.com [52.101.95.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BC33A3E74;
	Wed, 20 May 2026 21:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779313867; cv=fail; b=JA7nuN6x8uGFvTCYvH58RatgKKW23TCtD+PLWmJTqVemRGyg4uWH2IZQi1E39+KAYX5RdDyb1gUZ+SiKgkRyzKphaTX39GJkgHdvm4K/4oZ7ntYwQnZSbvFViJIoLQPEtBA0BPLUW0j/uYb6cucpdGvXjxyTLLcujXLCg/jFXX4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779313867; c=relaxed/simple;
	bh=DkYl5gSyzPssM6U7YdR72AEn0X78rHvBW5MNLL/9k2I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=X9tlphzZeC3WqtGrN61c4twClcfWPGEv1GTg51uYV1v9KyVUeYcBRyCads/bcB2laYP1NRMi6xqIIxvqsh7F1+7cykGdHYW7qYTM57WH37lzI8RtSWjKoxaqZiYZ65mMK4zz+iMviD5y0568D4ikhU3KYnFgyYLOj8KOcBNSpCc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.95.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TuvlKpgnshsI6D9iSWyd+WGJMCAsjGT56PrgHr64X1Wml9a/CNpAOtvdjjrKfmtlxavrCGfy9IchsFQAQvSJfcUuAy/zcflpqV8qLuZJprXTk9S1UIrwj14fGE3XapZ3AxN0TuLWIFLgrCGUpY73i/dgh3GyzbPmyLSQ9aCeibWXtz3EZ8WGy6FKOjH5sDkFFP/Itnq8zuqjUxTXwVA5ItdRhk8XpLZPVToXVyJTCq4zJXB1l4mxcTxbb5VdMWcCDFFJp2iPzfh09fqSuDemUGbuxZHsFsWz50hg9WEU0KqHizMDnCEpqVR8kdkXoM7otMtd/FAY0EeYCYnsiErDdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EbqE/oS98kSBFc5DReMX920shdwvRa0zRECtM01NNo0=;
 b=SvBAHZ1zxdJG7Wfh8QEZrqSK6Myj2kdzuDAkQ7/LHtnP3fy83b14tzuIaiCUjtjwWbsSvUwsbfveG2hVh6yNqMOBHo8bEpkTswjf876IUbCv1GzaJwkGmRdTPrBYVr/fpgYLySiiY7/F7ZkC8mI33SsDxHm7Lpk54RDoHhWvgHG/VGMVIeWrCKxnkAOTvS2JpXYfCewlFsHoNilHZ4xIMcFEac6pPFtwIg225s1X3+Ekt8IsQkKS3Psy1du2FE0CCY/tgICXYTA1bZ9hww7g6mWy2M2rFEqSLBHJVV9rbXDuch1ZNtDJTwUdeQMdoWWU5xzXG0bsvAtrzu3kKf3S1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by LO6P123MB7351.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:37e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 21:51:02 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%2]) with mapi id 15.20.9846.025; Wed, 20 May 2026
 21:51:02 +0000
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
Subject: [PATCH v14 8/8] docs: add io_queue flag to isolcpus
Date: Wed, 20 May 2026 17:50:30 -0400
Message-ID: <20260520215030.496803-9-atomlin@atomlin.com>
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
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|LO6P123MB7351:EE_
X-MS-Office365-Filtering-Correlation-Id: b812b7c0-813e-46e4-fb70-08deb6b9e2c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|3023799007|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	rZPYy9osPUDjbvJ52VokzxpxRer2O5gxQ52CgboT95v3cHEGvXRnBR7xc8+P+uBJ2O3Gr0E695jFY6siUoWhxYoYGp7TEHh/uoKbjA5O9OuI1n0UUj0ZYFR+E2TX0pY5+dP8grnun9akr1tHpk5BiY0daiCXbZOvqbTkFE+WYz1qk2q+/PAnkwvNBqbGZDpTtWnOpEvHYH5LxJpjbuVu/doJNpaYnglvHqGuPvgdPFvj7lsNQgUOqz0SnWb0UtgUkKH4vsGmlcwHtJebv4y1Vp0Ti1juIpCwhdELdvmvBS3+4CnKquXCX0AXnxBATwpWhnyabHfInDtZO8XXDZvFPpQ3AtmYNbgzkueMTLZENEgWLTRb5B9GWLW/gOaoKz3kenGGQRGnEWoOu0NNVeWM3GDYR7/pXixFnbR95t39imf0untyhRbred0KhmpYR4XKIZkeMF0DtmhUsa/rKTJylcCsZnA0SqbaUNTza5ae4+hwP73qEvTqnwy79oAjbwzH8YkvCRhknRVMm2JW7sa5bOCRWuq1WFHiKPFvxdK6gFxkZI2/pUVWRpd9ph3UJCjBvSMK04WBalKUvDadrGuUAqP3LRJ8ZGy7Zbb5Jg3ywXgGDiKp6UwrsIw5Nfnd8o/Z7FsoaaZKi9UHArWCzfxmgfeox8bt+tdDxoX8TmgTUGBFw4+OhyC+mz4A4G4KPH7V
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(3023799007)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gkcyv4tzrVDBiSvNBfxVKjiiGR2ujHMSNYmekEpIyk9l3LHMEqOLtjHkKjGx?=
 =?us-ascii?Q?+KXh1+sYhP74G/dHwR79QK7/n75s4MRfcweeIETsQ5UMncyedl48Z6FlyeIt?=
 =?us-ascii?Q?a/rBBgCJgZDwTF+vtlP9U4eppQ7CSI9JDUXAtPrQ2BX9I6D11m7DetruupIY?=
 =?us-ascii?Q?X3fpsbPJ3+GbPkS9QlpYN5q0gMMpx2187b3rxQmG79rekvAnkssQiNX4oDTg?=
 =?us-ascii?Q?JKXCH4Muy2Pa2BaBRaP99O/8p9qgd1tTWa4M82RN2V1avIie3k9IRMlZs3hg?=
 =?us-ascii?Q?qLM5rUkwJTzMpLfvMDuLHjMGi8pj+WC1ejgsCJIarrPOO4MMPUg64jiEx/iX?=
 =?us-ascii?Q?USIoNvZlGf7gSf6+c9ks5UMm41LS2248Dt2givWlP8O09lh4qKQvy8NYCGJE?=
 =?us-ascii?Q?XTpA/tQj0YTWk3r0MzGOS0pW1OC6dNyhfFNI4d00dNkhwldlmhwiGfszAeoT?=
 =?us-ascii?Q?aWE2PT9AAM4A+nfTVbNAGdTjjSj/Jgi0SDAgYtbrwLejhawfHmbm9BC88ALh?=
 =?us-ascii?Q?HM+gMZ/y6npfU8LCaTNp1PQUS3Q5miPR0txQaXyu4A/nPkZhhKzMJYmPDI/h?=
 =?us-ascii?Q?XGOlhcqGhQJqFag48n1YILpoKE7RotdlvN8A5znaHIOhTjzqUMJg0o98xpaM?=
 =?us-ascii?Q?cs2vD1xA5dNQ6zcwzQq8QP/N6SqfJHObZ7nApbC4kWBB0zhK9dHV6LskDKPD?=
 =?us-ascii?Q?DXaimE7Ksd2VYnfduPoaqqxl6e7pFIPNFjwjqg4dPD4X5KpRABbbV9SkhkbI?=
 =?us-ascii?Q?VYUSzNrknnNd5Ur8SGRhBYaIdl62pEGFkNzV2SIz6txAEmjjgW/AxIlhoCk3?=
 =?us-ascii?Q?WUXUEiv7s97rYrpVnf9yzFp+ItL5gJr38cBz6pVu094EqxK0jfiRqB/WSz7n?=
 =?us-ascii?Q?u+AR2NEx9Qap5mVnMTt77G7hhEFhJfqEC9PU8VXPlmgOkss4gbXqpgGtdnoP?=
 =?us-ascii?Q?I01kVO4ZaIDd8n64YrOP9+B7DV/prxG2Dr45+VBsFFLA3crSXpw73oTUovCw?=
 =?us-ascii?Q?nAfxek/gXok35+jIXeD9PCz/453p7ls0nKYsooyg3dx7e6qxHDZCQ+4LD8wt?=
 =?us-ascii?Q?suBm4/JCHnbmHlDqxLK6mxMlUQIHanvOU60njwQ5dScRD/S4u+GwK8gw3F9c?=
 =?us-ascii?Q?1RgMNHdqYkJilG6FJ8f8lc9PYlLAzV7YOtfOTJcxHQ1pGv67FhXN/8SiHOBO?=
 =?us-ascii?Q?czijOofHtPgaCn31koQJwp80ZNXUfhtctJx8WGGfLhkGtaX9rSriilJV8woP?=
 =?us-ascii?Q?hsdSQA5aiDtkC1m5SNiEg26QZAUg0DnZwWCznakYqDAAZNb9krnO0Y+qxOlk?=
 =?us-ascii?Q?LFHqp25lVwDP/Qi4oFQ4GtFMJ73+HlF01DeaYWBGY6fWO0koAetL15g6M1zO?=
 =?us-ascii?Q?PEUnBzp0mh4DoNIeg1OmxPg9BaEShgyaCjxWwPGYtkinmk0ftKtFhlqH3a1d?=
 =?us-ascii?Q?C0aH+F3gXo9KIqEBLTj6lrq+WHK8WRBnm2J5ZcuH2SchGzzaHBZpq3AvVcZu?=
 =?us-ascii?Q?f4dheizhuLwzt2em/MgB8BLtucpN5h2kW9XMXv0z2JfbUX+kaV6YHUxvlSoo?=
 =?us-ascii?Q?O9PRkCqaezNOYF3TUIHOfu+uNaH9RyPaSjNs4bOJNBJOxH0jFrvyTh2D+ELL?=
 =?us-ascii?Q?+XtIBE+j3EIoU9kbjDA6ti93pyNXASWJC9HYMw3LxGfcoeLgvV2oOmC3Heol?=
 =?us-ascii?Q?ORLWocUH+VqvrfRIISP63bipcTUQzmPUmsxvywPGseDmE6eLEbbFb8cWgjKz?=
 =?us-ascii?Q?l5HMajEU1g=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b812b7c0-813e-46e4-fb70-08deb6b9e2c3
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 21:51:02.5810
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GZt/bdAO851e14ZFaGIy0VP8U+oZ8m7Jc8ddRA9JfuI3mQwESya7Lu//IBmE+8lsXIR2JaeslESIIvLwDUTqgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO6P123MB7351

From: Daniel Wagner <wagi@kernel.org>

The io_queue flag informs multiqueue device drivers where to place
hardware queues. Document this new flag in the isolcpus
command-line argument description.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
[atomlin:
    - Refined io_queue kernel parameter documentation
    - Removed an inaccurate claim in the documentation stating
      that io_queue takes precedence over managed_irq]
Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 .../admin-guide/kernel-parameters.txt         | 26 ++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 4d0f545fb3ec..fb828bb60b9e 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2792,7 +2792,6 @@ Kernel parameters
 			  "number of CPUs in system - 1".
 
 			managed_irq
-
 			  Isolate from being targeted by managed interrupts
 			  which have an interrupt mask containing isolated
 			  CPUs. The affinity of managed interrupts is
@@ -2815,6 +2814,31 @@ Kernel parameters
 			  housekeeping CPUs has no influence on those
 			  queues.
 
+			io_queue
+			  Applicable to managed IRQs only. Restrict
+			  multiqueue hardware queue allocation to online
+			  housekeeping CPUs. This guarantees that all
+			  managed hardware completion interrupts are routed
+			  exclusively to housekeeping cores, shielding
+			  isolated CPUs from I/O interruptions even if they
+			  initiated the request.
+
+			  Note: Using io_queue restricts the number of
+			  allocated hardware queues to match the number of
+			  housekeeping CPUs. This prevents MSI-X vector
+			  exhaustion and forces isolated CPUs to share
+			  submission queues.
+
+			  Note: Offlining housekeeping CPUs which serve
+			  isolated CPUs will fail. The isolated CPUs must
+			  be offlined before offlining the housekeeping
+			  CPUs.
+
+			  Note: When I/O is submitted by an application on
+			  an isolated CPU, the hardware completion
+			  interrupt is handled entirely by a housekeeping
+			  CPU.
+
 			The format of <cpu-list> is described above.
 
 	iucv=		[HW,NET]
-- 
2.51.0

