Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2FBF291C34
	for <linux-block@vger.kernel.org>; Tue, 24 Jun 2025 13:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750771053; cv=none; b=PkZ0zKxZumOtWOZoBUXMaQRkPR6oIJ/9bAF1AD1RWemS7qTa80Skle3xMlqNDSYcOk8ewQG13KbItDNKLm+IGEnQrwgYUGTkKPcTxe7M04pnD2qeNBYbaI6/ru1EIwB/1lyPEecBPQoKtA/M5QFlOmuPU/FB0vVvLHch2cRkGgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750771053; c=relaxed/simple;
	bh=syaSihA/aDQZ906LOg21ySsQFQ5+GJyC5bSBZSsfYXg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fWBf7yKKfiurYnhzLj0h8/Zdis7ywy4zvKR9ykNGumZg1V48+D/7aBH1BIsBoAM6RQdHwXQfJ1FDNkgcJtd3217sU5paymw3gk7LI5Cas64jXOM/0GcAVYcNEDiNHuK/MTdVk+adJRjksEWU8ZYqg69Cb2p+eQ2MncCrEqjp7ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=X57e4/6Q; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="X57e4/6Q"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55O83haa027197;
	Tue, 24 Jun 2025 13:17:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=g5tpXk5VOEmJAnp5Y
	aozFjIpis2oOZk1N1phjw9wNHg=; b=X57e4/6QmgZwqpV03X1o135RRE1eQ8nCn
	blj35wJj5Ztzjipv96WfMZFpFCGOgaR7qGNPG17tyiXVDcYZljezDo87HZqGhseC
	s7I5coQ/iruBJ9EU1zgN2XoKTr0lXNRZgXMF8F8hCrFp/NH0m/WHLOqtPwsLKjiu
	HWikQ1UZWlNAdLmC8YsJ8Im2C/zRLRvnwlGMwiFmNsfwnLewA8hgtc4XdRTZ0YvX
	T8Mc+CGq4GsrxAqxvw4iyHbjgkfPTvFakw7bE52ODuq5/es11NGfJuqLlzOzKHx+
	LtFpRIzMndrgqXHxhdQMwnvrX8vPO1zKUXCuMYnKsv1pt34d6QK/w==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dj5trvcp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Jun 2025 13:17:24 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55O9WGVM006400;
	Tue, 24 Jun 2025 13:17:24 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47e82p45jy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Jun 2025 13:17:24 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55ODHMIA31326482
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Jun 2025 13:17:22 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 53EE120043;
	Tue, 24 Jun 2025 13:17:22 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C927620040;
	Tue, 24 Jun 2025 13:17:20 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.in.ibm.com (unknown [9.109.198.209])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 24 Jun 2025 13:17:20 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-block@vger.kernel.org
Cc: hch@lst.de, ming.lei@redhat.com, axboe@kernel.dk, sth@linux.ibm.com,
        gjoyce@ibm.com
Subject: [PATCHv4 2/3] block: fix lockdep warning caused by lock dependency in elv_iosched_store
Date: Tue, 24 Jun 2025 18:47:04 +0530
Message-ID: <20250624131716.630465-3-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250624131716.630465-1-nilay@linux.ibm.com>
References: <20250624131716.630465-1-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 2zxm7bG4BqMsqxv3lHUweyQPMiPlTPjc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI0MDExMiBTYWx0ZWRfXyWPpMyeeaEki cF91k+jmvYdxjB/mevUxuzDBD0xVbMkKuKcFfYVDY2Dnb61QJDv/QeaH5tkYnaWLbuOQJ7+o+0C N7tS+AITfbiyl/KiNjXY6s1fFZF35copE8shEgW+gJqladNuCSfcxpqXhoxdi9RVE108cdh44BA
 d7vvOjc1PSRIeG3Ea6to94GB3Uwelmjo9rYVID9+D0VPCQy7k4QiR4luLcribZHUYJIyXPP+1SC cGfGU4D67usB2ZsbispUnB7XwNYVPUBcDgB7e8YvD2toirK6DP9wKrsCQJM1wE06lghoSTA98P9 KYLGXw1ZQaGcQQSXjNzJyiLw9eRIkfnO9ZJPCps6t/UG6YmDfyc7m1VshjEISeiIylhOeZVMrTN
 JdNXi6HqPs0Dmkz3iQvmkyZjtaSBTDCT8ZYP/rGJMCVUT+zPAEEn7Bwujzx/Wu1UpVGQr4bh
