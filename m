Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A3128A410
	for <linux-block@vger.kernel.org>; Tue, 24 Jun 2025 13:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750771055; cv=none; b=WF8ORYfl8p//0xSIBLYeNmTlHQjMhw9bKES8PnWi7NwVp6DeFMl3hNUon10Iul5z5sf1kYeCNlFXH7D9xXDClxGZDpSYntQXqmn21eFC+pwf4nX7irrv+D5S7c/06DDSTVOWXGupyo6ekxtLoPrR2e7EyoAn6YrPHXD6KwBJelI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750771055; c=relaxed/simple;
	bh=+r6jsumyIi3lEGrARa3WhXXev1qRuj/8zb5N69RMLVg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HpClszNupm990DmeVZ2W+bdRUGqnjcBX1QjVocbhVI9EYMwS5StlanfqUuO7HL2FAVHqxXmwllchhQ/c9lqmavCVBLfv7ZhDX4+xmi4LrcnUnjvgEhHNBkNBBroJem4InklAb/Yzco8oayYHQS7GaAfdTibng6dzJBwEFPo+c8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SqXPJtc7; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SqXPJtc7"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55OCkTIE030633;
	Tue, 24 Jun 2025 13:17:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Gt9tLP/hNZm+nvJ3r
	+s1t1GIlbhjy59GWxJYO5dEG+g=; b=SqXPJtc7mYO9uUyrLWIon9MbyxHtUlQ5b
	H5p8i1WR+4iLgrWP5/N/Ca8SJ1kpPwlDrf2Ay5KhOla2ekCmakdxaVlEzGx8bec9
	kSjqGauFD0yf+hb4XcINEovD9Wh2JE4lGXqyDl+SOApuWx6RsuqQwPmtnpuAa2Di
	3twOtCh1UAJT3PjaM+03T7N8BEZY7Yj35C9AGUMwWotvfUxJF4ciRSPKrOONc3e7
	MZK6OVH9X9L+TT4/36JO/esgCFTuFySCCZLww5qVu1FE2NldoOOfWcQL1LrzkDSE
	vPWLcH7XvkPvmQz+1x72IOGg5X9Y5wAus5I1SHWAZRwVBSNxS+DkA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dmfe8vya-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Jun 2025 13:17:26 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55OBSacZ014769;
	Tue, 24 Jun 2025 13:17:22 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 47e9s2btbd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Jun 2025 13:17:22 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55ODHKJo46989792
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Jun 2025 13:17:20 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7EC9D20040;
	Tue, 24 Jun 2025 13:17:20 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 079212004B;
	Tue, 24 Jun 2025 13:17:19 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.in.ibm.com (unknown [9.109.198.209])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 24 Jun 2025 13:17:18 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-block@vger.kernel.org
Cc: hch@lst.de, ming.lei@redhat.com, axboe@kernel.dk, sth@linux.ibm.com,
        gjoyce@ibm.com
