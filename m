Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DEEA35963
	for <linux-block@vger.kernel.org>; Wed, 18 Dec 2024 10:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734516998; cv=none; b=iYPELfMJMNTCYEy82LwZ7rGBp42BeLVKjWMUv4SEk2RySw64MCZF9nJxPdB/XdKz91bstLhgOfH5U28mX/btv1kLbSChI2kwGdXdGm6GI6F+VaPn4jzZ0IT2VzZ9YLj7u8AYRcZQAgeGyHq7N/6TFxzvsOJpjmjIY8xmBY/+ogY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734516998; c=relaxed/simple;
	bh=rC25hUoRmTEeR27CVTz3LK8dt0A5BjTN4cAoHsTlums=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AIz3xR+Iz4elyuu/ythNuflVNjMRjMHzrmmHSLnkRZ26hTdmZNeeRm29KkkEsbQ3dFjfhpJ4Zayvr+d86KfZQI2OTpQ1nBDx67cMO7wkRZkP5oPKvBerZic7wqDN1Y/7LiQFRe2QUUrR+zZcZvM+AgFU7ukqu5aqv8K1wJVgnZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bPqXapoW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bPqXapoW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734516995;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jj8JOuv4V2TlcuoKm0L/7qx24xCzKBAdOEOCt4kxvN4=;
	b=bPqXapoWliH41BBVB3AL+4FeLwTP6EZ6G0S/D7teYNsh95srLUJ4s0t86a4S6ZQvgGAzm5
	tHewX8+ZJ3yGfZVpuMb7VRKGQUn4AX0vEGLYXizZIDbMGbTUvZEzuRdasdupxv/D/QEmDO
	0VsYWASd/uea37u/AEsNIwqMQLckvi8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-632-WdjEmsPPOb-c9mWTkMN_xQ-1; Wed,
 18 Dec 2024 05:16:30 -0500
X-MC-Unique: WdjEmsPPOb-c9mWTkMN_xQ-1
X-Mimecast-MFC-AGG-ID: WdjEmsPPOb-c9mWTkMN_xQ
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 80D0A1956088;
	Wed, 18 Dec 2024 10:16:29 +0000 (UTC)
Received: from localhost (unknown [10.72.116.10])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5E44919560AD;
	Wed, 18 Dec 2024 10:16:27 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>,
	Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH 1/2] block: Revert "block: Fix potential deadlock while freezing queue and acquiring sysfs_lock"
Date: Wed, 18 Dec 2024 18:16:14 +0800
Message-ID: <20241218101617.3275704-2-ming.lei@redhat.com>
In-Reply-To: <20241218101617.3275704-1-ming.lei@redhat.com>
References: <20241218101617.3275704-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

This reverts commit be26ba96421ab0a8fa2055ccf7db7832a13c44d2.

Commit be26ba96421a ("block: Fix potential deadlock while freezing queue and
acquiring sysfs_loc") actually reverts commit 22465bbac53c ("blk-mq: move cpuhp
callback registering out of q->sysfs_lock"), and causes the original resctrl
lockdep warning.

So revert it and we need to fix the issue in another way.

Cc: Nilay Shroff <nilay@linux.ibm.com>
Fixes: be26ba96421a ("block: Fix potential deadlock while freezing queue and acquiring sysfs_loc")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq-sysfs.c | 16 ++++++++++------
 block/blk-mq.c       | 29 +++++++++++------------------
 block/blk-sysfs.c    |  4 ++--
 3 files changed, 23 insertions(+), 26 deletions(-)

diff --git a/block/blk-mq-sysfs.c b/block/blk-mq-sysfs.c
index cd5ea6eaa76b..156e9bb07abf 100644
--- a/block/blk-mq-sysfs.c
+++ b/block/blk-mq-sysfs.c
@@ -275,13 +275,15 @@ void blk_mq_sysfs_unregister_hctxs(struct request_queue *q)
 	struct blk_mq_hw_ctx *hctx;
 	unsigned long i;
 
-	lockdep_assert_held(&q->sysfs_dir_lock);
-
+	mutex_lock(&q->sysfs_dir_lock);
 	if (!q->mq_sysfs_init_done)
-		return;
+		goto unlock;
 
 	queue_for_each_hw_ctx(q, hctx, i)
 		blk_mq_unregister_hctx(hctx);
+
+unlock:
+	mutex_unlock(&q->sysfs_dir_lock);
 }
 
 int blk_mq_sysfs_register_hctxs(struct request_queue *q)
@@ -290,10 +292,9 @@ int blk_mq_sysfs_register_hctxs(struct request_queue *q)
 	unsigned long i;
 	int ret = 0;
 
-	lockdep_assert_held(&q->sysfs_dir_lock);
-
+	mutex_lock(&q->sysfs_dir_lock);
 	if (!q->mq_sysfs_init_done)
-		return ret;
+		goto unlock;
 
 	queue_for_each_hw_ctx(q, hctx, i) {
 		ret = blk_mq_register_hctx(hctx);
@@ -301,5 +302,8 @@ int blk_mq_sysfs_register_hctxs(struct request_queue *q)
 			break;
 	}
 
