Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459922C11C5
	for <linux-block@vger.kernel.org>; Thu, 13 Nov 2025 09:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763024804; cv=none; b=vE8L+12t6DAFip2S+I2gNYsLY+4rV7nJgi/L0Kfrm4zroZKGI1G9XrGlmnmfBd2tMlxcvWeyt9iK33/DOxISRbYC6g/P88RZ/BZcc1WfNdW/NBQt2Qcjy+pov0cKSIzLx1q1ZLa6ZZGsO/3Ko6226qXZuB/KzesoUBa7y5RLUwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763024804; c=relaxed/simple;
	bh=W+kNcYkHys/PQCXdmyYLYx4jDM67r1ojKMwnMjNEa8c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NAROyEsiIe4ZlEwvhFflA6JFknOwRZZiPvl2RdRi6fHTGPn2wDDIliYJ2ziflKlt44efuWlsF3dZ9VyXZytVBJYQoaYIV4vYn2Og/TF81PfjbNN3gV572EBkd2e/AYFNZvliNsJFMVkYdwtuP1DbrXUTNQfQN/a77Pj20QgohWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PmGDC9c/; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PmGDC9c/"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ACImjXh032662;
	Thu, 13 Nov 2025 09:06:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=8Z+qjNddTK0sxX9uF
	M4magCFKyItN9KujO1CEv9RBsI=; b=PmGDC9c/MXOedJXkAzE1UTd48ZvG0JVAu
	6M1FF7fOSKAVn/zzAysovoP+d+U3NZPorlXJ+26tTbgmtuD8YwDVd2T0JIpehvaQ
	YeVuACSo22olPizmrqJRthEoMyLnJhU83EoBvaVrEOGa99ltAianqO2ymVw4DH1A
	0AzdSS19hGjEiqAWEyIdxYKznXZ3PtnFYFVfl2/gcWrINiC1pv0FpIK39PY8PO3S
	zM7HYBhduZQRMztDmQSantbUchKfrV8MqKwKWu1vFFfLqMtD6uNrBYhFcauYUGfI
	owEMMjtK1+BXFfTL09EqJdhq23pyRIFTA4K2ruQ9QgCC1s5id1B9A==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aa5tk4dj5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Nov 2025 09:06:29 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AD8a4ww028862;
	Thu, 13 Nov 2025 09:06:28 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4aag6sn4d8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Nov 2025 09:06:28 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5AD96Qg630671170
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 09:06:26 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 86A7720040;
	Thu, 13 Nov 2025 09:06:26 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 81E6F2004B;
	Thu, 13 Nov 2025 09:06:24 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.in.ibm.com (unknown [9.109.198.209])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 13 Nov 2025 09:06:24 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-block@vger.kernel.org
Cc: ming.lei@redhat.com, hch@lst.de, axboe@kernel.dk, yi.zhang@redhat.com,
        czhong@redhat.com, yukuai@fnnas.com, gjoyce@ibm.com
Subject: [PATCHv7 2/5] block: move elevator tags into struct elevator_resources
Date: Thu, 13 Nov 2025 14:28:19 +0530
Message-ID: <20251113090619.2030737-3-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251113090619.2030737-1-nilay@linux.ibm.com>
References: <20251113090619.2030737-1-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: GdeTnwMptVAKNvRyaHecA3tIWMHxozSg
X-Proofpoint-ORIG-GUID: GdeTnwMptVAKNvRyaHecA3tIWMHxozSg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDA5OSBTYWx0ZWRfX4Zy3WceBVN6a
 j1WgPRAbdKHQz+YYmkhRy1SOoIB0XfD7L9Fc2qc9yda3xj+gbgFDFzvqWSs141xUC/Zt5CBjGiB
 kFeiZsL1u2ChMdaie6NswMGjqiMYHjbJMouNWsaouG/cBO8++yagsDLJJPxgw8hjW9o/h+8VkQS
 rXPx6cU4dxQ2yEZAacgjlKav7c/F1yudczhiwoujLNgY1KFfeczgZsgl2GUI28FksAffUa/sGan
 F+K0vRdYwZMWDritLTPsTsFJ5YrGMICAEnTrCKepBp91DEoW7Xr5zQHmfyrBC9LZLNEHOhcJHrI
 AWEcEO1Z7oMhRA1+lA+LZSgbKu4buzmoeS79fOHJ7C6hhj8fA4bL1AipTkMlmAuvJr7PUefqkAy
 H0gV0udr18/CypS4W1GJxm7dkkQ59A==
