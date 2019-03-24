Return-Path: <SRS0=54qS=R3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F416C10F00
	for <linux-block@archiver.kernel.org>; Sun, 24 Mar 2019 09:52:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3201222C1
	for <linux-block@archiver.kernel.org>; Sun, 24 Mar 2019 09:52:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbfCXJw5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 24 Mar 2019 05:52:57 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:46310 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726788AbfCXJw4 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 24 Mar 2019 05:52:56 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id C72F666CCCF1045E528D;
        Sun, 24 Mar 2019 17:52:54 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.408.0; Sun, 24 Mar 2019
 17:52:50 +0800
From:   Yufen Yu <yuyufen@huawei.com>
To:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>
Subject: [PATCH 1/2] blk-mq: use blk_mq_put_driver_tag() to put tag
Date:   Sun, 24 Mar 2019 17:57:07 +0800
Message-ID: <20190324095708.77658-2-yuyufen@huawei.com>
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

Expect arguments, blk_mq_put_driver_tag_hctx() and blk_mq_put_driver_tag()
is same. We can just use argument 'request' to put tag by blk_mq_put_driver_tag().
Then we can remove the unused blk_mq_put_driver_tag_hctx().

Signed-off-by: Yufen Yu <yuyufen@huawei.com>
---
 block/blk-flush.c | 4 ++--
 block/blk-mq.h    | 9 ---------
 2 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/block/blk-flush.c b/block/blk-flush.c
index 6e0f2d97fc6d..d95f94892015 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -220,7 +220,7 @@ static void flush_end_io(struct request *flush_rq, blk_status_t error)
 		blk_mq_tag_set_rq(hctx, flush_rq->tag, fq->orig_rq);
 		flush_rq->tag = -1;
 	} else {
-		blk_mq_put_driver_tag_hctx(hctx, flush_rq);
+		blk_mq_put_driver_tag(flush_rq);
 		flush_rq->internal_tag = -1;
 	}
 
@@ -324,7 +324,7 @@ static void mq_flush_data_end_io(struct request *rq, blk_status_t error)
 
 	if (q->elevator) {
 		WARN_ON(rq->tag < 0);
-		blk_mq_put_driver_tag_hctx(hctx, rq);
+		blk_mq_put_driver_tag(rq);
 	}
 
 	/*
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 0ed8e5a8729f..d704fc7766f4 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -224,15 +224,6 @@ static inline void __blk_mq_put_driver_tag(struct blk_mq_hw_ctx *hctx,
 	}
 }
 
-static inline void blk_mq_put_driver_tag_hctx(struct blk_mq_hw_ctx *hctx,
-				       struct request *rq)
-{
-	if (rq->tag == -1 || rq->internal_tag == -1)
-		return;
-
-	__blk_mq_put_driver_tag(hctx, rq);
-}
-
 static inline void blk_mq_put_driver_tag(struct request *rq)
 {
 	if (rq->tag == -1 || rq->internal_tag == -1)
-- 
2.16.2.dirty

