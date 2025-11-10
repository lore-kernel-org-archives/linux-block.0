Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7E42512FF
	for <linux-block@vger.kernel.org>; Mon, 10 Nov 2025 08:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762762530; cv=none; b=WJ7Xkder16J7bNW6Gd8Id0yVdzCagvbSIvzqVs7ZwECVEj+aRbz7ClbIImApM0nGMATmr7rwJOXlkIonqdF8yqtysr/68lHHSYYf8ookj9Kfv1pe7058OLh64crmZe9sNIIbjk3s6/ubhHuKmiV7Sky9/Yj2utOq5CstZanwh8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762762530; c=relaxed/simple;
	bh=JPNV3SGewI0H0bP/CCveQ6ycU/Vg5NB1vnfHJO2BzRo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GO3qppWAoxnMY/SkgVfIy7bFdyoIN+WxVWHQT+Y1lIuPPB7U5wnK2fP+R80B0aOwvuX6gF3f60vRZ69ORJPCtMvtrBBkqnmECXLGrFh4x2ti9cPvBO5KJucCEvTJDwozRlSiOn0fCRY0I4I4E5rL/t6+ULghZyieD1zzfZu8DTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Elus6/C4; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Elus6/C4"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AA7rvBZ025094;
	Mon, 10 Nov 2025 08:15:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=j2pYgaRMUNTMlpo+V
	uJHRPfggdDvvsuQQMD0iodvdpk=; b=Elus6/C40tfgzFxCZUESngrbYMFv7uPCG
	IdfIMaKsICGAA/8iz802PiKTcWNpIlTDuywk4nigwpFbGQz31Y7061BG8JsZfoI5
	GUPQ/JXJzaH5NtkoOj7XQZb2/d5w7tEK34jEg27TX91Qxmk36kUzr3VFKp5IWk26
	eX/pXziqLs+h5tKJ5Lvnsfvx2EmkVQ2/X6DE0lDnd0xvJEzQSramePmP5v72l/PK
	byD8jS9+iSdZdDkPney6C0CJv70DYK3gV3ZfwWWGw498QAUxTrcrE5uToebNtH19
	aa8gwCDgbkC4kGqB9XP50UNnGdSEF+P4ptw2u8fkg8uzx5X+L6vgQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aa3m7we11-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Nov 2025 08:15:17 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AA4uxok028939;
	Mon, 10 Nov 2025 08:15:16 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4aag6s4qyr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Nov 2025 08:15:16 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5AA8FESw16253308
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Nov 2025 08:15:14 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 94AB920043;
	Mon, 10 Nov 2025 08:15:14 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F285320040;
	Mon, 10 Nov 2025 08:15:09 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.61.93.35])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 10 Nov 2025 08:15:09 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-block@vger.kernel.org
Cc: ming.lei@redhat.com, hch@lst.de, axboe@kernel.dk, yi.zhang@redhat.com,
        czhong@redhat.com, yukuai@fnnas.com, gjoyce@ibm.com
