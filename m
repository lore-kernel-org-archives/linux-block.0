Return-Path: <SRS0=kuF4=CO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B093FC433E2
	for <linux-block@archiver.kernel.org>; Sat,  5 Sep 2020 09:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 776F120757
	for <linux-block@archiver.kernel.org>; Sat,  5 Sep 2020 09:44:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728297AbgIEJoI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 5 Sep 2020 05:44:08 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:49078 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726372AbgIEJoI (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 5 Sep 2020 05:44:08 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 72D8C7F3C0397521918D;
        Sat,  5 Sep 2020 17:44:06 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.487.0; Sat, 5 Sep 2020
 17:43:58 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] block: Use helper function blk_mq_sched_needs_restart()
Date:   Sat, 5 Sep 2020 05:42:33 -0400
Message-ID: <20200905094233.3888-1-linmiaohe@huawei.com>
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

Use helper function blk_mq_sched_needs_restart() to check if hardware queue
needs restart.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 block/blk-mq-sched.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index d2790e5b06d1..dc837fd26e17 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -65,7 +65,7 @@ void blk_mq_sched_assign_ioc(struct request *rq)
  */
 void blk_mq_sched_mark_restart_hctx(struct blk_mq_hw_ctx *hctx)
 {
-	if (test_bit(BLK_MQ_S_SCHED_RESTART, &hctx->state))
+	if (blk_mq_sched_needs_restart(hctx))
 		return;
 
 	set_bit(BLK_MQ_S_SCHED_RESTART, &hctx->state);
@@ -74,7 +74,7 @@ EXPORT_SYMBOL_GPL(blk_mq_sched_mark_restart_hctx);
 
 void blk_mq_sched_restart(struct blk_mq_hw_ctx *hctx)
 {
-	if (!test_bit(BLK_MQ_S_SCHED_RESTART, &hctx->state))
+	if (!blk_mq_sched_needs_restart(hctx))
 		return;
 	clear_bit(BLK_MQ_S_SCHED_RESTART, &hctx->state);
 
-- 
2.19.1

