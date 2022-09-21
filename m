Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29478ECAAD8
	for <linux-block@archiver.kernel.org>; Wed, 21 Sep 2022 18:05:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbiIUSFR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Sep 2022 14:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbiIUSFQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Sep 2022 14:05:16 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1F5D4B0FC
        for <linux-block@vger.kernel.org>; Wed, 21 Sep 2022 11:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=w1kAA5r5tTq/ndH/roZVwTLBiw9ABOt0C8Q0F3avUfQ=; b=0WO+SmdRlEWSd2NRWGA83ZmsxZ
        ARq02D6EgAfEq6vp2S94XV3a1BjoI3XSoCcb2nLFr7GQoiFWZqWvvmm7N8d0BqykIPGKlAGOO1qRx
        PZv+TaN4Nerzb9uMFlhzUlDCmGg8FSmmrBqQLgz8S7Wi8COVmcb1Dep3E0SKD4anoKCSb90KOWbx2
        qCrlvorxi0y6njKuB59Yh9mBhalrYPMMnOUKCrjrnGlGcRAtG4coWH0aDwb6D+ADONm3FPZCia775
        gp5NeUIBDJ5XZhbB11y1tV3Qj6qG58LAhEC0oyEF5UPSPJC8V5EyiFj0IoEOJnFXlaxx2UIiU6KPo
        9pVDUuBA==;
Received: from ip4d15bec4.dynamic.kabel-deutschland.de ([77.21.190.196] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ob45x-00CGWe-Fr; Wed, 21 Sep 2022 18:05:13 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 04/17] blk-cgroup: cleanup the blkg_lookup family of functions
Date:   Wed, 21 Sep 2022 20:04:48 +0200
Message-Id: <20220921180501.1539876-5-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220921180501.1539876-1-hch@lst.de>
References: <20220921180501.1539876-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add a fully inlined blkg_lookup as the extra two checks aren't going
to generated a lot more code vs the call to the slowpath routine, and
open code the hint update in the two callers that care.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-cgroup.c | 38 +++++++++++++++-----------------------
 block/blk-cgroup.h | 39 ++++++++++++---------------------------
 2 files changed, 27 insertions(+), 50 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index b9a1dcee5a244..d1216760d0255 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -263,29 +263,13 @@ static struct blkcg_gq *blkg_alloc(struct blkcg *blkcg, struct request_queue *q,
 	return NULL;
 }
 
-struct blkcg_gq *blkg_lookup_slowpath(struct blkcg *blkcg,
-				      struct request_queue *q, bool update_hint)
+static void blkg_update_hint(struct blkcg *blkcg, struct blkcg_gq *blkg)
 {
-	struct blkcg_gq *blkg;
-
-	/*
-	 * Hint didn't match.  Look up from the radix tree.  Note that the
-	 * hint can only be updated under queue_lock as otherwise @blkg
-	 * could have already been removed from blkg_tree.  The caller is
-	 * responsible for grabbing queue_lock if @update_hint.
-	 */
-	blkg = radix_tree_lookup(&blkcg->blkg_tree, q->id);
-	if (blkg && blkg->q == q) {
-		if (update_hint) {
-			lockdep_assert_held(&q->queue_lock);
-			rcu_assign_pointer(blkcg->blkg_hint, blkg);
-		}
-		return blkg;
-	}
+	lockdep_assert_held(&blkg->q->queue_lock);
 
-	return NULL;
+	if (blkcg != &blkcg_root && blkg != rcu_dereference(blkcg->blkg_hint))
+		rcu_assign_pointer(blkcg->blkg_hint, blkg);
 }
