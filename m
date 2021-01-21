Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C1E4C433DB
	for <linux-block@archiver.kernel.org>; Thu, 21 Jan 2021 07:04:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34D5823977
	for <linux-block@archiver.kernel.org>; Thu, 21 Jan 2021 07:04:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbhAUHEd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Jan 2021 02:04:33 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:11118 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727207AbhAUHE3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Jan 2021 02:04:29 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DLtcj4dQwz15wQj;
        Thu, 21 Jan 2021 15:02:29 +0800 (CST)
Received: from huawei.com (10.29.88.127) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.498.0; Thu, 21 Jan 2021
 15:03:32 +0800
From:   Chao Leng <lengchao@huawei.com>
To:     <linux-nvme@lists.infradead.org>
CC:     <kbusch@kernel.org>, <axboe@fb.com>, <hch@lst.de>,
        <sagi@grimberg.me>, <linux-block@vger.kernel.org>,
        <axboe@kernel.dk>
Subject: [PATCH v3 2/5] nvme-core: introduce complete failed request
Date:   Thu, 21 Jan 2021 15:03:27 +0800
Message-ID: <20210121070330.19701-3-lengchao@huawei.com>
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
queue_rq call HBA drive to send request, queue_rq need complete the
request with NVME_SC_HOST_PATH_ERROR, the request will fail over to
retry if needed.
So introduce nvme_complete_failed_req for queue_rq and
nvmf_fail_nonready_command.

Signed-off-by: Chao Leng <lengchao@huawei.com>
---
 drivers/nvme/host/nvme.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 88a6b97247f5..01fb54ba3d1f 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -575,6 +575,14 @@ static inline bool nvme_is_aen_req(u16 qid, __u16 command_id)
 }
 
 void nvme_complete_rq(struct request *req);
+
+static inline void nvme_complete_failed_req(struct request *req)
+{
+	nvme_req(req)->status = NVME_SC_HOST_PATH_ERROR;
+	blk_mq_set_request_complete(req);
+	nvme_complete_rq(req);
+}
+
 bool nvme_cancel_request(struct request *req, void *data, bool reserved);
 bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 		enum nvme_ctrl_state new_state);
-- 
2.16.4

