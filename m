Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1302D609
	for <linux-block@vger.kernel.org>; Thu, 18 Jan 2024 18:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705601154; cv=none; b=iFJanosd/JIyz9uBoqcp6riNVNPIUmwt2bTdsVsznUPUeai1vY8yH4bVM/j2l/oOZTyZ/ZAjh4t3J9Au1yeg8QYaItyptBSuQEq/ETIow3KFcMTrHQNyktGJLeRmSgBVFVhhl+xPgtbkzQ4sl/CIGH1a+eKmMIIB8hS1qdsaOj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705601154; c=relaxed/simple;
	bh=XLtFh+4fWxIXKoubvDFOyDpiQ8Gh0Mc4F93R33jMV/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tnLV+Fag73yYmdbUmxTt7JtnYDfJCLDQbVRLhF7HZiBCoQnXTBbvCwCwn4FGGHswJLQe+w2XK/KmiCx+M8ceWT8XtIo4yIFWok0kP1uoKn729KxwyBjF4Ruks8dfcNEWVbZtcM9mGMGDII7sl9eprwIvwFkSn6c23pWcBSTwAX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=CGPwfjvt; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="CGPwfjvt"
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-36191ee7be4so3287065ab.0
        for <linux-block@vger.kernel.org>; Thu, 18 Jan 2024 10:05:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1705601151; x=1706205951; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EW0ywMN8IyqUZ7Mc9p1SkRGgoUcTSdaHcbYxrzonAOc=;
        b=CGPwfjvt73bc2EADdljcienissHnQMu8JzmB0SEiIruECHeUdLY6AUT+7RQZYukaFa
         3kVw6kZ5vFbMWsDScrU/7vVoo8Q2/3B+zbydssVLLQfIq8BwR8RQj0lbhLQs7HSuhLhu
         F1r5HIkyS31OyFsTBSwRY/B+qsBTyvPzOHZuGSw8tRP0afGmxGpG3F8QSFfGPn8X0+1d
         h+yUBMORXS92lI1BHXM+rYtlipuw6go3oexNrIcnOSkVO9Yi8gaBjQxH1G6u6AdkMKjU
         ob7mjxjtdp/GFGmeZ0OAx/1dJdJ+Ez9BMRiTAvEIVI5gUKUeh4fFUiT6yDXqO2bQYHk0
         aZnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705601151; x=1706205951;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EW0ywMN8IyqUZ7Mc9p1SkRGgoUcTSdaHcbYxrzonAOc=;
        b=Elo0A2jLpOf0k7bjFH0V9q9hLYgJYX7dO+iZJYm6KKXPo6EODZi2C9+7jN7dVeFosF
         s3RN2mTcmogHQ6AdivNUVdfNdQ2DNAUHATGCVPiue2XMKJvXruJHMttYretWb7TzXJKP
         aJUBd+Isjn7hadZbPC/S7vA2bIp93wFFOqo+Tm5gXxzr4fOoAib7ZwWrx9u1n7p3ykce
         iUTyoZhERX8lKCz3WQhN98lerGEYemaIviJUGk/1OOrRI/yEO3NiYa7iDGbP1K5nKblo
         Zlbm314GYOUX2He2E+EqBeJq8QyrBKskb7Ia50LPlrT+EBc8YQ8n2/skX5zV6sV09ktd
         bf5A==
X-Gm-Message-State: AOJu0YxtUO8ahqEBfFmA4/AwcMz6gMdpk4UnrVGiovoI/qOJSM/4Afar
	vNsLakCXGc+4141aWSW7P8r8oxOShXdc/LSH3n+6Cah4t65Qmq3T4Vhzmq4gRan/Kbudg18AmoY
	ZwXE=
X-Google-Smtp-Source: AGHT+IG/jgKLRweZvUu7L0pt8hUfn+VsBI2YsMseH4fp9pXo5J973t8kYVszGMq/GkIR4XEWQVbjoA==
X-Received: by 2002:a92:cda2:0:b0:35f:fa79:644 with SMTP id g2-20020a92cda2000000b0035ffa790644mr35297ild.3.1705601151492;
        Thu, 18 Jan 2024 10:05:51 -0800 (PST)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id bq7-20020a056e02238700b0036088147a06sm4981873ilb.1.2024.01.18.10.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 10:05:49 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: bvanassche@acm.org,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 2/2] block/mq-deadline: fallback to per-cpu insertion buckets under contention
