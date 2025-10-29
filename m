Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D3F32C938
	for <linux-block@vger.kernel.org>; Wed, 29 Oct 2025 10:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761734223; cv=none; b=Q07p6uzHCray1Dc6tafnWCLCWRauhvKC4RWJNliBU00P5cpdXM/uBSPL8XakExtw9uJRLpbEizwFvipRWosHIrSpqQMktUKl78n9b1zcQOHM6S0oA55sCraMEQhBrDvZbksIN7rvrN6feDot6P4ojo8fsmniPd6ZOexuPWrtmco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761734223; c=relaxed/simple;
	bh=bBL3jG8uRd/kVFFuA1ePPN070INkjfrs5gMTAIGyd6A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P/NJE9dgxTxsX4fHn7Pc4pfcwdI6LATrF4LdNCEe021K85sDPACyRB1j5fLa1Wz4qZJd1NyWVpC/+TW+3V/G0s/b06InzzVLBJLjwqCpRYgxbENc4dYxnjiczJfZxx5i0gxJylEsOEq/LZMZwEh6GZoyGwV9taMPMz6uNPoNsng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QFo+uNTV; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QFo+uNTV"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59SJlmDT003305;
	Wed, 29 Oct 2025 10:36:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=uyjK4IR1smuzMSJNz
	r2+S98mPwEaVFRVJk9QygzRS38=; b=QFo+uNTVK05yTxNEwNW1gPgXb9RwGk1Fw
	7Zw46jPmeIXDzeSVU+ZxIiHSG2ggNLp+AxHTPA5XoYmbeDVyN+iDmRPyGnpDIVvy
	j+9v4lfBIOkbwHWblYk9iNY5onPH3tjXbmKTqCTpOtBNA9NZeTZvHpELrXIAvLek
	KwedHUq8CxTFy9lpRpeW6MbTn0yGfPymGraChHLXc8+lFCE/BZ1zr5gcrOU4dpcT
	gjB9XBDzjU4qnD553FMF1Su/rypaA3PmkrK1UFJ0ibeXQoMMEvIcvXDxEAqVVJYf
	gvrF5R9U6ginDkIMjKhsG0GTA5Gt5+iZSWXByrqNA4sjsLqlC3RzA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a34a8jshv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Oct 2025 10:36:54 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59T9kF9f023869;
	Wed, 29 Oct 2025 10:36:53 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4a33vx2vn2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Oct 2025 10:36:53 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59TAapUL25166518
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Oct 2025 10:36:51 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8210620043;
	Wed, 29 Oct 2025 10:36:51 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5676920040;
	Wed, 29 Oct 2025 10:36:46 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.61.159.127])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 29 Oct 2025 10:36:45 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-block@vger.kernel.org
Cc: ming.lei@redhat.com, hch@lst.de, axboe@kernel.dk, yi.zhang@redhat.com,
        czhong@redhat.com, gjoyce@ibm.com
Subject: [PATCHv3 3/4] block: introduce alloc_sched_data and free_sched_data elevator methods
Date: Wed, 29 Oct 2025 16:06:16 +0530
Message-ID: <20251029103622.205607-4-nilay@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=DYkaa/tW c=1 sm=1 tr=0 ts=6901ee46 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=VnNF1IyMAAAA:8 a=BHJ_uGNgmAg05V-1cPgA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: j2Lxh15U_WDSBlHs8olUkan_KbxfARMp
X-Proofpoint-ORIG-GUID: j2Lxh15U_WDSBlHs8olUkan_KbxfARMp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDE2NiBTYWx0ZWRfX1HpWTzJlprX2
 F4Y3lKPop8L2Nr+LxWsxAxfctlPZ70YynT+QLMNkMIeuHCKMpVOrJabTVY7GtRIkX5jfsVZeCix
 ta08gR10ZRxYaUN11tTUyRGdhhhLbBySSZ8r/oXlzMTLAvGtXOY7XRac0vBQoseTadE3NYv8BMH
 Z8igmXPZevz8lSyF54bQHqkInxQzgw0K0lJ93GiHmwxy6khrs6CKubjQqJYgm0rJWoPxcbdsrjA
 uFIaVeVCl1Pf3ba0CDhlqVl6HS8VBTeb6k6Va0vKWHISi7mQilbhTUCTM6rhsuCGZBU+KQdSFf1
 9cLTg8O20gGkN8KqKK6wyooDBe7ww5tNIJuzuhKwQYDlQYdSZQ0TYPr/v4PaA6sZaZjiZyp0Al5
 0Pl17Q1EXy3vLeoDd2XllZNSGSaD2w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-29_04,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 malwarescore=0 bulkscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2510280166

