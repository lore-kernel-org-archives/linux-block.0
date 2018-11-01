Return-Path: <dennisszhou@gmail.com>
Return-Path: <dennisszhou@gmail.com>
From: Dennis Zhou <dennis@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Tejun Heo <tj@kernel.org>,
	kernel-team@fb.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dennis Zhou <dennis@kernel.org>
Subject: [PATCH] blkcg: revert blkcg cleanups series
Date: Thu,  1 Nov 2018 17:24:10 -0400
Message-Id: <20181101212410.47569-1-dennis@kernel.org>
List-ID: <linux-block@vger.kernel.org>

This reverts a series committed earlier due to null pointer exception
bug report in [1]. It seems there are edge case interactions that I did
not consider and will need some time to understand what causes the
adverse interactions.

The original series can be found in [2] with a follow up series in [3].

[1] https://www.spinics.net/lists/cgroups/msg20719.html
[2] https://lore.kernel.org/lkml/20180911184137.35897-1-dennisszhou@gmail.com/
[3] https://lore.kernel.org/lkml/20181020185612.51587-1-dennis@kernel.org/

This reverts the following commits:
d459d853c2ed, b2c3fa546705, 101246ec02b5, b3b9f24f5fcc, e2b0989954ae,
f0fcb3ec89f3, c839e7a03f92, bdc2491708c4, 74b7c02a9bc1, 5bf9a1f3b4ef,
a7b39b4e961c, 07b05bcc3213, 49f4c2dc2b50, 27e6fa996c53

Signed-off-by: Dennis Zhou <dennis@kernel.org>
---
 Documentation/admin-guide/cgroup-v2.rst |   8 +-
 block/bfq-cgroup.c                      |   4 +-
 block/bfq-iosched.c                     |   2 +-
 block/bio.c                             | 174 +++++++-----------------
 block/blk-cgroup.c                      | 123 ++++++-----------
 block/blk-core.c                        |   1 -
 block/blk-iolatency.c                   |  26 +++-
 block/blk-throttle.c                    |  13 +-
 block/bounce.c                          |   4 +-
 block/cfq-iosched.c                     |   4 +-
 drivers/block/loop.c                    |   5 +-
 drivers/md/raid0.c                      |   2 +-
 fs/buffer.c                             |  10 +-
 fs/ext4/page-io.c                       |   2 +-
 include/linux/bio.h                     |  26 ++--
 include/linux/blk-cgroup.h              | 145 ++++++--------------
 include/linux/blk_types.h               |   1 +
 include/linux/cgroup.h                  |   2 -
 include/linux/writeback.h               |   5 +-
 kernel/cgroup/cgroup.c                  |  48 ++-----
 kernel/trace/blktrace.c                 |   4 +-
 mm/page_io.c                            |   2 +-
 22 files changed, 208 insertions(+), 403 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index caf36105a1c7..184193bcb262 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1857,10 +1857,8 @@ following two functions.
 
   wbc_init_bio(@wbc, @bio)
 	Should be called for each bio carrying writeback data and
-	associates the bio with the inode's owner cgroup and the
-	corresponding request queue.  This must be called after
-	a queue (device) has been associated with the bio and
-	before submission.
+	associates the bio with the inode's owner cgroup.  Can be
+	called anytime between bio allocation and submission.
 
   wbc_account_io(@wbc, @page, @bytes)
 	Should be called for each data segment being written out.
@@ -1879,7 +1877,7 @@ the configuration, the bio may be executed at a lower priority and if
 the writeback session is holding shared resources, e.g. a journal
 entry, may lead to priority inversion.  There is no one easy solution
 for the problem.  Filesystems can try to work around specific problem
-cases by skipping wbc_init_bio() or using bio_associate_create_blkg()
+cases by skipping wbc_init_bio() or using bio_associate_blkcg()
 directly.
 
 
diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index d9a7916ff0ab..9fe5952d117d 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -642,7 +642,7 @@ void bfq_bic_update_cgroup(struct bfq_io_cq *bic, struct bio *bio)
 	uint64_t serial_nr;
 
 	rcu_read_lock();
