Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: osandov@fb.com,
	efault@gmx.de,
	paolo.valente@linaro.org,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/7] blk-mq: don't call into depth limiting for reserved tags
Date: Wed,  9 May 2018 14:49:21 -0600
Message-Id: <1525898967-13425-2-git-send-email-axboe@kernel.dk>
In-Reply-To: <1525898967-13425-1-git-send-email-axboe@kernel.dk>
References: <1525898967-13425-1-git-send-email-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

It's not useful, they are internal and/or error handling recovery
commands.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-mq.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 4e9d83594cca..64630caaf27e 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -360,9 +360,11 @@ static struct request *blk_mq_get_request(struct request_queue *q,
 
 		/*
 		 * Flush requests are special and go directly to the
-		 * dispatch list.
+		 * dispatch list. Don't include reserved tags in the
+		 * limiting, as it isn't useful.
 		 */
-		if (!op_is_flush(op) && e->type->ops.mq.limit_depth)
+		if (!op_is_flush(op) && e->type->ops.mq.limit_depth &&
+		    !(data->flags & BLK_MQ_REQ_RESERVED))
 			e->type->ops.mq.limit_depth(op, data);
 	}
 
-- 
2.7.4