X-Authority-Analysis: v=2.4 cv=MshS63ae c=1 sm=1 tr=0 ts=685aa565 cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=8C7QiuhBnyRB_e-tNnwA:9
X-Proofpoint-GUID: 2zxm7bG4BqMsqxv3lHUweyQPMiPlTPjc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-24_05,2025-06-23_07,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 mlxlogscore=999 impostorscore=0
 clxscore=1015 phishscore=0 malwarescore=0 suspectscore=0 adultscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506240112

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
 block/blk-mq-sched.c | 186 ++++++++++++++++++++++++++-----------------
 block/blk-mq-sched.h |  14 +++-
 block/elevator.c     |  66 +++++++++++++--
 block/elevator.h     |  19 ++++-
 4 files changed, 204 insertions(+), 81 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 359e0704e09b..5d3132ac7777 100644
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
@@ -458,8 +411,106 @@ void blk_mq_sched_unreg_debugfs(struct request_queue *q)
 	mutex_unlock(&q->debugfs_mutex);
 }
 
+void __blk_mq_free_sched_tags(struct blk_mq_tag_set *set,
+		struct blk_mq_tags **tags, unsigned int nr_hw_queues)
+{
+	unsigned long i;
+
+	if (!tags)
+		return;
+
+	/* Shared tags are stored at index 0 in @tags. */
+	if (blk_mq_is_shared_tags(set->flags))
+		blk_mq_free_map_and_rqs(set, tags[0], BLK_MQ_NO_HCTX_IDX);
+	else {
+		for (i = 0; i < nr_hw_queues; i++)
+			blk_mq_free_map_and_rqs(set, tags[i], i);
+	}
+
+	kfree(tags);
+}
+
+void blk_mq_free_sched_tags(struct elevator_tags *et,
+		struct blk_mq_tag_set *set, int id)
+{
+	struct blk_mq_tags **tags;
+
+	tags = xa_load(&et->tags_table, id);
+	__blk_mq_free_sched_tags(set, tags, et->nr_hw_queues);
+}
+
+struct blk_mq_tags **__blk_mq_alloc_sched_tags(struct blk_mq_tag_set *set,
+				unsigned int nr_hw_queues,
+				unsigned int nr_requests,
+				gfp_t gfp)
+{
+	int i, nr_tags;
+	struct blk_mq_tags **tags;
+
+	if (blk_mq_is_shared_tags(set->flags))
+		nr_tags = 1;
+	else
+		nr_tags = nr_hw_queues;
+
+	tags = kcalloc(nr_tags, sizeof(struct blk_mq_tags *), gfp);
+	if (!tags)
+		return NULL;
+
+	if (blk_mq_is_shared_tags(set->flags)) {
+		/* Shared tags are stored at index 0 in @tags. */
+		tags[0] = blk_mq_alloc_map_and_rqs(set, BLK_MQ_NO_HCTX_IDX,
+					MAX_SCHED_RQ);
+		if (!tags[0])
+			goto out;
+	} else {
+		for (i = 0; i < nr_hw_queues; i++) {
+			tags[i] = blk_mq_alloc_map_and_rqs(set, i, nr_requests);
+			if (!tags[i])
+				goto out_unwind;
+		}
+	}
+
+	return tags;
+out_unwind:
+	while (--i >= 0)
+		blk_mq_free_map_and_rqs(set, tags[i], i);
+out:
+	kfree(tags);
+	return NULL;
+}
+
+int blk_mq_alloc_sched_tags(struct elevator_tags *et,
+		struct blk_mq_tag_set *set, int id)
+{
+	struct blk_mq_tags **tags;
+	gfp_t gfp = GFP_NOIO | __GFP_NOWARN | __GFP_NORETRY;
+
+	/*
+	 * Default to double of smaller one between hw queue_depth and
+	 * 128, since we don't split into sync/async like the old code
+	 * did. Additionally, this is a per-hw queue depth.
+	 */
+	et->nr_requests = 2 * min_t(unsigned int, set->queue_depth,
+			BLKDEV_DEFAULT_RQ);
+
+	tags = __blk_mq_alloc_sched_tags(set, et->nr_hw_queues,
+			et->nr_requests, gfp);
+	if (!tags)
+		return -ENOMEM;
+
+	if (xa_insert(&et->tags_table, id, tags, gfp))
+		goto out_free_tags;
+
+	return 0;
+
+out_free_tags:
+	__blk_mq_free_sched_tags(set, tags, et->nr_hw_queues);
+	return -ENOMEM;
+}
+
 /* caller must have a reference to @e, will grab another one if successful */