-	serial_nr = __bio_blkcg(bio)->css.serial_nr;
+	serial_nr = bio_blkcg(bio)->css.serial_nr;
 
 	/*
 	 * Check whether blkcg has changed.  The condition may trigger
@@ -651,7 +651,7 @@ void bfq_bic_update_cgroup(struct bfq_io_cq *bic, struct bio *bio)
 	if (unlikely(!bfqd) || likely(bic->blkcg_serial_nr == serial_nr))
 		goto out;
 
-	bfqg = __bfq_bic_change_cgroup(bfqd, bic, __bio_blkcg(bio));
+	bfqg = __bfq_bic_change_cgroup(bfqd, bic, bio_blkcg(bio));
 	/*
 	 * Update blkg_path for bfq_log_* functions. We cache this
 	 * path, and update it here, for the following
diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 6075100f03a5..3a27d31fcda6 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -4384,7 +4384,7 @@ static struct bfq_queue *bfq_get_queue(struct bfq_data *bfqd,
 
 	rcu_read_lock();
 
-	bfqg = bfq_find_set_group(bfqd, __bio_blkcg(bio));
+	bfqg = bfq_find_set_group(bfqd, bio_blkcg(bio));
 	if (!bfqg) {
 		bfqq = &bfqd->oom_bfqq;
 		goto out;
diff --git a/block/bio.c b/block/bio.c
index bbfeb4ee2892..4a5a036268fb 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -609,9 +609,7 @@ void __bio_clone_fast(struct bio *bio, struct bio *bio_src)
 	bio->bi_iter = bio_src->bi_iter;
 	bio->bi_io_vec = bio_src->bi_io_vec;
 
-	bio_clone_blkg_association(bio, bio_src);
-
-	blkcg_bio_issue_init(bio);
+	bio_clone_blkcg_association(bio, bio_src);
 }
 EXPORT_SYMBOL(__bio_clone_fast);
 
@@ -1956,151 +1954,69 @@ EXPORT_SYMBOL(bioset_init_from_src);
 
 #ifdef CONFIG_BLK_CGROUP
 
-/**
- * bio_associate_blkg - associate a bio with the a blkg
- * @bio: target bio
- * @blkg: the blkg to associate
- *
- * This tries to associate @bio with the specified blkg.  Association failure
- * is handled by walking up the blkg tree.  Therefore, the blkg associated can
- * be anything between @blkg and the root_blkg.  This situation only happens
- * when a cgroup is dying and then the remaining bios will spill to the closest
- * alive blkg.
- *
- * A reference will be taken on the @blkg and will be released when @bio is
- * freed.
- */
-int bio_associate_blkg(struct bio *bio, struct blkcg_gq *blkg)
-{
-	if (unlikely(bio->bi_blkg))
-		return -EBUSY;
-	bio->bi_blkg = blkg_tryget_closest(blkg);
-	return 0;
-}
-
-/**
- * __bio_associate_blkg_from_css - internal blkg association function
- *
- * This in the core association function that all association paths rely on.
- * A blkg reference is taken which is released upon freeing of the bio.
- */
-static int __bio_associate_blkg_from_css(struct bio *bio,
-					 struct cgroup_subsys_state *css)
-{
-	struct request_queue *q = bio->bi_disk->queue;
-	struct blkcg_gq *blkg;
-	int ret;
-
-	rcu_read_lock();
-
-	if (!css || !css->parent)
-		blkg = q->root_blkg;
-	else
-		blkg = blkg_lookup_create(css_to_blkcg(css), q);
-
-	ret = bio_associate_blkg(bio, blkg);
-
-	rcu_read_unlock();
-	return ret;
-}
-
-/**
- * bio_associate_blkg_from_css - associate a bio with a specified css
- * @bio: target bio
- * @css: target css
- *
- * Associate @bio with the blkg found by combining the css's blkg and the
- * request_queue of the @bio.  This falls back to the queue's root_blkg if
- * the association fails with the css.
- */
-int bio_associate_blkg_from_css(struct bio *bio,
-				struct cgroup_subsys_state *css)
-{
-	if (unlikely(bio->bi_blkg))
-		return -EBUSY;
-	return __bio_associate_blkg_from_css(bio, css);
-}
-EXPORT_SYMBOL_GPL(bio_associate_blkg_from_css);
-
 #ifdef CONFIG_MEMCG
 /**
- * bio_associate_blkg_from_page - associate a bio with the page's blkg
+ * bio_associate_blkcg_from_page - associate a bio with the page's blkcg
  * @bio: target bio
  * @page: the page to lookup the blkcg from
  *
- * Associate @bio with the blkg from @page's owning memcg and the respective
- * request_queue.  If cgroup_e_css returns NULL, fall back to the queue's
- * root_blkg.
- *
- * Note: this must be called after bio has an associated device.
+ * Associate @bio with the blkcg from @page's owning memcg.  This works like
+ * every other associate function wrt references.
  */
-int bio_associate_blkg_from_page(struct bio *bio, struct page *page)
+int bio_associate_blkcg_from_page(struct bio *bio, struct page *page)
 {
-	struct cgroup_subsys_state *css;
-	int ret;
+	struct cgroup_subsys_state *blkcg_css;
 
-	if (unlikely(bio->bi_blkg))
+	if (unlikely(bio->bi_css))
 		return -EBUSY;
 	if (!page->mem_cgroup)
 		return 0;
-
-	rcu_read_lock();
-
-	css = cgroup_e_css(page->mem_cgroup->css.cgroup, &io_cgrp_subsys);
-
-	ret = __bio_associate_blkg_from_css(bio, css);
-
-	rcu_read_unlock();
-	return ret;
+	blkcg_css = cgroup_get_e_css(page->mem_cgroup->css.cgroup,
+				     &io_cgrp_subsys);
+	bio->bi_css = blkcg_css;
+	return 0;
 }
 #endif /* CONFIG_MEMCG */
 
 /**
- * bio_associate_create_blkg - associate a bio with a blkg from q
- * @q: request_queue where bio is going
+ * bio_associate_blkcg - associate a bio with the specified blkcg
  * @bio: target bio
+ * @blkcg_css: css of the blkcg to associate
+ *
+ * Associate @bio with the blkcg specified by @blkcg_css.  Block layer will
+ * treat @bio as if it were issued by a task which belongs to the blkcg.
  *
- * Associate @bio with the blkg found from the bio's css and the request_queue.
- * If one is not found, bio_lookup_blkg creates the blkg.  This falls back to
- * the queue's root_blkg if association fails.
+ * This function takes an extra reference of @blkcg_css which will be put
+ * when @bio is released.  The caller must own @bio and is responsible for
+ * synchronizing calls to this function.
  */
-int bio_associate_create_blkg(struct request_queue *q, struct bio *bio)
+int bio_associate_blkcg(struct bio *bio, struct cgroup_subsys_state *blkcg_css)
 {
-	struct cgroup_subsys_state *css;
-	int ret = 0;
-
-	/* someone has already associated this bio with a blkg */
-	if (bio->bi_blkg)
-		return ret;
-
-	rcu_read_lock();
-
-	css = blkcg_css();
-
-	ret = __bio_associate_blkg_from_css(bio, css);
-
-	rcu_read_unlock();
-	return ret;
+	if (unlikely(bio->bi_css))
+		return -EBUSY;
+	css_get(blkcg_css);
+	bio->bi_css = blkcg_css;
+	return 0;
 }
+EXPORT_SYMBOL_GPL(bio_associate_blkcg);
 
 /**
- * bio_reassociate_blkg - reassociate a bio with a blkg from q
- * @q: request_queue where bio is going
+ * bio_associate_blkg - associate a bio with the specified blkg
  * @bio: target bio
+ * @blkg: the blkg to associate
  *
- * When submitting a bio, multiple recursive calls to make_request() may occur.
- * This causes the initial associate done in blkcg_bio_issue_check() to be
- * incorrect and reference the prior request_queue.  This performs reassociation
- * when this situation happens.
+ * Associate @bio with the blkg specified by @blkg.  This is the queue specific
+ * blkcg information associated with the @bio, a reference will be taken on the
+ * @blkg and will be freed when the bio is freed.
  */
-int bio_reassociate_blkg(struct request_queue *q, struct bio *bio)
+int bio_associate_blkg(struct bio *bio, struct blkcg_gq *blkg)
 {
-	if (bio->bi_blkg) {
-		blkg_put(bio->bi_blkg);
-		bio->bi_blkg = NULL;
-	}
-
-	return bio_associate_create_blkg(q, bio);
+	if (unlikely(bio->bi_blkg))
+		return -EBUSY;
+	if (!blkg_try_get(blkg))
+		return -ENODEV;
+	bio->bi_blkg = blkg;
+	return 0;
 }
 
 /**
@@ -2113,6 +2029,10 @@ void bio_disassociate_task(struct bio *bio)
 		put_io_context(bio->bi_ioc);
 		bio->bi_ioc = NULL;
 	}
+	if (bio->bi_css) {
+		css_put(bio->bi_css);
+		bio->bi_css = NULL;
+	}
 	if (bio->bi_blkg) {
 		blkg_put(bio->bi_blkg);
 		bio->bi_blkg = NULL;
@@ -2120,16 +2040,16 @@ void bio_disassociate_task(struct bio *bio)
 }
 
 /**
- * bio_clone_blkg_association - clone blkg association from src to dst bio
+ * bio_clone_blkcg_association - clone blkcg association from src to dst bio
  * @dst: destination bio
  * @src: source bio
  */
