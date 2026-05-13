Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022083.outbound.protection.outlook.com [52.101.101.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E02629BD88;
	Wed, 13 May 2026 00:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778633737; cv=fail; b=t4s0CGSJixqNUzXDKxl5yIP7b/rn0iT4NvfVAsZXslQgJcj2wJmI+Q6wQ+tFBFN8r+zwIKDNrJFyQK213vj6UIUamk0W4OqlQ0VJBjP967fuqXMXifwQ9XdNVZ9jQW0+x+4l/faKjuMg4TfyUADBs9Rr5G8m1+38osDIOVRgdb0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778633737; c=relaxed/simple;
	bh=9HC8ussBWkaRLEugnZ7SMDo8ld3PD3BuQfhb2YdByo0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qMIccu8vOFEBQRqF1ddi9Xs00Vma+pFhYIzckE/ampa2DEXNFG9bfKoXo+VOtpsYoNV0U6XuwdvwhkGb62OCFkUFxTTvCI6K44XEK6kQHv8D5Hzeb0XGAx+9GINHQd2g6IMnYunKiZ5s3Ddaz/JrCEmDbksiaJiaVV5CoYD08Ng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.101.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lqy8kDSrndQ+gFOZgSYua1F0nFDXrmpd2Bxl7kuLvUUmwW19xNj/bAjlYp891aq1qSFgvlFlWDKaqtifP3TwmXvLky4D60ZAB+i6GPYK7WD6u3Q9gC0lNQ3wqd0k23gvr6vqMlPgWkOUv6qKLLnxqvbz/5bE+udVQpUiRA2suHipSCyRC4cr8xAMRxBpKZRNBWI/azOD4GtCUpbPfJFZAexfWdxxHCykPUBNsh31kBFZheXEPr3gyLH8TNmNnAujZ1LBIsqJ8EVFVDW2JcNvrkGKM6M27riuZElmSYO6xhqJwzh7nKZesfLLJqJSdEtQoTTQXhiMMXCBOpsFatZlrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aVaFS6L9qRQrm9dGLN+gsBMHWzce41962Ry75xfGuko=;
 b=lRF+gt6Z8gmibgqeIpb660X8xcOPU+AslhaqHcVSRfmdAhjau5QUMmknDiOgijNZUz7QHlUvcMLIB6hBy1nEO2ohBRfQWLkNzw5ruYbDXgAFadGhFjmZoMYF+zSO/VvxDt5RCsb869VoK9m2Lh4wK+2I9z1s7vEUBWhiUHW6hI7WwPOheTupKYLUU/j28TCqbro4lqZWaLWRLqLXK71hSOv8x1fLf3QujatJJ7lVJ/RTTlExiEdNMCVoHzOHFFcVGpukXEQ9Ql9pBddpMTtX7SLzrBSnB35DYWmhRuEqVF6eOQWxNQTR4pVg5yWJ2WL7Y5cjaaY+HGbPCMHk0z+HaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by CWLP123MB4226.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:bb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.17; Wed, 13 May
 2026 00:55:31 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%2]) with mapi id 15.20.9846.025; Wed, 13 May 2026
 00:55:31 +0000
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
Subject: [PATCH v13 5/8] blk-mq: use hk cpus only when isolcpus=io_queue is enabled
Date: Tue, 12 May 2026 20:55:06 -0400
Message-ID: <20260513005509.135966-6-atomlin@atomlin.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260513005509.135966-1-atomlin@atomlin.com>
References: <20260513005509.135966-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0108.namprd03.prod.outlook.com
 (2603:10b6:408:fd::23) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|CWLP123MB4226:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e18df84-766f-4f46-65c8-08deb08a54dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|7416014|3023799003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	mfgAOZM+Com3CPgkiTqHAlO3rRPJ39QSwwyxTAFdutjXNvjLPanTB3d8F3Dd80KZy0694fs9CdqvG7GLtH8GYPb++u+XnNhXhZdL+DYbrasB97TZtABkzGT0yII2pLr8SxsAJnrneWqzHmtP3CAd9xQmH6y+SJZ87VeibPdQGyfvGlB9lL6/izZNu0MCi07mktaa+jRUvsnn1r7AhblvIZDfDS1JFWjdR0V7alVnCzf4zkLE+b72Pd9FMXBNc3JgryKQo6t2jNluYhTNEnDHPkoYhapZU+K+ITpKigFNLvTtaYb0wyTEJmXMaHqskETsJ4XjEdumfWXxNqioh6r7bW7PC7O5946miDeEoibdeWdl1A/LOft9JcIXaqkyAL02X7jIfIvFVFexzo3VkM5eQt47lmriaKccqc810sWy+67HXuFSbTxKCXUQrpB6gkzvNMd1PZWDyu6jinOJEnpQ6SKoQpbXa720j6g+TkkKQBBLe5ujXEVFOs1gW+Vkz6I8Wbe+D9EnYdOsRIjd3JNiSSMahii7/O7Cv5GvxDnoTNLHetZ6fU7P1XnefG5PBMRqFOLVitMG7uf652mqNc0D+MeB91SxusYuTZS8CtFej5DPpC55sCVJPg6eP5s3HPDUgQ8k5+nb8QqBVMQZoznrux+q0ZjxUan9V9gxD3l3e6Hzp/Tlx6yEutB1iB/uGEYm
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(3023799003)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?H/HZU5PCugMlxir5L6e3zkxhIMEDUi2iew9C6wW99PnaL6WD0M0EbxqmFZCs?=
 =?us-ascii?Q?5a/FtGHJH5cAgm2a9VHx8jgarmerdkbpqeySQ/CudpuD7DiNrhPooVL0GBmP?=
 =?us-ascii?Q?NubcCNKrUpgfTMOL/fJTUMNOQrCBVT0a7z7cnw2OnNyzV4mWR3hXBQ/3/wyj?=
 =?us-ascii?Q?a2fxUabFIqnhOkqSXwUbzigwz3yAEh9F8znDOpr8qApkbsx6gS/02jnls46/?=
 =?us-ascii?Q?6rwPLU3z0fWGqSEAkY6pFarwVuPJF0KUgp5GNm14HaCFfuMHAQyNvlzV++W6?=
 =?us-ascii?Q?HEaBw7HIWa+i3IuoLN4+lfoqPeh5spv9z+PlqgWQYIQE4u1Sohd7RW7t+pkO?=
 =?us-ascii?Q?9hN6zwxdztl4lHBVeGNVnhFp/6UjSavdnKwixW9goUhsMsgD//nZQRGHUDJj?=
 =?us-ascii?Q?czP1fdvQyBox91dkO1aOxF+ayhG9Lmp2X9C1FfBEEHUhRuXE+6SkBW1GMANJ?=
 =?us-ascii?Q?Kq95FLC5MrjERxbeuNUnK+XBHwl3FoReBvAV52lVl28dBBJ7vge77XNaT4j2?=
 =?us-ascii?Q?uqDSTNllYvM478zwnjZ0QuYME0CFS8LYiMz3Tmf+jksytuL11gMhB05PuoCp?=
 =?us-ascii?Q?W6/S70LX7xqPnjtCt6qaks05ZJYeEFxumU0Ln1ogTpswhqXJ364u5qYDhSL7?=
 =?us-ascii?Q?Qc3Nj6NR+FE3LsudrKbxTtFaqvnQsFhLjpLEGmI7evIr0yxyL1OFBacv6qcd?=
 =?us-ascii?Q?zxAN8ao0aty39QoKuNs5cGEzFnvLHOrUdxBBzC77BnJmP929mL+36+3VSauk?=
 =?us-ascii?Q?OG5pVDv9P7mwv8yfDT0Slwxf2AK3+Ao9PM0acBNV3GqzJKPLXn5rjLWLQgOa?=
 =?us-ascii?Q?2OdwyZLakPjWaoIrxyDA3a2Qs/zitVVtahYTaXgLMOHEYAy7/jTaon44NEBa?=
 =?us-ascii?Q?g3dvY31x1bRka6GBwDLrmI3bdLEHG1G86BmxLHUTwkMlHN4R3V5jhu9Imlgz?=
 =?us-ascii?Q?m5TcDGMhNgyArXbNXc97Vdt/+zmn94dQiOvdrjArShltJjZ5jXvQDkCxkDzC?=
 =?us-ascii?Q?I3hXgeGkXR+ZhNXSzIX/NzBlJbJXveApIVbj8BoqhQdvDx8BE8Lh88hjBIvg?=
 =?us-ascii?Q?JjRp8O95z6f026zZFlQBtNeZOxcHTYbg41w4DH+mUpH4AJWOK0x7+hkypR6o?=
 =?us-ascii?Q?netNt/5i4SU32vqpcObeOn+iHK8hXjBvcqjtYeK/l9DMPpZHUrLY+2wAAylc?=
 =?us-ascii?Q?80Da7TS827LTLPfSknz4zQ0iDhErh8H9C8gWYQ2FDWo3urgz4ZYBnB0lD8kM?=
 =?us-ascii?Q?ZktIPVbyS3PPjfkv1TTqqKGTmWZVrBDvUXSH53/JEuXG2wJz/KpTYq36+d0E?=
 =?us-ascii?Q?7iOdvKNycdJpyOFFxNg8SFxcmGhInty9u/gEgPDuiS4AuL9+sAX5Dw/cIMrj?=
 =?us-ascii?Q?074ytyOulVNA6R6Q/Z2YE+cEbNJh6atYMDlowTtUwjOcB4XopOKvrySNA6k3?=
 =?us-ascii?Q?qEpPdr+wtvJveEi+q8+tVaweXIatV/pBjcnzIhTs1fMPcnuTMLQD8fx1hhx1?=
 =?us-ascii?Q?FjIeUeiqJ2pBQalX320TmWsjq1ii49Uu8beJEid0394xFYj6jZXJIO1zkSDv?=
 =?us-ascii?Q?Hg+pXEc/FkRr0zCQyYmAQ9+m8++AZxPFKQbrE7XiNVdjevYGWtf08VYbZyD4?=
 =?us-ascii?Q?pxvl9ZqVKf1/tDDpGDUxdsqAoUAVck2Zjxz+or0svixxz5sA8f+5Ppkh/onU?=
 =?us-ascii?Q?P83YP/2flwJHIERfm6xjihXUS3W+cW+hUpwKO32lBEhNZHr4J3qj/lguDLU2?=
 =?us-ascii?Q?to5rS7hcwQ=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e18df84-766f-4f46-65c8-08deb08a54dd
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 00:55:31.0936
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /hl9cblj9M7a1gvR1Oy3fkkQyY5fByUBqMnA+Ol96e/Idy7OXG39BCUeqiU3lNuK4T8Q5gIEw1WlpX5HDLHuqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP123MB4226

