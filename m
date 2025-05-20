Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5102025D219
	for <linux-block@vger.kernel.org>; Tue, 20 May 2025 10:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747737281; cv=none; b=uP+Zi2OLmAAWCkw0FagD/ZXV7zfxxxUSNuDdZAyW7VaMfYMSNwvsTBg1GkSr7f/hOUumEQALk9QMQuMQ3pNFDMCLeoDvVLWXPtOjHCn1VdmjHdUdPKerAiQchAshE2P8F6ZbNnW1SNcg6yWb+UHsonEnZFuoCvn7AIJ4QjPm9Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747737281; c=relaxed/simple;
	bh=o0Lx9IJrTUMa5YgpGQLnpyQpLABeRUBccPxLvfkkVLk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SWfXkvQAyRHbfly4+LuLuUUPXVyGpmt/CoRUNyQhhV1b3KL2PBMq8BCDrG/eP14skJm05icP5esM9zB8MEl/IERk+polhYZ6I1ZewGGTLE4UKCpRdXL7QZBtakPgozH3IcBrEpPELkFOIMhev2w1FNamAmNCGPDsTVWcfUDTSQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=J9UCSlLk; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="J9UCSlLk"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54K3qMJ5014344;
	Tue, 20 May 2025 10:34:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=9XDdiIrEHWW2f0Fd/V6ipN5L00clkiWdJFdtEeHqY
	E0=; b=J9UCSlLkFlnYocbRwVq+Gb/j0O1VioyFFg3pv6A0mr7Dwc5huoWoxWf8s
	+8ZOfHMJGb2OYb9T81MFWzYLKq1orTAMBo0Bqx8t/Eamau86Pb/OT/OasPE4ZTBF
	H32eVivciOGuRs0S+5MFCVBd1OcLO9/etbfjRFb6h9rpcRKlriQr4nr9hLFeYNOi
	NOxbl5+LkAqfg7eEKwceljoPE5GGoW07GhoG0pA4boWftCS0UBRd1c/NRDbivUYS
	TweMNCQV55bWp4odmwvQ0WI9mx2C7Wl60eiyHy4SHDBj/PfhE0taJ+ZsHeLvXaMR
	J1PXwpR4XBDoC6lOc30jblBDp9e+Q==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46r5v3cw35-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 May 2025 10:34:32 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54K9qF07029295;
	Tue, 20 May 2025 10:34:32 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46q55yuj8c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 May 2025 10:34:32 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 54KAYUbq58917352
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 May 2025 10:34:30 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4622A2008B;
	Tue, 20 May 2025 10:34:30 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4306E2008A;
	Tue, 20 May 2025 10:34:27 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.67.15.219])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 20 May 2025 10:34:26 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-block@vger.kernel.org
Cc: ming.lei@redhat.com, hch@lst.de, axboe@kernel.dk, sth@linux.ibm.com,
        gjoyce@ibm.com
Subject: [PATCH] block: fix lock dependency between percpu alloc lock and elevator lock
Date: Tue, 20 May 2025 16:03:49 +0530
Message-ID: <20250520103425.1259712-1-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIwMDA4MyBTYWx0ZWRfX5qJeJw/Un0rd 2Eyw3IRwGLTRtENKuphQfJDdglP14coi1wcicgsnPBcB9z8luVNqXEdLjEoWQhzT2zffCV2oUC+ tUloU3YtFx2NbJjRa94hJCMm0+tW4jcxkuK77v/oXrsVo2UX7D7fJgVH6eZYWD2934v0+cCjBRq
 SzcpHKSEmGosKdBxcoqvomlM6W1mdO9kpOgSGqJZhuDkUoDtv6b6WroQKchUDqiQeIjave+c9cu KIuPwU8FxbqEekWuDyzkXhgjIvUQcWr6L7/cek5CyCJeSjB6q4QvQCwZ80GIKrySyQdW+wEndwS brTJdm4bX5jbxDj2auFtBwkPMBXyjp00Srs+Eyp+XSQysqJOWtC4AAGQW5ma1wU30XexndgPaZ5
 mX1E/taR3xYnGIY0noEgp4/jo7perVFmhIOcMi+42eAuJKJll/chcfnBPrJAiCK2tv8PbHPf
