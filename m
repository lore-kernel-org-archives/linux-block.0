Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE8128643E
	for <linux-block@vger.kernel.org>; Wed, 28 May 2025 12:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748435818; cv=none; b=cnJWJP9A8dgxZsuj0joqBvfNZuJxiyAGfJSNtn85WHvBIczWWcxAkcQ4HXyeDMJS0ZgE8guorP7k5CPyeIb7awgUhldu/tMFETYx5Xx11YIujW/yOB46z6gMvcOIrZlZn4iWsuFgD9LlsgSaAR0Sr5qKvEyDYXcSK9i4xhPzQIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748435818; c=relaxed/simple;
	bh=Bk1W1xG292unfhYjGkYeMc/96jd046lHs2C3qHBrYDA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=juUwt7QFh7WZmxFoTdJKYIxWL3S/giRVhhFCcFASzRR0W6MdwoKu8hHRAlqjSrMRzJ9d888TGOejADnO+SQsfnHjcKUDSOubvhRDlTYQ71ZCbCZcF7p/K69sflWMLKnuUax67nJfKu3lKOM7P5avJn5ZIXuAzjY2uZBohHnRc2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gR+RcFdy; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gR+RcFdy"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54S5ZHjL007507;
	Wed, 28 May 2025 12:36:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=hEv/5rcDg6Mv9/NJEInT7OPO/kkq
	Z+bGulqC+949MD4=; b=gR+RcFdyAJj5susgnxIXg9YMG4k+DHRyOeFEMyxBYITh
	sHnobzwPMfsnLUkomHhccVkfP+/znmaeCZWSVxxgF3fE+uUcPZWU96gYaJzkPIOS
	hjHnqXJ2lgQBvIGIKfGq8Wj9lT5KQnr8Sbp7fF3+PZxpACUwZxu+1p2sLPJKWCfW
	wtvHQO4M6Q0N+I2q6MFnIXZt0kkKXfEEe8fFd3MJyMUUnX2JesyurrXV61rhB347
	CQlBCDNa/9HJ7wpRB6C9SK0pXJ7V0sf75RmnIlJU6nViJWtpGAxzjao311/skA+g
	79nDuESeVIc4cCSJIheMmG0BCZVzEKUke5zCWejDjw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46wvfb1ucn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 May 2025 12:36:48 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54SAQBdS016114;
	Wed, 28 May 2025 12:36:47 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 46ureufptf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 May 2025 12:36:46 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 54SCaj6A55247230
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 May 2025 12:36:45 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3CD0E20043;
	Wed, 28 May 2025 12:36:45 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D3E952004B;
	Wed, 28 May 2025 12:36:41 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.67.148.223])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 28 May 2025 12:36:41 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-block@vger.kernel.org
Cc: ming.lei@redhat.com, hch@lst.de, axboe@kernel.dk, sth@linux.ibm.com,
        gjoyce@ibm.com
Subject: [PATCHv2] block: fix lock dependency between percpu alloc lock and elevator lock
Date: Wed, 28 May 2025 18:03:58 +0530
Message-ID: <20250528123638.1029700-1-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI4MDEwOSBTYWx0ZWRfX5FNMhv3gEJNj RhsnLBYMcKnivvMT9AIlLD9o7LN+ktWdLJF+e19OxuH6E4uQ+98X7wwCZk6toXEUEjgjlIEqexW 7wJedaN9iHs24zYHN3hoKP4Vvhqj2d7+WGbUrGdj8p4iVuPvf7cyo/cFX0BGFK0HI/xAzmdqEAU
 yKkTg5WubYxlX9mj0ovX87PkEnBM9PrfcZQGF8PudXad4/cS0vuaecsOTEj0it8YgMcfOBbqv7S GBzpwrmpgAL5ZTFtVfe632L7XuwA2X9fvzy6lMFMhQX7RVvtHmLfWHNW1WOrCiu2HQ+nRuFzOTy l/Ncbtw1Gx8mjJA1DpDmKb75YNGSeb5xUcv5OuiOLv4SpimViEGjrbwcqN6Zc97UX3g9IKd6Li3
 2mmoddL/07i0NBYKC3Yer+8ytJTQcR9ojEWGcRyPGvh7kGN+hJS2pIcQhfx7+RBoIMMvFb6a