From: Daniel Wagner <wagi@kernel.org>

Extend the capabilities of the generic CPU to hardware queue (hctx)
mapping code, so it maps houskeeping CPUs and isolated CPUs to the
hardware queues evenly.

A hctx is only operational when there is at least one online
housekeeping CPU assigned (aka active_hctx). Thus, check the final
mapping that there is no hctx which has only offline housekeeing CPU and
online isolated CPUs.

Example mapping result:

  16 online CPUs

  isolcpus=io_queue,2-3,6-7,12-13

Queue mapping:
        hctx0: default 0 2
        hctx1: default 1 3
        hctx2: default 4 6
        hctx3: default 5 7
        hctx4: default 8 12
        hctx5: default 9 13
        hctx6: default 10
        hctx7: default 11
        hctx8: default 14
        hctx9: default 15

IRQ mapping:
        irq 42 affinity 0 effective 0  nvme0q0
        irq 43 affinity 0 effective 0  nvme0q1
        irq 44 affinity 1 effective 1  nvme0q2
        irq 45 affinity 4 effective 4  nvme0q3
        irq 46 affinity 5 effective 5  nvme0q4
        irq 47 affinity 8 effective 8  nvme0q5
        irq 48 affinity 9 effective 9  nvme0q6
        irq 49 affinity 10 effective 10  nvme0q7
        irq 50 affinity 11 effective 11  nvme0q8
        irq 51 affinity 14 effective 14  nvme0q9
        irq 52 affinity 15 effective 15  nvme0q10

