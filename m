Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4854D314A79
	for <linux-block@vger.kernel.org>; Mon, 27 Oct 2025 17:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761586633; cv=none; b=l/F+7oumPfGHktzFjWOM7Jji9DOFzAz9DwpK89F1jaWrmKHXbIcu9g+LkcwOGmZNQdXrerqlm8853GvlOGNcQpS4/U0TH+55cKRVJsxmJyFwU6avHBtmFv0g+VKW9zY0VT/nlKAY62aBsGyCj+4aSEjF2BRwv3utM5lVtTnfgck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761586633; c=relaxed/simple;
	bh=/a9cgA2wWOzMjYrvw7b4f0CCivh2KtbUHVlhM7X97yM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L9An5XnppFOE0PoQj4nZ7YlMm0rR32uMw+FaODPCr2EZUNTYWjHKVX9/zs8bRzuWmKfkb+c3OeDPycC0z1ynY2EaBTcp/CkB7DZ7NTejpLKzXmZ2TXzsujlIFOuxtBAAY4UBr3a67smmP8KhZGMQ+qu9v0BxYGAnWiSJ11vJxTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CYsTt2TB; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CYsTt2TB"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59RDLCYJ001054;
	Mon, 27 Oct 2025 17:36:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=mYQ2qSEu+abDcFtUs
	8vD4ciL99UTMIzPs0taIJZm0k8=; b=CYsTt2TBGhwYxhDnvl6Lvw/nAYONJot61
	/lebLaPS8YngKwGe3LIWLV7uzFGxhqfCgV7q9+x0O7Ys8hP/ZhnpCEfMxL2Yelvl
	zUAANcP/pfOS4aZ261E4snUlLBrw65Zo/VjJzpCQi/+M934GZ/bNwQ15LdTRbfsm
	zapPm9/o78XuaghMsSxiZzII1+K9r+4HexAFUjh+mjItiMmBNEaPc+stFbyjLwLc
	OzBbYA1VNt6nKH8AE03VYDfSHnBhzZE0Yi6kuaGk+HWbhzt/22X9cBEDTNdS1OqE
	ONQb2BSqK2twIRfenRhLktsxDsrlgWIaLLnMPhJZjYxFQVIKnJLNQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a0p9902b0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Oct 2025 17:36:57 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59RFKcVM030353;
	Mon, 27 Oct 2025 17:36:56 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4a1acjpr90-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Oct 2025 17:36:56 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59RHas2E37421550
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Oct 2025 17:36:54 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A708120040;
	Mon, 27 Oct 2025 17:36:54 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AF30E20043;
	Mon, 27 Oct 2025 17:36:50 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.61.186.32])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 27 Oct 2025 17:36:50 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-block@vger.kernel.org
Cc: ming.lei@redhat.com, hch@lst.de, yukuai1@huaweicloud.com, axboe@kernel.dk,
        yi.zhang@redhat.com, czhong@redhat.com, gjoyce@ibm.com
Subject: [PATCHv2 3/4] block: introduce alloc_sched_data and free_sched_data elevator methods
Date: Mon, 27 Oct 2025 23:05:58 +0530
Message-ID: <20251027173631.1081005-4-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251027173631.1081005-1-nilay@linux.ibm.com>
References: <20251027173631.1081005-1-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=JqL8bc4C c=1 sm=1 tr=0 ts=68ffadba cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=VnNF1IyMAAAA:8 a=LcjFNjeu-Gdkh6knpzMA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: QKVUmkViNsylgX5gYuvDsyCGE_LN7x8h
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI1MDAxOSBTYWx0ZWRfXyvm3/xX+sbr4
 vgRv6FVAMXbWCdrx9WiGkZ+EupOZYDbO7UnnxeWD5ZSiTzUoOQdL+IPC191wRyFidwrd7PyrEDA
 QH8wulEwJol9+22ZNuUhwKxf2SaAlyJNGDwblVkS7ekzpS0QvbuHJ4lCi1Wqp9QCwfowGixn3tC
 oZY/dD8UMKUnHw8jH6rQRYZRhtMU8lINB+WzORZKDQaODnmBWYqcg4VMTzpUAcfzeNvA0jUjB9V
 oP4AwMslr1nwci7Ujal7Tn+lVyq8utWYZZaeLQgF4gOSgOkAc6R+qSj+61KMb1YdN3SqZgdrTnz
 pR4cPdT0yruPfd6vwatV00PBTmTzCr0gFrDgCTXM81KABulehUwbPOpJLbrthEan60Rw6BQpNHQ
 rrSGEX58fq/0skekdC6rLZPrtCaBLw==
