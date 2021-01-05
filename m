Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C40AC433E9
	for <linux-block@archiver.kernel.org>; Tue,  5 Jan 2021 07:20:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6DED224F9
	for <linux-block@archiver.kernel.org>; Tue,  5 Jan 2021 07:20:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726052AbhAEHUd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 5 Jan 2021 02:20:33 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9671 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbhAEHUc (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 5 Jan 2021 02:20:32 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4D93l33yQRz15nk1;
        Tue,  5 Jan 2021 15:18:55 +0800 (CST)
Received: from huawei.com (10.29.88.127) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.498.0; Tue, 5 Jan 2021
 15:19:40 +0800
From:   Chao Leng <lengchao@huawei.com>
To:     <linux-nvme@lists.infradead.org>
CC:     <kbusch@kernel.org>, <axboe@fb.com>, <hch@lst.de>,
        <sagi@grimberg.me>, <lengchao@huawei.com>,
        <linux-block@vger.kernel.org>, <axboe@kernel.dk>
Subject: [PATCH 5/6] nvme-tcp: avoid IO error and repeated request completion
Date:   Tue, 5 Jan 2021 15:19:35 +0800
Message-ID: <20210105071936.25097-6-lengchao@huawei.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20210105071936.25097-1-lengchao@huawei.com>
References: <20210105071936.25097-1-lengchao@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.29.88.127]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When a request is queued failed, blk_status_t is directly returned
to the blk-mq. If blk_status_t is not BLK_STS_RESOURCE,
BLK_STS_DEV_RESOURCE, BLK_STS_ZONE_RESOURCE, blk-mq call
blk_mq_end_request to complete the request with BLK_STS_IOERR.
In two scenarios, the request should be retried and may succeed.
First, if work with nvme multipath, the request may be retried
successfully in another path, because the error is probably related to
the path. Second, if work without multipath software, the request may
be retried successfully after error recovery.
If the request is completed with BLK_STS_IOERR in blk_mq_dispatch_rq_list.
The state of request may be changed to MQ_RQ_IN_FLIGHT. If free the
request asynchronously such as in nvme_submit_user_cmd, in extreme
scenario the request will be repeated freed in tear down.
If a non-resource error occurs when queue_rq, should directly call
nvme_complete_rq to complete request and set the state of request to
MQ_RQ_COMPLETE. nvme_complete_rq will decide to retry, fail over or end
the request.

Signed-off-by: Chao Leng <lengchao@huawei.com>
---
 drivers/nvme/host/tcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 1ba659927442..a81683ce8cff 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2306,7 +2306,7 @@ static blk_status_t nvme_tcp_queue_rq(struct blk_mq_hw_ctx *hctx,
 
 	ret = nvme_tcp_setup_cmd_pdu(ns, rq);
 	if (unlikely(ret))
-		return ret;
+		return nvme_try_complete_failed_req(rq, ret);
 
 	blk_mq_start_request(rq);
 
-- 
2.16.4

