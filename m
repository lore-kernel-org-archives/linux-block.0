Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E9132C305
	for <linux-block@vger.kernel.org>; Wed, 29 Oct 2025 10:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761734217; cv=none; b=F5csNiifovwjtY5T5zRlBttvarjb8s6anb5RhONk6iK6VD7rDb6NRQJxp/x/tiyyXbGAg7QQJilO4uUXMzO0f6FHxALTkwVwr5JUPzMhnpzxL+AIowPvy/EXWTu9C175yoTRJj7DoB87tmRH7W4U5U9pGYkBKQqQuQlY7ElyJu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761734217; c=relaxed/simple;
	bh=RX/rfFLgDQNCdOGtWpaf/s5zjQmJ5qjXkrze0Kar6Aw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gTDitm4XoxrEyJR9RvLngWr84V1GB6BbZFBXRorupC6hFwct8UC+QF121IoH3K9Zq8jg8vyx4TaiflfyOX4pJPddLAYyntrhfBmTnr+0KVZ/JSxooq5WNgd/DY05+8zogbtGIO0BdAxtOn4yEChs/PJR9zDinzCBTU68HDG5cHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WQK7atOI; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WQK7atOI"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59SJmCwX025772;
	Wed, 29 Oct 2025 10:36:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=V8S1J/kAOUA9CDvHO
	voajY2g3OsFOu7FKpEodpIGPoI=; b=WQK7atOIyf4IzhTCdXuH49IOz9T3/LwU0
	YU3J9RoU4iNZp8VtdXDbioCa8pPpq3jbfBnQEY/pyLUzFQ5/tJqrw0N/VtEBHGox
	9Q9Ewu3dpl0D34phop6VBubhUQWUP+XKiLgjZKbLGVio3SfWaKnDh+GG/hm/jy05
	pG92kaUewpEetmes7HjVQtOMvgepEGAjodTInEvGA6P0SmTpIkch2MukvJo7T3V5
	yj0MOywpQcpK6l8kLo9YCM+2bvnHqu44Qfn8gRSVpLpJ535Pn7W8sHY5EiQlJL6I
	P15jGSNJ1VSGSJo1/jk4lxH2nGXQlf2pYbaHCkrpI3FEZ8efStG6g==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a34acjs49-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Oct 2025 10:36:48 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59T9wvvl030753;
	Wed, 29 Oct 2025 10:36:47 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4a33wwjvm0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Oct 2025 10:36:47 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59TAajWb50528578
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Oct 2025 10:36:45 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1E40020043;
	Wed, 29 Oct 2025 10:36:45 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 008A420040;
	Wed, 29 Oct 2025 10:36:40 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.61.159.127])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 29 Oct 2025 10:36:39 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-block@vger.kernel.org
Cc: ming.lei@redhat.com, hch@lst.de, axboe@kernel.dk, yi.zhang@redhat.com,
        czhong@redhat.com, gjoyce@ibm.com
Subject: [PATCHv3 2/4] block: move elevator tags into struct elevator_resources
Date: Wed, 29 Oct 2025 16:06:15 +0530
Message-ID: <20251029103622.205607-3-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251029103622.205607-1-nilay@linux.ibm.com>
References: <20251029103622.205607-1-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=XbuEDY55 c=1 sm=1 tr=0 ts=6901ee40 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=1tIFTA3NGq1c-V0S2pIA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: I-91kNdPVqQruie8h2sQq4f5RAbV5t3k
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDE2NiBTYWx0ZWRfX6NndO3eHV0iA
 Fqv1eDcVKp5kJwsGTsx76TtMgRWrRkrs90eBGQzXf7PL/qGRVesvyJytpq59Y9NbzJClPec5Swx
 F99mYVyJuheLM/StSotS4Kc/e4P/q4gY20Blh8jlF4lghCaFQHGK3LgncJwe+piBDcBhq+GXNvr
 paeiDeJLzp0ffwRmql5a2wXF3sRuwRF9Qt7BPm2Wz9jg4kMzLIneSge4oq2aQ8ykEqoKAoUKlnH
 WDbbxeodx2gZiwtzC18tNEQJEzoiYALzhIxzNfj9b0xtI1TmR8MH7DzzE75O8EB0g3CiuSXiCxO
 +TxFV2pG7vg5r/Q6uR6d0H7hQLaZdXjStm/kY0I3u/+bwLoL/MukdQOrabcO8cPtQ8Jh8awFmc4
 6BBPbJRTqg0kyAh7JZthrgeB3/ddGA==
X-Proofpoint-GUID: I-91kNdPVqQruie8h2sQq4f5RAbV5t3k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-29_04,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 bulkscore=0 spamscore=0
 impostorscore=0 phishscore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2510280166

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
 block/elevator.c     | 35 ++++++++++++++--------------
 block/elevator.h     | 11 ++++++---
 5 files changed, 69 insertions(+), 44 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 3d9386555a50..6db45b0819e6 100644
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
+	eq = elevator_alloc(q, e, res);
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
index cd7bdff205c8..d5d89b202fda 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -121,7 +121,7 @@ static struct elevator_type *elevator_find_get(const char *name)
 static const struct kobj_type elv_ktype;
 
 struct elevator_queue *elevator_alloc(struct request_queue *q,
-		struct elevator_type *e, struct elevator_tags *et)
+		struct elevator_type *e, struct elevator_resources *res)
 {
 	struct elevator_queue *eq;
 
@@ -134,7 +134,7 @@ struct elevator_queue *elevator_alloc(struct request_queue *q,
 	kobject_init(&eq->kobj, &elv_ktype);
 	mutex_init(&eq->sysfs_lock);
 	hash_init(eq->hash);
-	eq->et = et;
+	eq->et = res->et;
 
 	return eq;
 }
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
index bad43182361e..6533f74ad5ef 100644
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
@@ -178,7 +183,7 @@ ssize_t elv_iosched_store(struct gendisk *disk, const char *page, size_t count);
 
 extern bool elv_bio_merge_ok(struct request *, struct bio *);
 struct elevator_queue *elevator_alloc(struct request_queue *,
-		struct elevator_type *, struct elevator_tags *);
+		struct elevator_type *, struct elevator_resources *);
 
 /*
  * Helper functions.
-- 
2.51.0

