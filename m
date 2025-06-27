Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D642EBBA8
	for <linux-block@vger.kernel.org>; Fri, 27 Jun 2025 17:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751046973; cv=none; b=PZGiapA5IdxWfA8ZnGq+IuXATrNWX8DM7C9gUmqAmA12VZTLR94jXAZ5dCjG1vS0Ay4sRIIF2FWLJoWBKDDY/L5Kgyj0Okdguv1qkdJeT9hJBeeFGWrLXNQc2SHIVQEDYOU4ZHQYbAS/qSrDp6f5LPe3HcYRFYyRa+rcUHjqI+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751046973; c=relaxed/simple;
	bh=/vsbIHvwm33Z3Qoi72f8D/lW5btqtOa+Y+I5uVbDYcg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SM0XCeMQuLUT43kRQDUJLHxwYSUg7Somob1cfnMX/njZMH6JlMpwN9fpR6eH3VAoLu1yrVEDNpQ3mNKOBLWhYTCSO9bWORMIcV97X1ZFu0Tu0A8SVOCZfO4oiSqWtK6QPVkWMbycdjHd5bb/9myGZ7G92RwsM7J8dH98U1Zod4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=oO9IKm5N; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oO9IKm5N"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55RBGoTB015880;
	Fri, 27 Jun 2025 17:56:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=NfxS59GTd8zocK6+3
	kQ2yCpMobRX7JEP5m4IuBcxr2s=; b=oO9IKm5NZ7xusEgB0haFH80gG76HGwz6x
	gksqrToLlNa/LPoHbMwwOLPJxX3/cstXJYVZSjyXOFnc6I8CKfO/p/b3QpiXP25d
	xppfiPL22F2RNHrl0tJbR4p0T2wQqdZLie0JcIttX6FGf0l4E4QoOATnI9hMXkxI
	lvnC3iaBrVo4XFDN79HDnO+RRRAYPdxh4WOU291SI3JKHrjqi4+NHUvjWdcwhBFI
	PIESYaE6Hpfd/GIVTWrChtgjtkiTt4V7OtMMprBfFVhbepkndJIGUtsauU+SaCF6
	AR0xxBhZiitHZmuWFqp799s1v/kXeEhWZk9IH/t5/Tfy5UW8O43sw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dm8jy3y8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Jun 2025 17:56:03 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55RHNp0G002471;
	Fri, 27 Jun 2025 17:56:01 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47e8jmn7dy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Jun 2025 17:56:01 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55RHtxva53477684
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Jun 2025 17:56:00 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C564720043;
	Fri, 27 Jun 2025 17:55:59 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 621A720040;
	Fri, 27 Jun 2025 17:55:56 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.61.18.63])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 27 Jun 2025 17:55:55 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-block@vger.kernel.org
Cc: hch@lst.de, ming.lei@redhat.com, axboe@kernel.dk, sth@linux.ibm.com,
        gjoyce@ibm.com
Subject: [PATCHv5 2/3] block: fix lockdep warning caused by lock dependency in elv_iosched_store
Date: Fri, 27 Jun 2025 23:25:20 +0530
Message-ID: <20250627175544.1063910-3-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250627175544.1063910-1-nilay@linux.ibm.com>
References: <20250627175544.1063910-1-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI3MDE0NCBTYWx0ZWRfXxh1AtYQ4ZfhR 3lDfMVCSKMF221+onWimsfDS3Lcc4vcgVyHrXO0KMjPjtSu8+vW7iULy2hCHygAyl6RjbS3jyYg v/7pwb+vHSS2lrwnHXW/Ae2bLKXz7fSXyH4d38bJKPblrbgwaf1YV6FIAXmiLAQTU1PrFn+eiRb
 SsE/Q0GSakn7W6PhamW/kg098fae0DuhO0MyFBRNzQCzt8JL+aYc71L7dQMXZh4c/osqO0FqHgJ 8JyKy3XkQK9pmrwZGCHT2HaRQAvD4pa7N6zf7OPnUwAEoFu4Ep/ILBcC8bN31HoCP92QCUpc8mY 4Tgcl1I5SwGCyoeNns13aeRunbyrzC8oKg+Eu5rnlDbuMT6bhfrnfdPxDtx2dNFqlQ59l2txV4F
 KbgTVXYYSSpUkOfgb+HN5bMe7qP+QNPSqYTX8SepXLGfHFodzumHnQ14NU7wr/sajMRzQvuU
