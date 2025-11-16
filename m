Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D363C19F12D;
	Sun, 16 Nov 2025 04:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763266231; cv=none; b=Q/5mM9wkz7wxhF6FPtNpFCg19NW0aG4XO0Iaq7xI544SFAWkuzJTooxat3KJBvDzIAFyOAC+S2WUQech5i1yIk7It5b9GCqDP+/eagqVv92CMo3k+SVr/i+AgxvDrrRWRGmqb9qUs0JVVXNUYR5wy/U0UCVXf+hEIwh6AlbUrrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763266231; c=relaxed/simple;
	bh=oHU5WUeUHVeJ43U86ohqtdr2k0bq20DXDgHXaMlKoLo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cpCLsg2BW2BGxvjfAmU9CmyFgKp425FRLlTfq1gPwS2cPncNwBe/gCndZSka5iaa4MatvCgbQqhi/aglMUGdD/Z9iM/icj7BcyPaYEU9tBaWOBGUWSi+oMPuuQuEhStbVpPb65xKmO3eXbFUDQptkKqnWSp5NHmCNsAZI+kYp48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B236EC4CEF1;
	Sun, 16 Nov 2025 04:10:29 +0000 (UTC)
From: Yu Kuai <yukuai@fnnas.com>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tj@kernel.org,
	nilay@linux.ibm.com,
	ming.lei@redhat.com
Cc: yukuai@fnnas.com
Subject: [PATCH RESEND 1/5] block/blk-rq-qos: add a new helper rq_qos_add_freezed()
Date: Sun, 16 Nov 2025 12:10:20 +0800
Message-ID: <20251116041024.120500-2-yukuai@fnnas.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251116041024.120500-1-yukuai@fnnas.com>
References: <20251116041024.120500-1-yukuai@fnnas.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

queue should not be freezed under rq_qos_mutex, see example index
commit 9730763f4756 ("block: correct locking order for protecting blk-wbt
parameters"), which means current implementation of rq_qos_add() is
problematic. Add a new helper and prepare to fix this problem in
following patches.

Signed-off-by: Yu Kuai <yukuai@fnnas.com>
---
 block/blk-rq-qos.c | 27 +++++++++++++++++++++++++++
 block/blk-rq-qos.h |  2 ++
 2 files changed, 29 insertions(+)

diff --git a/block/blk-rq-qos.c b/block/blk-rq-qos.c
index 654478dfbc20..353397d7e126 100644
--- a/block/blk-rq-qos.c
+++ b/block/blk-rq-qos.c
@@ -322,6 +322,33 @@ void rq_qos_exit(struct request_queue *q)
 	mutex_unlock(&q->rq_qos_mutex);
 }
 
+int rq_qos_add_freezed(struct rq_qos *rqos, struct gendisk *disk,
+		       enum rq_qos_id id, const struct rq_qos_ops *ops)
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
+	if (rqos->ops->debugfs_attrs) {
+		mutex_lock(&q->debugfs_mutex);
+		blk_mq_debugfs_register_rqos(rqos);
+		mutex_unlock(&q->debugfs_mutex);
+	}
+
+	return 0;
+}
+
 int rq_qos_add(struct rq_qos *rqos, struct gendisk *disk, enum rq_qos_id id,
 		const struct rq_qos_ops *ops)
 {
diff --git a/block/blk-rq-qos.h b/block/blk-rq-qos.h
index b538f2c0febc..4a7fec01600b 100644
--- a/block/blk-rq-qos.h
+++ b/block/blk-rq-qos.h
@@ -87,6 +87,8 @@ static inline void rq_wait_init(struct rq_wait *rq_wait)
 
 int rq_qos_add(struct rq_qos *rqos, struct gendisk *disk, enum rq_qos_id id,
 		const struct rq_qos_ops *ops);
+int rq_qos_add_freezed(struct rq_qos *rqos, struct gendisk *disk,
+		       enum rq_qos_id id, const struct rq_qos_ops *ops);
 void rq_qos_del(struct rq_qos *rqos);
 
 typedef bool (acquire_inflight_cb_t)(struct rq_wait *rqw, void *private_data);
-- 
2.51.0

