Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:52608 "EHLO
	mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757323AbcFHUnv (ORCPT
	<rfc822;linux-block@vger.kernel.org>);
	Wed, 8 Jun 2016 16:43:51 -0400
Received: from pps.filterd (m0044008.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id u58KeYCa011487
	for <linux-block@vger.kernel.org>; Wed, 8 Jun 2016 13:43:50 -0700
Received: from mail.thefacebook.com ([199.201.64.23])
	by mx0a-00082601.pphosted.com with ESMTP id 23es8n8jv3-3
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Wed, 08 Jun 2016 13:43:50 -0700
Date: Wed, 8 Jun 2016 14:43:47 -0600
From: Jens Axboe <axboe@fb.com>
To: <linux-block@vger.kernel.org>
Subject: [PATCH] cfq: priority boost on meta/prio marked IO
Message-ID: <20160608204347.GA30146@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

At Facebook, we have a number of cases where people use ionice to set a
lower priority, then end up having tasks stuck for a long time because
eg meta data updates from an idle priority tasks is blocking out higher
priority processes. It's bad enough that it will trigger the softlockup
warning.

This patch adds code to CFQ that bumps the priority class and data for
an idle task, if is doing IO marked as PRIO or META. With this, we no
longer see the softlockups.

Signed-off-by: Jens Axboe <axboe@fb.com>

diff --git a/block/blk-core.c b/block/blk-core.c
index 32a283eb7274..3cfd67d006fb 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1781,6 +1781,11 @@ get_rq:
 		rw_flags |= REQ_SYNC;
 
 	/*
+	 * Add in META/PRIO flags, if set, before we get to the IO scheduler
+	 */
+	rw_flags |= (bio->bi_rw & (REQ_META | REQ_PRIO));
+
+	/*
 	 * Grab a free request. This is might sleep but can not fail.
 	 * Returns with the queue unlocked.
 	 */
diff --git a/block/cfq-iosched.c b/block/cfq-iosched.c
index 4e5978426ee7..7969882e0a2a 100644
--- a/block/cfq-iosched.c
+++ b/block/cfq-iosched.c
@@ -72,6 +72,8 @@ static struct kmem_cache *cfq_pool;
 #define CFQ_WEIGHT_LEGACY_DFL	500
 #define CFQ_WEIGHT_LEGACY_MAX	1000
 
+#define RQ_PRIO_MASK		(REQ_META | REQ_PRIO)
+
 struct cfq_ttime {
 	u64 last_end_request;
 
@@ -141,7 +143,7 @@ struct cfq_queue {
 
 	/* io prio of this group */
 	unsigned short ioprio, org_ioprio;
-	unsigned short ioprio_class;
+	unsigned short ioprio_class, org_ioprio_class;
 
 	pid_t pid;
 
@@ -1114,8 +1116,8 @@ cfq_choose_req(struct cfq_data *cfqd, struct request *rq1, struct request *rq2,
 	if (rq_is_sync(rq1) != rq_is_sync(rq2))
 		return rq_is_sync(rq1) ? rq1 : rq2;
 
-	if ((rq1->cmd_flags ^ rq2->cmd_flags) & REQ_PRIO)
-		return rq1->cmd_flags & REQ_PRIO ? rq1 : rq2;
+	if ((rq1->cmd_flags ^ rq2->cmd_flags) & RQ_PRIO_MASK)
+		return rq1->cmd_flags & RQ_PRIO_MASK ? rq1 : rq2;
 
 	s1 = blk_rq_pos(rq1);
 	s2 = blk_rq_pos(rq2);
@@ -2530,7 +2532,7 @@ static void cfq_remove_request(struct request *rq)
 
 	cfqq->cfqd->rq_queued--;
 	cfqg_stats_update_io_remove(RQ_CFQG(rq), req_op(rq), rq->cmd_flags);
-	if (rq->cmd_flags & REQ_PRIO) {
+	if (rq->cmd_flags & RQ_PRIO_MASK) {
 		WARN_ON(!cfqq->prio_pending);
 		cfqq->prio_pending--;
 	}
@@ -3700,6 +3702,7 @@ static void cfq_init_prio_data(struct cfq_queue *cfqq, struct cfq_io_cq *cic)
 	 * elevate the priority of this queue
 	 */
 	cfqq->org_ioprio = cfqq->ioprio;
+	cfqq->org_ioprio_class = cfqq->ioprio_class;
 	cfq_clear_cfqq_prio_changed(cfqq);
 }
 
@@ -4012,7 +4015,7 @@ cfq_should_preempt(struct cfq_data *cfqd, struct cfq_queue *new_cfqq,
 	 * So both queues are sync. Let the new request get disk time if
 	 * it's a metadata request and the current queue is doing regular IO.
 	 */
-	if ((rq->cmd_flags & REQ_PRIO) && !cfqq->prio_pending)
+	if ((rq->cmd_flags & RQ_PRIO_MASK) && !cfqq->prio_pending)
 		return true;
 
 	/* An idle queue should not be idle now for some reason */
@@ -4073,7 +4076,7 @@ cfq_rq_enqueued(struct cfq_data *cfqd, struct cfq_queue *cfqq,
 	struct cfq_io_cq *cic = RQ_CIC(rq);
 
 	cfqd->rq_queued++;
-	if (rq->cmd_flags & REQ_PRIO)
+	if (rq->cmd_flags & RQ_PRIO_MASK)
 		cfqq->prio_pending++;
 
 	cfq_update_io_thinktime(cfqd, cfqq, cic);
@@ -4295,6 +4298,20 @@ static void cfq_completed_request(struct request_queue *q, struct request *rq)
 		cfq_schedule_dispatch(cfqd);
 }
 
+static void cfqq_boost_on_meta(struct cfq_queue *cfqq, int op_flags)
+{
+	if (!(op_flags & RQ_PRIO_MASK)) {
+		cfqq->ioprio_class = cfqq->org_ioprio_class;
+		cfqq->ioprio = cfqq->org_ioprio;
+		return;
+	}
+
+	if (cfq_class_idle(cfqq))
+		cfqq->ioprio_class = IOPRIO_CLASS_BE;
+	if (cfqq->ioprio > IOPRIO_NORM)
+		cfqq->ioprio = IOPRIO_NORM;
+}
+
 static inline int __cfq_may_queue(struct cfq_queue *cfqq)
 {
 	if (cfq_cfqq_wait_request(cfqq) && !cfq_cfqq_must_alloc_slice(cfqq)) {
@@ -4325,6 +4342,7 @@ static int cfq_may_queue(struct request_queue *q, int op, int op_flags)
 	cfqq = cic_to_cfqq(cic, rw_is_sync(op, op_flags));
 	if (cfqq) {
 		cfq_init_prio_data(cfqq, cic);
+		cfqq_boost_on_meta(cfqq, op_flags);
 
 		return __cfq_may_queue(cfqq);
 	}

-- 
Jens Axboe

