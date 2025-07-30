Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F1528751B
	for <linux-block@vger.kernel.org>; Wed, 30 Jul 2025 07:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753861625; cv=none; b=hpT1HnIid2lcNKap+M6ZGwpxPC96BaFP7PMCYFuNiO0pIVUHJ3bkyHs8GTgvHWoQYQK+ocP4Z8WJRyTQEc842rwIy7Jyp2P09mT8gzL2Hc2jc4GYvwmMVp/ibPlXfMVU3IKNolUbg2BQ2bV4R0m9NuWNyxmyJAvo84GgpFjxbck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753861625; c=relaxed/simple;
	bh=vbWAuz+gUGOSpYz5wufgxj7ww7wrmGRchvknnVMvaxU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nSeLQMGVCemSG6OWwQwiEudoMDzs+TX6EwWCt8Er85tlD+Ex+A/3n/bVNmuxvRP82jsBAgBvu4GR6XAogj4eA6xdZQ4F11p+Je6jg9K1Yyq5+qoEEFu0dNZ3gzvlmlE80OEzIqX/kKaUByThvsGtZM5C4nMINGkkI8TpiqR/qIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Wx4GB1PX; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Wx4GB1PX"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56U0knYr021843;
	Wed, 30 Jul 2025 07:46:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=RYLyvDfJjelAj3KNa
	w6yhuOwNsJ5nqS8hIgou7oI+XQ=; b=Wx4GB1PXJAn4VsWJWbWJX+sznQKvkGnmy
	5BKBzzfACvYZalpcrZbzCuoUpUbd8qPjUYXlhvearZn1/689WbNP7USojUNJn2Vh
	INlee2NhjQ3CbAnu61XKsKGASE6/nZVQQYQxkI58FvQtdL3k70rKd28AF0J87ZMo
	HC63a1ueJL6RbuZCRRE3SbVLxyZL8gHTohyZe952urRmRumGWfRiLqWhrrzmsZZV
	dO7GXlkXt6QR+YjH8sqNmw7zQQ8fOx5alQzGqYVRQ0C4R92dlKdw9v7TFwUTTiKg
	Cs7Eb85E2N8PMipD3H8nt5H18GtHLwg07yYMAMXv8r/WJ5+nR9Uig==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 484qemub97-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Jul 2025 07:46:54 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56U515Wt017977;
	Wed, 30 Jul 2025 07:46:29 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4859btpj79-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Jul 2025 07:46:29 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56U7kPTv50069996
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Jul 2025 07:46:25 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C9A3F20040;
	Wed, 30 Jul 2025 07:46:25 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 30E7F20043;
	Wed, 30 Jul 2025 07:46:23 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.43.45.161])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 30 Jul 2025 07:46:22 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-block@vger.kernel.org
Cc: axboe@kernel.dk, hch@lst.de, ming.lei@redhat.com, hare@suse.de,
        sth@linux.ibm.com, gjoyce@ibm.com, nilay@linux.ibm.com
Subject: [PATCHv8 2/3] block: fix lockdep warning caused by lock dependency in elv_iosched_store
Date: Wed, 30 Jul 2025 13:16:08 +0530
Message-ID: <20250730074614.2537382-3-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250730074614.2537382-1-nilay@linux.ibm.com>
References: <20250730074614.2537382-1-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: p0O8bLLGnFbJMJCnVNrEj505zjINBN1z
X-Proofpoint-GUID: p0O8bLLGnFbJMJCnVNrEj505zjINBN1z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMwMDA1MyBTYWx0ZWRfX+uW/CJfwwO2P
 N4e6vuxbMJnivqTn+0QpwaTS8JbTLVYnhLEHiWoZJcKDyw6KbjB69vkvJvRoS73m3PxBNRY+qB4
 rw2eyfpklbe5c7/u3BXo2o4t5FRhu/zjB7klflhTvtWM9MA5qDQPvr1Mmp0ca3PrGJA+rhgcHEK
 OE2XZf8H3lgrLjXVZt0W90zaEy9Ll8ThWHQPv+W5jdoRft7aQDXDxtuwNtSJbPvBVbg4VropbXs
 WaExGmmpbE8K1z4GfPTWobdy+ao6W8qZ6rfiqR9BzS9Rk8duJirMwqgcYSA0Uuwa6pRZJPiGklm
 +Rd+os/Qo/2zCxQ3mSqpeWJr6Ypv3k0+XZu1+B/IayukC6gcB+UHUDm+Q/ifcJ+jUe7ZIjRf9u3
 OB6FHJPn8RkxdEzPbsEx3aajf0nIToqjoiwnA9KezvrLfphzcp2R+XpXuHO1Oe3QYXi/VhYx
X-Authority-Analysis: v=2.4 cv=BJOzrEQG c=1 sm=1 tr=0 ts=6889cdee cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8
 a=K7DvTsf3hfHH9eChsmYA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-30_03,2025-07-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0
 mlxlogscore=999 priorityscore=1501 malwarescore=0 mlxscore=0 bulkscore=0
 adultscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507300053

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
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 block/blk-mq-sched.c | 155 +++++++++++++++++++++++--------------------
 block/blk-mq-sched.h |   8 ++-
 block/elevator.c     |  40 +++++++++--
 block/elevator.h     |  14 +++-
 4 files changed, 136 insertions(+), 81 deletions(-)

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
index 939b0c590fbe..e9dc837b7b70 100644
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
@@ -690,6 +707,7 @@ static int elevator_change(struct request_queue *q, struct elv_change_ctx *ctx)
  */
 void elv_update_nr_hw_queues(struct request_queue *q, struct elevator_type *e)
 {
+	struct blk_mq_tag_set *set = q->tag_set;
 	struct elv_change_ctx ctx = {};
 	int ret = -ENODEV;
 
@@ -697,15 +715,25 @@ void elv_update_nr_hw_queues(struct request_queue *q, struct elevator_type *e)
 
 	if (e && !blk_queue_dying(q) && blk_queue_registered(q)) {
 		ctx.name = e->elevator_name;
-
+		ctx.et = blk_mq_alloc_sched_tags(set, set->nr_hw_queues);
+		if (!ctx.et) {
+			WARN_ON_ONCE(1);
+			goto unfreeze;
+		}
 		mutex_lock(&q->elevator_lock);
 		/* force to reattach elevator after nr_hw_queue is updated */
 		ret = elevator_switch(q, &ctx);
 		mutex_unlock(&q->elevator_lock);
 	}
+unfreeze:
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
2.50.1

