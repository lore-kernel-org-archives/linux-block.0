Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022083.outbound.protection.outlook.com [52.101.101.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1EA72C15B0;
	Wed, 13 May 2026 00:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778633749; cv=fail; b=EQg0n6Oq1EuPiPP6zPnVCF54gwlnIZF/p8HI/jZCg4H+G3QXYzfoKD4GGj5cgx8QseE5HjfasIJWl2PEzT/IzujZDfcHHgiZFROiKfX3eHSGBjBC8DsmIS6UElHfX66HYQno0tOnWHwJItzZzbdYLjH7tItTFU5GcCkSWrfo+hU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778633749; c=relaxed/simple;
	bh=KP0I+vRvu8cMwKUnkerXxCp/NnM/UAb3VFkNZ9NPlz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Nq+kuS+JN/b0YuMtjdWBT5XJXoS/Ch0vxp5mLqpEES8DQcNLQygeOtO16iiDwa0s4IhDCc1EbDTqMOWuk4gzh0gUcuPDsvl3jMcXEGoeR9e+Cqt2G9++0jZMKloAiF1Ae78LkzamvHOAPaiccxOcDSQZJeDVdZefZCIYy0e+GHM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.101.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LUFS+ODmCzX92Ji17j5KoBB0n5MncoeFE8HzY8OHUZHph+t44jz+Qx9n5f4/Vk46jxR4XhuKxyVTreiyjcywuvgDzRIPXCWQXH/XviLq1tqcPNBkiKxrdye/50KUxiqIJQHvL1laA09iCSl4V9eas+4AplXu/o8VvNkW10Q8FMUoRd8j4ntnK5SwpxnlxTyAPs0y4dwYiJCYntRW3KKe6FukH3KKeHqW3zLdjbTRGR2HB+02Nnt1y0V9rrhBs3DWctLib5++fAA2DNN9w5ngR+FiwcqW7gEyg5sUmcDC5dzh913ufGbNm6rgQxfLgfXMaQvf89vNqPKkSDDxo/cxog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bGVv5QZUgcasqmM/T7tYTY/f5ujpMqZclVj7VauTxYE=;
 b=qwwsBWjypfJLtnR0zJyvI8Fb86+M4tcg2hWXze9OhhpEFZKWWleEP5Z9wEcXP/O2cWiun/pTvCWwbjY36uSNQGBPXmVnnzeZ/KU8lfJKZUP1HXPAiTV4k6mjJCPStWap85d/bRZjMIkZJTLUkPJST4cTJvMYj/U+jo28rB6+6Bs8vK+n4apKPGsVxZ7VHdjxWM8T06n+ZJrDC0lnRnGlCi58ShLjxnMufqB290p2hlSu/6sPn2UL4l4NDLEdvr0DmrQIbPpY1W73bsbBqslZcZqDG4OrmVsKn0Cmgb1LmVNvFr/1HYlnLlKnl+ZSNwzen9ILH/dsELzM95kLqTT05w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by CWLP123MB4226.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:bb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.17; Wed, 13 May
 2026 00:55:41 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%2]) with mapi id 15.20.9846.025; Wed, 13 May 2026
 00:55:41 +0000
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
Subject: [PATCH v13 8/8] docs: add io_queue flag to isolcpus
Date: Tue, 12 May 2026 20:55:09 -0400
Message-ID: <20260513005509.135966-9-atomlin@atomlin.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260513005509.135966-1-atomlin@atomlin.com>
References: <20260513005509.135966-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR04CA0180.namprd04.prod.outlook.com
 (2603:10b6:408:eb::35) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|CWLP123MB4226:EE_
