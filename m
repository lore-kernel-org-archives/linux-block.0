Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B7B54F83
	for <linux-block@vger.kernel.org>; Fri, 19 Jan 2024 16:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705680229; cv=none; b=udiXFgYDyW5FcuQOxOWQH0YNMjX5r27QGV4PRrsXQ4XrTaV3cmzFLmJjZ/nHNZH6CMd9hsOTw2m8iHA7k85NQ1UGxTpQle44+R93CwR1i1MR4p5bYdQsvwSAaySW6rQSiojaffhUMAfyjjRH7+P8gjyyRsB9zzp6EXhR3uz78cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705680229; c=relaxed/simple;
	bh=LtBCGP8P0JdIyyvJ+j0kW3j5RJ+Qy/CI/yDgASn7SMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lXnKhNQhdZ4lm0YUilvql1yI92A39PE95HDmTCR9kIj/4FtiItuSPaKXSI0jMNTFL04hxp+GtnGXELZ0hUO9WZ+RzuBv+vQbXmIDFAk84Y88dNTcbCLUCWPoayH31oWM/6VD1OUJi/1fK9x62gQrJpQDB7Q1viuF4YOIs7aUoJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=nWu0Aiu7; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="nWu0Aiu7"
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-7bed82030faso13084639f.1
        for <linux-block@vger.kernel.org>; Fri, 19 Jan 2024 08:03:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1705680226; x=1706285026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R+L4DBFcuvmEPP5mxZ7Z9hQF2ctRiwJtMB/6A5xRD0s=;
        b=nWu0Aiu7mBhiuYbMfVG5QJfXgtBhoy/hUTijHkGbKmHTOcXN1bu6kw9/Eqv/eAHw8X
         NDx/FmyqMqcpszkywpI173pTZfNU+MoCWN51EOu7QHAkq4ujYxkFVBSH79kYUL1FlnUJ
         Kf375f0I/JQqoYA8u0/UsC5sDGgT78BEewJ5lHMMEmPX88BUlhno+Ne0dAYKnfSShulO
         oYvVSA4FvhUcT1gea1nSQ3glD3VKbdy449as1uVUDPhVLbU0m0gsm21/6Z1vUL+xS1ye
         BaAi3C6nnFtOdOI7N+Zc1RATH4kp4Z+zrhOSlQ87NzLAv4rpFPf0OArzHwHVyL0k/LNd
         WB0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705680226; x=1706285026;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R+L4DBFcuvmEPP5mxZ7Z9hQF2ctRiwJtMB/6A5xRD0s=;
        b=aokB/SZQ9iKleW+4LOj1rqQi65vTFNsGzSnt3WpwwhATGdvtkWs1raJejcUYMDb2Hk
         FHNNv51B/M1GDoswY+u7YNwstBPnDul+2fiIw24zniXv1hnUeYikTpWaHcVdOPBYQ86C
         2E1ckvfgRazmlJYKy6o4ZHYxkzX3PxTUKBdfU/XCJMflWh539RB9K1SiOcUbjhp5bS8N
         iAM9U6yT4ZgRSmfXdJQBFyGOG3n0yFBB+1EM+G7VvRd1O6LegmwHyuOQy93Y0SV6XIwV
         STOp0zEjQkr6bpMgDhg2cQuorkEA3X5+SvkbZh9EiIVnIfUssXGumqNKXFHL2a9x9hzQ
         K0gg==
X-Gm-Message-State: AOJu0Ywt0nhSniEHNMRxa3AFO4T9dENUk9z4G8y8Y0vsXYeY7hrkyR3s
	nW4djc0WIBBpPY6NqNc0bLZFw58Ysyxnlws8MqC5om6ABrIJ4LapVEjHxbbD9niPLkD3dyKIgL4
	bXOI=