X-Proofpoint-ORIG-GUID: USzqe7J39HbwRcQAvtKtG7Ms14Kl2nTa
X-Authority-Analysis: v=2.4 cv=bt5MBFai c=1 sm=1 tr=0 ts=68370360 cx=c_pps a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=zRgNgO36K0PcdPFg0qgA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: USzqe7J39HbwRcQAvtKtG7Ms14Kl2nTa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-28_06,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 impostorscore=0 malwarescore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 suspectscore=0 adultscore=0 priorityscore=1501 phishscore=0 mlxscore=0
 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505280109

Recent lockdep reports [1] have revealed a potential deadlock caused
by a lock dependency between the percpu allocator lock and the elevator
lock. This issue can be avoided by ensuring that the allocation and
release of scheduler tags (sched_tags) are performed outside the
elevator lock. Furthermore, the queue does not need to remain frozen
during these operations.

Since the lifetime of the elevator queue and its associated sched_tags
is closely tied, we now pre-allocate both elevator queue and sched_tags
before initiating the elevator switch—outside the protection of ->freeze_
lock and ->elevator_lock. The newly allocated sched_tags are stored in
the elevator queue structure.

Then, during the actual elevator switch (which runs under ->freeze_lock
and ->elevator_lock), the pre-allocated sched_tags are assigned to the
appropriate q->hctx. Once the switch is complete and the locks are
released, the old elevator queue and its associated sched_tags are
freed. This change also requires updating the ->init_sched elevator ops
API as now elevator queue allocation happens very early before we
actually start switching the elevator. So, accordingly, this patch also
updates the ->init_sched implementation for each supported elevator.

With this change, all sched_tags allocations and deallocations occur
outside of both ->freeze_lock and ->elevator_lock, and that helps
prevent the lock ordering issue observed when elv_iosched_store() is
triggered via sysfs.

[1] https://lore.kernel.org/all/0659ea8d-a463-47c8-9180-43c719e106eb@linux.ibm.com/

Reported-by: Stefan Haberland <sth@linux.ibm.com>
Closes: https://lore.kernel.org/all/0659ea8d-a463-47c8-9180-43c719e106eb@linux.ibm.com/
Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
Changes from v1:
    - As the lifetime of elevator queue and sched tags are same, allocate 
      and move sched tags under struct elevator_queue (Ming Lei)
---
 block/bfq-iosched.c   |   7 +-
 block/blk-mq-sched.c  | 214 ++++++++++++++++++++++++++----------------
 block/blk-mq-sched.h  |  28 +++++-
 block/elevator.c      | 123 +++++++++++++-----------
 block/elevator.h      |   5 +-
 block/kyber-iosched.c |   7 +-
 block/mq-deadline.c   |   7 +-
 7 files changed, 233 insertions(+), 158 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 0cb1e9873aab..51d406da4abf 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -7232,17 +7232,12 @@ static void bfq_init_root_group(struct bfq_group *root_group,
 	root_group->sched_data.bfq_class_idle_last_service = jiffies;
 }
 
