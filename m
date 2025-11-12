Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0CB632D44F
	for <linux-block@vger.kernel.org>; Wed, 12 Nov 2025 13:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762953802; cv=none; b=SxWKPdlOF1W8y50daU7EUSFvPQxxF49H2kU2PgWjFAV3wNm0LUYIGlIN1PxkXeADfljDfJj+GuIQRDh0LS8+VGZQEEr1mWMfqiFRXjju1TY31gSvv7WANbB/dSNSomGDWr8+iYCoJmOmO3xrHQ+FCdYHF/uXHUEyE827ETNS2X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762953802; c=relaxed/simple;
	bh=/5dGdyVwSl5nbktuQp4kDG4qLvaK2T32///E4JKoi0w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VKYLU4DmY2vgHd6XUW1YjJrvlQqw+sD9IMqet/l2LbkkgG7lqpMKrBw4LN7Idv1nMcW7uSzTwxkGrlucTSCUlhq/RWeb49IzXxxIq3ILOQI8/5mRyjSt/mr45SG8PZ6IHJhgQ+9becB399P4qgL3Dnw6E/njz7d28MTRWQ5w/UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jrMRF82w; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jrMRF82w"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AC7d95N013673;
	Wed, 12 Nov 2025 13:23:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=AMtAg4VA1FJyOVwzt
	o4PyT6/PQjpF4Q1GaOvk6wSRZ0=; b=jrMRF82wNmdvtNHYy2G14YVNtAH7IgvQo
	9PuVfzAN9TmbNzWvQionHJ1OISnFaRxVhL1j8U/zjMeyqp/+3spMTOXZE7S52Jyx
	EyAg6cK33WQN9QrQuEI7/cZGY3/P1kYJtSnt88+LOuYDi1g+2OxMKAnzIxUGxhet
	VEfWvOkqEsKSELwnu0Ztmablf3cKqUhkiT3oLk4T+RzLKY8U7Mi4i6XE3qZLWtjw
	vU9jMpq99ahBfxDvKWZ6cfTByaZO4cvdU8dzAfkOhdyk/Lc4FjHBkGQ/qyN/B9NH
	wUl10tC/fZ379oxaqK/aruq3E+zjFojWTji+b1zXoNsA0MZNkXVGQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aa5tk0671-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Nov 2025 13:23:07 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5ACA0Woe007325;
	Wed, 12 Nov 2025 13:23:06 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4aajdjg6he-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Nov 2025 13:23:06 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5ACDN5KE43254222
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Nov 2025 13:23:05 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DA18320043;
	Wed, 12 Nov 2025 13:23:04 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DD5ED20040;
	Wed, 12 Nov 2025 13:23:00 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.43.41.49])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Nov 2025 13:23:00 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-block@vger.kernel.org
Cc: ming.lei@redhat.com, hch@lst.de, axboe@kernel.dk, yi.zhang@redhat.com,
        czhong@redhat.com, yukuai@fnnas.com, gjoyce@ibm.com
Subject: [PATCHv6 2/5] block: move elevator tags into struct elevator_resources
Date: Wed, 12 Nov 2025 18:52:25 +0530
Message-ID: <20251112132249.1791304-3-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251112132249.1791304-1-nilay@linux.ibm.com>
References: <20251112132249.1791304-1-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: A4mDKkyZz_fpnyk8nSNzhgt6l-rw7oFD
X-Proofpoint-ORIG-GUID: A4mDKkyZz_fpnyk8nSNzhgt6l-rw7oFD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDA5OSBTYWx0ZWRfX2on43kLXv0Eb
 bAUTtoGCvv04C2Py8w0cqwaMQedVjxwkq8q8X4pE96lf671YOxKhn8jZaHaNmZA3BclI56C0T+R
 bTip5D/9gcf+J4Y77HwUglJLs0Kugh0FWCo+RckqfM1k7CTKx7dH7q6kC9cpjS1wcqQMbhgcWwN
 DQTWeyj3dR5gxi7enUbCKy5UQgEbGrMR4TXGdtvd0PAdLauZI47ysfHB81MVPt2z2Bf4oa+0m3B
 G4ZaAvfTcXgUTM7EwwA0pgA9qDH/NrPynbKxsJk75VTTdnCmiNhrjyttbdcK3ttwXJNlCn8Alq+
 owp+y6V00tFzBEax/zB/mAhBt4EMc/Izfb3Un698rnW/ZqKnF4YY9qWu1Uh8nn+5RGcQHL/QRGA
 qh6EIqfqn2EFIgXfOyYtIpqmV1/RVA==
X-Authority-Analysis: v=2.4 cv=V6xwEOni c=1 sm=1 tr=0 ts=69148a3b cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8
 a=v_g3h6iVwOFbQ9QLieUA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_03,2025-11-11_03,2025-10-01_01
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

