Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CD22F7AA8
	for <linux-block@vger.kernel.org>; Mon,  1 Dec 2025 08:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764578082; cv=none; b=f3c25ry7Y683a2NySQXtFfhitzAaR3SQeQcXaWTUcBsoPQlqDlXa8cjI9XTq3Oaj3WlfvmBR8X3l/FiLCU5cLNZNMvu0WCeYwSCm9BdPeMIv4Q0X5B3G4JYZ0yW6lDi5X6P0VZLTXaxtnrBeveYYUdzpD4/e6GQ7yWyY7YVfLXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764578082; c=relaxed/simple;
	bh=SkfbwOYDuQJu8LjbLXrT8Vd6eyLW1EGoPCt1Qc/Ebak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=biaArn3QYqqYa7sylvArW03JcukdrwIEDJV2ul78eiSrbQXbnTdz/glKP8Xy8HXwZjFLq7ePkbyszdGkDVG1zvU1tp9CBqWkadjil785t+huY0jNSNINXpOhF2OhDGTKVY4yMnDDmlp647K4iI4ZqqMUHJvvpopwwqyJjVnmI2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4927FC116D0;
	Mon,  1 Dec 2025 08:34:40 +0000 (UTC)
From: Yu Kuai <yukuai@fnnas.com>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org,
	tj@kernel.org,
	nilay@linux.ibm.com,
	ming.lei@redhat.com,
	bvanassche@acm.org
Cc: yukuai@fnnas.com
Subject: [PATCH v4 12/12] block/blk-rq-qos: cleanup rq_qos_add()
Date: Mon,  1 Dec 2025 16:34:15 +0800
Message-ID: <20251201083415.2407888-13-yukuai@fnnas.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251201083415.2407888-1-yukuai@fnnas.com>
References: <20251201083415.2407888-1-yukuai@fnnas.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that there is no caller of rq_qos_add(), remove it, and also rename
rq_qos_add_frozen() back to rq_qos_add().

Signed-off-by: Yu Kuai <yukuai@fnnas.com>
---
 block/blk-iocost.c    |  2 +-
 block/blk-iolatency.c |  4 ++--
 block/blk-rq-qos.c    | 35 ++---------------------------------
 block/blk-rq-qos.h    |  2 --
 block/blk-wbt.c       |  2 +-
 5 files changed, 6 insertions(+), 39 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 929fc1421d7e..0359a5b65202 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -2925,7 +2925,7 @@ static int blk_iocost_init(struct gendisk *disk)
 	 * called before policy activation completion, can't assume that the
 	 * target bio has an iocg associated and need to test for NULL iocg.
 	 */
-	ret = rq_qos_add_frozen(&ioc->rqos, disk, RQ_QOS_COST, &ioc_rqos_ops);
+	ret = rq_qos_add(&ioc->rqos, disk, RQ_QOS_COST, &ioc_rqos_ops);
 	if (ret)
 		goto err_free_ioc;
 
diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
index 1558afbf517b..5b18125e21c9 100644
--- a/block/blk-iolatency.c
+++ b/block/blk-iolatency.c
@@ -764,8 +764,8 @@ static int blk_iolatency_init(struct gendisk *disk)
 	if (!blkiolat)
 		return -ENOMEM;
 
-	ret = rq_qos_add_frozen(&blkiolat->rqos, disk, RQ_QOS_LATENCY,
-				&blkcg_iolatency_ops);
+	ret = rq_qos_add(&blkiolat->rqos, disk, RQ_QOS_LATENCY,
+			 &blkcg_iolatency_ops);
 	if (ret)
 		goto err_free;
 	ret = blkcg_activate_policy(disk, &blkcg_policy_iolatency);
diff --git a/block/blk-rq-qos.c b/block/blk-rq-qos.c
index c1a94c2a9742..8de7dae3273e 100644
--- a/block/blk-rq-qos.c
+++ b/block/blk-rq-qos.c
@@ -322,8 +322,8 @@ void rq_qos_exit(struct request_queue *q)
 	mutex_unlock(&q->rq_qos_mutex);
 }
 
-int rq_qos_add_frozen(struct rq_qos *rqos, struct gendisk *disk,
-		      enum rq_qos_id id, const struct rq_qos_ops *ops)
+int rq_qos_add(struct rq_qos *rqos, struct gendisk *disk, enum rq_qos_id id,
+	       const struct rq_qos_ops *ops)
 {
 	struct request_queue *q = disk->queue;
 
@@ -343,37 +343,6 @@ int rq_qos_add_frozen(struct rq_qos *rqos, struct gendisk *disk,
 	return 0;
 }
 
-int rq_qos_add(struct rq_qos *rqos, struct gendisk *disk, enum rq_qos_id id,
-		const struct rq_qos_ops *ops)
-{
-	struct request_queue *q = disk->queue;
-	unsigned int memflags;
-
-	lockdep_assert_held(&q->rq_qos_mutex);
-
-	rqos->disk = disk;
-	rqos->id = id;
-	rqos->ops = ops;
-
-	/*
-	 * No IO can be in-flight when adding rqos, so freeze queue, which
-	 * is fine since we only support rq_qos for blk-mq queue.
-	 */
-	memflags = blk_mq_freeze_queue(q);
-
-	if (rq_qos_id(q, rqos->id))
-		goto ebusy;
-	rqos->next = q->rq_qos;
-	q->rq_qos = rqos;
-	blk_queue_flag_set(QUEUE_FLAG_QOS_ENABLED, q);
-
-	blk_mq_unfreeze_queue(q, memflags);
-	return 0;
-ebusy:
-	blk_mq_unfreeze_queue(q, memflags);
-	return -EBUSY;
-}
-
 void rq_qos_del(struct rq_qos *rqos)
 {
 	struct request_queue *q = rqos->disk->queue;
diff --git a/block/blk-rq-qos.h b/block/blk-rq-qos.h
index 8d9fb10ae526..b538f2c0febc 100644
--- a/block/blk-rq-qos.h
+++ b/block/blk-rq-qos.h
@@ -87,8 +87,6 @@ static inline void rq_wait_init(struct rq_wait *rq_wait)
 
 int rq_qos_add(struct rq_qos *rqos, struct gendisk *disk, enum rq_qos_id id,
 		const struct rq_qos_ops *ops);
-int rq_qos_add_frozen(struct rq_qos *rqos, struct gendisk *disk,
-		      enum rq_qos_id id, const struct rq_qos_ops *ops);
 void rq_qos_del(struct rq_qos *rqos);
 
 typedef bool (acquire_inflight_cb_t)(struct rq_wait *rqw, void *private_data);
diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index e035331a800f..25cb8ab7d647 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -947,7 +947,7 @@ static int wbt_init(struct gendisk *disk, struct rq_wb *rwb)
 	 * Assign rwb and add the stats callback.
 	 */
 	mutex_lock(&q->rq_qos_mutex);
-	ret = rq_qos_add_frozen(&rwb->rqos, disk, RQ_QOS_WBT, &wbt_rqos_ops);
+	ret = rq_qos_add(&rwb->rqos, disk, RQ_QOS_WBT, &wbt_rqos_ops);
 	mutex_unlock(&q->rq_qos_mutex);
 	if (ret)
 		goto err_free;
-- 
2.51.0