The recent lockdep splat [1] highlights a potential deadlock risk
involving ->elevator_lock and ->freeze_lock dependencies on -pcpu_alloc_
mutex. The trace shows that the issue occurs when the Kyber scheduler
allocates dynamic memory for its elevator data during initialization.

To address this, introduce two new elevator operation callbacks:
->alloc_sched_data and ->free_sched_data.

When an elevator implements these methods, they are invoked during
scheduler switch before acquiring ->freeze_lock and ->elevator_lock.
This allows safe allocation and deallocation of per-elevator data
without holding locks that could depend on pcpu_alloc_mutex, effectively
breaking the lock dependency chain and avoiding the reported deadlock
scenario.

[1] https://lore.kernel.org/all/CAGVVp+VNW4M-5DZMNoADp6o2VKFhi7KxWpTDkcnVyjO0=-D5+A@mail.gmail.com/

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 block/blk-mq-sched.c | 30 +++++++++++++++++++++++-------
 block/blk-mq-sched.h | 25 +++++++++++++++++++++++--
 block/elevator.c     | 35 +++++++++++++++++++++++++----------
 block/elevator.h     |  4 ++++
 4 files changed, 75 insertions(+), 19 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 6db45b0819e6..4376d0ddbd1e 100644
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
@@ -540,15 +545,24 @@ struct elevator_tags *blk_mq_alloc_sched_tags(struct blk_mq_tag_set *set,
 	return NULL;
 }
 