X-Proofpoint-GUID: _6gDCLTWcEg3GYD3Hc_FU4HkrnCjn6ql
X-Proofpoint-ORIG-GUID: _6gDCLTWcEg3GYD3Hc_FU4HkrnCjn6ql
X-Authority-Analysis: v=2.4 cv=combk04i c=1 sm=1 tr=0 ts=685edb33 cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=K7DvTsf3hfHH9eChsmYA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-27_05,2025-06-26_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 spamscore=0 adultscore=0 mlxlogscore=999 clxscore=1015
 impostorscore=0 suspectscore=0 mlxscore=0 phishscore=0 lowpriorityscore=0
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506270144

Recent lockdep reports [1] have revealed a potential deadlock caused by a
lock dependency between the percpu allocator lock and the elevator lock.
This issue can be avoided by ensuring that the allocation and release of
scheduler tags (sched_tags) are performed outside the elevator lock.
Furthermore, the queue does not need to be remain frozen during these
operations.

To address this, move all sched_tags allocations and deallocations outside
of both the ->elevator_lock and the ->freeze_lock. Since the lifetime of
the elevator queue and its associated sched_tags is closely tied, the
allocated sched_tags are now stored in the elevator queue structure. Then,
during the actual elevator switch (which runs under ->freeze_lock and
->elevator_lock), the pre-allocated sched_tags are assigned to the
appropriate q->hctx. Once the elevator switch is complete and the locks
are released, the old elevator queue and its associated sched_tags are
freed.

This commit specifically addresses the allocation/deallocation of sched_
tags during elevator switching. Note that sched_tags may also be allocated
in other contexts, such as during nr_hw_queues updates. Supporting that
use case will require batch allocation/deallocation, which will be handled
in a follow-up patch.

This restructuring ensures that sched_tags memory management occurs
entirely outside of the ->elevator_lock and ->freeze_lock context,
eliminating the lock dependency problem seen during scheduler updates.

[1] https://lore.kernel.org/all/0659ea8d-a463-47c8-9180-43c719e106eb@linux.ibm.com/

Reported-by: Stefan Haberland <sth@linux.ibm.com>
Closes: https://lore.kernel.org/all/0659ea8d-a463-47c8-9180-43c719e106eb@linux.ibm.com/
Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 block/blk-mq-sched.c | 154 +++++++++++++++++++++++--------------------
 block/blk-mq-sched.h |   8 ++-
 block/elevator.c     |  47 +++++++++++--
 block/elevator.h     |  14 +++-
 4 files changed, 143 insertions(+), 80 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 359e0704e09b..7bc15b4cff89 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -374,64 +374,17 @@ bool blk_mq_sched_try_insert_merge(struct request_queue *q, struct request *rq,
 }
 EXPORT_SYMBOL_GPL(blk_mq_sched_try_insert_merge);
 