Subject: [PATCHv4 1/3] block: move elevator queue allocation logic into blk_mq_init_sched
Date: Tue, 24 Jun 2025 18:47:03 +0530
Message-ID: <20250624131716.630465-2-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250624131716.630465-1-nilay@linux.ibm.com>
References: <20250624131716.630465-1-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: CFtVGYo3GYyBUBi1cPmNQODY0rzNuDIa
X-Proofpoint-GUID: CFtVGYo3GYyBUBi1cPmNQODY0rzNuDIa
X-Authority-Analysis: v=2.4 cv=BpqdwZX5 c=1 sm=1 tr=0 ts=685aa566 cx=c_pps a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17 a=6IFa9wvqVegA:10 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=eVjI13sIsFB_z2tHqD4A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI0MDExMiBTYWx0ZWRfXyVMyx0WxfA3M X7jx9xhNGpEw8b+Z0tNRRfVcwNWyGEdAoGHH7N9wvdCnN/u+Ct7dqP3fDh0e8XyHF+lpa2EbqQP A8FlZsqdi0YHXgcGMqB0krrtvGP68iVqfGUO4Ya6LIudm35TA903h93RPQA/CIl1KqBraIUBCDs
 Jvtma0DyaN+9hZ9h6dKitR7e3VlWhP0QnH+cN4Ae0kyBe80EUUCXJWKB9NoySCvGRSPKzLezl8b R3IBTLr5Lm+NOQ52B9Zh1qNGD/bGUIu+nq1a/FW2lN3GFjKgmFDT0A+tZEsRAghJzYWly4VdzrJ jyz8EKNSBiY0IN30OoTPp/U7GZaiWPlhFpn7jk5+WdVxorh8VNYQ5NiO8ASgHoT7aKUFsFj/Bfd
 7tYvbsPsoBHMO5XJEPqHDHv/b/bzhK2NEk+3ILaZyq+Vn7PfLOC/0f+DhTHyTbvD3PqL2OK7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-24_05,2025-06-23_07,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 impostorscore=0 clxscore=1015 spamscore=0 mlxlogscore=999
 priorityscore=1501 phishscore=0 malwarescore=0 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506240112

In preparation for allocating sched_tags before freezing the request
queue and acquiring ->elevator_lock, move the elevator queue allocation
logic from the elevator ops ->init_sched callback into blk_mq_init_sched.
As elevator_alloc is now only invoked from block layer core, we don't
need to export it, so unexport elevator_alloc function.

This refactoring provides a centralized location for elevator queue
initialization, which makes it easier to store pre-allocated sched_tags
in the struct elevator_queue during later changes.

Reviewed-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 block/bfq-iosched.c   | 13 +++----------
 block/blk-mq-sched.c  | 11 ++++++++---
 block/elevator.c      |  1 -
 block/elevator.h      |  2 +-
 block/kyber-iosched.c | 11 ++---------
 block/mq-deadline.c   | 14 ++------------
 6 files changed, 16 insertions(+), 36 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 0cb1e9873aab..fd26dc1901b0 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -7232,22 +7232,16 @@ static void bfq_init_root_group(struct bfq_group *root_group,
 	root_group->sched_data.bfq_class_idle_last_service = jiffies;
 }
 
-static int bfq_init_queue(struct request_queue *q, struct elevator_type *e)
+static int bfq_init_queue(struct request_queue *q, struct elevator_queue *eq)
 {
 	struct bfq_data *bfqd;
-	struct elevator_queue *eq;
 	unsigned int i;
 	struct blk_independent_access_ranges *ia_ranges = q->disk->ia_ranges;
 
-	eq = elevator_alloc(q, e);
-	if (!eq)
-		return -ENOMEM;
-
 	bfqd = kzalloc_node(sizeof(*bfqd), GFP_KERNEL, q->node);
-	if (!bfqd) {
-		kobject_put(&eq->kobj);
+	if (!bfqd)
 		return -ENOMEM;
-	}
+
 	eq->elevator_data = bfqd;
 
 	spin_lock_irq(&q->queue_lock);
@@ -7405,7 +7399,6 @@ static int bfq_init_queue(struct request_queue *q, struct elevator_type *e)
 
 out_free:
 	kfree(bfqd);
-	kobject_put(&eq->kobj);
 	return -ENOMEM;
 }
 
diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 55a0fd105147..359e0704e09b 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -475,10 +475,14 @@ int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e)
 	q->nr_requests = 2 * min_t(unsigned int, q->tag_set->queue_depth,
 				   BLKDEV_DEFAULT_RQ);
 
+	eq = elevator_alloc(q, e);
+	if (!eq)
+		return -ENOMEM;
+
 	if (blk_mq_is_shared_tags(flags)) {
 		ret = blk_mq_init_sched_shared_tags(q);
 		if (ret)
-			return ret;
+			goto err_put_elevator;
 	}
 
 	queue_for_each_hw_ctx(q, hctx, i) {
@@ -487,7 +491,7 @@ int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e)
 			goto err_free_map_and_rqs;
 	}
 