X-Authority-Analysis: v=2.4 cv=LNFmQIW9 c=1 sm=1 tr=0 ts=682c5ab9 cx=c_pps a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=MWPDNTg0NfB-aUe9DEcA:9
X-Proofpoint-GUID: 8BK_9awuQhQJAIVdj7Xjjl5uHxLnZqbM
X-Proofpoint-ORIG-GUID: 8BK_9awuQhQJAIVdj7Xjjl5uHxLnZqbM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-20_04,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 suspectscore=0 spamscore=0 malwarescore=0 clxscore=1015
 mlxscore=0 priorityscore=1501 phishscore=0 impostorscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505200083

Recent lockdep reports [1] have indicated a potential deadlock arising
from the dependency between the percpu allocator lock and the elevaor
lock. This issue can be mitigated by ensuring that elevator/sched tags
allocation and release occur outside the eleavtor lock. Moreover, we also
don't require queue remains frozen while we allocate/release sched tags.
So this patch addresses this problem by moving the allocation and de-
allocation of elevator sched tags outside the elevator switch path that
is protected by the ->freeze_lock and ->elevator_lock. Specifically, new
elevator sched tags are now allocated before switching the elevator and
outside the freeze section and elevator lock section. The old elevator's
sched tags are then freed after the elevator lock is released and queue
is unfrozen.

To support this, the elv_change_ctx structure is extended to hold relevant
data needed for allocation and deferred release of sched tags during
elevator switching. With these changes, all sched tag allocations and
releases are performed outside both ->freeze_lock and ->elevator_lock,
preventing the lock ordering issue when elv_iosched_store is triggered
via sysfs.

[1] https://lore.kernel.org/all/0659ea8d-a463-47c8-9180-43c719e106eb@linux.ibm.com/

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 block/blk-mq-sched.c | 226 +++++++++++++++++++++++++++++--------------
 block/blk-mq-sched.h |  33 ++++++-
 block/blk-mq.c       |   2 +-
 block/blk.h          |   2 +-
 block/elevator.c     | 110 +++++++++++++--------
 5 files changed, 255 insertions(+), 118 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 55a0fd105147..d2ae5fe8433d 100644
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
+				  struct elv_data *elv)
 {
 	if (blk_mq_is_shared_tags(q->tag_set->flags)) {
 		hctx->sched_tags = q->sched_shared_tags;
 		return 0;
 	}
+	/*
+	 * We allocated the sched tags before initiating the elevator switch,
+	 * prior to acquiring ->elevator_lock, and stored them in the elevator
+	 * context. So assign those pre-allocated tags now.
+	 */
+	hctx->sched_tags = elv->tags[hctx_idx];
 
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
-static void blk_mq_sched_tags_teardown(struct request_queue *q, unsigned int flags)
+/*
+ * Called in queue's release handler, tagset has gone away. Sched tags
+ * are freed later when we finish switching the elevator and release
+ * the ->elevator_lock and ->frezze_lock.
+ */
+static void blk_mq_sched_tags_release(struct request_queue *q, unsigned int flags)
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
+		struct elv_data *elv)
 {
-	struct blk_mq_tag_set *set = queue->tag_set;
-
 	/*
-	 * Set initial depth at max so that we don't need to reallocate for
-	 * updating nr_requests.
+	 * We allocated the sched shared tags before initiating the elevator
+	 * switch, prior to acquiring ->elevator_lock and ->freeze_lock, and
+	 * stored them in the elevator context. So assign those pre-allocated
+	 * tags now.
 	 */
-	queue->sched_shared_tags = blk_mq_alloc_map_and_rqs(set,
-						BLK_MQ_NO_HCTX_IDX,
-						MAX_SCHED_RQ);
-	if (!queue->sched_shared_tags)
-		return -ENOMEM;
-
+	queue->sched_shared_tags = elv->shared_tags;
 	blk_mq_tag_update_sched_shared_tags(queue);
 
 	return 0;
@@ -458,8 +448,108 @@ void blk_mq_sched_unreg_debugfs(struct request_queue *q)
 	mutex_unlock(&q->debugfs_mutex);
 }
 