-static int blk_mq_sched_alloc_map_and_rqs(struct request_queue *q,
-					  struct blk_mq_hw_ctx *hctx,
-					  unsigned int hctx_idx)
-{
-	if (blk_mq_is_shared_tags(q->tag_set->flags)) {
-		hctx->sched_tags = q->sched_shared_tags;
-		return 0;
-	}
-
-	hctx->sched_tags = blk_mq_alloc_map_and_rqs(q->tag_set, hctx_idx,
-						    q->nr_requests);
-
-	if (!hctx->sched_tags)
-		return -ENOMEM;
-	return 0;
-}
-
-static void blk_mq_exit_sched_shared_tags(struct request_queue *queue)
-{
-	blk_mq_free_rq_map(queue->sched_shared_tags);
-	queue->sched_shared_tags = NULL;
-}
-
 /* called in queue's release handler, tagset has gone away */
 static void blk_mq_sched_tags_teardown(struct request_queue *q, unsigned int flags)
 {
 	struct blk_mq_hw_ctx *hctx;
 	unsigned long i;
 
-	queue_for_each_hw_ctx(q, hctx, i) {
-		if (hctx->sched_tags) {
-			if (!blk_mq_is_shared_tags(flags))
-				blk_mq_free_rq_map(hctx->sched_tags);
-			hctx->sched_tags = NULL;
-		}
-	}
+	queue_for_each_hw_ctx(q, hctx, i)
+		hctx->sched_tags = NULL;
 
 	if (blk_mq_is_shared_tags(flags))
-		blk_mq_exit_sched_shared_tags(q);
-}
-
-static int blk_mq_init_sched_shared_tags(struct request_queue *queue)
-{
-	struct blk_mq_tag_set *set = queue->tag_set;
-
-	/*
-	 * Set initial depth at max so that we don't need to reallocate for
-	 * updating nr_requests.
-	 */
-	queue->sched_shared_tags = blk_mq_alloc_map_and_rqs(set,
-						BLK_MQ_NO_HCTX_IDX,
-						MAX_SCHED_RQ);
-	if (!queue->sched_shared_tags)
-		return -ENOMEM;
-
-	blk_mq_tag_update_sched_shared_tags(queue);
-
-	return 0;
+		q->sched_shared_tags = NULL;
 }
 
 void blk_mq_sched_reg_debugfs(struct request_queue *q)
@@ -458,8 +411,74 @@ void blk_mq_sched_unreg_debugfs(struct request_queue *q)
 	mutex_unlock(&q->debugfs_mutex);
 }
 
+void blk_mq_free_sched_tags(struct elevator_tags *et,
+		struct blk_mq_tag_set *set)
+{
+	unsigned long i;
+
+	/* Shared tags are stored at index 0 in @tags. */
+	if (blk_mq_is_shared_tags(set->flags))
+		blk_mq_free_map_and_rqs(set, et->tags[0], BLK_MQ_NO_HCTX_IDX);
+	else {
+		for (i = 0; i < et->nr_hw_queues; i++)
+			blk_mq_free_map_and_rqs(set, et->tags[i], i);
+	}
+
+	kfree(et);
+}
+
+struct elevator_tags *blk_mq_alloc_sched_tags(struct blk_mq_tag_set *set,
+		unsigned int nr_hw_queues)
+{
+	unsigned int nr_tags, i;
+	struct elevator_tags *et;
+	gfp_t gfp = GFP_NOIO | __GFP_ZERO | __GFP_NOWARN | __GFP_NORETRY;
+
+	if (blk_mq_is_shared_tags(set->flags))
+		nr_tags = 1;
+	else
+		nr_tags = nr_hw_queues;
+
+	et = kmalloc(sizeof(struct elevator_tags) +
+			nr_tags * sizeof(struct blk_mq_tags *), gfp);
+	if (!et)
+		return NULL;
+	/*
+	 * Default to double of smaller one between hw queue_depth and
+	 * 128, since we don't split into sync/async like the old code
+	 * did. Additionally, this is a per-hw queue depth.
+	 */
+	et->nr_requests = 2 * min_t(unsigned int, set->queue_depth,
+			BLKDEV_DEFAULT_RQ);
+	et->nr_hw_queues = nr_hw_queues;
+
+	if (blk_mq_is_shared_tags(set->flags)) {
+		/* Shared tags are stored at index 0 in @tags. */
+		et->tags[0] = blk_mq_alloc_map_and_rqs(set, BLK_MQ_NO_HCTX_IDX,
+					MAX_SCHED_RQ);
+		if (!et->tags[0])
+			goto out;
+	} else {
+		for (i = 0; i < et->nr_hw_queues; i++) {
+			et->tags[i] = blk_mq_alloc_map_and_rqs(set, i,
+					et->nr_requests);
+			if (!et->tags[i])
+				goto out_unwind;
+		}
+	}
+
+	return et;
+out_unwind:
+	while (--i >= 0)
+		blk_mq_free_map_and_rqs(set, et->tags[i], i);
+out:
+	kfree(et);
+	return NULL;
+}
+
 /* caller must have a reference to @e, will grab another one if successful */
