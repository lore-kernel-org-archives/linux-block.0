Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235191DE2C4
	for <linux-block@vger.kernel.org>; Fri,  6 Dec 2024 08:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733473366; cv=none; b=lNK/BoJ/ABf2WvyDW7urww/umS3Do8iHya91cRgsmGXVpyAGb3YN7OHwbjMxuV73M/2/ZQcdqF/oA+hfKSitcWAw8i+bkMl2j/A2Tqqey61+/oTW6j1CtKgzsyyZ8AMGiK9w7+YbdjIq3eO9P8N4z7/Ra6aLP0kXssL5Iyb/FRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733473366; c=relaxed/simple;
	bh=Aq9s0tx7FWFfVi0jrRHpiCAAbM6vaTkXJYAymompjR8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oas5nK+rCI4kRyA65JXIpg7OSu4JtVBONjdjuDdgtigZR5NSM31J7/aRMFnd8w1JSWZmJEcQODFRWBysFxpX141xnY0e+6w2cfo8179QPqp16w5aObjqM1uEeaoxWXBzzXVrKekWcURwVB1oEf4KUqhGjYuR2ZxUqCXDmNy1nGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DMSRz+I6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DMSRz+I6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733473362;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d0x2CKnXxTiKsxlIQDL54XyunUD4Fr09WyjkSs3jREE=;
	b=DMSRz+I6cC2cCOvXmq8HF0vUNwKGVlgr/uinjcBEXhqM1p8MghEfeLFevc7rmCXTJ6fI7M
	NYDrIImRWwA+fg+3YYDu4yIzxCUpxyhRIkBdjK2mhZNdioG4zdX4PzTNZAe7xK/qsvg8mv
	6qrnIxrynl+w5C0W0O1/ZDhemaCXNjQ=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-590-eZ84I819PkGFwHVUAGohWQ-1; Fri,
 06 Dec 2024 03:22:39 -0500
X-MC-Unique: eZ84I819PkGFwHVUAGohWQ-1
X-Mimecast-MFC-AGG-ID: eZ84I819PkGFwHVUAGohWQ
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 74B581956089;
	Fri,  6 Dec 2024 08:22:38 +0000 (UTC)
Received: from localhost (unknown [10.72.112.88])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2A2F71956095;
	Fri,  6 Dec 2024 08:22:36 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Fenghua Yu <fenghua.yu@intel.com>,
	Peter Newman <peternewman@google.com>,
	Babu Moger <babu.moger@amd.com>,
	Luck Tony <tony.luck@intel.com>
Subject: [PATCH 2/2] blk-mq: move cpuhp callback registering out of q->sysfs_lock
Date: Fri,  6 Dec 2024 16:21:58 +0800
Message-ID: <20241206082202.949142-5-ming.lei@redhat.com>
In-Reply-To: <20241206082202.949142-1-ming.lei@redhat.com>
References: <20241206082202.949142-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Registering and unregistering cpuhp requires global cpu hotplug lock,
which is used everywhere. Meantime q->sysfs_lock is used in block layer
almost everywhere.

It is easy to trigger lockdep warning[1] by connecting the two locks.

Fix the warning by moving blk-mq's cpuhp callback registering out of
q->sysfs_lock. Add one dedicated global lock for covering registering &
unregistering hctx's cpuhp, and it is safe to do so because hctx is
guaranteed to be live if our request_queue is live.

[1] https://lore.kernel.org/lkml/Z04pz3AlvI4o0Mr8@agluck-desk3/

Cc: Reinette Chatre <reinette.chatre@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: Peter Newman <peternewman@google.com>
Cc: Babu Moger <babu.moger@amd.com>
Reported-by: Luck Tony <tony.luck@intel.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 103 +++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 92 insertions(+), 11 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index a404465036de..aa340b097b6e 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -43,6 +43,7 @@
 
 static DEFINE_PER_CPU(struct llist_head, blk_cpu_done);
 static DEFINE_PER_CPU(call_single_data_t, blk_cpu_csd);
+static DEFINE_MUTEX(blk_mq_cpuhp_lock);
 
 static void blk_mq_insert_request(struct request *rq, blk_insert_t flags);
 static void blk_mq_request_bypass_insert(struct request *rq,
@@ -3739,13 +3740,91 @@ static int blk_mq_hctx_notify_dead(unsigned int cpu, struct hlist_node *node)
 	return 0;
 }
 
