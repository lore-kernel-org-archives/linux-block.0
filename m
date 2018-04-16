Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mxhk.zte.com.cn ([63.217.80.70]:39408 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750735AbeDPGdp (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Apr 2018 02:33:45 -0400
From: tang.junhui@zte.com.cn
To: kent.overstreet@gmail.com, colyli@suse.de, mlyle@lyle.org
Cc: linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
        tang.junhui@zte.com.cn
Subject: [PATCH v2 3/4] bcache: notify allocator to prepare for GC
Date: Mon, 16 Apr 2018 14:33:49 +0800
Message-Id: <1523860430-31331-4-git-send-email-tang.junhui@zte.com.cn>
In-Reply-To: <1523860430-31331-1-git-send-email-tang.junhui@zte.com.cn>
References: <1523860430-31331-1-git-send-email-tang.junhui@zte.com.cn>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Tang Junhui <tang.junhui@zte.com.cn>

Since no new bucket can be allocated during GC, and front side I/Os would
run out of all the buckets, so notify allocator to pack the free_inc queue
full of buckets before GC, then we could have enough buckets for front side
I/Os during GC period.

The main idea of this patch is:

		GC thread						|		allocator thread
==>triggered by sectors_to_gc			|
	set ca->prepare_gc to GC_PREPARING	|
	to notify allocator thread to		|
	prepare for GC						|==>detect ca->prepare_gc is 
										|	GC_PREPARING,
										|	do invalidate_buckets(),
==>waiting for allocator				|	and fill free_inc queue with
	thread to prepare over				|	reclaimable buckets, after
										|	that, set ca->prepare_gc to
										|	GC_PREPARED to notify GC
										|	thread being prepared
==>detect ca->prepare_gc is				|
	prepared, set						|
	ca->prepare_gc back to				|
	GC_PREPARE_NONE, and continue GC	|

Patch v2: Refactoring code

Signed-off-by: Tang Junhui <tang.junhui@zte.com.cn>
---
 drivers/md/bcache/alloc.c  | 11 ++++++++-
 drivers/md/bcache/bcache.h |  2 ++
 drivers/md/bcache/btree.c  | 59 +++++++++++++++++++++++++++++++++++++++++++---
 drivers/md/bcache/btree.h  |  4 ++++
 4 files changed, 72 insertions(+), 4 deletions(-)

diff --git a/drivers/md/bcache/alloc.c b/drivers/md/bcache/alloc.c
index a0cc1bc..85020cc 100644
--- a/drivers/md/bcache/alloc.c
+++ b/drivers/md/bcache/alloc.c
@@ -323,7 +323,8 @@ static int bch_allocator_thread(void *arg)
 		 * possibly issue discards to them, then we add the bucket to
 		 * the free list:
 		 */
-		while (!fifo_empty(&ca->free_inc)) {
+		while (!fifo_empty(&ca->free_inc) &&
+		       ca->prepare_gc != GC_PREPARING) {
 			long bucket;
 
 			fifo_pop(&ca->free_inc, bucket);
@@ -353,6 +354,14 @@ static int bch_allocator_thread(void *arg)
 		invalidate_buckets(ca);
 
 		/*
+		 * Let GC continue
+		 */
+		if (ca->prepare_gc == GC_PREPARING) {
+			ca->prepare_gc = GC_PREPARED;
+			wake_up_gc(ca->set);
+		}
+
+		/*
 		 * Now, we write their new gens to disk so we can start writing
 		 * new stuff to them:
 		 */
diff --git a/drivers/md/bcache/bcache.h b/drivers/md/bcache/bcache.h
index 5d52be8..e6d5391 100644
--- a/drivers/md/bcache/bcache.h
+++ b/drivers/md/bcache/bcache.h
@@ -428,6 +428,8 @@ struct cache {
 	 * cpu
 	 */
 	unsigned		invalidate_needs_gc;
+	/* used to notify allocator to prepare GC*/
+	unsigned int		prepare_gc;
 
 	bool			discard; /* Get rid of? */
 
diff --git a/drivers/md/bcache/btree.c b/drivers/md/bcache/btree.c
index 2ad0731e..0478821 100644
--- a/drivers/md/bcache/btree.c
+++ b/drivers/md/bcache/btree.c
@@ -1805,19 +1805,72 @@ static void bch_btree_gc(struct cache_set *c)
 	bch_moving_gc(c);
 }
 
+unsigned int get_cache_gc_prepare_status(struct cache_set *c)
+{
+	struct cache *ca;
+	unsigned int i;
+	unsigned int status = GC_PREPARE_NONE;
+
+	for_each_cache(ca, c, i) {
+		if (ca->prepare_gc == GC_PREPARING)
+			return GC_PREPARING;
+
+		status = ca->prepare_gc;
+	}
+
+	return status;
+}
+
+static void set_cache_gc_prepare_status(struct cache_set *c,
+					unsigned int status)
+{
+	struct cache *ca;
+	unsigned int i;
+
+	for_each_cache(ca, c, i)
+		ca->prepare_gc = status;
+}
+
 static bool gc_should_run(struct cache_set *c)
 {
 	struct cache *ca;
 	unsigned i;
+	bool ret = false;
 
 	for_each_cache(ca, c, i)
 		if (ca->invalidate_needs_gc)
 			return true;
 
-	if (atomic_read(&c->sectors_to_gc) < 0)
-		return true;
+	if (atomic_read(&c->sectors_to_gc) < 0) {
+		unsigned int status;
 
-	return false;
+		mutex_lock(&c->bucket_lock);
+		status = get_cache_gc_prepare_status(c);
+		switch (status) {
+		case GC_PREPARE_NONE:
+			/*
+			 * notify allocator thread to prepare for GC
+			 */
+			set_cache_gc_prepare_status(c, GC_PREPARING);
+			break;
+		case GC_PREPARED:
+			/*
+			 * alloc thread finished preparing,
+			 * and continue to GC
+			 */
+			set_cache_gc_prepare_status(c, GC_PREPARE_NONE);
+			ret = true;
+			break;
+		default:
+			/*
+			 * waitting allocator finishing prepareing
+			 */
+			break;
+		}
+		mutex_unlock(&c->bucket_lock);
+	}
+
+	return ret;
 }
 
 static int bch_gc_thread(void *arg)
diff --git a/drivers/md/bcache/btree.h b/drivers/md/bcache/btree.h
index d211e2c..e60bd7a 100644
--- a/drivers/md/bcache/btree.h
+++ b/drivers/md/bcache/btree.h
@@ -102,6 +102,10 @@
 #include "bset.h"
 #include "debug.h"
 
+#define GC_PREPARE_NONE		0
+#define GC_PREPARING		1
+#define GC_PREPARED		2
+
 struct btree_write {
 	atomic_t		*journal;
 
-- 
1.8.3.1
