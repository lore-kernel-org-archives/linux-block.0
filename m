Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD221276046
	for <linux-block@vger.kernel.org>; Sun, 14 Dec 2025 10:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765707259; cv=none; b=llG+vlfKH821fUN/+b9KENlnqI/WsL8YtnzJiXHMvCQrXXyOt5NipvZYD4IRIFsQsErXNq5zuLwj0DgPR1nsYogV+DaoFw2N2bIxnqFG9f0BBxc9HW0VHfn4b/zVGiGZ0PmeqJzPpMLUW9OuEXtXb10WrHoscvSoBsM1YkO6j2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765707259; c=relaxed/simple;
	bh=jywSz3nQaXsHkLrHZbhxJxFFVM3ZBjk5GdMKMFGDkUk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ErqlGWcQ1RISTN79UPrc/N9AtfEA3WUbp3H7tGnI+XUmBw3UHz7QPf8zU8m2Dy/ClFhARvnz80qb3iKxXqnE8Uo6fhbUFZinMOFcnxze+v6YxpI3ygq4bMAI6Faz/X4+MHMLJyXHwkPOvfVyX5VHWGWDl+swKaEAt983t8QDmBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01777C16AAE;
	Sun, 14 Dec 2025 10:14:17 +0000 (UTC)
From: Yu Kuai <yukuai@fnnas.com>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org,
	tj@kernel.org,
	nilay@linux.ibm.com,
	ming.lei@redhat.com
Cc: yukuai@fnnas.com
Subject: [PATCH v5 02/13] blk-wbt: fix possible deadlock to nest pcpu_alloc_mutex under q_usage_counter
Date: Sun, 14 Dec 2025 18:13:57 +0800
Message-ID: <20251214101409.1723751-3-yukuai@fnnas.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251214101409.1723751-1-yukuai@fnnas.com>
References: <20251214101409.1723751-1-yukuai@fnnas.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If wbt is disabled by default and user configures wbt by sysfs, queue
will be frozen first and then pcpu_alloc_mutex will be held in
blk_stat_alloc_callback().

Fix this problem by allocating memory first before queue frozen.

Signed-off-by: Yu Kuai <yukuai@fnnas.com>
---
 block/blk-wbt.c | 106 ++++++++++++++++++++++++++++--------------------
 1 file changed, 61 insertions(+), 45 deletions(-)

diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index ba807649b29a..696baa681717 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -93,7 +93,7 @@ struct rq_wb {
 	struct rq_depth rq_depth;
 };
 
-static int wbt_init(struct gendisk *disk);
+static int wbt_init(struct gendisk *disk, struct rq_wb *rwb);
 
 static inline struct rq_wb *RQWB(struct rq_qos *rqos)
 {
@@ -698,6 +698,41 @@ static void wbt_requeue(struct rq_qos *rqos, struct request *rq)
 	}
 }
 
+static int wbt_data_dir(const struct request *rq)
+{
+	const enum req_op op = req_op(rq);
+
+	if (op == REQ_OP_READ)
+		return READ;
+	else if (op_is_write(op))
+		return WRITE;
+
+	/* don't account */
+	return -1;
+}
+
+static struct rq_wb *wbt_alloc(void)
+{
+	struct rq_wb *rwb = kzalloc(sizeof(*rwb), GFP_KERNEL);
+
+	if (!rwb)
+		return NULL;
+
+	rwb->cb = blk_stat_alloc_callback(wb_timer_fn, wbt_data_dir, 2, rwb);
+	if (!rwb->cb) {
+		kfree(rwb);
+		return NULL;
+	}
+
+	return rwb;
+}
+
+static void wbt_free(struct rq_wb *rwb)
+{
+	blk_stat_free_callback(rwb->cb);
+	kfree(rwb);
+}
+
 /*
  * Enable wbt if defaults are configured that way
  */
@@ -726,8 +761,15 @@ void wbt_enable_default(struct gendisk *disk)
 	if (!blk_queue_registered(q))
 		return;
 
