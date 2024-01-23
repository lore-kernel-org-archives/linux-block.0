Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECAE5811EC
	for <linux-block@vger.kernel.org>; Tue, 23 Jan 2024 17:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706031640; cv=none; b=jvEs7BxkbKMKxoPYanbKfP5WY8jVZzFHiaAvjzONms5DZEZXCsH9KKJ7N2y50anybLkNlAvVjCHlsLoLCHm2Jr7WIAmYznSL1tasgkQkj+GO4+mmxuOZB118sef8nbJbL1nDl/jF2hZThc4wiijWCahuOnrbxUkAT/B+2ze1UXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706031640; c=relaxed/simple;
	bh=KnWGHMmacZniTWp9tv0oQ44d65rhPNIr9+G1kWjEXEU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=okj9wsLZjkikXcMtVUMe60lRwiXNr1UJSmnDniu/Sjwz2CdWdleGS/GjsXUwcNFMcxPTAraCCUfFf2ugMENt5J+XYkBAlXKRWEeD7PQSV/Ow+W7f88rpSXu65JpfZjNl/LiWv0s/BFI9EbOVS/0SW+raOg+bcbvtlHE5koyAndA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=VjLJtHFq; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="VjLJtHFq"
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7beeeb1ba87so61745939f.0
        for <linux-block@vger.kernel.org>; Tue, 23 Jan 2024 09:40:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1706031637; x=1706636437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7j1Y7sJYWn7DCvoraweTkCWNWnVnygffY6V8hmKwE+o=;
        b=VjLJtHFq5CQiGfCkcxn5dmfPyQEDIg38Hu61iPI/MAIuz0MvT0V387uEGwhWyVTvEF
         +KOtklZMZYTb6Z4d5pm1E0s8ItT2ykImKsLDST8Z82TMGFctoT5wh9tev2xiZGllHmcQ
         Vr9YcN7bR74gRnW0Ee7XwNyczuFwu6pxV3kcRTXYTEDoTw3xEo13iekkP4DQxA3dNM6U
         ehLSB5OfJhZ77yOkSlO8XzURyCPjmT+hhGujqSRI4FnpkuPOgkQFvesg6w+YlExPk6Px
         y6AxtJUO6LKgZhs2mV0J9iMJWoCdQu7P9NJkfkdbbJP82ipx9LptwdZv+b9UDn5oCTfI
         7ECg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706031637; x=1706636437;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7j1Y7sJYWn7DCvoraweTkCWNWnVnygffY6V8hmKwE+o=;
        b=uTpvk6B01UCEplgJ1GtLEuDoZ7rUb5QjYEYEJnmw5VC/FFlkpyeTL/pGGsSKY7JQNA
         xJKjg8fJPDwqTboLrKTnqzdErPsNpMlAkdDDOslmTYPKYEhOOwhehbecaeejRMA0YdkT
         tOc9uRWeEeSRle1G9/oPRFP44m37+CNh9WO23NZ7aSL42S620SQdI4NwcT2rndaTPBGO
         hCjXdKTvRyZqGKUwr78ZiMuKlRvOfMysfsvy+IPNyPACf60mapxVA6YNIHGdEUtIRChn
         LZyUnTZ40NpF1VmJbenfsIHIy344lWm47OfCpYNCmrM3p7c/f2/kv+EsxiiXZCMIvS/h
         n1sQ==
X-Gm-Message-State: AOJu0YyjvSlZxhWZQBuIGC2FdickaENrgvqvpQrO3B3jHDVNNSu7T9IM
	CTMV0+y3u/NHLvS+kRnFXJcs1ZkY/GSB1lBbqurS0nE64FEg4fr6L678/uAPLzPuYXC78FEMnMR
	SDCM=
X-Google-Smtp-Source: AGHT+IHYZHy/EwBSLYqzI5TS06nzAFHB5QyfsbaL2tfvs+h9qPZOzfTiozr52kzBTQVo7h6QUAzuwg==
X-Received: by 2002:a5d:8942:0:b0:7bf:3651:4c6d with SMTP id b2-20020a5d8942000000b007bf36514c6dmr10358314iot.2.1706031637621;
        Tue, 23 Jan 2024 09:40:37 -0800 (PST)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id l15-20020a6b700f000000b007bf4b9fa2e6sm4647700ioc.47.2024.01.23.09.40.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 09:40:36 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 8/8] block/bfq: use separate insertion lists
Date: Tue, 23 Jan 2024 10:34:20 -0700
Message-ID: <20240123174021.1967461-9-axboe@kernel.dk>
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

Based on the similar patch for mq-deadline, this uses separate
insertion lists so we can defer touching dd->lock until dispatch
time.