Date: Thu, 18 Jan 2024 11:04:57 -0700
Message-ID: <20240118180541.930783-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240118180541.930783-1-axboe@kernel.dk>
References: <20240118180541.930783-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If we attempt to insert a list of requests but someone else is already
running an insertion, then fallback to queueing it internally and let
the existing inserter finish the operation.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/mq-deadline.c | 118 +++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 110 insertions(+), 8 deletions(-)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index 9e0ab3ea728a..eeeaaff189e1 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -81,8 +81,17 @@ struct dd_per_prio {
 
 enum {
 	DD_DISPATCHING	= 0,
+	DD_INSERTING	= 1,
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
@@ -94,6 +103,9 @@ struct deadline_data {
 
 	unsigned long run_state;
 
+	atomic_t insert_seq;
+	struct dd_bucket_list bucket_lists[DD_CPU_BUCKETS];
+
 	struct dd_per_prio per_prio[DD_PRIO_COUNT];
 
 	/* Data direction of latest dispatched request. */
@@ -711,7 +723,7 @@ static int dd_init_sched(struct request_queue *q, struct elevator_type *e)
 	struct deadline_data *dd;
 	struct elevator_queue *eq;
 	enum dd_prio prio;
-	int ret = -ENOMEM;
+	int i, ret = -ENOMEM;
 
 	eq = elevator_alloc(q, e);
 	if (!eq)
@@ -725,6 +737,12 @@ static int dd_init_sched(struct request_queue *q, struct elevator_type *e)
 
 	spin_lock_init(&dd->lock);
 	spin_lock_init(&dd->zone_lock);
+	atomic_set(&dd->insert_seq, 0);
+
+	for (i = 0; i < DD_CPU_BUCKETS; i++) {
+		INIT_LIST_HEAD(&dd->bucket_lists[i].list);
+		spin_lock_init(&dd->bucket_lists[i].lock);
+	}
 
 	for (prio = 0; prio <= DD_PRIO_MAX; prio++) {
 		struct dd_per_prio *per_prio = &dd->per_prio[prio];
@@ -876,6 +894,67 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
 	}
 }
 
+static void dd_dispatch_from_buckets(struct deadline_data *dd,
+				     struct list_head *list)
+{
+	int i;
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
+				struct list_head *list, int *seq)
+	__acquires(&dd->lock)
+{
+	struct dd_bucket_list *bucket;
+	int next_seq;
+
+	*seq = atomic_read(&dd->insert_seq);
+
+	if (spin_trylock(&dd->lock))
+		return false;
+	if (!test_bit(DD_INSERTING, &dd->run_state)) {
+		spin_lock(&dd->lock);
+		return false;
+	}
+
+	*seq = atomic_inc_return(&dd->insert_seq);
+
+	bucket = &dd->bucket_lists[get_cpu() & DD_CPU_BUCKETS_MASK];
+	spin_lock(&bucket->lock);
+	list_splice_init(list, &bucket->list);
+	spin_unlock(&bucket->lock);
+	put_cpu();
+
+	/*
+	 * If seq still matches, we should be safe to just exit with the
+	 * pending requests queued in a bucket.
+	 */
+	next_seq = atomic_inc_return(&dd->insert_seq);
+	if (next_seq == *seq + 1)
+		return true;
+
+	/*
+	 * Seq changed, be safe and grab the lock and insert. Don't update
+	 * sequence, so that we flusht the buckets too.
+	 */
+	spin_lock(&dd->lock);
+	return false;
+}
+
 /*
  * Called from blk_mq_insert_request() or blk_mq_dispatch_plug_list().
  */
@@ -886,16 +965,39 @@ static void dd_insert_requests(struct blk_mq_hw_ctx *hctx,
 	struct request_queue *q = hctx->queue;
 	struct deadline_data *dd = q->elevator->elevator_data;
 	LIST_HEAD(free);
+	int seq;
 
-	spin_lock(&dd->lock);
-	while (!list_empty(list)) {
-		struct request *rq;
+	/*
+	 * If dispatch is busy and we ended up adding to our internal bucket,
+	 * then we're done for now.
+	 */
+	if (dd_insert_to_bucket(dd, list, &seq))
+		return;
+
+	set_bit(DD_INSERTING, &dd->run_state);
+	do {
+		int next_seq;
+
+		while (!list_empty(list)) {
+			struct request *rq;
+
+			rq = list_first_entry(list, struct request, queuelist);
+			list_del_init(&rq->queuelist);
+			dd_insert_request(hctx, rq, flags, &free);
+		}
+
+		/*
+		 * If sequence changed, flush internal buckets
+		 */
+		next_seq = atomic_inc_return(&dd->insert_seq);
+		if (next_seq == seq + 1)
+			break;
+		seq = next_seq;
+		dd_dispatch_from_buckets(dd, list);
+	} while (1);
 
-		rq = list_first_entry(list, struct request, queuelist);
-		list_del_init(&rq->queuelist);
-		dd_insert_request(hctx, rq, flags, &free);
-	}
 	spin_unlock(&dd->lock);
+	clear_bit(DD_INSERTING, &dd->run_state);
 
 	blk_mq_free_requests(&free);
 }
-- 
2.43.0