-void bio_clone_blkg_association(struct bio *dst, struct bio *src)
+void bio_clone_blkcg_association(struct bio *dst, struct bio *src)
 {
-	if (src->bi_blkg)
-		bio_associate_blkg(dst, src->bi_blkg);
+	if (src->bi_css)
+		WARN_ON(bio_associate_blkcg(dst, src->bi_css));
 }
-EXPORT_SYMBOL_GPL(bio_clone_blkg_association);
+EXPORT_SYMBOL_GPL(bio_clone_blkcg_association);
 #endif /* CONFIG_BLK_CGROUP */
 
 static void __init biovec_init_slabs(void)
diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 992da5592c6e..c630e02836a8 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -84,37 +84,6 @@ static void blkg_free(struct blkcg_gq *blkg)
 	kfree(blkg);
 }
 
-static void __blkg_release(struct rcu_head *rcu)
-{
-	struct blkcg_gq *blkg = container_of(rcu, struct blkcg_gq, rcu_head);
-
-	percpu_ref_exit(&blkg->refcnt);
-
-	/* release the blkcg and parent blkg refs this blkg has been holding */
-	css_put(&blkg->blkcg->css);
-	if (blkg->parent)
-		blkg_put(blkg->parent);
-
-	wb_congested_put(blkg->wb_congested);
-
-	blkg_free(blkg);
-}
-
-/*
- * A group is RCU protected, but having an rcu lock does not mean that one
- * can access all the fields of blkg and assume these are valid.  For
- * example, don't try to follow throtl_data and request queue links.
- *
- * Having a reference to blkg under an rcu allows accesses to only values
- * local to groups like group stats and group rate limits.
- */
-static void blkg_release(struct percpu_ref *ref)
-{
-	struct blkcg_gq *blkg = container_of(ref, struct blkcg_gq, refcnt);
-
-	call_rcu(&blkg->rcu_head, __blkg_release);
-}
-
 /**
  * blkg_alloc - allocate a blkg
  * @blkcg: block cgroup the new blkg is associated with
@@ -141,6 +110,7 @@ static struct blkcg_gq *blkg_alloc(struct blkcg *blkcg, struct request_queue *q,
 	blkg->q = q;
 	INIT_LIST_HEAD(&blkg->q_node);
 	blkg->blkcg = blkcg;
+	atomic_set(&blkg->refcnt, 1);
 
 	/* root blkg uses @q->root_rl, init rl only for !root blkgs */
 	if (blkcg != &blkcg_root) {
@@ -247,11 +217,6 @@ static struct blkcg_gq *blkg_create(struct blkcg *blkcg,
 		blkg_get(blkg->parent);
 	}
 
-	ret = percpu_ref_init(&blkg->refcnt, blkg_release, 0,
-			      GFP_NOWAIT | __GFP_NOWARN);
-	if (ret)
-		goto err_cancel_ref;
-
 	/* invoke per-policy init */
 	for (i = 0; i < BLKCG_MAX_POLS; i++) {
 		struct blkcg_policy *pol = blkcg_policy[i];
@@ -284,8 +249,6 @@ static struct blkcg_gq *blkg_create(struct blkcg *blkcg,
 	blkg_put(blkg);
 	return ERR_PTR(ret);
 
-err_cancel_ref:
-	percpu_ref_exit(&blkg->refcnt);
 err_put_congested:
 	wb_congested_put(wb_congested);
 err_put_css:
@@ -296,7 +259,7 @@ static struct blkcg_gq *blkg_create(struct blkcg *blkcg,
 }
 
 /**
- * __blkg_lookup_create - lookup blkg, try to create one if not there
+ * blkg_lookup_create - lookup blkg, try to create one if not there
  * @blkcg: blkcg of interest
  * @q: request_queue of interest
  *
@@ -305,11 +268,12 @@ static struct blkcg_gq *blkg_create(struct blkcg *blkcg,
  * that all non-root blkg's have access to the parent blkg.  This function
  * should be called under RCU read lock and @q->queue_lock.
  *
- * Returns the blkg or the closest blkg if blkg_create fails as it walks
- * down from root.
+ * Returns pointer to the looked up or created blkg on success, ERR_PTR()
+ * value on error.  If @q is dead, returns ERR_PTR(-EINVAL).  If @q is not
+ * dead and bypassing, returns ERR_PTR(-EBUSY).
  */
-struct blkcg_gq *__blkg_lookup_create(struct blkcg *blkcg,
-				      struct request_queue *q)
+struct blkcg_gq *blkg_lookup_create(struct blkcg *blkcg,
+				    struct request_queue *q)
 {
 	struct blkcg_gq *blkg;
 
@@ -321,7 +285,7 @@ struct blkcg_gq *__blkg_lookup_create(struct blkcg *blkcg,
 	 * we shouldn't allow anything to go through for a bypassing queue.
 	 */
 	if (unlikely(blk_queue_bypass(q)))
-		return q->root_blkg;
+		return ERR_PTR(blk_queue_dying(q) ? -ENODEV : -EBUSY);
 
 	blkg = __blkg_lookup(blkcg, q, true);
 	if (blkg)
@@ -329,58 +293,23 @@ struct blkcg_gq *__blkg_lookup_create(struct blkcg *blkcg,
 
 	/*
 	 * Create blkgs walking down from blkcg_root to @blkcg, so that all
-	 * non-root blkgs have access to their parents.  Returns the closest
-	 * blkg to the intended blkg should blkg_create() fail.
+	 * non-root blkgs have access to their parents.
 	 */
 	while (true) {
 		struct blkcg *pos = blkcg;
 		struct blkcg *parent = blkcg_parent(blkcg);
-		struct blkcg_gq *ret_blkg = q->root_blkg;
-
-		while (parent) {
-			blkg = __blkg_lookup(parent, q, false);
-			if (blkg) {
-				/* remember closest blkg */
-				ret_blkg = blkg;
-				break;
-			}
+
+		while (parent && !__blkg_lookup(parent, q, false)) {
 			pos = parent;
 			parent = blkcg_parent(parent);
 		}
 
 		blkg = blkg_create(pos, q, NULL);
-		if (IS_ERR(blkg))
-			return ret_blkg;
-		if (pos == blkcg)
+		if (pos == blkcg || IS_ERR(blkg))
 			return blkg;
 	}
 }
 
-/**
- * blkg_lookup_create - find or create a blkg
- * @blkcg: target block cgroup
- * @q: target request_queue
- *
- * This looks up or creates the blkg representing the unique pair
- * of the blkcg and the request_queue.
- */
-struct blkcg_gq *blkg_lookup_create(struct blkcg *blkcg,
-				    struct request_queue *q)
-{
-	struct blkcg_gq *blkg = blkg_lookup(blkcg, q);
-	unsigned long flags;
-
-	if (unlikely(!blkg)) {
-		spin_lock_irqsave(q->queue_lock, flags);
-
-		blkg = __blkg_lookup_create(blkcg, q);
-
-		spin_unlock_irqrestore(q->queue_lock, flags);
-	}
-
-	return blkg;
-}
-
 static void blkg_destroy(struct blkcg_gq *blkg)
 {
 	struct blkcg *blkcg = blkg->blkcg;
@@ -424,7 +353,7 @@ static void blkg_destroy(struct blkcg_gq *blkg)
 	 * Put the reference taken at the time of creation so that when all
 	 * queues are gone, group can be destroyed.
 	 */
-	percpu_ref_kill(&blkg->refcnt);
+	blkg_put(blkg);
 }
 
 /**
@@ -451,6 +380,29 @@ static void blkg_destroy_all(struct request_queue *q)
 	q->root_rl.blkg = NULL;
 }
 
+/*
+ * A group is RCU protected, but having an rcu lock does not mean that one
+ * can access all the fields of blkg and assume these are valid.  For
+ * example, don't try to follow throtl_data and request queue links.
+ *
+ * Having a reference to blkg under an rcu allows accesses to only values
+ * local to groups like group stats and group rate limits.
+ */
+void __blkg_release_rcu(struct rcu_head *rcu_head)
+{
+	struct blkcg_gq *blkg = container_of(rcu_head, struct blkcg_gq, rcu_head);
+
+	/* release the blkcg and parent blkg refs this blkg has been holding */
+	css_put(&blkg->blkcg->css);
+	if (blkg->parent)
+		blkg_put(blkg->parent);
+
+	wb_congested_put(blkg->wb_congested);
+
+	blkg_free(blkg);
+}
+EXPORT_SYMBOL_GPL(__blkg_release_rcu);
+
 /*
  * The next function used by blk_queue_for_each_rl().  It's a bit tricky
  * because the root blkg uses @q->root_rl instead of its own rl.
@@ -1796,7 +1748,8 @@ void blkcg_maybe_throttle_current(void)
 	blkg = blkg_lookup(blkcg, q);
 	if (!blkg)
 		goto out;
-	if (!blkg_tryget(blkg))
+	blkg = blkg_try_get(blkg);
+	if (!blkg)
 		goto out;
 	rcu_read_unlock();
 
diff --git a/block/blk-core.c b/block/blk-core.c
index 3ed60723e242..cdfabc5646da 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -2433,7 +2433,6 @@ blk_qc_t generic_make_request(struct bio *bio)
 			if (q)
 				blk_queue_exit(q);
 			q = bio->bi_disk->queue;
-			bio_reassociate_blkg(q, bio);
 			flags = 0;
 			if (bio->bi_opf & REQ_NOWAIT)
 				flags = BLK_MQ_REQ_NOWAIT;
diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
index 35c48d7b8f78..bb240a0c1309 100644
--- a/block/blk-iolatency.c
+++ b/block/blk-iolatency.c
@@ -480,12 +480,34 @@ static void blkcg_iolatency_throttle(struct rq_qos *rqos, struct bio *bio,
 				     spinlock_t *lock)
 {
 	struct blk_iolatency *blkiolat = BLKIOLATENCY(rqos);
-	struct blkcg_gq *blkg = bio->bi_blkg;
+	struct blkcg *blkcg;
+	struct blkcg_gq *blkg;
+	struct request_queue *q = rqos->q;
 	bool issue_as_root = bio_issue_as_root_blkg(bio);
 
 	if (!blk_iolatency_enabled(blkiolat))
 		return;
 
+	rcu_read_lock();
+	blkcg = bio_blkcg(bio);
+	bio_associate_blkcg(bio, &blkcg->css);
+	blkg = blkg_lookup(blkcg, q);
+	if (unlikely(!blkg)) {
+		if (!lock)
+			spin_lock_irq(q->queue_lock);
+		blkg = blkg_lookup_create(blkcg, q);
+		if (IS_ERR(blkg))
+			blkg = NULL;
+		if (!lock)
+			spin_unlock_irq(q->queue_lock);
+	}
+	if (!blkg)
+		goto out;
+
+	bio_issue_init(&bio->bi_issue, bio_sectors(bio));
+	bio_associate_blkg(bio, blkg);
+out:
+	rcu_read_unlock();
 	while (blkg && blkg->parent) {
 		struct iolatency_grp *iolat = blkg_to_lat(blkg);
 		if (!iolat) {
@@ -706,7 +728,7 @@ static void blkiolatency_timer_fn(struct timer_list *t)
 		 * We could be exiting, don't access the pd unless we have a
 		 * ref on the blkg.
 		 */
-		if (!blkg_tryget(blkg))
+		if (!blkg_try_get(blkg))
 			continue;
 
 		iolat = blkg_to_lat(blkg);
diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 4bda70e8db48..db1a3a2ae006 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -2115,11 +2115,21 @@ static inline void throtl_update_latency_buckets(struct throtl_data *td)
 }
 #endif
 
+static void blk_throtl_assoc_bio(struct throtl_grp *tg, struct bio *bio)
+{
+#ifdef CONFIG_BLK_DEV_THROTTLING_LOW
+	/* fallback to root_blkg if we fail to get a blkg ref */
+	if (bio->bi_css && (bio_associate_blkg(bio, tg_to_blkg(tg)) == -ENODEV))
+		bio_associate_blkg(bio, bio->bi_disk->queue->root_blkg);
+	bio_issue_init(&bio->bi_issue, bio_sectors(bio));
+#endif
+}
+
 bool blk_throtl_bio(struct request_queue *q, struct blkcg_gq *blkg,
 		    struct bio *bio)
 {
 	struct throtl_qnode *qn = NULL;
-	struct throtl_grp *tg = blkg_to_tg(blkg);
+	struct throtl_grp *tg = blkg_to_tg(blkg ?: q->root_blkg);
 	struct throtl_service_queue *sq;
 	bool rw = bio_data_dir(bio);
 	bool throttled = false;
@@ -2138,6 +2148,7 @@ bool blk_throtl_bio(struct request_queue *q, struct blkcg_gq *blkg,
 	if (unlikely(blk_queue_bypass(q)))
 		goto out_unlock;
 
+	blk_throtl_assoc_bio(tg, bio);
 	blk_throtl_update_idletime(tg);
 
 	sq = &tg->service_queue;
diff --git a/block/bounce.c b/block/bounce.c
index ec0d99995f5f..418677dcec60 100644
--- a/block/bounce.c
+++ b/block/bounce.c
@@ -276,9 +276,7 @@ static struct bio *bounce_clone_bio(struct bio *bio_src, gfp_t gfp_mask,
 		}
 	}
 
-	bio_clone_blkg_association(bio, bio_src);
-
-	blkcg_bio_issue_init(bio);
+	bio_clone_blkcg_association(bio, bio_src);
 
 	return bio;
 }
diff --git a/block/cfq-iosched.c b/block/cfq-iosched.c
index 6a3d87dd3c1a..ed41aa978c4a 100644
--- a/block/cfq-iosched.c
+++ b/block/cfq-iosched.c
@@ -3759,7 +3759,7 @@ static void check_blkcg_changed(struct cfq_io_cq *cic, struct bio *bio)
 	uint64_t serial_nr;
 
 	rcu_read_lock();
-	serial_nr = __bio_blkcg(bio)->css.serial_nr;
+	serial_nr = bio_blkcg(bio)->css.serial_nr;
 	rcu_read_unlock();
 
 	/*
@@ -3824,7 +3824,7 @@ cfq_get_queue(struct cfq_data *cfqd, bool is_sync, struct cfq_io_cq *cic,
 	struct cfq_group *cfqg;
 
 	rcu_read_lock();
-	cfqg = cfq_lookup_cfqg(cfqd, __bio_blkcg(bio));
+	cfqg = cfq_lookup_cfqg(cfqd, bio_blkcg(bio));
 	if (!cfqg) {
 		cfqq = &cfqd->oom_cfqq;
 		goto out;
diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index abad6d15f956..ea9debf59b22 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -77,7 +77,6 @@
 #include <linux/falloc.h>
 #include <linux/uio.h>
 #include <linux/ioprio.h>
-#include <linux/blk-cgroup.h>
 
 #include "loop.h"
 
@@ -1761,8 +1760,8 @@ static blk_status_t loop_queue_rq(struct blk_mq_hw_ctx *hctx,
 
 	/* always use the first bio's css */
 #ifdef CONFIG_BLK_CGROUP
-	if (cmd->use_aio && rq->bio && rq->bio->bi_blkg) {
-		cmd->css = &bio_blkcg(rq->bio)->css;
+	if (cmd->use_aio && rq->bio && rq->bio->bi_css) {
+		cmd->css = rq->bio->bi_css;
 		css_get(cmd->css);
 	} else
 #endif
diff --git a/drivers/md/raid0.c b/drivers/md/raid0.c
index f3fb5bb8c82a..ac1cffd2a09b 100644
--- a/drivers/md/raid0.c
+++ b/drivers/md/raid0.c
@@ -542,7 +542,7 @@ static void raid0_handle_discard(struct mddev *mddev, struct bio *bio)
 		    !discard_bio)
 			continue;
 		bio_chain(discard_bio, bio);
-		bio_clone_blkg_association(discard_bio, bio);
+		bio_clone_blkcg_association(discard_bio, bio);
 		if (mddev->gendisk)
 			trace_block_bio_remap(bdev_get_queue(rdev->bdev),
 				discard_bio, disk_devt(mddev->gendisk),
diff --git a/fs/buffer.c b/fs/buffer.c
index 109f55196866..6f1ae3ac9789 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -3060,6 +3060,11 @@ static int submit_bh_wbc(int op, int op_flags, struct buffer_head *bh,
 	 */
 	bio = bio_alloc(GFP_NOIO, 1);
 
+	if (wbc) {
+		wbc_init_bio(wbc, bio);
+		wbc_account_io(wbc, bh->b_page, bh->b_size);
+	}
+
 	bio->bi_iter.bi_sector = bh->b_blocknr * (bh->b_size >> 9);
 	bio_set_dev(bio, bh->b_bdev);
 	bio->bi_write_hint = write_hint;
@@ -3079,11 +3084,6 @@ static int submit_bh_wbc(int op, int op_flags, struct buffer_head *bh,
 		op_flags |= REQ_PRIO;
 	bio_set_op_attrs(bio, op, op_flags);
 
-	if (wbc) {
-		wbc_init_bio(wbc, bio);
-		wbc_account_io(wbc, bh->b_page, bh->b_size);
-	}
-
 	submit_bio(bio);
 	return 0;
 }
diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
index 2aa62d58d8dd..db7590178dfc 100644
--- a/fs/ext4/page-io.c
+++ b/fs/ext4/page-io.c
@@ -374,13 +374,13 @@ static int io_submit_init_bio(struct ext4_io_submit *io,
 	bio = bio_alloc(GFP_NOIO, BIO_MAX_PAGES);
 	if (!bio)
 		return -ENOMEM;
+	wbc_init_bio(io->io_wbc, bio);
 	bio->bi_iter.bi_sector = bh->b_blocknr * (bh->b_size >> 9);
 	bio_set_dev(bio, bh->b_bdev);
 	bio->bi_end_io = ext4_end_bio;
 	bio->bi_private = ext4_get_io_end(io->io_end);
 	io->io_bio = bio;
 	io->io_next_block = bh->b_blocknr;
-	wbc_init_bio(io->io_wbc, bio);
 	return 0;
 }
 
diff --git a/include/linux/bio.h b/include/linux/bio.h
index b47c7f716731..056fb627edb3 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -503,31 +503,23 @@ do {						\
 	disk_devt((bio)->bi_disk)
 
 #if defined(CONFIG_MEMCG) && defined(CONFIG_BLK_CGROUP)
-int bio_associate_blkg_from_page(struct bio *bio, struct page *page);
+int bio_associate_blkcg_from_page(struct bio *bio, struct page *page);
 #else
-static inline int bio_associate_blkg_from_page(struct bio *bio,
-					       struct page *page) { return 0; }
+static inline int bio_associate_blkcg_from_page(struct bio *bio,
+						struct page *page) {  return 0; }
 #endif
 
 #ifdef CONFIG_BLK_CGROUP
+int bio_associate_blkcg(struct bio *bio, struct cgroup_subsys_state *blkcg_css);
 int bio_associate_blkg(struct bio *bio, struct blkcg_gq *blkg);
-int bio_associate_blkg_from_css(struct bio *bio,
-				struct cgroup_subsys_state *css);
-int bio_associate_create_blkg(struct request_queue *q, struct bio *bio);
-int bio_reassociate_blkg(struct request_queue *q, struct bio *bio);
 void bio_disassociate_task(struct bio *bio);
-void bio_clone_blkg_association(struct bio *dst, struct bio *src);
+void bio_clone_blkcg_association(struct bio *dst, struct bio *src);
 #else	/* CONFIG_BLK_CGROUP */
-static inline int bio_associate_blkg_from_css(struct bio *bio,
-					      struct cgroup_subsys_state *css)
-{ return 0; }
-static inline int bio_associate_create_blkg(struct request_queue *q,
-					    struct bio *bio) { return 0; }
-static inline int bio_reassociate_blkg(struct request_queue *q, struct bio *bio)
-{ return 0; }
+static inline int bio_associate_blkcg(struct bio *bio,
+			struct cgroup_subsys_state *blkcg_css) { return 0; }
 static inline void bio_disassociate_task(struct bio *bio) { }
-static inline void bio_clone_blkg_association(struct bio *dst,
-					      struct bio *src) { }
+static inline void bio_clone_blkcg_association(struct bio *dst,
+			struct bio *src) { }
 #endif	/* CONFIG_BLK_CGROUP */
 
 #ifdef CONFIG_HIGHMEM
diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index 1e76ceebeb5d..6d766a19f2bb 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -126,7 +126,7 @@ struct blkcg_gq {
 	struct request_list		rl;
 
 	/* reference count */
-	struct percpu_ref		refcnt;
+	atomic_t			refcnt;
 
 	/* is this blkg online? protected by both blkcg and q locks */
 	bool				online;
@@ -184,8 +184,6 @@ extern struct cgroup_subsys_state * const blkcg_root_css;
 
 struct blkcg_gq *blkg_lookup_slowpath(struct blkcg *blkcg,
 				      struct request_queue *q, bool update_hint);
-struct blkcg_gq *__blkg_lookup_create(struct blkcg *blkcg,
-				      struct request_queue *q);
 struct blkcg_gq *blkg_lookup_create(struct blkcg *blkcg,
 				    struct request_queue *q);
 int blkcg_init_queue(struct request_queue *q);
@@ -232,59 +230,22 @@ int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
 		   char *input, struct blkg_conf_ctx *ctx);
 void blkg_conf_finish(struct blkg_conf_ctx *ctx);
 
-/**
- * blkcg_css - find the current css
- *
- * Find the css associated with either the kthread or the current task.
- * This may return a dying css, so it is up to the caller to use tryget logic
- * to confirm it is alive and well.
- */
-static inline struct cgroup_subsys_state *blkcg_css(void)
-{
-	struct cgroup_subsys_state *css;
-
-	css = kthread_blkcg();
-	if (css)
-		return css;
-	return task_css(current, io_cgrp_id);
-}
 
 static inline struct blkcg *css_to_blkcg(struct cgroup_subsys_state *css)
 {
 	return css ? container_of(css, struct blkcg, css) : NULL;
 }
 
-/**
- * __bio_blkcg - internal version of bio_blkcg for bfq and cfq
- *
- * DO NOT USE.
- * There is a flaw using this version of the function.  In particular, this was
- * used in a broken paradigm where association was called on the given css.  It
- * is possible though that the returned css from task_css() is in the process
- * of dying due to migration of the current task.  So it is improper to assume
- * *_get() is going to succeed.  Both BFQ and CFQ rely on this logic and will
- * take additional work to handle more gracefully.
- */
-static inline struct blkcg *__bio_blkcg(struct bio *bio)
-{
-	if (bio && bio->bi_blkg)
-		return bio->bi_blkg->blkcg;
-	return css_to_blkcg(blkcg_css());
-}
-
-/**
- * bio_blkcg - grab the blkcg associated with a bio
- * @bio: target bio
- *
- * This returns the blkcg associated with a bio, NULL if not associated.
- * Callers are expected to either handle NULL or know association has been
- * done prior to calling this.
- */
 static inline struct blkcg *bio_blkcg(struct bio *bio)
 {
-	if (bio && bio->bi_blkg)
-		return bio->bi_blkg->blkcg;
-	return NULL;
+	struct cgroup_subsys_state *css;
+
+	if (bio && bio->bi_css)
+		return css_to_blkcg(bio->bi_css);
+	css = kthread_blkcg();
+	if (css)
+		return css_to_blkcg(css);
+	return css_to_blkcg(task_css(current, io_cgrp_id));
 }
 
 static inline bool blk_cgroup_congested(void)
@@ -490,35 +451,26 @@ static inline int blkg_path(struct blkcg_gq *blkg, char *buf, int buflen)
  */
 static inline void blkg_get(struct blkcg_gq *blkg)
 {
-	percpu_ref_get(&blkg->refcnt);
+	WARN_ON_ONCE(atomic_read(&blkg->refcnt) <= 0);
+	atomic_inc(&blkg->refcnt);
 }
 
 /**
- * blkg_tryget - try and get a blkg reference
+ * blkg_try_get - try and get a blkg reference
  * @blkg: blkg to get
  *
  * This is for use when doing an RCU lookup of the blkg.  We may be in the midst
  * of freeing this blkg, so we can only use it if the refcnt is not zero.
  */
-static inline bool blkg_tryget(struct blkcg_gq *blkg)
+static inline struct blkcg_gq *blkg_try_get(struct blkcg_gq *blkg)
 {
-	return percpu_ref_tryget(&blkg->refcnt);
+	if (atomic_inc_not_zero(&blkg->refcnt))
+		return blkg;
+	return NULL;
 }
 
-/**
- * blkg_tryget_closest - try and get a blkg ref on the closet blkg
- * @blkg: blkg to get
- *
- * This walks up the blkg tree to find the closest non-dying blkg and returns
- * the blkg that it did association with as it may not be the passed in blkg.
- */
-static inline struct blkcg_gq *blkg_tryget_closest(struct blkcg_gq *blkg)
-{
-	while (!percpu_ref_tryget(&blkg->refcnt))
-		blkg = blkg->parent;
 
-	return blkg;
-}
+void __blkg_release_rcu(struct rcu_head *rcu);
 
 /**
  * blkg_put - put a blkg reference
@@ -526,7 +478,9 @@ static inline struct blkcg_gq *blkg_tryget_closest(struct blkcg_gq *blkg)
  */
 static inline void blkg_put(struct blkcg_gq *blkg)
 {
-	percpu_ref_put(&blkg->refcnt);
+	WARN_ON_ONCE(atomic_read(&blkg->refcnt) <= 0);
+	if (atomic_dec_and_test(&blkg->refcnt))
+		call_rcu(&blkg->rcu_head, __blkg_release_rcu);
 }
 
 /**
@@ -579,36 +533,25 @@ static inline struct request_list *blk_get_rl(struct request_queue *q,
 
 	rcu_read_lock();
 
-	if (bio && bio->bi_blkg) {
-		blkcg = bio->bi_blkg->blkcg;
-		if (blkcg == &blkcg_root)
-			goto rl_use_root;
-
-		blkg_get(bio->bi_blkg);
-		rcu_read_unlock();
-		return &bio->bi_blkg->rl;
-	}
+	blkcg = bio_blkcg(bio);
 
-	blkcg = css_to_blkcg(blkcg_css());
+	/* bypass blkg lookup and use @q->root_rl directly for root */
 	if (blkcg == &blkcg_root)
-		goto rl_use_root;
+		goto root_rl;
 
+	/*
+	 * Try to use blkg->rl.  blkg lookup may fail under memory pressure
+	 * or if either the blkcg or queue is going away.  Fall back to
+	 * root_rl in such cases.
+	 */
 	blkg = blkg_lookup(blkcg, q);
 	if (unlikely(!blkg))
-		blkg = __blkg_lookup_create(blkcg, q);
-
-	if (blkg->blkcg == &blkcg_root || !blkg_tryget(blkg))
-		goto rl_use_root;
+		goto root_rl;
 
+	blkg_get(blkg);
 	rcu_read_unlock();
 	return &blkg->rl;
-
-	/*
-	 * Each blkg has its own request_list, however, the root blkcg
-	 * uses the request_queue's root_rl.  This is to avoid most
-	 * overhead for the root blkcg.
-	 */
-rl_use_root:
+root_rl:
 	rcu_read_unlock();
 	return &q->root_rl;
 }
@@ -854,26 +797,32 @@ static inline bool blk_throtl_bio(struct request_queue *q, struct blkcg_gq *blkg
 				  struct bio *bio) { return false; }
 #endif
 
-
-static inline void blkcg_bio_issue_init(struct bio *bio)
-{
-	bio_issue_init(&bio->bi_issue, bio_sectors(bio));
-}
-
 static inline bool blkcg_bio_issue_check(struct request_queue *q,
 					 struct bio *bio)
 {
+	struct blkcg *blkcg;
 	struct blkcg_gq *blkg;
 	bool throtl = false;
 
 	rcu_read_lock();
+	blkcg = bio_blkcg(bio);
+
+	/* associate blkcg if bio hasn't attached one */
+	bio_associate_blkcg(bio, &blkcg->css);
 
-	bio_associate_create_blkg(q, bio);
-	blkg = bio->bi_blkg;
+	blkg = blkg_lookup(blkcg, q);
+	if (unlikely(!blkg)) {
+		spin_lock_irq(q->queue_lock);
+		blkg = blkg_lookup_create(blkcg, q);
+		if (IS_ERR(blkg))
+			blkg = NULL;
+		spin_unlock_irq(q->queue_lock);
+	}
 
 	throtl = blk_throtl_bio(q, blkg, bio);
 
 	if (!throtl) {
+		blkg = blkg ?: q->root_blkg;
 		/*
 		 * If the bio is flagged with BIO_QUEUE_ENTERED it means this
 		 * is a split bio and we would have already accounted for the
@@ -885,8 +834,6 @@ static inline bool blkcg_bio_issue_check(struct request_queue *q,
 		blkg_rwstat_add(&blkg->stat_ios, bio->bi_opf, 1);
 	}
 
-	blkcg_bio_issue_init(bio);
-
 	rcu_read_unlock();
 	return !throtl;
 }
@@ -983,7 +930,6 @@ static inline int blkcg_activate_policy(struct request_queue *q,
 static inline void blkcg_deactivate_policy(struct request_queue *q,
 					   const struct blkcg_policy *pol) { }
 
-static inline struct blkcg *__bio_blkcg(struct bio *bio) { return NULL; }
 static inline struct blkcg *bio_blkcg(struct bio *bio) { return NULL; }
 
 static inline struct blkg_policy_data *blkg_to_pd(struct blkcg_gq *blkg,
@@ -999,7 +945,6 @@ static inline void blk_put_rl(struct request_list *rl) { }
 static inline void blk_rq_set_rl(struct request *rq, struct request_list *rl) { }
 static inline struct request_list *blk_rq_rl(struct request *rq) { return &rq->q->root_rl; }
 
-static inline void blkcg_bio_issue_init(struct bio *bio) { }
 static inline bool blkcg_bio_issue_check(struct request_queue *q,
 					 struct bio *bio) { return true; }
 
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 9578c7ab1eb6..f6dfb30737d8 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -178,6 +178,7 @@ struct bio {
 	 * release.  Read comment on top of bio_associate_current().
 	 */
 	struct io_context	*bi_ioc;
+	struct cgroup_subsys_state *bi_css;
 	struct blkcg_gq		*bi_blkg;
 	struct bio_issue	bi_issue;
 #endif
diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index b8bcbdeb2eac..32c553556bbd 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -93,8 +93,6 @@ extern struct css_set init_css_set;
 
 bool css_has_online_children(struct cgroup_subsys_state *css);
 struct cgroup_subsys_state *css_from_id(int id, struct cgroup_subsys *ss);
-struct cgroup_subsys_state *cgroup_e_css(struct cgroup *cgroup,
-					 struct cgroup_subsys *ss);
 struct cgroup_subsys_state *cgroup_get_e_css(struct cgroup *cgroup,
 					     struct cgroup_subsys *ss);
 struct cgroup_subsys_state *css_tryget_online_from_dir(struct dentry *dentry,
diff --git a/include/linux/writeback.h b/include/linux/writeback.h
index 738a0c24874f..fdfd04e348f6 100644
--- a/include/linux/writeback.h
+++ b/include/linux/writeback.h
@@ -246,8 +246,7 @@ static inline void wbc_attach_fdatawrite_inode(struct writeback_control *wbc,
  *
  * @bio is a part of the writeback in progress controlled by @wbc.  Perform
  * writeback specific initialization.  This is used to apply the cgroup
- * writeback context.  Must be called after the bio has been associated with
- * a device.
+ * writeback context.
  */
 static inline void wbc_init_bio(struct writeback_control *wbc, struct bio *bio)
 {
@@ -258,7 +257,7 @@ static inline void wbc_init_bio(struct writeback_control *wbc, struct bio *bio)
 	 * regular writeback instead of writing things out itself.
 	 */
 	if (wbc->wb)
-		bio_associate_blkg_from_css(bio, wbc->wb->blkcg_css);
+		bio_associate_blkcg(bio, wbc->wb->blkcg_css);
 }
 
 #else	/* CONFIG_CGROUP_WRITEBACK */
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 48fb22e49467..aae10baf1902 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -492,7 +492,7 @@ static struct cgroup_subsys_state *cgroup_tryget_css(struct cgroup *cgrp,
 }
 
 /**
- * cgroup_e_css_by_mask - obtain a cgroup's effective css for the specified ss
+ * cgroup_e_css - obtain a cgroup's effective css for the specified subsystem
  * @cgrp: the cgroup of interest
  * @ss: the subsystem of interest (%NULL returns @cgrp->self)
  *
@@ -501,8 +501,8 @@ static struct cgroup_subsys_state *cgroup_tryget_css(struct cgroup *cgrp,
  * enabled.  If @ss is associated with the hierarchy @cgrp is on, this
  * function is guaranteed to return non-NULL css.
  */
-static struct cgroup_subsys_state *cgroup_e_css_by_mask(struct cgroup *cgrp,
-							struct cgroup_subsys *ss)
+static struct cgroup_subsys_state *cgroup_e_css(struct cgroup *cgrp,
+						struct cgroup_subsys *ss)
 {
 	lockdep_assert_held(&cgroup_mutex);
 
@@ -522,35 +522,6 @@ static struct cgroup_subsys_state *cgroup_e_css_by_mask(struct cgroup *cgrp,
 	return cgroup_css(cgrp, ss);
 }
 
-/**
- * cgroup_e_css - obtain a cgroup's effective css for the specified subsystem
- * @cgrp: the cgroup of interest
- * @ss: the subsystem of interest
- *
- * Find and get the effective css of @cgrp for @ss.  The effective css is
- * defined as the matching css of the nearest ancestor including self which
- * has @ss enabled.  If @ss is not mounted on the hierarchy @cgrp is on,
- * the root css is returned, so this function always returns a valid css.
- *
- * The returned css is not guaranteed to be online, and therefore it is the
- * callers responsiblity to tryget a reference for it.
- */
-struct cgroup_subsys_state *cgroup_e_css(struct cgroup *cgrp,
-					 struct cgroup_subsys *ss)
-{
-	struct cgroup_subsys_state *css;
-
-	do {
-		css = cgroup_css(cgrp, ss);
-
-		if (css)
-			return css;
-		cgrp = cgroup_parent(cgrp);
-	} while (cgrp);
-
-	return init_css_set.subsys[ss->id];
-}
-
 /**
  * cgroup_get_e_css - get a cgroup's effective css for the specified subsystem
  * @cgrp: the cgroup of interest
@@ -633,11 +604,10 @@ EXPORT_SYMBOL_GPL(of_css);
  *
  * Should be called under cgroup_[tree_]mutex.
  */
-#define for_each_e_css(css, ssid, cgrp)					    \
-	for ((ssid) = 0; (ssid) < CGROUP_SUBSYS_COUNT; (ssid)++)	    \
-		if (!((css) = cgroup_e_css_by_mask(cgrp,		    \
-						   cgroup_subsys[(ssid)]))) \
-			;						    \
+#define for_each_e_css(css, ssid, cgrp)					\
+	for ((ssid) = 0; (ssid) < CGROUP_SUBSYS_COUNT; (ssid)++)	\
+		if (!((css) = cgroup_e_css(cgrp, cgroup_subsys[(ssid)]))) \
+			;						\
 		else
 
 /**
@@ -1036,7 +1006,7 @@ static struct css_set *find_existing_css_set(struct css_set *old_cset,
 			 * @ss is in this hierarchy, so we want the
 			 * effective css from @cgrp.
 			 */
-			template[i] = cgroup_e_css_by_mask(cgrp, ss);
+			template[i] = cgroup_e_css(cgrp, ss);
 		} else {
 			/*
 			 * @ss is not in this hierarchy, so we don't want
@@ -3049,7 +3019,7 @@ static int cgroup_apply_control(struct cgroup *cgrp)
 		return ret;
 
 	/*
-	 * At this point, cgroup_e_css_by_mask() results reflect the new csses
+	 * At this point, cgroup_e_css() results reflect the new csses
 	 * making the following cgroup_update_dfl_csses() properly update
 	 * css associations of all tasks in the subtree.
 	 */
diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index fac0ddf8a8e2..2868d85f1fb1 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -764,9 +764,9 @@ blk_trace_bio_get_cgid(struct request_queue *q, struct bio *bio)
 	if (!bt || !(blk_tracer_flags.val & TRACE_BLK_OPT_CGROUP))
 		return NULL;
 
-	if (!bio->bi_blkg)
+	if (!bio->bi_css)
 		return NULL;
-	return cgroup_get_kernfs_id(bio_blkcg(bio)->css.cgroup);
+	return cgroup_get_kernfs_id(bio->bi_css->cgroup);
 }
 #else
 static union kernfs_node_id *
diff --git a/mm/page_io.c b/mm/page_io.c
index 573d3663d846..aafd19ec1db4 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -339,7 +339,7 @@ int __swap_writepage(struct page *page, struct writeback_control *wbc,
 		goto out;
 	}
 	bio->bi_opf = REQ_OP_WRITE | REQ_SWAP | wbc_to_write_flags(wbc);
-	bio_associate_blkg_from_page(bio, page);
+	bio_associate_blkcg_from_page(bio, page);
 	count_swpout_vm_event(page);
 	set_page_writeback(page);
 	unlock_page(page);
-- 
2.17.1