This improves the following fio workload:

fio --bs=512 --group_reporting=1 --gtod_reduce=1 --invalidate=1 \
        --ioengine=io_uring --norandommap --runtime=60 --rw=randread \
        --thread --time_based=1 --buffered=0 --fixedbufs=1 --numjobs=32 \
        --iodepth=4 --iodepth_batch_submit=4 --iodepth_batch_complete=4 \
        --name=/dev/nvme0n1 --filename=/dev/nvme0n1

from:

/dev/nvme0n1: (groupid=0, jobs=32): err= 0: pid=1113: Fri Jan 19 20:59:26 2024
  read: IOPS=567k, BW=277MiB/s (290MB/s)(1820MiB/6575msec)
   bw (  KiB/s): min=274824, max=291156, per=100.00%, avg=283930.08, stdev=143.01, samples=416
   iops        : min=549648, max=582312, avg=567860.31, stdev=286.01, samples=416
  cpu          : usr=0.18%, sys=86.04%, ctx=866079, majf=0, minf=0
  IO depths    : 1=0.0%, 2=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=3728344,0,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=4

with 96% lock contention and 86% sys time, to:

/dev/nvme0n1: (groupid=0, jobs=32): err= 0: pid=8922: Sat Jan 20 11:16:20 2024
  read: IOPS=1550k, BW=757MiB/s (794MB/s)(19.6GiB/26471msec)
   bw (  KiB/s): min=754668, max=848896, per=100.00%, avg=775459.33, stdev=624.43, samples=1664
   iops        : min=1509336, max=1697793, avg=1550918.83, stdev=1248.87, samples=1664
  cpu          : usr=1.34%, sys=14.49%, ctx=9950560, majf=0, minf=0
  IO depths    : 1=0.0%, 2=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=41042924,0,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=4

