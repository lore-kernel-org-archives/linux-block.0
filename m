Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC0119CD1D
	for <linux-block@vger.kernel.org>; Thu, 31 Oct 2024 13:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730381872; cv=none; b=SR1+KB7E2o+CwVmFPk3vZua7l7DQEGfgFQua1lZqAWAa2e6VJU+7ENnaPbbmv8gtuiOjXPsViw2ly/ZiAar1sJJ7dZ6Gz2WPljKJL/sAKWtoV63oB1l+W0Dbawdkvys6TpmX67JrErtqW3HZfGW6lwm4eWFxXZF3hTIT7wdK1e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730381872; c=relaxed/simple;
	bh=rFojhjOQjJxB+IPAkhVSMmaoO8WXbZgg5SsulDLD/kc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ofSYH0RfCLQj+rb33SVnuAG4gdtomOibIUazgieYBx7zp+P3nG0W87Ul/WaYMvuzNFZ5i9flW9Dd46WKQ9V3jq7s5rbXBDGPtA/xvekBLcEh+p2BByqBgPce98+yvhApkJpfVOmvsF8jrrdmxc2Wul73f/m5eV2hPhyeCeC/LEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RKq1XGiT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RKq1XGiT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730381868;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wMfTfRi982GDE43niZeVbCPQqGUzPV9Usj+wCKpm+3U=;
	b=RKq1XGiTWcYOaE31WGJ2HzuAZ3zBadpoG3b6gC+nb3MZpYBmP3DY+sidDBTQbP16o4rrQB
	y664q5Q1uqNlKI3DDljFL6p3cT482QHmZ/A0fwYL6RAsUAh+zqUnvfsglCD/1eX8j4FGj8
	HK7ZsazRMnBpdKwm9UTZbl/tjz01++0=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-261-AOEK4nQROy-UQuHkRID4-w-1; Thu,
 31 Oct 2024 09:37:46 -0400
X-MC-Unique: AOEK4nQROy-UQuHkRID4-w-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 557AB1955EA5;
	Thu, 31 Oct 2024 13:37:45 +0000 (UTC)
Received: from localhost (unknown [10.72.116.4])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6251F1956086;
	Thu, 31 Oct 2024 13:37:43 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 3/4] block: always verify unfreeze lock on the owner task
Date: Thu, 31 Oct 2024 21:37:19 +0800
Message-ID: <20241031133723.303835-4-ming.lei@redhat.com>
In-Reply-To: <20241031133723.303835-1-ming.lei@redhat.com>
References: <20241031133723.303835-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

