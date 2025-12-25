Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5935531AA96
	for <linux-block@vger.kernel.org>; Thu, 25 Dec 2025 10:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766658799; cv=none; b=QnBCT+FHYm9YZq3It7svQwAhGpKs3Kg3IFBTlKMUlWP+e910H5YmHCNh5LV5nZ/+C5AwwLVAVYF9b8yLbrABFE8+SLERnKUUqVTvQnHkzPhxCa9Ic6UYCloS1zOZabbJHEftZZ/Hi+cTJfIqCM9v1mR8wa2Ow32m1JkMU9aaGGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766658799; c=relaxed/simple;
	bh=/EeUTFOm4bpjSSWOJBud9uN3XCLeYkQuca5MX3rBXJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=anByDjg+uyXv6173Ehvm1HxlSfgb0Eyy+X6e/dwWY7sRmO6yeMnGbzVOnxAVwCkh5EaE/I+ZwrNaxd47yKVzx4X9Ug6GlmHQwocvKyMkwhFm5AP59r4jkQnGDXq+rvam8mz25COUZUqG4ZD6Mbcw+ZshWAl0tsvXxK7CYzvNXj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 134FFC16AAE;
	Thu, 25 Dec 2025 10:33:15 +0000 (UTC)
From: Yu Kuai <yukuai@fnnas.com>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org,
	tj@kernel.org,
	nilay@linux.ibm.com,
	ming.lei@redhat.com
Cc: yukuai@fnnas.com
Subject: [PATCH v6 09/13] block/blk-rq-qos: add a new helper rq_qos_add_frozen()
Date: Thu, 25 Dec 2025 18:32:44 +0800
Message-ID: <20251225103248.1303397-10-yukuai@fnnas.com>
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

queue should not be frozen under rq_qos_mutex, see example from
commit 9730763f4756 ("block: correct locking order for protecting blk-wbt
parameters"), which means current implementation of rq_qos_add() is
problematic. Add a new helper and prepare to fix this problem in
following patches.

Signed-off-by: Yu Kuai <yukuai@fnnas.com>
---
 block/blk-rq-qos.c | 21 +++++++++++++++++++++
 block/blk-rq-qos.h |  2 ++
 2 files changed, 23 insertions(+)

diff --git a/block/blk-rq-qos.c b/block/blk-rq-qos.c
index 85cf74402a09..b8f163827477 100644
--- a/block/blk-rq-qos.c
+++ b/block/blk-rq-qos.c
@@ -322,6 +322,27 @@ void rq_qos_exit(struct request_queue *q)
 	mutex_unlock(&q->rq_qos_mutex);
 }
 
+int rq_qos_add_frozen(struct rq_qos *rqos, struct gendisk *disk,
+		      enum rq_qos_id id, const struct rq_qos_ops *ops)
+{
+	struct request_queue *q = disk->queue;
+
+	WARN_ON_ONCE(q->mq_freeze_depth == 0);
+	lockdep_assert_held(&q->rq_qos_mutex);
+
+	if (rq_qos_id(q, id))
+		return -EBUSY;
+
+	rqos->disk = disk;
+	rqos->id = id;
+	rqos->ops = ops;
+	rqos->next = q->rq_qos;
+	q->rq_qos = rqos;
+	blk_queue_flag_set(QUEUE_FLAG_QOS_ENABLED, q);
+
+	return 0;
+}
+
 int rq_qos_add(struct rq_qos *rqos, struct gendisk *disk, enum rq_qos_id id,
 		const struct rq_qos_ops *ops)
 {
diff --git a/block/blk-rq-qos.h b/block/blk-rq-qos.h
index b538f2c0febc..8d9fb10ae526 100644
--- a/block/blk-rq-qos.h
+++ b/block/blk-rq-qos.h
@@ -87,6 +87,8 @@ static inline void rq_wait_init(struct rq_wait *rq_wait)
 
 int rq_qos_add(struct rq_qos *rqos, struct gendisk *disk, enum rq_qos_id id,
 		const struct rq_qos_ops *ops);
+int rq_qos_add_frozen(struct rq_qos *rqos, struct gendisk *disk,
+		      enum rq_qos_id id, const struct rq_qos_ops *ops);
 void rq_qos_del(struct rq_qos *rqos);
 
 typedef bool (acquire_inflight_cb_t)(struct rq_wait *rqw, void *private_data);
-- 
2.51.0