+int blk_mq_alloc_sched_tags(struct request_queue *q, struct elv_change_ctx *ctx)
+{
+	unsigned long i;
+	struct elv_data *new_e = &ctx->new.elv;
+	struct elv_data *old_e = &ctx->old.elv;
+	struct blk_mq_tag_set *set = q->tag_set;
+	gfp_t gfp = GFP_NOIO | __GFP_NOWARN | __GFP_NORETRY;
+
+	if (strncmp(ctx->new.name, "none", 4)) {
+		/*
+		 * Default to double of smaller one between hw queue_depth and
+		 * 128, since we don't split into sync/async like the old code
+		 * did. Additionally, this is a per-hw queue depth.
+		 */
+		ctx->new.nr_requests = 2 * min_t(unsigned int, set->queue_depth,
+					BLKDEV_DEFAULT_RQ);
+
+		if (blk_mq_is_shared_tags(set->flags)) {
+
+			new_e->shared_tags = blk_mq_alloc_map_and_rqs(set,
+						BLK_MQ_NO_HCTX_IDX,
+						MAX_SCHED_RQ);
+			if (!new_e->shared_tags)
+				return -ENOMEM;
+
+			return 0;
+		}
+
+		new_e->tags = kcalloc(new_e->nr_hw_queues,
+				      sizeof(struct blk_mq_tags *),
+				      gfp);
+		if (!new_e->tags)
+			return -ENOMEM;
+
+		for (i = 0; i < new_e->nr_hw_queues; i++) {
+			new_e->tags[i] = blk_mq_alloc_map_and_rqs(set, i,
+						ctx->new.nr_requests);
+			if (!new_e->tags[i])
+				goto out_free_new_e_tags;
+		}
+	}
+
+	/* Allocate memory to hold old elevator sched tags. */
+	old_e->tags = kcalloc(old_e->nr_hw_queues,
+			      sizeof(struct blk_mq_tags *),
+			      gfp);
+	if (!old_e->tags)
+		goto out_free_new_e_tags;
+
+	return 0;
+
+out_free_new_e_tags:
+	__blk_mq_free_sched_tags(q->tag_set, new_e);
+	return -ENOMEM;
+}
+
+void __blk_mq_free_sched_tags(struct blk_mq_tag_set *set,
+		struct elv_data *elv)
+{
+	unsigned long i;
+
+	if (elv->shared_tags) {
+		blk_mq_free_rqs(set, elv->shared_tags, BLK_MQ_NO_HCTX_IDX);
+		blk_mq_free_rq_map(elv->shared_tags);
+		elv->shared_tags = NULL;
+	}
+
+	if (!elv->tags)
+		return;
+
+	for (i = 0; i < elv->nr_hw_queues; i++) {
+		if (elv->tags[i]) {
+			blk_mq_free_rqs(set, elv->tags[i], i);
+			blk_mq_free_rq_map(elv->tags[i]);
+		}
+	}
+
+	kfree(elv->tags);
+	elv->tags = NULL;
+}
+
+void blk_mq_free_sched_tags(struct request_queue *q,
+		struct elv_change_ctx *ctx)
+{
+	struct elv_data *new_e = &ctx->new.elv;
+	struct elv_data *old_e = &ctx->old.elv;
+
+	/* Free old elevator sched tags. */
+	__blk_mq_free_sched_tags(q->tag_set, old_e);
+
+	/* Free new elevator sched tags if switching to new elevator failed. */
+	if (!new_e->elevator && strncmp(ctx->new.name, "none", 4))
+		__blk_mq_free_sched_tags(q->tag_set, new_e);
+
+	/* In any case, free new elevator **tags, which is no more needed. */
+	kfree(new_e->tags);
+	new_e->tags = NULL;
+}
+
 /* caller must have a reference to @e, will grab another one if successful */
-int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e)
+int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e,
+		struct elv_change_ctx *ctx)
 {
 	unsigned int flags = q->tag_set->flags;
 	struct blk_mq_hw_ctx *hctx;
@@ -467,36 +557,28 @@ int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e)
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
+		blk_mq_init_sched_shared_tags(q, &ctx->new.elv);
 
-	queue_for_each_hw_ctx(q, hctx, i) {
-		ret = blk_mq_sched_alloc_map_and_rqs(q, hctx, i);
-		if (ret)
-			goto err_free_map_and_rqs;
-	}
+	queue_for_each_hw_ctx(q, hctx, i)
+		blk_mq_init_sched_tags(q, hctx, i, &ctx->new.elv);
 
 	ret = e->ops.init_sched(q, e);
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
 				kobject_put(&eq->kobj);
 				return ret;