-int blk_mq_alloc_sched_res(struct elevator_resources *res,
-		struct blk_mq_tag_set *set, unsigned int nr_hw_queues)
+int blk_mq_alloc_sched_res(struct request_queue *q,
+		struct elevator_type *type,
+		struct elevator_resources *res,
+		struct blk_mq_tag_set *set,
+		unsigned int nr_hw_queues)
 {
+	int ret;
+
 	res->et = blk_mq_alloc_sched_tags(set, nr_hw_queues,
 			blk_mq_default_nr_requests(set));
 	if (!res->et)
 		return -ENOMEM;
 
-	return 0;
+	ret = blk_mq_alloc_sched_data(q, type, &res->data);
+	if (ret)
+		kfree(res->et);
+
+	return ret;
 }
 
 int blk_mq_alloc_sched_res_batch(struct xarray *elv_tbl,
@@ -575,19 +589,21 @@ int blk_mq_alloc_sched_res_batch(struct xarray *elv_tbl,
 				goto out_unwind;
 			}
 
-			ret = blk_mq_alloc_sched_res(&ctx->res, set,
-					nr_hw_queues);
+			ret = blk_mq_alloc_sched_res(q, q->elevator->type,
+					&ctx->res, set, nr_hw_queues);
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
diff --git a/block/blk-mq-sched.h b/block/blk-mq-sched.h
index 97204df76def..acd4f1355be6 100644
--- a/block/blk-mq-sched.h
+++ b/block/blk-mq-sched.h
@@ -25,8 +25,11 @@ void blk_mq_sched_free_rqs(struct request_queue *q);
 
 struct elevator_tags *blk_mq_alloc_sched_tags(struct blk_mq_tag_set *set,
 		unsigned int nr_hw_queues, unsigned int nr_requests);
-int blk_mq_alloc_sched_res(struct elevator_resources *res,
-		struct blk_mq_tag_set *set, unsigned int nr_hw_queues);
+int blk_mq_alloc_sched_res(struct request_queue *q,
+		struct elevator_type *type,
+		struct elevator_resources *res,
+		struct blk_mq_tag_set *set,
+		unsigned int nr_hw_queues);
 int blk_mq_alloc_sched_res_batch(struct xarray *elv_tbl,
 		struct blk_mq_tag_set *set, unsigned int nr_hw_queues);
 int blk_mq_alloc_sched_ctx_batch(struct xarray *elv_tbl,
@@ -35,10 +38,28 @@ void blk_mq_free_sched_ctx_batch(struct xarray *elv_tbl);
 void blk_mq_free_sched_tags(struct elevator_tags *et,
 		struct blk_mq_tag_set *set);
 void blk_mq_free_sched_res(struct elevator_resources *res,
+		struct elevator_type *type,
 		struct blk_mq_tag_set *set);
 void blk_mq_free_sched_res_batch(struct xarray *et_table,
 		struct blk_mq_tag_set *set);
 
+static inline int blk_mq_alloc_sched_data(struct request_queue *q,
+		struct elevator_type *e, void **data)
+{
+	if (e && e->ops.alloc_sched_data) {
+		*data = e->ops.alloc_sched_data(q);
+		if (!*data)
+			return -ENOMEM;
+	}
+	return 0;
+}
+
+static inline void blk_mq_free_sched_data(struct elevator_type *e, void *data)
+{
+	if (e && e->ops.free_sched_data)
+		e->ops.free_sched_data(data);
+}
+
 static inline void blk_mq_sched_restart(struct blk_mq_hw_ctx *hctx)
 {
 	if (test_bit(BLK_MQ_S_SCHED_RESTART, &hctx->state))
diff --git a/block/elevator.c b/block/elevator.c
index d5d89b202fda..8696b2a741b7 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -135,6 +135,7 @@ struct elevator_queue *elevator_alloc(struct request_queue *q,
 	mutex_init(&eq->sysfs_lock);
 	hash_init(eq->hash);
 	eq->et = res->et;
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
-		ret = blk_mq_alloc_sched_res(&ctx->res, set, set->nr_hw_queues);
+		ret = blk_mq_alloc_sched_res(q, ctx->type, &ctx->res, set,
+				set->nr_hw_queues);
 		if (ret)
 			return ret;
 	}
@@ -681,11 +686,15 @@ static int elevator_change(struct request_queue *q, struct elv_change_ctx *ctx)
 	blk_mq_unfreeze_queue(q, memflags);
 	if (!ret)
 		ret = elevator_change_done(q, ctx);
+
+	if (ctx->new) /* switching to new elevator is successful */
+		return ret;
+
 	/*
 	 * Free sched resource if it's allocated but we couldn't switch elevator.
 	 */
 	if (!ctx->new)
-		blk_mq_free_sched_res(&ctx->res, set);
+		blk_mq_free_sched_res(&ctx->res, ctx->type, set);
 
 	return ret;
 }
@@ -711,11 +720,14 @@ void elv_update_nr_hw_queues(struct request_queue *q,
 	blk_mq_unfreeze_queue_nomemrestore(q);
 	if (!ret)
 		WARN_ON_ONCE(elevator_change_done(q, ctx));
+
+	if (ctx->new) /* switching to new elevator is successful */
+		return;
 	/*
 	 * Free sched resource if it's allocated but we couldn't switch elevator.
 	 */
 	if (!ctx->new)
-		blk_mq_free_sched_res(&ctx->res, set);
+		blk_mq_free_sched_res(&ctx->res, ctx->type, set);
 }
 
 /*
@@ -729,7 +741,6 @@ void elevator_set_default(struct request_queue *q)
 		.no_uevent = true,
 	};
 	int err;
-	struct elevator_type *e;
 
 	/* now we allow to switch elevator */
 	blk_queue_flag_clear(QUEUE_FLAG_NO_ELV_SWITCH, q);
@@ -742,8 +753,8 @@ void elevator_set_default(struct request_queue *q)
 	 * have multiple queues or mq-deadline is not available, default
 	 * to "none".
 	 */
-	e = elevator_find_get(ctx.name);
-	if (!e)
+	ctx.type = elevator_find_get(ctx.name);
+	if (!ctx.type)
 		return;
 
 	if ((q->nr_hw_queues == 1 ||
@@ -753,7 +764,7 @@ void elevator_set_default(struct request_queue *q)
 			pr_warn("\"%s\" elevator initialization, failed %d, falling back to \"none\"\n",
 					ctx.name, err);
 	}
-	elevator_put(e);
+	elevator_put(ctx.type);
 }
 
 void elevator_set_none(struct request_queue *q)
@@ -802,6 +813,7 @@ ssize_t elv_iosched_store(struct gendisk *disk, const char *buf,
 	ctx.name = strstrip(elevator_name);
 
 	elv_iosched_load_module(ctx.name);
+	ctx.type = elevator_find_get(ctx.name);
 
 	down_read(&set->update_nr_hwq_lock);
 	if (!blk_queue_no_elv_switch(q)) {
@@ -812,6 +824,9 @@ ssize_t elv_iosched_store(struct gendisk *disk, const char *buf,
 		ret = -ENOENT;
 	}
 	up_read(&set->update_nr_hwq_lock);
+
+	if (ctx.type)
+		elevator_put(ctx.type);
 	return ret;
 }
 
diff --git a/block/elevator.h b/block/elevator.h
index 6533f74ad5ef..3ee1d494f48a 100644
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
@@ -58,6 +60,8 @@ struct elevator_mq_ops {
 	int (*init_hctx)(struct blk_mq_hw_ctx *, unsigned int);
 	void (*exit_hctx)(struct blk_mq_hw_ctx *, unsigned int);
 	void (*depth_updated)(struct request_queue *);
+	void *(*alloc_sched_data)(struct request_queue *);
+	void (*free_sched_data)(void *);
 
 	bool (*allow_merge)(struct request_queue *, struct request *, struct bio *);
 	bool (*bio_merge)(struct request_queue *, struct bio *, unsigned int);
-- 
2.51.0