X-Google-Smtp-Source: AGHT+IG3jn/AocOtSq4GyyVyV5H33+HkVUS03WIJuC0Lmz8EJuQEZnEXSog7KvUYYYLLu3oGBCNyNQ==
X-Received: by 2002:a05:6e02:1a25:b0:35f:b16d:cd64 with SMTP id g5-20020a056e021a2500b0035fb16dcd64mr107497ile.0.1705680226449;
        Fri, 19 Jan 2024 08:03:46 -0800 (PST)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id bc8-20020a056e02008800b0035fe37a9c09sm5645163ilb.20.2024.01.19.08.03.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 08:03:44 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: bvanassche@acm.org,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 3/4] block/mq-deadline: fallback to per-cpu insertion buckets under contention
Date: Fri, 19 Jan 2024 09:02:08 -0700
Message-ID: <20240119160338.1191281-4-axboe@kernel.dk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240119160338.1191281-1-axboe@kernel.dk>
References: <20240119160338.1191281-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If we attempt to insert a list of requests, but someone else is already
running an insertion, then fallback to queueing that list internally and
let the existing inserter finish the operation. The current inserter
will either see and flush this list, of if it ends before we're done
doing our bucket insert, then we'll flush it and insert ourselves.

This reduces contention on the dd->lock, which protects any request
insertion or dispatch, by having a backup point to insert into which
will either be flushed immediately or by an existing inserter. As the
alternative is to just keep spinning on the dd->lock, it's very easy
to get into a situation where multiple processes are trying to do IO
and all sit and spin on this lock.

With the previous dispatch optimization, this drastically reduces
contention for a sample cases of 32 threads doing IO to devices. The
test case looks as follows:

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

and after this and the previous dispatch patch:

