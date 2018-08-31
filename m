Return-Path: <dennisszhou@gmail.com>
Return-Path: <dennisszhou@gmail.com>
From: Dennis Zhou <dennisszhou@gmail.com>
To: Jens Axboe <axboe@kernel.dk>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Josef Bacik <josef@toxicpanda.com>
Cc: kernel-team@fb.com,
	linux-block@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dennis Zhou (Facebook)" <dennisszhou@gmail.com>
Subject: [PATCH 12/15] blkcg: cleanup and make blk_get_rl use blkg_lookup_create
Date: Thu, 30 Aug 2018 21:53:53 -0400
Message-Id: <20180831015356.69796-13-dennisszhou@gmail.com>
In-Reply-To: <20180831015356.69796-1-dennisszhou@gmail.com>
References: <20180831015356.69796-1-dennisszhou@gmail.com>
List-ID: <linux-block@vger.kernel.org>

From: "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>

blk_get_rl is responsible for identifying which request_list a request
should be allocated to. Try get logic was added earlier, but
semantically the logic was not changed.

This patch makes better use of the bio already having a reference to the
blkg in the hot path. The cold path uses a better fallback of
blkg_lookup_create rather than just blkg_lookup and then falling back to
the q->root_rl. If lookup_create fails with anything but -ENODEV, it
falls back to q->root_rl.

A clarifying comment is added to explain why q->root_rl is used rather
than the root blkg's rl.

Signed-off-by: Dennis Zhou <dennisszhou@gmail.com>
---
 include/linux/blk-cgroup.h | 53 ++++++++++++++++++++++++++------------
 1 file changed, 37 insertions(+), 16 deletions(-)

diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index 3eed491e4daa..97cb82029b18 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -537,28 +537,49 @@ static inline struct request_list *blk_get_rl(struct request_queue *q,
 
 	rcu_read_lock();
 
-	blkcg = bio_blkcg(bio);
-	if (!blkcg)
+	blkg = bio->bi_blkg;
+	if (blkg) {
+		blkcg = bio->bi_blkg->blkcg;
+		if (blkcg == &blkcg_root)
+			goto rl_use_root;
+
+		blkg_get(blkg);
+		return &blkg->rl;
+	}
+
+	while (true) {
 		blkcg = css_to_blkcg(blkcg_css());
+		if (blkcg == &blkcg_root)
+			goto rl_use_root;
 
-	/* bypass blkg lookup and use @q->root_rl directly for root */
-	if (blkcg == &blkcg_root)
-		goto root_rl;
+		blkg = blkg_lookup(blkcg, q);
 
-	/*
-	 * Try to use blkg->rl.  blkg lookup may fail under memory pressure
-	 * or if either the blkcg or queue is going away.  Fall back to
-	 * root_rl in such cases.
-	 */
-	blkg = blkg_lookup(blkcg, q);
-	if (unlikely(!blkg))
-		goto root_rl;
+		if (unlikely(!blkg))
+			blkg = __blkg_lookup_create(blkcg, q);
+
+		if (IS_ERR(blkg)) {
+			if (PTR_ERR(blkg) == -ENODEV) {
+				cpu_relax();
+				continue;
+			} else {
+				goto rl_use_root;
+			}
+		}
+
+		if (blkg_try_get(blkg))
+			break;
+		cpu_relax();
+	}
 
-	if (!blkg_try_get(blkg))
-		goto root_rl;
 	rcu_read_unlock();
 	return &blkg->rl;
-root_rl:
+
+	/*
+	 * Each blkg has its own request_list, however, the root blkcg
+	 * uses the request_queue's root_rl.  This is to avoid most
+	 * overhead for the root blkcg.
+	 */
+rl_use_root:
 	rcu_read_unlock();
 	return &q->root_rl;
 }
-- 
2.17.1
