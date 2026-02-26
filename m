Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012039.outbound.protection.outlook.com [52.101.48.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0CEE36F420
	for <linux-block@vger.kernel.org>; Thu, 26 Feb 2026 03:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772075620; cv=fail; b=n/CFDfG7KK0EdNAGNd2UzRHf7Tw1cgYthens9/gs3n4RkoKx//1vmxrPRS67XfqDVVPN3ml08DJpDmjiS5YKy3BwAMe/RVf+r6Bciq2blQIUtUq0TYQgLhPugabQWz77pPnVR6Sy9uS69HSRiIaEnVxDe+XEBzti27bdF7Jn1DA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772075620; c=relaxed/simple;
	bh=WcJx2iM9haq+erYafdCQVvr+N0njd5sH5P8cRSA3rOM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y/6oCIcgcGF4r5DRTFsbnA+w1l2/daxNP/AzM7b1sGkktVwcFj+zmlQt0rteA6V7KDzyRD7SHHqaTVauZmjvqnWUseoGVfeF2oYSRLKujElFLkPxlAy6rh136YMXfQxpK1zNme3rT08/ZJj3GUaAN7IOr1MQvOQseV11PM5a2mQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tPvFbN58; arc=fail smtp.client-ip=52.101.48.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tPvFbN58"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k0n1jO/hJf1jMceZGtZrEqwXalWV7xjvLcwj9hoYiQxA58LLV+XlPGwpGO8YSLz2eVePVrKGtBp6y9RNpU+jaYqSsukiJW8oebYNUpQcpGiCwN5g81QWKysKuYqdngwWaIGgF2T2jsly1/Lc0YwyXb4sVtDNgl62mytiPjKuIJRDoD8cNbd5kvD57i3abAR4hor2doZY6BqWpDikHQa5jrRuK1ZREyTfSlLGGsv459jzutvh5gZZtlT2y2ht+lXHn9R+Aq9j1dCg9y2eBdT+awnXK8jDmpymEAFnsZQCW+FNL++1pU8jmRQmH7xNWVylRZ7sYXLbcbXd4kSDW/I16A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CRboSxT16kSkSDZ9y0BMLLoU/m+/+z7xTMwaKTgsZlQ=;
 b=u/EHGY0TFtukbEIssMJnVWQJo8ZkgxuJAJUBENVfB22qxkhabSYQzwb15H+3Dr7HAhfWnyaoRfx3IvNMidXQEl/RgSTuBP7xoo++/OUjG4A9x/pLtDG6sVGY8bMKpdohTkIbiMDh5CULou1DTtJdcT8oc4I+0goTIG08FiaOkmy+6E0MyjaUJzc7HpFaVcSaXlbJ7jmaZDg1Az98BZLi1OFEkcfCCY3sB0Aj/+u4o8p3lubIvMTssmDViKpw+3LOC/QUGbW8tGcrufKyKA7LLD4zKAEkqv5O2kE6e56Q0bayDco8hm1trpUH3k/gAeLd3rHHL8HtQNuM1v7DKAZ3Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CRboSxT16kSkSDZ9y0BMLLoU/m+/+z7xTMwaKTgsZlQ=;
 b=tPvFbN58X3ArQYuwHGDdfG6UEmlxI2ZMxsCAYH5G2P6ivtENZBK8L8Dp0CDovk9UFur1vgHn/Ec7E2dRPcF8/2sWFj15hpxnA0yIEx64VhPzP0/o169rIa2E5C7bKsQrse3fzk6/kGi6lNeoKnP/OwXk49ebZj6sZQzlpXGKsyoNl2A5EJaqdAUq0QrscKavI1nENPU2iT3ru/NaRtMe/50IR1YXOXzpDbyZkZ1lJW0M+wLp+ARyPeCXTpuEhWErRSgdmTO+hyhYovbcRBi+hb1KjNQKEPVcXko6JUM00XkfU/twPoF4wjsj9eM4QNocBjfVuWlXPEVwv/0cgN7Pxw==
Received: from DS7P222CA0015.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::27) by
 PH7PR12MB6935.namprd12.prod.outlook.com (2603:10b6:510:1b9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Thu, 26 Feb
 2026 03:13:33 +0000
Received: from DS1PEPF0001708F.namprd03.prod.outlook.com
 (2603:10b6:8:2e:cafe::9a) by DS7P222CA0015.outlook.office365.com
 (2603:10b6:8:2e::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.23 via Frontend Transport; Thu,
 26 Feb 2026 03:13:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS1PEPF0001708F.mail.protection.outlook.com (10.167.17.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 26 Feb 2026 03:13:32 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Feb
 2026 19:13:23 -0800
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Feb
 2026 19:13:22 -0800
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>, <wagi@monom.org>
CC: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
	"Chaitanya Kulkarni" <kch@nvidia.com>
Subject: [PATCH V2 2/2] block: clear BIO_QOS flags in blk_steal_bios()
Date: Wed, 25 Feb 2026 19:12:43 -0800
Message-ID: <20260226031243.87200-3-kch@nvidia.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260226031243.87200-1-kch@nvidia.com>
References: <20260226031243.87200-1-kch@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708F:EE_|PH7PR12MB6935:EE_
X-MS-Office365-Filtering-Correlation-Id: bcd5b659-1533-406c-02aa-08de74e505ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	lvNn9DyyqoPOY5qVYctwHKcCYaVgwbzY3MzlvAEDlY0Mb3mDxt53QMIHMA4zvX684Iuf2K3wnouQp2XSmgb/1uwAKQvppLK8posqEVkyHLFrHCdQTykLvq398Y/hIaOFjmPHyXUHwYD1mMkKYv/0+PLTWq3TmCIAANUzsYvD/RQGfcI3VbrtMwRFQDRdnZtxElDVQP0Wn+DRi0fYCbC1qabSE7A6YITuItxwBb3Wy3Px3zIBw1sKx/HF2tAR1SFeEni5CAAYfmnBMIdpZrBTIYvBYMSTIT82U6rQhXuNgt/9tU9CptBSy9mNLuG2kV8LeLK7rMT/r1Y0wyGZf6GEE1tLAJsEvKWje7Y5LnuTlYHclL0u0DsSS4DX9ZnxY8+R4IiOyqb9JKpGEJ8kZRt8lHVo71UyAAaNJ/f7TzalsvQR1BcmIGSRn9FQ5zgVu7n4WMJCSB6Kza6cDOvGyTe1k34Fhpo681fhbwP/swHpu33HHVbTg6CSMtzm8/Wumzvyed/Y1Er3W14+FpZAhAZN5lkR6K/9w1QrRivHJB9CzdPObD2HFoV49SUJwK807bMNBduKo06Lp3dxL960l0of3tc/YSgxT3IRbqAPtUsM5osExvmt6bVvdQmGytqueq8n1Y2FlKxhnRMobxJ4X+yvYRM9Z5GdnUvsnyG+22uX6fZ8TGnoLZ+JYCEnYuU0Yaa7jZfZEZqc6W06JHBDYTy4kBmdlt0WTL4QaZgHYQmS5dhLGVrKTTflZiNrLZygIkcev6sH7aOZYqIlSyHSJM0aFVztNKaaKiN6e49TRKQ9zNaTvzOQFDogntkIBqoVyrrECr/BbAFp0nMtnWuwqjgEkQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	PgII2qmSCV3YX+vUjQN0xZYD+lZ0/Vhfkkj2JFts71r1pWFNFT6y2izZ8lHBBTaeEDAjxk8N88R/z3kGYiLMeda+mLKH7xZuPXUcJxKWxEkl7G6/yEhWm5OJmprlbttg7nULvkTPMvTQJAiExEALVtoxpYGhiWQRdwaPYUaYQ92CI/UDeh8Kiy8mO5K9wLeNfOwJ3VS0j0KEio7sCpFO4M9NaxYQjxbSy/jlSQSqYI+fIeEpok++FhySHNpFm/nJTqRCQXe/hQrrN9/UFSuxZrtZtAMLomy2oKutifbIfKVji+RDeNFufJKKSFzPwrEoPAWvRpwCAm0RhYJMh2AbQePE8YYWJo+I5DRIaWVhT6YT5+whHp1Y1+bM52IOUrmfNkRhdfOjq7VAVKOzAj1zDOpe+QML7t0OqBU+YamRwdGXjcQvWAUdmCgsMJMWKdwR
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 03:13:32.7523
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bcd5b659-1533-406c-02aa-08de74e505ee
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001708F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6935

When a bio goes through the rq_qos infrastructure on a path's request
queue, it gets BIO_QOS_THROTTLED or BIO_QOS_MERGED flags set. These
flags indicate that rq_qos_done_bio() should be called on completion
to update rq_qos accounting.

During path failover in nvme_failover_req(), the bio's bi_bdev is
redirected from the failed path's disk to the multipath head's disk
via bio_set_dev(). However, the BIO_QOS flags are not cleared.

When the bio eventually completes (either successfully via a new path
or with an error via bio_io_error()), rq_qos_done_bio() checks for
these flags and calls __rq_qos_done_bio(q->rq_qos, bio) where q is
obtained from the bio's current bi_bdev - which is now the multipath
head's queue, not the original path's queue.

The multipath head's queue does not have rq_qos enabled (q->rq_qos is
NULL), but the code assumes that if BIO_QOS_* flags are set, q->rq_qos
must be valid.

This breaks when a bio is moved between queues during NVMe multipath
failover, leading to a NULL pointer dereference.

Execution Context timeline :-

   * =====> dd process context
   [USER] dd process
     [SYSCALL] write() - dd process context
       submit_bio()
       nvme_ns_head_submit_bio() - path selection
       blk_mq_submit_bio()  #### QOS FLAGS SET HERE

        [USER] dd waits or returns

          ==== I/O in flight on NVMe hardware =====

   ===== End of submission path ====
   ------------------------------------------------------

   * dd ====> Interrupt context;
   [IRQ] NVMe completion interrupt
       nvme_irq()
        nvme_complete_rq()
         nvme_failover_req() ### BIO MOVED TO HEAD
            spin_lock_irqsave (atomic section)
            bio_set_dev() changes bi_bdev
            ### BUG: QOS flags NOT cleared
            kblockd_schedule_work()

   * Interrupt context =====> kblockd workqueue
   [WQ] kblockd workqueue - kworker process
       nvme_requeue_work()
        submit_bio_noacct()
         nvme_ns_head_submit_bio()
          nvme_find_path() returns NULL
           bio_io_error()
            bio_endio()
             rq_qos_done_bio()  ### CRASH ###

   KERNEL PANIC / OOPS

Crash from blktests nvme/058 (rapid namespace remapping):

[ 1339.636033] BUG: kernel NULL pointer dereference, address: 0000000000000000
[ 1339.641025] nvme nvme4: rescanning namespaces.
[ 1339.642064] #PF: supervisor read access in kernel mode
[ 1339.642067] #PF: error_code(0x0000) - not-present page
[ 1339.642070] PGD 0 P4D 0
[ 1339.642073] Oops: Oops: 0000 [#1] SMP NOPTI
[ 1339.642078] CPU: 35 UID: 0 PID: 4579 Comm: kworker/35:2H
               Tainted: G   O     N  6.17.0-rc3nvme+ #5 PREEMPT(voluntary)
[ 1339.642084] Tainted: [O]=OOT_MODULE, [N]=TEST
[ 1339.673446] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
           BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
[ 1339.682359] Workqueue: kblockd nvme_requeue_work [nvme_core]
[ 1339.686613] RIP: 0010:__rq_qos_done_bio+0xd/0x40
[ 1339.690161] Code: 75 dd 5b 5d 41 5c c3 cc cc cc cc 66 90 90 90 90 90 90 90
                     90 90 90 90 90 90 90 90 90 90 0f 1f 44 00 00 55 48 89 f5
             53 48 89 fb <48> 8b 03 48 8b 40 30 48 85 c0 74 0b 48 89 ee
             48 89 df ff d0 0f 1f
[ 1339.703691] RSP: 0018:ffffc900066f3c90 EFLAGS: 00010202
[ 1339.706844] RAX: ffff888148b9ef00 RBX: 0000000000000000 RCX: 0000000000000000
[ 1339.711136] RDX: 00000000000001c0 RSI: ffff8882aaab8a80 RDI: 0000000000000000
[ 1339.715691] RBP: ffff8882aaab8a80 R08: 0000000000000000 R09: 0000000000000000
[ 1339.720472] R10: 0000000000000000 R11: fefefefefefefeff R12: ffff8882aa3b6010
[ 1339.724650] R13: 0000000000000000 R14: ffff8882338bcef0 R15: ffff8882aa3b6020
[ 1339.729029] FS:  0000000000000000(0000) GS:ffff88985c0cf000(0000) knlGS:0000000000000000
[ 1339.734525] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1339.738563] CR2: 0000000000000000 CR3: 0000000111045000 CR4: 0000000000350ef0
[ 1339.742750] DR0: ffffffff845ccbec DR1: ffffffff845ccbed DR2: ffffffff845ccbee
[ 1339.745630] DR3: ffffffff845ccbef DR6: 00000000ffff0ff0 DR7: 0000000000000600
[ 1339.748488] Call Trace:
[ 1339.749512]  <TASK>
[ 1339.750449]  bio_endio+0x71/0x2e0
[ 1339.751833]  nvme_ns_head_submit_bio+0x290/0x320 [nvme_core]
[ 1339.754073]  __submit_bio+0x222/0x5e0
[ 1339.755623]  ? rcu_is_watching+0xd/0x40
[ 1339.757201]  ? submit_bio_noacct_nocheck+0x131/0x370
[ 1339.759210]  submit_bio_noacct_nocheck+0x131/0x370
[ 1339.761189]  ? submit_bio_noacct+0x20/0x620
[ 1339.762849]  nvme_requeue_work+0x4b/0x60 [nvme_core]
[ 1339.764828]  process_one_work+0x20e/0x630
[ 1339.766528]  worker_thread+0x184/0x330
[ 1339.768129]  ? __pfx_worker_thread+0x10/0x10
[ 1339.769942]  kthread+0x10a/0x250
[ 1339.771263]  ? __pfx_kthread+0x10/0x10
[ 1339.772776]  ? __pfx_kthread+0x10/0x10
[ 1339.774381]  ret_from_fork+0x273/0x2e0
[ 1339.775948]  ? __pfx_kthread+0x10/0x10
[ 1339.777504]  ret_from_fork_asm+0x1a/0x30
[ 1339.779163]  </TASK>

Fix this by clearing both BIO_QOS_THROTTLED and BIO_QOS_MERGED flags
when bios are redirected to the multipath head in nvme_failover_req().
This is consistent with the existing code that clears REQ_POLLED and
REQ_NOWAIT flags when the bio changes queues.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 block/blk-mq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 419b5c768af2..fea1d46829d6 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3427,6 +3427,8 @@ void blk_steal_bios(struct bio_list *list, struct request *rq)
 		 * the flag to avoid spurious EAGAIN I/O failures.
 		 */
 		bio->bi_opf &= ~REQ_NOWAIT;
+		bio_clear_flag(bio, BIO_QOS_THROTTLED);
+		bio_clear_flag(bio, BIO_QOS_MERGED);
 	}
 
 	if (rq->bio) {
-- 
2.39.5