X-Authority-Analysis: v=2.4 cv=V6xwEOni c=1 sm=1 tr=0 ts=69159f95 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=20KFwNOVAAAA:8 a=tJLSzyRPAAAA:8
 a=VnNF1IyMAAAA:8 a=v_g3h6iVwOFbQ9QLieUA:9 a=H0xsmVfZzgdqH4_HIfU3:22
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_01,2025-11-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 malwarescore=0 impostorscore=0
 suspectscore=0 priorityscore=1501 phishscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511080099

This patch introduces a new structure, struct elevator_resources, to
group together all elevator-related resources that share the same
lifetime. As a first step, this change moves the elevator tag pointer
from struct elv_change_ctx into the new struct elevator_resources.

Additionally, rename blk_mq_alloc_sched_tags_batch() and
blk_mq_free_sched_tags_batch() to blk_mq_alloc_sched_res_batch() and
blk_mq_free_sched_res_batch(), respectively. Introduce two new wrapper
helpers, blk_mq_alloc_sched_res() and blk_mq_free_sched_res(), around
blk_mq_alloc_sched_tags() and blk_mq_free_sched_tags().

These changes pave the way for consolidating the allocation and freeing
of elevator-specific resources into common helper functions. This
refactoring improves encapsulation and prepares the code for future
extensions, allowing additional elevator-specific data to be added to
struct elevator_resources without cluttering struct elv_change_ctx.

Subsequent patches will extend struct elevator_resources to include
other elevator-related data.

Reviewed-by: Ming Lei <ming.lei@redhat.com>
Reviewed-by: Yu Kuai <yukuai@fnnas.com>
Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 block/blk-mq-sched.c | 48 ++++++++++++++++++++++++++++++--------------
 block/blk-mq-sched.h | 10 ++++++---
 block/blk-mq.c       |  2 +-
 block/elevator.c     | 31 ++++++++++++++--------------
 block/elevator.h     |  9 +++++++--
 5 files changed, 64 insertions(+), 36 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 3d9386555a50..03ff16c49976 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -427,7 +427,16 @@ void blk_mq_free_sched_tags(struct elevator_tags *et,
 	kfree(et);
 }
 
-void blk_mq_free_sched_tags_batch(struct xarray *elv_tbl,
+void blk_mq_free_sched_res(struct elevator_resources *res,
+		struct blk_mq_tag_set *set)
+{
+	if (res->et) {
+		blk_mq_free_sched_tags(res->et, set);
+		res->et = NULL;
+	}
+}
+
+void blk_mq_free_sched_res_batch(struct xarray *elv_tbl,
 		struct blk_mq_tag_set *set)
 {
 	struct request_queue *q;
@@ -445,12 +454,11 @@ void blk_mq_free_sched_tags_batch(struct xarray *elv_tbl,
 		 */
 		if (q->elevator) {
 			ctx = xa_load(elv_tbl, q->id);
-			if (!ctx || !ctx->et) {
+			if (!ctx) {
 				WARN_ON_ONCE(1);
 				continue;
 			}
-			blk_mq_free_sched_tags(ctx->et, set);
-			ctx->et = NULL;
+			blk_mq_free_sched_res(&ctx->res, set);
 		}
 	}
 }
@@ -532,12 +540,24 @@ struct elevator_tags *blk_mq_alloc_sched_tags(struct blk_mq_tag_set *set,
 	return NULL;
 }
 
-int blk_mq_alloc_sched_tags_batch(struct xarray *elv_tbl,
+int blk_mq_alloc_sched_res(struct request_queue *q,
+		struct elevator_resources *res, unsigned int nr_hw_queues)
+{
+	struct blk_mq_tag_set *set = q->tag_set;
+
+	res->et = blk_mq_alloc_sched_tags(set, nr_hw_queues,
+			blk_mq_default_nr_requests(set));
+	if (!res->et)
+		return -ENOMEM;
+
+	return 0;
+}
+
+int blk_mq_alloc_sched_res_batch(struct xarray *elv_tbl,
 		struct blk_mq_tag_set *set, unsigned int nr_hw_queues)
 {
 	struct elv_change_ctx *ctx;
 	struct request_queue *q;
-	struct elevator_tags *et;
 	int ret = -ENOMEM;
 
 	lockdep_assert_held_write(&set->update_nr_hwq_lock);
@@ -557,11 +577,10 @@ int blk_mq_alloc_sched_tags_batch(struct xarray *elv_tbl,
 				goto out_unwind;
 			}
 
-			ctx->et = blk_mq_alloc_sched_tags(set, nr_hw_queues,
-					blk_mq_default_nr_requests(set));
-			if (!ctx->et)
+			ret = blk_mq_alloc_sched_res(q, &ctx->res,
+					nr_hw_queues);
+			if (ret)
 				goto out_unwind;
-
 		}
 	}
 	return 0;
@@ -569,10 +588,8 @@ int blk_mq_alloc_sched_tags_batch(struct xarray *elv_tbl,
 	list_for_each_entry_continue_reverse(q, &set->tag_list, tag_set_list) {
 		if (q->elevator) {
 			ctx = xa_load(elv_tbl, q->id);
-			if (ctx && ctx->et) {
-				blk_mq_free_sched_tags(ctx->et, set);
-				ctx->et = NULL;
-			}
+			if (ctx)
+				blk_mq_free_sched_res(&ctx->res, set);
 		}
 	}
 	return ret;
@@ -580,9 +597,10 @@ int blk_mq_alloc_sched_tags_batch(struct xarray *elv_tbl,
 
 /* caller must have a reference to @e, will grab another one if successful */
 int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e,
-		struct elevator_tags *et)
+		struct elevator_resources *res)
 {
 	unsigned int flags = q->tag_set->flags;
+	struct elevator_tags *et = res->et;
 	struct blk_mq_hw_ctx *hctx;
 	struct elevator_queue *eq;
 	unsigned long i;
diff --git a/block/blk-mq-sched.h b/block/blk-mq-sched.h
index 2fddbc91a235..1f8e58dd4b49 100644
--- a/block/blk-mq-sched.h
+++ b/block/blk-mq-sched.h
@@ -19,20 +19,24 @@ void __blk_mq_sched_restart(struct blk_mq_hw_ctx *hctx);
 void blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx);
 
 int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e,
-		struct elevator_tags *et);
+		struct elevator_resources *res);
 void blk_mq_exit_sched(struct request_queue *q, struct elevator_queue *e);
 void blk_mq_sched_free_rqs(struct request_queue *q);
 
 struct elevator_tags *blk_mq_alloc_sched_tags(struct blk_mq_tag_set *set,
 		unsigned int nr_hw_queues, unsigned int nr_requests);