-static int bfq_init_queue(struct request_queue *q, struct elevator_type *e)
+static int bfq_init_queue(struct request_queue *q, struct elevator_queue *eq)
 {
 	struct bfq_data *bfqd;
-	struct elevator_queue *eq;
 	unsigned int i;
 	struct blk_independent_access_ranges *ia_ranges = q->disk->ia_ranges;
 
-	eq = elevator_alloc(q, e);
-	if (!eq)
-		return -ENOMEM;
-
 	bfqd = kzalloc_node(sizeof(*bfqd), GFP_KERNEL, q->node);
 	if (!bfqd) {
 		kobject_put(&eq->kobj);
diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 55a0fd105147..41bc864440eb 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -374,61 +374,51 @@ bool blk_mq_sched_try_insert_merge(struct request_queue *q, struct request *rq,
 }
 EXPORT_SYMBOL_GPL(blk_mq_sched_try_insert_merge);
 
-static int blk_mq_sched_alloc_map_and_rqs(struct request_queue *q,
-					  struct blk_mq_hw_ctx *hctx,
-					  unsigned int hctx_idx)
+static int blk_mq_init_sched_tags(struct request_queue *q,
+				  struct blk_mq_hw_ctx *hctx,
+				  unsigned int hctx_idx,
+				  struct elevator_queue *elevator)
 {
 	if (blk_mq_is_shared_tags(q->tag_set->flags)) {
 		hctx->sched_tags = q->sched_shared_tags;
 		return 0;
 	}
+	/*
+	 * We allocated the elevator queue and sched tags before initiating the
+	 * elevator switch, prior to acquiring ->elevator_lock. The sched tags
+	 * are stored under the elevator queue. So assign those pre-allocated
+	 * sched tags now.
+	 */
+	hctx->sched_tags = elevator->tags[hctx_idx];
 
-	hctx->sched_tags = blk_mq_alloc_map_and_rqs(q->tag_set, hctx_idx,
-						    q->nr_requests);
-
-	if (!hctx->sched_tags)
-		return -ENOMEM;
 	return 0;
 }
 
-static void blk_mq_exit_sched_shared_tags(struct request_queue *queue)
-{
-	blk_mq_free_rq_map(queue->sched_shared_tags);
-	queue->sched_shared_tags = NULL;
-}
-
-/* called in queue's release handler, tagset has gone away */
+/*
+ * Called while exiting elevator. Sched tags are freed later when we finish
+ * switching the elevator and releases the ->elevator_lock and ->frezze_lock.
+ */
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
+		q->sched_shared_tags = NULL;
 }
-
-static int blk_mq_init_sched_shared_tags(struct request_queue *queue)
+static int blk_mq_init_sched_shared_tags(struct request_queue *queue,
+		struct elevator_queue *elevator)
 {
-	struct blk_mq_tag_set *set = queue->tag_set;
-
 	/*
-	 * Set initial depth at max so that we don't need to reallocate for
-	 * updating nr_requests.
+	 * We allocated the elevator queue and sched tags before initiating the
+	 * elevator switch, prior to acquiring ->elevator_lock. The sched tags
+	 * are stored under the elevator queue. So assign the pre-allocated
+	 * sched tags now.
 	 */
-	queue->sched_shared_tags = blk_mq_alloc_map_and_rqs(set,
-						BLK_MQ_NO_HCTX_IDX,
-						MAX_SCHED_RQ);
-	if (!queue->sched_shared_tags)
-		return -ENOMEM;
-
+	queue->sched_shared_tags = elevator->shared_tags;
 	blk_mq_tag_update_sched_shared_tags(queue);
 
 	return 0;
@@ -458,8 +448,97 @@ void blk_mq_sched_unreg_debugfs(struct request_queue *q)
 	mutex_unlock(&q->debugfs_mutex);
 }
 
+int blk_mq_alloc_elevator_and_sched_tags(struct request_queue *q,
+		struct elv_change_ctx *ctx)
+{
+	unsigned long i;
+	struct elevator_queue *elevator;
+	struct elevator_type *e;
+	struct blk_mq_tag_set *set = q->tag_set;
+	gfp_t gfp = GFP_NOIO | __GFP_NOWARN | __GFP_NORETRY;
+
+	if (strncmp(ctx->new.name, "none", 4)) {
+
+		e = elevator_find_get(ctx->new.name);
+		if (!e)
+			return -EINVAL;
+
+		elevator = ctx->new.elevator = elevator_alloc(q, e);
+		if (!elevator) {
+			elevator_put(e);
+			return -ENOMEM;
+		}
+
+		/*
+		 * Default to double of smaller one between hw queue_depth and
+		 * 128, since we don't split into sync/async like the old code
+		 * did. Additionally, this is a per-hw queue depth.
+		 */
+		ctx->new.nr_requests = 2 * min_t(unsigned int,
+						set->queue_depth,
+						BLKDEV_DEFAULT_RQ);
+
+		if (blk_mq_is_shared_tags(set->flags)) {
+
+			elevator->shared_tags = blk_mq_alloc_map_and_rqs(set,
+							BLK_MQ_NO_HCTX_IDX,
+							MAX_SCHED_RQ);
+			if (!elevator->shared_tags)
+				goto out_elevator_release;
+
+			return 0;
+		}
+
+		elevator->tags = kcalloc(set->nr_hw_queues,
+					sizeof(struct blk_mq_tags *),
+					gfp);
+		if (!elevator->tags)
+			goto out_elevator_release;
+
+		for (i = 0; i < set->nr_hw_queues; i++) {
+			elevator->tags[i] = blk_mq_alloc_map_and_rqs(set, i,
+						ctx->new.nr_requests);
+			if (!elevator->tags[i])
+				goto out_free_tags;
+		}
+	}
+
+	return 0;
+
+out_free_tags:
+	blk_mq_free_sched_tags(q->tag_set, elevator);
+out_elevator_release:
+	kobject_put(&elevator->kobj);
+	return -ENOMEM;
+}
+
+void blk_mq_free_sched_tags(struct blk_mq_tag_set *set,
+		struct elevator_queue *elevator)
+{
+	unsigned long i;
+
+	if (elevator->shared_tags) {
+		blk_mq_free_rqs(set, elevator->shared_tags, BLK_MQ_NO_HCTX_IDX);
+		blk_mq_free_rq_map(elevator->shared_tags);
+		return;
+	}
+
+	if (!elevator->tags)
+		return;
+
+	for (i = 0; i < set->nr_hw_queues; i++) {
+		if (elevator->tags[i]) {
+			blk_mq_free_rqs(set, elevator->tags[i], i);
+			blk_mq_free_rq_map(elevator->tags[i]);
+		}
+	}
+
+	kfree(elevator->tags);
+}
+
 /* caller must have a reference to @e, will grab another one if successful */
-int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e)
+int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e,
+		struct elv_change_ctx *ctx)
 {
 	unsigned int flags = q->tag_set->flags;
 	struct blk_mq_hw_ctx *hctx;
@@ -467,73 +546,44 @@ int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e)
 	unsigned long i;
 	int ret;
 
