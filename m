Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f52.google.com ([74.125.83.52]:36542 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754209AbdDDQvK (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Apr 2017 12:51:10 -0400
Received: by mail-pg0-f52.google.com with SMTP id g2so155821894pge.3
        for <linux-block@vger.kernel.org>; Tue, 04 Apr 2017 09:51:10 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Cc: kernel-team@fb.com
Subject: [PATCH v2 4/5] blk-mq: export blk_mq_finish_request()
Date: Tue,  4 Apr 2017 09:49:57 -0700
Message-Id: <7b169ea3fc51fff8d9244eb2e3cdbfb168c7fb41.1491324365.git.osandov@fb.com>
In-Reply-To: <cover.1491324365.git.osandov@fb.com>
References: <cover.1491324365.git.osandov@fb.com>
In-Reply-To: <cover.1491324365.git.osandov@fb.com>
References: <cover.1491324365.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

This is required for schedulers that define their own put_request().

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 block/blk-mq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 3dbfed6d0e5b..e75fa7a1a653 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -368,6 +368,7 @@ void blk_mq_finish_request(struct request *rq)
 {
 	blk_mq_finish_hctx_request(blk_mq_map_queue(rq->q, rq->mq_ctx->cpu), rq);
 }
+EXPORT_SYMBOL_GPL(blk_mq_finish_request);
 
 void blk_mq_free_request(struct request *rq)
 {
-- 
2.12.2
