Return-Path: <SRS0=54qS=R3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47909C4360F
	for <linux-block@archiver.kernel.org>; Sun, 24 Mar 2019 09:52:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EB37222C1
	for <linux-block@archiver.kernel.org>; Sun, 24 Mar 2019 09:52:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbfCXJw5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 24 Mar 2019 05:52:57 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:46306 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726970AbfCXJw5 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 24 Mar 2019 05:52:57 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id C3A6C59172F6BDA2BDC8;
        Sun, 24 Mar 2019 17:52:54 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.408.0; Sun, 24 Mar 2019
 17:52:51 +0800
From:   Yufen Yu <yuyufen@huawei.com>
To:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>
Subject: [PATCH 2/2] blk-mq: update comment for blk_mq_hctx_has_pending()
Date:   Sun, 24 Mar 2019 17:57:08 +0800
Message-ID: <20190324095708.77658-3-yuyufen@huawei.com>
X-Mailer: git-send-email 2.16.2.dirty
In-Reply-To: <20190324095708.77658-1-yuyufen@huawei.com>
References: <20190324095708.77658-1-yuyufen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

For now, blk_mq_hctx_has_pending() checks any of ctx, hctx->dispatch
or io scheduler have pending work. So, update the comment accordingly.

Signed-off-by: Yufen Yu <yuyufen@huawei.com>
---
 block/blk-mq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 2ad06150ebff..e3f2c85f048c 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -59,7 +59,8 @@ static int blk_mq_poll_stats_bkt(const struct request *rq)
 }
 
 /*
- * Check if any of the ctx's have pending work in this hardware queue
+ * Check if any of the ctx, dispatch list or elevator
+ * have pending work in this hardware queue.
  */
 static bool blk_mq_hctx_has_pending(struct blk_mq_hw_ctx *hctx)
 {
-- 
2.16.2.dirty

