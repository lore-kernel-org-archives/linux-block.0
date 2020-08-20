Return-Path: <SRS0=Z7Y6=B6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7646AC433E1
	for <linux-block@archiver.kernel.org>; Thu, 20 Aug 2020 03:54:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50F592078B
	for <linux-block@archiver.kernel.org>; Thu, 20 Aug 2020 03:54:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbgHTDyT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Aug 2020 23:54:19 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:9857 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726435AbgHTDyT (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Aug 2020 23:54:19 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id CE7F2C1F96EF9441C564;
        Thu, 20 Aug 2020 11:54:16 +0800 (CST)
Received: from huawei.com (10.29.88.127) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.487.0; Thu, 20 Aug 2020
 11:54:06 +0800
From:   Chao Leng <lengchao@huawei.com>
To:     <linux-nvme@lists.infradead.org>
CC:     <linux-block@vger.kernel.org>, <kbusch@kernel.org>, <axboe@fb.com>,
        <hch@lst.de>, <sagi@grimberg.me>, <lengchao@huawei.com>
Subject: [PATCH 2/3] nvme-core: fix deadlock when reconnect failed due to nvme_set_queue_count timeout
Date:   Thu, 20 Aug 2020 11:54:06 +0800
Message-ID: <20200820035406.1720-1-lengchao@huawei.com>
X-Mailer: git-send-email 2.16.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.29.88.127]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

A deadlock happens When we test nvme over roce with link blink. The
reason: link blink will cause error recovery, and then reconnect.If
reconnect fail due to nvme_set_queue_count timeout, the reconnect
process will set the queue count as 0 and continue , and then
nvme_start_ctrl will call nvme_enable_aen, and deadlock happens
because the admin queue is quiesced.

log:
Aug  3 22:47:24 localhost kernel: nvme nvme2: I/O 22 QID 0 timeout
Aug  3 22:47:24 localhost kernel: nvme nvme2: Could not set queue count
(881)
stack:
root     23848  0.0  0.0      0     0 ?        D    Aug03   0:00
[kworker/u12:4+nvme-wq]
[<0>] blk_execute_rq+0x69/0xa0
[<0>] __nvme_submit_sync_cmd+0xaf/0x1b0 [nvme_core]
[<0>] nvme_features+0x73/0xb0 [nvme_core]
[<0>] nvme_start_ctrl+0xa4/0x100 [nvme_core]
[<0>] nvme_rdma_setup_ctrl+0x438/0x700 [nvme_rdma]
[<0>] nvme_rdma_reconnect_ctrl_work+0x22/0x30 [nvme_rdma]
[<0>] process_one_work+0x1a7/0x370
[<0>] worker_thread+0x30/0x380
[<0>] kthread+0x112/0x130
[<0>] ret_from_fork+0x35/0x40

Many functions which call __nvme_submit_sync_cmd treat error code in two
modes: If error code less than 0, treat as command failed. If erroe code
more than 0, treat as target not support or other and continue.
NVME_SC_HOST_ABORTED_CMD and NVME_SC_HOST_PATH_ERROR both are cancled io
by host, is not the real error code return from target. So we need set
the flag:NVME_REQ_CANCELLED. Thus __nvme_submit_sync_cmd translate
the error to INTR, nvme_set_queue_count will return error, reconnect
process will terminate instead of continue.

Signed-off-by: Chao Leng <lengchao@huawei.com>
---
 drivers/nvme/host/core.c    | 1 +
 drivers/nvme/host/fabrics.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 43ac8a1ad65d..74f76aa78b02 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -307,6 +307,7 @@ bool nvme_cancel_request(struct request *req, void *data, bool reserved)
 	if (blk_mq_request_completed(req))
 		return true;
 
+	nvme_req(req)->flags |= NVME_REQ_CANCELLED;
 	nvme_req(req)->status = NVME_SC_HOST_ABORTED_CMD;
 	blk_mq_complete_request(req);
 	return true;
diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 4ec4829d6233..6c40054f9fb4 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -552,6 +552,7 @@ blk_status_t nvmf_fail_nonready_command(struct nvme_ctrl *ctrl,
 	    !blk_noretry_request(rq) && !(rq->cmd_flags & REQ_NVME_MPATH))
 		return BLK_STS_RESOURCE;
 
+	nvme_req(rq)->flags |= NVME_REQ_CANCELLED;
 	nvme_req(rq)->status = NVME_SC_HOST_PATH_ERROR;
 	blk_mq_start_request(rq);
 	nvme_complete_rq(rq);
-- 
2.16.4

