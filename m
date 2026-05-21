Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021092.outbound.protection.outlook.com [52.101.95.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E996349CEF;
	Thu, 21 May 2026 23:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779406224; cv=fail; b=jvR/qxigVN8QoEKyj4Jysqi0Huv2zq1eEbQgutMuYWqVQt7KsWC1tfLnto7OHbBK0bnp1H88lBWWyQwuDUGVpsgkNybpbaOXXTTg4iIzKO+3qRW5p8K3ZebSNXB0POq84VNWCo2ujMWuCaeJD3qr83pPAcqS6UahsWjoaryLCMI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779406224; c=relaxed/simple;
	bh=mEgPEYQ9F1IaI/uERYxT6SXvV9zsVxRzE3h48JdSpt0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RkQ8GQoxjlNxh+rC+sxSRuVGiOw2R5AcB7jITCLrSpTCrY02p3WZcsgqjrk7C0OeTKMu5q9iijsC/S40YrHeSpan07vgC9A2ywI7GbAVtmJi9tsezTSid1hOOaeTKcRCl5e5/BtnAd8AJPKL+SlKhNbDBHp+PZrsnq/ry5T8u9c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.95.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KNooaKGhXi0K8btC+Cwh0miKaPgTp+9e8E5WxzbsTsGhnvSNBzKVhJjHzzBA2UB2brhpfv30tpK7uVhR2oSGq0XxBd/C1zGik7bpRt4GZGnUw88UyY46PxMTPBlT8JvAxCEPzIwVX/YwEbdCq3JmUDbzFM7iRA2btbvtBkhlcCI/YzGc2UstfoctMm8+Ybg682cNqH0D1xaDX+QH938YyMJbpNpQyxb8bL7PGLIfPvdy+PpJKe5NOu9hjTSs6QZK8HBI/xDARygpBaVn5OcSeHtLZiWK7tQpSBA6IYreitriYDJSp7ruiQUAEF9tQWRrroIn/4XISiehImFhsjXTOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s8RNbQHWHSGF8SihSPL+dJwzsPZqZWqbOhVKbsk6BOs=;
 b=NWwBE4ESMGvCIFR0qSPjks5HsPoayY47sNVjt4PPEWHxFxxMPM/RdW+SnxfQy99q581+IOLVTsSO2HOY9pZnzaghCIjN0hkEbQXjKo6vD+2eY0JM3Dsj//eADTuADPWxmRTzz47yl+K8Ojc6uozLuGw0YYnTrRkpcXBDSbK5IMSpwAqKSSYP4veWNNlxvqbucaeu2o8FZjhgpJJqEfjJltGZiFGhF6wqdN9ZcNEfYj0dLyK+N0ENgewW5t7fUXFJwnuKUSHjHMT4VOIavSVPkMnv/hM5fk8oKt7FfUgYceB54hGPRRqEuxyYQSSPwM6TUbQfMnLcW/FwhgwqVw2Btg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by CWLP123MB6796.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:1e9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Thu, 21 May
 2026 23:30:20 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0048.016; Thu, 21 May 2026
 23:30:20 +0000
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
Subject: [PATCH v15 5/8] blk-mq: use hk cpus only when isolcpus=io_queue is enabled
Date: Thu, 21 May 2026 19:29:53 -0400
Message-ID: <20260521232956.553287-6-atomlin@atomlin.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260521232956.553287-1-atomlin@atomlin.com>
References: <20260521232956.553287-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0341.namprd03.prod.outlook.com
 (2603:10b6:408:f6::16) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|CWLP123MB6796:EE_
X-MS-Office365-Filtering-Correlation-Id: 75752910-708a-4448-c0d9-08deb790ec24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|56012099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	ztbX0D2SofF9RCriT3IZtSbAL0gxfBjyoLbvyrqw5xaF3WmUubtC3ceLfqmMbtiJwtssF8cJ8JWOV15YI92R1vPNWzF4HcNPbykM5aD67rUdRR8Q5eARuk8lB84YZFlDGSC+hEpSBi7UDw9srPNEv3aqP6mG7OrPs/jPX0xmaqmWC1hgoPJA4uuDq6RcoB3lu+KDrK85Y+R9DnB8P0OjpPD1nr3KKaUSgW4qJj/fmb52I7ZxqjMwM5AvMmiCi/mi+YIK7YydXP+FfEbTnN1plkySCqr4OlB/NR5z3/kFfczAiKiv+X/jSvDJ8sd/WnNPVVA8LLv0R4BkcHToSPeUS81psHEh501JzFqDU+9VU79oKToNZLw8gwJ9f9OqttzF1be4sfl1u9k3TS9VhYzqiMGukzeLPhzxUi3De9RXqt7CLCqFQ+HGEhlkskymGDZIicY6Eqs3IxWdjUdO579RC8gplwmZ3mYZ/1v9anfANfbHS7dUmfYlw+CANX2GbXJPZDZ08Sb3/o/wjoS8ihWCy8bNRwWG/sWZeGrysJEizqfJQShOGS/gaF6WPFX5wTp2PgtBruByZKrWRIH7LJze4FP5J0O1oeqq1F+vinOpbsoGaisDWucvgLK4zlUmMzH6bxzl87lEbXHfzcZ6f6QlOEhM/MbVW8zABGV3+5zaGRCPYp6QXTTHPH6vh03b6nUo
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(56012099003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0mLSJPl5qdcvR8LV+gALiPjtjxYz4IoZIC/0+EbDYbBSDJH93I8MEgkAZ0Uh?=
 =?us-ascii?Q?0AEyV460dw2LtvxYXVjU8tKGjoswihp63CQ8yAJhygRjyNYc8pe1XAORzvWg?=
 =?us-ascii?Q?BGmEkrgh0ptJK2UJWhTD8LLI/Fpx5RiEOjzoTWLZtVhC/4dULUhrT5KqCGu4?=
 =?us-ascii?Q?cxMUyy2vH99fEWwnkJg459JoCU17u9RObXGyODPlmaDQISqulqSA+fqE7NxL?=
 =?us-ascii?Q?n8H48EUKdr1KYMEcQ8uedK0ML28muP1sjuIk0086WtySskWUoKfewnXpXTyK?=
 =?us-ascii?Q?+OI0m7DYDlFXVTVOb43WBKuK/3+M7rzH85TncBbALbVhsPIIfZz6Km7rw+PM?=
 =?us-ascii?Q?14q/XiozUXOlfM5J5r4rqxXIEXmwbGJKb5Z7J1siGrWC6Hqk3OdHNDcDiTku?=
 =?us-ascii?Q?VTi7qTIy3wo5sd1Imo2y80Wn9Viiw5I7eTqKIqWZ4LDmBDYOF6NTDWlvjLAv?=
 =?us-ascii?Q?S9Ye54T71uqrGN3iq5QKqgcxyqfBUVhC3dz4+wPLDtAy7DVUjEVHLv5sikDv?=
 =?us-ascii?Q?OItzTlm6toSMbbN5XHpVaaN03yI+4qd68u3DCQN7vE1uDWJPDzQN9IeOXJap?=
 =?us-ascii?Q?3v2XrxrAm42M/X+tMkOaOEzed2KVCB/Xnm7lLzDCiDLT4ocvstdosbdJJscc?=
 =?us-ascii?Q?DDgL08wGsFDjNvjn+1GpyG1Ch6pD+C77aRi2ew2mvgifg+tOONEyflhXjXNc?=
 =?us-ascii?Q?64PtFWGNhk/ikfreM4KlmsUhZp7k1mivgORaf45NyjcFLejrsefzsqbHrEt7?=
 =?us-ascii?Q?DfoVjDHbNapKCR6CijuaIfgxXWP6aMuk1nBHUxdXVMB7ngrzLzXXr83yHRsA?=
 =?us-ascii?Q?JQkIbQ74+k1BhTdlzBxNpTg2Jl2EukqIgOkCx0FGv+D6XXWdDmXaxDuKqG7Z?=
 =?us-ascii?Q?qFjZM3BnF70U7o6/O6FRvjPZGdchbKWNkZRnL1u9/6c/0hnuuzhMUB9AX7R3?=
 =?us-ascii?Q?W5Gp5OGXRsry5qyQioEup4LTef3mP06+SZ8pQ8DIFCn23NlgVAmEKLikcShg?=
 =?us-ascii?Q?4Z3Lk5YxusVZ/OeJdVR9z3PTpOM/3HASNq2QeufMXxzEGdnvHdbhb9Bh1YvK?=
 =?us-ascii?Q?L+UuuuuA+oZFY0OuIEo+gWofDclhs4WKxt+/xzbFSKT1oi685WGTPmvoA7ed?=
 =?us-ascii?Q?/zjk2t5pW3SmiROBBa/Vj73e0aYfAzOYPN0tIXEukSa4wuD7ZczfKDhSSSyq?=
 =?us-ascii?Q?4eWHgv2nXYzeM01VrcUYT/JT4Bc0RUDiBixANZ1+sl7/K1z01vZAThUSp4ik?=
 =?us-ascii?Q?4ZvZ4jKb4FDkC9k8/KjCS2ubZbDP3Xn8dI2Bc9WBfBtKYmvzpMLcNBnDLzCd?=
 =?us-ascii?Q?JAwbTQdVs2Dhdxesbz/l2x2cjPSHU43C3DbjBz4Wh+zYblv30Y1j9e8pfMh8?=
 =?us-ascii?Q?/oISW0Wz6LIfiQa/Pqw1PLtGCT0m3QcmRh6ZgGjhcRLvkChnh2uU5OQrPsPp?=
 =?us-ascii?Q?E+0809nvEstHoIDmQKBeYUCqxX9A+jbKIYDCo3qaV3O+NJ4W4jO4MSmb4vt1?=
 =?us-ascii?Q?9UL5HYex9CJpWIrkmpik7XPKG+dudYPdaYQTMSgB1C8rEz0df/qvcne/v0kQ?=
 =?us-ascii?Q?kLV+ivKAuKlILisuXzpckLZAMtMN55gkpoSOL41g6EG9tAoiyzE/hQoJzcI7?=
 =?us-ascii?Q?hoHlF7nbeZys/ooqXzWgF3ecL0bWVykNeHFGgbNoa4eXVd09rkVgvJGSxpSI?=
 =?us-ascii?Q?fgecjAMq2Lw9wFgKwMpAKXnNfziVUKtzp9u4K3vsKm9T/d2p29ZPLBXNF1ZZ?=
 =?us-ascii?Q?eD6oYQDB+Q=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75752910-708a-4448-c0d9-08deb790ec24
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 23:30:19.9582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RJPXwRTCdM5E2u1QTUZGsfJQxZa0t7ul9Xfd2+b20dAKnpuqJabS1Nhm74BFE3WPLGZOXm/S8t6ImUuJC+xtwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP123MB6796

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
      blk_mq_map_hw_queues() by correctly routing missing IRQ affinity
      masks to the map_software path instead of the naive fallback
    - Fixed a silent validation bypass in blk_mq_map_hw_queues() caused by
      overlapping IRQ affinity masks by evaluating the active_hctx bitmap
      in a secondary pass
    - Hardened isolation logic in blk_mq_map_hw_queues() to require online
      housekeeping CPUs before marking a hardware queue as active
    - Enforce safe fallback of 1 when the intersection evaluates to 0]
Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 block/blk-mq-cpumap.c | 238 ++++++++++++++++++++++++++++++++++++++----
 1 file changed, 220 insertions(+), 18 deletions(-)

diff --git a/block/blk-mq-cpumap.c b/block/blk-mq-cpumap.c
index 705da074ad6c..efb02655f59e 100644
--- a/block/blk-mq-cpumap.c
+++ b/block/blk-mq-cpumap.c
@@ -22,8 +22,15 @@ static unsigned int blk_mq_num_queues(const struct cpumask *mask,
 {
 	unsigned int num;
 
-	num = cpumask_weight(mask);
-	return min_not_zero(num, max_queues);
+	if (housekeeping_enabled(HK_TYPE_IO_QUEUE))
+		num = cpumask_weight_and(mask, housekeeping_cpumask(HK_TYPE_IO_QUEUE));
+	else
+		num = cpumask_weight(mask);
+	/*
+	 * Ensure that a count of zero does not inadvertently result in
+	 * allocating the maximum number of queues.
+	 */
+	return min_not_zero(num ?: 1U, max_queues);
 }
 
 /**
@@ -33,7 +40,8 @@ static unsigned int blk_mq_num_queues(const struct cpumask *mask,
  *		ignored.
  *
  * Calculates the number of queues to be used for a multiqueue
- * device based on the number of possible CPUs.
+ * device based on the number of possible CPUs. This helper
+ * takes isolcpus settings into account.
  */
 unsigned int blk_mq_num_possible_queues(unsigned int max_queues)
 {
@@ -48,7 +56,8 @@ EXPORT_SYMBOL_GPL(blk_mq_num_possible_queues);
  *		ignored.
  *
  * Calculates the number of queues to be used for a multiqueue
- * device based on the number of online CPUs.
+ * device based on the number of online CPUs. This helper
+ * takes isolcpus settings into account.
  */
 unsigned int blk_mq_num_online_queues(unsigned int max_queues)
 {
@@ -56,23 +65,139 @@ unsigned int blk_mq_num_online_queues(unsigned int max_queues)
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
 
@@ -109,24 +234,101 @@ void blk_mq_map_hw_queues(struct blk_mq_queue_map *qmap,
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
+
+	if (housekeeping_enabled(HK_TYPE_IO_QUEUE))
+		constraint = housekeeping_cpumask(HK_TYPE_IO_QUEUE);
+	else
+		constraint = cpu_possible_mask;
 
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
+
+		affinity_mask = dev->bus->irq_get_affinity(dev, offset + queue);
+		if (!affinity_mask)
+			goto free_map_software;
 
-		for_each_cpu(cpu, mask)
+		for_each_cpu(cpu, affinity_mask) {
 			qmap->mq_map[cpu] = qmap->queue_offset + queue;
+			cpumask_set_cpu(cpu, mask);
+		}
+	}
+
+	/*
+	 * Evaluate active_hctx after mapping to handle overlapping masks.
+	 * This ensures queues that were overwritten do not falsely pass validation.
+	 */
+	for_each_cpu(cpu, mask) {
+		if (cpumask_test_cpu(cpu, online_mask) &&
+			cpumask_test_cpu(cpu, constraint)) {
+			queue = qmap->mq_map[cpu] - qmap->queue_offset;
+			__set_bit(queue, active_hctx);
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
+free_map_software:
+	free_cpumask_var(online_mask);
+	free_cpumask_var(mask);
+	bitmap_free(active_hctx);
+map_software:
 	blk_mq_map_queues(qmap);
 }
 EXPORT_SYMBOL_GPL(blk_mq_map_hw_queues);
-- 
2.51.0

