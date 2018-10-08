Return-Path: <colyli@suse.de>
From: Coly Li <colyli@suse.de>
To: axboe@kernel.dk
Cc: linux-bcache@vger.kernel.org,
	linux-block@vger.kernel.org,
	Dongbo Cao <cdbdyx@163.com>,
	Coly Li <colyli@suse.de>
Subject: [PATCH 14/15] bcache: split combined if-condition code into separate ones
Date: Mon,  8 Oct 2018 20:41:20 +0800
Message-Id: <20181008124121.20192-15-colyli@suse.de>
In-Reply-To: <20181008124121.20192-1-colyli@suse.de>
References: <20181008124121.20192-1-colyli@suse.de>
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

From: Dongbo Cao <cdbdyx@163.com>

Split the combined '||' statements in if() check, to make the code easier
for debug.

Signed-off-by: Dongbo Cao <cdbdyx@163.com>
Signed-off-by: Coly Li <colyli@suse.de>
---
 drivers/md/bcache/super.c | 90 +++++++++++++++++++++++++++++++++------
 1 file changed, 76 insertions(+), 14 deletions(-)

diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index 719686ea5e27..2a362a7ba995 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -2051,6 +2051,8 @@ static int cache_alloc(struct cache *ca)
 	size_t free;
 	size_t btree_buckets;
 	struct bucket *b;
+	int ret = -ENOMEM;
+	const char *err = NULL;
 
 	__module_get(THIS_MODULE);
 	kobject_init(&ca->kobj, &bch_cache_ktype);
@@ -2069,26 +2071,86 @@ static int cache_alloc(struct cache *ca)
 	btree_buckets = ca->sb.njournal_buckets ?: 8;
 	free = roundup_pow_of_two(ca->sb.nbuckets) >> 10;
 
-	if (!init_fifo(&ca->free[RESERVE_BTREE], btree_buckets, GFP_KERNEL) ||
-	    !init_fifo_exact(&ca->free[RESERVE_PRIO], prio_buckets(ca), GFP_KERNEL) ||
-	    !init_fifo(&ca->free[RESERVE_MOVINGGC], free, GFP_KERNEL) ||
-	    !init_fifo(&ca->free[RESERVE_NONE], free, GFP_KERNEL) ||
-	    !init_fifo(&ca->free_inc,	free << 2, GFP_KERNEL) ||
-	    !init_heap(&ca->heap,	free << 3, GFP_KERNEL) ||
-	    !(ca->buckets	= vzalloc(array_size(sizeof(struct bucket),
-						     ca->sb.nbuckets))) ||
-	    !(ca->prio_buckets	= kzalloc(array3_size(sizeof(uint64_t),
-						      prio_buckets(ca), 2),
-					  GFP_KERNEL)) ||
-	    !(ca->disk_buckets	= alloc_bucket_pages(GFP_KERNEL, ca)))
-		return -ENOMEM;
+	if (!init_fifo(&ca->free[RESERVE_BTREE], btree_buckets,
+						GFP_KERNEL)) {
+		err = "ca->free[RESERVE_BTREE] alloc failed";
+		goto err_btree_alloc;
+	}
+
+	if (!init_fifo_exact(&ca->free[RESERVE_PRIO], prio_buckets(ca),
+							GFP_KERNEL)) {
+		err = "ca->free[RESERVE_PRIO] alloc failed";
+		goto err_prio_alloc;
+	}
+
+	if (!init_fifo(&ca->free[RESERVE_MOVINGGC], free, GFP_KERNEL)) {
+		err = "ca->free[RESERVE_MOVINGGC] alloc failed";
+		goto err_movinggc_alloc;
+	}
+
+	if (!init_fifo(&ca->free[RESERVE_NONE], free, GFP_KERNEL)) {
+		err = "ca->free[RESERVE_NONE] alloc failed";
+		goto err_none_alloc;
+	}
+
+	if (!init_fifo(&ca->free_inc, free << 2, GFP_KERNEL)) {
+		err = "ca->free_inc alloc failed";
+		goto err_free_inc_alloc;
+	}
+
+	if (!init_heap(&ca->heap, free << 3, GFP_KERNEL)) {
+		err = "ca->heap alloc failed";
+		goto err_heap_alloc;
+	}
+
+	ca->buckets = vzalloc(array_size(sizeof(struct bucket),
+			      ca->sb.nbuckets));
+	if (!ca->buckets) {
+		err = "ca->buckets alloc failed";
+		goto err_buckets_alloc;
+	}
+
+	ca->prio_buckets = kzalloc(array3_size(sizeof(uint64_t),
+				   prio_buckets(ca), 2),
+				   GFP_KERNEL);
+	if (!ca->prio_buckets) {
+		err = "ca->prio_buckets alloc failed";
+		goto err_prio_buckets_alloc;
+	}
+
+	ca->disk_buckets = alloc_bucket_pages(GFP_KERNEL, ca);
+	if (!ca->disk_buckets) {
+		err = "ca->disk_buckets alloc failed";
+		goto err_disk_buckets_alloc;
+	}
 
 	ca->prio_last_buckets = ca->prio_buckets + prio_buckets(ca);
 
 	for_each_bucket(b, ca)
 		atomic_set(&b->pin, 0);
-
 	return 0;
+
+err_disk_buckets_alloc:
+	kfree(ca->prio_buckets);
+err_prio_buckets_alloc:
+	vfree(ca->buckets);
+err_buckets_alloc:
+	free_heap(&ca->heap);
+err_heap_alloc:
+	free_fifo(&ca->free_inc);
+err_free_inc_alloc:
+	free_fifo(&ca->free[RESERVE_NONE]);
+err_none_alloc:
+	free_fifo(&ca->free[RESERVE_MOVINGGC]);
+err_movinggc_alloc:
+	free_fifo(&ca->free[RESERVE_PRIO]);
+err_prio_alloc:
+	free_fifo(&ca->free[RESERVE_BTREE]);
+err_btree_alloc:
+	module_put(THIS_MODULE);
+	if (err)
+		pr_notice("error %s: %s", ca->cache_dev_name, err);
+	return ret;
 }
 
 static int register_cache(struct cache_sb *sb, struct page *sb_page,
-- 
2.19.0
