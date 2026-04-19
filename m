Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020104.outbound.protection.outlook.com [52.101.196.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A6D194C98;
	Sun, 19 Apr 2026 02:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776565846; cv=fail; b=ehzFoqm+h6zXK7UYy6H9gxxJoO8sE1tLNZB4jtFCqiLoV8/xMFSMzTkFsXMq8rYDyUtLfZAMNy6YseM0IT6U0AEEBKOgoTQkTy8hum0CEFaqlmSIPyCFvwiIGKoMHn04EghVKt/wdquWCuEaBxXDlmDxP8Z8p0XpbsdCUfyd+wU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776565846; c=relaxed/simple;
	bh=/N2WA1gaJw/nC/Vo9htm+TqkK4m8syYZeKIIa9MNqM0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=pdXnlE96/WstJWIH/IWdV0cMPk64s12ezPfUJJyWkhfR0/Y3pp+G2V01IHKMRvJIUJ+yWOWEPxnywm3tjU9y6bJsExMAEyHlsWl/qi66k9fmPwt0oGjsARRjj27cK5IrkE4C3xRBeet6DGdIVfmFLd0YAZvGvVNCupmAlRtkLH4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.196.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I+4lLoH8S/bwhAQXdbPh49vxriGTUhaZwVY8jWHhk6xAKTNJnFOEtmzymhvSZP6CknueGmuu4snjKgLkCGCFq4IGSJ3DRO/E99icQfaHVV4b3uj9W6DCg2sXBlHWp+nGDTX/GPgPkvEbtFDLgV3qmJEiZL7is+BBXOAUS/0zM/eabrqtS+8YxsTocHI6WGF0ZWWouzBK7F1OXP7K86sP1F0QVzQxrJQWazHg0d+T38uEjSp0CkLLjCMiyM+WSgsa4fPKxlht7Vdyw1slXEK0DfBmkr2GAJgDxAWuK6hr12Nca7T1K/ej096gAH13HSyQS5Xnucwk2gcfTycJiNm8Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mj6O1vhfU++hndkh6ikbcgY6V8in3gGLudh/WTDV53w=;
 b=E8+i+JA8sehsGZn3OabrS3o49ijJNk5EIb2V7NIPhPmF2eNkrwkqVDpg7pZ2iT1GK9Y1n3oSJ6FAWwCTkFZBfr9p5IYVnVnpsqekt24uLhjTsADjiI27HNpuKqsMTZlU+WJ2bLm7cRQ/JGL0HbtDbqeh5IXKJGq79XEgmFk2htAW9iWa6BfNOdo+hG+PjCL5jPukk8aIMA5d7Zzfbbxl+9nq7wQ8E0jaATteFuLS6AC0w7jalTy3RYSnfv35h6KVagoktkgpSnVmGxo9oJ9igxggf/k1oYpVjWEE9wwHa0NijlpI4q+QDg2swPKttEkr/jFCRy8zjvU9/85Thy6mQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by LO2P123MB5960.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:255::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.31; Sun, 19 Apr
 2026 02:30:41 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%2]) with mapi id 15.20.9769.046; Sun, 19 Apr 2026
 02:30:41 +0000
From: Aaron Tomlin <atomlin@atomlin.com>
To: axboe@kernel.dk,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com
Cc: bvanassche@acm.org,
	johannes.thumshirn@wdc.com,
	kch@nvidia.com,
	dlemoal@kernel.org,
	ritesh.list@gmail.com,
	loberman@redhat.com,
	neelx@suse.com,
	sean@ashe.io,
	mproche@gmail.com,
	chjohnst@gmail.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v4 0/2] blk-mq: introduce tag starvation observability
Date: Sat, 18 Apr 2026 22:30:34 -0400
Message-ID: <20260419023036.1419514-1-atomlin@atomlin.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR04CA0122.namprd04.prod.outlook.com
 (2603:10b6:408:ed::7) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|LO2P123MB5960:EE_