@@ -505,33 +587,29 @@ int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e)
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
 
 /*
- * called in either blk_queue_cleanup or elevator_switch, tagset
- * is required for freeing requests
+ * Copy elevator tags while exiting elevator. These tags are freed later
+ * when switching elevator is complete and we don't hold ->elevator_lock.
  */
-void blk_mq_sched_free_rqs(struct request_queue *q)
+void blk_mq_sched_copy_tags(struct request_queue *q, struct elv_data *elv)
 {
 	struct blk_mq_hw_ctx *hctx;
 	unsigned long i;
 
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
+	if (blk_mq_is_shared_tags(q->tag_set->flags))
+		elv->shared_tags =  q->sched_shared_tags;
+	else
+		queue_for_each_hw_ctx(q, hctx, i)
+			elv->tags[i] = hctx->sched_tags;
 }
 
 void blk_mq_exit_sched(struct request_queue *q, struct elevator_queue *e)
@@ -550,7 +628,7 @@ void blk_mq_exit_sched(struct request_queue *q, struct elevator_queue *e)
 
 	if (e->type->ops.exit_sched)
 		e->type->ops.exit_sched(e);
-	blk_mq_sched_tags_teardown(q, flags);
+	blk_mq_sched_tags_release(q, flags);
 	set_bit(ELEVATOR_FLAG_DYING, &q->elevator->flags);
 	q->elevator = NULL;
 }
diff --git a/block/blk-mq-sched.h b/block/blk-mq-sched.h
index 1326526bb733..d19e3e8a8771 100644
--- a/block/blk-mq-sched.h
+++ b/block/blk-mq-sched.h
@@ -7,6 +7,29 @@
 
 #define MAX_SCHED_RQ (16 * BLKDEV_DEFAULT_RQ)
 
+struct elv_data {
+	struct elevator_queue *elevator;
+	struct blk_mq_tags *shared_tags;
+	struct blk_mq_tags **tags;
+	int nr_hw_queues;
+};
+
+/* Holding context data for changing elevator */
+struct elv_change_ctx {
+	/* for unregistering/freeing old elevator */
+	struct {
+		struct elv_data elv;
+	} old;
+
+	/* for registering/allocating new elevator */
+	struct {
+		const char *name;
+		bool no_uevent;
+		unsigned long nr_requests;
+		struct elv_data elv;
+	} new;
+};
+
 bool blk_mq_sched_try_merge(struct request_queue *q, struct bio *bio,
 		unsigned int nr_segs, struct request **merged_request);
 bool blk_mq_sched_bio_merge(struct request_queue *q, struct bio *bio,
@@ -18,9 +41,15 @@ void __blk_mq_sched_restart(struct blk_mq_hw_ctx *hctx);
 
 void blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx);
 
-int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e);
+int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e,
+		struct elv_change_ctx *ctx);
+int blk_mq_alloc_sched_tags(struct request_queue *q,
+		struct elv_change_ctx *ctx);
+void __blk_mq_free_sched_tags(struct blk_mq_tag_set *set, struct elv_data *ctx);
+void blk_mq_free_sched_tags(struct request_queue *q,
+		struct elv_change_ctx *ctx);
 void blk_mq_exit_sched(struct request_queue *q, struct elevator_queue *e);
