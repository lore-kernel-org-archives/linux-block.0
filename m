Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA0543147
	for <linux-block@vger.kernel.org>; Mon, 30 Jun 2025 05:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751262499; cv=none; b=Mq853hhJ9B/CwRyqPGPIps0UGa86u5z8Em76t+Ub1yJRy0052hXWQIhbpYDWq86htfvZGtcnc7SGeuXiTnolgyIlcEVzc/R5uesXc7NPN508h0VzLWyeZE6CQNsuzcWZ74F9WjBv6FQfytauF7LHeQz4RVke2R80RJIy3Ov/E6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751262499; c=relaxed/simple;
	bh=i7w7AdM6OusA51XgLVbYoh6Pz0I0qzVsrPNbRZgz+rM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e6B7hpyI0VEmqEfKYeTeTyyJ7nuR403laWN6oAhulT1WqeQN/mPdtfw/of3lTNigONMtVlhCinupAgBC74JqGFOOwxUja+S6eNdd7Nl5Uu3d/LJBI44B2NbnM6nmv5QYyP7j989CpMKzH/vn+LPhWXrWPOnPkr1Lw4+S2K5aJRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KJve8Qch; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KJve8Qch"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55TNIUgm012368;
	Mon, 30 Jun 2025 05:48:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=JvrNosHA4rODqW8t6
	66EXmNXtySkz2oIFFR/957a0c0=; b=KJve8QchiTHgeWJgZYA2mv2iRmlNCNUfI
	c3tjKGxrcUr1tDSstIshwzEueCeK/zW6JYayJOOfB8A7H3bCbm7FQ16rnp5X6x86
	LoLgcpyDYaHh4fHDXivEHMIix/LvJtQgFlDgDqxeGEnB9zQraHdRbectUJxm8UcR
	x0NOR8FjUbU0gwaONtbPxx5WWQZp0pRX3hA8RJ78ntagtzdQUigv62+R6fcRHytS
	Bh5tGVhy1OKJZg0yk4QPUw67Pfu/qvOotyxFg3unt7KFsFTQpBF5wcy7JDE2WPSe
	YLNnWP7/tKsEFnrNTTyPzMIwnHqRpj58fArEboW4bmi+zrpDA1FDg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47j82ff7h7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Jun 2025 05:48:11 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55U0cLgE011803;
	Mon, 30 Jun 2025 05:48:10 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47jv7mmcr0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Jun 2025 05:48:10 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55U5m8gw40829266
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Jun 2025 05:48:08 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 63DBB20040;
	Mon, 30 Jun 2025 05:48:08 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BFC1E20043;
	Mon, 30 Jun 2025 05:48:03 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.61.92.250])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 30 Jun 2025 05:48:03 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-block@vger.kernel.org
Cc: hch@lst.de, ming.lei@redhat.com, axboe@kernel.dk, sth@linux.ibm.com,
        lkp@intel.com, gjoyce@ibm.com
Subject: [PATCHv6 1/3] block: move elevator queue allocation logic into blk_mq_init_sched
Date: Mon, 30 Jun 2025 10:51:54 +0530
Message-ID: <20250630054756.54532-2-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250630054756.54532-1-nilay@linux.ibm.com>
References: <20250630054756.54532-1-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: UtUvgHXMvhpVQrhqbHNCpqF6uwj0fIDU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjMwMDA0NiBTYWx0ZWRfXzmJUWZvhAu+Q M2zSKfMK0g85nC4OySKCxwc8Qy+mX1m6ijHC738dA03tC//kIUTzVqjvwYZt2KjAWlgWOTYzSl0 IoHcZJiwSBDfudfLMlaPFmDftJCTgBXIJnEKH41esAL5Q6VZM6AZrXU40SPFUz/xGA53GFcGnU2
 7zsOyhHmeq0CzXXq8UM3goz+E0NSeCIqCsk/bkQO60NTdeWzUoP8s7b773oEZHqhf8GxNET3J8U 2gncInCrfm6wxWHxdvamuzzIfMSXgg7bCOP5SfOj9T+YSxA8Txu6Vmzx7cgAcPcGdS6f3/0lkVr ucIyB2D1GcQ/iZE1UmsV7ZPcukPOcBtLya2QIJdzTxCD1SOTvPkW98k+SadojnS73m11gvFOZ9i
 p119IjmtBt/zMAFj1ux5L3RG9atgeYAETXtbP2fQIImRBiS0/opFX+Yoxt3rk/IPHaQOPui6
X-Authority-Analysis: v=2.4 cv=LpeSymdc c=1 sm=1 tr=0 ts=6862251b cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=6IFa9wvqVegA:10 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=eVjI13sIsFB_z2tHqD4A:9
X-Proofpoint-GUID: UtUvgHXMvhpVQrhqbHNCpqF6uwj0fIDU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-27_05,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 impostorscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506300046

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
2.50.0

