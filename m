Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CE927E1C5
	for <linux-block@vger.kernel.org>; Thu, 13 Nov 2025 09:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763024811; cv=none; b=rhjceZWPSPms1VxR3p64NVQaDdLiVgxa3ngqiUiCULKqYjANbJqudpczV3TY5fzVtWW3S2IrJ/z9dt1X8sHHG+n81PjgokhyDCONWIbFeR+oJC/v0rAFzvITTi3R5qnT7Gzyg3F00GT6sDPkO8GJsPk1rNFosdt6x8S7aRN4HA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763024811; c=relaxed/simple;
	bh=hStucodmdjA1k+2lQiqkSdds7Q/tcsc9PZzVdV1sqnU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kMPYXHBi39p79xZKizn0GOMjOcvb/W7PxiP/yuUt4F0T0N9TKNdi0MJVKdHmrpUNtbEo/q5eqDm37KnL+xHtAScg0Y1y1eMbbQwbkjWSeIvetC0aHreVWlk3kGcVMZkFtjBR+brfhf5157oD4FPPQoNookWjzcEA1P+gEDdtUeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FhNnL6JB; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FhNnL6JB"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ACKYNpP016810;
	Thu, 13 Nov 2025 09:06:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=0v5rGAReSP9XTPO+U
	AEJ5bRvPb3NN5DITW21GAnAz1w=; b=FhNnL6JBgp1MU4tlYPYTYwJB5Uyg73VKa
	7dCIn5nnmaYBuwJNw43WCLHd7dKZEmR5hZVwzWRYwFjQ9dHU37WPFyQp7FePKgHp
	SecowtNzho7WPzg9yXabK/lIpYPcm24/dz6cISFWGaetD54D+demCFrl8xc0w3od
	6k1Xm55XLXAxsvYLrB8YTDs9ISFXq/Ci5Mi5S8Rs292Rib58+BBMCG4mD46R9CrR
	g66BrGqI+wOmSFvwXobxzyhltaqTTqCzRam1Tp1E0aFVMLJy82kbqt6y1jzQomvG
	8tTtYuZ5IH8IPIdWq2DZct6DRfDoWT+Npcm5nfWiP81CthlJ+6CUw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a9wc7f4wu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Nov 2025 09:06:35 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AD8atMP007309;
	Thu, 13 Nov 2025 09:06:34 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4aajdjmryp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Nov 2025 09:06:34 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5AD96XLh19136782
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 09:06:33 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1134720043;
	Thu, 13 Nov 2025 09:06:33 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 557B920040;
	Thu, 13 Nov 2025 09:06:31 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.in.ibm.com (unknown [9.109.198.209])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 13 Nov 2025 09:06:31 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-block@vger.kernel.org
Cc: ming.lei@redhat.com, hch@lst.de, axboe@kernel.dk, yi.zhang@redhat.com,
        czhong@redhat.com, yukuai@fnnas.com, gjoyce@ibm.com
Subject: [PATCHv7 4/5] block: use {alloc|free}_sched data methods
Date: Thu, 13 Nov 2025 14:28:21 +0530
Message-ID: <20251113090619.2030737-5-nilay@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDAxOCBTYWx0ZWRfX1FIKXHDSvxH+
 LgYxKItFdEE3jWaztKHiuvpUiYJ8Se3nueO3X3s7TIdibZ5aLVlCaOcKuDgNu5SNqySDTFmW/hT
 zMrxbcM4iijbeNKzHYAULy5roGgRBOTMNTvLG3086Gve8s3rvJe+jXPXCi/h55Zx8WfxJGXQRpC
 ZQmhD3TmAF0Kx9Xhl/YBdv+AEFV19i2XX0bRg+SZV3crJQugCDUK8niqoski3LRgr4DJS0W2BVs
 l3Qk64zASzJXc00hPxD9Pt3704heroPJ6FpF/sqgFvoOXaG90PQeC4nLoxQOzGEF//ibTg9pi7x
 utIPas1nhMjW3qNMJNKGLW3jE+1DbUYJiyu7EZlnI18miwCa3M6lrwqJKhJhl1oDBfYWidnKXKA
 PMQfvNmy0M/wDiTQjZXE4vuKnyxOXg==
