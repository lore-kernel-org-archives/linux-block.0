Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299353B9619
	for <linux-block@vger.kernel.org>; Thu, 15 Jan 2026 16:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768495137; cv=none; b=lEZ8/dL0x6jyFRaLgya2OiPQHWpLvUnvoKoYgGXWTzFi272e8W7z/XLVnLfF1sVkG8YVzQA70fbloGxDH+EIClpC1v6jE5Kr8qOS2L83RSWEC3HfMHlyVyVbbzG/yopaXHUPixN9FEiWo1W5UXq9zQ0O77y+3JfRNHGRQlbcmZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768495137; c=relaxed/simple;
	bh=Cnpho0AVBHmQTj4A5OQUYiDhYrEyr9z1KgKgeAKHq44=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gMjC8Vfr1tIULbFtS4JLItnpAoykqx1Ml5W1rlAtTQhatcJYKBozb7ZC1PAOAyTfnjyQcLHrgK4uqIfYXck4jbbI7uyxEios9uFM/lj7fr/af8PK+2NXeme4MAeq1cZHRuIzwQIPKkp4oGmsYPodZ+K6cDnkD7MLeLl6g4YzSQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30046C16AAE;
	Thu, 15 Jan 2026 16:38:52 +0000 (UTC)
From: Yu Kuai <yukuai@fnnas.com>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org,
	tj@kernel.org,
	nilay@linux.ibm.com,
	ming.lei@redhat.com
Cc: yukuai@fnnas.com,
	zhengqixing@huawei.com,
	mkoutny@suse.com,
	hch@infradead.org
Subject: [PATCH 6/6] blk-cgroup: allocate pds before freezing queue in blkcg_activate_policy()
Date: Fri, 16 Jan 2026 00:38:18 +0800
Message-ID: <20260115163818.162968-7-yukuai@fnnas.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260115163818.162968-1-yukuai@fnnas.com>
References: <20260115163818.162968-1-yukuai@fnnas.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some policies like iocost and iolatency perform percpu allocation in
pd_alloc_fn(). Percpu allocation with queue frozen can cause deadlock
because percpu memory reclaim may issue IO.

Now that q->blkg_list is protected by blkcg_mutex, restructure
blkcg_activate_policy() to allocate all pds before freezing the queue:
1. Allocate all pds with GFP_KERNEL before freezing the queue
2. Freeze the queue
3. Initialize and online all pds

Note: Future work is to remove all queue freezing before
blkcg_activate_policy() to fix the deadlocks thoroughly.

