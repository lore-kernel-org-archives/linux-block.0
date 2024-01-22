Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E95312E56
	for <linux-block@vger.kernel.org>; Mon, 22 Jan 2024 23:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705967637; cv=none; b=mzlgOmnNIwVuRc/eurzwBCbWUEVh6F5Iu/xjuw2hGtD8M698O9aPupiF7NL9eUWAYWxT6MgHWaOjEBEQZEFsBoo5KDZsesr4EIC7j9pGuHt2N5ZgCCWZY9fxF+4vWpi9DICAL8KQewXgex7b+hrm0YP91LIise4ruWC392cXkiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705967637; c=relaxed/simple;
	bh=WNaLQOTvRlltijApE3q3YmhNrqciDTqUmW5xLl+bqfc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZkVIz2K6GETQ+4Oim+6FN4hi1KLhKVUPkfjwSLyoY69gfZAnZPMLgf7jElYufITnuBGNaqrcbs0tdNPCFvlofDq/wq9JyLqCsJcqUoXZV0GmHIjUrKFQlkeWOkpNv02jQntQRyEykPk1iyleMRTYGtWuhwhyaAM6b+sboVCr96o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6db0fdd2b8fso1771640b3a.2
        for <linux-block@vger.kernel.org>; Mon, 22 Jan 2024 15:53:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705967635; x=1706572435;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VGY7+s5+ev7hogDnsMOEa6sW1fzkfiXEUne6AffkzpQ=;
        b=le7WgGLn2CA/u7rmcLKXZRyte1qE+tCgqGRlSbeH3t3tEjVYW5oLqd/NIVUnhSoxcd
         sEf6+ioHtf1AyHL3DyT2ln72eXQPTyPNS+iEz+rQTnQFelqq84kpQD2h7Knac5mFaVZQ
         Rz2z8o/4uRhcX9tt6CuxpOsWjC3uv/1cuT8ANHplhw7UbAwPQrTToKbyBfv1IB7PtQlN
         BcCcch/uQnMyaeFd93Vo3aEb/naPxd1+iIM/pyZgTmOCdTYMUEt4+D/FnDCAmj3xECcr
         OtncvHDHE5sZ+hDdIHmnrtr6A7NqjvkZVCaP5o2AQ1qUGnQeIbdIV/0lhj3XzcZ8qjIj
         Ph3A==
X-Gm-Message-State: AOJu0Yw+61Ywlz5hG4BVKYsw/UpU+K6SiUrSGq3fD54jVBg4bmO+0g5F
	bUOM0AP2GEi3cELDdv7FfHnPlaDg9oG6hAORJDDOVpB7tGngpYmI
X-Google-Smtp-Source: AGHT+IFaEXvap8r9gt1HAtsgzyOBxt1uCYgriTzCDr/hDMwZAEVKw6h65yewgYB9L2Kht2oPAt+ilQ==
X-Received: by 2002:a05:6a00:4612:b0:6db:c6a6:c9eb with SMTP id ko18-20020a056a00461200b006dbc6a6c9ebmr3591711pfb.1.1705967634768;
        Mon, 22 Jan 2024 15:53:54 -0800 (PST)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:0:1000:8411:317b:f783:2438:d626])
        by smtp.gmail.com with ESMTPSA id t15-20020a62d14f000000b006d9a6953f08sm10600338pfl.103.2024.01.22.15.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 15:53:54 -0800 (PST)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH] block/mq-deadline: Optimize request insertion
