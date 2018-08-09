Return-Path: <prvs=752cffea0=Bart.VanAssche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Tejun Heo <tj@kernel.org>,
	Ming Lei <ming.lei@redhat.com>,
	Omar Sandoval <osandov@fb.com>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	Alexandru Moise <00moses.alexander00@gmail.com>,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	stable@vger.kernel.org
Subject: [PATCH v5 1/3] blkcg: Introduce blkg_root_lookup()
Date: Thu,  9 Aug 2018 07:53:36 -0700
Message-Id: <20180809145338.6160-2-bart.vanassche@wdc.com>
In-Reply-To: <20180809145338.6160-1-bart.vanassche@wdc.com>
References: <20180809145338.6160-1-bart.vanassche@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: bart.vanassche@wdc.com
List-ID: <linux-block@vger.kernel.org>

This new function will be used in a later patch to verify whether a
queue has been dissociated from the cgroup controller before being
released.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Omar Sandoval <osandov@fb.com>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Alexandru Moise <00moses.alexander00@gmail.com>
Cc: Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: <stable@vger.kernel.org>
---
 include/linux/blk-cgroup.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index f7b910768306..1361cfc9b878 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -341,6 +341,23 @@ static inline struct blkcg_gq *blkg_lookup(struct blkcg *blkcg,
 	return __blkg_lookup(blkcg, q, false);
 }
 
+/**
+ * blkg_lookup - look up blkg for the specified request queue
+ * @q: request_queue of interest
+ *
+ * Lookup blkg for @q at the root level. See also blkg_lookup().
+ */
+static inline struct blkcg_gq *blkg_root_lookup(struct request_queue *q)
+{
+	struct blkcg_gq *blkg;
+
+	rcu_read_lock();
+	blkg = blkg_lookup(&blkcg_root, q);
+	rcu_read_unlock();
+
+	return blkg;
+}
+
 /**
  * blkg_to_pdata - get policy private data
  * @blkg: blkg of interest
@@ -864,6 +881,7 @@ static inline bool blk_cgroup_congested(void) { return false; }
 static inline void blkcg_schedule_throttle(struct request_queue *q, bool use_memdelay) { }
 
 static inline struct blkcg_gq *blkg_lookup(struct blkcg *blkcg, void *key) { return NULL; }
+static inline struct blkcg_gq *blkg_root_lookup(struct request_queue *q) { return NULL; }
 static inline int blkcg_init_queue(struct request_queue *q) { return 0; }
 static inline void blkcg_drain_queue(struct request_queue *q) { }
 static inline void blkcg_exit_queue(struct request_queue *q) { }
-- 
2.18.0
