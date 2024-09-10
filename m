Received: from 189.cn (ptr.189.cn [183.61.185.103])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 693AE339AC;
	Tue, 10 Sep 2024 08:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=183.61.185.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725958064; cv=none; b=ofN8RJPayNVpO00//R9tLlxpsYtvrqhpx3bRd4aVhr1994RtJgoSs/bEhx7DzirWTdvZyVmd3jk3jD+STWPPo7tsp9rpmIEvQHJis6rPJlQZzLUxHiNeejusjhWyW9WJe2LEUAEW2ksX6WhRbBr6skQ/QNt0NO0O7b4/x3NmwPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725958064; c=relaxed/simple;
	bh=1DaEvN+kL6q16ZIm6Z8fBX/5uac/UzkFsTq+CcEGgMY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rSrbuChi08z0C74/naiB6TUIb+nCOi2Tm7Jd9e9fLMjc8Lw75HgrMzxvC7jdyvpnK0whutLIgG6rJoDLD8UkRYXF+y1c4BZl35ehEOA2jdhgIQrujsItTY5xkZ8antSUysGm3jsE1IxaEojqoo1BAwhJP9Qkw8tl+hxHBjNe8us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=189.cn; spf=pass smtp.mailfrom=189.cn; arc=none smtp.client-ip=183.61.185.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=189.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=189.cn
HMM_SOURCE_IP:10.158.242.145:3112.620420812
HMM_ATTACHE_NUM:0000
HMM_SOURCE_TYPE:SMTP
Received: from clientip-123.150.8.42 (unknown [10.158.242.145])
	by 189.cn (HERMES) with SMTP id 5D15D1002BE;
	Tue, 10 Sep 2024 16:42:41 +0800 (CST)
Received: from  ([123.150.8.42])
	by gateway-153622-dep-68cfdf7599-zbmfg with ESMTP id d207631d2c03443aad32dabe2cbe8b5d for axboe@kernel.dk;
	Tue, 10 Sep 2024 16:42:42 CST
X-Transaction-ID: d207631d2c03443aad32dabe2cbe8b5d
X-Real-From: chensong_2000@189.cn
X-Receive-IP: 123.150.8.42
X-MEDUSA-Status: 0
Sender: chensong_2000@189.cn
From: chensong_2000@189.cn
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Song Chen <chensong_2000@189.cn>
Subject: [PATCH] block/blk-rq-qos: introduce macro RQ_QOS_FN for common behaviors in rq_qos*
Date: Tue, 10 Sep 2024 16:42:38 +0800
Message-Id: <20240910084238.3543971-1-chensong_2000@189.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Song Chen <chensong_2000@189.cn>

Below functions in blk-rq.qos.c have similar behaviors:
	__rq_qos_cleanup
	__rq_qos_done
	__rq_qos_issue
	__rq_qos_requeue
	__rq_qos_throttle
	__rq_qos_track
	__rq_qos_merge
	__rq_qos_done_bio
	__rq_qos_queue_depth_changed

Those functions traverse rq_qos in request_queue and call callback function
in rq_qos_ops if it exists.

This patch removes those duplicated code and abstract it in a helper macro
RQ_QOS_FN.

Signed-off-by: Song Chen <chensong_2000@189.cn>
---
 block/blk-rq-qos.c | 88 ++--------------------------------------------
 block/blk-rq-qos.h | 39 ++++++++++----------
 2 files changed, 23 insertions(+), 104 deletions(-)

diff --git a/block/blk-rq-qos.c b/block/blk-rq-qos.c
index dd7310c94713..c41f314ab024 100644
--- a/block/blk-rq-qos.c
+++ b/block/blk-rq-qos.c
@@ -23,87 +23,6 @@ bool rq_wait_inc_below(struct rq_wait *rq_wait, unsigned int limit)
 	return atomic_inc_below(&rq_wait->inflight, limit);
 }
 
