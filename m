Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EF73C433EF
	for <linux-block@archiver.kernel.org>; Fri, 10 Sep 2021 08:47:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32FE860C51
	for <linux-block@archiver.kernel.org>; Fri, 10 Sep 2021 08:47:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbhIJIs2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 10 Sep 2021 04:48:28 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:16185 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231502AbhIJIs1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 10 Sep 2021 04:48:27 -0400
Received: from dggeme760-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4H5TxT0Sclz1DGvZ;
        Fri, 10 Sep 2021 16:46:21 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggeme760-chm.china.huawei.com
 (10.3.19.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.8; Fri, 10
 Sep 2021 16:47:14 +0800
From:   Lihong Kou <koulihong@huawei.com>
To:     <axboe@kernel.dk>, <kbusch@kernel.org>, <hch@lst.de>,
        <sagi@grimberg.me>
CC:     <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>
Subject: [PATCH] block: nvme: fix the NULL ptr bug in bio_integrity_verify_fn
Date:   Fri, 10 Sep 2021 16:54:12 +0800
Message-ID: <20210910085412.747800-1-koulihong@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggeme760-chm.china.huawei.com (10.3.19.106)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We encouter a null ptr problem in our system with the block integrity
feature enabled. The call trace is:
[  221.903927] ==================================================================
[  221.904648] BUG: KASAN: null-ptr-deref in bio_integrity_verify_fn+0xbd/0xe3
[  221.905160] Read of size 8 at addr 0000000000000008 by task kworker/1:1H/135
[  221.905683]
[  221.905797] CPU: 1 PID: 135 Comm: kworker/1:1H Not tainted 5.14.0-02729-gb91db6a0b52e-dirty #8
[  221.906407] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS ?-20190727_073836-buildvm-ppc64le-16.ppc.fedoraproject.org-3.fc31 04/01/2014
[  221.907339] Workqueue: kintegrityd bio_integrity_verify_fn
[  221.907749] Call Trace:
[  221.907936]  dump_stack_lvl+0x34/0x44
[  221.908222]  kasan_report.cold+0x66/0xdf
[  221.908511]  ? bio_integrity_verify_fn+0xbd/0xe3
[  221.908865]  bio_integrity_verify_fn+0xbd/0xe3
[  221.909205]  process_one_work+0x39f/0x690
[  221.909515]  worker_thread+0x78/0x600
[  221.909779]  ? process_one_work+0x690/0x690
[  221.910085]  kthread+0x1cf/0x200
[  221.910325]  ? set_kthread_struct+0x80/0x80
[  221.910635]  ret_from_fork+0x1f/0x30
[  221.910902] ==================================================================
[  221.911426] Disabling lock debugging due to kernel taint
[  221.911819] BUG: kernel NULL pointer dereference, address: 0000000000000008
[  221.912323] #PF: supervisor read access in kernel mode
[  221.912690] #PF: error_code(0x0000) - not-present page
[  221.913064] PGD 0 P4D 0
[  221.913263] Oops: 0000 [#1] SMP KASAN
[  221.913532] CPU: 1 PID: 135 Comm: kworker/1:1H Tainted: G    B             5.14.0-02729-gb91db6a0b52e-dirty #8
[  221.914242] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS ?-20190727_073836-buildvm-ppc64le-16.ppc.fedoraproject.org-3.fc31 04/01/2014
[  221.915222] Workqueue: kintegrityd bio_integrity_verify_fn
[  221.915636] RIP: 0010:bio_integrity_verify_fn+0xbd/0xe3
[  221.916024] Code: 2e ff 48 83 7d 00 00 75 0c 48 c7 c7 c0 b9 8b 8f e8 3f ea fd ff 48 89 ef e8 6a fc 2e ff 48 8b 6d 00 48 8d 7d 08 e8 5d fc 2e ff <48> 8b 55 08 48 8d 73 e8 4c 89 e7 e8 bd 10 8c ff 4c 89d
[  221.917402] RSP: 0018:ffff8881068ffde8 EFLAGS: 00010286
[  221.917807] RAX: 0000000000000001 RBX: ffff888102d0eb40 RCX: ffffffff8f1bbe22
[  221.918349] RDX: 1ffffffff3431d80 RSI: 0000000000000246 RDI: ffffffff9a18ec00
[  221.918872] RBP: 0000000000000000 R08: 0000000000000001 R09: fffffbfff3011121
[  221.919461] R10: ffffffff98088907 R11: fffffbfff3011120 R12: ffff8881171e7740
[  221.920132] R13: 0000000000000000 R14: ffff8883d3073000 R15: 0000000000000040
[  221.920817] FS:  0000000000000000(0000) GS:ffff8883d3040000(0000) knlGS:0000000000000000
[  221.921601] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  221.922093] CR2: 0000000000000008 CR3: 0000000118df5000 CR4: 00000000000006e0
[  221.922750] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  221.923431] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  221.924087] Call Trace:
[  221.924317]  process_one_work+0x39f/0x690
[  221.924710]  worker_thread+0x78/0x600
[  221.925047]  ? process_one_work+0x690/0x690
[  221.925459]  kthread+0x1cf/0x200
[  221.925732]  ? set_kthread_struct+0x80/0x80
[  221.926148]  ret_from_fork+0x1f/0x30
[  221.926514] Modules linked in:
[  221.926796] CR2: 0000000000000008
[  221.927225] ---[ end trace 35c0b7896d001c06 ]---
[  221.927688] RIP: 0010:bio_integrity_verify_fn+0xbd/0xe3
[  221.928289] Code: 2e ff 48 83 7d 00 00 75 0c 48 c7 c7 c0 b9 8b 8f e8 3f ea fd ff 48 89 ef e8 6a fc 2e ff 48 8b 6d 00 48 8d 7d 08 e8 5d fc 2e ff <48> 8b 55 08 48 8d 73 e8 4c 89 e7 e8 bd 10 8c ff 4c 89d
[  221.930413] RSP: 0018:ffff8881068ffde8 EFLAGS: 00010286
[  221.930948] RAX: 0000000000000001 RBX: ffff888102d0eb40 RCX: ffffffff8f1bbe22
[  221.931628] RDX: 1ffffffff3431d80 RSI: 0000000000000246 RDI: ffffffff9a18ec00
[  221.932195] RBP: 0000000000000000 R08: 0000000000000001 R09: fffffbfff3011121
[  221.932739] R10: ffffffff98088907 R11: fffffbfff3011120 R12: ffff8881171e7740
[  221.933277] R13: 0000000000000000 R14: ffff8883d3073000 R15: 0000000000000040
[  221.933819] FS:  0000000000000000(0000) GS:ffff8883d3040000(0000) knlGS:0000000000000000
[  221.934430] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  221.934850] CR2: 0000000000000008 CR3: 0000000118df5000 CR4: 00000000000006e0
[  221.935391] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  221.935934] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400