X-Proofpoint-ORIG-GUID: QKVUmkViNsylgX5gYuvDsyCGE_LN7x8h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-27_07,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0 bulkscore=0
 priorityscore=1501 spamscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510250019

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
 block/blk-mq-sched.c | 68 ++++++++++++++++++++++++++++++++++++++++++--
 block/blk-mq-sched.h | 23 ++++++++++++++-
 block/blk-mq.c       |  7 ++++-
 block/elevator.c     | 46 +++++++++++++++++++++++-------
 block/elevator.h     |  8 +++++-
 5 files changed, 137 insertions(+), 15 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index b35300882852..76f40acd4cee 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -464,6 +464,70 @@ void blk_mq_free_sched_ctx_batch(struct xarray *elv_tbl)
 	}
 }
 
+void blk_mq_free_sched_data_batch(struct xarray *elv_tbl,
+		struct blk_mq_tag_set *set)
+{
+	struct request_queue *q;
+	struct elv_change_ctx *ctx;
+
+	lockdep_assert_held_write(&set->update_nr_hwq_lock);
+
+	list_for_each_entry(q, &set->tag_list, tag_set_list) {
+		if (q->elevator) {
+			ctx = xa_load(elv_tbl, q->id);
+			if (WARN_ON_ONCE(!ctx))
+				continue;
+			if (ctx->res.data)
+				blk_mq_free_sched_data(q->elevator->type,
+						ctx->res.data);
+		}
+	}
+}
+
+int blk_mq_alloc_sched_data_batch(struct xarray *elv_tbl,
+		struct blk_mq_tag_set *set)
+{
+	struct request_queue *q;
+	struct elv_change_ctx *ctx;
+	int ret = 0;
+
+	lockdep_assert_held_write(&set->update_nr_hwq_lock);
+
+	list_for_each_entry(q, &set->tag_list, tag_set_list) {
+		/*
+		 * Accessing q->elevator without holding q->elevator_lock is
+		 * safe because we're holding here set->update_nr_hwq_lock in
+		 * the writer context. So, scheduler update/switch code (which
+		 * acquires the same lock but in the reader context) can't run
+		 * concurrently.
+		 */
+		if (q->elevator) {
+			ctx = xa_load(elv_tbl, q->id);
+			if (WARN_ON_ONCE(!ctx))
+				return -ENOENT;
+
+			ret = blk_mq_alloc_sched_data(q, q->elevator->type,
+					&ctx->res.data);
+			if (ret)
+				goto out_unwind;
+		}
+	}
+	return ret;
+
+out_unwind:
+	list_for_each_entry_continue_reverse(q, &set->tag_list, tag_set_list) {
+		if (q->elevator) {
+			ctx = xa_load(elv_tbl, q->id);
+			if (WARN_ON_ONCE(!ctx))
+				continue;
+			if (ctx->res.data)
+				blk_mq_free_sched_data(q->elevator->type,
+						ctx->res.data);
+		}
+	}
+	return ret;
+}
+
 int blk_mq_alloc_sched_ctx_batch(struct xarray *elv_tbl,
 		struct blk_mq_tag_set *set)
 {
@@ -580,7 +644,7 @@ int blk_mq_alloc_sched_tags_batch(struct xarray *elv_tbl,
 
 /* caller must have a reference to @e, will grab another one if successful */
 int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e,
-		struct elevator_tags *et)
+		struct elevator_tags *et, void *data)
 {
 	unsigned int flags = q->tag_set->flags;
 	struct blk_mq_hw_ctx *hctx;
@@ -588,7 +652,7 @@ int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e,
 	unsigned long i;
 	int ret;
 
-	eq = elevator_alloc(q, e, et);
+	eq = elevator_alloc(q, e, et, data);
 	if (!eq)
 		return -ENOMEM;
 
diff --git a/block/blk-mq-sched.h b/block/blk-mq-sched.h
index 2fddbc91a235..efbab73164e9 100644
--- a/block/blk-mq-sched.h
+++ b/block/blk-mq-sched.h
@@ -19,7 +19,7 @@ void __blk_mq_sched_restart(struct blk_mq_hw_ctx *hctx);
 void blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx);
 
 int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e,
