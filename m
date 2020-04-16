Return-Path: <SRS0=Ef4g=6A=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C046C2BB55
	for <linux-block@archiver.kernel.org>; Thu, 16 Apr 2020 11:25:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4300A221F6
	for <linux-block@archiver.kernel.org>; Thu, 16 Apr 2020 11:25:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633075AbgDPLZI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Apr 2020 07:25:08 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:52226 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2633029AbgDPLXJ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Apr 2020 07:23:09 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id B4DE0BEC26C13D528FF6;
        Thu, 16 Apr 2020 19:22:58 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.487.0; Thu, 16 Apr 2020 19:22:47 +0800
From:   John Garry <john.garry@huawei.com>
To:     <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <ming.lei@redhat.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH] blk-mq: Put driver tag in blk_mq_dispatch_rq_list() when no budget
Date:   Thu, 16 Apr 2020 19:18:51 +0800
Message-ID: <1587035931-125028-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If in blk_mq_dispatch_rq_list() we find no budget, then we break of the
dispatch loop, but the request may keep the driver tag, evaulated
in 'nxt' in the previous loop iteration.

Fix by putting the driver tag for that request.

Signed-off-by: John Garry <john.garry@huawei.com>

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 8e56884fd2e9..a7785df2c944 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1222,8 +1222,10 @@ bool blk_mq_dispatch_rq_list(struct request_queue *q, struct list_head *list,
 		rq = list_first_entry(list, struct request, queuelist);
 
 		hctx = rq->mq_hctx;
-		if (!got_budget && !blk_mq_get_dispatch_budget(hctx))
+		if (!got_budget && !blk_mq_get_dispatch_budget(hctx)) {
+			blk_mq_put_driver_tag(rq);
 			break;
+		}
 
 		if (!blk_mq_get_driver_tag(rq)) {
 			/*
-- 
2.16.4