-	/*
-	 * Default to double of smaller one between hw queue_depth and 128,
-	 * since we don't split into sync/async like the old code did.
-	 * Additionally, this is a per-hw queue depth.
-	 */
-	q->nr_requests = 2 * min_t(unsigned int, q->tag_set->queue_depth,
-				   BLKDEV_DEFAULT_RQ);
+	q->nr_requests = ctx->new.nr_requests;
 
-	if (blk_mq_is_shared_tags(flags)) {
-		ret = blk_mq_init_sched_shared_tags(q);
-		if (ret)
-			return ret;
-	}
+	if (blk_mq_is_shared_tags(flags))
+		blk_mq_init_sched_shared_tags(q, ctx->new.elevator);
 
-	queue_for_each_hw_ctx(q, hctx, i) {
-		ret = blk_mq_sched_alloc_map_and_rqs(q, hctx, i);
-		if (ret)
-			goto err_free_map_and_rqs;
-	}
+	queue_for_each_hw_ctx(q, hctx, i)
+		blk_mq_init_sched_tags(q, hctx, i, ctx->new.elevator);
 
-	ret = e->ops.init_sched(q, e);
+	ret = e->ops.init_sched(q, ctx->new.elevator);
 	if (ret)
-		goto err_free_map_and_rqs;
+		goto out;
 
 	queue_for_each_hw_ctx(q, hctx, i) {
 		if (e->ops.init_hctx) {
 			ret = e->ops.init_hctx(hctx, i);
 			if (ret) {
+				/*
+				 * For failed case, sched tags are released
+				 * later when we finish switching elevator and
+				 * release ->elevator_lock and ->freeze_lock.
+				 */
 				eq = q->elevator;
-				blk_mq_sched_free_rqs(q);
 				blk_mq_exit_sched(q, eq);
-				kobject_put(&eq->kobj);
 				return ret;
 			}
 		}
 	}
 	return 0;
 
-err_free_map_and_rqs:
-	blk_mq_sched_free_rqs(q);
-	blk_mq_sched_tags_teardown(q, flags);
-
+out:
+	/*
+	 * Sched tags are released later when we finish switching elevator
+	 * and release ->elevator_lock and ->freeze_lock.
+	 */
 	q->elevator = NULL;
 	return ret;
 }
 
