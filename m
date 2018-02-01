Return-Path: <keith.busch@intel.com>
From: Keith Busch <keith.busch@intel.com>
To: Linux Block <linux-block@vger.kernel.org>,
	Linux NVMe <linux-nvme@lists.infradead.org>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <keith.busch@intel.com>
Subject: [PATCHv2 2/2] block: Handle merging discards in IO schedulers
Date: Thu,  1 Feb 2018 13:31:58 -0700
Message-Id: <20180201203158.24761-3-keith.busch@intel.com>
In-Reply-To: <20180201203158.24761-1-keith.busch@intel.com>
References: <20180201203158.24761-1-keith.busch@intel.com>
List-ID: <linux-block@vger.kernel.org>

This adds support for merging discard requests in all IO schedulers.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 block/bfq-iosched.c      | 2 +-
 block/blk-core.c         | 4 ++++
 block/blk-mq-sched.c     | 2 ++
 block/cfq-iosched.c      | 2 +-
 block/deadline-iosched.c | 4 +++-
 block/elevator.c         | 2 +-
 block/mq-deadline.c      | 2 +-
 7 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 47e6ec7427c4..9b08c08298a6 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -1839,7 +1839,7 @@ static int bfq_request_merge(struct request_queue *q, struct request **req,
 	__rq = bfq_find_rq_fmerge(bfqd, bio, q);
 	if (__rq && elv_bio_merge_ok(__rq, bio)) {
 		*req = __rq;
-		return ELEVATOR_FRONT_MERGE;
+		return blk_try_merge(__rq, bio);
 	}
 
 	return ELEVATOR_NO_MERGE;
diff --git a/block/blk-core.c b/block/blk-core.c
index a2005a485335..295ce3cbe1f6 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1952,6 +1952,10 @@ static blk_qc_t blk_queue_bio(struct request_queue *q, struct bio *bio)
 		else
 			elv_merged_request(q, req, ELEVATOR_FRONT_MERGE);
 		goto out_unlock;
+	case ELEVATOR_DISCARD_MERGE:
+		if (!bio_attempt_discard_merge(q, req, bio))
+			break;
+		goto out_unlock;
 	default:
 		break;
 	}
diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 55c0a745b427..25c14c58385c 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -259,6 +259,8 @@ bool blk_mq_sched_try_merge(struct request_queue *q, struct bio *bio,
 		if (!*merged_request)
 			elv_merged_request(q, rq, ELEVATOR_FRONT_MERGE);
 		return true;
+	case ELEVATOR_DISCARD_MERGE:
+		return bio_attempt_discard_merge(q, rq, bio);
 	default:
 		return false;
 	}
diff --git a/block/cfq-iosched.c b/block/cfq-iosched.c
index 9f342ef1ad42..38158873d775 100644
--- a/block/cfq-iosched.c
+++ b/block/cfq-iosched.c
@@ -2518,7 +2518,7 @@ static enum elv_merge cfq_merge(struct request_queue *q, struct request **req,
 	__rq = cfq_find_rq_fmerge(cfqd, bio);
 	if (__rq && elv_bio_merge_ok(__rq, bio)) {
 		*req = __rq;
-		return ELEVATOR_FRONT_MERGE;
+		return blk_try_merge(__rq, bio);
 	}
 
 	return ELEVATOR_NO_MERGE;
diff --git a/block/deadline-iosched.c b/block/deadline-iosched.c
index 9de9f156e203..849e03938653 100644
--- a/block/deadline-iosched.c
+++ b/block/deadline-iosched.c
@@ -14,6 +14,8 @@
 #include <linux/compiler.h>
 #include <linux/rbtree.h>
 
+#include "blk.h"
+
 /*
  * See Documentation/block/deadline-iosched.txt
  */
@@ -142,7 +144,7 @@ deadline_merge(struct request_queue *q, struct request **req, struct bio *bio)
 
 			if (elv_bio_merge_ok(__rq, bio)) {
 				*req = __rq;
-				return ELEVATOR_FRONT_MERGE;
+				return blk_try_merge(__rq, bio);
 			}
 		}
 	}
diff --git a/block/elevator.c b/block/elevator.c
index e87e9b43aba0..7fd6cb9cfec1 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -484,7 +484,7 @@ enum elv_merge elv_merge(struct request_queue *q, struct request **req,
 	__rq = elv_rqhash_find(q, bio->bi_iter.bi_sector);
 	if (__rq && elv_bio_merge_ok(__rq, bio)) {
 		*req = __rq;
-		return ELEVATOR_BACK_MERGE;
+		return blk_try_merge(__rq, bio);
 	}
 
 	if (e->uses_mq && e->type->ops.mq.request_merge)
diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index c56f211c8440..a0f5752b6858 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -451,7 +451,7 @@ static int dd_request_merge(struct request_queue *q, struct request **rq,
 
 		if (elv_bio_merge_ok(__rq, bio)) {
 			*rq = __rq;
-			return ELEVATOR_FRONT_MERGE;
+			return blk_try_merge(__rq, bio);
 		}
 	}
 
-- 
2.14.3
