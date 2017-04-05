Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f53.google.com ([74.125.83.53]:33425 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932546AbdDES33 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Apr 2017 14:29:29 -0400
Received: by mail-pg0-f53.google.com with SMTP id x125so12191495pgb.0
        for <linux-block@vger.kernel.org>; Wed, 05 Apr 2017 11:29:29 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Cc: kernel-team@fb.com
Subject: [PATCH v2 8/8] blk-mq: clean up direct issue blk_mq_queue_data initialization
Date: Wed,  5 Apr 2017 11:28:20 -0700
Message-Id: <e0eac74e541e9f85403fd4cf887a7f288768f00e.1491416593.git.osandov@fb.com>
In-Reply-To: <cover.1491416593.git.osandov@fb.com>
References: <cover.1491416593.git.osandov@fb.com>
In-Reply-To: <cover.1491416593.git.osandov@fb.com>
References: <cover.1491416593.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

Trivial cleanup.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 block/blk-mq.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 71dc8608f3a8..779249a5999b 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1451,8 +1451,7 @@ static void __blk_mq_try_issue_directly(struct request *rq, blk_qc_t *cookie,
 	struct request_queue *q = rq->q;
 	struct blk_mq_queue_data bd = {
 		.rq = rq,
-		.list = NULL,
-		.last = 1
+		.last = true,
 	};
 	struct blk_mq_hw_ctx *hctx;
 	blk_qc_t new_cookie;
-- 
2.12.2
