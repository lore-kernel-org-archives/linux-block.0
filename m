Return-Path: <SRS0=Z7Y6=B6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B192C433E1
	for <linux-block@archiver.kernel.org>; Thu, 20 Aug 2020 03:54:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E74692086A
	for <linux-block@archiver.kernel.org>; Thu, 20 Aug 2020 03:54:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbgHTDyX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Aug 2020 23:54:23 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:53980 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726435AbgHTDyX (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Aug 2020 23:54:23 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id EAC079F87963C244A384;
        Thu, 20 Aug 2020 11:54:21 +0800 (CST)
Received: from huawei.com (10.29.88.127) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.487.0; Thu, 20 Aug 2020
 11:54:14 +0800
From:   Chao Leng <lengchao@huawei.com>
To:     <linux-nvme@lists.infradead.org>
CC:     <linux-block@vger.kernel.org>, <kbusch@kernel.org>, <axboe@fb.com>,
        <hch@lst.de>, <sagi@grimberg.me>, <lengchao@huawei.com>
Subject: [PATCH 3/3] nvme-core: fix crash when nvme_enable_aen timeout
Date:   Thu, 20 Aug 2020 11:54:13 +0800
Message-ID: <20200820035413.1790-1-lengchao@huawei.com>
X-Mailer: git-send-email 2.16.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.29.88.127]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

A crash happens When we test nvme over roce with link blink. The
reason: nvme_enable_aen falsely start async_event_work when set
sync_event feature timeout, but async_event_sqe and qp of the queue
already be freeed when timeout. if async_event_work scheduling is
delayed for busy cpu, crash happens because use after free.

log:
[ 2229.253424] nvme nvme0: I/O 21 QID 0 timeout
[ 2229.253427] nvme nvme0: starting error recovery
[ 2229.354181] nvme nvme0: Failed to configure AEN (cfg 100)
[ 2229.354373] BUG: kernel NULL pointer dereference, address: 0000000000000000
[ 2229.354928] #PF: supervisor write access in kernel mode
[ 2229.357945] #PF: error_code(0x0002) - not-present page
[ 2229.361009] PGD 0 P4D 0
[ 2229.364052] Oops: 0002 [#1] SMP PTI
[ 2229.367132] CPU: 4 PID: 17561 Comm: kworker/u12:0 Kdump: loaded Tainted: G           OE     5.7.8 #1
[ 2229.369124] nvme nvme0: Reconnecting in 10 seconds...
[ 2229.370412] Hardware name: Huawei RH1288 V3/BC11HGSC0,
BIOS 5.03 07/25/2018
[ 2229.370421] Workqueue: nvme-wq nvme_async_event_work [nvme_core]
[ 2229.380029] RIP: 0010:nvme_rdma_submit_async_event+0x74/0x160
[nvme_rdma]
[ 2229.383408] Code: 48 85 c0 0f 84 e4 00 00 00 48 8b 40 50 48 85 c0 74
0f b9 01 00 00 00 ba 40 00 00 00 e8 25 d5 7a f9 48 8d 7b 08 48 89 d9 31
c0 <48> c7 03 00 00 00 00 48 83 e7 f8 48 c7 43 38 00 00 00 00 48 29 f9
[ 2229.391164] RSP: 0018:ffffa864c14fbe30 EFLAGS: 00010246
[ 2229.395215] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
[ 2229.399478] RDX: 0000000000000040 RSI: 000000024d89bc00 RDI: 0000000000000008
[ 2229.403785] RBP: ffff9267c76b82f8 R08: 0000000000000000 R09: 0071772d656d766e
[ 2229.408223] R10: 8080808080808080 R11: 0000000000000000 R12: ffff9267bf6ba800
[ 2229.412758] R13: ffff9267ae980000 R14: 0ffff9267d6ba8a0 R15: ffff9267c76b8c20
[ 2229.417401] FS:  0000000000000000(0000) GS:ffff9267ffd00000(0000) knlGS:0000000000000000
[ 2229.422360] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 2229.427046] CR2: 0000000000000000 CR3: 0000000237188006 CR4: 00000000001606e0
[ 2229.431925] Call Trace:
[ 2229.436834]  ? __switch_to_asm+0x34/0x70
[ 2229.441867]  nvme_async_event_work+0x5d/0xc0 [nvme_core]
[ 2229.447057]  process_one_work+0x1a7/0x370
[ 2229.452314]  worker_thread+0x30/0x380
[ 2229.457634]  ? max_active_store+0x80/0x80
[ 2229.463033]  kthread+0x112/0x130
[ 2229.468482]  ? __kthread_parkme+0x70/0x70
[ 2229.474031]  ret_from_fork+0x35/0x40

nvme_enable_aen should not queue async_event_work when set aync_event
feature timeout. Based on the patch: set the flag:NVME_REQ_CANCELLED
for NVME_SC_HOST_ABORTED_CMD and NVME_SC_HOST_PATH_ERROR, check ruturn
value, if less than 0, do not queue async_event_work and return error.

Signed-off-by: Chao Leng <lengchao@huawei.com>
---
 drivers/nvme/host/core.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 74f76aa78b02..f4c347fe925a 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1422,21 +1422,25 @@ EXPORT_SYMBOL_GPL(nvme_set_queue_count);
 	(NVME_AEN_CFG_NS_ATTR | NVME_AEN_CFG_FW_ACT | \
 	 NVME_AEN_CFG_ANA_CHANGE | NVME_AEN_CFG_DISC_CHANGE)
 
-static void nvme_enable_aen(struct nvme_ctrl *ctrl)
+static int nvme_enable_aen(struct nvme_ctrl *ctrl)
 {
 	u32 result, supported_aens = ctrl->oaes & NVME_AEN_SUPPORTED;
 	int status;
 
 	if (!supported_aens)
-		return;
+		return 0;
 
 	status = nvme_set_features(ctrl, NVME_FEAT_ASYNC_EVENT, supported_aens,
 			NULL, 0, &result);
-	if (status)
+	if (status) {
 		dev_warn(ctrl->device, "Failed to configure AEN (cfg %x)\n",
 			 supported_aens);
+		if (status < 0)
+			return status;
+	}
 
 	queue_work(nvme_wq, &ctrl->async_event_work);
+	return 0;
 }
 
 /*
@@ -4343,12 +4347,14 @@ void nvme_start_ctrl(struct nvme_ctrl *ctrl)
 {
 	nvme_start_keep_alive(ctrl);
 
-	nvme_enable_aen(ctrl);
+	if (nvme_enable_aen(ctrl))
+		goto out;
 
 	if (ctrl->queue_count > 1) {
 		nvme_queue_scan(ctrl);
 		nvme_start_queues(ctrl);
 	}
+out:
 	ctrl->created = true;
 }
 EXPORT_SYMBOL_GPL(nvme_start_ctrl);
-- 
2.16.4

