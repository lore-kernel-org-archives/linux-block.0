Return-Path: <SRS0=+tqK=RS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FC9FC43381
	for <linux-block@archiver.kernel.org>; Fri, 15 Mar 2019 03:00:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77F4621872
	for <linux-block@archiver.kernel.org>; Fri, 15 Mar 2019 03:00:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727310AbfCODA4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Mar 2019 23:00:56 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:46294 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727284AbfCODA4 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Mar 2019 23:00:56 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id A3101CDF5E68FB850B99;
        Fri, 15 Mar 2019 11:00:54 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.408.0; Fri, 15 Mar 2019
 11:00:52 +0800
From:   Yufen Yu <yuyufen@huawei.com>
To:     <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>
Subject: [PATCH] blk-mq: use blk_mq_sched_mark_restart_hctx to set RESTART
Date:   Fri, 15 Mar 2019 11:05:10 +0800
Message-ID: <20190315030510.36531-1-yuyufen@huawei.com>
X-Mailer: git-send-email 2.16.2.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Let blk_mq_mark_tag_wait() use the blk_mq_sched_mark_restart_hctx()
to set BLK_MQ_S_SCHED_RESTART.

Signed-off-by: Yufen Yu <yuyufen@huawei.com>
---
 block/blk-mq.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index a9c181603cbd..ea01c23b58a3 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1093,8 +1093,7 @@ static bool blk_mq_mark_tag_wait(struct blk_mq_hw_ctx *hctx,
 	bool ret;
 
 	if (!(hctx->flags & BLK_MQ_F_TAG_SHARED)) {
-		if (!test_bit(BLK_MQ_S_SCHED_RESTART, &hctx->state))
-			set_bit(BLK_MQ_S_SCHED_RESTART, &hctx->state);
+		blk_mq_sched_mark_restart_hctx(hctx);
 
 		/*
 		 * It's possible that a tag was freed in the window between the
-- 
2.16.2.dirty

