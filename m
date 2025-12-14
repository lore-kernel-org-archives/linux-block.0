Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F21156237
	for <linux-block@vger.kernel.org>; Sun, 14 Dec 2025 10:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765707275; cv=none; b=IkkxCTHIYj5vnrvZdbBijxcWlh2UIs3YH4te5SCkFcO95uA3GWm2Fw3CBS0ygZxuWIFpHW2NEFa97435UJthJEf92uLZIrPs8BtzNiAHjsnUyLsyYoHpQ9DGMQVH3UHxTgWeQUUDU0n2QkYpf/nZYH6DHHc+/LwnNto1LyJLqzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765707275; c=relaxed/simple;
	bh=obY+ADyZeTl/i8qaVGxzUr52hxpiHhwKYKbZAixu6V8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PY0rwVbuizHEVKfPeYkkm1rKQ7voIA9hgE/14DvvtZwjGhnpYK/23CTKL+OfbDTxX+KMUervlB/8QmrBYzskKqma8yZA68ourK7M1IMmZx2syhLTcH70zQf9RZkcQxEyvvG7PnPd0DWv4ogJ8v4+POpFbQaMXRhjHK2HUA899SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 538DAC19421;
	Sun, 14 Dec 2025 10:14:33 +0000 (UTC)
From: Yu Kuai <yukuai@fnnas.com>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org,
	tj@kernel.org,
	nilay@linux.ibm.com,
	ming.lei@redhat.com
Cc: yukuai@fnnas.com
Subject: [PATCH v5 08/13] block/blk-rq-qos: add a new helper rq_qos_add_frozen()
Date: Sun, 14 Dec 2025 18:14:03 +0800
Message-ID: <20251214101409.1723751-9-yukuai@fnnas.com>
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
index d7ce99ce2e80..c1a94c2a9742 100644
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

