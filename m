Return-Path: <linux@rasmusvillemoes.dk>
Return-Path: <linux@rasmusvillemoes.dk>
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
To: Tejun Heo <tj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Jens Axboe <axboe@kernel.dk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	linux-block@vger.kernel.org
Subject: [RFC 06/10] block: use tida as small id allocator
Date: Thu,  8 Dec 2016 02:23:01 +0100
Message-Id: <1481160187-9652-7-git-send-email-linux@rasmusvillemoes.dk>
In-Reply-To: <1481160187-9652-1-git-send-email-linux@rasmusvillemoes.dk>
References: <1481160187-9652-1-git-send-email-linux@rasmusvillemoes.dk>
List-ID: <linux-block@vger.kernel.org>

A struct ida ends up costing > 16 KB of runtime memory, which is quite
a lot for something which on my laptop as of this writing has handed
out 27 ids in its lifetime. So use the simpler and lighter-weight
struct tida.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 block/blk-core.c  | 6 +++---
 block/blk-sysfs.c | 2 +-
 block/blk.h       | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 14d7c0740dc0..6919a519d797 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -46,7 +46,7 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(block_bio_complete);
 EXPORT_TRACEPOINT_SYMBOL_GPL(block_split);
 EXPORT_TRACEPOINT_SYMBOL_GPL(block_unplug);
 
-DEFINE_IDA(blk_queue_ida);
+DEFINE_TIDA(blk_queue_ida);
 
 /*
  * For the allocated request tables
@@ -699,7 +699,7 @@ struct request_queue *blk_alloc_queue_node(gfp_t gfp_mask, int node_id)
 	if (!q)
 		return NULL;
 
-	q->id = ida_simple_get(&blk_queue_ida, 0, 0, gfp_mask);
+	q->id = tida_get(&blk_queue_ida, gfp_mask);
 	if (q->id < 0)
 		goto fail_q;
 
@@ -771,7 +771,7 @@ struct request_queue *blk_alloc_queue_node(gfp_t gfp_mask, int node_id)
 fail_split:
 	bioset_free(q->bio_split);
 fail_id:
-	ida_simple_remove(&blk_queue_ida, q->id);
+	tida_put(&blk_queue_ida, q->id);
 fail_q:
 	kmem_cache_free(blk_requestq_cachep, q);
 	return NULL;
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 9cc8d7c5439a..5a04dd6cb20d 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -652,7 +652,7 @@ static void blk_release_queue(struct kobject *kobj)
 	if (q->bio_split)
 		bioset_free(q->bio_split);
 
-	ida_simple_remove(&blk_queue_ida, q->id);
+	tida_put(&blk_queue_ida, q->id);
 	call_rcu(&q->rcu_head, blk_free_queue_rcu);
 }
 
diff --git a/block/blk.h b/block/blk.h
index 74444c49078f..a0a606efed91 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -1,7 +1,7 @@
 #ifndef BLK_INTERNAL_H
 #define BLK_INTERNAL_H
 
-#include <linux/idr.h>
+#include <linux/tida.h>
 #include <linux/blk-mq.h>
 #include "blk-mq.h"
 
@@ -34,7 +34,7 @@ struct blk_flush_queue {
 extern struct kmem_cache *blk_requestq_cachep;
 extern struct kmem_cache *request_cachep;
 extern struct kobj_type blk_queue_ktype;
-extern struct ida blk_queue_ida;
+extern struct tida blk_queue_ida;
 
 static inline struct blk_flush_queue *blk_get_flush_queue(
 		struct request_queue *q, struct blk_mq_ctx *ctx)
-- 
2.1.4
