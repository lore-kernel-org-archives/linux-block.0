Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f41.google.com ([74.125.83.41]:34249 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751338AbdB0Rtu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Feb 2017 12:49:50 -0500
Received: by mail-pg0-f41.google.com with SMTP id p5so23387873pga.1
        for <linux-block@vger.kernel.org>; Mon, 27 Feb 2017 09:48:43 -0800 (PST)
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
        linux-block@vger.kernel.org
Cc: kernel-team@fb.com
Subject: [PATCH 2/3] blk-mq: kill blk_mq_set_alloc_data()
Date: Mon, 27 Feb 2017 09:47:54 -0800
Message-Id: <87aa35aa12f2edd4a9c56c382bf85ee580edf156.1488217516.git.osandov@fb.com>
In-Reply-To: <dcfe49f597dc1eec3b326024c86a6ad3afb82fa8.1488217516.git.osandov@fb.com>
References: <dcfe49f597dc1eec3b326024c86a6ad3afb82fa8.1488217516.git.osandov@fb.com>
In-Reply-To: <dcfe49f597dc1eec3b326024c86a6ad3afb82fa8.1488217516.git.osandov@fb.com>
References: <dcfe49f597dc1eec3b326024c86a6ad3afb82fa8.1488217516.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

Nothing is using it anymore.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 block/blk-mq.h | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/block/blk-mq.h b/block/blk-mq.h
index 24b2256186f3..088ced003c13 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -146,16 +146,6 @@ struct blk_mq_alloc_data {
 	struct blk_mq_hw_ctx *hctx;
 };
 
-static inline void blk_mq_set_alloc_data(struct blk_mq_alloc_data *data,
-		struct request_queue *q, unsigned int flags,
-		struct blk_mq_ctx *ctx, struct blk_mq_hw_ctx *hctx)
-{
-	data->q = q;
-	data->flags = flags;
-	data->ctx = ctx;
-	data->hctx = hctx;
-}
-
 static inline struct blk_mq_tags *blk_mq_tags_from_data(struct blk_mq_alloc_data *data)
 {
 	if (data->flags & BLK_MQ_REQ_INTERNAL)
-- 
2.12.0