-int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e)
+int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e,
+		struct elevator_tags *et)
 {
 	unsigned int flags = q->tag_set->flags;
 	struct blk_mq_hw_ctx *hctx;
@@ -467,40 +486,33 @@ int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e)
 	unsigned long i;
 	int ret;
 
-	/*
-	 * Default to double of smaller one between hw queue_depth and 128,
-	 * since we don't split into sync/async like the old code did.
-	 * Additionally, this is a per-hw queue depth.
-	 */
-	q->nr_requests = 2 * min_t(unsigned int, q->tag_set->queue_depth,
-				   BLKDEV_DEFAULT_RQ);
-
-	eq = elevator_alloc(q, e);
+	eq = elevator_alloc(q, e, et);
 	if (!eq)
 		return -ENOMEM;
 
+	q->nr_requests = et->nr_requests;
+
 	if (blk_mq_is_shared_tags(flags)) {
-		ret = blk_mq_init_sched_shared_tags(q);
-		if (ret)
-			goto err_put_elevator;
+		/* Shared tags are stored at index 0 in @et->tags. */
+		q->sched_shared_tags = et->tags[0];
+		blk_mq_tag_update_sched_shared_tags(q);
 	}
 
 	queue_for_each_hw_ctx(q, hctx, i) {
-		ret = blk_mq_sched_alloc_map_and_rqs(q, hctx, i);
-		if (ret)
-			goto err_free_map_and_rqs;
+		if (blk_mq_is_shared_tags(flags))
+			hctx->sched_tags = q->sched_shared_tags;
+		else
+			hctx->sched_tags = et->tags[i];
 	}
 
 	ret = e->ops.init_sched(q, eq);
 	if (ret)
-		goto err_free_map_and_rqs;
+		goto out;
 
 	queue_for_each_hw_ctx(q, hctx, i) {
 		if (e->ops.init_hctx) {
 			ret = e->ops.init_hctx(hctx, i);
 			if (ret) {
-				eq = q->elevator;
-				blk_mq_sched_free_rqs(q);
 				blk_mq_exit_sched(q, eq);
 				kobject_put(&eq->kobj);
 				return ret;
@@ -509,10 +521,8 @@ int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e)
 	}
 	return 0;
 
-err_free_map_and_rqs:
-	blk_mq_sched_free_rqs(q);
+out:
 	blk_mq_sched_tags_teardown(q, flags);
-err_put_elevator:
 	kobject_put(&eq->kobj);
 	q->elevator = NULL;
 	return ret;
diff --git a/block/blk-mq-sched.h b/block/blk-mq-sched.h
index 1326526bb733..0cde00cd1c47 100644
--- a/block/blk-mq-sched.h
+++ b/block/blk-mq-sched.h
@@ -18,10 +18,16 @@ void __blk_mq_sched_restart(struct blk_mq_hw_ctx *hctx);
 
 void blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx);
 
-int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e);
+int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e,
+		struct elevator_tags *et);
 void blk_mq_exit_sched(struct request_queue *q, struct elevator_queue *e);
 void blk_mq_sched_free_rqs(struct request_queue *q);
 