X-Authority-Analysis: v=2.4 cv=GcEaXAXL c=1 sm=1 tr=0 ts=69159f9b cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=20KFwNOVAAAA:8 a=tJLSzyRPAAAA:8
 a=VnNF1IyMAAAA:8 a=o7TE9uVMXMOSyBzNUyAA:9 a=H0xsmVfZzgdqH4_HIfU3:22
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: bzLOvYZt7GmDUDrr8u3dAfm7iJL7Fn6m
X-Proofpoint-ORIG-GUID: bzLOvYZt7GmDUDrr8u3dAfm7iJL7Fn6m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_06,2025-11-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 bulkscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511080018

The previous patch introduced ->alloc_sched_data and
->free_sched_data methods. This patch builds upon that
by now using these methods during elevator switch and
nr_hw_queue update.

It's also ensured that scheduler-specific data is
allocated and freed through the new callbacks outside
of the ->freeze_lock and ->elevator_lock locking contexts,
thereby preventing any dependency on pcpu_alloc_mutex.

Reviewed-by: Ming Lei <ming.lei@redhat.com>
Reviewed-by: Yu Kuai <yukuai@fnnas.com>
Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 block/blk-mq-sched.c | 27 +++++++++++++++++++++------
 block/blk-mq-sched.h |  5 ++++-
 block/elevator.c     | 34 ++++++++++++++++++++++------------
 block/elevator.h     |  4 +++-
 4 files changed, 50 insertions(+), 20 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 03ff16c49976..128f2be9d420 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -428,12 +428,17 @@ void blk_mq_free_sched_tags(struct elevator_tags *et,
 }
 
 void blk_mq_free_sched_res(struct elevator_resources *res,
+		struct elevator_type *type,
 		struct blk_mq_tag_set *set)
 {
 	if (res->et) {
 		blk_mq_free_sched_tags(res->et, set);
 		res->et = NULL;
 	}
+	if (res->data) {
+		blk_mq_free_sched_data(type, res->data);
+		res->data = NULL;
+	}
 }
 
 void blk_mq_free_sched_res_batch(struct xarray *elv_tbl,
@@ -458,7 +463,7 @@ void blk_mq_free_sched_res_batch(struct xarray *elv_tbl,
 				WARN_ON_ONCE(1);
 				continue;
 			}
-			blk_mq_free_sched_res(&ctx->res, set);
+			blk_mq_free_sched_res(&ctx->res, ctx->type, set);
 		}
 	}
 }
@@ -541,7 +546,9 @@ struct elevator_tags *blk_mq_alloc_sched_tags(struct blk_mq_tag_set *set,
 }
 
 int blk_mq_alloc_sched_res(struct request_queue *q,
-		struct elevator_resources *res, unsigned int nr_hw_queues)
+		struct elevator_type *type,
+		struct elevator_resources *res,
+		unsigned int nr_hw_queues)
 {
 	struct blk_mq_tag_set *set = q->tag_set;
 
@@ -550,6 +557,12 @@ int blk_mq_alloc_sched_res(struct request_queue *q,
 	if (!res->et)
 		return -ENOMEM;
 
+	res->data = blk_mq_alloc_sched_data(q, type);
+	if (IS_ERR(res->data)) {
+		blk_mq_free_sched_tags(res->et, set);
+		return -ENOMEM;
+	}
+
 	return 0;
 }
 
@@ -577,19 +590,21 @@ int blk_mq_alloc_sched_res_batch(struct xarray *elv_tbl,
 				goto out_unwind;
 			}
 
-			ret = blk_mq_alloc_sched_res(q, &ctx->res,
-					nr_hw_queues);
+			ret = blk_mq_alloc_sched_res(q, q->elevator->type,
+					&ctx->res, nr_hw_queues);
 			if (ret)
 				goto out_unwind;
 		}
 	}
 	return 0;
+
 out_unwind:
 	list_for_each_entry_continue_reverse(q, &set->tag_list, tag_set_list) {
 		if (q->elevator) {
 			ctx = xa_load(elv_tbl, q->id);
 			if (ctx)
-				blk_mq_free_sched_res(&ctx->res, set);
+				blk_mq_free_sched_res(&ctx->res,
+						ctx->type, set);
 		}
 	}
 	return ret;