-int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e)
+int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e,
+		struct elevator_tags *et)
 {
 	unsigned int flags = q->tag_set->flags;
 	struct blk_mq_hw_ctx *hctx;
@@ -467,40 +518,33 @@ int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e)
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
+		/* Shared tags are stored at index 0 in @eq->tags. */
+		q->sched_shared_tags = eq->tags[0];
+		blk_mq_tag_update_sched_shared_tags(q);
 	}
 
 	queue_for_each_hw_ctx(q, hctx, i) {
-		ret = blk_mq_sched_alloc_map_and_rqs(q, hctx, i);
-		if (ret)
-			goto err_free_map_and_rqs;
+		if (blk_mq_is_shared_tags(flags))
+			hctx->sched_tags = q->sched_shared_tags;
+		else
+			hctx->sched_tags = eq->tags[i];
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
@@ -509,10 +553,8 @@ int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e)
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
index 1326526bb733..92aa50b8376a 100644
--- a/block/blk-mq-sched.h
+++ b/block/blk-mq-sched.h
@@ -18,7 +18,19 @@ void __blk_mq_sched_restart(struct blk_mq_hw_ctx *hctx);
 
 void blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx);
 
-int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e);
+int blk_mq_alloc_sched_tags(struct elevator_tags *et,
+		struct blk_mq_tag_set *set, int id);
+void blk_mq_free_sched_tags(struct elevator_tags *et,
+		struct blk_mq_tag_set *set, int id);
+struct blk_mq_tags **__blk_mq_alloc_sched_tags(struct blk_mq_tag_set *set,
+					unsigned int nr_hw_queues,
+					unsigned int nr_requests,
+					gfp_t gfp);
+void __blk_mq_free_sched_tags(struct blk_mq_tag_set *set,
+		struct blk_mq_tags **tags, unsigned int nr_hw_queues);
+
+int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e,
+		struct elevator_tags *et);
 void blk_mq_exit_sched(struct request_queue *q, struct elevator_queue *e);
 void blk_mq_sched_free_rqs(struct request_queue *q);
 
diff --git a/block/elevator.c b/block/elevator.c
index 770874040f79..1408894c0396 100644
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
 
@@ -145,8 +147,15 @@ struct elevator_queue *elevator_alloc(struct request_queue *q,
 	kobject_init(&eq->kobj, &elv_ktype);
 	mutex_init(&eq->sysfs_lock);
 	hash_init(eq->hash);
+	eq->nr_hw_queues = et->nr_hw_queues;
+	eq->tags = xa_load(&et->tags_table, q->id);
+	if (WARN_ON_ONCE(!eq->tags))
+		goto out;
 
 	return eq;
+out:
+	kobject_put(&eq->kobj);
+	return NULL;
 }
 
 static void elevator_release(struct kobject *kobj)
@@ -165,7 +174,6 @@ static void elevator_exit(struct request_queue *q)
 	lockdep_assert_held(&q->elevator_lock);
 
 	ioc_clear_queue(q);
-	blk_mq_sched_free_rqs(q);
 
 	mutex_lock(&e->sysfs_lock);
 	blk_mq_exit_sched(q, e);
