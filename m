Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pl0-f66.google.com ([209.85.160.66]:37332 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754721AbeCSAgv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 18 Mar 2018 20:36:51 -0400
Received: by mail-pl0-f66.google.com with SMTP id w12-v6so9225161plp.4
        for <linux-block@vger.kernel.org>; Sun, 18 Mar 2018 17:36:51 -0700 (PDT)
From: Michael Lyle <mlyle@lyle.org>
To: linux-bcache@vger.kernel.org, linux-block@vger.kernel.org
Cc: axboe@fb.com, Tang Junhui <tang.junhui@zte.com.cn>
Subject: [for-4.17 09/20] bcache: fix using of loop variable in memory shrink
Date: Sun, 18 Mar 2018 17:36:22 -0700
Message-Id: <20180319003633.27225-10-mlyle@lyle.org>
In-Reply-To: <20180319003633.27225-1-mlyle@lyle.org>
References: <20180319003633.27225-1-mlyle@lyle.org>
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
Reviewed-by: Michael Lyle <mlyle@lyle.org>
---
 drivers/md/bcache/btree.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/md/bcache/btree.c b/drivers/md/bcache/btree.c
index b2d4899f48d5..d64aff0b8abc 100644
--- a/drivers/md/bcache/btree.c
+++ b/drivers/md/bcache/btree.c
@@ -665,6 +665,7 @@ static unsigned long bch_mca_scan(struct shrinker *shrink,
 	struct btree *b, *t;
 	unsigned long i, nr = sc->nr_to_scan;
 	unsigned long freed = 0;
+	unsigned int btree_cache_used;
 
 	if (c->shrinker_disabled)
 		return SHRINK_STOP;
@@ -689,9 +690,10 @@ static unsigned long bch_mca_scan(struct shrinker *shrink,
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
@@ -699,9 +701,10 @@ static unsigned long bch_mca_scan(struct shrinker *shrink,
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
2.14.1
