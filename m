Return-Path: <prvs=753ac577b=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH] blkcg: Make blkg_root_lookup() work for queues in bypass mode
Date: Fri, 10 Aug 2018 13:28:07 -0700
Message-Id: <20180810202807.14620-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

For legacy queues the only call of blkg_root_lookup() happens after
bypass mode has been enabled. Since blkg_lookup() returns NULL for
queues in bypass mode, modify the blkg_root_lookup() such that it
no longer depends on bypass mode. Rename the function into
blk_queue_root_blkg() as suggested by Tejun.

Suggested-by: Tejun Heo <tj@kernel.org>
Fixes: 6bad9b210a22 ("blkcg: Introduce blkg_root_lookup()")
Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Tejun Heo <tj@kernel.org>
---
 block/blk-sysfs.c          |  2 +-
 include/linux/blk-cgroup.h | 15 +++++----------
 2 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index fcadea471779..1bec13c4eb88 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -813,7 +813,7 @@ static void __blk_release_queue(struct work_struct *work)
 		blk_exit_queue(q);
 	}
 
-	WARN(blkg_root_lookup(q),
+	WARN(blk_queue_root_blkg(q),
 	     "request queue %p is being released but it has not yet been removed from the blkcg controller\n",
 	     q);
 
diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index 2b08616dcc11..30bbe053627c 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -344,20 +344,14 @@ static inline struct blkcg_gq *blkg_lookup(struct blkcg *blkcg,
 }
 
 /**
- * blkg_lookup - look up blkg for the specified request queue
+ * blk_queue_root_blkg - return blkg for the (blkcg_root, @q) pair
  * @q: request_queue of interest
  *
  * Lookup blkg for @q at the root level. See also blkg_lookup().
  */
-static inline struct blkcg_gq *blkg_root_lookup(struct request_queue *q)
+static inline struct blkcg_gq *blk_queue_root_blkg(struct request_queue *q)
 {
-	struct blkcg_gq *blkg;
-
-	rcu_read_lock();
-	blkg = blkg_lookup(&blkcg_root, q);
-	rcu_read_unlock();
-
-	return blkg;
+	return q->root_blkg;
 }
 
 /**
@@ -883,7 +877,8 @@ static inline bool blk_cgroup_congested(void) { return false; }
 static inline void blkcg_schedule_throttle(struct request_queue *q, bool use_memdelay) { }
 
 static inline struct blkcg_gq *blkg_lookup(struct blkcg *blkcg, void *key) { return NULL; }
-static inline struct blkcg_gq *blkg_root_lookup(struct request_queue *q) { return NULL; }
+static inline struct blkcg_gq *blk_queue_root_blkg(struct request_queue *q)
+{ return NULL; }
 static inline int blkcg_init_queue(struct request_queue *q) { return 0; }
 static inline void blkcg_drain_queue(struct request_queue *q) { }
 static inline void blkcg_exit_queue(struct request_queue *q) { }
-- 
2.18.0
