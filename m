Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:15582 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1036492AbdEYSns (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 May 2017 14:43:48 -0400
From: Bart Van Assche <bart.vanassche@sandisk.com>
To: Jens Axboe <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, Christoph Hellwig <hch@lst.de>,
        "Bart Van Assche" <bart.vanassche@sandisk.com>,
        Hannes Reinecke <hare@suse.com>,
        "Omar Sandoval" <osandov@fb.com>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 17/19] blk-mq: Document locking assumptions
Date: Thu, 25 May 2017 11:43:25 -0700
Message-ID: <20170525184327.23570-18-bart.vanassche@sandisk.com>
In-Reply-To: <20170525184327.23570-1-bart.vanassche@sandisk.com>
References: <20170525184327.23570-1-bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Document the locking assumptions in functions that modify
blk_mq_ctx.rq_list to make it easier for humans to verify
this code.

Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Omar Sandoval <osandov@fb.com>
Cc: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index b230038eba1d..4b1b2c7b4344 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -785,6 +785,8 @@ static bool blk_mq_attempt_merge(struct request_queue *q,
 	struct request *rq;
 	int checked = 8;
 
+	lockdep_assert_held(&ctx->lock);
+
 	list_for_each_entry_reverse(rq, &ctx->rq_list, queuelist) {
 		bool merged = false;
 
@@ -1338,6 +1340,8 @@ static inline void __blk_mq_insert_req_list(struct blk_mq_hw_ctx *hctx,
 {
 	struct blk_mq_ctx *ctx = rq->mq_ctx;
 
+	lockdep_assert_held(&ctx->lock);
+
 	trace_block_rq_insert(hctx->queue, rq);
 
 	if (at_head)
@@ -1351,6 +1355,8 @@ void __blk_mq_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
 {
 	struct blk_mq_ctx *ctx = rq->mq_ctx;
 
+	lockdep_assert_held(&ctx->lock);
+
 	__blk_mq_insert_req_list(hctx, rq, at_head);
 	blk_mq_hctx_mark_pending(hctx, ctx);
 }
-- 
2.12.2