X-MS-Office365-Filtering-Correlation-Id: f83fd65d-429f-43cb-0c60-08de9dbba65a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	aBH8TjmiOTkh8iuh3ZAJDTsVlqZpERbvALX0MJCSP7bm90Bz2FIlzULnvmloA8hKhCEUdv0r27aogRd+yub8ZAm2fCMdOm+2Kek6K4Pk/X94sXx5VAOZkPDbU78IihtNu9c34LJZniXu6G+OhuamHnAqvhIWdqUO9ZVySZehel5PnmJVDGkcTInffTgVYe81ss+68Vzq1KZLK18NxzsG39B/dhJmQqUh0rOQbVuczUrVsBo8+v72VtdCGk5Y/kAXdfty+uStBNihfZjZuNMk4fsIjtUs0GZX2d+GHoKXJBZT+GJqXptxEcD5yfrGkz0drutkIaTi+ur1alW8cmiT4/7dodJMr20hVhDIvG/ZsrDn7bXaqJ/6qP/T1pLpPA0PVFjzb7PWT9yWkzlE7g5aMLJs66FAC0tkF9y9uL4KMJp33RsVMDIz9qkd+KfKvqEwAF0W3QCtAHYFqExu9C65pU7BqFCpFr7vi9Nd7UEbdA4SDVsoaY8MT7cKgKBbA8uEmfNpMcdNVTGoaNNTTuJKDAUtMH+dAwE/JWEtFdyfmbvRsWVL4xI6MGLhjIaNXEywHCFsLgfQy6GhfHsFM/6L6drFjxl01azxme6Bm+cQT6kHd9TeSFAy8a0j37VAFgSrA3gmltgc+CYwyC0Bl9LxX4FB9XERBctAXcxpFeBeM08nkXk+ypg4VHkbFz4ewaeGwZJileSEXk3cube+z28s77qiiA9z80ygXBXrOalsw3c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(18002099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kZBkjX+GGhhT4euAfYOovzkL00IvWZP0KvocxdS+2xxk0OMWYCYW/yQvmbSQ?=
 =?us-ascii?Q?DHZGglB9BkNMJNsMNDtTsxnbTUfvgGAb8k5A7L4Z5uKYR6gbxhe8iqwg1sZZ?=
 =?us-ascii?Q?/fiPaefxGZiSDcUeLx04z0fDwK1ADWf+nqeTYIrQ+TVCo7jNctl6PuerOtwR?=
 =?us-ascii?Q?Mms3r7M26SHhCIyIqWrpNZWJ40t2knqH5Oku4rEyGg3YdXFIkskINKXgeycx?=
 =?us-ascii?Q?GboaIqm70C6qZUpUu4x4wCHcwF8iLY53IBEtp/sa7IBzH3stX/DC28mJE2bn?=
 =?us-ascii?Q?g8Fheb76do7HXwh48nMnJaQgnV7iTTtww8v0dSqZ6lfQipT7bnUwJtgbwVvL?=
 =?us-ascii?Q?3qiUnmblNy2LeUNMaBgk0s3riMzyAJ59u4BE8cVtSi8MdAzdVFwOkGOZbR8T?=
 =?us-ascii?Q?pokPCns8vKMEOHGHo8ETvIVMop3U8EoCSgNlNQpBbYrk9jBr7BHgU3REYT39?=
 =?us-ascii?Q?lRrwTsHlKC09rlSyduVE2QXgAjwFygYPRow7MZF6FTuPqrt0Pj2QGHlOMU5w?=
 =?us-ascii?Q?1PsL5EEstnPlnyhblsjhquWUSKDaa6rfSYLQu/AFNF5876zwqM1B4GvYhkr6?=
 =?us-ascii?Q?iaXkg7/P4dxs9t3+hqibeVaPtDgAlzdfXEAfIe32koRhRqEa6Mm9wbXA5V1P?=
 =?us-ascii?Q?00bMd9T0owXXMMPO34oZwD0ZXpehb+eD094KPMwOmyLwPdk4k+p6I6S8aOiT?=
 =?us-ascii?Q?dVXrHJ2ZzeuUP9jvZYaihv4C+WdPYhm+Vtb49eTkLjl1m1Tu/JhirZqZQ3g9?=
 =?us-ascii?Q?wWnRIozkf3jY/qdDok9zl0fzg4qevGBv8T0rNnTi/gGKOuqhzL4805NioAeI?=
 =?us-ascii?Q?sEYrDCQAD00LXQ6Pgl08TTNVF0MVURgTk3FiIDPeSIyxX2dsewPnzvG/HNkv?=
 =?us-ascii?Q?470Fk4rW3018Z3XPUcqenrLJAquNuVa5SsKQJeEEvfgCs2FIdVpA7jc+bEAV?=
 =?us-ascii?Q?qoDlv4dOZYChVKnMDf7kHU/IVHyd5wA/FJzQLuiLQGjXlQszeVi1hGovJxv2?=
 =?us-ascii?Q?MAqHYBWpcj4ErAJccCrW7IE3ZbMMS/wMP+PAqocVPFVLBSgyXgDU7Jgw1gx0?=
 =?us-ascii?Q?/665pMR0fPKoeV26eDFr0vNJ0PBAfMk9MUPCTiTBiXTVoqFfpVLxTEAy699x?=
 =?us-ascii?Q?D4Pgf4LPBbIRiW8liPPG/w89G2Z7/HsJUzyhUxCfhpajc80B0e8Edtg9B1U8?=
 =?us-ascii?Q?4w+b5ajfb6xAeU4fqngjDqTfYlkSruTkXpZAjWAyzm/2iYtDRgkjztgdX4Dc?=
 =?us-ascii?Q?UQqRoBVzVaebtc9dBkn9qVwQcYns65JiZ6JuFn6kYRwVLV7WlphQBi9G4Cmt?=
 =?us-ascii?Q?g9kmcXItgf8yl4HNNhPqZqSLXBoQvA4ZK+HKc7u7AecQ2C/3cJjZVMwRArGZ?=
 =?us-ascii?Q?3PTsPvZMxIqP5bu2vQBflRHZxP9zCTr41RhvvZsHjVLDtdaWTrYIOX7CFciH?=
 =?us-ascii?Q?Rdjk/EVWlZCODYpWEYZU5DB8TOTV9zE2Em7VD1Skj8oLz9U4pxDioohRU3mF?=
 =?us-ascii?Q?kAL8nhv6JObUvmQIXRZwXBQS2BE0MnQsZK2XoY9otFdvwOLzER34LOrIh+mt?=
 =?us-ascii?Q?hGXG80MnmuB1a/mzcRcr+AkeNa29wm/oWbd5RX9O2Gs0DIfke7Ja5jLxI03h?=
 =?us-ascii?Q?95RXPRs1azqDveusHEgkXpHPHG7Xn4Arzs7bf5eHmUfxAGaGJtvcVxAgPqHC?=
 =?us-ascii?Q?22hY9BLvuzc//Ng1X68ql2rG3JJrg17WiFq4yb5f73fhNmEgmMcyiDLhFm8r?=
 =?us-ascii?Q?O3S4JmA7rQ=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f83fd65d-429f-43cb-0c60-08de9dbba65a
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2026 02:30:41.2815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 07QAE/LpKIXnMmpUx2/HwK5ATntAQKr8y0wWojexUjXaQuyqgNSN9/FzYbFkaHuljyuYyf8ptki7lr6dP67ogg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P123MB5960

Hi Jens, Steve, Masami,

In high-performance storage environments, particularly when utilising RAID
controllers with shared tag sets (BLK_MQ_F_TAG_HCTX_SHARED), severe latency
spikes can occur when fast devices are starved of available tags.
Currently, diagnosing this specific queue contention requires deploying
dynamic kprobes or inferring sleep states, which lacks a simple,
out-of-the-box diagnostic path.

This short series introduces dedicated, low-overhead observability for tag
exhaustion events in the block layer:

  - Patch 1 introduces the "block_rq_tag_wait" tracepoint in the tag
    allocation slow-path to capture precise, event-based starvation.

  - Patch 2 complements this by exposing "wait_on_hw_tag" and
    "wait_on_sched_tag" per-CPU counters via debugfs for quick,
    point-in-time cumulative polling.

Together, these provide storage engineers with zero-configuration
mechanisms to definitively identify shared-tag bottlenecks.

Please let me know your thoughts.


Changes since v3 [1]:
 - Transitioned tracking architecture from shared atomic_t variables to
   dynamically allocated per-CPU counters to resolve cache line bouncing
   (Bart Van Assche)

Changes since v2 [2]:
 - Added "Reviewed-by:" and "Tested-by:" tags for patch 1
 - Evaluate is_sched_tag directly within TP_fast_assign (Steven Rostedt)
 - Introduced atomic counters via debugfs 

Changes since v1 [3]:
 - Improved the description of the trace point (Damien Le Moal)
 - Removed the redundant "active requests" (Laurence Oberman)
 - Introduced pool-specific starvation tracking

[1]: https://lore.kernel.org/lkml/20260319221956.332770-1-atomlin@atomlin.com/
[2]: https://lore.kernel.org/lkml/20260319015300.287653-1-atomlin@atomlin.com/
[3]: https://lore.kernel.org/lkml/20260317182835.258183-1-atomlin@atomlin.com/

Aaron Tomlin (2):
  blk-mq: add tracepoint block_rq_tag_wait
  blk-mq: expose tag starvation counts via debugfs

 block/blk-mq-debugfs.c       | 84 ++++++++++++++++++++++++++++++++++++
 block/blk-mq-debugfs.h       |  7 +++
 block/blk-mq-tag.c           |  8 ++++
 include/linux/blk-mq.h       | 12 ++++++
 include/trace/events/block.h | 43 ++++++++++++++++++
 5 files changed, 154 insertions(+)

-- 
2.51.0

