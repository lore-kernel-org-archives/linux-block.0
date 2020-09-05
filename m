Return-Path: <SRS0=kuF4=CO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CAE5C43461
	for <linux-block@archiver.kernel.org>; Sat,  5 Sep 2020 09:43:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D97D120757
	for <linux-block@archiver.kernel.org>; Sat,  5 Sep 2020 09:43:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbgIEJnk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 5 Sep 2020 05:43:40 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:48638 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726372AbgIEJnj (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 5 Sep 2020 05:43:39 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 3408ADE10C63DD391FBC;
        Sat,  5 Sep 2020 17:43:37 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Sat, 5 Sep 2020
 17:43:26 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] block: Use helper function blk_mq_hctx_stopped() in blk_mq_run_work_fn()
Date:   Sat, 5 Sep 2020 05:42:14 -0400
Message-ID: <20200905094214.3582-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Use helper function blk_mq_hctx_stopped() to check if hardware queue
stopped in blk_mq_run_work_fn().

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 block/blk-mq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index b3d2785eefe9..d089825f9cd1 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1806,7 +1806,7 @@ static void blk_mq_run_work_fn(struct work_struct *work)
 	/*
 	 * If we are stopped, don't run the queue.
 	 */
-	if (test_bit(BLK_MQ_S_STOPPED, &hctx->state))
+	if (blk_mq_hctx_stopped(hctx))
 		return;
 
 	__blk_mq_run_hw_queue(hctx);
-- 
2.19.1

