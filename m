Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E352C11D3
	for <linux-block@vger.kernel.org>; Wed, 12 Nov 2025 05:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762925365; cv=none; b=k0ylwQfC1qBAWufK6Jnbur1G081WqDIDhGkIrMpYSM5KhRCADInVzC+y8g3n1voHGhaxOINjBUhCnftbD18mNbUHqseMmQEaCCxnPYF946lShEOJHs674lC7D5qPpXEXuklP0LM9nZEg5Uphb/MSdfw+dIHJX5Rbb4z2XG8Spt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762925365; c=relaxed/simple;
	bh=m6uwbsSHxmc8FFDpirn/x5+8J7qqJn4ykjZEx3XV5cI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P0O145eL6q7rmKB/cOosgacrPu86mmoOQ1wzURErquILYn/SI6cLfce46BD9hxRDXFcj/9z4z9jgWycPIwLYpYnwrFaKKvyXXPuA8sf3yzXSTlh68c6fvZDxFS88SsN9wQy1AHJRS4rGw7B+og/JI2DGG/SWmDkRyA3Kf1PMtVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jq+OOF6e; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jq+OOF6e"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ABGrfeg016114;
	Wed, 12 Nov 2025 05:29:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=cQFSWNNpjK9S+mhnA
	rOmvdofgHjho/Mi6Pmb9G1GBbg=; b=jq+OOF6epQq6BFnVUfvnUGxZoX6unu59g
	AZ+Y42mQvha8MFs1zwHzDPFqV2yw/y+kbttXgNCVhu+96+UQynBNgu5yaOUF4iXm
	y1hKM1JIQ2SBTkc3gdJGX7CiWY3PFTZxJWU3O7tj0CkykFeY9/wBY7ZIGz1inDUu
	26hxaKNjIxOYXlSbukhI2Om1oGjh0xEOpPGaOWGOrMTlmiWOCt52KTYJ+GWY6WFk
	PoWXhduV8Py7nctcem6WQ3dA9weg5HNWlhvkBWe8pyMhgxHuC5jS/9FVybmiWiE5
	ZVi65LUlqqQUNyhaCnMgXhOyWub2tfOiTx3AwCezEflvQxbWOfmNA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a9wc78tmn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Nov 2025 05:29:11 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AC1DA0D028939;
	Wed, 12 Nov 2025 05:29:10 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4aag6sema6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Nov 2025 05:29:10 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5AC5T83C15270384
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Nov 2025 05:29:08 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8B3E620040;
	Wed, 12 Nov 2025 05:29:08 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 82CF720043;
	Wed, 12 Nov 2025 05:29:03 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.43.41.49])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Nov 2025 05:29:03 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-block@vger.kernel.org
Cc: ming.lei@redhat.com, hch@lst.de, axboe@kernel.dk, yi.zhang@redhat.com,
        czhong@redhat.com, yukuai@fnnas.com, gjoyce@ibm.com
Subject: [PATCHv5 2/5] block: move elevator tags into struct elevator_resources
Date: Wed, 12 Nov 2025 10:56:03 +0530
Message-ID: <20251112052848.1433256-3-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251112052848.1433256-1-nilay@linux.ibm.com>
References: <20251112052848.1433256-1-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDAxOCBTYWx0ZWRfX40cC+/Tqlyds
 zZTf1+Wtxp8+bO64h6wQwSvfIui6jbZU0M1JbOUu7n6W4VehmwSyMCQg/yxz+zGXUuHYxjSZio5
 zGUeYiusWU4fqDigs2tFzYXkAjR0cxENy7iyKohiMaJB5TUG8YrpoI502JttuHcAT9SbkN79TbR
 u6JyCTd/fad4b8Y6URCOwErCnZ4H+onUoQLP3bGuwCBLJk4WM6XzKNXwt5NhkN/Pz279eu98eo8
 2pXcQUF9yo8H3hmm2b/GCt3bmZYQt51A5iNJvYEMvfOlWpRtdtFohsY6g/Mr2XN/VENMZmRNwQ7
 obCS8xPePsJgS0rCAi9g2Z4YwM/z1OR8CPKPxkLokaMmeO9u9SHF2LgHXdoLa7uWHVdZPWTdnkE
 XpDeLMo5QJJZRmKGvLb5JZ1L0hMuGA==
X-Authority-Analysis: v=2.4 cv=GcEaXAXL c=1 sm=1 tr=0 ts=69141b27 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=v_g3h6iVwOFbQ9QLieUA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: xtN_nNFvYtolrljH70uftTtoDKHT-fI4
X-Proofpoint-ORIG-GUID: xtN_nNFvYtolrljH70uftTtoDKHT-fI4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_01,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 bulkscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511080018

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

