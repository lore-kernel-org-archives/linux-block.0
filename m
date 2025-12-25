Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB7423D7FC
	for <linux-block@vger.kernel.org>; Thu, 25 Dec 2025 10:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766658807; cv=none; b=atyFwTlYxiKTIkKZ129uDTOm8u3O+LCyxMEPIpDGvMjnczzWAN4r0KI1buH9j1h7r6sq1lf/GaDfg+lh/zXdb7Y2zpwOqP/E5pyEtSR6Y92unzal9X2a6KOmtQIpVX6MUWZoDJmzo1Km6hIAvMovNJ5Bk70c+EfrnIGPEtPsUMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766658807; c=relaxed/simple;
	bh=TVao6Gz8mANoHsKQbiQEy9kW/DIKrrv25bUL2FrooyM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m81EIS6pfHMSK2QiTLp02dRTjW8TX8j1qoyxbjiDWrvn3AZ3jB0+mwt7TBO8FIGg9iExsaWRseliIsyn5U0SV45BzIHepoMeQe85K77fUnP9PDPfik0xD3lcQ/QEZ8LaIHwg1a8c1OZPIqC8UOPS+b/ByNumtx5jTL3Wk0Awd0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4F2AC4CEFB;
	Thu, 25 Dec 2025 10:33:24 +0000 (UTC)
From: Yu Kuai <yukuai@fnnas.com>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org,
	tj@kernel.org,
	nilay@linux.ibm.com,
	ming.lei@redhat.com
Cc: yukuai@fnnas.com
Subject: [PATCH v6 13/13] block/blk-rq-qos: cleanup rq_qos_add()
Date: Thu, 25 Dec 2025 18:32:48 +0800
Message-ID: <20251225103248.1303397-14-yukuai@fnnas.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251225103248.1303397-1-yukuai@fnnas.com>
References: <20251225103248.1303397-1-yukuai@fnnas.com>
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
index b8f163827477..20d8e53f063e 100644
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
index ed8231b6b6e9..7c3e0d324ab9 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -966,7 +966,7 @@ static int wbt_init(struct gendisk *disk, struct rq_wb *rwb)
 	 * Assign rwb and add the stats callback.
 	 */
 	mutex_lock(&q->rq_qos_mutex);
-	ret = rq_qos_add_frozen(&rwb->rqos, disk, RQ_QOS_WBT, &wbt_rqos_ops);
+	ret = rq_qos_add(&rwb->rqos, disk, RQ_QOS_WBT, &wbt_rqos_ops);
 	mutex_unlock(&q->rq_qos_mutex);
 	if (ret)
 		return ret;
-- 
2.51.0

