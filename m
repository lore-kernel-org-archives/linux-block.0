Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:39434 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1032630AbdD1OcG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Apr 2017 10:32:06 -0400
From: Jens Axboe <axboe@fb.com>
To: <linux-block@vger.kernel.org>
CC: <ming.lei@redhat.com>, <hch@lst.de>, Jens Axboe <axboe@fb.com>
Subject: [PATCH 4/6] blk-mq: don't bypass scheduler for reserved requests
Date: Fri, 28 Apr 2017 08:31:49 -0600
Message-ID: <1493389911-19512-5-git-send-email-axboe@fb.com>
In-Reply-To: <1493389911-19512-1-git-send-email-axboe@fb.com>
References: <1493389911-19512-1-git-send-email-axboe@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Instead of bypassing the scheduler for insertion of reserved requests,
we ensure that the request is marked as RQF_RESERVED so they driver
knows where it came from.

Usually we just use the tag to know if it's reserved or not,
but that only works when the request has a driver tag assigned.
Using RQF_RESERVED can be done independently of whether or not
scheduling is used.

Signed-off-by: Jens Axboe <axboe@fb.com>
---
 block/blk-mq-sched.c   | 8 +++-----
 block/blk-mq.c         | 3 +++
 include/linux/blkdev.h | 2 ++
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 8b361e192e8a..27c67465f856 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -82,11 +82,7 @@ struct request *blk_mq_sched_get_request(struct request_queue *q,
 	if (likely(!data->hctx))
 		data->hctx = blk_mq_map_queue(q, data->ctx->cpu);
 
-	/*
-	 * For a reserved tag, allocate a normal request since we might
-	 * have driver dependencies on the value of the internal tag.
-	 */
-	if (e && !(data->flags & BLK_MQ_REQ_RESERVED)) {
+	if (e) {
 		data->flags |= BLK_MQ_REQ_INTERNAL;
 
 		/*
@@ -104,6 +100,8 @@ struct request *blk_mq_sched_get_request(struct request_queue *q,
 	}
 
 	if (rq) {
+		if (data->flags & BLK_MQ_REQ_RESERVED)
+			rq->rq_flags |= RQF_RESERVED;
 		if (!op_is_flush(op)) {
 			rq->elv.icq = NULL;
 			if (e && e->type->icq_cache)
diff --git a/block/blk-mq.c b/block/blk-mq.c
index b75ef2392db7..0168b27469cb 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -268,6 +268,9 @@ struct request *__blk_mq_alloc_request(struct blk_mq_alloc_data *data,
 			data->hctx->tags->rqs[rq->tag] = rq;
 		}
 
+		if (data->flags & BLK_MQ_REQ_RESERVED)
+			rq->rq_flags |= RQF_RESERVED;
+
 		blk_mq_rq_ctx_init(data->q, data->ctx, rq, op);
 		return rq;
 	}
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index ba3884f26288..c246de5861dc 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -120,6 +120,8 @@ typedef __u32 __bitwise req_flags_t;
 /* Look at ->special_vec for the actual data payload instead of the
    bio chain. */
 #define RQF_SPECIAL_PAYLOAD	((__force req_flags_t)(1 << 18))
+/* Request came from the reserved tags/pool */
+#define RQF_RESERVED		((__force req_flags_t)(1 << 19))
 
 /* flags that prevent us from merging requests: */
 #define RQF_NOMERGE_FLAGS \
-- 
2.7.4