@@ -606,7 +621,7 @@ int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e,
 	unsigned long i;
 	int ret;
 
-	eq = elevator_alloc(q, e, et);
+	eq = elevator_alloc(q, e, res);
 	if (!eq)
 		return -ENOMEM;
 
diff --git a/block/blk-mq-sched.h b/block/blk-mq-sched.h
index 4e1b86e85a8a..02c40a72e959 100644
--- a/block/blk-mq-sched.h
+++ b/block/blk-mq-sched.h
@@ -26,7 +26,9 @@ void blk_mq_sched_free_rqs(struct request_queue *q);
 struct elevator_tags *blk_mq_alloc_sched_tags(struct blk_mq_tag_set *set,
 		unsigned int nr_hw_queues, unsigned int nr_requests);
 int blk_mq_alloc_sched_res(struct request_queue *q,
-		struct elevator_resources *res, unsigned int nr_hw_queues);
+		struct elevator_type *type,
+		struct elevator_resources *res,
+		unsigned int nr_hw_queues);
 int blk_mq_alloc_sched_res_batch(struct xarray *elv_tbl,
 		struct blk_mq_tag_set *set, unsigned int nr_hw_queues);
 int blk_mq_alloc_sched_ctx_batch(struct xarray *elv_tbl,
@@ -35,6 +37,7 @@ void blk_mq_free_sched_ctx_batch(struct xarray *elv_tbl);
 void blk_mq_free_sched_tags(struct elevator_tags *et,
 		struct blk_mq_tag_set *set);
 void blk_mq_free_sched_res(struct elevator_resources *res,
+		struct elevator_type *type,
 		struct blk_mq_tag_set *set);
 void blk_mq_free_sched_res_batch(struct xarray *et_table,
 		struct blk_mq_tag_set *set);
diff --git a/block/elevator.c b/block/elevator.c
index cbec292a4af5..5b37ef44f52d 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -121,7 +121,7 @@ static struct elevator_type *elevator_find_get(const char *name)
 static const struct kobj_type elv_ktype;
 
 struct elevator_queue *elevator_alloc(struct request_queue *q,
-		struct elevator_type *e, struct elevator_tags *et)
+		struct elevator_type *e, struct elevator_resources *res)
 {
 	struct elevator_queue *eq;
 
@@ -134,7 +134,8 @@ struct elevator_queue *elevator_alloc(struct request_queue *q,
 	kobject_init(&eq->kobj, &elv_ktype);
 	mutex_init(&eq->sysfs_lock);
 	hash_init(eq->hash);
-	eq->et = et;
+	eq->et = res->et;
+	eq->elevator_data = res->data;
 
 	return eq;
 }
@@ -617,7 +618,7 @@ static void elv_exit_and_release(struct elv_change_ctx *ctx,
 	mutex_unlock(&q->elevator_lock);
 	blk_mq_unfreeze_queue(q, memflags);
 	if (e) {
-		blk_mq_free_sched_res(&ctx->res, q->tag_set);
+		blk_mq_free_sched_res(&ctx->res, ctx->type, q->tag_set);
 		kobject_put(&e->kobj);
 	}
 }
@@ -628,12 +629,15 @@ static int elevator_change_done(struct request_queue *q,
 	int ret = 0;
 
 	if (ctx->old) {
-		struct elevator_resources res = {.et = ctx->old->et};
+		struct elevator_resources res = {
+			.et = ctx->old->et,
+			.data = ctx->old->elevator_data
+		};
 		bool enable_wbt = test_bit(ELEVATOR_FLAG_ENABLE_WBT_ON_EXIT,
 				&ctx->old->flags);
 
 		elv_unregister_queue(q, ctx->old);
-		blk_mq_free_sched_res(&res, q->tag_set);
+		blk_mq_free_sched_res(&res, ctx->old->type, q->tag_set);
 		kobject_put(&ctx->old->kobj);
 		if (enable_wbt)
 			wbt_enable_default(q->disk);
@@ -658,7 +662,8 @@ static int elevator_change(struct request_queue *q, struct elv_change_ctx *ctx)
 	lockdep_assert_held(&set->update_nr_hwq_lock);
 
 	if (strncmp(ctx->name, "none", 4)) {
-		ret = blk_mq_alloc_sched_res(q, &ctx->res, set->nr_hw_queues);
+		ret = blk_mq_alloc_sched_res(q, ctx->type, &ctx->res,
+				set->nr_hw_queues);
 		if (ret)
 			return ret;
 	}
@@ -681,11 +686,12 @@ static int elevator_change(struct request_queue *q, struct elv_change_ctx *ctx)
 	blk_mq_unfreeze_queue(q, memflags);
 	if (!ret)
 		ret = elevator_change_done(q, ctx);
+
 	/*
 	 * Free sched resource if it's allocated but we couldn't switch elevator.
 	 */
 	if (!ctx->new)
-		blk_mq_free_sched_res(&ctx->res, set);
+		blk_mq_free_sched_res(&ctx->res, ctx->type, set);
 
 	return ret;
 }
@@ -711,11 +717,12 @@ void elv_update_nr_hw_queues(struct request_queue *q,
 	blk_mq_unfreeze_queue_nomemrestore(q);
 	if (!ret)
 		WARN_ON_ONCE(elevator_change_done(q, ctx));
+
 	/*
 	 * Free sched resource if it's allocated but we couldn't switch elevator.
 	 */
 	if (!ctx->new)
-		blk_mq_free_sched_res(&ctx->res, set);
+		blk_mq_free_sched_res(&ctx->res, ctx->type, set);
 }
 
 /*
@@ -729,7 +736,6 @@ void elevator_set_default(struct request_queue *q)
 		.no_uevent = true,
 	};
 	int err;
-	struct elevator_type *e;
 
 	/* now we allow to switch elevator */
 	blk_queue_flag_clear(QUEUE_FLAG_NO_ELV_SWITCH, q);
@@ -742,8 +748,8 @@ void elevator_set_default(struct request_queue *q)
 	 * have multiple queues or mq-deadline is not available, default
 	 * to "none".
 	 */
-	e = elevator_find_get(ctx.name);
-	if (!e)
+	ctx.type = elevator_find_get(ctx.name);
+	if (!ctx.type)
 		return;
 
 	if ((q->nr_hw_queues == 1 ||
@@ -753,7 +759,7 @@ void elevator_set_default(struct request_queue *q)
 			pr_warn("\"%s\" elevator initialization, failed %d, falling back to \"none\"\n",
 					ctx.name, err);
 	}
-	elevator_put(e);
+	elevator_put(ctx.type);
 }
 
 void elevator_set_none(struct request_queue *q)
@@ -802,6 +808,7 @@ ssize_t elv_iosched_store(struct gendisk *disk, const char *buf,
 	ctx.name = strstrip(elevator_name);
 
 	elv_iosched_load_module(ctx.name);
+	ctx.type = elevator_find_get(ctx.name);
 
 	down_read(&set->update_nr_hwq_lock);
 	if (!blk_queue_no_elv_switch(q)) {
@@ -812,6 +819,9 @@ ssize_t elv_iosched_store(struct gendisk *disk, const char *buf,
 		ret = -ENOENT;
 	}
 	up_read(&set->update_nr_hwq_lock);
+
+	if (ctx.type)
+		elevator_put(ctx.type);
 	return ret;
 }
 
diff --git a/block/elevator.h b/block/elevator.h
index e34043f6da26..3ee1d494f48a 100644
--- a/block/elevator.h
+++ b/block/elevator.h
@@ -33,6 +33,8 @@ struct elevator_tags {
 };
 
 struct elevator_resources {
+	/* holds elevator data */
+	void *data;
 	/* holds elevator tags */
 	struct elevator_tags *et;
 };
@@ -185,7 +187,7 @@ ssize_t elv_iosched_store(struct gendisk *disk, const char *page, size_t count);
 
 extern bool elv_bio_merge_ok(struct request *, struct bio *);
 struct elevator_queue *elevator_alloc(struct request_queue *,
-		struct elevator_type *, struct elevator_tags *);
+		struct elevator_type *, struct elevator_resources *);
 
 /*
  * Helper functions.
-- 
2.51.0