-int blk_mq_alloc_sched_tags_batch(struct xarray *et_table,
+int blk_mq_alloc_sched_res(struct request_queue *q,
+		struct elevator_resources *res, unsigned int nr_hw_queues);
+int blk_mq_alloc_sched_res_batch(struct xarray *elv_tbl,
 		struct blk_mq_tag_set *set, unsigned int nr_hw_queues);
 int blk_mq_alloc_sched_ctx_batch(struct xarray *elv_tbl,
 		struct blk_mq_tag_set *set);
 void blk_mq_free_sched_ctx_batch(struct xarray *elv_tbl);
 void blk_mq_free_sched_tags(struct elevator_tags *et,
 		struct blk_mq_tag_set *set);
-void blk_mq_free_sched_tags_batch(struct xarray *et_table,
+void blk_mq_free_sched_res(struct elevator_resources *res,
+		struct blk_mq_tag_set *set);
+void blk_mq_free_sched_res_batch(struct xarray *et_table,
 		struct blk_mq_tag_set *set);
 
 static inline void blk_mq_sched_restart(struct blk_mq_hw_ctx *hctx)
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 1f5ef7fc9cda..2535271875bb 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -5066,7 +5066,7 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 	if (blk_mq_alloc_sched_ctx_batch(&elv_tbl, set) < 0)
 		goto out_free_ctx;
 
-	if (blk_mq_alloc_sched_tags_batch(&elv_tbl, set, nr_hw_queues) < 0)
+	if (blk_mq_alloc_sched_res_batch(&elv_tbl, set, nr_hw_queues) < 0)
 		goto out_free_ctx;
 
 	list_for_each_entry(q, &set->tag_list, tag_set_list) {
diff --git a/block/elevator.c b/block/elevator.c
index cd7bdff205c8..cbec292a4af5 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -580,7 +580,7 @@ static int elevator_switch(struct request_queue *q, struct elv_change_ctx *ctx)
 	}
 
 	if (new_e) {
-		ret = blk_mq_init_sched(q, new_e, ctx->et);
+		ret = blk_mq_init_sched(q, new_e, &ctx->res);
 		if (ret)
 			goto out_unfreeze;
 		ctx->new = q->elevator;
@@ -604,7 +604,8 @@ static int elevator_switch(struct request_queue *q, struct elv_change_ctx *ctx)
 	return ret;
 }
 
-static void elv_exit_and_release(struct request_queue *q)
+static void elv_exit_and_release(struct elv_change_ctx *ctx,
+		struct request_queue *q)
 {
 	struct elevator_queue *e;
 	unsigned memflags;
@@ -616,7 +617,7 @@ static void elv_exit_and_release(struct request_queue *q)
 	mutex_unlock(&q->elevator_lock);
 	blk_mq_unfreeze_queue(q, memflags);
 	if (e) {
-		blk_mq_free_sched_tags(e->et, q->tag_set);
+		blk_mq_free_sched_res(&ctx->res, q->tag_set);
 		kobject_put(&e->kobj);
 	}
 }
@@ -627,11 +628,12 @@ static int elevator_change_done(struct request_queue *q,
 	int ret = 0;
 
 	if (ctx->old) {
+		struct elevator_resources res = {.et = ctx->old->et};
 		bool enable_wbt = test_bit(ELEVATOR_FLAG_ENABLE_WBT_ON_EXIT,
 				&ctx->old->flags);
 
 		elv_unregister_queue(q, ctx->old);
-		blk_mq_free_sched_tags(ctx->old->et, q->tag_set);
+		blk_mq_free_sched_res(&res, q->tag_set);
 		kobject_put(&ctx->old->kobj);
 		if (enable_wbt)
 			wbt_enable_default(q->disk);
@@ -639,7 +641,7 @@ static int elevator_change_done(struct request_queue *q,
 	if (ctx->new) {
 		ret = elv_register_queue(q, ctx->new, !ctx->no_uevent);
 		if (ret)
-			elv_exit_and_release(q);
+			elv_exit_and_release(ctx, q);
 	}
 	return ret;
 }
@@ -656,10 +658,9 @@ static int elevator_change(struct request_queue *q, struct elv_change_ctx *ctx)
 	lockdep_assert_held(&set->update_nr_hwq_lock);
 
 	if (strncmp(ctx->name, "none", 4)) {
-		ctx->et = blk_mq_alloc_sched_tags(set, set->nr_hw_queues,
-				blk_mq_default_nr_requests(set));
-		if (!ctx->et)
-			return -ENOMEM;
+		ret = blk_mq_alloc_sched_res(q, &ctx->res, set->nr_hw_queues);
+		if (ret)
+			return ret;
 	}
 
 	memflags = blk_mq_freeze_queue(q);
@@ -681,10 +682,10 @@ static int elevator_change(struct request_queue *q, struct elv_change_ctx *ctx)
 	if (!ret)
 		ret = elevator_change_done(q, ctx);
 	/*
-	 * Free sched tags if it's allocated but we couldn't switch elevator.
+	 * Free sched resource if it's allocated but we couldn't switch elevator.
 	 */
-	if (ctx->et && !ctx->new)
-		blk_mq_free_sched_tags(ctx->et, set);
+	if (!ctx->new)
+		blk_mq_free_sched_res(&ctx->res, set);
 
 	return ret;
 }
@@ -711,10 +712,10 @@ void elv_update_nr_hw_queues(struct request_queue *q,
 	if (!ret)
 		WARN_ON_ONCE(elevator_change_done(q, ctx));
 	/*
-	 * Free sched tags if it's allocated but we couldn't switch elevator.
+	 * Free sched resource if it's allocated but we couldn't switch elevator.
 	 */
-	if (ctx->et && !ctx->new)
-		blk_mq_free_sched_tags(ctx->et, set);
+	if (!ctx->new)
+		blk_mq_free_sched_res(&ctx->res, set);
 }
 
 /*
diff --git a/block/elevator.h b/block/elevator.h
index bad43182361e..621a63597249 100644
--- a/block/elevator.h
+++ b/block/elevator.h
@@ -32,6 +32,11 @@ struct elevator_tags {
 	struct blk_mq_tags *tags[];
 };
 
+struct elevator_resources {
+	/* holds elevator tags */
+	struct elevator_tags *et;
+};
+
 /* Holding context data for changing elevator */
 struct elv_change_ctx {
 	const char *name;
@@ -43,8 +48,8 @@ struct elv_change_ctx {
 	struct elevator_queue *new;
 	/* store elevator type */
 	struct elevator_type *type;
-	/* holds sched tags data */
-	struct elevator_tags *et;
+	/* store elevator resources */
+	struct elevator_resources res;
 };
 
 struct elevator_mq_ops {
-- 
2.51.0