A corner case is when the number of online CPUs and present CPUs
differ and the driver asks for less queues than online CPUs, e.g.

  8 online CPUs, 16 possible CPUs

  isolcpus=io_queue,2-3,6-7,12-13
  virtio_blk.num_request_queues=2

Queue mapping:
        hctx0: default 0 1 2 3 4 5 6 7 8 12 13
        hctx1: default 9 10 11 14 15

IRQ mapping
        irq 27 affinity 0 effective 0 virtio0-config
        irq 28 affinity 0-1,4-5,8 effective 5 virtio0-req.0
        irq 29 affinity 9-11,14-15 effective 0 virtio0-req.1

Noteworthy is that for the normal/default configuration (!isoclpus) the
mapping will change for systems which have non hyperthreading CPUs. The
main assignment loop will completely rely that group_mask_cpus_evenly to
do the right thing. The old code would distribute the CPUs linearly over
the hardware context:

queue mapping for /dev/nvme0n1
        hctx0: default 0 8
        hctx1: default 1 9
        hctx2: default 2 10
        hctx3: default 3 11
        hctx4: default 4 12
        hctx5: default 5 13
        hctx6: default 6 14
        hctx7: default 7 15

The assign each hardware context the map generated by the
group_mask_cpus_evenly function:

queue mapping for /dev/nvme0n1
        hctx0: default 0 1
        hctx1: default 2 3
        hctx2: default 4 5
        hctx3: default 6 7
        hctx4: default 8 9
        hctx5: default 10 11
        hctx6: default 12 13
        hctx7: default 14 15

