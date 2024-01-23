Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3AD180058
	for <linux-block@vger.kernel.org>; Tue, 23 Jan 2024 17:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706031634; cv=none; b=fJciO4EJ8Akvb2G+COxlnU0sC0FsWwvwYEaSSFgpt1fA5nWqNTJkgPzeikB5N7v9gArRqjbpdOPuK5bTvzjR9vBGxbG3q+hg2qk+0NHcvYRUbJPD3chnRZVefu/bZacNSioyM2SbJ6/ORf7L/JYR631e3c4YpC3Twf63RibAnqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706031634; c=relaxed/simple;
	bh=rctKEqZgFH8GBDRhKSDbQ7fv+wiyAwfvfZ94Npf4OAs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uIthPjehk6vYC2Bx34RUk0aN2lQ5NKHsyDz2AISOHygNoWg7CAR3iuOAW2Aj9XSPXtvUQ/a3+ZWShBY0YttYmXfNDYQk38q7P1rb8rf/aT8No2RD5khYvF+nElD3j6xNKQvOB7bfE8o7NL9E2DuvnhTIJGNwFbz9bH/JUasO7gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=2+30bjJR; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="2+30bjJR"
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-7bed82030faso59740839f.1
        for <linux-block@vger.kernel.org>; Tue, 23 Jan 2024 09:40:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1706031631; x=1706636431; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ldNwZctVsTHz0OYw14xBNqcgq5YNaiT4939FOB1Vvs0=;
        b=2+30bjJRpxRuA4zLMEtu9qpEUebuXTv6tgLB8ncTL6gr/IMf1GuvlwRudNoqz4pPi7
         ImM/KBfIbRH7Se/V7dBBTwsleVTMdzwtROiTNur77QZsKSeXVfpYIbkrgsuvDRCZ1LEt
         P9dqOgO9i/whlKsl2ecMxOp2wvHYhIbkyujNF7hSklC3CshfsjWss2X5QGE0w8Iz9JOd
         a3OyCGFObsYy3k9I8Q/oDksPQrYCO468rRGafdf4kv6Bs/AELuNt1HiAXTbCilfWAJRv
         vb5F9syvzzhgc2IatDbvYnAimm5ukz6Hqlh90nN8SgzXuyjcII4bUX3rguStJQg11NJM
         LWlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706031631; x=1706636431;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ldNwZctVsTHz0OYw14xBNqcgq5YNaiT4939FOB1Vvs0=;
        b=Eielfz6Ve1X7AUXb0nUyQ+rX8kqwdezsX41CHx+LsmQ6mv5DwRP+pqrM56cIKip/cJ
         Z1d+cXDuZcK9Ck+iRY1bzwMgLMiQzDOdt3bg6sqmJb/FTnt3tg3dIx103AOKETcT0GR3
         U/Mf8lEXmP0Dt2EDsDogt9FBEYpV3xhpPy24PYrnzjg7XJLTTEHTGDdslyuX6/Rn7TfK
         k5ACmmEeL0Si44h5PiY6sKiLWlfNNi++o+JuFiKzlnCjiMXhMM2+q1KRD7YEPYv3qBew
         OfHjCdzAXEVklF0pkjCtiQpsfsLMc0JLxVYvok80d78XVw+uoJHlaIWWa2eAexTC4XNs
         T26g==
X-Gm-Message-State: AOJu0Yzc8/2dGo5qVwAafJMLndnS3P2b4uYOam/CeLDLyD1qBdRQt5Xv
	Uoe22cLwRLRVdT2g+6N5/BccquvZqEqWyHL7cCRpNQlNfgqy/p0e6MHjcTRfylO3129YvbTKCac
	pr8Q=
X-Google-Smtp-Source: AGHT+IHpNVN4x1bY43D8YgsNqUcNDgK1WZ0EdCGBNJoa/dJX2yTMYgJUKMcfP0Z3S43eSaHDPce5SA==
X-Received: by 2002:a05:6602:4145:b0:7bf:60bc:7f1e with SMTP id bv5-20020a056602414500b007bf60bc7f1emr11477265iob.1.1706031631637;
        Tue, 23 Jan 2024 09:40:31 -0800 (PST)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id l15-20020a6b700f000000b007bf4b9fa2e6sm4647700ioc.47.2024.01.23.09.40.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 09:40:30 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Bart Van Assche <bvanassche@acm.org>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4/8] block/mq-deadline: use separate insertion lists