@@ -591,7 +599,7 @@ static int elevator_switch(struct request_queue *q, struct elv_change_ctx *ctx)
 	}
 
 	if (new_e) {
-		ret = blk_mq_init_sched(q, new_e);
+		ret = blk_mq_init_sched(q, new_e, ctx->et);
 		if (ret)
 			goto out_unfreeze;
 		ctx->new = q->elevator;
@@ -626,8 +634,10 @@ static void elv_exit_and_release(struct request_queue *q)
 	elevator_exit(q);
 	mutex_unlock(&q->elevator_lock);
 	blk_mq_unfreeze_queue(q, memflags);
-	if (e)
+	if (e) {
+		__blk_mq_free_sched_tags(q->tag_set, e->tags, e->nr_hw_queues);
 		kobject_put(&e->kobj);
+	}
 }
 
 static int elevator_change_done(struct request_queue *q,
@@ -640,6 +650,8 @@ static int elevator_change_done(struct request_queue *q,
 				&ctx->old->flags);
 
 		elv_unregister_queue(q, ctx->old);
+		__blk_mq_free_sched_tags(q->tag_set, ctx->old->tags,
+				ctx->old->nr_hw_queues);
 		kobject_put(&ctx->old->kobj);
 		if (enable_wbt)
 			wbt_enable_default(q->disk);
@@ -658,9 +670,20 @@ static int elevator_change_done(struct request_queue *q,
 static int elevator_change(struct request_queue *q, struct elv_change_ctx *ctx)
 {
 	unsigned int memflags;
+	struct elevator_tags et;
+	struct blk_mq_tag_set *set = q->tag_set;
 	int ret = 0;
 
-	lockdep_assert_held(&q->tag_set->update_nr_hwq_lock);
+	lockdep_assert_held(&set->update_nr_hwq_lock);
+
+	et.nr_hw_queues = set->nr_hw_queues;
+	xa_init(&et.tags_table);
+	ctx->et = &et;
+	if (strncmp(ctx->name, "none", 4)) {
+		ret = blk_mq_alloc_sched_tags(ctx->et, set, q->id);
+		if (ret)
+			goto out;
+	}
 
 	memflags = blk_mq_freeze_queue(q);
 	/*
@@ -680,7 +703,13 @@ static int elevator_change(struct request_queue *q, struct elv_change_ctx *ctx)
 	blk_mq_unfreeze_queue(q, memflags);
 	if (!ret)
 		ret = elevator_change_done(q, ctx);
-
+	/*
+	 * Free sched tags if it's allocated but we couldn't switch elevator.
+	 */
+	if (!xa_empty(&ctx->et->tags_table) && !ctx->new)
+		blk_mq_free_sched_tags(ctx->et, set, q->id);
+out:
+	xa_destroy(&ctx->et->tags_table);
 	return ret;
 }
 
@@ -690,11 +719,29 @@ static int elevator_change(struct request_queue *q, struct elv_change_ctx *ctx)
  */
 void elv_update_nr_hw_queues(struct request_queue *q)
 {
+	struct blk_mq_tag_set *set = q->tag_set;
+	struct elevator_tags et;
 	struct elv_change_ctx ctx = {};
 	int ret = -ENODEV;
 
 	WARN_ON_ONCE(q->mq_freeze_depth == 0);
 
+	et.nr_hw_queues = set->nr_hw_queues;
+	xa_init(&et.tags_table);
+	ctx.et = &et;
+	/*
+	 * Accessing q->elevator without holding q->elevator_lock is safe here
+	 * because nr_hw_queue update is protected by set->update_nr_hwq_lock
+	 * in the writer context. So, scheduler update/switch code (which
+	 * acquires same lock in the reader context) can't run concurrently.
+	 */
+	if (q->elevator) {
+		if (blk_mq_alloc_sched_tags(ctx.et, set, q->id)) {
+			WARN_ON_ONCE(1);
+			goto out;
+		}
+	}
+
 	mutex_lock(&q->elevator_lock);
 	if (q->elevator && !blk_queue_dying(q) && blk_queue_registered(q)) {
 		ctx.name = q->elevator->type->elevator_name;
@@ -706,6 +753,13 @@ void elv_update_nr_hw_queues(struct request_queue *q)
 	blk_mq_unfreeze_queue_nomemrestore(q);
 	if (!ret)
 		WARN_ON_ONCE(elevator_change_done(q, &ctx));
+	/*
+	 * Free sched tags if it's allocated but we couldn't switch elevator.
+	 */
+	if (!xa_empty(&ctx.et->tags_table) && !ctx.new)
+		blk_mq_free_sched_tags(ctx.et, set, q->id);
+out:
+	xa_destroy(&ctx.et->tags_table);
 }
 
 /*
diff --git a/block/elevator.h b/block/elevator.h
index a4de5f9ad790..849c264031ca 100644
--- a/block/elevator.h
+++ b/block/elevator.h
@@ -23,6 +23,19 @@ enum elv_merge {
 struct blk_mq_alloc_data;
 struct blk_mq_hw_ctx;
 
+struct elevator_tags {
+	/* num. of hardware queues for which tags are allocated */
+	unsigned int nr_hw_queues;
+	/* depth used while allocating tags */
+	unsigned int nr_requests;
+	/*
+	 * An Xarray table storing shared and per hardware queue sched tags.
+	 * The key to store an entry in Xarray is q->id. Please note that
+	 * shared sched tags are always stored at index 0.
+	 */
+	struct xarray tags_table;
+};
+
 struct elevator_mq_ops {
 	int (*init_sched)(struct request_queue *, struct elevator_queue *);
 	void (*exit_sched)(struct elevator_queue *);
@@ -113,6 +126,8 @@ struct request *elv_rqhash_find(struct request_queue *q, sector_t offset);
 struct elevator_queue
 {
 	struct elevator_type *type;
+	struct blk_mq_tags **tags;
+	unsigned int nr_hw_queues;
 	void *elevator_data;
 	struct kobject kobj;
 	struct mutex sysfs_lock;
@@ -152,8 +167,8 @@ ssize_t elv_iosched_show(struct gendisk *disk, char *page);
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