-void blk_mq_sched_free_rqs(struct request_queue *q);
+void blk_mq_sched_copy_tags(struct request_queue *q, struct elv_data *ctx);
 
 static inline void blk_mq_sched_restart(struct blk_mq_hw_ctx *hctx)
 {
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 4806b867e37d..c20528308442 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -5019,7 +5019,7 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 
 	/* elv_update_nr_hw_queues() unfreeze queue for us */
 	list_for_each_entry(q, &set->tag_list, tag_set_list)
-		elv_update_nr_hw_queues(q);
+		elv_update_nr_hw_queues(q, prev_nr_hw_queues);
 
 reregister:
 	list_for_each_entry(q, &set->tag_list, tag_set_list) {
diff --git a/block/blk.h b/block/blk.h
index 37ec459fe656..4d3d74c54ce7 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -321,7 +321,7 @@ bool blk_bio_list_merge(struct request_queue *q, struct list_head *list,
 
 bool blk_insert_flush(struct request *rq);
 
-void elv_update_nr_hw_queues(struct request_queue *q);
+void elv_update_nr_hw_queues(struct request_queue *q, int prev_nr_hw_queues);
 void elevator_set_default(struct request_queue *q);
 void elevator_set_none(struct request_queue *q);
 
diff --git a/block/elevator.c b/block/elevator.c
index ab22542e6cf0..0929e8cc309b 100644
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
 
@@ -159,14 +148,14 @@ static void elevator_release(struct kobject *kobj)
 	kfree(e);
 }
 
-static void elevator_exit(struct request_queue *q)
+static void elevator_exit(struct request_queue *q, struct elv_data *elv)
 {
 	struct elevator_queue *e = q->elevator;
 
 	lockdep_assert_held(&q->elevator_lock);
 
 	ioc_clear_queue(q);
-	blk_mq_sched_free_rqs(q);
+	blk_mq_sched_copy_tags(q, elv);
 
 	mutex_lock(&e->sysfs_lock);
 	blk_mq_exit_sched(q, e);
@@ -578,8 +567,8 @@ static int elevator_switch(struct request_queue *q, struct elv_change_ctx *ctx)
 	WARN_ON_ONCE(q->mq_freeze_depth == 0);
 	lockdep_assert_held(&q->elevator_lock);
 
-	if (strncmp(ctx->name, "none", 4)) {
-		new_e = elevator_find_get(ctx->name);
+	if (strncmp(ctx->new.name, "none", 4)) {
+		new_e = elevator_find_get(ctx->new.name);
 		if (!new_e)
 			return -EINVAL;
 	}
@@ -587,21 +576,21 @@ static int elevator_switch(struct request_queue *q, struct elv_change_ctx *ctx)
 	blk_mq_quiesce_queue(q);
 
 	if (q->elevator) {
-		ctx->old = q->elevator;
-		elevator_exit(q);
+		ctx->old.elv.elevator = q->elevator;
+		elevator_exit(q, &ctx->old.elv);
 	}
 
 	if (new_e) {
-		ret = blk_mq_init_sched(q, new_e);
+		ret = blk_mq_init_sched(q, new_e, ctx);
 		if (ret)
 			goto out_unfreeze;
-		ctx->new = q->elevator;
+		ctx->new.elv.elevator = q->elevator;
 	} else {
 		blk_queue_flag_clear(QUEUE_FLAG_SQ_SCHED, q);
 		q->elevator = NULL;
 		q->nr_requests = q->tag_set->queue_depth;
 	}
-	blk_add_trace_msg(q, "elv switch: %s", ctx->name);
+	blk_add_trace_msg(q, "elv switch: %s", ctx->new.name);
 
 out_unfreeze:
 	blk_mq_unquiesce_queue(q);
@@ -620,33 +609,47 @@ static void elv_exit_and_release(struct request_queue *q)
 {
 	struct elevator_queue *e;
 	unsigned memflags;
+	int ret;
+	struct elv_change_ctx ctx = {};
+
+	ctx.new.name = "none";
+	ctx.old.elv.nr_hw_queues = q->tag_set->nr_hw_queues;
+	ret = blk_mq_alloc_sched_tags(q, &ctx);
+	if (ret) {
+		pr_warn("%s: allocating sched tags failed!\n", __func__);
+		return;
+	}
 
 	memflags = blk_mq_freeze_queue(q);
 	mutex_lock(&q->elevator_lock);
 	e = q->elevator;
-	elevator_exit(q);
+	elevator_exit(q, &ctx.old.elv);
 	mutex_unlock(&q->elevator_lock);
 	blk_mq_unfreeze_queue(q, memflags);
 	if (e)
 		kobject_put(&e->kobj);
+
+	blk_mq_free_sched_tags(q, &ctx);
 }
 
 static int elevator_change_done(struct request_queue *q,
 				struct elv_change_ctx *ctx)
 {
 	int ret = 0;
+	struct elevator_queue *old_e = ctx->old.elv.elevator;
+	struct elevator_queue *new_e = ctx->new.elv.elevator;
 
-	if (ctx->old) {
+	if (old_e) {
 		bool enable_wbt = test_bit(ELEVATOR_FLAG_ENABLE_WBT_ON_EXIT,
-				&ctx->old->flags);
+				&old_e->flags);
 
-		elv_unregister_queue(q, ctx->old);
-		kobject_put(&ctx->old->kobj);
+		elv_unregister_queue(q, old_e);
+		kobject_put(&old_e->kobj);
 		if (enable_wbt)
 			wbt_enable_default(q->disk);
 	}
-	if (ctx->new) {
-		ret = elv_register_queue(q, ctx->new, !ctx->no_uevent);
+	if (new_e) {
+		ret = elv_register_queue(q, new_e, !ctx->new.no_uevent);
 		if (ret)
 			elv_exit_and_release(q);
 	}
@@ -659,9 +662,17 @@ static int elevator_change_done(struct request_queue *q,
 static int elevator_change(struct request_queue *q, struct elv_change_ctx *ctx)
 {
 	unsigned int memflags;
+	struct elv_data *old_e = &ctx->old.elv;
+	struct elv_data *new_e = &ctx->new.elv;
+	struct blk_mq_tag_set *set = q->tag_set;
 	int ret = 0;
 
-	lockdep_assert_held(&q->tag_set->update_nr_hwq_lock);
+	lockdep_assert_held(&set->update_nr_hwq_lock);
+
+	old_e->nr_hw_queues = new_e->nr_hw_queues = set->nr_hw_queues;
+	ret = blk_mq_alloc_sched_tags(q, ctx);
+	if (ret)
+		return ret;
 
 	memflags = blk_mq_freeze_queue(q);
 	/*
@@ -675,10 +686,13 @@ static int elevator_change(struct request_queue *q, struct elv_change_ctx *ctx)
 	 */
 	blk_mq_cancel_work_sync(q);
 	mutex_lock(&q->elevator_lock);
-	if (!(q->elevator && elevator_match(q->elevator->type, ctx->name)))
+	if (!(q->elevator && elevator_match(q->elevator->type, ctx->new.name)))
 		ret = elevator_switch(q, ctx);
 	mutex_unlock(&q->elevator_lock);
 	blk_mq_unfreeze_queue(q, memflags);
+
+	blk_mq_free_sched_tags(q, ctx);
+
 	if (!ret)
 		ret = elevator_change_done(q, ctx);
 
@@ -689,21 +703,38 @@ static int elevator_change(struct request_queue *q, struct elv_change_ctx *ctx)
  * The I/O scheduler depends on the number of hardware queues, this forces a
  * reattachment when nr_hw_queues changes.
  */
-void elv_update_nr_hw_queues(struct request_queue *q)
+void elv_update_nr_hw_queues(struct request_queue *q, int prev_nr_hw_queues)
 {
 	struct elv_change_ctx ctx = {};
 	int ret = -ENODEV;
 
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
+		ctx.new.elv.nr_hw_queues = q->tag_set->nr_hw_queues;
+		ctx.old.elv.nr_hw_queues = prev_nr_hw_queues;
+		ret = blk_mq_alloc_sched_tags(q, &ctx);
+		if (ret) {
+			pr_warn("%s: allocating sched tags failed!\n", __func__);
+			goto out_unfreeze;
+		}
 
+		mutex_lock(&q->elevator_lock);
 		/* force to reattach elevator after nr_hw_queue is updated */
 		ret = elevator_switch(q, &ctx);
+		mutex_unlock(&q->elevator_lock);
+
+		blk_mq_free_sched_tags(q, &ctx);
 	}
-	mutex_unlock(&q->elevator_lock);
+
+out_unfreeze:
 	blk_mq_unfreeze_queue_nomemrestore(q);
 	if (!ret)
 		WARN_ON_ONCE(elevator_change_done(q, &ctx));
@@ -716,8 +747,7 @@ void elv_update_nr_hw_queues(struct request_queue *q)
 void elevator_set_default(struct request_queue *q)
 {
 	struct elv_change_ctx ctx = {
-		.name = "mq-deadline",
-		.no_uevent = true,
+		.new = {.name = "mq-deadline", .no_uevent = true},
 	};
 	int err = 0;
 
@@ -732,18 +762,18 @@ void elevator_set_default(struct request_queue *q)
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
 
@@ -783,9 +813,9 @@ ssize_t elv_iosched_store(struct gendisk *disk, const char *buf,
 	 * queue is the one for the device storing the module file.
 	 */
 	strscpy(elevator_name, buf, sizeof(elevator_name));
-	ctx.name = strstrip(elevator_name);
+	ctx.new.name = strstrip(elevator_name);
 
-	elv_iosched_load_module(ctx.name);
+	elv_iosched_load_module(ctx.new.name);
 
 	down_read(&set->update_nr_hwq_lock);
 	if (!blk_queue_no_elv_switch(q)) {
-- 
2.49.0

