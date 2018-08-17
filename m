Return-Path: <mail@maciej.szmigiero.name>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>,
 Joseph Qi <joseph.qi@linux.alibaba.com>, Tejun Heo <tj@kernel.org>,
 jiufei.xue@linux.alibaba.com, Caspar Zhang <caspar@linux.alibaba.com>
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: [PATCH] blkcg: retry in case of locking failure in
 blkcg_css_offline()
Message-ID: <022a73bc-86e1-f242-09d8-490c3e2462f9@maciej.szmigiero.name>
Date: Fri, 17 Aug 2018 19:29:29 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Commit 4c6994806f70 ("blk-throttle: fix race between blkcg_bio_issue_check() and cgroup_rmdir()")
changed a loop inside blkcg_css_offline() from "while (!hlist_empty(list))"
to "hlist_for_each_entry(list)" as the old condition wouldn't work anymore
due to list elements no longer being removed inside the loop.

However, this means that the code effectively lost an automatic retry in
case of queue_lock locking failure.
Let's put the lock retry back there.

Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Fixes: 4c6994806f70 ("blk-throttle: fix race between blkcg_bio_issue_check() and cgroup_rmdir()").
Cc: stable@vger.kernel.org
---
 block/blk-cgroup.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 694595b29b8f..db4b3331d01a 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1073,16 +1073,23 @@ static void blkcg_css_offline(struct cgroup_subsys_state *css)
 	spin_lock_irq(&blkcg->lock);
 
 	hlist_for_each_entry(blkg, &blkcg->blkg_list, blkcg_node) {
+		bool retry;
 		struct request_queue *q = blkg->q;
 
+again:
 		if (spin_trylock(q->queue_lock)) {
 			blkg_pd_offline(blkg);
 			spin_unlock(q->queue_lock);
+			retry = false;
 		} else {
 			spin_unlock_irq(&blkcg->lock);
 			cpu_relax();
 			spin_lock_irq(&blkcg->lock);
+			retry = true;
 		}
+
+		if (retry)
+			goto again;
 	}
 
 	spin_unlock_irq(&blkcg->lock);