Date: Tue, 23 Jan 2024 10:34:16 -0700
Message-ID: <20240123174021.1967461-5-axboe@kernel.dk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240123174021.1967461-1-axboe@kernel.dk>
References: <20240123174021.1967461-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bart Van Assche <bvanassche@acm.org>

Reduce lock contention on dd->lock by calling dd_insert_request() from
inside the dispatch callback instead of from the insert callback. This
patch is inspired by a patch from Jens.

With the previous dispatch and merge optimization, this drastically
reduces contention for a sample cases of 32 threads doing IO to devices.
The test case looks as follows:

fio --bs=512 --group_reporting=1 --gtod_reduce=1 --invalidate=1 \
	--ioengine=io_uring --norandommap --runtime=60 --rw=randread \
	--thread --time_based=1 --buffered=0 --fixedbufs=1 --numjobs=32 \
	--iodepth=4 --iodepth_batch_submit=4 --iodepth_batch_complete=4 \
	--name=scaletest --filename=/dev/$DEV

Before:

Device		IOPS	sys	contention	diff
====================================================
null_blk	879K	89%	93.6%
nvme0n1		901K	86%	94.5%

and after this and the previous two patches:

Device		IOPS	sys	contention	diff
====================================================
null_blk	2867K	11.1%	~6.0%		+226%
nvme0n1		3162K	 9.9%	~5.0%		+250%

which basically eliminates all of the lock contention, it's down to
more normal levels. The throughput increases show that nicely, with more
than a 200% improvement for both cases.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
[axboe: expand commit message with more details and perf results]
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/mq-deadline.c | 66 ++++++++++++++++++++++++++++++++++++---------
 1 file changed, 53 insertions(+), 13 deletions(-)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index 740b94f36cac..1b0de4fc3958 100644
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
@@ -592,6 +599,33 @@ static struct request *dd_dispatch_prio_aged_requests(struct deadline_data *dd,
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
@@ -602,10 +636,12 @@ static struct request *dd_dispatch_prio_aged_requests(struct deadline_data *dd,
  */
 static struct request *dd_dispatch_request(struct blk_mq_hw_ctx *hctx)
 {
-	struct deadline_data *dd = hctx->queue->elevator->elevator_data;
+	struct request_queue *q = hctx->queue;
+	struct deadline_data *dd = q->elevator->elevator_data;
 	const unsigned long now = jiffies;
 	struct request *rq;
 	enum dd_prio prio;
+	LIST_HEAD(free);
 
 	/*
 	 * If someone else is already dispatching, skip this one. This will
@@ -620,6 +656,7 @@ static struct request *dd_dispatch_request(struct blk_mq_hw_ctx *hctx)
 		return NULL;
 
 	spin_lock(&dd->lock);
+	dd_do_insert(q, &free);
 	rq = dd_dispatch_prio_aged_requests(dd, now);
 	if (rq)
 		goto unlock;
@@ -638,6 +675,7 @@ static struct request *dd_dispatch_request(struct blk_mq_hw_ctx *hctx)
 	clear_bit_unlock(DD_DISPATCHING, &dd->run_state);
 	spin_unlock(&dd->lock);
 
+	blk_mq_free_requests(&free);
 	return rq;
 }
 
@@ -727,8 +765,12 @@ static int dd_init_sched(struct request_queue *q, struct elevator_type *e)
 	eq->elevator_data = dd;
 
 	spin_lock_init(&dd->lock);
+	spin_lock_init(&dd->insert_lock);
 	spin_lock_init(&dd->zone_lock);
 
+	INIT_LIST_HEAD(&dd->at_head);
+	INIT_LIST_HEAD(&dd->at_tail);
+
 	for (prio = 0; prio <= DD_PRIO_MAX; prio++) {
 		struct dd_per_prio *per_prio = &dd->per_prio[prio];
 
@@ -899,19 +941,13 @@ static void dd_insert_requests(struct blk_mq_hw_ctx *hctx,
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
@@ -990,6 +1026,10 @@ static bool dd_has_work(struct blk_mq_hw_ctx *hctx)
 	struct deadline_data *dd = hctx->queue->elevator->elevator_data;
 	enum dd_prio prio;
 
+	if (!list_empty_careful(&dd->at_head) ||
+	    !list_empty_careful(&dd->at_tail))
+		return true;
+
 	for (prio = 0; prio <= DD_PRIO_MAX; prio++)
 		if (dd_has_work_for_prio(&dd->per_prio[prio]))
 			return true;
-- 
2.43.0