Device		IOPS	sys	contention	diff
====================================================
null_blk	2311K	10.3%	21.1%		+257%
nvme0n1		2610K	11.0%	24.6%		+289%

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/mq-deadline.c | 130 +++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 121 insertions(+), 9 deletions(-)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index b579ce282176..cc3155d50e0d 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -81,8 +81,18 @@ struct dd_per_prio {
 
 enum {
 	DD_DISPATCHING	= 0,
+	DD_INSERTING	= 1,
+	DD_BUCKETS	= 2,
 };
 
+#define DD_CPU_BUCKETS		32
+#define DD_CPU_BUCKETS_MASK	(DD_CPU_BUCKETS - 1)
+
+struct dd_bucket_list {
+	struct list_head list;
+	spinlock_t lock;
+} ____cacheline_aligned_in_smp;
+
 struct deadline_data {
 	/*
 	 * run time data
@@ -94,6 +104,8 @@ struct deadline_data {
 
 	unsigned long run_state;
 
+	struct dd_bucket_list bucket_lists[DD_CPU_BUCKETS];
+
 	struct dd_per_prio per_prio[DD_PRIO_COUNT];
 
 	/* Data direction of latest dispatched request. */
@@ -714,7 +726,7 @@ static int dd_init_sched(struct request_queue *q, struct elevator_type *e)
 	struct deadline_data *dd;
 	struct elevator_queue *eq;
 	enum dd_prio prio;
-	int ret = -ENOMEM;
+	int i, ret = -ENOMEM;
 
 	eq = elevator_alloc(q, e);
 	if (!eq)
@@ -729,6 +741,11 @@ static int dd_init_sched(struct request_queue *q, struct elevator_type *e)
 	spin_lock_init(&dd->lock);
 	spin_lock_init(&dd->zone_lock);
 
+	for (i = 0; i < DD_CPU_BUCKETS; i++) {
+		INIT_LIST_HEAD(&dd->bucket_lists[i].list);
+		spin_lock_init(&dd->bucket_lists[i].lock);
+	}
+
 	for (prio = 0; prio <= DD_PRIO_MAX; prio++) {
 		struct dd_per_prio *per_prio = &dd->per_prio[prio];
 
@@ -878,6 +895,94 @@ static void dd_insert_request(struct request_queue *q, struct request *rq,
 	}
 }
 
+static void dd_dispatch_from_buckets(struct deadline_data *dd,
+				     struct list_head *list)
+{
+	int i;
+
+	if (!test_bit(DD_BUCKETS, &dd->run_state) ||
+	    !test_and_clear_bit(DD_BUCKETS, &dd->run_state))
+		return;
+
+	for (i = 0; i < DD_CPU_BUCKETS; i++) {
+		struct dd_bucket_list *bucket = &dd->bucket_lists[i];
+
+		if (list_empty_careful(&bucket->list))
+			continue;
+		spin_lock(&bucket->lock);
+		list_splice_init(&bucket->list, list);
+		spin_unlock(&bucket->lock);
+	}
+}
+
+/*
+ * If we can grab the dd->lock, then just return and do the insertion as per
+ * usual. If not, add to one of our internal buckets, and afterwards recheck
+ * if if we should retry.
+ */
+static bool dd_insert_to_bucket(struct deadline_data *dd,
+				struct list_head *list)
+	__acquires(&dd->lock)
+{
+	struct dd_bucket_list *bucket;
+
+	/*
+	 * If we can grab the lock, proceed as per usual. If not, and insert
+	 * isn't running, force grab the lock and proceed as per usual.
+	 */
+	if (spin_trylock(&dd->lock))
+		return false;
+	if (!test_bit(DD_INSERTING, &dd->run_state)) {
+		spin_lock(&dd->lock);
+		return false;
+	}
+
+	if (!test_bit(DD_BUCKETS, &dd->run_state))
+		set_bit(DD_BUCKETS, &dd->run_state);
+
+	bucket = &dd->bucket_lists[get_cpu() & DD_CPU_BUCKETS_MASK];
+	spin_lock(&bucket->lock);
+	list_splice_init(list, &bucket->list);
+	spin_unlock(&bucket->lock);
+	put_cpu();
+
+	/*
+	 * Insertion still running, we are done.
+	 */
+	if (test_bit(DD_INSERTING, &dd->run_state))
+		return true;
+
+	/*
+	 * We may be too late, play it safe and grab the lock. This will
+	 * flush the above bucket insert as well and insert it.
+	 */
+	spin_lock(&dd->lock);
+	return false;
+}
+
+static void __dd_insert_requests(struct request_queue *q,
+				 struct deadline_data *dd,
+				 struct list_head *list, blk_insert_t flags,
+				 struct list_head *free)
+{
+	set_bit(DD_INSERTING, &dd->run_state);
+	do {
+		while (!list_empty(list)) {
+			struct request *rq;
+
+			rq = list_first_entry(list, struct request, queuelist);
+			list_del_init(&rq->queuelist);
+			dd_insert_request(q, rq, flags, free);
+		}
+
+		dd_dispatch_from_buckets(dd, list);
+		if (list_empty(list))
+			break;
+	} while (1);
+
+	clear_bit(DD_INSERTING, &dd->run_state);
+}
+
 /*
  * Called from blk_mq_insert_request() or blk_mq_dispatch_plug_list().
  */
@@ -889,16 +994,23 @@ static void dd_insert_requests(struct blk_mq_hw_ctx *hctx,
 	struct deadline_data *dd = q->elevator->elevator_data;
 	LIST_HEAD(free);
 
-	spin_lock(&dd->lock);
-	while (!list_empty(list)) {
-		struct request *rq;
+	/*
+	 * If dispatch is busy and we ended up adding to our internal bucket,
+	 * then we're done for now.
+	 */
+	if (dd_insert_to_bucket(dd, list))
+		return;
 
-		rq = list_first_entry(list, struct request, queuelist);
-		list_del_init(&rq->queuelist);
-		dd_insert_request(q, rq, flags, &free);
-	}
-	spin_unlock(&dd->lock);
+	do {
+		__dd_insert_requests(q, dd, list, flags, &free);
 
+		/*
+		 * If buckets is set after inserting was cleared, be safe and do
+		 * another loop as we could be racing with bucket insertion.
+		 */
+	} while (test_bit(DD_BUCKETS, &dd->run_state));
+
+	spin_unlock(&dd->lock);
 	blk_mq_free_requests(&free);
 }
 
-- 
2.43.0

