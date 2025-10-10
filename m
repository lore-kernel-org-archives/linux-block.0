Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06CED239E75;
	Fri, 10 Oct 2025 02:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760063310; cv=none; b=N/8LVQHXqXDGur2FvX+58LZJfGYRWGK49AGSrvznpSgr0mGkmnCkax56MYP3LSk9ez4RMQNL+vsFsM9C8VCxFFP6NhBPPin7nEzSc/IdPui2r1Y0knESimKnAPDIhWQp8wbSqEukXrjZcMfCXtL6C3sKbfAjCLO0MwIBSif9pCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760063310; c=relaxed/simple;
	bh=APAI+hF//ptD6OlrXToB8nH7awX2OzL6LZOrayJYBKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EI2JjHDMA0YlLfiUwnSt2GX/fW+3pJErzbv9T6qIOgPw/uNLaWYMcorJqUHq3xrBh8EcrgUEglWXGNzzolVWqAZNvYSNFHJiQYjDNDLJmVKMtNrLu/Th9U/BRsTDrwddIl5WLWARbYh4Zo9htOr8z77nPMAAlOzkvBoq0zTj8z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fY8RhBve; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fY8RhBve"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1D8DC4CEF7;
	Fri, 10 Oct 2025 02:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760063309;
	bh=APAI+hF//ptD6OlrXToB8nH7awX2OzL6LZOrayJYBKQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fY8RhBvegqabJJzbUGHp771pHbti7dSl5BcCECxCx6Uf/6tYT607K4M5/bd64C67a
	 bT6EadH+lMibQYyRvkYNoab1cwNZoSDYl0+Tu3J1eT75QLjDD7r08jdG/em/kM0MY+
	 rndxUaKpiNmUspnE3j6fxSoFuOabCkvDjBWay3ElOSR0eLd1gqBU9nuXUopnNky/s8
	 m5TMMjxuJDGWyZkLVdcuEyiARCiNCGTiUO29AsbrjnOxh3MRCEJqB2Gm9n79rYGqfD
	 FqybQJYvtZ3Zefvr23HCW7qb2jismNmIZCCPACWFLsTEgMyBm2ap84gAlyuPVszvpA
	 Bnxc5UGN0K2Pg==
From: Yu Kuai <yukuai@kernel.org>
To: axboe@kernel.dk,
	bvanassche@acm.org,
	nilay@linux.ibm.com
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai3@huawei.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	johnny.chenyi@huawei.com
Subject: [PATCH v3 3/7] blk-mq: add a new queue sysfs attribute async_depth
Date: Fri, 10 Oct 2025 10:28:05 +0800
Message-ID: <20251010022812.2985286-4-yukuai@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010022812.2985286-1-yukuai@kernel.org>
References: <20251010022812.2985286-1-yukuai@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yu Kuai <yukuai3@huawei.com>

Add a new field async_depth to request_queue and related APIs, this is
currently not used, following patches will convert elevators to use
this instead of internal async_depth.

Also factor out a helper blk_mq_limit_depth() to make code cleaner.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-core.c       |  1 +
 block/blk-mq.c         | 64 +++++++++++++++++++++++++-----------------
 block/blk-sysfs.c      | 42 +++++++++++++++++++++++++++
 block/elevator.c       |  1 +
 include/linux/blkdev.h |  1 +
 5 files changed, 84 insertions(+), 25 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index dd39ff651095..76df70cfc103 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -463,6 +463,7 @@ struct request_queue *blk_alloc_queue(struct queue_limits *lim, int node_id)
 	fs_reclaim_release(GFP_KERNEL);
 
 	q->nr_requests = BLKDEV_DEFAULT_RQ;
+	q->async_depth = BLKDEV_DEFAULT_RQ;
 
 	return q;
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 09f579414161..16b335723610 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -491,6 +491,38 @@ __blk_mq_alloc_requests_batch(struct blk_mq_alloc_data *data)
 	return rq_list_pop(data->cached_rqs);
 }
 
