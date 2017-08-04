Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: brking@linux.vnet.ibm.com,
	bart.vanassche@wdc.com,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/6] blk-mq-tag: check for NULL rq when iterating tags
Date: Fri,  4 Aug 2017 09:04:17 -0600
Message-Id: <1501859062-11120-2-git-send-email-axboe@kernel.dk>
In-Reply-To: <1501859062-11120-1-git-send-email-axboe@kernel.dk>
References: <1501859062-11120-1-git-send-email-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

Since we introduced blk-mq-sched, the tags->rqs[] array has been
dynamically assigned. So we need to check for NULL when iterating,
since there's a window of time where the bit is set, but we haven't
dynamically assigned the tags->rqs[] array position yet.

This is perfectly safe, since the memory backing of the request is
never going away while the device is alive.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-mq-tag.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index d0be72ccb091..b856b2827157 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -214,7 +214,7 @@ static bool bt_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
 		bitnr += tags->nr_reserved_tags;
 	rq = tags->rqs[bitnr];
 
-	if (rq->q == hctx->queue)
+	if (rq && rq->q == hctx->queue)
 		iter_data->fn(hctx, rq, iter_data->data, reserved);
 	return true;
 }
@@ -249,8 +249,8 @@ static bool bt_tags_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
 	if (!reserved)
 		bitnr += tags->nr_reserved_tags;
 	rq = tags->rqs[bitnr];
-
-	iter_data->fn(rq, iter_data->data, reserved);
+	if (rq)
+		iter_data->fn(rq, iter_data->data, reserved);
 	return true;
 }
 
-- 
2.7.4
