Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:33462 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753989AbdAKVkN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Jan 2017 16:40:13 -0500
From: Jens Axboe <axboe@fb.com>
To: <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>
CC: <osandov@osandov.com>, <bart.vanassche@sandisk.com>,
        Jens Axboe <axboe@fb.com>
Subject: [PATCH 01/10] block: move existing elevator ops to union
Date: Wed, 11 Jan 2017 14:39:54 -0700
Message-ID: <1484170803-9311-2-git-send-email-axboe@fb.com>
In-Reply-To: <1484170803-9311-1-git-send-email-axboe@fb.com>
References: <1484170803-9311-1-git-send-email-axboe@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Prep patch for adding MQ ops as well, since doing anon unions with
named initializers doesn't work on older compilers.

Signed-off-by: Jens Axboe <axboe@fb.com>
---
 block/blk-ioc.c          |  8 +++----
 block/blk-merge.c        |  4 ++--
 block/blk.h              | 10 ++++----
 block/cfq-iosched.c      |  2 +-
 block/deadline-iosched.c |  2 +-
 block/elevator.c         | 60 ++++++++++++++++++++++++------------------------
 block/noop-iosched.c     |  2 +-
 include/linux/elevator.h |  4 +++-
 8 files changed, 47 insertions(+), 45 deletions(-)

diff --git a/block/blk-ioc.c b/block/blk-ioc.c
index 381cb50a673c..ab372092a57d 100644
--- a/block/blk-ioc.c
+++ b/block/blk-ioc.c
@@ -43,8 +43,8 @@ static void ioc_exit_icq(struct io_cq *icq)
 	if (icq->flags & ICQ_EXITED)
 		return;
 
-	if (et->ops.elevator_exit_icq_fn)
-		et->ops.elevator_exit_icq_fn(icq);
+	if (et->ops.sq.elevator_exit_icq_fn)
+		et->ops.sq.elevator_exit_icq_fn(icq);
 
 	icq->flags |= ICQ_EXITED;
 }
@@ -383,8 +383,8 @@ struct io_cq *ioc_create_icq(struct io_context *ioc, struct request_queue *q,
 	if (likely(!radix_tree_insert(&ioc->icq_tree, q->id, icq))) {
 		hlist_add_head(&icq->ioc_node, &ioc->icq_list);
 		list_add(&icq->q_node, &q->icq_list);
-		if (et->ops.elevator_init_icq_fn)
-			et->ops.elevator_init_icq_fn(icq);
+		if (et->ops.sq.elevator_init_icq_fn)
+			et->ops.sq.elevator_init_icq_fn(icq);
 	} else {
 		kmem_cache_free(et->icq_cache, icq);
 		icq = ioc_lookup_icq(ioc, q);
diff --git a/block/blk-merge.c b/block/blk-merge.c
index 182398cb1524..480570b691dc 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -763,8 +763,8 @@ int blk_attempt_req_merge(struct request_queue *q, struct request *rq,
 {
 	struct elevator_queue *e = q->elevator;
 
-	if (e->type->ops.elevator_allow_rq_merge_fn)
-		if (!e->type->ops.elevator_allow_rq_merge_fn(q, rq, next))
+	if (e->type->ops.sq.elevator_allow_rq_merge_fn)
+		if (!e->type->ops.sq.elevator_allow_rq_merge_fn(q, rq, next))
 			return 0;
 
 	return attempt_merge(q, rq, next);
diff --git a/block/blk.h b/block/blk.h
index 041185e5f129..f46c0ac8ae3d 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -167,7 +167,7 @@ static inline struct request *__elv_next_request(struct request_queue *q)
 			return NULL;
 		}
 		if (unlikely(blk_queue_bypass(q)) ||
-		    !q->elevator->type->ops.elevator_dispatch_fn(q, 0))
+		    !q->elevator->type->ops.sq.elevator_dispatch_fn(q, 0))
 			return NULL;
 	}
 }
