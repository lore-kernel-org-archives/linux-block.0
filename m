Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA80E18C011
	for <linux-block@vger.kernel.org>; Mon, 30 Jun 2025 05:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751262513; cv=none; b=P5K2iSWi6JSHT/XrhfGSk7eZHp/U4YqIKfJUD45hWghY7Z+hLgJzfb/lJcoyaDZ88UZCNrdtnzlKVwiARuSoPBlX71xqIpZCY6ReHHkW9muVLjso+H9oDtZIR/LGJU3Yc9qJKIR5GzSq9G/tYUaMuByP+Apj5rBrki7yM6oS8wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751262513; c=relaxed/simple;
	bh=1nrUTMxhnNJcskDVbVwBI76C3AI72+8Wmfi+3EZQsLY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tI6jtiuJQ6UaS0xvPZ8XGkTr1UgTg/dJExg5OM88Mts1Wm8O/aUOSijYhogqaufg9Td7JvZB2ReLSYwMF/0wLCSO94BTU3eCV84rf2azuK8fikhKnmh1DcWa3WxJxD+9OlfocbB6su3/eUvJcqEtciXmv7gI+ZOtRBxJ0PpczH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EmoXzUna; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EmoXzUna"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55TKS4VA015498;
	Mon, 30 Jun 2025 05:48:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=C8bOLOIK6AY034YdH
	kqw7MnCkStPxRkL2qzisJ1bJkU=; b=EmoXzUnae7Z2TaXaFPjLzl6061dY+B0sX
	goKyd2UzfCoWq2dUxz0GQLURSJeBaReTp66npNkj3Hip8OnT4JY+KDL7rR6i34LN
	XFnpOl3YnmI8qknwF34/SXLgCFOa8gT+z7oBLs7sajn6KOWzLykACkvd3DN7FrX8
	LQKf7XSr/qvTHaT/aJ3/3CZo6nXt+tuk1M0tnyU+9qLNUNUGofTi7iD2Oo/h1cz6
	wLN8xH5DauRpwzXEflnY9Wvm6KZA83US2q+PM7WSIE/1ccB5+I+M+boJu2ZGW3e5
	aPi24ci/JoX0pO4CSok7gBFDtq254vHgFg+Vo8M+UYljsq/A1F3IA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47j7wr7des-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Jun 2025 05:48:21 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55U5C8XV021934;
	Mon, 30 Jun 2025 05:48:20 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47juqpcfnx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Jun 2025 05:48:20 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55U5mIWX32768356
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Jun 2025 05:48:18 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3736E2004B;
	Mon, 30 Jun 2025 05:48:18 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3696D20040;
	Mon, 30 Jun 2025 05:48:09 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.61.92.250])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 30 Jun 2025 05:48:08 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-block@vger.kernel.org
Cc: hch@lst.de, ming.lei@redhat.com, axboe@kernel.dk, sth@linux.ibm.com,
        lkp@intel.com, gjoyce@ibm.com
Subject: [PATCHv6 2/3] block: fix lockdep warning caused by lock dependency in elv_iosched_store
Date: Mon, 30 Jun 2025 10:51:55 +0530
Message-ID: <20250630054756.54532-3-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250630054756.54532-1-nilay@linux.ibm.com>
References: <20250630054756.54532-1-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=E/PNpbdl c=1 sm=1 tr=0 ts=68622525 cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=K7DvTsf3hfHH9eChsmYA:9
X-Proofpoint-GUID: RQ7utsDc7EGaHUkW2LRrrB5XgZqikF5a
X-Proofpoint-ORIG-GUID: RQ7utsDc7EGaHUkW2LRrrB5XgZqikF5a
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjMwMDA0NiBTYWx0ZWRfX0OKuK5aX1JLr QPYSh7jL+taCpb3Jx9Z2q7T96HMJ4mYd2sWR6o3LyVX/xFyJJlYIzlPq4ajKo062LIbfi5G23UM 1upgEc/0YgXFSsKuwa3kVBlRMHZPIJ5KY4mlJnKoV8gK0dQUDjVhBFkMDZRT20L9iP1pcN5aeIh
 W/TIESkA9jUab+yKuCKKActJLGHIIweLoeiurQZNv0sBokTSrzUuLMleqjz7DTLSQ/1z82niDBG rhWQtk18HW1S4LhnGSwOE9cXsuaMC/sHyItvXSY96PDwLLAxfPyMKFw2RJ4UZy3vT6FhmcObx3V nBQQ4MxAHoDSB0bow/vLfZrhlIBTyxyenHTtSldvotfJf2pAQej1aUbstb53WXwyz1zE6SCsVRZ
 yrLuUOu9GavdKFviuGQ/qKiKoEPOrLUIJj//kUjAQQ1obUc4FB+iCXjRsNUY1bdPcC9yS8FF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-27_05,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 bulkscore=0 priorityscore=1501 phishscore=0 suspectscore=0 mlxlogscore=999
 lowpriorityscore=0 mlxscore=0 clxscore=1015 adultscore=0 impostorscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506300046

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
 block/blk-mq-sched.c | 155 +++++++++++++++++++++++--------------------
 block/blk-mq-sched.h |   8 ++-
 block/elevator.c     |  47 +++++++++++--
 block/elevator.h     |  14 +++-
 4 files changed, 144 insertions(+), 80 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 359e0704e09b..2d6d1ebdd8fb 100644
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
@@ -458,8 +411,75 @@ void blk_mq_sched_unreg_debugfs(struct request_queue *q)
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
+	unsigned int nr_tags;
+	int i;
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
@@ -467,40 +487,33 @@ int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e)
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
@@ -509,10 +522,8 @@ int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e)
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
2.50.0

