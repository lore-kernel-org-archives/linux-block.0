Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06899C433E6
	for <linux-block@archiver.kernel.org>; Thu, 21 Jan 2021 07:05:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9ED3D2396D
	for <linux-block@archiver.kernel.org>; Thu, 21 Jan 2021 07:05:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbhAUHFV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Jan 2021 02:05:21 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:11117 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727226AbhAUHE3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Jan 2021 02:04:29 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DLtcj4MwDz15wF0;
        Thu, 21 Jan 2021 15:02:29 +0800 (CST)
Received: from huawei.com (10.29.88.127) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.498.0; Thu, 21 Jan 2021
 15:03:33 +0800
From:   Chao Leng <lengchao@huawei.com>
To:     <linux-nvme@lists.infradead.org>
CC:     <kbusch@kernel.org>, <axboe@fb.com>, <hch@lst.de>,
        <sagi@grimberg.me>, <linux-block@vger.kernel.org>,
        <axboe@kernel.dk>
Subject: [PATCH v3 4/5] nvme-rdma: avoid IO error for nvme native multipath
Date:   Thu, 21 Jan 2021 15:03:29 +0800
Message-ID: <20210121070330.19701-5-lengchao@huawei.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20210121070330.19701-1-lengchao@huawei.com>
References: <20210121070330.19701-1-lengchao@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.29.88.127]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Work with nvme native multipath, if a path related error occurs when
queue_rq call HBA drive to send request, queue_rq will return
BLK_STS_IOERR to blk-mq. The request is completed with BLK_STS_IOERR
instead of fail over to retry.
queue_rq need call nvme_complete_rq to complete the request with
NVME_SC_HOST_PATH_ERROR, the request will fail over to retry if needed.

Signed-off-by: Chao Leng <lengchao@huawei.com>
---
 drivers/nvme/host/rdma.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index cf6c49d09c82..5fb0838a5f8b 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -2030,6 +2030,7 @@ static blk_status_t nvme_rdma_queue_rq(struct blk_mq_hw_ctx *hctx,
 	bool queue_ready = test_bit(NVME_RDMA_Q_LIVE, &queue->flags);
 	blk_status_t ret;
 	int err;
+	bool driver_error = false;
 
 	WARN_ON_ONCE(rq->tag < 0);
 
@@ -2077,8 +2078,10 @@ static blk_status_t nvme_rdma_queue_rq(struct blk_mq_hw_ctx *hctx,
 
 	err = nvme_rdma_post_send(queue, sqe, req->sge, req->num_sge,
 			req->mr ? &req->reg_wr.wr : NULL);
-	if (unlikely(err))
+	if (unlikely(err)) {
+		driver_error = true;
 		goto err_unmap;
+	}
 
 	return BLK_STS_OK;
 
@@ -2093,6 +2096,10 @@ static blk_status_t nvme_rdma_queue_rq(struct blk_mq_hw_ctx *hctx,
 unmap_qe:
 	ib_dma_unmap_single(dev, req->sqe.dma, sizeof(struct nvme_command),
 			    DMA_TO_DEVICE);
+	if (driver_error && ret == BLK_STS_IOERR) {
+		nvme_complete_failed_req(rq);
+		ret = BLK_STS_OK;
+	}
 	return ret;
 }
 
-- 
2.16.4

