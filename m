Return-Path: <colyli@suse.de>
From: Coly Li <colyli@suse.de>
To: axboe@kernel.dk,
	linux-bcache@vger.kernel.org
Cc: linux-block@vger.kernel.org,
	Coly Li <colyli@suse.de>
Subject: [PATCH 03/10] bcache: avoid unncessary cache prefetch bch_btree_node_get()
Date: Thu,  9 Aug 2018 15:48:44 +0800
Message-Id: <20180809074851.11027-4-colyli@suse.de>
In-Reply-To: <20180809074851.11027-1-colyli@suse.de>
References: <20180809074851.11027-1-colyli@suse.de>
List-ID: <linux-block@vger.kernel.org>

In bch_btree_node_get() the read-in btree node will be partially
prefetched into L1 cache for following bset iteration (if there is).
But if the btree node read is failed, the perfetch operations will
waste L1 cache space. This patch checkes whether read operation and
only does cache prefetch when read I/O succeeded.

Signed-off-by: Coly Li <colyli@suse.de>
---
 drivers/md/bcache/btree.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/md/bcache/btree.c b/drivers/md/bcache/btree.c
index 475008fbbaab..c19f7716df88 100644
--- a/drivers/md/bcache/btree.c
+++ b/drivers/md/bcache/btree.c
@@ -1011,6 +1011,13 @@ struct btree *bch_btree_node_get(struct cache_set *c, struct btree_op *op,
 		BUG_ON(b->level != level);
 	}
 
+	if (btree_node_io_error(b)) {
+		rw_unlock(write, b);
+		return ERR_PTR(-EIO);
+	}
+
+	BUG_ON(!b->written);
+
 	b->parent = parent;
 	b->accessed = 1;
 
@@ -1022,13 +1029,6 @@ struct btree *bch_btree_node_get(struct cache_set *c, struct btree_op *op,
 	for (; i <= b->keys.nsets; i++)
 		prefetch(b->keys.set[i].data);
 
-	if (btree_node_io_error(b)) {
-		rw_unlock(write, b);
-		return ERR_PTR(-EIO);
-	}
-
-	BUG_ON(!b->written);
-
 	return b;
 }
 
-- 
2.18.0
