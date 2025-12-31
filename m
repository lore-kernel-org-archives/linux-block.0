Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DA231327A
	for <linux-block@vger.kernel.org>; Wed, 31 Dec 2025 08:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767171114; cv=none; b=UH0rxUWw3/ZSWhE4cKvj0tbRWRi132JxuPuJz6MXQmTDgPj3WQBoi+9DizqTKLRTpldtgDfo1s9IRvp/m2j/xgFv53zCLFGkRb4MWNMRzLYnivF4F15HaWU5BEOd2Qals/dR5KEltk35SeiJTfyNXd1sXLtJ2OwnqTe6sgieGhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767171114; c=relaxed/simple;
	bh=/EeUTFOm4bpjSSWOJBud9uN3XCLeYkQuca5MX3rBXJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qHXkx2olW1VA+FaX6I5eI/0GI/jNiYSLPidadL5JUia0vABc658wtIIxIOQhrSI62rdLx4TwWU9SYUbBWcIwy5Ad2cIyElnAXQ4fMfOJTZ2JKZqS2EwBwUWXr4hQ3y9sP+QmwUDtd9b/kHruzXZoBFzbVXLCbidVEKGGmV41AZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D86A5C19422;
	Wed, 31 Dec 2025 08:51:52 +0000 (UTC)
From: Yu Kuai <yukuai@fnnas.com>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org,
	tj@kernel.org,
	nilay@linux.ibm.com,
	ming.lei@redhat.com
Cc: yukuai@fnnas.com
Subject: [PATCH v7 10/16] block/blk-rq-qos: add a new helper rq_qos_add_frozen()
Date: Wed, 31 Dec 2025 16:51:20 +0800
Message-ID: <20251231085126.205310-11-yukuai@fnnas.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251231085126.205310-1-yukuai@fnnas.com>
References: <20251231085126.205310-1-yukuai@fnnas.com>
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

