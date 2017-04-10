Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f45.google.com ([74.125.83.45]:33945 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751864AbdDJGwU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Apr 2017 02:52:20 -0400
Received: by mail-pg0-f45.google.com with SMTP id 21so101101359pgg.1
        for <linux-block@vger.kernel.org>; Sun, 09 Apr 2017 23:52:20 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Cc: kernel-team@fb.com
Subject: [PATCH v3 3/5] blk-mq: export helpers
Date: Sun,  9 Apr 2017 23:51:11 -0700
Message-Id: <45c2de5dc43bfefddbefaab32f203bf6795ffe9d.1491806249.git.osandov@fb.com>
In-Reply-To: <cover.1491806249.git.osandov@fb.com>
References: <cover.1491806249.git.osandov@fb.com>
In-Reply-To: <cover.1491806249.git.osandov@fb.com>
References: <cover.1491806249.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

blk_mq_finish_request() is required for schedulers that define their own
put_request(). blk_mq_run_hw_queue() is required for schedulers that
hold back requests to be run later.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 block/blk-mq.c         | 2 ++
 include/linux/blk-mq.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index e536dacfae4c..7138cd98146e 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -368,6 +368,7 @@ void blk_mq_finish_request(struct request *rq)
 {
 	blk_mq_finish_hctx_request(blk_mq_map_queue(rq->q, rq->mq_ctx->cpu), rq);
 }
+EXPORT_SYMBOL_GPL(blk_mq_finish_request);
 
 void blk_mq_free_request(struct request *rq)
 {
@@ -1183,6 +1184,7 @@ void blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async)
 {
 	__blk_mq_delay_run_hw_queue(hctx, async, 0);
 }
+EXPORT_SYMBOL(blk_mq_run_hw_queue);
 
 void blk_mq_run_hw_queues(struct request_queue *q, bool async)
 {
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index b90c3d5766cd..d75de612845d 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -238,6 +238,7 @@ void blk_mq_start_hw_queues(struct request_queue *q);
 void blk_mq_start_stopped_hw_queue(struct blk_mq_hw_ctx *hctx, bool async);
 void blk_mq_start_stopped_hw_queues(struct request_queue *q, bool async);
 void blk_mq_delay_run_hw_queue(struct blk_mq_hw_ctx *hctx, unsigned long msecs);
+void blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async);
 void blk_mq_run_hw_queues(struct request_queue *q, bool async);
 void blk_mq_delay_queue(struct blk_mq_hw_ctx *hctx, unsigned long msecs);
 void blk_mq_tagset_busy_iter(struct blk_mq_tag_set *tagset,
-- 
2.12.2