In case of hyperthreading CPUs, the resulting map stays the same.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
[atomlin:
    - Updated blk_mq_validate() to use test_bit() for the new bitmap
    - Replaced __free cleanups with traditional goto unwinding to align
      with subsystem styling
    - Updated blk_mq_map_fallback() to use qmap->queue_offset ensuring
      secondary maps do not incorrectly route to the primary default map
    - Added a bitmap_empty() check to prevent out-of-bounds CPU routing
      when all mapped CPUs are offline
    - Migrated active_hctx to a dynamically sized bitmap to fix an
      out-of-bounds write when hardware queues exceed the system CPU
      count
    - Fixed absolute vs. relative hardware queue index mix-up in
      blk_mq_map_queues() and validation checks
    - Fixed typographical errors
    - Reduced stack frame size of blk_mq_num_queues()
    - Resolved a TOCTOU race against CPU hotplug events by snapshotting
      cpu_online_mask to ensure mapping and validation phases agree
    - Corrected a loop overwrite bug in blk_mq_map_queues() by iterating
      directly over masks to prevent orphaned queues from being activated
    - Restored topology-aware multi-queue fallback in
      blk_mq_map_hw_queues() for devices lacking IRQ affinity hints
    - Hardened isolation logic in blk_mq_map_hw_queues() to require online
      housekeeping CPUs before marking a hardware queue as active
    - Optimised active queue evaluations by short-circuiting redundant
      checks once a valid CPU is found]
Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 block/blk-mq-cpumap.c | 224 ++++++++++++++++++++++++++++++++++++++----
 1 file changed, 207 insertions(+), 17 deletions(-)