Because the  bio verify work is done in the worker thread, someone can
unregister the bio intergity concurrently as below:

CPU0                                    CPU1
  process_one_work                      nvme_validate_ns
    bio_integrity_verify_fn                nvme_update_ns_info
	                                     nvme_update_disk_info
	                                       blk_integrity_unregister
                                               ---set queue->integrity as 0
	bio_integrity_process
	--access bi->profile->veryfy_fn(bi is a pointer of queue->integity)

Before calling blk_integrity_unregister in nvme_update_disk_info, we must
make sure that there is no work item in the kintegrityd_wq. Just call
blk_flush_integrity to flush the work queue so the bug can be resolved.

Signed-off-by: Lihong Kou <koulihong@huawei.com>
---
 block/bio-integrity.c    |  1 +
 block/blk.h              |  4 ----
 drivers/nvme/host/core.c | 10 +++++++++-
 drivers/nvme/host/nvme.h |  5 +++++
 include/linux/blkdev.h   |  4 ++++
 5 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index 6b47cddbbca1..25477ac2b5f3 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -21,6 +21,7 @@ void blk_flush_integrity(void)
 {
 	flush_workqueue(kintegrityd_wq);
 }
+EXPORT_SYMBOL(blk_flush_integrity);
 
 static void __bio_integrity_free(struct bio_set *bs,
 				 struct bio_integrity_payload *bip)
diff --git a/block/blk.h b/block/blk.h
index 8c96b0c90c48..69b9fe26105c 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -93,7 +93,6 @@ static inline bool bvec_gap_to_prev(struct request_queue *q,
 }
 
 #ifdef CONFIG_BLK_DEV_INTEGRITY
-void blk_flush_integrity(void);
 bool __bio_integrity_endio(struct bio *);
 void bio_integrity_free(struct bio *bio);
 static inline bool bio_integrity_endio(struct bio *bio)
@@ -152,9 +151,6 @@ static inline bool integrity_req_gap_front_merge(struct request *req,
 	return false;
 }
 
-static inline void blk_flush_integrity(void)
-{
-}
 static inline bool bio_integrity_endio(struct bio *bio)
 {
 	return true;
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 8679a108f571..74a70747c305 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1742,6 +1742,14 @@ static void nvme_set_queue_limits(struct nvme_ctrl *ctrl,
 	blk_queue_write_cache(q, vwc, vwc);
 }
 
+static void nvme_integrity_cleanup(struct gendisk *disk)
+{
+	if (nvme_integrity_registered(disk)) {
+		blk_flush_integrity();
+		blk_integrity_unregister(disk);
+	}
+}
+
 static void nvme_update_disk_info(struct gendisk *disk,
 		struct nvme_ns *ns, struct nvme_id_ns *id)
 {
@@ -1758,7 +1766,7 @@ static void nvme_update_disk_info(struct gendisk *disk,
 		bs = (1 << 9);
 	}
 
-	blk_integrity_unregister(disk);
+	nvme_integrity_cleanup(disk);
 
 	atomic_bs = phys_bs = bs;
 	nvme_setup_streams_ns(ns->ctrl, ns, &phys_bs, &io_opt);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index a2e1f298b217..694e4a3b98cf 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -880,6 +880,11 @@ static inline bool nvme_ctrl_sgl_supported(struct nvme_ctrl *ctrl)
 	return ctrl->sgls & ((1 << 0) | (1 << 1));
 }
 
+static inline bool nvme_integrity_registered(struct gendisk *disk)
+{
+	return !!blk_get_integrity(disk);
+}
+
 u32 nvme_command_effects(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 			 u8 opcode);
 int nvme_execute_passthru_rq(struct request *rq);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 12b9dbcc980e..24b43545b556 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1658,6 +1658,7 @@ struct blk_integrity_profile {
 	const char			*name;
 };
 
+extern void blk_flush_integrity(void);
 extern void blk_integrity_register(struct gendisk *, struct blk_integrity *);
 extern void blk_integrity_unregister(struct gendisk *);
 extern int blk_integrity_compare(struct gendisk *, struct gendisk *);
@@ -1776,6 +1777,9 @@ static inline int blk_integrity_compare(struct gendisk *a, struct gendisk *b)
 {
 	return 0;
 }
+static inline void blk_flush_integrity(void)
+{
+}
 static inline void blk_integrity_register(struct gendisk *d,
 					 struct blk_integrity *b)
 {
-- 
2.25.4