+static void blk_mq_limit_depth(struct blk_mq_alloc_data *data)
+{
+	struct elevator_mq_ops *ops;
+
+	/* If elevator is none, don't limit requests */
+	if (!data->q->elevator) {
+		blk_mq_tag_busy(data->hctx);
+		return;
+	}
+
+	data->rq_flags |= RQF_SCHED_TAGS;
+
+	/*
+	 * Flush/passthrough requests are special and go directly to the
+	 * dispatch list, they don't have limit.
+	 */
+	if ((data->cmd_flags & REQ_OP_MASK) == REQ_OP_FLUSH ||
+	    blk_op_is_passthrough(data->cmd_flags))
+		return;
+
+	WARN_ON_ONCE(data->flags & BLK_MQ_REQ_RESERVED);
+	data->rq_flags |= RQF_USE_SCHED;
+
+	/*
+	 * By default, sync requests have no limit, and async requests is
+	 * limited to async_depth.
+	 */
+	ops = &data->q->elevator->type->ops;
+	if (ops->limit_depth)
+		ops->limit_depth(data->cmd_flags, data);
+}
+
 static struct request *__blk_mq_alloc_requests(struct blk_mq_alloc_data *data)
 {
 	struct request_queue *q = data->q;
@@ -509,31 +541,7 @@ static struct request *__blk_mq_alloc_requests(struct blk_mq_alloc_data *data)
 	data->ctx = blk_mq_get_ctx(q);
 	data->hctx = blk_mq_map_queue(data->cmd_flags, data->ctx);
 
-	if (q->elevator) {
-		/*
-		 * All requests use scheduler tags when an I/O scheduler is
-		 * enabled for the queue.
-		 */
-		data->rq_flags |= RQF_SCHED_TAGS;
-
-		/*
-		 * Flush/passthrough requests are special and go directly to the
-		 * dispatch list.
-		 */
-		if ((data->cmd_flags & REQ_OP_MASK) != REQ_OP_FLUSH &&
-		    !blk_op_is_passthrough(data->cmd_flags)) {
-			struct elevator_mq_ops *ops = &q->elevator->type->ops;
-
-			WARN_ON_ONCE(data->flags & BLK_MQ_REQ_RESERVED);
-
-			data->rq_flags |= RQF_USE_SCHED;
-			if (ops->limit_depth)
-				ops->limit_depth(data->cmd_flags, data);
-		}
-	} else {
-		blk_mq_tag_busy(data->hctx);
-	}
-
+	blk_mq_limit_depth(data);
 	if (data->flags & BLK_MQ_REQ_RESERVED)
 		data->rq_flags |= RQF_RESV;
 
@@ -4605,6 +4613,7 @@ int blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 	spin_lock_init(&q->requeue_lock);
 
 	q->nr_requests = set->queue_depth;
+	q->async_depth = set->queue_depth;
 
 	blk_mq_init_cpu_queues(q, set->nr_hw_queues);
 	blk_mq_map_swqueue(q);
@@ -4971,6 +4980,11 @@ struct elevator_tags *blk_mq_update_nr_requests(struct request_queue *q,
 		q->elevator->et = et;
 	}
 
+	/*
+	 * Preserve relative value, both nr and async_depth are at most 16 bit
+	 * value, no need to worry about overflow.
+	 */
+	q->async_depth = max(q->async_depth * nr / q->nr_requests, 1);
 	q->nr_requests = nr;
 	if (q->elevator && q->elevator->type->ops.depth_updated)
 		q->elevator->type->ops.depth_updated(q);
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 76c47fe9b8d6..18ef3bbb34e3 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -127,6 +127,46 @@ queue_requests_store(struct gendisk *disk, const char *page, size_t count)
 	return ret;
 }
 
+static ssize_t queue_async_depth_show(struct gendisk *disk, char *page)
+{
+	guard(mutex)(&disk->queue->elevator_lock);
+
+	return queue_var_show(disk->queue->async_depth, page);
+}
+
+static ssize_t
+queue_async_depth_store(struct gendisk *disk, const char *page, size_t count)
+{
+	struct request_queue *q = disk->queue;
+	unsigned int memflags;
+	unsigned long nr;
+	int ret;
+
+	if (!queue_is_mq(q))
+		return -EINVAL;
+
+	ret = queue_var_store(&nr, page, count);
+	if (ret < 0)
+		return ret;
+
+	if (nr == 0)
+		return -EINVAL;
+
+	memflags = blk_mq_freeze_queue(q);
+	scoped_guard(mutex, &q->elevator_lock) {
+		if (q->elevator) {
+			q->async_depth = min(q->nr_requests, nr);
+			if (q->elevator->type->ops.depth_updated)
+				q->elevator->type->ops.depth_updated(q);
+		} else {
+			ret = -EINVAL;
+		}
+	}
+	blk_mq_unfreeze_queue(q, memflags);
+
+	return ret;
+}
+
 static ssize_t queue_ra_show(struct gendisk *disk, char *page)
 {
 	ssize_t ret;
@@ -542,6 +582,7 @@ static struct queue_sysfs_entry _prefix##_entry = {	\
 }
 
 QUEUE_RW_ENTRY(queue_requests, "nr_requests");
+QUEUE_RW_ENTRY(queue_async_depth, "async_depth");
 QUEUE_RW_ENTRY(queue_ra, "read_ahead_kb");
 QUEUE_LIM_RW_ENTRY(queue_max_sectors, "max_sectors_kb");
 QUEUE_LIM_RO_ENTRY(queue_max_hw_sectors, "max_hw_sectors_kb");
@@ -764,6 +805,7 @@ static struct attribute *blk_mq_queue_attrs[] = {
 	 */
 	&elv_iosched_entry.attr,
 	&queue_requests_entry.attr,
+	&queue_async_depth_entry.attr,
 #ifdef CONFIG_BLK_WBT
 	&queue_wb_lat_entry.attr,
 #endif
diff --git a/block/elevator.c b/block/elevator.c
index e2ebfbf107b3..8f510cb881ba 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -601,6 +601,7 @@ static int elevator_switch(struct request_queue *q, struct elv_change_ctx *ctx)
 		blk_queue_flag_clear(QUEUE_FLAG_SQ_SCHED, q);
 		q->elevator = NULL;
 		q->nr_requests = q->tag_set->queue_depth;
+		q->async_depth = q->tag_set->queue_depth;
 	}
 	blk_add_trace_msg(q, "elv switch: %s", ctx->name);
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 02c006fb94c5..1d470ac71c64 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -542,6 +542,7 @@ struct request_queue {
 	 * queue settings
 	 */
 	unsigned int		nr_requests;	/* Max # of requests */
+	unsigned int		async_depth;	/* Max # of async requests */
 
 #ifdef CONFIG_BLK_INLINE_ENCRYPTION
 	struct blk_crypto_profile *crypto_profile;
-- 
2.51.0