-/*
- * called in either blk_queue_cleanup or elevator_switch, tagset
- * is required for freeing requests
- */
-void blk_mq_sched_free_rqs(struct request_queue *q)
-{
-	struct blk_mq_hw_ctx *hctx;
-	unsigned long i;
-
-	if (blk_mq_is_shared_tags(q->tag_set->flags)) {
-		blk_mq_free_rqs(q->tag_set, q->sched_shared_tags,
-				BLK_MQ_NO_HCTX_IDX);
-	} else {
-		queue_for_each_hw_ctx(q, hctx, i) {
-			if (hctx->sched_tags)
-				blk_mq_free_rqs(q->tag_set,
-						hctx->sched_tags, i);
-		}
-	}
-}
-
 void blk_mq_exit_sched(struct request_queue *q, struct elevator_queue *e)
 {
 	struct blk_mq_hw_ctx *hctx;
diff --git a/block/blk-mq-sched.h b/block/blk-mq-sched.h
index 1326526bb733..6c0f1936b81c 100644
--- a/block/blk-mq-sched.h
+++ b/block/blk-mq-sched.h
@@ -7,6 +7,26 @@
 
 #define MAX_SCHED_RQ (16 * BLKDEV_DEFAULT_RQ)
 
+/* Holding context data for changing elevator */
+struct elv_change_ctx {
+	/* for unregistering/freeing old elevator */
+	struct {
+		struct elevator_queue *elevator;
+	} old;
+
+	/* for registering/allocating new elevator */
+	struct {
+		const char *name;
+		bool no_uevent;
+		unsigned long nr_requests;
+		struct elevator_queue *elevator;
+		int inited;
+	} new;
+
+	/* elevator switch status */
+	int status;
+};
+
 bool blk_mq_sched_try_merge(struct request_queue *q, struct bio *bio,
 		unsigned int nr_segs, struct request **merged_request);
 bool blk_mq_sched_bio_merge(struct request_queue *q, struct bio *bio,
@@ -18,9 +38,13 @@ void __blk_mq_sched_restart(struct blk_mq_hw_ctx *hctx);
 
 void blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx);
 
-int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e);
+int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e,
+		struct elv_change_ctx *ctx);
+int blk_mq_alloc_elevator_and_sched_tags(struct request_queue *q,
+		struct elv_change_ctx *ctx);
+void blk_mq_free_sched_tags(struct blk_mq_tag_set *set,
+		struct elevator_queue *elevator);
 void blk_mq_exit_sched(struct request_queue *q, struct elevator_queue *e);
-void blk_mq_sched_free_rqs(struct request_queue *q);
 
 static inline void blk_mq_sched_restart(struct blk_mq_hw_ctx *hctx)
 {
diff --git a/block/elevator.c b/block/elevator.c
index ab22542e6cf0..da740cff8dbc 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -45,17 +45,6 @@
 #include "blk-wbt.h"
 #include "blk-cgroup.h"
 
-/* Holding context data for changing elevator */
-struct elv_change_ctx {
-	const char *name;
-	bool no_uevent;
-
-	/* for unregistering old elevator */
-	struct elevator_queue *old;
-	/* for registering new elevator */
-	struct elevator_queue *new;
-};
-
 static DEFINE_SPINLOCK(elv_list_lock);
 static LIST_HEAD(elv_list);
 
@@ -117,7 +106,7 @@ static struct elevator_type *__elevator_find(const char *name)
 	return NULL;
 }
 
-static struct elevator_type *elevator_find_get(const char *name)
+struct elevator_type *elevator_find_get(const char *name)
 {
 	struct elevator_type *e;
 
@@ -128,6 +117,7 @@ static struct elevator_type *elevator_find_get(const char *name)
 	spin_unlock(&elv_list_lock);
 	return e;
 }
+EXPORT_SYMBOL(elevator_find_get);
 
 static const struct kobj_type elv_ktype;
 
@@ -166,7 +156,6 @@ static void elevator_exit(struct request_queue *q)
 	lockdep_assert_held(&q->elevator_lock);
 
 	ioc_clear_queue(q);
