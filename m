Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DAF8C4361B
	for <linux-block@archiver.kernel.org>; Tue,  8 Dec 2020 09:58:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B878423A9A
	for <linux-block@archiver.kernel.org>; Tue,  8 Dec 2020 09:58:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727754AbgLHJ6P (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Dec 2020 04:58:15 -0500
Received: from smtp.h3c.com ([60.191.123.56]:59037 "EHLO h3cspam01-ex.h3c.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727132AbgLHJ6P (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 8 Dec 2020 04:58:15 -0500
X-Greylist: delayed 1244 seconds by postgrey-1.27 at vger.kernel.org; Tue, 08 Dec 2020 04:58:14 EST
Received: from h3cspam01-ex.h3c.com (localhost [127.0.0.2] (may be forged))
        by h3cspam01-ex.h3c.com with ESMTP id 0B87owop066652;
        Tue, 8 Dec 2020 15:50:58 +0800 (GMT-8)
        (envelope-from tian.xianting@h3c.com)
Received: from DAG2EX03-BASE.srv.huawei-3com.com ([10.8.0.66])
        by h3cspam01-ex.h3c.com with ESMTP id 0B87oVLF065626;
        Tue, 8 Dec 2020 15:50:31 +0800 (GMT-8)
        (envelope-from tian.xianting@h3c.com)
Received: from localhost.localdomain (10.99.212.201) by
 DAG2EX03-BASE.srv.huawei-3com.com (10.8.0.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 8 Dec 2020 15:50:34 +0800
From:   Xianting Tian <tian.xianting@h3c.com>
To:     <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Xianting Tian <tian.xianting@h3c.com>
Subject: [PATCH] blk-mq-tag: make blk_mq_tag_busy() return void
Date:   Tue, 8 Dec 2020 15:40:02 +0800
Message-ID: <20201208074002.31539-1-tian.xianting@h3c.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.99.212.201]
X-ClientProxiedBy: BJSMTP01-EX.srv.huawei-3com.com (10.63.20.132) To
 DAG2EX03-BASE.srv.huawei-3com.com (10.8.0.66)
X-DNSRBL: 
X-MAIL: h3cspam01-ex.h3c.com 0B87oVLF065626
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

As no one cares about the return value of blk_mq_tag_busy() and
__blk_mq_tag_busy(), so make them return void.

Signed-off-by: Xianting Tian <tian.xianting@h3c.com>
---
 block/blk-mq-tag.c | 4 ++--
 block/blk-mq-tag.h | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 9c92053e7..21ff7d156 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -21,7 +21,7 @@
  * to get tag when first time, the other shared-tag users could reserve
  * budget for it.
  */
-bool __blk_mq_tag_busy(struct blk_mq_hw_ctx *hctx)
+void __blk_mq_tag_busy(struct blk_mq_hw_ctx *hctx)
 {
 	if (blk_mq_is_sbitmap_shared(hctx->flags)) {
 		struct request_queue *q = hctx->queue;
@@ -36,7 +36,7 @@ bool __blk_mq_tag_busy(struct blk_mq_hw_ctx *hctx)
 			atomic_inc(&hctx->tags->active_queues);
 	}
 
-	return true;
+	return;
 }
 
 /*
diff --git a/block/blk-mq-tag.h b/block/blk-mq-tag.h
index 7d3e6b333..dd80e5a85 100644
--- a/block/blk-mq-tag.h
+++ b/block/blk-mq-tag.h
@@ -60,15 +60,15 @@ enum {
 	BLK_MQ_TAG_MAX		= BLK_MQ_NO_TAG - 1,
 };
 
-extern bool __blk_mq_tag_busy(struct blk_mq_hw_ctx *);
+extern void __blk_mq_tag_busy(struct blk_mq_hw_ctx *);
 extern void __blk_mq_tag_idle(struct blk_mq_hw_ctx *);
 
-static inline bool blk_mq_tag_busy(struct blk_mq_hw_ctx *hctx)
+static inline void blk_mq_tag_busy(struct blk_mq_hw_ctx *hctx)
 {
 	if (!(hctx->flags & BLK_MQ_F_TAG_QUEUE_SHARED))
-		return false;
+		return;
 
-	return __blk_mq_tag_busy(hctx);
+	__blk_mq_tag_busy(hctx);
 }
 
 static inline void blk_mq_tag_idle(struct blk_mq_hw_ctx *hctx)
-- 
2.17.1