Date: Mon, 22 Jan 2024 15:53:32 -0800
Message-ID: <20240122235332.2299150-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reduce lock contention on dd->lock by calling dd_insert_request() from
inside the dispatch callback instead of from the insert callback. This
patch is inspired by a patch from Jens.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/mq-deadline.c | 70 +++++++++++++++++++++++++++++++++++++--------
 1 file changed, 58 insertions(+), 12 deletions(-)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index 83bc21801226..d11b8604f046 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -89,11 +89,15 @@ struct deadline_data {
 	 */
 	struct {
 		spinlock_t lock;
+		spinlock_t insert_lock;
 		spinlock_t zone_lock;
 	} ____cacheline_aligned_in_smp;
 
 	unsigned long run_state;
 
+	struct list_head at_head;
+	struct list_head at_tail;
+
 	struct dd_per_prio per_prio[DD_PRIO_COUNT];
 
 	/* Data direction of latest dispatched request. */
@@ -120,6 +124,9 @@ static const enum dd_prio ioprio_class_to_prio[] = {
 	[IOPRIO_CLASS_IDLE]	= DD_IDLE_PRIO,
 };
 
+static void dd_insert_request(struct request_queue *q, struct request *rq,
+			      blk_insert_t flags, struct list_head *free);
+
 static inline struct rb_root *
 deadline_rb_root(struct dd_per_prio *per_prio, struct request *rq)
 {
@@ -592,6 +599,35 @@ static struct request *dd_dispatch_prio_aged_requests(struct deadline_data *dd,
 	return NULL;
 }
 
+static void __dd_do_insert(struct request_queue *q, blk_insert_t flags,
+			   struct list_head *list, struct list_head *free)
+{
+	while (!list_empty(list)) {
+		struct request *rq;
+
+		rq = list_first_entry(list, struct request, queuelist);
+		list_del_init(&rq->queuelist);
+		dd_insert_request(q, rq, flags, free);
+	}
+}
+
+static void dd_do_insert(struct request_queue *q, struct list_head *free)
+{
+	struct deadline_data *dd = q->elevator->elevator_data;
+	LIST_HEAD(at_head);
+	LIST_HEAD(at_tail);
+
+	lockdep_assert_held(&dd->lock);
+
+	spin_lock(&dd->insert_lock);
+	list_splice_init(&dd->at_head, &at_head);
+	list_splice_init(&dd->at_tail, &at_tail);
+	spin_unlock(&dd->insert_lock);
+
+	__dd_do_insert(q, BLK_MQ_INSERT_AT_HEAD, &at_head, free);
+	__dd_do_insert(q, 0, &at_tail, free);
+}
+
 /*
  * Called from blk_mq_run_hw_queue() -> __blk_mq_sched_dispatch_requests().
  *
@@ -606,6 +642,7 @@ static struct request *dd_dispatch_request(struct blk_mq_hw_ctx *hctx)
 	const unsigned long now = jiffies;
 	struct request *rq;
 	enum dd_prio prio;
+	LIST_HEAD(free);
 
 	/*
 	 * If someone else is already dispatching, skip this one. This will
@@ -620,6 +657,11 @@ static struct request *dd_dispatch_request(struct blk_mq_hw_ctx *hctx)
 		return NULL;
 
 	spin_lock(&dd->lock);
+        /*
+         * Request insertion happens from inside the dispatch callback instead
+         * of inside the insert callback to minimize contention on dd->lock.
+         */
+	dd_do_insert(hctx->queue, &free);
 	rq = dd_dispatch_prio_aged_requests(dd, now);
 	if (rq)
 		goto unlock;
@@ -638,6 +680,8 @@ static struct request *dd_dispatch_request(struct blk_mq_hw_ctx *hctx)
 	clear_bit(DD_DISPATCHING, &dd->run_state);
 	spin_unlock(&dd->lock);
 
+	blk_mq_free_requests(&free);
+
 	return rq;
 }
 
@@ -727,8 +771,12 @@ static int dd_init_sched(struct request_queue *q, struct elevator_type *e)
 	eq->elevator_data = dd;
 
 	spin_lock_init(&dd->lock);
+	spin_lock_init(&dd->insert_lock);
 	spin_lock_init(&dd->zone_lock);
 
+	INIT_LIST_HEAD(&dd->at_head);
+	INIT_LIST_HEAD(&dd->at_tail);
+
 	for (prio = 0; prio <= DD_PRIO_MAX; prio++) {
 		struct dd_per_prio *per_prio = &dd->per_prio[prio];
 
@@ -899,19 +947,13 @@ static void dd_insert_requests(struct blk_mq_hw_ctx *hctx,
 {
 	struct request_queue *q = hctx->queue;
 	struct deadline_data *dd = q->elevator->elevator_data;
-	LIST_HEAD(free);
-
-	spin_lock(&dd->lock);
-	while (!list_empty(list)) {
-		struct request *rq;
 
-		rq = list_first_entry(list, struct request, queuelist);
-		list_del_init(&rq->queuelist);
-		dd_insert_request(q, rq, flags, &free);
-	}
-	spin_unlock(&dd->lock);
-
-	blk_mq_free_requests(&free);
+	spin_lock(&dd->insert_lock);
+	if (flags & BLK_MQ_INSERT_AT_HEAD)
+		list_splice_init(list, &dd->at_head);
+	else
+		list_splice_init(list, &dd->at_tail);
+	spin_unlock(&dd->insert_lock);
 }
 
 /* Callback from inside blk_mq_rq_ctx_init(). */
@@ -990,6 +1032,10 @@ static bool dd_has_work(struct blk_mq_hw_ctx *hctx)
 	struct deadline_data *dd = hctx->queue->elevator->elevator_data;
 	enum dd_prio prio;
 
+	if (!list_empty_careful(&dd->at_head) ||
+	    !list_empty_careful(&dd->at_tail))
+		return true;
+
 	for (prio = 0; prio <= DD_PRIO_MAX; prio++)
 		if (dd_has_work_for_prio(&dd->per_prio[prio]))
 			return true;