-	blk_mq_sched_free_rqs(q);
 
 	mutex_lock(&e->sysfs_lock);
 	blk_mq_exit_sched(q, e);
@@ -570,38 +559,34 @@ EXPORT_SYMBOL_GPL(elv_unregister);
  * If switching fails, we are most likely running out of memory and not able
  * to restore the old io scheduler, so leaving the io scheduler being none.
  */
-static int elevator_switch(struct request_queue *q, struct elv_change_ctx *ctx)
+static void elevator_switch(struct request_queue *q, struct elv_change_ctx *ctx)
 {
-	struct elevator_type *new_e = NULL;
+	struct elevator_type *new_e;
 	int ret = 0;
 
 	WARN_ON_ONCE(q->mq_freeze_depth == 0);
 	lockdep_assert_held(&q->elevator_lock);
 
-	if (strncmp(ctx->name, "none", 4)) {
-		new_e = elevator_find_get(ctx->name);
-		if (!new_e)
-			return -EINVAL;
-	}
+	new_e = ctx->new.elevator ? ctx->new.elevator->type : NULL;
 
 	blk_mq_quiesce_queue(q);
 
 	if (q->elevator) {
-		ctx->old = q->elevator;
+		ctx->old.elevator = q->elevator;
 		elevator_exit(q);
 	}
 
 	if (new_e) {
-		ret = blk_mq_init_sched(q, new_e);
+		ret = blk_mq_init_sched(q, new_e, ctx);
 		if (ret)
 			goto out_unfreeze;
-		ctx->new = q->elevator;
+		ctx->new.inited = 1;
 	} else {
 		blk_queue_flag_clear(QUEUE_FLAG_SQ_SCHED, q);
 		q->elevator = NULL;
 		q->nr_requests = q->tag_set->queue_depth;
 	}
-	blk_add_trace_msg(q, "elv switch: %s", ctx->name);
+	blk_add_trace_msg(q, "elv switch: %s", ctx->new.name);
 
 out_unfreeze:
 	blk_mq_unquiesce_queue(q);
@@ -610,10 +595,7 @@ static int elevator_switch(struct request_queue *q, struct elv_change_ctx *ctx)
 		pr_warn("elv: switch to \"%s\" failed, falling back to \"none\"\n",
 			new_e->elevator_name);
 	}
-
-	if (new_e)
-		elevator_put(new_e);
-	return ret;
+	ctx->status = ret;
 }
 
 static void elv_exit_and_release(struct request_queue *q)
@@ -627,28 +609,43 @@ static void elv_exit_and_release(struct request_queue *q)
 	elevator_exit(q);
 	mutex_unlock(&q->elevator_lock);
 	blk_mq_unfreeze_queue(q, memflags);