with ~30% lock contention and 14.5% sys time, by applying the lessons
learnt with scaling mq-deadline. Patch needs to be split, but it:

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/bfq-iosched.c | 70 ++++++++++++++++++++++++++++++++++-----------
 block/bfq-iosched.h |  4 +++
 2 files changed, 58 insertions(+), 16 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index ea16a0c53082..9bd57baa4b0b 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -5174,6 +5174,10 @@ static bool bfq_has_work(struct blk_mq_hw_ctx *hctx)
 {
 	struct bfq_data *bfqd = hctx->queue->elevator->elevator_data;
 
+	if (!list_empty_careful(&bfqd->at_head) ||
+	    !list_empty_careful(&bfqd->at_tail))
+		return true;
+
 	/*
 	 * Avoiding lock: a race on bfqd->queued should cause at
 	 * most a call to dispatch for nothing
@@ -5323,12 +5327,44 @@ static inline void bfq_update_dispatch_stats(struct request_queue *q,
 					     bool idle_timer_disabled) {}
 #endif /* CONFIG_BFQ_CGROUP_DEBUG */
 
+static void bfq_insert_request(struct request_queue *q, struct request *rq,
+			       blk_insert_t flags, struct list_head *free);
+
+static void __bfq_do_insert(struct request_queue *q, blk_insert_t flags,
+			    struct list_head *list, struct list_head *free)
+{
+	while (!list_empty(list)) {
+		struct request *rq;
+
+		rq = list_first_entry(list, struct request, queuelist);
+		list_del_init(&rq->queuelist);
+		bfq_insert_request(q, rq, flags, free);
+	}
+}
+
+static void bfq_do_insert(struct request_queue *q, struct list_head *free)
+{
+	struct bfq_data *bfqd = q->elevator->elevator_data;
+	LIST_HEAD(at_head);
+	LIST_HEAD(at_tail);
+
+	spin_lock(&bfqd->insert_lock);
+	list_splice_init(&bfqd->at_head, &at_head);
+	list_splice_init(&bfqd->at_tail, &at_tail);
+	spin_unlock(&bfqd->insert_lock);
+
+	__bfq_do_insert(q, BLK_MQ_INSERT_AT_HEAD, &at_head, free);
+	__bfq_do_insert(q, 0, &at_tail, free);
+}
+
 static struct request *bfq_dispatch_request(struct blk_mq_hw_ctx *hctx)
 {
-	struct bfq_data *bfqd = hctx->queue->elevator->elevator_data;
+	struct request_queue *q = hctx->queue;
+	struct bfq_data *bfqd = q->elevator->elevator_data;
 	struct request *rq;
 	struct bfq_queue *in_serv_queue;
 	bool waiting_rq, idle_timer_disabled = false;
+	LIST_HEAD(free);
 
 	/*
 	 * If someone else is already dispatching, skip this one. This will
@@ -5344,6 +5380,8 @@ static struct request *bfq_dispatch_request(struct blk_mq_hw_ctx *hctx)
 
 	spin_lock_irq(&bfqd->lock);
 
+	bfq_do_insert(hctx->queue, &free);
+
 	in_serv_queue = bfqd->in_service_queue;
 	waiting_rq = in_serv_queue && bfq_bfqq_wait_request(in_serv_queue);
 
@@ -5355,6 +5393,7 @@ static struct request *bfq_dispatch_request(struct blk_mq_hw_ctx *hctx)
 
 	clear_bit_unlock(BFQ_DISPATCHING, &bfqd->run_state);
 	spin_unlock_irq(&bfqd->lock);
+	blk_mq_free_requests(&free);
 	bfq_update_dispatch_stats(hctx->queue, rq,
 			idle_timer_disabled ? in_serv_queue : NULL,
 				idle_timer_disabled);
@@ -6276,25 +6315,20 @@ static inline void bfq_update_insert_stats(struct request_queue *q,
 static struct bfq_queue *bfq_init_rq(struct request *rq);
 
 static void bfq_insert_request(struct request_queue *q, struct request *rq,
-			       blk_insert_t flags)
+			       blk_insert_t flags, struct list_head *free)
 {
 	struct bfq_data *bfqd = q->elevator->elevator_data;
 	struct bfq_queue *bfqq;
 	bool idle_timer_disabled = false;
 	blk_opf_t cmd_flags;
-	LIST_HEAD(free);
 
 #ifdef CONFIG_BFQ_GROUP_IOSCHED
 	if (!cgroup_subsys_on_dfl(io_cgrp_subsys) && rq->bio)
 		bfqg_stats_update_legacy_io(q, rq);
 #endif
-	spin_lock_irq(&bfqd->lock);
 	bfqq = bfq_init_rq(rq);
-	if (blk_mq_sched_try_insert_merge(q, rq, &free)) {
-		spin_unlock_irq(&bfqd->lock);
-		blk_mq_free_requests(&free);
+	if (blk_mq_sched_try_insert_merge(q, rq, free))
 		return;
-	}
 
 	trace_block_rq_insert(rq);
 
@@ -6324,8 +6358,6 @@ static void bfq_insert_request(struct request_queue *q, struct request *rq,
 	 * merge).
 	 */
 	cmd_flags = rq->cmd_flags;
-	spin_unlock_irq(&bfqd->lock);
-
 	bfq_update_insert_stats(q, bfqq, idle_timer_disabled,
 				cmd_flags);
 }
@@ -6334,13 +6366,15 @@ static void bfq_insert_requests(struct blk_mq_hw_ctx *hctx,
 				struct list_head *list,
 				blk_insert_t flags)
 {
-	while (!list_empty(list)) {
-		struct request *rq;
+	struct request_queue *q = hctx->queue;
+	struct bfq_data *bfqd = q->elevator->elevator_data;
 
-		rq = list_first_entry(list, struct request, queuelist);
-		list_del_init(&rq->queuelist);
-		bfq_insert_request(hctx->queue, rq, flags);
-	}
+	spin_lock_irq(&bfqd->insert_lock);
+	if (flags & BLK_MQ_INSERT_AT_HEAD)
+		list_splice_init(list, &bfqd->at_head);
+	else
+		list_splice_init(list, &bfqd->at_tail);
+	spin_unlock_irq(&bfqd->insert_lock);
 }
 
 static void bfq_update_hw_tag(struct bfq_data *bfqd)
@@ -7250,6 +7284,10 @@ static int bfq_init_queue(struct request_queue *q, struct elevator_type *e)
 	spin_unlock_irq(&q->queue_lock);
 
 	spin_lock_init(&bfqd->lock);
+	spin_lock_init(&bfqd->insert_lock);
+
+	INIT_LIST_HEAD(&bfqd->at_head);
+	INIT_LIST_HEAD(&bfqd->at_tail);
 
 	/*
 	 * Our fallback bfqq if bfq_find_alloc_queue() runs into OOM issues.
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index 56ff69f22163..f44f5d4ec2f4 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -516,10 +516,14 @@ enum {
 struct bfq_data {
 	struct {
 		spinlock_t lock;
+		spinlock_t insert_lock;
 	} ____cacheline_aligned_in_smp;
 
 	unsigned long run_state;
 
+	struct list_head at_head;
+	struct list_head at_tail;
+
 	/* device request queue */
 	struct request_queue *queue;
 	/* dispatch queue */
-- 
2.43.0