-static void blk_mq_remove_cpuhp(struct blk_mq_hw_ctx *hctx)
+static void __blk_mq_remove_cpuhp(struct blk_mq_hw_ctx *hctx)
 {
-	if (!(hctx->flags & BLK_MQ_F_STACKING))
+	lockdep_assert_held(&blk_mq_cpuhp_lock);
+
+	if (!(hctx->flags & BLK_MQ_F_STACKING) &&
+	    !hlist_unhashed(&hctx->cpuhp_online)) {
 		cpuhp_state_remove_instance_nocalls(CPUHP_AP_BLK_MQ_ONLINE,
 						    &hctx->cpuhp_online);
-	cpuhp_state_remove_instance_nocalls(CPUHP_BLK_MQ_DEAD,
-					    &hctx->cpuhp_dead);
+		INIT_HLIST_NODE(&hctx->cpuhp_online);
+	}
+
+	if (!hlist_unhashed(&hctx->cpuhp_dead)) {
+		cpuhp_state_remove_instance_nocalls(CPUHP_BLK_MQ_DEAD,
+						    &hctx->cpuhp_dead);
+		INIT_HLIST_NODE(&hctx->cpuhp_dead);
+	}
+}
+
+static void blk_mq_remove_cpuhp(struct blk_mq_hw_ctx *hctx)
+{
+	mutex_lock(&blk_mq_cpuhp_lock);
+	__blk_mq_remove_cpuhp(hctx);
+	mutex_unlock(&blk_mq_cpuhp_lock);
+}
+
+static void __blk_mq_add_cpuhp(struct blk_mq_hw_ctx *hctx)
+{
+	lockdep_assert_held(&blk_mq_cpuhp_lock);
+
+	if (!(hctx->flags & BLK_MQ_F_STACKING) &&
+	    hlist_unhashed(&hctx->cpuhp_online))
+		cpuhp_state_add_instance_nocalls(CPUHP_AP_BLK_MQ_ONLINE,
+				&hctx->cpuhp_online);
+
+	if (hlist_unhashed(&hctx->cpuhp_dead))
+		cpuhp_state_add_instance_nocalls(CPUHP_BLK_MQ_DEAD,
+				&hctx->cpuhp_dead);
+}
+
+static void __blk_mq_remove_cpuhp_list(struct list_head *head)
+{
+	struct blk_mq_hw_ctx *hctx;
+
+	lockdep_assert_held(&blk_mq_cpuhp_lock);
+
+	list_for_each_entry(hctx, head, hctx_list)
+		__blk_mq_remove_cpuhp(hctx);
+}
+
+/*
+ * Unregister cpuhp callbacks from exited hw queues
+ *
+ * Safe to call if this `request_queue` is live
+ */
+static void blk_mq_remove_hw_queues_cpuhp(struct request_queue *q)
+{
+	LIST_HEAD(hctx_list);
+
+	spin_lock(&q->unused_hctx_lock);
+	list_splice_init(&q->unused_hctx_list, &hctx_list);
+	spin_unlock(&q->unused_hctx_lock);
+
+	mutex_lock(&blk_mq_cpuhp_lock);
+	__blk_mq_remove_cpuhp_list(&hctx_list);
+	mutex_unlock(&blk_mq_cpuhp_lock);
+
+	spin_lock(&q->unused_hctx_lock);
+	list_splice(&hctx_list, &q->unused_hctx_list);
+	spin_unlock(&q->unused_hctx_lock);
+}
+
+/*
+ * Register cpuhp callbacks from all hw queues
+ *
+ * Safe to call if this `request_queue` is live
+ */
+static void blk_mq_add_hw_queues_cpuhp(struct request_queue *q)
+{
+	struct blk_mq_hw_ctx *hctx;
+	unsigned long i;
+
+	mutex_lock(&blk_mq_cpuhp_lock);
+	queue_for_each_hw_ctx(q, hctx, i)
+		__blk_mq_add_cpuhp(hctx);
+	mutex_unlock(&blk_mq_cpuhp_lock);
 }
 
 /*
@@ -3796,8 +3875,6 @@ static void blk_mq_exit_hctx(struct request_queue *q,
 	if (set->ops->exit_hctx)
 		set->ops->exit_hctx(hctx, hctx_idx);
 
-	blk_mq_remove_cpuhp(hctx);
-
 	xa_erase(&q->hctx_table, hctx_idx);
 
 	spin_lock(&q->unused_hctx_lock);
@@ -3814,6 +3891,7 @@ static void blk_mq_exit_hw_queues(struct request_queue *q,
 	queue_for_each_hw_ctx(q, hctx, i) {
 		if (i == nr_queue)
 			break;
+		blk_mq_remove_cpuhp(hctx);
 		blk_mq_exit_hctx(q, set, hctx, i);
 	}
 }
@@ -3837,11 +3915,6 @@ static int blk_mq_init_hctx(struct request_queue *q,
 	if (xa_insert(&q->hctx_table, hctx_idx, hctx, GFP_KERNEL))
 		goto exit_flush_rq;
 
-	if (!(hctx->flags & BLK_MQ_F_STACKING))
-		cpuhp_state_add_instance_nocalls(CPUHP_AP_BLK_MQ_ONLINE,
-				&hctx->cpuhp_online);
-	cpuhp_state_add_instance_nocalls(CPUHP_BLK_MQ_DEAD, &hctx->cpuhp_dead);
-
 	return 0;
 
  exit_flush_rq:
@@ -3876,6 +3949,8 @@ blk_mq_alloc_hctx(struct request_queue *q, struct blk_mq_tag_set *set,
 	INIT_DELAYED_WORK(&hctx->run_work, blk_mq_run_work_fn);
 	spin_lock_init(&hctx->lock);
 	INIT_LIST_HEAD(&hctx->dispatch);
+	INIT_HLIST_NODE(&hctx->cpuhp_dead);
+	INIT_HLIST_NODE(&hctx->cpuhp_online);
 	hctx->queue = q;
 	hctx->flags = set->flags & ~BLK_MQ_F_TAG_QUEUE_SHARED;
 
@@ -4414,6 +4489,12 @@ static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
 	xa_for_each_start(&q->hctx_table, j, hctx, j)
 		blk_mq_exit_hctx(q, set, hctx, j);
 	mutex_unlock(&q->sysfs_lock);
+
+	/* unregister cpuhp callbacks for exited hctxs */
+	blk_mq_remove_hw_queues_cpuhp(q);
+
+	/* register cpuhp for new initialized hctxs */
+	blk_mq_add_hw_queues_cpuhp(q);
 }
 
 int blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
-- 
2.47.0