-EXPORT_SYMBOL_GPL(blkg_lookup_slowpath);
 
 /*
  * If @new_blkg is %NULL, this function tries to allocate a new one as
@@ -397,9 +381,11 @@ static struct blkcg_gq *blkg_lookup_create(struct blkcg *blkcg,
 		return blkg;
 
 	spin_lock_irqsave(&q->queue_lock, flags);
-	blkg = __blkg_lookup(blkcg, q, true);
-	if (blkg)
+	blkg = blkg_lookup(blkcg, q);
+	if (blkg) {
+		blkg_update_hint(blkcg, blkg);
 		goto found;
+	}
 
 	/*
 	 * Create blkgs walking down from blkcg_root to @blkcg, so that all
@@ -621,12 +607,18 @@ static struct blkcg_gq *blkg_lookup_check(struct blkcg *blkcg,
 					  const struct blkcg_policy *pol,
 					  struct request_queue *q)
 {
+	struct blkcg_gq *blkg;
+
 	WARN_ON_ONCE(!rcu_read_lock_held());
 	lockdep_assert_held(&q->queue_lock);
 
 	if (!blkcg_policy_enabled(q, pol))
 		return ERR_PTR(-EOPNOTSUPP);
-	return __blkg_lookup(blkcg, q, true /* update_hint */);
+
+	blkg = blkg_lookup(blkcg, q);
+	if (blkg)
+		blkg_update_hint(blkcg, blkg);
+	return blkg;
 }
 
 /**
diff --git a/block/blk-cgroup.h b/block/blk-cgroup.h
index 30396cad50e9a..91b7ae0773be6 100644
--- a/block/blk-cgroup.h
+++ b/block/blk-cgroup.h
@@ -178,8 +178,6 @@ struct blkcg_policy {
 extern struct blkcg blkcg_root;
 extern bool blkcg_debug_stats;
 
-struct blkcg_gq *blkg_lookup_slowpath(struct blkcg *blkcg,
-				      struct request_queue *q, bool update_hint);
 int blkcg_init_queue(struct request_queue *q);
 void blkcg_exit_queue(struct request_queue *q);
 
@@ -227,22 +225,21 @@ static inline bool bio_issue_as_root_blkg(struct bio *bio)
 }
 
 /**
- * __blkg_lookup - internal version of blkg_lookup()
+ * blkg_lookup - lookup blkg for the specified blkcg - q pair
  * @blkcg: blkcg of interest
  * @q: request_queue of interest
- * @update_hint: whether to update lookup hint with the result or not
  *
- * This is internal version and shouldn't be used by policy
- * implementations.  Looks up blkgs for the @blkcg - @q pair regardless of
- * @q's bypass state.  If @update_hint is %true, the caller should be
- * holding @q->queue_lock and lookup hint is updated on success.
+ * Lookup blkg for the @blkcg - @q pair.
+
+ * Must be called in a RCU critical section.
  */
-static inline struct blkcg_gq *__blkg_lookup(struct blkcg *blkcg,
-					     struct request_queue *q,
-					     bool update_hint)
+static inline struct blkcg_gq *blkg_lookup(struct blkcg *blkcg,
+					   struct request_queue *q)
 {
 	struct blkcg_gq *blkg;
 
+	WARN_ON_ONCE(!rcu_read_lock_held());
+
 	if (blkcg == &blkcg_root)
 		return q->root_blkg;
 
@@ -250,22 +247,10 @@ static inline struct blkcg_gq *__blkg_lookup(struct blkcg *blkcg,
 	if (blkg && blkg->q == q)
 		return blkg;
 
-	return blkg_lookup_slowpath(blkcg, q, update_hint);
-}
-
-/**
- * blkg_lookup - lookup blkg for the specified blkcg - q pair
- * @blkcg: blkcg of interest
- * @q: request_queue of interest
- *
- * Lookup blkg for the @blkcg - @q pair.  This function should be called
- * under RCU read lock.
- */
-static inline struct blkcg_gq *blkg_lookup(struct blkcg *blkcg,
-					   struct request_queue *q)
-{
-	WARN_ON_ONCE(!rcu_read_lock_held());
-	return __blkg_lookup(blkcg, q, false);
+	blkg = radix_tree_lookup(&blkcg->blkg_tree, q->id);
+	if (blkg && blkg->q != q)
+		blkg = NULL;
+	return blkg;
 }
 
 /**
-- 
2.30.2