-	if (queue_is_mq(q) && enable)
-		wbt_init(disk);
+	if (queue_is_mq(q) && enable) {
+		struct rq_wb *rwb = wbt_alloc();
+
+		if (WARN_ON_ONCE(!rwb))
+			return;
+
+		if (WARN_ON_ONCE(wbt_init(disk, rwb)))
+			wbt_free(rwb);
+	}
 }
 EXPORT_SYMBOL_GPL(wbt_enable_default);
 
@@ -743,19 +785,6 @@ static u64 wbt_default_latency_nsec(struct request_queue *q)
 		return 75000000ULL;
 }
 
-static int wbt_data_dir(const struct request *rq)
-{
-	const enum req_op op = req_op(rq);
-
-	if (op == REQ_OP_READ)
-		return READ;
-	else if (op_is_write(op))
-		return WRITE;
-
-	/* don't account */
-	return -1;
-}
-
 static void wbt_queue_depth_changed(struct rq_qos *rqos)
 {
 	RQWB(rqos)->rq_depth.queue_depth = blk_queue_depth(rqos->disk->queue);
@@ -767,8 +796,7 @@ static void wbt_exit(struct rq_qos *rqos)
 	struct rq_wb *rwb = RQWB(rqos);
 
 	blk_stat_remove_callback(rqos->disk->queue, rwb->cb);
-	blk_stat_free_callback(rwb->cb);
-	kfree(rwb);
+	wbt_free(rwb);
 }
 
 /*
@@ -892,22 +920,11 @@ static const struct rq_qos_ops wbt_rqos_ops = {
 #endif
 };
 
-static int wbt_init(struct gendisk *disk)
+static int wbt_init(struct gendisk *disk, struct rq_wb *rwb)
 {
 	struct request_queue *q = disk->queue;
-	struct rq_wb *rwb;
-	int i;
 	int ret;
-
-	rwb = kzalloc(sizeof(*rwb), GFP_KERNEL);
-	if (!rwb)
-		return -ENOMEM;
-
-	rwb->cb = blk_stat_alloc_callback(wb_timer_fn, wbt_data_dir, 2, rwb);
-	if (!rwb->cb) {
-		kfree(rwb);
-		return -ENOMEM;
-	}
+	int i;
 
 	for (i = 0; i < WBT_NUM_RWQ; i++)
 		rq_wait_init(&rwb->rq_wait[i]);
@@ -927,38 +944,38 @@ static int wbt_init(struct gendisk *disk)
 	ret = rq_qos_add(&rwb->rqos, disk, RQ_QOS_WBT, &wbt_rqos_ops);
 	mutex_unlock(&q->rq_qos_mutex);
 	if (ret)
-		goto err_free;
+		return ret;
 
 	blk_stat_add_callback(q, rwb->cb);
-
 	return 0;
-
-err_free:
-	blk_stat_free_callback(rwb->cb);
-	kfree(rwb);
-	return ret;
-
 }
 
 int wbt_set_lat(struct gendisk *disk, s64 val)
 {
 	struct request_queue *q = disk->queue;
+	struct rq_qos *rqos = wbt_rq_qos(q);
+	struct rq_wb *rwb = NULL;
 	unsigned int memflags;
-	struct rq_qos *rqos;
 	int ret = 0;
 
+	if (!rqos) {
+		rwb = wbt_alloc();
+		if (!rwb)
+			return -ENOMEM;
+	}
+
 	/*
 	 * Ensure that the queue is idled, in case the latency update
 	 * ends up either enabling or disabling wbt completely. We can't
 	 * have IO inflight if that happens.
 	 */
 	memflags = blk_mq_freeze_queue(q);
-
-	rqos = wbt_rq_qos(q);
 	if (!rqos) {
-		ret = wbt_init(disk);
-		if (ret)
+		ret = wbt_init(disk, rwb);
+		if (ret) {
+			wbt_free(rwb);
 			goto out;
+		}
 	}
 
 	if (val == -1)
@@ -978,6 +995,5 @@ int wbt_set_lat(struct gendisk *disk, s64 val)
 	blk_mq_unquiesce_queue(q);
 out:
 	blk_mq_unfreeze_queue(q, memflags);
-
 	return ret;
 }
-- 
2.51.0