-	ret = e->ops.init_sched(q, e);
+	ret = e->ops.init_sched(q, eq);
 	if (ret)
 		goto err_free_map_and_rqs;
 
@@ -508,7 +512,8 @@ int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e)
 err_free_map_and_rqs:
 	blk_mq_sched_free_rqs(q);
 	blk_mq_sched_tags_teardown(q, flags);
-
+err_put_elevator:
+	kobject_put(&eq->kobj);
 	q->elevator = NULL;
 	return ret;
 }
diff --git a/block/elevator.c b/block/elevator.c
index ab22542e6cf0..770874040f79 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -148,7 +148,6 @@ struct elevator_queue *elevator_alloc(struct request_queue *q,
 
 	return eq;
 }
-EXPORT_SYMBOL(elevator_alloc);
 
 static void elevator_release(struct kobject *kobj)
 {
diff --git a/block/elevator.h b/block/elevator.h
index a07ce773a38f..a4de5f9ad790 100644
--- a/block/elevator.h
+++ b/block/elevator.h
@@ -24,7 +24,7 @@ struct blk_mq_alloc_data;
 struct blk_mq_hw_ctx;
 
 struct elevator_mq_ops {
-	int (*init_sched)(struct request_queue *, struct elevator_type *);
+	int (*init_sched)(struct request_queue *, struct elevator_queue *);
 	void (*exit_sched)(struct elevator_queue *);
 	int (*init_hctx)(struct blk_mq_hw_ctx *, unsigned int);
 	void (*exit_hctx)(struct blk_mq_hw_ctx *, unsigned int);
diff --git a/block/kyber-iosched.c b/block/kyber-iosched.c
index 4dba8405bd01..7b6832cb3a8d 100644
--- a/block/kyber-iosched.c
+++ b/block/kyber-iosched.c
@@ -402,20 +402,13 @@ static struct kyber_queue_data *kyber_queue_data_alloc(struct request_queue *q)
 	return ERR_PTR(ret);
 }
 
-static int kyber_init_sched(struct request_queue *q, struct elevator_type *e)
+static int kyber_init_sched(struct request_queue *q, struct elevator_queue *eq)
 {
 	struct kyber_queue_data *kqd;
-	struct elevator_queue *eq;
-
-	eq = elevator_alloc(q, e);
-	if (!eq)
-		return -ENOMEM;
 
 	kqd = kyber_queue_data_alloc(q);
-	if (IS_ERR(kqd)) {
-		kobject_put(&eq->kobj);
+	if (IS_ERR(kqd))
 		return PTR_ERR(kqd);
-	}
 
 	blk_stat_enable_accounting(q);
 
diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index 2edf1cac06d5..7b6caf30e00a 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -568,20 +568,14 @@ static void dd_exit_sched(struct elevator_queue *e)
 /*
  * initialize elevator private data (deadline_data).
  */
-static int dd_init_sched(struct request_queue *q, struct elevator_type *e)
+static int dd_init_sched(struct request_queue *q, struct elevator_queue *eq)
 {
 	struct deadline_data *dd;
-	struct elevator_queue *eq;
 	enum dd_prio prio;
-	int ret = -ENOMEM;
-
-	eq = elevator_alloc(q, e);
-	if (!eq)
-		return ret;
 
 	dd = kzalloc_node(sizeof(*dd), GFP_KERNEL, q->node);
 	if (!dd)
-		goto put_eq;
+		return -ENOMEM;
 
 	eq->elevator_data = dd;
 
@@ -608,10 +602,6 @@ static int dd_init_sched(struct request_queue *q, struct elevator_type *e)
 
 	q->elevator = eq;
 	return 0;
-
-put_eq:
-	kobject_put(&eq->kobj);
-	return ret;
 }
 
 /*
-- 
2.49.0