-		struct elevator_tags *et);
+		struct elevator_tags *et, void *data);
 void blk_mq_exit_sched(struct request_queue *q, struct elevator_queue *e);
 void blk_mq_sched_free_rqs(struct request_queue *q);
 
@@ -29,11 +29,32 @@ int blk_mq_alloc_sched_tags_batch(struct xarray *et_table,
 		struct blk_mq_tag_set *set, unsigned int nr_hw_queues);
 int blk_mq_alloc_sched_ctx_batch(struct xarray *elv_tbl,
 		struct blk_mq_tag_set *set);
+int blk_mq_alloc_sched_data_batch(struct xarray *elv_tbl,
+		struct blk_mq_tag_set *set);
 void blk_mq_free_sched_ctx_batch(struct xarray *elv_tbl);
 void blk_mq_free_sched_tags(struct elevator_tags *et,
 		struct blk_mq_tag_set *set);
 void blk_mq_free_sched_tags_batch(struct xarray *et_table,
 		struct blk_mq_tag_set *set);
+void blk_mq_free_sched_data_batch(struct xarray *elv_tbl,
+		struct blk_mq_tag_set *set);
+
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
 
 static inline void blk_mq_sched_restart(struct blk_mq_hw_ctx *hctx)
 {
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 1f5ef7fc9cda..f6045dfa48d9 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -5066,9 +5066,14 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 	if (blk_mq_alloc_sched_ctx_batch(&elv_tbl, set) < 0)
 		goto out_free_ctx;
 
-	if (blk_mq_alloc_sched_tags_batch(&elv_tbl, set, nr_hw_queues) < 0)
+	if (blk_mq_alloc_sched_data_batch(&elv_tbl, set) < 0)
 		goto out_free_ctx;
 
+	if (blk_mq_alloc_sched_tags_batch(&elv_tbl, set, nr_hw_queues) < 0) {
+		blk_mq_free_sched_data_batch(&elv_tbl, set);
+		goto out_free_ctx;
+	}
+
 	list_for_each_entry(q, &set->tag_list, tag_set_list) {
 		blk_mq_debugfs_unregister_hctxs(q);
 		blk_mq_sysfs_unregister_hctxs(q);
diff --git a/block/elevator.c b/block/elevator.c
index 51bf688b5c4e..66fd2fc4fa91 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -121,7 +121,9 @@ static struct elevator_type *elevator_find_get(const char *name)
 static const struct kobj_type elv_ktype;
 
 struct elevator_queue *elevator_alloc(struct request_queue *q,
-		struct elevator_type *e, struct elevator_tags *et)
+			struct elevator_type *e,
+			struct elevator_tags *et,
+			void *data)
 {
 	struct elevator_queue *eq;
 
@@ -135,6 +137,7 @@ struct elevator_queue *elevator_alloc(struct request_queue *q,
 	mutex_init(&eq->sysfs_lock);
 	hash_init(eq->hash);
 	eq->et = et;
+	eq->elevator_data = data;
 
 	return eq;
 }
@@ -580,7 +583,7 @@ static int elevator_switch(struct request_queue *q, struct elv_change_ctx *ctx)
 	}
 
 	if (new_e) {
-		ret = blk_mq_init_sched(q, new_e, ctx->res.et);
+		ret = blk_mq_init_sched(q, new_e, ctx->res.et, ctx->res.data);
 		if (ret)
 			goto out_unfreeze;
 		ctx->new = q->elevator;
@@ -617,6 +620,7 @@ static void elv_exit_and_release(struct request_queue *q)
 	blk_mq_unfreeze_queue(q, memflags);
 	if (e) {
 		blk_mq_free_sched_tags(e->et, q->tag_set);
+		blk_mq_free_sched_data(e->type, e->elevator_data);
 		kobject_put(&e->kobj);
 	}
 }
@@ -632,6 +636,7 @@ static int elevator_change_done(struct request_queue *q,
 
 		elv_unregister_queue(q, ctx->old);
 		blk_mq_free_sched_tags(ctx->old->et, q->tag_set);
+		blk_mq_free_sched_data(ctx->old->type, ctx->old->elevator_data);
 		kobject_put(&ctx->old->kobj);
 		if (enable_wbt)
 			wbt_enable_default(q->disk);
@@ -660,6 +665,10 @@ static int elevator_change(struct request_queue *q, struct elv_change_ctx *ctx)
 				blk_mq_default_nr_requests(set));
 		if (!ctx->res.et)
 			return -ENOMEM;
+
+		ret = blk_mq_alloc_sched_data(q, ctx->type, &ctx->res.data);
+		if (ret)
+			goto free_sched_tags;
 	}
 
 	memflags = blk_mq_freeze_queue(q);
