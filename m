Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mxhk.zte.com.cn ([63.217.80.70]:47726 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750825AbeCFHui (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 6 Mar 2018 02:50:38 -0500
From: tang.junhui@zte.com.cn
To: colyli@suse.de, mlyle@lyle.org
Cc: linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
        tang.junhui@zte.com.cn
Subject: [PATCH] [v2] bcache: fix using of loop variable in memory shrink
Date: Tue, 6 Mar 2018 15:53:28 +0800
Message-Id: <1520322808-13187-1-git-send-email-tang.junhui@zte.com.cn>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Tang Junhui <tang.junhui@zte.com.cn>

In bch_mca_scan(), There are some confusion and logical error in the use of
loop variables. In this patch, we clarify them as:
1) nr: the number of btree nodes needs to scan, which will decrease after
we scan a btree node, and should not be less than 0;
2) i: the number of btree nodes have scanned, includes both
btree_cache_freeable and btree_cache, which should not be bigger than
btree_cache_used;
3) freed: the number of btree nodes have freed.

Signed-off-by: Tang Junhui <tang.junhui@zte.com.cn>
---
 drivers/md/bcache/btree.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/md/bcache/btree.c b/drivers/md/bcache/btree.c
index 81e8dc3..7487f8e 100644
--- a/drivers/md/bcache/btree.c
+++ b/drivers/md/bcache/btree.c
@@ -664,6 +664,7 @@ static unsigned long bch_mca_scan(struct shrinker *shrink,
 	struct btree *b, *t;
 	unsigned long i, nr = sc->nr_to_scan;
 	unsigned long freed = 0;
+	unsigned int btree_cache_used;
 
 	if (c->shrinker_disabled)
 		return SHRINK_STOP;
@@ -688,9 +689,10 @@ static unsigned long bch_mca_scan(struct shrinker *shrink,
 	nr = min_t(unsigned long, nr, mca_can_free(c));
 
 	i = 0;
+	btree_cache_used = c->btree_cache_used;
 	list_for_each_entry_safe(b, t, &c->btree_cache_freeable, list) {
-		if (freed >= nr)
-			break;
+		if (nr <= 0)
+			goto out;
 
 		if (++i > 3 &&
 		    !mca_reap(b, 0, false)) {
@@ -698,9 +700,10 @@ static unsigned long bch_mca_scan(struct shrinker *shrink,
 			rw_unlock(true, b);
 			freed++;
 		}
+		nr--;
 	}
 
-	for (i = 0; (nr--) && i < c->btree_cache_used; i++) {
+	for (;  (nr--) && i < btree_cache_used; i++) {
 		if (list_empty(&c->btree_cache))
 			goto out;
 
-- 
1.8.3.1
