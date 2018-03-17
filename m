Return-Path: <linux-block-owner@vger.kernel.org>
Received: from out1.zte.com.cn ([202.103.147.172]:58172 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750778AbeCQIyO (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 17 Mar 2018 04:54:14 -0400
From: tang.junhui@zte.com.cn
To: colyli@suse.de, mlyle@lyle.org
Cc: linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
        tang.junhui@zte.com.cn
Subject: [PATCH] bache: put all the sorted bucket in heap into the free_inc queue
Date: Sat, 17 Mar 2018 16:58:36 +0800
Message-Id: <1521277116-8470-1-git-send-email-tang.junhui@zte.com.cn>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Tang Junhui <tang.junhui@zte.com.cn>

We make a lot of effort to sort buckets in heap, but we only pull
half of buckets into free_inc queue, it's too wasteful.

And in incremental GC, we may run out of all buckets in free_inc
queue during GC, so it would be useful if we have more buckets
in free_inc queue.

This patch enlarge the size of free_inc queue as much as the heap.

Signed-off-by: Tang Junhui <tang.junhui@zte.com.cn>
---
 drivers/md/bcache/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index b4d2892..6f428c0 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -1835,7 +1835,7 @@ static int cache_alloc(struct cache *ca)
 	    !init_fifo_exact(&ca->free[RESERVE_PRIO], prio_buckets(ca), GFP_KERNEL) ||
 	    !init_fifo(&ca->free[RESERVE_MOVINGGC], free, GFP_KERNEL) ||
 	    !init_fifo(&ca->free[RESERVE_NONE], free, GFP_KERNEL) ||
-	    !init_fifo(&ca->free_inc,	free << 2, GFP_KERNEL) ||
+	    !init_fifo(&ca->free_inc,	free << 3, GFP_KERNEL) ||
 	    !init_heap(&ca->heap,	free << 3, GFP_KERNEL) ||
 	    !(ca->buckets	= vzalloc(sizeof(struct bucket) *
 					  ca->sb.nbuckets)) ||
-- 
1.8.3.1