@@ -680,10 +689,18 @@ static int elevator_change(struct request_queue *q, struct elv_change_ctx *ctx)
 	blk_mq_unfreeze_queue(q, memflags);
 	if (!ret)
 		ret = elevator_change_done(q, ctx);
+
+	if (ctx->new) /* switching to new elevator is successful */
+		return ret;
+
 	/*
-	 * Free sched tags if it's allocated but we couldn't switch elevator.
+	 * Free sched tags and data if those were allocated but we couldn't
+	 * switch elevator.
 	 */
-	if (ctx->res.et && !ctx->new)
+	if (ctx->res.data)
+		blk_mq_free_sched_data(ctx->type, ctx->res.data);
+free_sched_tags:
+	if (ctx->res.et)
 		blk_mq_free_sched_tags(ctx->res.et, set);
 
 	return ret;
@@ -710,11 +727,17 @@ void elv_update_nr_hw_queues(struct request_queue *q,
 	blk_mq_unfreeze_queue_nomemrestore(q);
 	if (!ret)
 		WARN_ON_ONCE(elevator_change_done(q, ctx));
+
+	if (ctx->new) /* switching to new elevator is successful */
+		return;
 	/*
-	 * Free sched tags if it's allocated but we couldn't switch elevator.
+	 * Free sched tags and data if it's allocated but we couldn't switch
+	 * elevator.
 	 */
-	if (ctx->res.et && !ctx->new)
+	if (ctx->res.et)
 		blk_mq_free_sched_tags(ctx->res.et, set);
+	if (ctx->res.data)
+		blk_mq_free_sched_data(ctx->type, ctx->res.data);
 }
 
 /*
@@ -728,7 +751,6 @@ void elevator_set_default(struct request_queue *q)
 		.no_uevent = true,
 	};
 	int err;
-	struct elevator_type *e;
 
 	/* now we allow to switch elevator */
 	blk_queue_flag_clear(QUEUE_FLAG_NO_ELV_SWITCH, q);
@@ -741,8 +763,8 @@ void elevator_set_default(struct request_queue *q)
 	 * have multiple queues or mq-deadline is not available, default
 	 * to "none".
 	 */
-	e = elevator_find_get(ctx.name);
-	if (!e)
+	ctx.type = elevator_find_get(ctx.name);
+	if (!ctx.type)
 		return;
 
 	if ((q->nr_hw_queues == 1 ||
@@ -752,7 +774,7 @@ void elevator_set_default(struct request_queue *q)
 			pr_warn("\"%s\" elevator initialization, failed %d, falling back to \"none\"\n",
 					ctx.name, err);
 	}
-	elevator_put(e);
+	elevator_put(ctx.type);
 }
 
 void elevator_set_none(struct request_queue *q)
@@ -801,6 +823,7 @@ ssize_t elv_iosched_store(struct gendisk *disk, const char *buf,
 	ctx.name = strstrip(elevator_name);
 
 	elv_iosched_load_module(ctx.name);
+	ctx.type = elevator_find_get(ctx.name);
 
 	down_read(&set->update_nr_hwq_lock);
 	if (!blk_queue_no_elv_switch(q)) {
@@ -811,6 +834,9 @@ ssize_t elv_iosched_store(struct gendisk *disk, const char *buf,
 		ret = -ENOENT;
 	}
 	up_read(&set->update_nr_hwq_lock);
+
+	if (ctx.type)
+		elevator_put(ctx.type);
 	return ret;
 }
 
diff --git a/block/elevator.h b/block/elevator.h
index 621a63597249..1707e22bf6d0 100644
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
@@ -183,7 +187,9 @@ ssize_t elv_iosched_store(struct gendisk *disk, const char *page, size_t count);
 
 extern bool elv_bio_merge_ok(struct request *, struct bio *);
 struct elevator_queue *elevator_alloc(struct request_queue *,
-		struct elevator_type *, struct elevator_tags *);
+			struct elevator_type *,
+			struct elevator_tags *,
+			void *);
 
 /*
  * Helper functions.
-- 
2.51.0

