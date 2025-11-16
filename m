Received: from sg-1-13.ptr.blmpb.com (sg-1-13.ptr.blmpb.com [118.26.132.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9966822370A
	for <linux-block@vger.kernel.org>; Sun, 16 Nov 2025 02:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763260920; cv=none; b=c1iUZcrnjDFOlD9Zz3z642X0fMf/NkkRh899pXnuRz4RZvVEs278EKeARfmFP+6XAJqn3urUzmQj02M9SYgHKnsPxwqBWUIQHx8Wnd8rSwZcHdexyrPK7TaYYWbE4XG26LEWKr2L20eyyoppoyU8V6oQepic8shAehNwX/1rjjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763260920; c=relaxed/simple;
	bh=oHU5WUeUHVeJ43U86ohqtdr2k0bq20DXDgHXaMlKoLo=;
	h=Cc:Content-Type:To:Date:Mime-Version:From:Subject:Message-Id; b=t5byJeok8vYdc6dDazm3kN8prjFO7mNWy+A4SpoFTjOtELymUXqiVwyhfrpDQushhwpGKkLvy/V9UVZ4qOuvaPejb0oVsn4dpbTKQJGXmkz8ThuBkrYdf1uMy+B3hdUnN2N1l2GUHfk1azVe1BaqO/ku0s1M/Nh0zq9mOSvM5hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com; spf=none smtp.mailfrom=fnnas.com; dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b=r0ORlw8Y; arc=none smtp.client-ip=118.26.132.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=fnnas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b="r0ORlw8Y"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fnnas-com.20200927.dkim.feishu.cn; t=1763260912;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=MOFiFxRWDeWl7oGKAd0yMxZwEVTKVFOPgfE7nuxPBdQ=;
 b=r0ORlw8YajzDvPc14xJW9p04BGmTtyoNR2D6FhrBevoYUFzMS+A2M6+KaZN21JoRk0wyOe
 V8G9KrESKmzwFskjP9uNSXfq2hK+y66tYUw04M4L1rRXwiNjK38FeqL+wZvKpof3/Qlf3X
 Nn1kbFVsMOVx/BIiM0NhxpJhBleJFsNeV+b6EdJ9Bw8FDC4cImQebrQkI8GzkFAgsX8pgj
 wpB/JMwNt6bosH3dj5+tNCGdd9x002DW0V1fQi8XL6mJUCU76G1fiiAFOHyrUqUpI41Ocq
 BDHHlKTm1QhT0AK7eXv0DIYkKF7Ri4uMsyUkwzVvhidVDxJDvrvmPAPiaFnTmw==
Cc: <yukuai@fnnas.com>
Content-Transfer-Encoding: 7bit
X-Mailer: git-send-email 2.51.0
Content-Type: text/plain; charset=UTF-8
To: <axboe@kernel.dk>, <linux-block@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <tj@kernel.org>, <nilay@linux.ibm.com>, 
	<ming.lei@redhat.com>
Date: Sun, 16 Nov 2025 10:41:30 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Lms-Return-Path: <lba+2691939ee+27bb7c+vger.kernel.org+yukuai@fnnas.com>
From: "Yu Kuai" <yukuai@fnnas.com>
Subject: [PATCH 1/5] block/blk-rq-qos: add a new helper rq_qos_add_freezed()
X-Original-From: Yu Kuai <yukuai@fnnas.com>
Message-Id: <20251116024134.115685-2-yukuai@fnnas.com>
Received: from localhost.localdomain ([39.182.0.135]) by smtp.feishu.cn with ESMTPS; Sun, 16 Nov 2025 10:41:49 +0800

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
