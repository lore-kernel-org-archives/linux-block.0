Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C6EBC4361B
	for <linux-block@archiver.kernel.org>; Thu, 10 Dec 2020 06:05:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9E5223770
	for <linux-block@archiver.kernel.org>; Thu, 10 Dec 2020 06:05:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733033AbgLJGFQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Dec 2020 01:05:16 -0500
Received: from smtp.h3c.com ([60.191.123.50]:26874 "EHLO h3cspam02-ex.h3c.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732896AbgLJGFQ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Dec 2020 01:05:16 -0500
Received: from DAG2EX03-BASE.srv.huawei-3com.com ([10.8.0.66])
        by h3cspam02-ex.h3c.com with ESMTP id 0BA63XK7009246;
        Thu, 10 Dec 2020 14:03:33 +0800 (GMT-8)
        (envelope-from tian.xianting@h3c.com)
Received: from localhost.localdomain (10.99.212.201) by
 DAG2EX03-BASE.srv.huawei-3com.com (10.8.0.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 10 Dec 2020 14:03:35 +0800
From:   Xianting Tian <tian.xianting@h3c.com>
To:     <axboe@kernel.dk>
CC:     <ming.lei@redhat.com>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Xianting Tian <tian.xianting@h3c.com>
Subject: [PATCH] [v2] blk-mq-tag: make blk_mq_tag_busy() return void
Date:   Thu, 10 Dec 2020 13:53:07 +0800
Message-ID: <20201210055307.1024-1-tian.xianting@h3c.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.99.212.201]
X-ClientProxiedBy: BJSMTP01-EX.srv.huawei-3com.com (10.63.20.132) To
 DAG2EX03-BASE.srv.huawei-3com.com (10.8.0.66)
X-DNSRBL: 
X-MAIL: h3cspam02-ex.h3c.com 0BA63XK7009246
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

As no one cares about the return value of blk_mq_tag_busy() and
__blk_mq_tag_busy(), so make them return void.

Other change is to simplify blk_mq_tag_idle().

Signed-off-by: Xianting Tian <tian.xianting@h3c.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq-tag.c |  4 ++--
 block/blk-mq-tag.h | 16 ++++++----------
 2 files changed, 8 insertions(+), 12 deletions(-)

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
index 7d3e6b333..4b4ccd794 100644
--- a/block/blk-mq-tag.h
+++ b/block/blk-mq-tag.h
@@ -60,23 +60,19 @@ enum {
 	BLK_MQ_TAG_MAX		= BLK_MQ_NO_TAG - 1,
 };
 
-extern bool __blk_mq_tag_busy(struct blk_mq_hw_ctx *);
+extern void __blk_mq_tag_busy(struct blk_mq_hw_ctx *);
 extern void __blk_mq_tag_idle(struct blk_mq_hw_ctx *);
 
-static inline bool blk_mq_tag_busy(struct blk_mq_hw_ctx *hctx)
+static inline void blk_mq_tag_busy(struct blk_mq_hw_ctx *hctx)
 {
-	if (!(hctx->flags & BLK_MQ_F_TAG_QUEUE_SHARED))
-		return false;
-
-	return __blk_mq_tag_busy(hctx);
+	if (hctx->flags & BLK_MQ_F_TAG_QUEUE_SHARED)
+		__blk_mq_tag_busy(hctx);
 }
 
 static inline void blk_mq_tag_idle(struct blk_mq_hw_ctx *hctx)
 {
-	if (!(hctx->flags & BLK_MQ_F_TAG_QUEUE_SHARED))
-		return;
-
-	__blk_mq_tag_idle(hctx);
+	if (hctx->flags & BLK_MQ_F_TAG_QUEUE_SHARED)
+		__blk_mq_tag_idle(hctx);
 }
 
 static inline bool blk_mq_tag_is_reserved(struct blk_mq_tags *tags,
-- 
2.17.1

