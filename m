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
Cc: Josef Bacik <jbacik@fb.com>
Subject: [PATCH 11/15] rq-qos: introduce dio_bio callback
Date: Mon, 25 Jun 2018 11:12:39 -0400
Message-Id: <20180625151243.2132-12-josef@toxicpanda.com>
In-Reply-To: <20180625151243.2132-1-josef@toxicpanda.com>
References: <20180625151243.2132-1-josef@toxicpanda.com>
List-ID: <linux-block@vger.kernel.org>

From: Josef Bacik <jbacik@fb.com>

wbt cares only about request completion time, but controllers may need
information that is on the bio itself, so add a done_bio callback for
rq-qos so things like blk-iolatency can use it to have the bio when it
completes.

Signed-off-by: Josef Bacik <jbacik@fb.com>
---
 block/bio.c        |  4 ++++
 block/blk-rq-qos.c | 10 ++++++++++
 block/blk-rq-qos.h |  2 ++
 3 files changed, 16 insertions(+)

diff --git a/block/bio.c b/block/bio.c
index c77fe1b4caa8..99809b73a400 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -32,6 +32,7 @@
 
 #include <trace/events/block.h>
 #include "blk.h"
+#include "blk-rq-qos.h"
 
 /*
  * Test patch to inline a certain number of bi_io_vec's inside the bio
@@ -1781,6 +1782,9 @@ void bio_endio(struct bio *bio)
 	if (WARN_ONCE(bio->bi_next, "driver left bi_next not NULL"))
 		bio->bi_next = NULL;
 
+	if (bio->bi_disk)
+		rq_qos_done_bio(bio->bi_disk->queue, bio);
+
 	/*
 	 * Need to have a real endio function for chained bios, otherwise
 	 * various corner cases will break (like stacking block devices that
diff --git a/block/blk-rq-qos.c b/block/blk-rq-qos.c
index b7b02e04f64f..5134b24482f6 100644
--- a/block/blk-rq-qos.c
+++ b/block/blk-rq-qos.c
@@ -88,6 +88,16 @@ void rq_qos_track(struct request_queue *q, struct request *rq, struct bio *bio)
 	}
 }
 
+void rq_qos_done_bio(struct request_queue *q, struct bio *bio)
+{
+	struct rq_qos *rqos;
+
+	for(rqos = q->rq_qos; rqos; rqos = rqos->next) {
+		if (rqos->ops->done_bio)
+			rqos->ops->done_bio(rqos, bio);
+	}
+}
+
 /*
  * Return true, if we can't increase the depth further by scaling
  */
diff --git a/block/blk-rq-qos.h b/block/blk-rq-qos.h
index 501253676dd8..3874e6ad09f0 100644
--- a/block/blk-rq-qos.h
+++ b/block/blk-rq-qos.h
@@ -30,6 +30,7 @@ struct rq_qos_ops {
 	void (*issue)(struct rq_qos *, struct request *);
 	void (*requeue)(struct rq_qos *, struct request *);
 	void (*done)(struct rq_qos *, struct request *);
+	void (*done_bio)(struct rq_qos *, struct bio *);
 	void (*cleanup)(struct rq_qos *, struct bio *);
 	void (*exit)(struct rq_qos *);
 };
@@ -86,6 +87,7 @@ void rq_qos_cleanup(struct request_queue *, struct bio *);
 void rq_qos_done(struct request_queue *, struct request *);
 void rq_qos_issue(struct request_queue *, struct request *);
 void rq_qos_requeue(struct request_queue *, struct request *);
+void rq_qos_done_bio(struct request_queue *q, struct bio *bio);
 void rq_qos_throttle(struct request_queue *, struct bio *, spinlock_t *);
 void rq_qos_track(struct request_queue *q, struct request *, struct bio *);
 void rq_qos_exit(struct request_queue *);
-- 
2.14.3