X-MS-Office365-Filtering-Correlation-Id: 8042cf25-bc96-4d66-392c-08deb08a5b45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|7416014|3023799003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	xYp+kQBmq2KNiD3Mw8l2UgnEM69ZFm6d5MXrYle5BEzUuIwCTnSL/6V6TRVMqZvx05U9CKToEnGSbXfExjJ6JP7XWHAKy4v/9z3xAnOWBkSPLEZ1VUHnYbUpJlBQ/xPzN8LBrI4c9lVqSXkaDUWZpbMo0+JhwQOIGTvrm3n99fiMNXRrzhydYVmeTjC7Leb0m25Ec89TsYhkVU9G3CKlmgfhXjQXSROrvRR3/uHruRkEVJI23S8HZ2ZrQuZ+oRcM0EfmXdOmsJ4fMGJTXQCsZM0kyXBBUwHk+dL1xcYsp7MDqi+hcOlTA0l5RuEi6V4RQIJGWNUS2hJAb3F+j0wExInY3TXJUWSTYcDU9h5C9lf0hotpwUefayQygf0i3JTSqNdEGl23QUMJ+fn6IISYKXP/18pJyri4m861ULIGQ5E5nYFGzIaRCdtIExv2L3XY66GmnucEImqZPReqeTdZty5RqFtU/Xa91XQXsZ/Nzf9h1Ty6HnYlShmM0Xh+ixK01lHF2rFAix9WdFg6Z05jyfpp2K7WNkauxUSJLPvE9Xl3RMj0epMr/vuGwSnp6WwKTN0QmNN3215Uzoh6E1vWxi93raju72PLeYq7+QVxIH0C53Yw/l9khKupZdTznJWKhG/v+4D0nE5uUPwKcAHlhFDm9IUiSGjBCmbzV94VHV5xACFVaMwVjj8qsogh4Ow3
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(3023799003)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LTz08TCX3dtilEWlyC2oB5MOENkvoHaA6GW3PLTOTHf0LtyDtWyPGn3FvDuv?=
 =?us-ascii?Q?coghHa8mE4OSNVZhS2/+7WiYOfsa5jBtikfTmLnf1M9D9WT2goSBExDccEGz?=
 =?us-ascii?Q?3gcRCw4gxzs/WdVY9q8TLFxQvbn9ZkLZBSGBNLWRkcs2jt7QQGp9im/mJGpN?=
 =?us-ascii?Q?RBz3NOGitpoRxMHI9lyzs/r0Z0Kt1d5mGaT/h3w4ABrunOfLtAsN5eUrUUSC?=
 =?us-ascii?Q?PrWKUZraLaZ7e2DreBvNdBePIZn7t/I7tlFFdZQpsOodwVRp5NoxSQLavruU?=
 =?us-ascii?Q?kUFr1lgS77QUQAS45TXV+EY90AwPJhuSAo/RREYOAPNvRGDocDHQ0SmOnZiX?=
 =?us-ascii?Q?vrsccOK/asgU8/qLZxcb2tcbfEKrAihtjccKVFcBFbcSOhLvYSrdNMBYgWWw?=
 =?us-ascii?Q?eQ/C08V+qzq86UZcbh9JPq0iRa8yzVd95F9a0DbVE22HXm6KoC/XLrrnTBub?=
 =?us-ascii?Q?dtMww9dvgtTVGfGztMHh+/+6fYd4PwvoZp9lM+FBUGxB3CHRt9GxHSG/QtAY?=
 =?us-ascii?Q?r8wfcALM/t7Phu2a+OEun4GMr3wqvuoDFDzelWeoN7KTySXYyRdBgIzq+Ju/?=
 =?us-ascii?Q?wKekvWDDfFDE3k4guy/GCjh++7oi2LYS9FAwh+ZT4itrYWg5QBJFHCByjDC7?=
 =?us-ascii?Q?q/a/laL0YsaRUz9XcjlNhTSss8vk1jO6IeezibjRctRUg2vu9HJ7QVhckdyW?=
 =?us-ascii?Q?exWDvPgFLVJwZi+q6m5jLSvgbxAYMW6dXyN1+ochzBJ6FO6Hmm0MH4yU/vbm?=
 =?us-ascii?Q?QUs3YKWX6DastBLiGkZezIupySBhvDX61D61eP7hHOuMXGeQX405rZ9qH9Ap?=
 =?us-ascii?Q?iYjCw2AWF/1Dvl4yJT4R46WLdTsgLOTBOtY8GR0CVQUelV1cpHi7QhQJZUIn?=
 =?us-ascii?Q?KINBjeOUP3ou+J2PIJ+gnJ6W0po0BKmhlfcI+UkEL3oNDnx/I07pohahGw+l?=
 =?us-ascii?Q?1dTyhkT5R3Pf52BDZw0lDPCeyNZhJfi+E52LN0TRzMQxkju82Uczw3NnB7Y1?=
 =?us-ascii?Q?0h5bTA2sXRoTWqIkSfPyAw6YW4GTrQGlrThxUueFPG11gLVoDZyLeL3GVcGO?=
 =?us-ascii?Q?4GgVOoG3ovdjyKMALJHXVhRrRhNegyopAsmc2r5gXhr9u4b8t178XZmmZUxf?=
 =?us-ascii?Q?dBbU2MVR5JkFJge8l1L8cbPyjx70KV/pO7No5Us/KBCz1EcCwcouGr0whDED?=
 =?us-ascii?Q?lUNNZ6Az115QmZQPqpuVNo6ltyWAZhXjJZQzOIk0bex+IpdzarJy41BvzUxN?=
 =?us-ascii?Q?LchRHavjfMwyA72i098awYuMEI8E58dSwt3nVcpBcVVoGSFCERTaKgBKyPX4?=
 =?us-ascii?Q?RI5F/B43d+tPHT4L46nR+0SwGQCPuLqC1s251LdcRkt+hpNBMiz0907/FKkh?=
 =?us-ascii?Q?KR+8Pj7MKvLMBak/ejApdTgSQBdJrn2pOWCCFGPzkV8wldkviv94w1i37Vzv?=
 =?us-ascii?Q?okgut6MeFZy6nZ1supIXtn1STXhYBETqclnoyJaubNyO9gB5PTHMSnzs0eyv?=
 =?us-ascii?Q?5HIpKjEwoJI/sNGc465M/1kQmpcgmcxXMATOI4u960wAd/f+bbJlYLvF9ewE?=
 =?us-ascii?Q?KF5kA+q/o63gSa4AAGwosKgcf/hlQHRMKXuDZzOrigxynMaRMXhP1zaTQOTA?=
 =?us-ascii?Q?jszruASccCZ9rsfQQu0o59QqjM7WnuGXWpD0oIm02tqBck136KqmcgJ2FYGb?=
 =?us-ascii?Q?FMRGlp/ljp+r4/uKyS0vqung3dAmhGekBFN84UTcO5dJsDbmsbYoeR+1Hfu5?=
 =?us-ascii?Q?wW6wcgPQ/g=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8042cf25-bc96-4d66-392c-08deb08a5b45
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 00:55:41.7906
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h3oVekOoyMXMZhrlA+BTVxZP3T9cJ+TF5VWO5TDJzfTwDsyqC7E60uSKYmrOe8a+stANtjRCmz2y0V5luspNDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP123MB4226

From: Daniel Wagner <wagi@kernel.org>

The io_queue flag informs multiqueue device drivers where to place
hardware queues. Document this new flag in the isolcpus
command-line argument description.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
[atomlin: Refined io_queue kernel parameter documentation]
Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 .../admin-guide/kernel-parameters.txt         | 30 ++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 4d0f545fb3ec..2de1b7bffbe9 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2792,7 +2792,6 @@ Kernel parameters
 			  "number of CPUs in system - 1".
 
 			managed_irq
-
 			  Isolate from being targeted by managed interrupts
 			  which have an interrupt mask containing isolated
 			  CPUs. The affinity of managed interrupts is
@@ -2815,6 +2814,35 @@ Kernel parameters
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
+			  The io_queue configuration takes precedence over
+			  managed_irq. When io_queue is used, managed_irq
+			  placement constraints have no effect.
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