Subject: [PATCHv4 2/5] block: move elevator tags into struct elevator_resources
Date: Mon, 10 Nov 2025 13:44:49 +0530
Message-ID: <20251110081457.1006206-3-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251110081457.1006206-1-nilay@linux.ibm.com>
References: <20251110081457.1006206-1-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=MtZfKmae c=1 sm=1 tr=0 ts=69119f15 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=TYEZK6b6RLM3VZUrf3IA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: KNt64RuQ9gMLC1MMCjsRFODBntKVqXSu
X-Proofpoint-ORIG-GUID: KNt64RuQ9gMLC1MMCjsRFODBntKVqXSu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDA3OSBTYWx0ZWRfXwLrimC7EFZL9
 QeWzqQLNqTfQrjubS3OZK5NkF5X8UnNWQNIYHQX94ZRDTIL+o8OciA0xSC+7pt3TPWFgCl3oKWF
 7s+QbIjWJOkKMZM6u1mzz72iA2wknGh03ziYzvvLvNqcHv/kH0U3VOPnyy7dLnzLlJFMA853CLI
 h5lyVYzhfKCkb9HhVekY7GlSIMkVcwwpoBsRz5cgA6sRck9ClN/C1p+sc3PrFnRkvN9EuXgD5sV
 NqRiXKUwglqfAHCvNzGh/W9PCNEPTijpq6CKR0jav4XAVJD87RrTfIZnaVr/FtCX6zxBfnX7/so
 j4QNPJa2KrxLtz83ti1IlOIv1IPmA5FCXEysD/Nl9O3XdBPukrq/9on/NkmxDU4WxFMrHqBkILV
 Q+cFw65LfdonC7bH+ub0OwfANVMU3A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_03,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511080079

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

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 block/blk-mq-sched.c | 55 ++++++++++++++++++++++++++++----------------
 block/blk-mq-sched.h | 10 +++++---
 block/blk-mq.c       |  2 +-
 block/elevator.c     | 31 +++++++++++++------------
 block/elevator.h     |  9 ++++++--
 5 files changed, 66 insertions(+), 41 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 3d9386555a50..c7091ea4dccd 100644
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
@@ -532,12 +540,22 @@ struct elevator_tags *blk_mq_alloc_sched_tags(struct blk_mq_tag_set *set,
 	return NULL;
 }
 
-int blk_mq_alloc_sched_tags_batch(struct xarray *elv_tbl,
+int blk_mq_alloc_sched_res(struct elevator_resources *res,
+		struct blk_mq_tag_set *set, unsigned int nr_hw_queues)
+{
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
@@ -557,11 +575,10 @@ int blk_mq_alloc_sched_tags_batch(struct xarray *elv_tbl,
 				goto out_unwind;
 			}
 
-			ctx->et = blk_mq_alloc_sched_tags(set, nr_hw_queues,
-					blk_mq_default_nr_requests(set));
-			if (!ctx->et)
+			ret = blk_mq_alloc_sched_res(&ctx->res, set,
+					nr_hw_queues);
+			if (ret)
 				goto out_unwind;
-
 		}
 	}
 	return 0;
@@ -569,10 +586,8 @@ int blk_mq_alloc_sched_tags_batch(struct xarray *elv_tbl,
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
@@ -580,7 +595,7 @@ int blk_mq_alloc_sched_tags_batch(struct xarray *elv_tbl,
 
 /* caller must have a reference to @e, will grab another one if successful */
 int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e,
-		struct elevator_tags *et)
+		struct elevator_resources *res)
 {
 	unsigned int flags = q->tag_set->flags;
 	struct blk_mq_hw_ctx *hctx;
@@ -588,23 +603,23 @@ int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e,
 	unsigned long i;
 	int ret;
 
-	eq = elevator_alloc(q, e, et);
+	eq = elevator_alloc(q, e, res->et);
 	if (!eq)
 		return -ENOMEM;
 
-	q->nr_requests = et->nr_requests;
+	q->nr_requests = res->et->nr_requests;
 
 	if (blk_mq_is_shared_tags(flags)) {
 		/* Shared tags are stored at index 0 in @et->tags. */
-		q->sched_shared_tags = et->tags[0];
-		blk_mq_tag_update_sched_shared_tags(q, et->nr_requests);
+		q->sched_shared_tags = res->et->tags[0];
+		blk_mq_tag_update_sched_shared_tags(q, res->et->nr_requests);
 	}
 
 	queue_for_each_hw_ctx(q, hctx, i) {
 		if (blk_mq_is_shared_tags(flags))
 			hctx->sched_tags = q->sched_shared_tags;
 		else
-			hctx->sched_tags = et->tags[i];
+			hctx->sched_tags = res->et->tags[i];
 	}
 
 	ret = e->ops.init_sched(q, eq);
diff --git a/block/blk-mq-sched.h b/block/blk-mq-sched.h
index 2fddbc91a235..97204df76def 100644
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
+int blk_mq_alloc_sched_res(struct elevator_resources *res,
+		struct blk_mq_tag_set *set, unsigned int nr_hw_queues);
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
index cd7bdff205c8..7fd3c547833c 100644
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
+		ret = blk_mq_alloc_sched_res(&ctx->res, set, set->nr_hw_queues);
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