-void __rq_qos_cleanup(struct rq_qos *rqos, struct bio *bio)
-{
-	do {
-		if (rqos->ops->cleanup)
-			rqos->ops->cleanup(rqos, bio);
-		rqos = rqos->next;
-	} while (rqos);
-}
-
-void __rq_qos_done(struct rq_qos *rqos, struct request *rq)
-{
-	do {
-		if (rqos->ops->done)
-			rqos->ops->done(rqos, rq);
-		rqos = rqos->next;
-	} while (rqos);
-}
-
-void __rq_qos_issue(struct rq_qos *rqos, struct request *rq)
-{
-	do {
-		if (rqos->ops->issue)
-			rqos->ops->issue(rqos, rq);
-		rqos = rqos->next;
-	} while (rqos);
-}
-
-void __rq_qos_requeue(struct rq_qos *rqos, struct request *rq)
-{
-	do {
-		if (rqos->ops->requeue)
-			rqos->ops->requeue(rqos, rq);
-		rqos = rqos->next;
-	} while (rqos);
-}
-
-void __rq_qos_throttle(struct rq_qos *rqos, struct bio *bio)
-{
-	do {
-		if (rqos->ops->throttle)
-			rqos->ops->throttle(rqos, bio);
-		rqos = rqos->next;
-	} while (rqos);
-}
-
-void __rq_qos_track(struct rq_qos *rqos, struct request *rq, struct bio *bio)
-{
-	do {
-		if (rqos->ops->track)
-			rqos->ops->track(rqos, rq, bio);
-		rqos = rqos->next;
-	} while (rqos);
-}
-
-void __rq_qos_merge(struct rq_qos *rqos, struct request *rq, struct bio *bio)
-{
-	do {
-		if (rqos->ops->merge)
-			rqos->ops->merge(rqos, rq, bio);
-		rqos = rqos->next;
-	} while (rqos);
-}
-
-void __rq_qos_done_bio(struct rq_qos *rqos, struct bio *bio)
-{
-	do {
-		if (rqos->ops->done_bio)
-			rqos->ops->done_bio(rqos, bio);
-		rqos = rqos->next;
-	} while (rqos);
-}
-
-void __rq_qos_queue_depth_changed(struct rq_qos *rqos)
-{
-	do {
-		if (rqos->ops->queue_depth_changed)
-			rqos->ops->queue_depth_changed(rqos);
-		rqos = rqos->next;
-	} while (rqos);
-}
-
 /*
  * Return true, if we can't increase the depth further by scaling
  */