Signed-off-by: Yu Kuai <yukuai@fnnas.com>
---
 block/blk-cgroup.c | 90 ++++++++++++++++------------------------------
 1 file changed, 31 insertions(+), 59 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 573f2d93a261..88dbb5bdd6f7 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1606,8 +1606,7 @@ static void blkcg_policy_teardown_pds(struct request_queue *q,
 int blkcg_activate_policy(struct gendisk *disk, const struct blkcg_policy *pol)
 {
 	struct request_queue *q = disk->queue;
-	struct blkg_policy_data *pd_prealloc = NULL;
-	struct blkcg_gq *blkg, *pinned_blkg = NULL;
+	struct blkcg_gq *blkg;
 	unsigned int memflags;
 	int ret;
 
@@ -1622,90 +1621,63 @@ int blkcg_activate_policy(struct gendisk *disk, const struct blkcg_policy *pol)
 	if (WARN_ON_ONCE(!pol->pd_alloc_fn || !pol->pd_free_fn))
 		return -EINVAL;
 
-	if (queue_is_mq(q))
-		memflags = blk_mq_freeze_queue(q);
-
+	/*
+	 * Allocate all pds before freezing queue. Some policies like iocost
+	 * and iolatency do percpu allocation in pd_alloc_fn(), which can
+	 * deadlock with queue frozen because percpu memory reclaim may issue
+	 * IO. blkcg_mutex protects q->blkg_list iteration.
+	 */
 	mutex_lock(&q->blkcg_mutex);
-retry:
-	spin_lock_irq(&q->queue_lock);
-
-	/* blkg_list is pushed at the head, reverse walk to initialize parents first */
 	list_for_each_entry_reverse(blkg, &q->blkg_list, q_node) {
 		struct blkg_policy_data *pd;
 
-		if (blkg->pd[pol->plid])
+		/* Skip dying blkg */
+		if (hlist_unhashed(&blkg->blkcg_node))
 			continue;
 
-		/* If prealloc matches, use it; otherwise try GFP_NOWAIT */
-		if (blkg == pinned_blkg) {
-			pd = pd_prealloc;
-			pd_prealloc = NULL;
-		} else {
-			pd = pol->pd_alloc_fn(disk, blkg->blkcg,
-					      GFP_NOWAIT);
-		}
-
+		pd = pol->pd_alloc_fn(disk, blkg->blkcg, GFP_KERNEL);
 		if (!pd) {
-			/*
-			 * GFP_NOWAIT failed.  Free the existing one and
-			 * prealloc for @blkg w/ GFP_KERNEL.
-			 */
-			if (hlist_unhashed(&blkg->blkcg_node))
-				continue;
-			if (pinned_blkg)
-				blkg_put(pinned_blkg);
-			blkg_get(blkg);
-			pinned_blkg = blkg;
-
-			spin_unlock_irq(&q->queue_lock);
-
-			if (pd_prealloc)
-				pol->pd_free_fn(pd_prealloc);
-			pd_prealloc = pol->pd_alloc_fn(disk, blkg->blkcg,
-						       GFP_KERNEL);
-			if (pd_prealloc)
-				goto retry;
-			else
-				goto enomem;
+			ret = -ENOMEM;
+			goto err_teardown;
 		}
 
-		spin_lock(&blkg->blkcg->lock);
-
 		pd->blkg = blkg;
 		pd->plid = pol->plid;
+		pd->online = false;
 		blkg->pd[pol->plid] = pd;
+	}
 
+	/* Now freeze queue and initialize/online all pds */
+	if (queue_is_mq(q))
+		memflags = blk_mq_freeze_queue(q);
+
+	spin_lock_irq(&q->queue_lock);
+	list_for_each_entry_reverse(blkg, &q->blkg_list, q_node) {
+		struct blkg_policy_data *pd = blkg->pd[pol->plid];
+
+		/* Skip dying blkg */
+		if (hlist_unhashed(&blkg->blkcg_node))
+			continue;
+
+		spin_lock(&blkg->blkcg->lock);
 		if (pol->pd_init_fn)
 			pol->pd_init_fn(pd);
-
 		if (pol->pd_online_fn)
 			pol->pd_online_fn(pd);
 		pd->online = true;
-
 		spin_unlock(&blkg->blkcg->lock);
 	}
 
 	__set_bit(pol->plid, q->blkcg_pols);
-	ret = 0;
-
 	spin_unlock_irq(&q->queue_lock);
-out:
-	mutex_unlock(&q->blkcg_mutex);
+
 	if (queue_is_mq(q))
 		blk_mq_unfreeze_queue(q, memflags);
-	if (pinned_blkg)
-		blkg_put(pinned_blkg);
-	if (pd_prealloc)
-		pol->pd_free_fn(pd_prealloc);
-	return ret;
+	mutex_unlock(&q->blkcg_mutex);
+	return 0;
 
-enomem:
-	/* alloc failed, take down everything */
-	spin_lock_irq(&q->queue_lock);
+err_teardown:
 	blkcg_policy_teardown_pds(q, pol);
-	spin_unlock_irq(&q->queue_lock);
-	ret = -ENOMEM;
-	goto out;
+	mutex_unlock(&q->blkcg_mutex);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(blkcg_activate_policy);
 
-- 
2.51.0

