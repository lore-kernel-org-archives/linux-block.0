Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3EBAC433EF
	for <linux-block@archiver.kernel.org>; Sat, 11 Sep 2021 02:41:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A668661213
	for <linux-block@archiver.kernel.org>; Sat, 11 Sep 2021 02:41:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235061AbhIKCnB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 10 Sep 2021 22:43:01 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:15404 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231864AbhIKCnB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 10 Sep 2021 22:43:01 -0400
Received: from dggeme760-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4H5xjh6N9SzQvgZ;
        Sat, 11 Sep 2021 10:37:44 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggeme760-chm.china.huawei.com
 (10.3.19.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.8; Sat, 11
 Sep 2021 10:41:47 +0800
From:   Lihong Kou <koulihong@huawei.com>
To:     <axboe@kernel.dk>, <kbusch@kernel.org>, <hch@lst.de>,
        <sagi@grimberg.me>
CC:     <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>
Subject: [PATCH v2] block: nvme: fix the NULL ptr bug in bio_integrity_verify_fn
Date:   Sat, 11 Sep 2021 10:49:06 +0800
Message-ID: <20210911024906.1125259-1-koulihong@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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
 block/blk-core.c         | 3 ---
 block/blk-integrity.c    | 3 +++
 drivers/nvme/host/core.c | 3 ++-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 5454db2fa263..62a653e45054 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -389,9 +389,6 @@ void blk_cleanup_queue(struct request_queue *q)
 
 	blk_queue_flag_set(QUEUE_FLAG_DEAD, q);
 
-	/* for synchronous bio-based driver finish in-flight integrity i/o */
-	blk_flush_integrity();
-
 	blk_sync_queue(q);
 	if (queue_is_mq(q))
 		blk_mq_exit_queue(q);
diff --git a/block/blk-integrity.c b/block/blk-integrity.c
index 69a12177dfb6..94138a2184e3 100644
--- a/block/blk-integrity.c
+++ b/block/blk-integrity.c
@@ -426,6 +426,9 @@ EXPORT_SYMBOL(blk_integrity_register);
  */
 void blk_integrity_unregister(struct gendisk *disk)
 {
+	/* for synchronous bio-based driver finish in-flight integrity i/o */
+	blk_flush_integrity();
+
 	blk_queue_flag_clear(QUEUE_FLAG_STABLE_WRITES, disk->queue);
 	memset(&disk->queue->integrity, 0, sizeof(struct blk_integrity));
 }
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 8679a108f571..d937771e456a 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1758,7 +1758,8 @@ static void nvme_update_disk_info(struct gendisk *disk,
 		bs = (1 << 9);
 	}
 
-	blk_integrity_unregister(disk);
+	if (blk_get_integrity(disk))
+		blk_integrity_unregister(disk);
 
 	atomic_bs = phys_bs = bs;
 	nvme_setup_streams_ns(ns->ctrl, ns, &phys_bs, &io_opt);
-- 
2.25.4