+unlock:
+	mutex_unlock(&q->sysfs_dir_lock);
+
 	return ret;
 }
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 6b6111513986..92e8ddf34575 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4453,8 +4453,7 @@ static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
 	unsigned long i, j;
 
 	/* protect against switching io scheduler  */
-	lockdep_assert_held(&q->sysfs_lock);
-
+	mutex_lock(&q->sysfs_lock);
 	for (i = 0; i < set->nr_hw_queues; i++) {
 		int old_node;
 		int node = blk_mq_get_hctx_node(set, i);
@@ -4487,6 +4486,7 @@ static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
 
 	xa_for_each_start(&q->hctx_table, j, hctx, j)
 		blk_mq_exit_hctx(q, set, hctx, j);
+	mutex_unlock(&q->sysfs_lock);
 
 	/* unregister cpuhp callbacks for exited hctxs */
 	blk_mq_remove_hw_queues_cpuhp(q);
@@ -4518,14 +4518,10 @@ int blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 
 	xa_init(&q->hctx_table);
 
-	mutex_lock(&q->sysfs_lock);
-
 	blk_mq_realloc_hw_ctxs(set, q);
 	if (!q->nr_hw_queues)
 		goto err_hctxs;
 
-	mutex_unlock(&q->sysfs_lock);
-
 	INIT_WORK(&q->timeout_work, blk_mq_timeout_work);
 	blk_queue_rq_timeout(q, set->timeout ? set->timeout : 30 * HZ);
 
@@ -4544,7 +4540,6 @@ int blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 	return 0;
 
 err_hctxs:
-	mutex_unlock(&q->sysfs_lock);
 	blk_mq_release(q);
 err_exit:
 	q->mq_ops = NULL;
@@ -4925,12 +4920,12 @@ static bool blk_mq_elv_switch_none(struct list_head *head,
 		return false;
 
 	/* q->elevator needs protection from ->sysfs_lock */
-	lockdep_assert_held(&q->sysfs_lock);
+	mutex_lock(&q->sysfs_lock);
 
 	/* the check has to be done with holding sysfs_lock */
 	if (!q->elevator) {
 		kfree(qe);
-		goto out;
+		goto unlock;
 	}
 
 	INIT_LIST_HEAD(&qe->node);
@@ -4940,7 +4935,9 @@ static bool blk_mq_elv_switch_none(struct list_head *head,
 	__elevator_get(qe->type);
 	list_add(&qe->node, head);
 	elevator_disable(q);
-out:
+unlock:
+	mutex_unlock(&q->sysfs_lock);
+
 	return true;
 }
 
@@ -4969,9 +4966,11 @@ static void blk_mq_elv_switch_back(struct list_head *head,
 	list_del(&qe->node);
 	kfree(qe);
 
+	mutex_lock(&q->sysfs_lock);
 	elevator_switch(q, t);
 	/* drop the reference acquired in blk_mq_elv_switch_none */
 	elevator_put(t);
+	mutex_unlock(&q->sysfs_lock);
 }
 
 static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
@@ -4991,11 +4990,8 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 	if (set->nr_maps == 1 && nr_hw_queues == set->nr_hw_queues)
 		return;
 
-	list_for_each_entry(q, &set->tag_list, tag_set_list) {
-		mutex_lock(&q->sysfs_dir_lock);
-		mutex_lock(&q->sysfs_lock);
+	list_for_each_entry(q, &set->tag_list, tag_set_list)
 		blk_mq_freeze_queue(q);
-	}
 	/*
 	 * Switch IO scheduler to 'none', cleaning up the data associated
 	 * with the previous scheduler. We will switch back once we are done
@@ -5051,11 +5047,8 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 	list_for_each_entry(q, &set->tag_list, tag_set_list)
 		blk_mq_elv_switch_back(&head, q);
 
-	list_for_each_entry(q, &set->tag_list, tag_set_list) {
+	list_for_each_entry(q, &set->tag_list, tag_set_list)
 		blk_mq_unfreeze_queue(q);
-		mutex_unlock(&q->sysfs_lock);
-		mutex_unlock(&q->sysfs_dir_lock);
-	}
 
 	/* Free the excess tags when nr_hw_queues shrink. */
 	for (i = set->nr_hw_queues; i < prev_nr_hw_queues; i++)
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 64f70c713d2f..767598e719ab 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -706,11 +706,11 @@ queue_attr_store(struct kobject *kobj, struct attribute *attr,
 	if (entry->load_module)
 		entry->load_module(disk, page, length);
 
-	mutex_lock(&q->sysfs_lock);
 	blk_mq_freeze_queue(q);
+	mutex_lock(&q->sysfs_lock);
 	res = entry->store(disk, page, length);
-	blk_mq_unfreeze_queue(q);
 	mutex_unlock(&q->sysfs_lock);
+	blk_mq_unfreeze_queue(q);
 	return res;
 }
 
-- 
2.47.0

