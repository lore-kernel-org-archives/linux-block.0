Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56670 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751639AbdH3PUO (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Aug 2017 11:20:14 -0400
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Cc: Bart Van Assche <bart.vanassche@sandisk.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 1/2] blk-mq: add requests in the tail of hctx->dispatch
Date: Wed, 30 Aug 2017 23:19:34 +0800
Message-Id: <20170830151935.24253-3-ming.lei@redhat.com>
In-Reply-To: <20170830151935.24253-1-ming.lei@redhat.com>
References: <20170830151935.24253-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

It is more reasonable to add requests to ->dispatch in way
of FIFO style, instead of LIFO style.

Also in this way, we can allow to insert request at the front
of hw queue, which function is needed to fix one bug
in blk-mq's implementation of blk_execute_rq()

Reported-by: Oleksandr Natalenko <oleksandr@natalenko.name>
Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq-sched.c | 2 +-
 block/blk-mq.c       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 4ab69435708c..8d97df40fc28 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -272,7 +272,7 @@ static bool blk_mq_sched_bypass_insert(struct blk_mq_hw_ctx *hctx,
 	 * the dispatch list.
 	 */
 	spin_lock(&hctx->lock);
-	list_add(&rq->queuelist, &hctx->dispatch);
+	list_add_tail(&rq->queuelist, &hctx->dispatch);
 	spin_unlock(&hctx->lock);
 	return true;
 }
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 4603b115e234..fed3d0c16266 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1067,7 +1067,7 @@ bool blk_mq_dispatch_rq_list(struct request_queue *q, struct list_head *list)
 		blk_mq_put_driver_tag(rq);
 
 		spin_lock(&hctx->lock);
-		list_splice_init(list, &hctx->dispatch);
+		list_splice_tail_init(list, &hctx->dispatch);
 		spin_unlock(&hctx->lock);
 
 		/*
-- 
2.9.5
