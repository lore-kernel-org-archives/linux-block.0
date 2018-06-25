Return-Path: <josef@toxicpanda.com>
Return-Path: <josef@toxicpanda.com>
From: Josef Bacik <josef@toxicpanda.com>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org,
	kernel-team@fb.com,
	akpm@linux-foundation.org,
	hannes@cmpxchg.org,
	linux-kernel@vger.kernel.org,
	tj@kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 15/15] block: use irq variant for blkcg->lock
Date: Mon, 25 Jun 2018 11:12:43 -0400
Message-Id: <20180625151243.2132-16-josef@toxicpanda.com>
In-Reply-To: <20180625151243.2132-1-josef@toxicpanda.com>
References: <20180625151243.2132-1-josef@toxicpanda.com>
List-ID: <linux-block@vger.kernel.org>

We inconsistently use the irq and non-irq variants of spin_lock for
blkcg->lock, which results in awesome lockdep messages when I have to
use a irq safe lock inside the private data callbacks.  Fix this to
always use the irq safe variants.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 block/blk-cgroup.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index fd614c31ccd2..ab88d96d2e43 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -226,7 +226,7 @@ static struct blkcg_gq *blkg_create(struct blkcg *blkcg,
 	}
 
 	/* insert */
-	spin_lock(&blkcg->lock);
+	spin_lock_irq(&blkcg->lock);
 	ret = radix_tree_insert(&blkcg->blkg_tree, q->id, blkg);
 	if (likely(!ret)) {
 		hlist_add_head_rcu(&blkg->blkcg_node, &blkcg->blkg_list);
@@ -240,7 +240,7 @@ static struct blkcg_gq *blkg_create(struct blkcg *blkcg,
 		}
 	}
 	blkg->online = true;
-	spin_unlock(&blkcg->lock);
+	spin_unlock_irq(&blkcg->lock);
 
 	if (!ret)
 		return blkg;
@@ -381,10 +381,10 @@ static void blkg_destroy_all(struct request_queue *q)
 	list_for_each_entry_safe(blkg, n, &q->blkg_list, q_node) {
 		struct blkcg *blkcg = blkg->blkcg;
 
-		spin_lock(&blkcg->lock);
+		spin_lock_irq(&blkcg->lock);
 		blkg_pd_offline(blkg);
 		blkg_destroy(blkg);
-		spin_unlock(&blkcg->lock);
+		spin_unlock_irq(&blkcg->lock);
 	}
 
 	q->root_blkg = NULL;
-- 
2.14.3
