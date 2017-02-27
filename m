Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f43.google.com ([74.125.83.43]:36313 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751596AbdB0SZA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Feb 2017 13:25:00 -0500
Received: by mail-pg0-f43.google.com with SMTP id s67so47225044pgb.3
        for <linux-block@vger.kernel.org>; Mon, 27 Feb 2017 10:24:23 -0800 (PST)
Date: Mon, 27 Feb 2017 09:53:51 -0800
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
        linux-block@vger.kernel.org
Cc: kernel-team@fb.com
Subject: Re: [PATCH 1/3] blk-mq: make blk_mq_alloc_request_hctx() allocate a
 scheduler request
Message-ID: <20170227175351.GF10715@vader>
References: <dcfe49f597dc1eec3b326024c86a6ad3afb82fa8.1488217516.git.osandov@fb.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="LZvS9be/3tNcYl/X"
In-Reply-To: <dcfe49f597dc1eec3b326024c86a6ad3afb82fa8.1488217516.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 27, 2017 at 09:47:53AM -0800, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> blk_mq_alloc_request_hctx() allocates a driver request directly, unlike
> its blk_mq_alloc_request() counterpart. It also crashes because it
> doesn't update the tags->rqs map.
> 
> Fix it by making it allocate a scheduler request.
> 
> Reported-by: Sagi Grimberg <sagi@grimberg.me>
> Signed-off-by: Omar Sandoval <osandov@fb.com>
> ---
> I think this should do it. Verified that normal operation still works
> for me, but I'm not sure how to test the actual _hctx() alloc path.
> Sagi, could you please test this series out?

Hm, Sagi, your mail server seems to have rejected patches 2 and 3
because git-send-email duplicated the in-reply-to header for some
reason. I've attached the patches instead.

--LZvS9be/3tNcYl/X
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="0001-blk-mq-make-blk_mq_alloc_request_hctx-allocate-a-sch.patch"

>From dcfe49f597dc1eec3b326024c86a6ad3afb82fa8 Mon Sep 17 00:00:00 2001
Message-Id: <dcfe49f597dc1eec3b326024c86a6ad3afb82fa8.1488217516.git.osandov@fb.com>
From: Omar Sandoval <osandov@fb.com>
Date: Mon, 27 Feb 2017 09:34:20 -0800
Subject: [PATCH 1/3] blk-mq: make blk_mq_alloc_request_hctx() allocate a
 scheduler request

blk_mq_alloc_request_hctx() allocates a driver request directly, unlike
its blk_mq_alloc_request() counterpart. It also crashes because it
doesn't update the tags->rqs map.

Fix it by making it allocate a scheduler request.

Reported-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Omar Sandoval <osandov@fb.com>
---
I think this should do it. Verified that normal operation still works
for me, but I'm not sure how to test the actual _hctx() alloc path.
Sagi, could you please test this series out?

 block/blk-mq-sched.c | 11 +++++------
 block/blk-mq.c       | 34 +++++++++++++++-------------------
 2 files changed, 20 insertions(+), 25 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 46ca965fff5c..5697b23412a1 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -110,15 +110,14 @@ struct request *blk_mq_sched_get_request(struct request_queue *q,
 					 struct blk_mq_alloc_data *data)
 {
 	struct elevator_queue *e = q->elevator;
-	struct blk_mq_hw_ctx *hctx;
-	struct blk_mq_ctx *ctx;
 	struct request *rq;
 
 	blk_queue_enter_live(q);
-	ctx = blk_mq_get_ctx(q);
-	hctx = blk_mq_map_queue(q, ctx->cpu);
-
-	blk_mq_set_alloc_data(data, q, data->flags, ctx, hctx);
+	data->q = q;
+	if (likely(!data->ctx))
+		data->ctx = blk_mq_get_ctx(q);
+	if (likely(!data->hctx))
+		data->hctx = blk_mq_map_queue(q, data->ctx->cpu);
 
 	if (e) {
 		data->flags |= BLK_MQ_REQ_INTERNAL;
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 9611cd9920e9..cc9713f574a5 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -273,10 +273,9 @@ EXPORT_SYMBOL(blk_mq_alloc_request);
 struct request *blk_mq_alloc_request_hctx(struct request_queue *q, int rw,
 		unsigned int flags, unsigned int hctx_idx)
 {
-	struct blk_mq_hw_ctx *hctx;
-	struct blk_mq_ctx *ctx;
+	struct blk_mq_alloc_data alloc_data = { .flags = flags };
 	struct request *rq;
-	struct blk_mq_alloc_data alloc_data;
+	unsigned int cpu;
 	int ret;
 
 	/*
@@ -299,26 +298,23 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q, int rw,
 	 * Check if the hardware context is actually mapped to anything.
 	 * If not tell the caller that it should skip this queue.
 	 */
-	hctx = q->queue_hw_ctx[hctx_idx];
-	if (!blk_mq_hw_queue_mapped(hctx)) {
-		ret = -EXDEV;
-		goto out_queue_exit;
+	alloc_data.hctx = q->queue_hw_ctx[hctx_idx];
+	if (!blk_mq_hw_queue_mapped(alloc_data.hctx)) {
+		blk_queue_exit(q);
+		return ERR_PTR(-EXDEV);
 	}
-	ctx = __blk_mq_get_ctx(q, cpumask_first(hctx->cpumask));
+	cpu = cpumask_first(alloc_data.hctx->cpumask);
+	alloc_data.ctx = __blk_mq_get_ctx(q, cpu);
 
-	blk_mq_set_alloc_data(&alloc_data, q, flags, ctx, hctx);
-	rq = __blk_mq_alloc_request(&alloc_data, rw);
-	if (!rq) {
-		ret = -EWOULDBLOCK;
-		goto out_queue_exit;
-	}
-	alloc_data.hctx->tags->rqs[rq->tag] = rq;
-
-	return rq;
+	rq = blk_mq_sched_get_request(q, NULL, rw, &alloc_data);
 
-out_queue_exit:
+	blk_mq_put_ctx(alloc_data.ctx);
 	blk_queue_exit(q);
-	return ERR_PTR(ret);
+
+	if (!rq)
+		return ERR_PTR(-EWOULDBLOCK);
+
+	return rq;
 }
 EXPORT_SYMBOL_GPL(blk_mq_alloc_request_hctx);
 
-- 
2.12.0


--LZvS9be/3tNcYl/X
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="0002-blk-mq-kill-blk_mq_set_alloc_data.patch"

>From 87aa35aa12f2edd4a9c56c382bf85ee580edf156 Mon Sep 17 00:00:00 2001
Message-Id: <87aa35aa12f2edd4a9c56c382bf85ee580edf156.1488217516.git.osandov@fb.com>
In-Reply-To: <dcfe49f597dc1eec3b326024c86a6ad3afb82fa8.1488217516.git.osandov@fb.com>
References: <dcfe49f597dc1eec3b326024c86a6ad3afb82fa8.1488217516.git.osandov@fb.com>
From: Omar Sandoval <osandov@fb.com>
Date: Mon, 27 Feb 2017 09:38:58 -0800
Subject: [PATCH 2/3] blk-mq: kill blk_mq_set_alloc_data()

Nothing is using it anymore.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 block/blk-mq.h | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/block/blk-mq.h b/block/blk-mq.h
index 24b2256186f3..088ced003c13 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -146,16 +146,6 @@ struct blk_mq_alloc_data {
 	struct blk_mq_hw_ctx *hctx;
 };
 
-static inline void blk_mq_set_alloc_data(struct blk_mq_alloc_data *data,
-		struct request_queue *q, unsigned int flags,
-		struct blk_mq_ctx *ctx, struct blk_mq_hw_ctx *hctx)
-{
-	data->q = q;
-	data->flags = flags;
-	data->ctx = ctx;
-	data->hctx = hctx;
-}
-
 static inline struct blk_mq_tags *blk_mq_tags_from_data(struct blk_mq_alloc_data *data)
 {
 	if (data->flags & BLK_MQ_REQ_INTERNAL)
-- 
2.12.0


--LZvS9be/3tNcYl/X
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="0003-blk-mq-move-update-of-tags-rqs-to-__blk_mq_alloc_req.patch"

>From 4715cce107df8b579734a074093a34001efd01d0 Mon Sep 17 00:00:00 2001
Message-Id: <4715cce107df8b579734a074093a34001efd01d0.1488217516.git.osandov@fb.com>
In-Reply-To: <dcfe49f597dc1eec3b326024c86a6ad3afb82fa8.1488217516.git.osandov@fb.com>
References: <dcfe49f597dc1eec3b326024c86a6ad3afb82fa8.1488217516.git.osandov@fb.com>
From: Omar Sandoval <osandov@fb.com>
Date: Mon, 27 Feb 2017 09:40:34 -0800
Subject: [PATCH 3/3] blk-mq: move update of tags->rqs to
 __blk_mq_alloc_request()

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


--LZvS9be/3tNcYl/X--
