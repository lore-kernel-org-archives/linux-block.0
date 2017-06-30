Return-Path: <axboe@kernel.dk>
To: Max Gurtovoy <maxg@mellanox.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: NVMe induced NULL deref in bt_iter()
Message-ID: <bcc46757-6027-ed7f-22b4-e6964d0dedf0@kernel.dk>
Date: Fri, 30 Jun 2017 11:26:49 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Max,

I remembered you reporting this. I think this is a regression introduced
with the scheduling, since ->rqs[] isn't static anymore. ->static_rqs[]
is, but that's not indexable by the tag we find. So I think we need to
guard those with a NULL check. The actual requests themselves are
static, so we know the memory itself isn't going away. But if we race
with completion, we could find a NULL there, validly.

Since you could reproduce it, can you try the below?

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
Jens Axboe