-	if (e)
+	if (e) {
+		blk_mq_free_sched_tags(q->tag_set, e);
 		kobject_put(&e->kobj);
+	}
 }
 
 static int elevator_change_done(struct request_queue *q,
 				struct elv_change_ctx *ctx)
 {
-	int ret = 0;
+	int ret = ctx->status;
+	struct elevator_queue *old_e = ctx->old.elevator;
+	struct elevator_queue *new_e = ctx->new.elevator;
+	int inited = ctx->new.inited;
 
-	if (ctx->old) {
+	if (old_e) {
 		bool enable_wbt = test_bit(ELEVATOR_FLAG_ENABLE_WBT_ON_EXIT,
-				&ctx->old->flags);
+				&old_e->flags);
 
-		elv_unregister_queue(q, ctx->old);
-		kobject_put(&ctx->old->kobj);
+		elv_unregister_queue(q, old_e);
+		blk_mq_free_sched_tags(q->tag_set, old_e);
+		kobject_put(&old_e->kobj);
 		if (enable_wbt)
 			wbt_enable_default(q->disk);
 	}
-	if (ctx->new) {
-		ret = elv_register_queue(q, ctx->new, !ctx->no_uevent);
-		if (ret)
-			elv_exit_and_release(q);
+	if (new_e) {
+		if (inited) {
+			ret = elv_register_queue(q, new_e, !ctx->new.no_uevent);
+			if (ret)
+				elv_exit_and_release(q);
+		} else {
+			/*
+			 * Switching to the new elevator failed, so free sched
+			 * tags allocated earlier and release the elevator.
+			 */
+			blk_mq_free_sched_tags(q->tag_set, new_e);
+			kobject_put(&new_e->kobj);
+		}
 	}
 	return ret;
 }
@@ -663,6 +660,11 @@ static int elevator_change(struct request_queue *q, struct elv_change_ctx *ctx)
 
 	lockdep_assert_held(&q->tag_set->update_nr_hwq_lock);
 
+	ret = blk_mq_alloc_elevator_and_sched_tags(q, ctx);
+	if (ret)
+		return ret;
+
+	ctx->status = 0;
 	memflags = blk_mq_freeze_queue(q);
 	/*
 	 * May be called before adding disk, when there isn't any FS I/O,
@@ -675,12 +677,12 @@ static int elevator_change(struct request_queue *q, struct elv_change_ctx *ctx)
 	 */
 	blk_mq_cancel_work_sync(q);
 	mutex_lock(&q->elevator_lock);
-	if (!(q->elevator && elevator_match(q->elevator->type, ctx->name)))
-		ret = elevator_switch(q, ctx);
+	if (!(q->elevator && elevator_match(q->elevator->type, ctx->new.name)))
+		elevator_switch(q, ctx);
 	mutex_unlock(&q->elevator_lock);
 	blk_mq_unfreeze_queue(q, memflags);
-	if (!ret)
-		ret = elevator_change_done(q, ctx);
+
+	ret = elevator_change_done(q, ctx);
 
 	return ret;
 }
@@ -696,17 +698,29 @@ void elv_update_nr_hw_queues(struct request_queue *q)
 
 	WARN_ON_ONCE(q->mq_freeze_depth == 0);
 
-	mutex_lock(&q->elevator_lock);
+	/*
+	 * Accessing q->elevator without holding q->elevator_lock is safe
+	 * because nr_hw_queue update is protected by set->update_nr_hwq_lock
+	 * in the writer context. So, scheduler update/switch code (which
+	 * acquires same lock in the reader context) cannot run concurrently.
+	 */
 	if (q->elevator && !blk_queue_dying(q) && blk_queue_registered(q)) {
-		ctx.name = q->elevator->type->elevator_name;
+		ctx.new.name = q->elevator->type->elevator_name;
+		ret = blk_mq_alloc_elevator_and_sched_tags(q, &ctx);
+		if (ret) {
+			pr_warn("%s: allocating sched tags failed!\n", __func__);
+			goto out_unfreeze;
+		}
 
+		mutex_lock(&q->elevator_lock);
 		/* force to reattach elevator after nr_hw_queue is updated */
-		ret = elevator_switch(q, &ctx);
+		elevator_switch(q, &ctx);
+		mutex_unlock(&q->elevator_lock);
 	}
-	mutex_unlock(&q->elevator_lock);
+
+out_unfreeze:
 	blk_mq_unfreeze_queue_nomemrestore(q);
-	if (!ret)
-		WARN_ON_ONCE(elevator_change_done(q, &ctx));
+	WARN_ON_ONCE(elevator_change_done(q, &ctx));
 }
 
 /*
@@ -716,8 +730,7 @@ void elv_update_nr_hw_queues(struct request_queue *q)
 void elevator_set_default(struct request_queue *q)
 {
 	struct elv_change_ctx ctx = {
-		.name = "mq-deadline",
-		.no_uevent = true,
+		.new = {.name = "mq-deadline", .no_uevent = true},
 	};
 	int err = 0;
 
@@ -732,18 +745,18 @@ void elevator_set_default(struct request_queue *q)
 	 * have multiple queues or mq-deadline is not available, default
 	 * to "none".
 	 */
