Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34023 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726890AbeHIWx0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 9 Aug 2018 18:53:26 -0400
Received: by mail-pf1-f195.google.com with SMTP id k19-v6so3386317pfi.1
        for <linux-block@vger.kernel.org>; Thu, 09 Aug 2018 13:26:58 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@fb.com>, kernel-team@fb.com
Subject: [RFC PATCH 3/5] kyber: don't make domain token sbitmap larger than necessary
Date: Thu,  9 Aug 2018 13:26:45 -0700
Message-Id: <47e82117e82563637b9a7091b827267f6874b9d2.1533846185.git.osandov@fb.com>
In-Reply-To: <cover.1533846185.git.osandov@fb.com>
References: <cover.1533846185.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

The domain token sbitmaps are currently initialized to the device queue
depth or 256, whichever is larger, and immediately resized to the
maximum depth for that domain (256, 128, or 64 for read, write, and
other, respectively). The sbitmap is never resized larger than that, so
it's unnecessary to allocate a bitmap larger than the maximum depth.
Let's just allocate it to the maximum depth to begin with. This will use
marginally less memory, and more importantly, give us a more appropriate
number of bits per sbitmap word.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 block/kyber-iosched.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/block/kyber-iosched.c b/block/kyber-iosched.c
index 95d062c07c61..08eb5295c18d 100644
--- a/block/kyber-iosched.c
+++ b/block/kyber-iosched.c
@@ -40,8 +40,6 @@ enum {
 };
 
 enum {
-	KYBER_MIN_DEPTH = 256,
-
 	/*
 	 * In order to prevent starvation of synchronous requests by a flood of
 	 * asynchronous requests, we reserve 25% of requests for synchronous
@@ -305,7 +303,6 @@ static int kyber_bucket_fn(const struct request *rq)
 static struct kyber_queue_data *kyber_queue_data_alloc(struct request_queue *q)
 {
 	struct kyber_queue_data *kqd;
-	unsigned int max_tokens;
 	unsigned int shift;
 	int ret = -ENOMEM;
 	int i;
@@ -320,25 +317,17 @@ static struct kyber_queue_data *kyber_queue_data_alloc(struct request_queue *q)
 	if (!kqd->cb)
 		goto err_kqd;
 
-	/*
-	 * The maximum number of tokens for any scheduling domain is at least
-	 * the queue depth of a single hardware queue. If the hardware doesn't
-	 * have many tags, still provide a reasonable number.
-	 */
-	max_tokens = max_t(unsigned int, q->tag_set->queue_depth,
-			   KYBER_MIN_DEPTH);
 	for (i = 0; i < KYBER_NUM_DOMAINS; i++) {
 		WARN_ON(!kyber_depth[i]);
 		WARN_ON(!kyber_batch_size[i]);
 		ret = sbitmap_queue_init_node(&kqd->domain_tokens[i],
-					      max_tokens, -1, false, GFP_KERNEL,
-					      q->node);
+					      kyber_depth[i], -1, false,
+					      GFP_KERNEL, q->node);
 		if (ret) {
 			while (--i >= 0)
 				sbitmap_queue_free(&kqd->domain_tokens[i]);
 			goto err_cb;
 		}
-		sbitmap_queue_resize(&kqd->domain_tokens[i], kyber_depth[i]);
 	}
 
 	shift = kyber_sched_tags_shift(kqd);
-- 
2.18.0
