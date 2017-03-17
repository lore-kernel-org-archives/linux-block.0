Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f175.google.com ([209.85.192.175]:36565 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751222AbdCQWLB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Mar 2017 18:11:01 -0400
Received: by mail-pf0-f175.google.com with SMTP id o126so42925422pfb.3
        for <linux-block@vger.kernel.org>; Fri, 17 Mar 2017 15:11:01 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: linux-block@vger.kernel.org
Cc: kernel-team@fb.com
Subject: [RFC PATCH 3/4] blk-mq: export blk_mq_finish_request()
Date: Fri, 17 Mar 2017 15:03:32 -0700
Message-Id: <f46a7712d31b003bb52951c10856f2afd063bef2.1489787289.git.osandov@fb.com>
In-Reply-To: <cover.1489787289.git.osandov@fb.com>
References: <cover.1489787289.git.osandov@fb.com>
In-Reply-To: <cover.1489787289.git.osandov@fb.com>
References: <cover.1489787289.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

This is required for schedulers that define their own put_request().

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 block/blk-mq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 559f9b0f24a1..94973103e809 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -370,6 +370,7 @@ void blk_mq_finish_request(struct request *rq)
 {
 	blk_mq_finish_hctx_request(blk_mq_map_queue(rq->q, rq->mq_ctx->cpu), rq);
 }
+EXPORT_SYMBOL_GPL(blk_mq_finish_request);
 
 void blk_mq_free_request(struct request *rq)
 {
-- 
2.12.0
