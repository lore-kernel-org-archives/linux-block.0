Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB4D1E492D
	for <linux-block@vger.kernel.org>; Mon, 10 Nov 2025 08:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762762542; cv=none; b=n2BI26bG9ohobo0G21npLSqN6IoDqZPDRlakKxbovCaejSEACJi1Z3MKz4CAfNpnUDCFU6ULfG+iNWPpYqjdHupxjQMcIMCjrxKZXKLo5B+hAdQP19GX9QPCM1Gsd/EwsIgdfzAgC3SynLOmQf3RGhi4p41191zvLwUcgpIipE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762762542; c=relaxed/simple;
	bh=EB68nTn49IclqUIoy5cUu43IB3Zi67orMQO7viV0y30=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eEsW2mxnfl4c3sdtklhFFDNUIagU082KdvzGBJodj/oMKJkTIyUEfiEpBMsS8KoEmRXaa1UvgeemFC4gBpJG1RxeabFw2VNCwFwrRTLj9UZlTVkneTiSjobN0m66fSrSKIIolaqrTA22KiwOT6toQQsEYwDyWP4LMcafshhx0/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SIh5EDUr; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SIh5EDUr"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A9MiHpi019248;
	Mon, 10 Nov 2025 08:15:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=hzyLIDpEU237YrW6m
	u0z/yI7P9Nuayy1I0OaCOxC8Us=; b=SIh5EDUrxXQKeU1OU1SaNgI3N6Pm2FKoK
	g8KLCh756Ux6zc72iiSAYMBl4FGdIhNmk16heG6nOqNuXwitCQRQbKSeA0pROIZL
	x9ZHtFx2Py4xp/9kcYCD4xlGoSj/b1Wlc5n8UV9yAlarYzTIFUTwRabeQ6OR4xRa
	sCqA91OVI061aiz91dfXhBkcv29DDVwYg+9dAXqSw/OvF6ACepk8BPGyP3gVrlMq
	30vkLUj3FchRF0RvfAuTXDbICbFGkijX2DmbF0cdVAZZuqvGxPstG+eHIScFK9zq
	c1D3kao68OKKGCscck7wXookKBJH4yP8mpmR3HnJ+46ACWvTK2khA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a9wgwp570-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Nov 2025 08:15:26 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AA4oVjJ008197;
	Mon, 10 Nov 2025 08:15:26 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4aah6mmka8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Nov 2025 08:15:25 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5AA8FNLa47645180
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Nov 2025 08:15:24 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DB7432004B;
	Mon, 10 Nov 2025 08:15:23 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 14D8920040;
	Mon, 10 Nov 2025 08:15:20 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.61.93.35])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 10 Nov 2025 08:15:19 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-block@vger.kernel.org
Cc: ming.lei@redhat.com, hch@lst.de, axboe@kernel.dk, yi.zhang@redhat.com,
        czhong@redhat.com, yukuai@fnnas.com, gjoyce@ibm.com
Subject: [PATCHv4 4/5] block: use {alloc|free}_sched data methods
Date: Mon, 10 Nov 2025 13:44:51 +0530
Message-ID: <20251110081457.1006206-5-nilay@linux.ibm.com>
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
X-Proofpoint-GUID: q7xYj2kv5_XTwLS9JsgLl95FEDJwhm0z
X-Proofpoint-ORIG-GUID: q7xYj2kv5_XTwLS9JsgLl95FEDJwhm0z
X-Authority-Analysis: v=2.4 cv=VMPQXtPX c=1 sm=1 tr=0 ts=69119f1e cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=BHJ_uGNgmAg05V-1cPgA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDAyMiBTYWx0ZWRfX1BUCtXiIyQd1
 c/8mWehpZYHczSJi+5ShuGpIpplg1exEXPvAalmu/DjLXuBnvWUoGKPnQp/6knS+pCuH8jnfMGS
 OJOGS3ZfnoWU5ysAPprFAPoOUKipaUAEk0TK9KjOWDcyiTPxsbOaFHWYGdrognP8colpc5QUrkd
 xG6EZBJh86dWCaZuThMV4CqR5GO3eBTuchoEC50Cxv6hXiXH0JsD8HvF48WkqPkD+hkBdRCMNzx
 9hK3D4nJPFctxWe1o9nLl080xNS7cm9xYo4qxyaHgnT0CuP1ug5dTGlazxZHsPvmz1VXKpCN9dv
 dkQZpvDQvYcM27pNXpJPC3XdHzKQ/zNmTNFPtUqB4Jy1TQNneIxIvrEl7gICqJLo2vbcacOv/n8
 P43fWZeQ34NIIOqPPOrJdGkI3TYNWQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_03,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 clxscore=1015 phishscore=0 spamscore=0 malwarescore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511080022

The previous patch introduced ->alloc_sched_data and
->free_sched_data methods. This patch builds upon that
by now using these methods during elevator switch and
nr_hw_queue update.

It's also ensured that scheduler-specific data is
allocated and freed through the new callbacks outside
of the ->freeze_lock and ->elevator_lock locking contexts,
thereby preventing any dependency on pcpu_alloc_mutex.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 block/blk-mq-sched.c | 32 ++++++++++++++++++++++++--------
 block/blk-mq-sched.h |  8 ++++++--
 block/elevator.c     | 34 ++++++++++++++++++++++------------
 block/elevator.h     |  4 +++-
 4 files changed, 55 insertions(+), 23 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index c7091ea4dccd..0ea8f0004274 100644
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
+		blk_mq_free_sched_tags(res->et, set);
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
@@ -603,7 +619,7 @@ int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e,
 	unsigned long i;
 	int ret;
 
-	eq = elevator_alloc(q, e, res->et);
+	eq = elevator_alloc(q, e, res);
 	if (!eq)
 		return -ENOMEM;
 
diff --git a/block/blk-mq-sched.h b/block/blk-mq-sched.h
index d38911d0d9eb..acd4f1355be6 100644
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
@@ -35,6 +38,7 @@ void blk_mq_free_sched_ctx_batch(struct xarray *elv_tbl);
 void blk_mq_free_sched_tags(struct elevator_tags *et,
 		struct blk_mq_tag_set *set);
 void blk_mq_free_sched_res(struct elevator_resources *res,
+		struct elevator_type *type,
 		struct blk_mq_tag_set *set);
 void blk_mq_free_sched_res_batch(struct xarray *et_table,
 		struct blk_mq_tag_set *set);
diff --git a/block/elevator.c b/block/elevator.c
index 7fd3c547833c..67500fbbfaf0 100644
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
-		ret = blk_mq_alloc_sched_res(&ctx->res, set, set->nr_hw_queues);
+		ret = blk_mq_alloc_sched_res(q, ctx->type, &ctx->res, set,
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

