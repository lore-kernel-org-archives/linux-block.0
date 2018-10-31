Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org,
	linux-ide@vger.kernel.org,
	linux-scsi@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 25/30] block: remove request_list code
Date: Wed, 31 Oct 2018 11:59:17 -0600
Message-Id: <20181031175922.8849-26-axboe@kernel.dk>
In-Reply-To: <20181031175922.8849-1-axboe@kernel.dk>
References: <20181031175922.8849-1-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

It's now dead code, nobody uses it.

Reviewed-by: Hannes Reinecke <hare@suse.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-cgroup.c         |  47 ----------------
 block/blk-core.c           |  75 --------------------------
 block/blk-mq.c             |   4 --
 block/blk.h                |   3 --
 include/linux/blk-cgroup.h | 108 -------------------------------------
 include/linux/blkdev.h     |  34 ------------
 6 files changed, 271 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 5f10d755ec52..020869a37d11 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -76,9 +76,6 @@ static void blkg_free(struct blkcg_gq *blkg)
 		if (blkg->pd[i])
 			blkcg_policy[i]->pd_free_fn(blkg->pd[i]);
 
-	if (blkg->blkcg != &blkcg_root)
-		blk_exit_rl(blkg->q, &blkg->rl);
-
 	blkg_rwstat_exit(&blkg->stat_ios);
 	blkg_rwstat_exit(&blkg->stat_bytes);
 	kfree(blkg);
@@ -142,13 +139,6 @@ static struct blkcg_gq *blkg_alloc(struct blkcg *blkcg, struct request_queue *q,
 	INIT_LIST_HEAD(&blkg->q_node);
 	blkg->blkcg = blkcg;
 
-	/* root blkg uses @q->root_rl, init rl only for !root blkgs */
-	if (blkcg != &blkcg_root) {
-		if (blk_init_rl(&blkg->rl, q, gfp_mask))
-			goto err_free;
-		blkg->rl.blkg = blkg;
-	}
-
 	for (i = 0; i < BLKCG_MAX_POLS; i++) {
 		struct blkcg_policy *pol = blkcg_policy[i];
 		struct blkg_policy_data *pd;
@@ -448,42 +438,6 @@ static void blkg_destroy_all(struct request_queue *q)
 	}
 
 	q->root_blkg = NULL;
-	q->root_rl.blkg = NULL;
-}
-
-/*
- * The next function used by blk_queue_for_each_rl().  It's a bit tricky
- * because the root blkg uses @q->root_rl instead of its own rl.
- */
-struct request_list *__blk_queue_next_rl(struct request_list *rl,
-					 struct request_queue *q)
-{
-	struct list_head *ent;
-	struct blkcg_gq *blkg;
-
-	/*
-	 * Determine the current blkg list_head.  The first entry is
-	 * root_rl which is off @q->blkg_list and mapped to the head.
-	 */
-	if (rl == &q->root_rl) {
-		ent = &q->blkg_list;
-		/* There are no more block groups, hence no request lists */
-		if (list_empty(ent))
-			return NULL;
-	} else {
-		blkg = container_of(rl, struct blkcg_gq, rl);
-		ent = &blkg->q_node;
-	}
-
-	/* walk to the next list_head, skip root blkcg */
-	ent = ent->next;
-	if (ent == &q->root_blkg->q_node)
-		ent = ent->next;
-	if (ent == &q->blkg_list)
-		return NULL;
-
-	blkg = container_of(ent, struct blkcg_gq, q_node);
-	return &blkg->rl;
 }
 
 static int blkcg_reset_stats(struct cgroup_subsys_state *css,
@@ -1278,7 +1232,6 @@ int blkcg_init_queue(struct request_queue *q)
 	if (IS_ERR(blkg))
 		goto err_unlock;
 	q->root_blkg = blkg;
-	q->root_rl.blkg = blkg;
 	spin_unlock_irq(q->queue_lock);
 	rcu_read_unlock();
 
diff --git a/block/blk-core.c b/block/blk-core.c
index fcdb631f0a7a..0678ec4b1169 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -447,81 +447,6 @@ void blk_cleanup_queue(struct request_queue *q)
 }
 EXPORT_SYMBOL(blk_cleanup_queue);
 
