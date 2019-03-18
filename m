Return-Path: <SRS0=WbMh=RV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38D11C43381
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 19:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED8BD20857
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 19:48:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="emSUwi31"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727531AbfCRTs2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Mar 2019 15:48:28 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35352 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726998AbfCRTs2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Mar 2019 15:48:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=AOzvmZMTDIUoOT6CJ2VqA/BjGfuBAonrADJEDHGv3ig=; b=emSUwi31OmJWKAaRNtu2NZ9DQ
        EUn7nGFDPTKiazMoPpqquNl0uSyufvth6k4Nuhac8JYn4Egc3Zn38ITGaC3yVnQfjH4XKfjhpzujt
        HaigJ9fI4hjm2IW59JWeLIW2RQ78cXWjsvLvfA6psBnS096NX6hn2Mo/tA2DTnqbkgYqwUa6DV7Bi
        BrLoPvN4Np6SevKQ46KP5CR5BbtXsfHPpnG3Ek1q1/ZjtDBqKhZTfN+lVi0yTxapHsbZJ3bhn4kOL
        kxq9rxUBBueI3JqVOlQWk3dKF0SEYPYj3i9Bi//i4rrSYcujvyaGJD6WLPZT8kFPocAgOzUnVcBEr
        0vWJdNzJw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h5yFH-0000v8-QT; Mon, 18 Mar 2019 19:48:27 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-block@vger.kernel.org
Cc:     Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 01/14] blk-cgroup: Convert to XArray
Date:   Mon, 18 Mar 2019 12:48:08 -0700
Message-Id: <20190318194821.3470-2-willy@infradead.org>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20190318194821.3470-1-willy@infradead.org>
References: <20190318194821.3470-1-willy@infradead.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

At the point of allocation, we're under not only the xarray lock, but
also under the queue lock.  So we can't drop the lock and retry the
allocation with GFP_KERNEL.  Use xa_insert() of a NULL pointer to ensure
the subsequent store will not need to allocate memory.  Now the store
cannot fail, so we can remove the error checks.

Signed-off-by: Matthew Wilcox <willy@infradead.org>
---
 block/bfq-cgroup.c         |  4 +--
 block/blk-cgroup.c         | 69 ++++++++++++++++----------------------
 include/linux/blk-cgroup.h |  5 ++-
 3 files changed, 33 insertions(+), 45 deletions(-)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index c6113af31960..9d25e490f9fa 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -863,7 +863,7 @@ static int bfq_io_set_weight_legacy(struct cgroup_subsys_state *css,
 		return ret;
 
 	ret = 0;
-	spin_lock_irq(&blkcg->lock);
+	xa_lock_irq(&blkcg->blkg_array);
 	bfqgd->weight = (unsigned short)val;
 	hlist_for_each_entry(blkg, &blkcg->blkg_list, blkcg_node) {
 		struct bfq_group *bfqg = blkg_to_bfqg(blkg);
@@ -897,7 +897,7 @@ static int bfq_io_set_weight_legacy(struct cgroup_subsys_state *css,
 			bfqg->entity.prio_changed = 1;
 		}
 	}
-	spin_unlock_irq(&blkcg->lock);
+	xa_unlock_irq(&blkcg->blkg_array);
 
 	return ret;
 }
diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 77f37ef8ef06..90deb5445332 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -169,12 +169,12 @@ struct blkcg_gq *blkg_lookup_slowpath(struct blkcg *blkcg,
 	struct blkcg_gq *blkg;
 
 	/*
-	 * Hint didn't match.  Look up from the radix tree.  Note that the
+	 * Hint didn't match.  Fetch from the xarray.  Note that the
 	 * hint can only be updated under queue_lock as otherwise @blkg
-	 * could have already been removed from blkg_tree.  The caller is
+	 * could have already been removed from blkg_array.  The caller is
 	 * responsible for grabbing queue_lock if @update_hint.
 	 */
-	blkg = radix_tree_lookup(&blkcg->blkg_tree, q->id);
+	blkg = xa_load(&blkcg->blkg_array, q->id);
 	if (blkg && blkg->q == q) {
 		if (update_hint) {
 			lockdep_assert_held(&q->queue_lock);
@@ -256,29 +256,21 @@ static struct blkcg_gq *blkg_create(struct blkcg *blkcg,
 			pol->pd_init_fn(blkg->pd[i]);
 	}
 
-	/* insert */
-	spin_lock(&blkcg->lock);
-	ret = radix_tree_insert(&blkcg->blkg_tree, q->id, blkg);
-	if (likely(!ret)) {
-		hlist_add_head_rcu(&blkg->blkcg_node, &blkcg->blkg_list);
-		list_add(&blkg->q_node, &q->blkg_list);
+	xa_lock(&blkcg->blkg_array);
+	__xa_store(&blkcg->blkg_array, q->id, blkg, 0);
+	hlist_add_head_rcu(&blkg->blkcg_node, &blkcg->blkg_list);
+	list_add(&blkg->q_node, &q->blkg_list);
 
-		for (i = 0; i < BLKCG_MAX_POLS; i++) {
-			struct blkcg_policy *pol = blkcg_policy[i];
+	for (i = 0; i < BLKCG_MAX_POLS; i++) {
+		struct blkcg_policy *pol = blkcg_policy[i];
 
-			if (blkg->pd[i] && pol->pd_online_fn)
-				pol->pd_online_fn(blkg->pd[i]);
-		}
+		if (blkg->pd[i] && pol->pd_online_fn)
+			pol->pd_online_fn(blkg->pd[i]);
 	}
 	blkg->online = true;
-	spin_unlock(&blkcg->lock);
-
-	if (!ret)
-		return blkg;
+	xa_unlock(&blkcg->blkg_array);
 
-	/* @blkg failed fully initialized, use the usual release path */
-	blkg_put(blkg);
-	return ERR_PTR(ret);
+	return blkg;
 
 err_cancel_ref:
 	percpu_ref_exit(&blkg->refcnt);
@@ -376,7 +368,7 @@ static void blkg_destroy(struct blkcg_gq *blkg)
 	int i;
 
 	lockdep_assert_held(&blkg->q->queue_lock);
-	lockdep_assert_held(&blkcg->lock);
+	lockdep_assert_held(&blkcg->blkg_array.xa_lock);
 
 	/* Something wrong if we are trying to remove same group twice */
 	WARN_ON_ONCE(list_empty(&blkg->q_node));
@@ -396,7 +388,7 @@ static void blkg_destroy(struct blkcg_gq *blkg)
 
 	blkg->online = false;
 
-	radix_tree_delete(&blkcg->blkg_tree, blkg->q->id);
+	__xa_erase(&blkcg->blkg_array, blkg->q->id);
 	list_del_init(&blkg->q_node);
 	hlist_del_init_rcu(&blkg->blkcg_node);
 
@@ -429,9 +421,9 @@ static void blkg_destroy_all(struct request_queue *q)
 	list_for_each_entry_safe(blkg, n, &q->blkg_list, q_node) {
 		struct blkcg *blkcg = blkg->blkcg;
 
-		spin_lock(&blkcg->lock);
+		xa_lock(&blkcg->blkg_array);
 		blkg_destroy(blkg);
-		spin_unlock(&blkcg->lock);
+		xa_unlock(&blkcg->blkg_array);
 	}
 
 	q->root_blkg = NULL;
@@ -446,7 +438,7 @@ static int blkcg_reset_stats(struct cgroup_subsys_state *css,
 	int i;
 
 	mutex_lock(&blkcg_pol_mutex);
-	spin_lock_irq(&blkcg->lock);
+	xa_lock_irq(&blkcg->blkg_array);
 
 	/*
 	 * Note that stat reset is racy - it doesn't synchronize against
@@ -465,7 +457,7 @@ static int blkcg_reset_stats(struct cgroup_subsys_state *css,
 		}
 	}
 
-	spin_unlock_irq(&blkcg->lock);
+	xa_unlock_irq(&blkcg->blkg_array);
 	mutex_unlock(&blkcg_pol_mutex);
 	return 0;
 }
@@ -1084,7 +1076,7 @@ static void blkcg_css_offline(struct cgroup_subsys_state *css)
  */
 void blkcg_destroy_blkgs(struct blkcg *blkcg)
 {
-	spin_lock_irq(&blkcg->lock);
+	xa_lock_irq(&blkcg->blkg_array);
 
 	while (!hlist_empty(&blkcg->blkg_list)) {
 		struct blkcg_gq *blkg = hlist_entry(blkcg->blkg_list.first,
@@ -1095,13 +1087,13 @@ void blkcg_destroy_blkgs(struct blkcg *blkcg)
 			blkg_destroy(blkg);
 			spin_unlock(&q->queue_lock);
 		} else {
-			spin_unlock_irq(&blkcg->lock);
+			xa_unlock_irq(&blkcg->blkg_array);
 			cpu_relax();
-			spin_lock_irq(&blkcg->lock);
+			xa_lock_irq(&blkcg->blkg_array);
 		}
 	}
 
-	spin_unlock_irq(&blkcg->lock);
+	xa_unlock_irq(&blkcg->blkg_array);
 }
 
 static void blkcg_css_free(struct cgroup_subsys_state *css)
@@ -1166,8 +1158,7 @@ blkcg_css_alloc(struct cgroup_subsys_state *parent_css)
 			pol->cpd_init_fn(cpd);
 	}
 
-	spin_lock_init(&blkcg->lock);
-	INIT_RADIX_TREE(&blkcg->blkg_tree, GFP_NOWAIT | __GFP_NOWARN);
+	xa_init_flags(&blkcg->blkg_array, XA_FLAGS_LOCK_IRQ);
 	INIT_HLIST_HEAD(&blkcg->blkg_list);
 #ifdef CONFIG_CGROUP_WRITEBACK
 	INIT_LIST_HEAD(&blkcg->cgwb_list);
@@ -1203,14 +1194,16 @@ blkcg_css_alloc(struct cgroup_subsys_state *parent_css)
 int blkcg_init_queue(struct request_queue *q)
 {
 	struct blkcg_gq *new_blkg, *blkg;
-	bool preloaded;
 	int ret;
 
 	new_blkg = blkg_alloc(&blkcg_root, q, GFP_KERNEL);
 	if (!new_blkg)
 		return -ENOMEM;
 
-	preloaded = !radix_tree_preload(GFP_KERNEL);
+	ret = xa_insert_irq(&blkcg_root.blkg_array, q->id, NULL, GFP_KERNEL);
+	if (ret == -ENOMEM)
+		return -ENOMEM;
+	BUG_ON(ret < 0);
 
 	/* Make sure the root blkg exists. */
 	rcu_read_lock();
@@ -1222,9 +1215,6 @@ int blkcg_init_queue(struct request_queue *q)
 	spin_unlock_irq(&q->queue_lock);
 	rcu_read_unlock();
 
-	if (preloaded)
-		radix_tree_preload_end();
-
 	ret = blk_iolatency_init(q);
 	if (ret)
 		goto err_destroy_all;
@@ -1238,10 +1228,9 @@ int blkcg_init_queue(struct request_queue *q)
 	blkg_destroy_all(q);
 	return ret;
 err_unlock:
+	xa_erase(&blkcg_root.blkg_array, q->id);
 	spin_unlock_irq(&q->queue_lock);
 	rcu_read_unlock();
-	if (preloaded)
-		radix_tree_preload_end();
 	return PTR_ERR(blkg);
 }
 
diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index 76c61318fda5..51530ac5451f 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -17,7 +17,7 @@
 #include <linux/cgroup.h>
 #include <linux/percpu_counter.h>
 #include <linux/seq_file.h>
-#include <linux/radix-tree.h>
+#include <linux/xarray.h>
 #include <linux/blkdev.h>
 #include <linux/atomic.h>
 #include <linux/kthread.h>
@@ -46,9 +46,8 @@ struct blkcg_gq;
 
 struct blkcg {
 	struct cgroup_subsys_state	css;
-	spinlock_t			lock;
 
-	struct radix_tree_root		blkg_tree;
+	struct xarray			blkg_array;
 	struct blkcg_gq	__rcu		*blkg_hint;
 	struct hlist_head		blkg_list;
 
-- 
2.20.1

