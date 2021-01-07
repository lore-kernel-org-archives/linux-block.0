Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0476BC433E0
	for <linux-block@archiver.kernel.org>; Thu,  7 Jan 2021 03:32:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB4B922D01
	for <linux-block@archiver.kernel.org>; Thu,  7 Jan 2021 03:32:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbhAGDcw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Jan 2021 22:32:52 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:9963 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726641AbhAGDcw (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Jan 2021 22:32:52 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4DBBbM0ddHzj3T3;
        Thu,  7 Jan 2021 11:31:11 +0800 (CST)
Received: from huawei.com (10.29.88.127) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.498.0; Thu, 7 Jan 2021
 11:31:51 +0800
From:   Chao Leng <lengchao@huawei.com>
To:     <linux-nvme@lists.infradead.org>
CC:     <kbusch@kernel.org>, <axboe@fb.com>, <hch@lst.de>,
        <sagi@grimberg.me>, <linux-block@vger.kernel.org>,
        <axboe@kernel.dk>
Subject: [PATCH v2 2/6] nvme-core: introduce complete failed request
Date:   Thu, 7 Jan 2021 11:31:45 +0800
Message-ID: <20210107033149.15701-3-lengchao@huawei.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20210107033149.15701-1-lengchao@huawei.com>
References: <20210107033149.15701-1-lengchao@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.29.88.127]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When a request is queued failed, if the fail status is not
BLK_STS_RESOURCE, BLK_STS_DEV_RESOURCE, BLK_STS_ZONE_RESOURCE,
the request is need to complete with nvme_complete_rq in queue_rq.
So introduce nvme_try_complete_failed_req.
The request is needed to complete with NVME_SC_HOST_PATH_ERROR in
nvmf_fail_nonready_command and queue_rq.
So introduce nvme_complete_failed_req.
For details, see the subsequent patches.

Signed-off-by: Chao Leng <lengchao@huawei.com>
---
 drivers/nvme/host/nvme.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index bfcedfa4b057..fc4eefdfbb34 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -649,6 +649,27 @@ void nvme_put_ns_from_disk(struct nvme_ns_head *head, int idx);
 extern const struct attribute_group *nvme_ns_id_attr_groups[];
 extern const struct block_device_operations nvme_ns_head_ops;
 
+static inline void nvme_complete_failed_req(struct request *req)
+{
+	nvme_req(req)->status = NVME_SC_HOST_PATH_ERROR;
+	blk_mq_set_request_complete(req);
+	nvme_complete_rq(req);
+}
+
+static inline blk_status_t nvme_try_complete_failed_req(struct request *req,
+							blk_status_t ret)
+{
+	switch (ret) {
+	case BLK_STS_RESOURCE:
+	case BLK_STS_DEV_RESOURCE:
+	case BLK_STS_ZONE_RESOURCE:
+		return ret;
+	default:
+		nvme_complete_failed_req(req);
+		return BLK_STS_OK;
+	}
+}
+
 #ifdef CONFIG_NVME_MULTIPATH
 static inline bool nvme_ctrl_use_ana(struct nvme_ctrl *ctrl)
 {
-- 
2.16.4

