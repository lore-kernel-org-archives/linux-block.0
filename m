Return-Path: <huhai@kylinos.cn>
From: huhai <huhai@kylinos.cn>
To: axboe@kernel.dk
Cc: ming.lei@redhat.com,
	linux-block@vger.kernel.org
Subject: [PATCH] blk-mq: remove wrong 'unlikely' checks
Date: Tue, 22 May 2018 17:39:34 +0800
Message-Id: <20180522093934.20849-1-huhai@kylinos.cn>
List-ID: <linux-block@vger.kernel.org>

When dispatch_rq_from_ctx is called, in the vast majority of cases
the ctx->rq_list is not empty

Fixes: b347689ffbca ("blk-mq-sched: improve dispatching from sw queue")
Signed-off-by: huhai <huhai@kylinos.cn>
---
 block/blk-mq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 4cbfd784e837..df928200b17e 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1036,7 +1036,7 @@ static bool dispatch_rq_from_ctx(struct sbitmap *sb, unsigned int bitnr,
 	struct blk_mq_ctx *ctx = hctx->ctxs[bitnr];
 
 	spin_lock(&ctx->lock);
-	if (unlikely(!list_empty(&ctx->rq_list))) {
+	if (!list_empty(&ctx->rq_list)) {
 		dispatch_data->rq = list_entry_rq(ctx->rq_list.next);
 		list_del_init(&dispatch_data->rq->queuelist);
 		if (list_empty(&ctx->rq_list))
-- 
2.17.0
