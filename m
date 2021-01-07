Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAD99C433DB
	for <linux-block@archiver.kernel.org>; Thu,  7 Jan 2021 03:32:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A57B22D01
	for <linux-block@archiver.kernel.org>; Thu,  7 Jan 2021 03:32:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbhAGDci (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Jan 2021 22:32:38 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:10031 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726681AbhAGDci (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Jan 2021 22:32:38 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DBBb76zDlzj4bB;
        Thu,  7 Jan 2021 11:30:59 +0800 (CST)
Received: from huawei.com (10.29.88.127) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.498.0; Thu, 7 Jan 2021
 11:31:52 +0800
From:   Chao Leng <lengchao@huawei.com>
To:     <linux-nvme@lists.infradead.org>
CC:     <kbusch@kernel.org>, <axboe@fb.com>, <hch@lst.de>,
        <sagi@grimberg.me>, <linux-block@vger.kernel.org>,
        <axboe@kernel.dk>
Subject: [PATCH v2 3/6] nvme-fabrics: avoid repeated request completion for nvmf_fail_nonready_command
Date:   Thu, 7 Jan 2021 11:31:46 +0800
Message-ID: <20210107033149.15701-4-lengchao@huawei.com>
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

The request may be completed with NVME_SC_HOST_PATH_ERROR in
nvmf_fail_nonready_command. The state of request will be changed to
MQ_RQ_IN_FLIGHT before call nvme_complete_rq. If free the request
asynchronously such as in nvme_submit_user_cmd, in extreme scenario
the request will be repeated freed in tear down.
Nvmf_fail_nonready_command do not need calling blk_mq_start_request
before complete the request. Nvmf_fail_nonready_command should set
the state of request to MQ_RQ_COMPLETE before complete the request.

Signed-off-by: Chao Leng <lengchao@huawei.com>
---
 drivers/nvme/host/fabrics.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 72ac00173500..874e4320e214 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -553,9 +553,7 @@ blk_status_t nvmf_fail_nonready_command(struct nvme_ctrl *ctrl,
 	    !blk_noretry_request(rq) && !(rq->cmd_flags & REQ_NVME_MPATH))
 		return BLK_STS_RESOURCE;
 
-	nvme_req(rq)->status = NVME_SC_HOST_PATH_ERROR;
-	blk_mq_start_request(rq);
-	nvme_complete_rq(rq);
+	nvme_complete_failed_req(rq);
 	return BLK_STS_OK;
 }
 EXPORT_SYMBOL_GPL(nvmf_fail_nonready_command);
-- 
2.16.4