@@ -288,12 +207,11 @@ void rq_qos_wait(struct rq_wait *rqw, void *private_data,
 
 void rq_qos_exit(struct request_queue *q)
 {
+	struct rq_qos *rqos;
+
 	mutex_lock(&q->rq_qos_mutex);
-	while (q->rq_qos) {
-		struct rq_qos *rqos = q->rq_qos;
-		q->rq_qos = rqos->next;
+	for_each_rqos(rqos, q)
 		rqos->ops->exit(rqos);
-	}
 	mutex_unlock(&q->rq_qos_mutex);
 }
 
diff --git a/block/blk-rq-qos.h b/block/blk-rq-qos.h
index 37245c97ee61..0f22669dce68 100644
--- a/block/blk-rq-qos.h
+++ b/block/blk-rq-qos.h
@@ -58,11 +58,14 @@ struct rq_depth {
 	unsigned int default_depth;
 };
 
+#define for_each_rqos(rqos, q)	\
+	for (rqos = q->rq_qos; rqos; rqos = rqos->next)
+
 static inline struct rq_qos *rq_qos_id(struct request_queue *q,
 				       enum rq_qos_id id)
 {
 	struct rq_qos *rqos;
-	for (rqos = q->rq_qos; rqos; rqos = rqos->next) {
+	for_each_rqos(rqos, q) {
 		if (rqos->id == id)
 			break;
 	}
@@ -100,38 +103,36 @@ bool rq_depth_scale_up(struct rq_depth *rqd);
 bool rq_depth_scale_down(struct rq_depth *rqd, bool hard_throttle);
 bool rq_depth_calc_max_depth(struct rq_depth *rqd);
 
-void __rq_qos_cleanup(struct rq_qos *rqos, struct bio *bio);
-void __rq_qos_done(struct rq_qos *rqos, struct request *rq);
-void __rq_qos_issue(struct rq_qos *rqos, struct request *rq);
-void __rq_qos_requeue(struct rq_qos *rqos, struct request *rq);
-void __rq_qos_throttle(struct rq_qos *rqos, struct bio *bio);
-void __rq_qos_track(struct rq_qos *rqos, struct request *rq, struct bio *bio);
-void __rq_qos_merge(struct rq_qos *rqos, struct request *rq, struct bio *bio);
-void __rq_qos_done_bio(struct rq_qos *rqos, struct bio *bio);
-void __rq_qos_queue_depth_changed(struct rq_qos *rqos);
+#define RQ_QOS_FN(q, fn, ...)	\
+	do {	\
+		struct rq_qos *rqos;	\
+		for_each_rqos(rqos, q)	\
+			if (rqos->ops->fn)	\
+				rqos->ops->fn(rqos, ##__VA_ARGS__);	\
+	} while (0)
 
 static inline void rq_qos_cleanup(struct request_queue *q, struct bio *bio)
 {
 	if (q->rq_qos)
-		__rq_qos_cleanup(q->rq_qos, bio);
+		RQ_QOS_FN(q, cleanup, bio);
 }
 
 static inline void rq_qos_done(struct request_queue *q, struct request *rq)
 {
 	if (q->rq_qos && !blk_rq_is_passthrough(rq))
-		__rq_qos_done(q->rq_qos, rq);
+		RQ_QOS_FN(q, done, rq);
 }
 
 static inline void rq_qos_issue(struct request_queue *q, struct request *rq)
 {
 	if (q->rq_qos)
-		__rq_qos_issue(q->rq_qos, rq);
+		RQ_QOS_FN(q, issue, rq);
 }
 
 static inline void rq_qos_requeue(struct request_queue *q, struct request *rq)
 {
 	if (q->rq_qos)
-		__rq_qos_requeue(q->rq_qos, rq);
+		RQ_QOS_FN(q, requeue, rq);
 }
 
 static inline void rq_qos_done_bio(struct bio *bio)
@@ -140,7 +141,7 @@ static inline void rq_qos_done_bio(struct bio *bio)
 			     bio_flagged(bio, BIO_QOS_MERGED))) {
 		struct request_queue *q = bdev_get_queue(bio->bi_bdev);
 		if (q->rq_qos)
-			__rq_qos_done_bio(q->rq_qos, bio);
+			RQ_QOS_FN(q, done_bio, bio);
 	}
 }
 
@@ -148,7 +149,7 @@ static inline void rq_qos_throttle(struct request_queue *q, struct bio *bio)
 {
 	if (q->rq_qos) {
 		bio_set_flag(bio, BIO_QOS_THROTTLED);
-		__rq_qos_throttle(q->rq_qos, bio);
+		RQ_QOS_FN(q, throttle, bio);
 	}
 }
 
@@ -156,7 +157,7 @@ static inline void rq_qos_track(struct request_queue *q, struct request *rq,
 				struct bio *bio)
 {
 	if (q->rq_qos)
-		__rq_qos_track(q->rq_qos, rq, bio);
+		RQ_QOS_FN(q, track, rq, bio);
 }
 
 static inline void rq_qos_merge(struct request_queue *q, struct request *rq,
@@ -164,14 +165,14 @@ static inline void rq_qos_merge(struct request_queue *q, struct request *rq,
 {
 	if (q->rq_qos) {
 		bio_set_flag(bio, BIO_QOS_MERGED);
-		__rq_qos_merge(q->rq_qos, rq, bio);
+		RQ_QOS_FN(q, merge, rq, bio);
 	}
 }
 
 static inline void rq_qos_queue_depth_changed(struct request_queue *q)
 {
 	if (q->rq_qos)
-		__rq_qos_queue_depth_changed(q->rq_qos);
+		RQ_QOS_FN(q, queue_depth_changed);
 }
 
 void rq_qos_exit(struct request_queue *);
-- 
2.34.1