commit f1be1788a32e ("block: model freeze & enter queue as lock for
supporting lockdep") tries to apply lockdep for verifying freeze &
unfreeze. However, the verification is only done the outmost freeze and
unfreeze. This way is actually not correct because q->mq_freeze_depth
still may drop to zero on other task instead of the freeze owner task.

Fix this issue by always verifying the last unfreeze lock on the owner
task context, and make sure both the outmost freeze & unfreeze are
verified in the current task.

Fixes: f1be1788a32e ("block: model freeze & enter queue as lock for supporting lockdep")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-core.c       |  2 +-
 block/blk-mq.c         | 62 ++++++++++++++++++++++++++++++++++++------
 block/blk.h            |  3 +-
 include/linux/blkdev.h |  4 +++
 4 files changed, 61 insertions(+), 10 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 09d10bb95fda..4f791a3114a1 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -287,7 +287,7 @@ bool blk_queue_start_drain(struct request_queue *q)
 	 * entering queue, so we call blk_freeze_queue_start() to
 	 * prevent I/O from crossing blk_queue_enter().
 	 */
-	bool freeze = __blk_freeze_queue_start(q);
+	bool freeze = __blk_freeze_queue_start(q, current);
 	if (queue_is_mq(q))
 		blk_mq_wake_waiters(q);
 	/* Make blk_queue_enter() reexamine the DYING flag. */
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 5f4496220432..5e240a4b6be0 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -120,20 +120,66 @@ void blk_mq_in_flight_rw(struct request_queue *q, struct block_device *part,
 	inflight[1] = mi.inflight[1];
 }
 
-bool __blk_freeze_queue_start(struct request_queue *q)
+#ifdef CONFIG_LOCKDEP
+static bool blk_freeze_set_owner(struct request_queue *q,
+				 struct task_struct *owner)
 {
-	int freeze;
+	if (!owner)
+		return false;
+
+	if (!q->mq_freeze_depth) {
+		q->mq_freeze_owner = owner;
+		q->mq_freeze_owner_depth = 1;
+		return true;
+	}
+
+	if (owner == q->mq_freeze_owner)
+		q->mq_freeze_owner_depth += 1;
+	return false;
+}
+
+/* verify the last unfreeze in owner context */
+static bool blk_unfreeze_check_owner(struct request_queue *q)
+{
+	if (!q->mq_freeze_owner)
+		return false;
+	if (q->mq_freeze_owner != current)
+		return false;
+	if (--q->mq_freeze_owner_depth == 0) {
+		q->mq_freeze_owner = NULL;
+		return true;
+	}
+	return false;
+}
+
+#else
+
+static bool blk_freeze_set_owner(struct request_queue *q,
+				 struct task_struct *owner)
+{
+	return false;
+}
+
+static bool blk_unfreeze_check_owner(struct request_queue *q)
+{
+	return false;
+}
+#endif
+
+bool __blk_freeze_queue_start(struct request_queue *q,
+			      struct task_struct *owner)
+{
+	bool freeze;
 
 	mutex_lock(&q->mq_freeze_lock);
+	freeze = blk_freeze_set_owner(q, owner);
 	if (++q->mq_freeze_depth == 1) {
 		percpu_ref_kill(&q->q_usage_counter);
 		mutex_unlock(&q->mq_freeze_lock);
 		if (queue_is_mq(q))
 			blk_mq_run_hw_queues(q, false);
-		freeze = true;
 	} else {
 		mutex_unlock(&q->mq_freeze_lock);
-		freeze = false;
 	}
 
 	return freeze;
@@ -141,7 +187,7 @@ bool __blk_freeze_queue_start(struct request_queue *q)
 
 void blk_freeze_queue_start(struct request_queue *q)
 {
-	if (__blk_freeze_queue_start(q))
+	if (__blk_freeze_queue_start(q, current))
 		blk_freeze_acquire_lock(q, false, false);
 }
 EXPORT_SYMBOL_GPL(blk_freeze_queue_start);
@@ -170,7 +216,7 @@ EXPORT_SYMBOL_GPL(blk_mq_freeze_queue);
 
 bool __blk_mq_unfreeze_queue(struct request_queue *q, bool force_atomic)
 {
-	int unfreeze = false;
+	bool unfreeze;
 
 	mutex_lock(&q->mq_freeze_lock);
 	if (force_atomic)
@@ -180,8 +226,8 @@ bool __blk_mq_unfreeze_queue(struct request_queue *q, bool force_atomic)
 	if (!q->mq_freeze_depth) {
 		percpu_ref_resurrect(&q->q_usage_counter);
 		wake_up_all(&q->mq_freeze_wq);
-		unfreeze = true;
 	}
+	unfreeze = blk_unfreeze_check_owner(q);
 	mutex_unlock(&q->mq_freeze_lock);
 
 	return unfreeze;
@@ -203,7 +249,7 @@ EXPORT_SYMBOL_GPL(blk_mq_unfreeze_queue);
  */
 void blk_freeze_queue_start_non_owner(struct request_queue *q)
 {
-	__blk_freeze_queue_start(q);
+	__blk_freeze_queue_start(q, NULL);
 }
 EXPORT_SYMBOL_GPL(blk_freeze_queue_start_non_owner);
 
diff --git a/block/blk.h b/block/blk.h
index ac48b79cbf80..57fc035620d6 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -37,7 +37,8 @@ void blk_free_flush_queue(struct blk_flush_queue *q);
 
 bool __blk_mq_unfreeze_queue(struct request_queue *q, bool force_atomic);
 bool blk_queue_start_drain(struct request_queue *q);
-bool __blk_freeze_queue_start(struct request_queue *q);
+bool __blk_freeze_queue_start(struct request_queue *q,
+			      struct task_struct *owner);
 int __bio_queue_enter(struct request_queue *q, struct bio *bio);
 void submit_bio_noacct_nocheck(struct bio *bio);
 void bio_await_chain(struct bio *bio);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 7bfc877e159e..379cd8eebdd9 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -575,6 +575,10 @@ struct request_queue {
 	struct throtl_data *td;
 #endif
 	struct rcu_head		rcu_head;
+#ifdef CONFIG_LOCKDEP
+	struct task_struct	*mq_freeze_owner;
+	int			mq_freeze_owner_depth;
+#endif
 	wait_queue_head_t	mq_freeze_wq;
 	/*
 	 * Protect concurrent access to q_usage_counter by
-- 
2.47.0

