Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f41.google.com ([74.125.83.41]:33271 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751341AbdB0Rtu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Feb 2017 12:49:50 -0500
Received: by mail-pg0-f41.google.com with SMTP id 25so17473184pgy.0
        for <linux-block@vger.kernel.org>; Mon, 27 Feb 2017 09:48:44 -0800 (PST)
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
        linux-block@vger.kernel.org
Cc: kernel-team@fb.com
Subject: [PATCH 3/3] blk-mq: move update of tags->rqs to __blk_mq_alloc_request()
Date: Mon, 27 Feb 2017 09:47:55 -0800
Message-Id: <4715cce107df8b579734a074093a34001efd01d0.1488217516.git.osandov@fb.com>
In-Reply-To: <dcfe49f597dc1eec3b326024c86a6ad3afb82fa8.1488217516.git.osandov@fb.com>
References: <dcfe49f597dc1eec3b326024c86a6ad3afb82fa8.1488217516.git.osandov@fb.com>
In-Reply-To: <dcfe49f597dc1eec3b326024c86a6ad3afb82fa8.1488217516.git.osandov@fb.com>
References: <dcfe49f597dc1eec3b326024c86a6ad3afb82fa8.1488217516.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

No functional difference, it just makes a little more sense to update
the tag map where we actually allocate the tag.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
Optional cleanup, since there's only one place that does this.

 block/blk-mq-sched.c | 2 --
 block/blk-mq.c       | 1 +
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 5697b23412a1..09af8ff18719 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -134,8 +134,6 @@ struct request *blk_mq_sched_get_request(struct request_queue *q,
 			rq = __blk_mq_alloc_request(data, op);
 	} else {
 		rq = __blk_mq_alloc_request(data, op);
-		if (rq)
-			data->hctx->tags->rqs[rq->tag] = rq;
 	}
 
 	if (rq) {
diff --git a/block/blk-mq.c b/block/blk-mq.c
index cc9713f574a5..452c1caf978f 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -234,6 +234,7 @@ struct request *__blk_mq_alloc_request(struct blk_mq_alloc_data *data,
 			}
 			rq->tag = tag;
 			rq->internal_tag = -1;
+			data->hctx->tags->rqs[rq->tag] = rq;
 		}
 
 		blk_mq_rq_ctx_init(data->q, data->ctx, rq, op);
-- 
2.12.0
