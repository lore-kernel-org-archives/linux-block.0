Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B44122A7F0;
	Wed, 11 Dec 2024 18:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733943186; cv=none; b=LGJkZB+pp2mHL3/+tDF5fsUO8geQYAdse382pMV6DWYITPNROCpxRo4Cr0zv+taK62ndR8dtp7iyvETBgU58L8JVGfZIJEF988SNPdXCXKj2EGdBZdjwtV26/dTbwRo3CERzbpDd0RvDCpnCgsIM8yCnNg10VZImOjQtZwBveAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733943186; c=relaxed/simple;
	bh=sifg6zcNR6GokQ8DlDB7B9RFA9aowqWDdxeUhtxumyc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CrRU4XZJXBwSlPhbuDlbi5geH/ECRZ7fJC/6ELXMxVE/+vlZWiX22Rf7xP4pUD0rHu02moUTytG1hVDn3Ao4bHINuW0bSy5sndnJbtS2lXY82nz0M5H8NoKj6MvU3DADslaz8blpTAuiiZyFBVTgAltXtaPQX93AkNP7XMsw+b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IJ3EmNE4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IJ3EmNE4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5AD8C4CED4;
	Wed, 11 Dec 2024 18:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733943186;
	bh=sifg6zcNR6GokQ8DlDB7B9RFA9aowqWDdxeUhtxumyc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IJ3EmNE4CX3q0qxBkQKw+JtM5/uVCPWQjM4YmMKDbOejGqmuQl36vb/cqWG+o0PpP
	 7HG/062dpfQzN3SLwaZuRZH3CZmTy8bxJF0qi3XEFy+xyo1fw66quh4GlGCOgd0RE5
	 EI5MpeKpTsEkbQD3/CkGeq8yW5y1YFOYfLBBuxE/PMCC7tPONRvQcoTC08kFpqP7UC
	 HwObNzwdSXFkzq2oBpA0YrK9Rm19LHv9waGlQ1RxzGWR5yuati3ngDQWaG6UDcoR/i
	 +rdJiMaXl31uBJVx02NrdX+WJ7jku5KPZblBjZ6DjQWn+4r8zD1jRrTdQ4MlGSU7XL
	 CG9J+lsroUBiA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Fenghua Yu <fenghua.yu@intel.com>,
	Peter Newman <peternewman@google.com>,
	Babu Moger <babu.moger@amd.com>,
	Luck Tony <tony.luck@intel.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>,
	linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 23/23] blk-mq: move cpuhp callback registering out of q->sysfs_lock
Date: Wed, 11 Dec 2024 13:52:00 -0500
Message-ID: <20241211185214.3841978-23-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241211185214.3841978-1-sashal@kernel.org>
References: <20241211185214.3841978-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.65
Content-Transfer-Encoding: 8bit

From: Ming Lei <ming.lei@redhat.com>

[ Upstream commit 22465bbac53c821319089016f268a2437de9b00a ]

Registering and unregistering cpuhp callback requires global cpu hotplug lock,
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
Tested-by: Tony Luck <tony.luck@intel.com>
Link: https://lore.kernel.org/r/20241206111611.978870-3-ming.lei@redhat.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-mq.c | 103 +++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 92 insertions(+), 11 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index f4a9eed1b9774..9efc2fd3e4c4a 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -43,6 +43,7 @@
 
 static DEFINE_PER_CPU(struct llist_head, blk_cpu_done);
 static DEFINE_PER_CPU(call_single_data_t, blk_cpu_csd);
+static DEFINE_MUTEX(blk_mq_cpuhp_lock);
 
 static void blk_mq_insert_request(struct request *rq, blk_insert_t flags);
 static void blk_mq_request_bypass_insert(struct request *rq,
@@ -3623,13 +3624,91 @@ static int blk_mq_hctx_notify_dead(unsigned int cpu, struct hlist_node *node)
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
@@ -3680,8 +3759,6 @@ static void blk_mq_exit_hctx(struct request_queue *q,
 	if (set->ops->exit_hctx)
 		set->ops->exit_hctx(hctx, hctx_idx);
 
-	blk_mq_remove_cpuhp(hctx);
-
 	xa_erase(&q->hctx_table, hctx_idx);
 
 	spin_lock(&q->unused_hctx_lock);
@@ -3698,6 +3775,7 @@ static void blk_mq_exit_hw_queues(struct request_queue *q,
 	queue_for_each_hw_ctx(q, hctx, i) {
 		if (i == nr_queue)
 			break;
+		blk_mq_remove_cpuhp(hctx);
 		blk_mq_exit_hctx(q, set, hctx, i);
 	}
 }
@@ -3721,11 +3799,6 @@ static int blk_mq_init_hctx(struct request_queue *q,
 	if (xa_insert(&q->hctx_table, hctx_idx, hctx, GFP_KERNEL))
 		goto exit_flush_rq;
 
-	if (!(hctx->flags & BLK_MQ_F_STACKING))
-		cpuhp_state_add_instance_nocalls(CPUHP_AP_BLK_MQ_ONLINE,
-				&hctx->cpuhp_online);
-	cpuhp_state_add_instance_nocalls(CPUHP_BLK_MQ_DEAD, &hctx->cpuhp_dead);
-
 	return 0;
 
  exit_flush_rq:
@@ -3760,6 +3833,8 @@ blk_mq_alloc_hctx(struct request_queue *q, struct blk_mq_tag_set *set,
 	INIT_DELAYED_WORK(&hctx->run_work, blk_mq_run_work_fn);
 	spin_lock_init(&hctx->lock);
 	INIT_LIST_HEAD(&hctx->dispatch);
+	INIT_HLIST_NODE(&hctx->cpuhp_dead);
+	INIT_HLIST_NODE(&hctx->cpuhp_online);
 	hctx->queue = q;
 	hctx->flags = set->flags & ~BLK_MQ_F_TAG_QUEUE_SHARED;
 
@@ -4278,6 +4353,12 @@ static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
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
 
 static void blk_mq_update_poll_flag(struct request_queue *q)
-- 
2.43.0