-	if (elevator_find_get(ctx.name) && (q->nr_hw_queues == 1 ||
+	if (elevator_find_get(ctx.new.name) && (q->nr_hw_queues == 1 ||
 			 blk_mq_is_shared_tags(q->tag_set->flags)))
 		err = elevator_change(q, &ctx);
 	if (err < 0)
 		pr_warn("\"%s\" elevator initialization, failed %d, "
-			"falling back to \"none\"\n", ctx.name, err);
+			"falling back to \"none\"\n", ctx.new.name, err);
 }
 
 void elevator_set_none(struct request_queue *q)
 {
 	struct elv_change_ctx ctx = {
-		.name	= "none",
+		.new = {.name = "none"},
 	};
 	int err;
 
@@ -783,9 +796,9 @@ ssize_t elv_iosched_store(struct gendisk *disk, const char *buf,
 	 * queue is the one for the device storing the module file.
 	 */
 	strscpy(elevator_name, buf, sizeof(elevator_name));
-	ctx.name = strstrip(elevator_name);
+	ctx.new.name = strstrip(elevator_name);
 
-	elv_iosched_load_module(ctx.name);
+	elv_iosched_load_module(ctx.new.name);
 
 	down_read(&set->update_nr_hwq_lock);
 	if (!blk_queue_no_elv_switch(q)) {
diff --git a/block/elevator.h b/block/elevator.h
index a07ce773a38f..c1f22bf03283 100644
--- a/block/elevator.h
+++ b/block/elevator.h
@@ -24,7 +24,7 @@ struct blk_mq_alloc_data;
 struct blk_mq_hw_ctx;
 
 struct elevator_mq_ops {
-	int (*init_sched)(struct request_queue *, struct elevator_type *);
+	int (*init_sched)(struct request_queue *, struct elevator_queue *);
 	void (*exit_sched)(struct elevator_queue *);
 	int (*init_hctx)(struct blk_mq_hw_ctx *, unsigned int);
 	void (*exit_hctx)(struct blk_mq_hw_ctx *, unsigned int);
@@ -113,6 +113,8 @@ struct request *elv_rqhash_find(struct request_queue *q, sector_t offset);
 struct elevator_queue
 {
 	struct elevator_type *type;
+	struct blk_mq_tags **tags;
+	struct blk_mq_tags *shared_tags;
 	void *elevator_data;
 	struct kobject kobj;
 	struct mutex sysfs_lock;
@@ -152,6 +154,7 @@ ssize_t elv_iosched_show(struct gendisk *disk, char *page);
 ssize_t elv_iosched_store(struct gendisk *disk, const char *page, size_t count);
 
 extern bool elv_bio_merge_ok(struct request *, struct bio *);
+extern struct elevator_type *elevator_find_get(const char *name);
 extern struct elevator_queue *elevator_alloc(struct request_queue *,
 					struct elevator_type *);
 
diff --git a/block/kyber-iosched.c b/block/kyber-iosched.c
index 0f0f8452609a..02e3de90e1a2 100644
--- a/block/kyber-iosched.c
+++ b/block/kyber-iosched.c
@@ -402,14 +402,9 @@ static struct kyber_queue_data *kyber_queue_data_alloc(struct request_queue *q)
 	return ERR_PTR(ret);
 }
 
-static int kyber_init_sched(struct request_queue *q, struct elevator_type *e)
+static int kyber_init_sched(struct request_queue *q, struct elevator_queue *eq)
 {
 	struct kyber_queue_data *kqd;
-	struct elevator_queue *eq;
-
-	eq = elevator_alloc(q, e);
-	if (!eq)
-		return -ENOMEM;
 
 	kqd = kyber_queue_data_alloc(q);
 	if (IS_ERR(kqd)) {
diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index 2edf1cac06d5..5b02ac214a0d 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -568,17 +568,12 @@ static void dd_exit_sched(struct elevator_queue *e)
 /*
  * initialize elevator private data (deadline_data).
  */
-static int dd_init_sched(struct request_queue *q, struct elevator_type *e)
+static int dd_init_sched(struct request_queue *q, struct elevator_queue *eq)
 {
 	struct deadline_data *dd;
-	struct elevator_queue *eq;
 	enum dd_prio prio;
 	int ret = -ENOMEM;
 
-	eq = elevator_alloc(q, e);
-	if (!eq)
-		return ret;
-
 	dd = kzalloc_node(sizeof(*dd), GFP_KERNEL, q->node);
 	if (!dd)
 		goto put_eq;
-- 
2.49.0

