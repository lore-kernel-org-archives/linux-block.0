Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399B4296BBD;
	Fri, 21 Nov 2025 05:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763702955; cv=none; b=WkCtLILSMKIhTRzAACoqoIVbIUaw0z7G1Fx2x2MDNfzvzqHkRz0w3bLdyYNLj0u8z2WFH7Pj9odmPIP576VTjnC8NCI7xg7g0eO0vjJ3jygW5BcTjMBloedsIKYTKTj3zYIDDwRYHAiFbcYxFpFO8w0UD/ZiZdQDACeqz1kLgak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763702955; c=relaxed/simple;
	bh=N+a3FwIQ5mSv51OIK5gStmnCljmasX2MsHpVoRqxvm0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=agKnuoB/pmrE6PvNaZjDscrPrOWeaU9ORtqMcPd4Wlb7WlpLqAv3CdbczeErl7vG2ap8HV438xmoF2TYNfp8l6VzHsAHp2fEMKhtynVPfYJLdK0hgzF4GA8ZkcquSAJDcX6EFMdo4T+7MmysMIWfxLEo5H6OJ2gmcaZlKiEvGo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0A6AC116D0;
	Fri, 21 Nov 2025 05:29:12 +0000 (UTC)
From: Yu Kuai <yukuai@fnnas.com>
To: axboe@kernel.dk,
	nilay@linux.ibm.com,
	bvanassche@acm.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: yukuai@fnnas.com
Subject: [PATCH v6 4/8] blk-mq: add a new queue sysfs attribute async_depth
Date: Fri, 21 Nov 2025 13:28:51 +0800
Message-ID: <20251121052901.1341976-5-yukuai@fnnas.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251121052901.1341976-1-yukuai@fnnas.com>
References: <20251121052901.1341976-1-yukuai@fnnas.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new field async_depth to request_queue and related APIs, this is
currently not used, following patches will convert elevators to use
this instead of internal async_depth.

Signed-off-by: Yu Kuai <yukuai@fnnas.com>
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
---
 block/blk-core.c       |  1 +
 block/blk-mq.c         |  6 ++++++
 block/blk-sysfs.c      | 42 ++++++++++++++++++++++++++++++++++++++++++
 block/elevator.c       |  1 +
 include/linux/blkdev.h |  1 +
 5 files changed, 51 insertions(+)

diff --git a/block/blk-core.c b/block/blk-core.c
index 14ae73eebe0d..cc5c9ced8e6f 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -463,6 +463,7 @@ struct request_queue *blk_alloc_queue(struct queue_limits *lim, int node_id)
 	fs_reclaim_release(GFP_KERNEL);
 
 	q->nr_requests = BLKDEV_DEFAULT_RQ;
+	q->async_depth = BLKDEV_DEFAULT_RQ;
 
 	return q;
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 6c505ebfab65..ae6ce68f4786 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4628,6 +4628,7 @@ int blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 	spin_lock_init(&q->requeue_lock);
 
 	q->nr_requests = set->queue_depth;
+	q->async_depth = set->queue_depth;
 
 	blk_mq_init_cpu_queues(q, set->nr_hw_queues);
 	blk_mq_map_swqueue(q);
@@ -4994,6 +4995,11 @@ struct elevator_tags *blk_mq_update_nr_requests(struct request_queue *q,
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
index 8684c57498cc..5c2d29ac6570 100644
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
@@ -532,6 +572,7 @@ static struct queue_sysfs_entry _prefix##_entry = {	\
 }
 
 QUEUE_RW_ENTRY(queue_requests, "nr_requests");
+QUEUE_RW_ENTRY(queue_async_depth, "async_depth");
 QUEUE_RW_ENTRY(queue_ra, "read_ahead_kb");
 QUEUE_LIM_RW_ENTRY(queue_max_sectors, "max_sectors_kb");
 QUEUE_LIM_RO_ENTRY(queue_max_hw_sectors, "max_hw_sectors_kb");
@@ -754,6 +795,7 @@ static struct attribute *blk_mq_queue_attrs[] = {
 	 */
 	&elv_iosched_entry.attr,
 	&queue_requests_entry.attr,
+	&queue_async_depth_entry.attr,
 #ifdef CONFIG_BLK_WBT
 	&queue_wb_lat_entry.attr,
 #endif
diff --git a/block/elevator.c b/block/elevator.c
index 5b37ef44f52d..5ff21075a84a 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -589,6 +589,7 @@ static int elevator_switch(struct request_queue *q, struct elv_change_ctx *ctx)
 		blk_queue_flag_clear(QUEUE_FLAG_SQ_SCHED, q);
 		q->elevator = NULL;
 		q->nr_requests = q->tag_set->queue_depth;
+		q->async_depth = q->tag_set->queue_depth;
 	}
 	blk_add_trace_msg(q, "elv switch: %s", ctx->name);
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index cdc68c41fa96..edddf17f8304 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -552,6 +552,7 @@ struct request_queue {
 	 * queue settings
 	 */
 	unsigned int		nr_requests;	/* Max # of requests */
+	unsigned int		async_depth;	/* Max # of async requests */
 
 #ifdef CONFIG_BLK_INLINE_ENCRYPTION
 	struct blk_crypto_profile *crypto_profile;
-- 
2.51.0