@@ -176,16 +176,16 @@ static inline void elv_activate_rq(struct request_queue *q, struct request *rq)
 {
 	struct elevator_queue *e = q->elevator;
 
-	if (e->type->ops.elevator_activate_req_fn)
-		e->type->ops.elevator_activate_req_fn(q, rq);
+	if (e->type->ops.sq.elevator_activate_req_fn)
+		e->type->ops.sq.elevator_activate_req_fn(q, rq);
 }
 
 static inline void elv_deactivate_rq(struct request_queue *q, struct request *rq)
 {
 	struct elevator_queue *e = q->elevator;
 
-	if (e->type->ops.elevator_deactivate_req_fn)
-		e->type->ops.elevator_deactivate_req_fn(q, rq);
+	if (e->type->ops.sq.elevator_deactivate_req_fn)
+		e->type->ops.sq.elevator_deactivate_req_fn(q, rq);
 }
 
 #ifdef CONFIG_FAIL_IO_TIMEOUT
diff --git a/block/cfq-iosched.c b/block/cfq-iosched.c
index c73a6fcaeb9d..37aeb20fa454 100644
--- a/block/cfq-iosched.c
+++ b/block/cfq-iosched.c
@@ -4837,7 +4837,7 @@ static struct elv_fs_entry cfq_attrs[] = {
 };
 
 static struct elevator_type iosched_cfq = {
-	.ops = {
+	.ops.sq = {
 		.elevator_merge_fn = 		cfq_merge,
 		.elevator_merged_fn =		cfq_merged_request,
 		.elevator_merge_req_fn =	cfq_merged_requests,
diff --git a/block/deadline-iosched.c b/block/deadline-iosched.c
index 55e0bb6d7da7..05fc0ea25a98 100644
--- a/block/deadline-iosched.c
+++ b/block/deadline-iosched.c
@@ -439,7 +439,7 @@ static struct elv_fs_entry deadline_attrs[] = {
 };
 
 static struct elevator_type iosched_deadline = {
-	.ops = {
+	.ops.sq = {
 		.elevator_merge_fn = 		deadline_merge,
 		.elevator_merged_fn =		deadline_merged_request,
 		.elevator_merge_req_fn =	deadline_merged_requests,
diff --git a/block/elevator.c b/block/elevator.c
index 40f0c04e5ad3..022a26830297 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -58,8 +58,8 @@ static int elv_iosched_allow_bio_merge(struct request *rq, struct bio *bio)
 	struct request_queue *q = rq->q;
 	struct elevator_queue *e = q->elevator;
 
-	if (e->type->ops.elevator_allow_bio_merge_fn)
-		return e->type->ops.elevator_allow_bio_merge_fn(q, rq, bio);
+	if (e->type->ops.sq.elevator_allow_bio_merge_fn)
+		return e->type->ops.sq.elevator_allow_bio_merge_fn(q, rq, bio);
 
 	return 1;
 }
@@ -224,7 +224,7 @@ int elevator_init(struct request_queue *q, char *name)
 		}
 	}
 
-	err = e->ops.elevator_init_fn(q, e);
+	err = e->ops.sq.elevator_init_fn(q, e);
 	if (err)
 		elevator_put(e);
 	return err;
@@ -234,8 +234,8 @@ EXPORT_SYMBOL(elevator_init);
 void elevator_exit(struct elevator_queue *e)
 {
 	mutex_lock(&e->sysfs_lock);
-	if (e->type->ops.elevator_exit_fn)
-		e->type->ops.elevator_exit_fn(e);
+	if (e->type->ops.sq.elevator_exit_fn)
+		e->type->ops.sq.elevator_exit_fn(e);
 	mutex_unlock(&e->sysfs_lock);
 
 	kobject_put(&e->kobj);
@@ -443,8 +443,8 @@ int elv_merge(struct request_queue *q, struct request **req, struct bio *bio)
 		return ELEVATOR_BACK_MERGE;
 	}
 
-	if (e->type->ops.elevator_merge_fn)
-		return e->type->ops.elevator_merge_fn(q, req, bio);
+	if (e->type->ops.sq.elevator_merge_fn)
+		return e->type->ops.sq.elevator_merge_fn(q, req, bio);
 
 	return ELEVATOR_NO_MERGE;
 }
@@ -495,8 +495,8 @@ void elv_merged_request(struct request_queue *q, struct request *rq, int type)
 {
 	struct elevator_queue *e = q->elevator;
 
-	if (e->type->ops.elevator_merged_fn)
-		e->type->ops.elevator_merged_fn(q, rq, type);
+	if (e->type->ops.sq.elevator_merged_fn)
+		e->type->ops.sq.elevator_merged_fn(q, rq, type);
 
 	if (type == ELEVATOR_BACK_MERGE)
 		elv_rqhash_reposition(q, rq);
@@ -510,8 +510,8 @@ void elv_merge_requests(struct request_queue *q, struct request *rq,
 	struct elevator_queue *e = q->elevator;
 	const int next_sorted = next->rq_flags & RQF_SORTED;
 
-	if (next_sorted && e->type->ops.elevator_merge_req_fn)
-		e->type->ops.elevator_merge_req_fn(q, rq, next);
+	if (next_sorted && e->type->ops.sq.elevator_merge_req_fn)
+		e->type->ops.sq.elevator_merge_req_fn(q, rq, next);
 
 	elv_rqhash_reposition(q, rq);
 
@@ -528,8 +528,8 @@ void elv_bio_merged(struct request_queue *q, struct request *rq,
 {
 	struct elevator_queue *e = q->elevator;
 
-	if (e->type->ops.elevator_bio_merged_fn)
-		e->type->ops.elevator_bio_merged_fn(q, rq, bio);
+	if (e->type->ops.sq.elevator_bio_merged_fn)
+		e->type->ops.sq.elevator_bio_merged_fn(q, rq, bio);
 }
 
 #ifdef CONFIG_PM
@@ -578,7 +578,7 @@ void elv_drain_elevator(struct request_queue *q)
 
 	lockdep_assert_held(q->queue_lock);
 
-	while (q->elevator->type->ops.elevator_dispatch_fn(q, 1))
+	while (q->elevator->type->ops.sq.elevator_dispatch_fn(q, 1))
 		;
 	if (q->nr_sorted && printed++ < 10) {
 		printk(KERN_ERR "%s: forced dispatching is broken "
@@ -653,7 +653,7 @@ void __elv_add_request(struct request_queue *q, struct request *rq, int where)
 		 * rq cannot be accessed after calling
 		 * elevator_add_req_fn.
 		 */
-		q->elevator->type->ops.elevator_add_req_fn(q, rq);
+		q->elevator->type->ops.sq.elevator_add_req_fn(q, rq);
 		break;
 
 	case ELEVATOR_INSERT_FLUSH:
@@ -682,8 +682,8 @@ struct request *elv_latter_request(struct request_queue *q, struct request *rq)
 {
 	struct elevator_queue *e = q->elevator;
 
-	if (e->type->ops.elevator_latter_req_fn)
-		return e->type->ops.elevator_latter_req_fn(q, rq);
+	if (e->type->ops.sq.elevator_latter_req_fn)
+		return e->type->ops.sq.elevator_latter_req_fn(q, rq);
 	return NULL;
 }
 
@@ -691,8 +691,8 @@ struct request *elv_former_request(struct request_queue *q, struct request *rq)
 {
 	struct elevator_queue *e = q->elevator;
 
-	if (e->type->ops.elevator_former_req_fn)
-		return e->type->ops.elevator_former_req_fn(q, rq);
+	if (e->type->ops.sq.elevator_former_req_fn)
+		return e->type->ops.sq.elevator_former_req_fn(q, rq);
 	return NULL;
 }
 
@@ -701,8 +701,8 @@ int elv_set_request(struct request_queue *q, struct request *rq,
 {
 	struct elevator_queue *e = q->elevator;
 
-	if (e->type->ops.elevator_set_req_fn)
-		return e->type->ops.elevator_set_req_fn(q, rq, bio, gfp_mask);
+	if (e->type->ops.sq.elevator_set_req_fn)
+		return e->type->ops.sq.elevator_set_req_fn(q, rq, bio, gfp_mask);
 	return 0;
 }
 
@@ -710,16 +710,16 @@ void elv_put_request(struct request_queue *q, struct request *rq)
 {
 	struct elevator_queue *e = q->elevator;
 
-	if (e->type->ops.elevator_put_req_fn)
-		e->type->ops.elevator_put_req_fn(rq);
+	if (e->type->ops.sq.elevator_put_req_fn)
+		e->type->ops.sq.elevator_put_req_fn(rq);
 }
 
 int elv_may_queue(struct request_queue *q, unsigned int op)
 {
 	struct elevator_queue *e = q->elevator;
 
-	if (e->type->ops.elevator_may_queue_fn)
-		return e->type->ops.elevator_may_queue_fn(q, op);
+	if (e->type->ops.sq.elevator_may_queue_fn)
+		return e->type->ops.sq.elevator_may_queue_fn(q, op);
 
 	return ELV_MQUEUE_MAY;
 }
@@ -734,8 +734,8 @@ void elv_completed_request(struct request_queue *q, struct request *rq)
 	if (blk_account_rq(rq)) {
 		q->in_flight[rq_is_sync(rq)]--;
 		if ((rq->rq_flags & RQF_SORTED) &&
-		    e->type->ops.elevator_completed_req_fn)
-			e->type->ops.elevator_completed_req_fn(q, rq);
+		    e->type->ops.sq.elevator_completed_req_fn)
+			e->type->ops.sq.elevator_completed_req_fn(q, rq);
 	}
 }
 
@@ -803,8 +803,8 @@ int elv_register_queue(struct request_queue *q)
 		}
 		kobject_uevent(&e->kobj, KOBJ_ADD);
 		e->registered = 1;
-		if (e->type->ops.elevator_registered_fn)
-			e->type->ops.elevator_registered_fn(q);
+		if (e->type->ops.sq.elevator_registered_fn)
+			e->type->ops.sq.elevator_registered_fn(q);
 	}
 	return error;
 }
@@ -912,7 +912,7 @@ static int elevator_switch(struct request_queue *q, struct elevator_type *new_e)
 	spin_unlock_irq(q->queue_lock);
 
 	/* allocate, init and register new elevator */
-	err = new_e->ops.elevator_init_fn(q, new_e);
+	err = new_e->ops.sq.elevator_init_fn(q, new_e);
 	if (err)
 		goto fail_init;
 
diff --git a/block/noop-iosched.c b/block/noop-iosched.c
index a163c487cf38..2d1b15d89b45 100644
--- a/block/noop-iosched.c
+++ b/block/noop-iosched.c
@@ -92,7 +92,7 @@ static void noop_exit_queue(struct elevator_queue *e)
 }
 
 static struct elevator_type elevator_noop = {
-	.ops = {
+	.ops.sq = {
 		.elevator_merge_req_fn		= noop_merged_requests,
 		.elevator_dispatch_fn		= noop_dispatch,
 		.elevator_add_req_fn		= noop_add_request,
diff --git a/include/linux/elevator.h b/include/linux/elevator.h
index b276e9ef0e0b..2a9e966eed03 100644
--- a/include/linux/elevator.h
+++ b/include/linux/elevator.h
@@ -94,7 +94,9 @@ struct elevator_type
 	struct kmem_cache *icq_cache;
 
 	/* fields provided by elevator implementation */
-	struct elevator_ops ops;
+	union {
+		struct elevator_ops sq;
+	} ops;
 	size_t icq_size;	/* see iocontext.h */
 	size_t icq_align;	/* ditto */
 	struct elv_fs_entry *elevator_attrs;
-- 
2.7.4

