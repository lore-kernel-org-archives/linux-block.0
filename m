Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BFDCC4361B
	for <linux-block@archiver.kernel.org>; Tue, 15 Dec 2020 15:07:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25C5E22525
	for <linux-block@archiver.kernel.org>; Tue, 15 Dec 2020 15:07:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729626AbgLOOpS convert rfc822-to-8bit (ORCPT
        <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Dec 2020 09:45:18 -0500
Received: from smtp.h3c.com ([60.191.123.50]:41624 "EHLO h3cspam02-ex.h3c.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729601AbgLOOpL (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Dec 2020 09:45:11 -0500
Received: from DAG2EX05-BASE.srv.huawei-3com.com ([10.8.0.68])
        by h3cspam02-ex.h3c.com with ESMTP id 0BFEhEgx026750;
        Tue, 15 Dec 2020 22:43:14 +0800 (GMT-8)
        (envelope-from tian.xianting@h3c.com)
Received: from DAG2EX03-BASE.srv.huawei-3com.com (10.8.0.66) by
 DAG2EX05-BASE.srv.huawei-3com.com (10.8.0.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 15 Dec 2020 22:43:18 +0800
Received: from DAG2EX03-BASE.srv.huawei-3com.com ([fe80::5d18:e01c:bbbd:c074])
 by DAG2EX03-BASE.srv.huawei-3com.com ([fe80::5d18:e01c:bbbd:c074%7]) with
 mapi id 15.01.2106.002; Tue, 15 Dec 2020 22:43:18 +0800
From:   Tianxianting <tian.xianting@h3c.com>
To:     "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] [v3] blk-mq-tag: make blk_mq_tag_busy() return void
Thread-Topic: [PATCH] [v3] blk-mq-tag: make blk_mq_tag_busy() return void
Thread-Index: AQHWzrvRRiMD+3GiNEGPjpoaRl2Mjqn4Q4aQ
Date:   Tue, 15 Dec 2020 14:43:18 +0000
Message-ID: <1f3ecd50bae1420ba9dbce013fec13b2@h3c.com>
References: <20201210060448.23435-1-tian.xianting@h3c.com>
In-Reply-To: <20201210060448.23435-1-tian.xianting@h3c.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.99.141.128]
x-sender-location: DAG2
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-DNSRBL: 
X-MAIL: h3cspam02-ex.h3c.com 0BFEhEgx026750
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi jens
Could I get your commits?  thanks

-----Original Message-----
From: tianxianting (RD) 
Sent: Thursday, December 10, 2020 2:05 PM
To: axboe@kernel.dk
Cc: ming.lei@redhat.com; linux-block@vger.kernel.org; linux-kernel@vger.kernel.org; tianxianting (RD) <tian.xianting@h3c.com>
Subject: [PATCH] [v3] blk-mq-tag: make blk_mq_tag_busy() return void

As no one cares about the return value of blk_mq_tag_busy() and __blk_mq_tag_busy(), so make them return void.

Other change is to simplify blk_mq_tag_idle().

Signed-off-by: Xianting Tian <tian.xianting@h3c.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq-tag.c |  4 +---
 block/blk-mq-tag.h | 16 ++++++----------
 2 files changed, 7 insertions(+), 13 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c index 9c92053e7..01c0bb1fb 100644
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
 		struct request_queue *q = hctx->queue; @@ -35,8 +35,6 @@ bool __blk_mq_tag_busy(struct blk_mq_hw_ctx *hctx)
 		    !test_and_set_bit(BLK_MQ_S_TAG_ACTIVE, &hctx->state))
 			atomic_inc(&hctx->tags->active_queues);
 	}
-
-	return true;
 }
 
 /*
diff --git a/block/blk-mq-tag.h b/block/blk-mq-tag.h index 7d3e6b333..4b4ccd794 100644
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
 
 static inline void blk_mq_tag_idle(struct blk_mq_hw_ctx *hctx)  {
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