+struct elevator_tags *blk_mq_alloc_sched_tags(struct blk_mq_tag_set *set,
+		unsigned int nr_hw_queues);
+void blk_mq_free_sched_tags(struct elevator_tags *et,
+		struct blk_mq_tag_set *set);
+
 static inline void blk_mq_sched_restart(struct blk_mq_hw_ctx *hctx)
 {
 	if (test_bit(BLK_MQ_S_SCHED_RESTART, &hctx->state))
diff --git a/block/elevator.c b/block/elevator.c
index 770874040f79..50f4b78efe66 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -54,6 +54,8 @@ struct elv_change_ctx {
 	struct elevator_queue *old;
 	/* for registering new elevator */
 	struct elevator_queue *new;
+	/* holds sched tags data */
+	struct elevator_tags *et;
 };
 
 static DEFINE_SPINLOCK(elv_list_lock);
@@ -132,7 +134,7 @@ static struct elevator_type *elevator_find_get(const char *name)
 static const struct kobj_type elv_ktype;
 
 struct elevator_queue *elevator_alloc(struct request_queue *q,
-				  struct elevator_type *e)
+		struct elevator_type *e, struct elevator_tags *et)
 {
 	struct elevator_queue *eq;
 
@@ -145,6 +147,7 @@ struct elevator_queue *elevator_alloc(struct request_queue *q,
 	kobject_init(&eq->kobj, &elv_ktype);
 	mutex_init(&eq->sysfs_lock);
 	hash_init(eq->hash);
+	eq->et = et;
 
 	return eq;
 }
@@ -165,7 +168,6 @@ static void elevator_exit(struct request_queue *q)
 	lockdep_assert_held(&q->elevator_lock);
 
 	ioc_clear_queue(q);
-	blk_mq_sched_free_rqs(q);
 
 	mutex_lock(&e->sysfs_lock);
 	blk_mq_exit_sched(q, e);
@@ -591,7 +593,7 @@ static int elevator_switch(struct request_queue *q, struct elv_change_ctx *ctx)
 	}
 
 	if (new_e) {
-		ret = blk_mq_init_sched(q, new_e);
+		ret = blk_mq_init_sched(q, new_e, ctx->et);
 		if (ret)
 			goto out_unfreeze;
 		ctx->new = q->elevator;
@@ -626,8 +628,10 @@ static void elv_exit_and_release(struct request_queue *q)
 	elevator_exit(q);
 	mutex_unlock(&q->elevator_lock);
 	blk_mq_unfreeze_queue(q, memflags);
-	if (e)
+	if (e) {
+		blk_mq_free_sched_tags(e->et, q->tag_set);
 		kobject_put(&e->kobj);
+	}
 }
 
 static int elevator_change_done(struct request_queue *q,
@@ -640,6 +644,7 @@ static int elevator_change_done(struct request_queue *q,
 				&ctx->old->flags);
 
 		elv_unregister_queue(q, ctx->old);
+		blk_mq_free_sched_tags(ctx->old->et, q->tag_set);
 		kobject_put(&ctx->old->kobj);
 		if (enable_wbt)
 			wbt_enable_default(q->disk);
@@ -658,9 +663,16 @@ static int elevator_change_done(struct request_queue *q,
 static int elevator_change(struct request_queue *q, struct elv_change_ctx *ctx)
 {
 	unsigned int memflags;
+	struct blk_mq_tag_set *set = q->tag_set;
 	int ret = 0;
 
-	lockdep_assert_held(&q->tag_set->update_nr_hwq_lock);
+	lockdep_assert_held(&set->update_nr_hwq_lock);
+
+	if (strncmp(ctx->name, "none", 4)) {
+		ctx->et = blk_mq_alloc_sched_tags(set, set->nr_hw_queues);
+		if (!ctx->et)
+			return -ENOMEM;
+	}
 
 	memflags = blk_mq_freeze_queue(q);
 	/*
@@ -680,6 +692,11 @@ static int elevator_change(struct request_queue *q, struct elv_change_ctx *ctx)
 	blk_mq_unfreeze_queue(q, memflags);
 	if (!ret)
 		ret = elevator_change_done(q, ctx);
+	/*
+	 * Free sched tags if it's allocated but we couldn't switch elevator.
+	 */
+	if (ctx->et && !ctx->new)
+		blk_mq_free_sched_tags(ctx->et, set);
 
 	return ret;
 }
@@ -690,11 +707,26 @@ static int elevator_change(struct request_queue *q, struct elv_change_ctx *ctx)
  */
 void elv_update_nr_hw_queues(struct request_queue *q)
 {
+	struct blk_mq_tag_set *set = q->tag_set;
 	struct elv_change_ctx ctx = {};
 	int ret = -ENODEV;
 
 	WARN_ON_ONCE(q->mq_freeze_depth == 0);
 
+	/*
+	 * Accessing q->elevator without holding q->elevator_lock is safe here
+	 * because nr_hw_queue update is protected by set->update_nr_hwq_lock
+	 * in the writer context. So, scheduler update/switch code (which
+	 * acquires same lock in the reader context) can't run concurrently.
+	 */
+	if (q->elevator) {
+		ctx.et = blk_mq_alloc_sched_tags(set, set->nr_hw_queues);
+		if (!ctx.et) {
+			WARN_ON_ONCE(1);
+			return;
+		}
+	}
+
 	mutex_lock(&q->elevator_lock);
 	if (q->elevator && !blk_queue_dying(q) && blk_queue_registered(q)) {
 		ctx.name = q->elevator->type->elevator_name;
@@ -706,6 +738,11 @@ void elv_update_nr_hw_queues(struct request_queue *q)
 	blk_mq_unfreeze_queue_nomemrestore(q);
 	if (!ret)
 		WARN_ON_ONCE(elevator_change_done(q, &ctx));
+	/*
+	 * Free sched tags if it's allocated but we couldn't switch elevator.
+	 */
+	if (ctx.et && !ctx.new)
+		blk_mq_free_sched_tags(ctx.et, set);
 }
 
 /*
diff --git a/block/elevator.h b/block/elevator.h
index a4de5f9ad790..adc5c157e17e 100644
--- a/block/elevator.h
+++ b/block/elevator.h
@@ -23,6 +23,15 @@ enum elv_merge {
 struct blk_mq_alloc_data;
 struct blk_mq_hw_ctx;
 
+struct elevator_tags {
+	/* num. of hardware queues for which tags are allocated */
+	unsigned int nr_hw_queues;
+	/* depth used while allocating tags */
+	unsigned int nr_requests;
+	/* shared tag is stored at index 0 */
+	struct blk_mq_tags *tags[];
+};
+
 struct elevator_mq_ops {
 	int (*init_sched)(struct request_queue *, struct elevator_queue *);
 	void (*exit_sched)(struct elevator_queue *);
@@ -113,6 +122,7 @@ struct request *elv_rqhash_find(struct request_queue *q, sector_t offset);
 struct elevator_queue
 {
 	struct elevator_type *type;
+	struct elevator_tags *et;
 	void *elevator_data;
 	struct kobject kobj;
 	struct mutex sysfs_lock;
@@ -152,8 +162,8 @@ ssize_t elv_iosched_show(struct gendisk *disk, char *page);
 ssize_t elv_iosched_store(struct gendisk *disk, const char *page, size_t count);
 
 extern bool elv_bio_merge_ok(struct request *, struct bio *);
-extern struct elevator_queue *elevator_alloc(struct request_queue *,
-					struct elevator_type *);
+struct elevator_queue *elevator_alloc(struct request_queue *,
+		struct elevator_type *, struct elevator_tags *);
 
 /*
  * Helper functions.
-- 
2.49.0

