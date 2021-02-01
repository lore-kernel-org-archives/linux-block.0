Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AFE1C433DB
	for <linux-block@archiver.kernel.org>; Mon,  1 Feb 2021 03:50:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5A2B60231
	for <linux-block@archiver.kernel.org>; Mon,  1 Feb 2021 03:50:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbhBADu1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 31 Jan 2021 22:50:27 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:11661 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231336AbhBADu0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 31 Jan 2021 22:50:26 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DTYnN10p5zlDX2;
        Mon,  1 Feb 2021 11:48:08 +0800 (CST)
Received: from huawei.com (10.29.88.127) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.498.0; Mon, 1 Feb 2021
 11:49:43 +0800
From:   Chao Leng <lengchao@huawei.com>
To:     <linux-nvme@lists.infradead.org>
CC:     <kbusch@kernel.org>, <axboe@fb.com>, <hch@lst.de>,
        <sagi@grimberg.me>, <linux-block@vger.kernel.org>,
        <axboe@kernel.dk>
Subject: [PATCH v5 3/3] nvme-rdma: avoid IO error for nvme native multipath
Date:   Mon, 1 Feb 2021 11:49:40 +0800
Message-ID: <20210201034940.18891-4-lengchao@huawei.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20210201034940.18891-1-lengchao@huawei.com>
References: <20210201034940.18891-1-lengchao@huawei.com>
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
queue_rq need complete the request with NVME_SC_HOST_PATH_ERROR and set
the state of request to MQ_RQ_COMPLETE, the request will fail over to
retry if needed.

Signed-off-by: Chao Leng <lengchao@huawei.com>
---
 drivers/nvme/host/rdma.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index b7ce4f221d99..5fc113dd3302 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -2084,8 +2084,19 @@ static blk_status_t nvme_rdma_queue_rq(struct blk_mq_hw_ctx *hctx,
 
 	err = nvme_rdma_post_send(queue, sqe, req->sge, req->num_sge,
 			req->mr ? &req->reg_wr.wr : NULL);
-	if (unlikely(err))
+	if (unlikely(err)) {
+		if (err == -EIO) {
+			/*
+			 * Fail the reqest so upper layer can failover I/O
+			 * if another path is available
+			 */
+			req->status = NVME_SC_HOST_PATH_ERROR;
+			blk_mq_set_request_complete(rq);
+			nvme_rdma_complete_rq(rq);
+			return BLK_STS_OK;
+		}
 		goto err_unmap;
+	}
 
 	return BLK_STS_OK;
 
-- 
2.16.4

