Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
From: Paolo Valente <paolo.valente@linaro.org>
To: Jens Axboe <axboe@kernel.dk>,
	Tejun Heo <tj@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ulf.hansson@linaro.org,
	linus.walleij@linaro.org,
	broonie@kernel.org,
	Paolo Valente <paolo.valente@linaro.org>
Subject: [WIP PATCHSET 3/4] Embed bfq-ioc.c and add locking on request queue
Date: Tue,  7 Feb 2017 18:24:45 +0100
Message-Id: <20170207172446.4528-4-paolo.valente@linaro.org>
In-Reply-To: <20170207172446.4528-1-paolo.valente@linaro.org>
References: <20170207172446.4528-1-paolo.valente@linaro.org>
List-ID: <linux-block@vger.kernel.org>

The version of bfq-ioc.c for bfq-iosched.c is not correct any more for
bfq-mq, because, in bfq-mq, the request queue lock is not being held
when bfq_bic_lookup is invoked. That function must then take that look
on its own. This commit removes the inclusion of bfq-ioc.c, copies the
content of bfq-ioc.c into bfq-mq-iosched.c, and adds the grabbing of
the lock.

Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-mq-iosched.c | 39 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 36 insertions(+), 3 deletions(-)

diff --git a/block/bfq-mq-iosched.c b/block/bfq-mq-iosched.c
index 7e3f429..a8679de 100644
--- a/block/bfq-mq-iosched.c
+++ b/block/bfq-mq-iosched.c
@@ -190,7 +190,39 @@ static int device_speed_thresh[2];
 
 static void bfq_schedule_dispatch(struct bfq_data *bfqd);
 
-#include "bfq-ioc.c"
+/**
+ * icq_to_bic - convert iocontext queue structure to bfq_io_cq.
+ * @icq: the iocontext queue.
+ */
+static struct bfq_io_cq *icq_to_bic(struct io_cq *icq)
+{
+	/* bic->icq is the first member, %NULL will convert to %NULL */
+	return container_of(icq, struct bfq_io_cq, icq);
+}
+
+/**
+ * bfq_bic_lookup - search into @ioc a bic associated to @bfqd.
+ * @bfqd: the lookup key.
+ * @ioc: the io_context of the process doing I/O.
+ * @q: the request queue.
+ */
+static struct bfq_io_cq *bfq_bic_lookup(struct bfq_data *bfqd,
+					struct io_context *ioc,
+					struct request_queue *q)
+{
+	if (ioc) {
+		struct bfq_io_cq *icq;
+
+		spin_lock_irq(q->queue_lock);
+		icq = icq_to_bic(ioc_lookup_icq(ioc, q));
+		spin_unlock_irq(q->queue_lock);
+
+		return icq;
+	}
+
+	return NULL;
+}
+
 #include "bfq-sched.c"
 #include "bfq-cgroup.c"
 
@@ -1480,13 +1512,14 @@ static void bfq_add_request(struct request *rq)
 }
 
 static struct request *bfq_find_rq_fmerge(struct bfq_data *bfqd,
-					  struct bio *bio)
+					  struct bio *bio,
+					  struct request_queue *q)
 {
 	struct task_struct *tsk = current;
 	struct bfq_io_cq *bic;
 	struct bfq_queue *bfqq;
 
-	bic = bfq_bic_lookup(bfqd, tsk->io_context);
+	bic = bfq_bic_lookup(bfqd, tsk->io_context, q);
 	if (!bic)
 		return NULL;
 
-- 
2.10.0