-/* Allocate memory local to the request queue */
-static void *alloc_request_simple(gfp_t gfp_mask, void *data)
-{
-	struct request_queue *q = data;
-
-	return kmem_cache_alloc_node(request_cachep, gfp_mask, q->node);
-}
-
-static void free_request_simple(void *element, void *data)
-{
-	kmem_cache_free(request_cachep, element);
-}
-
-static void *alloc_request_size(gfp_t gfp_mask, void *data)
-{
-	struct request_queue *q = data;
-	struct request *rq;
-
-	rq = kmalloc_node(sizeof(struct request) + q->cmd_size, gfp_mask,
-			q->node);
-	if (rq && q->init_rq_fn && q->init_rq_fn(q, rq, gfp_mask) < 0) {
-		kfree(rq);
-		rq = NULL;
-	}
-	return rq;
-}
-
-static void free_request_size(void *element, void *data)
-{
-	struct request_queue *q = data;
-
-	if (q->exit_rq_fn)
-		q->exit_rq_fn(q, element);
-	kfree(element);
-}
-
-int blk_init_rl(struct request_list *rl, struct request_queue *q,
-		gfp_t gfp_mask)
-{
-	if (unlikely(rl->rq_pool) || q->mq_ops)
-		return 0;
-
-	rl->q = q;
-	rl->count[BLK_RW_SYNC] = rl->count[BLK_RW_ASYNC] = 0;
-	rl->starved[BLK_RW_SYNC] = rl->starved[BLK_RW_ASYNC] = 0;
-	init_waitqueue_head(&rl->wait[BLK_RW_SYNC]);
-	init_waitqueue_head(&rl->wait[BLK_RW_ASYNC]);
-
-	if (q->cmd_size) {
-		rl->rq_pool = mempool_create_node(BLKDEV_MIN_RQ,
-				alloc_request_size, free_request_size,
-				q, gfp_mask, q->node);
-	} else {
-		rl->rq_pool = mempool_create_node(BLKDEV_MIN_RQ,
-				alloc_request_simple, free_request_simple,
-				q, gfp_mask, q->node);
-	}
-	if (!rl->rq_pool)
-		return -ENOMEM;
-
-	if (rl != &q->root_rl)
-		WARN_ON_ONCE(!blk_get_queue(q));
-
-	return 0;
-}
-
-void blk_exit_rl(struct request_queue *q, struct request_list *rl)
-{
-	if (rl->rq_pool) {
-		mempool_destroy(rl->rq_pool);
-		if (rl != &q->root_rl)
-			blk_put_queue(q);
-	}
-}
-
 struct request_queue *blk_alloc_queue(gfp_t gfp_mask)
 {
 	return blk_alloc_queue_node(gfp_mask, NUMA_NO_NODE, NULL);
diff --git a/block/blk-mq.c b/block/blk-mq.c
index a58d2d953876..d43c9232c77c 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -326,10 +326,6 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
 	rq->end_io_data = NULL;
 	rq->next_rq = NULL;
 
-#ifdef CONFIG_BLK_CGROUP
-	rq->rl = NULL;
-#endif
-
 	data->ctx->rq_dispatched[op_is_sync(op)]++;
 	refcount_set(&rq->ref, 1);
 	return rq;
diff --git a/block/blk.h b/block/blk.h
index 4ae6cacb4548..e925cf4fe4de 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -120,9 +120,6 @@ struct blk_flush_queue *blk_alloc_flush_queue(struct request_queue *q,
 		int node, int cmd_size, gfp_t flags);
 void blk_free_flush_queue(struct blk_flush_queue *q);
 
-int blk_init_rl(struct request_list *rl, struct request_queue *q,
-		gfp_t gfp_mask);
-void blk_exit_rl(struct request_queue *q, struct request_list *rl);
 void blk_exit_queue(struct request_queue *q);
 void blk_rq_bio_prep(struct request_queue *q, struct request *rq,
 			struct bio *bio);
diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index 1e76ceebeb5d..f2c067071336 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -122,9 +122,6 @@ struct blkcg_gq {
 	/* all non-root blkcg_gq's are guaranteed to have access to parent */
 	struct blkcg_gq			*parent;
 
-	/* request allocation list for this blkcg-q pair */
-	struct request_list		rl;
-
 	/* reference count */
 	struct percpu_ref		refcnt;
 
@@ -561,105 +558,6 @@ static inline void blkg_put(struct blkcg_gq *blkg)
 		if (((d_blkg) = __blkg_lookup(css_to_blkcg(pos_css),	\
 					      (p_blkg)->q, false)))
 
-/**
- * blk_get_rl - get request_list to use
- * @q: request_queue of interest
- * @bio: bio which will be attached to the allocated request (may be %NULL)
- *
- * The caller wants to allocate a request from @q to use for @bio.  Find
- * the request_list to use and obtain a reference on it.  Should be called
- * under queue_lock.  This function is guaranteed to return non-%NULL
- * request_list.
- */
-static inline struct request_list *blk_get_rl(struct request_queue *q,
-					      struct bio *bio)
-{
-	struct blkcg *blkcg;
-	struct blkcg_gq *blkg;
-
-	rcu_read_lock();
-
-	if (bio && bio->bi_blkg) {
-		blkcg = bio->bi_blkg->blkcg;
-		if (blkcg == &blkcg_root)
-			goto rl_use_root;
-
-		blkg_get(bio->bi_blkg);
-		rcu_read_unlock();
-		return &bio->bi_blkg->rl;
-	}
-
-	blkcg = css_to_blkcg(blkcg_css());
-	if (blkcg == &blkcg_root)
-		goto rl_use_root;
-
-	blkg = blkg_lookup(blkcg, q);
-	if (unlikely(!blkg))
-		blkg = __blkg_lookup_create(blkcg, q);
-
-	if (blkg->blkcg == &blkcg_root || !blkg_tryget(blkg))
-		goto rl_use_root;
-
-	rcu_read_unlock();
-	return &blkg->rl;
-
-	/*
-	 * Each blkg has its own request_list, however, the root blkcg
-	 * uses the request_queue's root_rl.  This is to avoid most
-	 * overhead for the root blkcg.
-	 */
-rl_use_root:
-	rcu_read_unlock();
-	return &q->root_rl;
-}
-
-/**
- * blk_put_rl - put request_list
- * @rl: request_list to put
- *
- * Put the reference acquired by blk_get_rl().  Should be called under
- * queue_lock.
- */
-static inline void blk_put_rl(struct request_list *rl)
-{
-	if (rl->blkg->blkcg != &blkcg_root)
-		blkg_put(rl->blkg);
-}
-
-/**
- * blk_rq_set_rl - associate a request with a request_list
- * @rq: request of interest
- * @rl: target request_list
- *
- * Associate @rq with @rl so that accounting and freeing can know the
- * request_list @rq came from.
- */
-static inline void blk_rq_set_rl(struct request *rq, struct request_list *rl)
-{
-	rq->rl = rl;
-}
-
-/**
- * blk_rq_rl - return the request_list a request came from
- * @rq: request of interest
- *
- * Return the request_list @rq is allocated from.
- */
-static inline struct request_list *blk_rq_rl(struct request *rq)
-{
-	return rq->rl;
-}
-
-struct request_list *__blk_queue_next_rl(struct request_list *rl,
-					 struct request_queue *q);
-/**
- * blk_queue_for_each_rl - iterate through all request_lists of a request_queue
- *
- * Should be used under queue_lock.
- */
-#define blk_queue_for_each_rl(rl, q)	\
-	for ((rl) = &(q)->root_rl; (rl); (rl) = __blk_queue_next_rl((rl), (q)))
-
 static inline int blkg_stat_init(struct blkg_stat *stat, gfp_t gfp)
 {
 	int ret;
@@ -993,12 +891,6 @@ static inline char *blkg_path(struct blkcg_gq *blkg) { return NULL; }
 static inline void blkg_get(struct blkcg_gq *blkg) { }
 static inline void blkg_put(struct blkcg_gq *blkg) { }
 
-static inline struct request_list *blk_get_rl(struct request_queue *q,
-					      struct bio *bio) { return &q->root_rl; }
-static inline void blk_put_rl(struct request_list *rl) { }
-static inline void blk_rq_set_rl(struct request *rq, struct request_list *rl) { }
-static inline struct request_list *blk_rq_rl(struct request *rq) { return &rq->q->root_rl; }
-
 static inline void blkcg_bio_issue_init(struct bio *bio) { }
 static inline bool blkcg_bio_issue_check(struct request_queue *q,
 					 struct bio *bio) { return true; }
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 877a3d235c45..e0c661a95c39 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -58,22 +58,6 @@ struct blk_stat_callback;
 
 typedef void (rq_end_io_fn)(struct request *, blk_status_t);
 
-struct request_list {
-	struct request_queue	*q;	/* the queue this rl belongs to */
-#ifdef CONFIG_BLK_CGROUP
-	struct blkcg_gq		*blkg;	/* blkg this request pool belongs to */
-#endif
-	/*
-	 * count[], starved[], and wait[] are indexed by
-	 * BLK_RW_SYNC/BLK_RW_ASYNC
-	 */
-	int			count[2];
-	int			starved[2];
-	mempool_t		*rq_pool;
-	wait_queue_head_t	wait[2];
-	unsigned int		flags;
-};
-
 /*
  * request flags */
 typedef __u32 __bitwise req_flags_t;
@@ -259,10 +243,6 @@ struct request {
 
 	/* for bidi */
 	struct request *next_rq;
-
-#ifdef CONFIG_BLK_CGROUP
-	struct request_list *rl;		/* rl this rq is alloced from */
-#endif
 };
 
 static inline bool blk_op_is_scsi(unsigned int op)
@@ -312,8 +292,6 @@ typedef bool (poll_q_fn) (struct request_queue *q, blk_qc_t);
 struct bio_vec;
 typedef void (softirq_done_fn)(struct request *);
 typedef int (dma_drain_needed_fn)(struct request *);
-typedef int (init_rq_fn)(struct request_queue *, struct request *, gfp_t);
-typedef void (exit_rq_fn)(struct request_queue *, struct request *);
 
 enum blk_eh_timer_return {
 	BLK_EH_DONE,		/* drivers has completed the command */
@@ -427,22 +405,10 @@ struct request_queue {
 	struct blk_queue_stats	*stats;
 	struct rq_qos		*rq_qos;
 
-	/*
-	 * If blkcg is not used, @q->root_rl serves all requests.  If blkcg
-	 * is used, root blkg allocates from @q->root_rl and all other
-	 * blkgs from their own blkg->rl.  Which one to use should be
-	 * determined using bio_request_list().
-	 */
-	struct request_list	root_rl;
-
 	make_request_fn		*make_request_fn;
 	poll_q_fn		*poll_fn;
 	softirq_done_fn		*softirq_done_fn;
 	dma_drain_needed_fn	*dma_drain_needed;
-	/* Called just after a request is allocated */
-	init_rq_fn		*init_rq_fn;
-	/* Called just before a request is freed */
-	exit_rq_fn		*exit_rq_fn;
 
 	const struct blk_mq_ops	*mq_ops;
 
-- 
2.17.1