diff --git a/block/blk-mq-cpumap.c b/block/blk-mq-cpumap.c
index 705da074ad6c..f953714d190c 100644
--- a/block/blk-mq-cpumap.c
+++ b/block/blk-mq-cpumap.c
@@ -22,7 +22,11 @@ static unsigned int blk_mq_num_queues(const struct cpumask *mask,
 {
 	unsigned int num;
 
-	num = cpumask_weight(mask);
+	if (housekeeping_enabled(HK_TYPE_IO_QUEUE))
+		num = cpumask_weight_and(mask, housekeeping_cpumask(HK_TYPE_IO_QUEUE));
+	else
+		num = cpumask_weight(mask);
+
 	return min_not_zero(num, max_queues);
 }
 
@@ -33,7 +37,8 @@ static unsigned int blk_mq_num_queues(const struct cpumask *mask,
  *		ignored.
  *
  * Calculates the number of queues to be used for a multiqueue
- * device based on the number of possible CPUs.
+ * device based on the number of possible CPUs. This helper
+ * takes isolcpus settings into account.
  */
 unsigned int blk_mq_num_possible_queues(unsigned int max_queues)
 {
@@ -48,7 +53,8 @@ EXPORT_SYMBOL_GPL(blk_mq_num_possible_queues);
  *		ignored.
  *
  * Calculates the number of queues to be used for a multiqueue
- * device based on the number of online CPUs.
+ * device based on the number of online CPUs. This helper
+ * takes isolcpus settings into account.
  */
 unsigned int blk_mq_num_online_queues(unsigned int max_queues)
 {
@@ -56,23 +62,139 @@ unsigned int blk_mq_num_online_queues(unsigned int max_queues)
 }
 EXPORT_SYMBOL_GPL(blk_mq_num_online_queues);
 
+static bool blk_mq_validate(struct blk_mq_queue_map *qmap,
+			    const unsigned long *active_hctx,
+			    const struct cpumask *online_mask)
+{
+	/*
+	 * Verify if the mapping is usable when housekeeping
+	 * configuration is enabled
+	 */
+	for (int queue = 0; queue < qmap->nr_queues; queue++) {
+		int cpu;
+
+		if (test_bit(queue, active_hctx)) {
+			/*
+			 * This hctx has at least one online CPU thus it
+			 * is able to serve any assigned isolated CPU.
+			 */
+			continue;
+		}
+
+		/*
+		 * There is no housekeeping online CPU for this hctx, all
+		 * good as long as all non-housekeeping CPUs are also
+		 * offline.
+		 */
+		for_each_cpu(cpu, online_mask) {
+			if (qmap->mq_map[cpu] != qmap->queue_offset + queue)
+				continue;
+
+			pr_warn("Unable to create a usable CPU-to-queue mapping with the given constraints\n");
+			return false;
+		}
+	}
+
+	return true;
+}
+
+static void blk_mq_map_fallback(struct blk_mq_queue_map *qmap)
+{
+	unsigned int cpu;
+
+	/*
+	 * Map all CPUs to the first hctx of this specific map to ensure
+	 * at least one online CPU is serving it, respecting the map's
+	 * boundaries so secondary maps do not route into the default map.
+	 */
+	for_each_possible_cpu(cpu)
+		qmap->mq_map[cpu] = qmap->queue_offset;
+}
+
 void blk_mq_map_queues(struct blk_mq_queue_map *qmap)
 {
-	const struct cpumask *masks;
+	struct cpumask *masks;
+	const struct cpumask *constraint;
 	unsigned int queue, cpu, nr_masks;
+	unsigned long *active_hctx;
+	cpumask_var_t online_mask;
 
-	masks = group_cpus_evenly(qmap->nr_queues, &nr_masks);
-	if (!masks) {
-		for_each_possible_cpu(cpu)
-			qmap->mq_map[cpu] = qmap->queue_offset;
-		return;
-	}
+	active_hctx = bitmap_zalloc(qmap->nr_queues, GFP_KERNEL);
+	if (!active_hctx)
+		goto fallback;
 
-	for (queue = 0; queue < qmap->nr_queues; queue++) {
-		for_each_cpu(cpu, &masks[queue % nr_masks])
+	if (!alloc_cpumask_var(&online_mask, GFP_KERNEL))
+		goto free_fallback_hctx;
+
+	/*
+	 * Snapshot online CPUs to prevent TOCTOU races between the
+	 * mapping phase and the validation phase.
+	 */
+	cpumask_copy(online_mask, cpu_online_mask);
+
+	if (housekeeping_enabled(HK_TYPE_IO_QUEUE))
+		constraint = housekeeping_cpumask(HK_TYPE_IO_QUEUE);
+	else
+		constraint = cpu_possible_mask;
+
+	/* Map CPUs to the hardware contexts (hctx) */
+	masks = group_mask_cpus_evenly(qmap->nr_queues, constraint, &nr_masks);
+	if (!masks)
+		goto free_fallback;
+
+	/*
+	 * Iterate directly over the generated CPU masks.
+	 * Calculate the final, highest hardware queue index that maps to this
+	 * mask. This skips all intermediate overwrites and safely evaluates
+	 * active_hctx only for queues that survive the mapping.
+	 */
+	for (unsigned int idx = 0; idx < nr_masks; idx++) {
+		bool active = false;
+		queue = qmap->nr_queues - 1 -
+			((qmap->nr_queues - 1 - idx) % nr_masks);
+
+		for_each_cpu(cpu, &masks[idx]) {
 			qmap->mq_map[cpu] = qmap->queue_offset + queue;
+
+			if (!active && cpumask_test_cpu(cpu, online_mask)) {
+				__set_bit(queue, active_hctx);
+				active = true;
+			}
+		}
+	}
+
+	/*
+	 * If all CPUs in the generated masks are offline, the active_hctx
+	 * bitmap will be empty. Attempting to route unassigned CPUs to an
+	 * empty bitmap will map them out-of-bounds. Fall back instead.
+	 */
+	if (bitmap_empty(active_hctx, qmap->nr_queues))
+		goto free_fallback;
+
+	/* Map any unassigned CPU evenly to the hardware contexts (hctx) */
+	queue = find_first_bit(active_hctx, qmap->nr_queues);
+	for_each_cpu_andnot(cpu, cpu_possible_mask, constraint) {
+		qmap->mq_map[cpu] = qmap->queue_offset + queue;
+		queue = find_next_bit_wrap(active_hctx, qmap->nr_queues, queue + 1);
 	}
+
+	if (!blk_mq_validate(qmap, active_hctx, online_mask))
+		goto free_fallback;
+
 	kfree(masks);
+	free_cpumask_var(online_mask);
+	bitmap_free(active_hctx);
+
+	return;
+
+free_fallback:
+	kfree(masks);
+	free_cpumask_var(online_mask);
+free_fallback_hctx:
+	bitmap_free(active_hctx);
+
+fallback:
+	blk_mq_map_fallback(qmap);
 }
 EXPORT_SYMBOL_GPL(blk_mq_map_queues);
 
@@ -109,24 +231,92 @@ void blk_mq_map_hw_queues(struct blk_mq_queue_map *qmap,
 			  struct device *dev, unsigned int offset)
 
 {
-	const struct cpumask *mask;
+	cpumask_var_t mask, online_mask;
+	const struct cpumask *constraint;
+	unsigned long *active_hctx;
 	unsigned int queue, cpu;
 
 	if (!dev->bus->irq_get_affinity)
+		goto map_software;
+
+	active_hctx = bitmap_zalloc(qmap->nr_queues, GFP_KERNEL);
+	if (!active_hctx)
+		goto fallback;
+
+	if (!zalloc_cpumask_var(&mask, GFP_KERNEL)) {
+		bitmap_free(active_hctx);
 		goto fallback;
+	}
+
+	if (!alloc_cpumask_var(&online_mask, GFP_KERNEL))
+		goto free_fallback_mask;
 
+	if (housekeeping_enabled(HK_TYPE_IO_QUEUE))
+		constraint = housekeeping_cpumask(HK_TYPE_IO_QUEUE);
+	else
+		constraint = cpu_possible_mask;
+
+	/*
+	 * Snapshot online CPUs to prevent TOCTOU races between the
+	 * mapping phase and the validation phase.
+	 */
+	cpumask_copy(online_mask, cpu_online_mask);
+
+	/* Map CPUs to the hardware contexts (hctx) */
 	for (queue = 0; queue < qmap->nr_queues; queue++) {
-		mask = dev->bus->irq_get_affinity(dev, queue + offset);
-		if (!mask)
-			goto fallback;
+		const struct cpumask *affinity_mask;
+		bool active = false;
+
+		affinity_mask = dev->bus->irq_get_affinity(dev, offset + queue);
+		if (!affinity_mask)
+			goto free_fallback;
 
-		for_each_cpu(cpu, mask)
+		for_each_cpu(cpu, affinity_mask) {
 			qmap->mq_map[cpu] = qmap->queue_offset + queue;
+
+			cpumask_set_cpu(cpu, mask);
+			if (!active && cpumask_test_cpu(cpu, online_mask) &&
+			    cpumask_test_cpu(cpu, constraint)) {
+				__set_bit(queue, active_hctx);
+				active = true;
+			}
+		}
+	}
+
+	/*
+	 * If all CPUs assigned to this map are offline, the bitmap will
+	 * be empty. Fall back instead of routing out of bounds.
+	 */
+	if (bitmap_empty(active_hctx, qmap->nr_queues))
+		goto free_fallback;
+
+	/* Map any unassigned CPU evenly to the hardware contexts (hctx) */
+	queue = find_first_bit(active_hctx, qmap->nr_queues);
+	for_each_cpu_andnot(cpu, cpu_possible_mask, mask) {
+		qmap->mq_map[cpu] = qmap->queue_offset + queue;
+		queue = find_next_bit_wrap(active_hctx, qmap->nr_queues, queue + 1);
 	}
 
+	if (!blk_mq_validate(qmap, active_hctx, online_mask))
+		goto free_fallback;
+
+	bitmap_free(active_hctx);
+	free_cpumask_var(mask);
+	free_cpumask_var(online_mask);
+
 	return;
 
+free_fallback:
+	free_cpumask_var(online_mask);
+free_fallback_mask:
+	bitmap_free(active_hctx);
+	free_cpumask_var(mask);
+
 fallback:
+	blk_mq_map_fallback(qmap);
+	return;
+
+map_software:
 	blk_mq_map_queues(qmap);
 }
 EXPORT_SYMBOL_GPL(blk_mq_map_hw_queues);
-- 
2.51.0

