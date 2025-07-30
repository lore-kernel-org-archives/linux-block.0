Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4A31624EA
	for <linux-block@vger.kernel.org>; Wed, 30 Jul 2025 07:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753861617; cv=none; b=qtJ/vwIKTgUjDOq/YkAGVgjglEXALE+qbPwDYNpRQdV0kLPPBCFuljbybgZfsszgauuyCILSpglthwA9rME3gh+8hf42IxbqQG5dtIqEQGybrTnZ/7OBnDZM6oRa9H7NgteQWPOZXqh5NAZmbmhW8rC1zMgy/3B2DPs+Mosjp0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753861617; c=relaxed/simple;
	bh=VkwQxanlVovPy8i6aVp/OD08gU51rn0EpVwafJBVkSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VdhdD87kiLxkwlWIsPg/CneRuNP0u5+ySS4HCXrQTg44SNj3HOcWCRKXb6Zi52taFhRvgT3EcnKr3k4ZzwotAjZTVEoy0cSBIOK4VAfVROlH8I+k0+ipjwtlGgl8Y9CtE/EAJ9V8RJYmtSO2idGiLGbNZGwpoeMS7qsYY6dqVTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RacvzBjn; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RacvzBjn"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56U0klSe002604;
	Wed, 30 Jul 2025 07:46:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=5SEFE2v1nHCizwHEo
	0bE3PwYR7AA6IiYYh+2libL4pg=; b=RacvzBjnNSbZjmTTp1x/0FQKogDvnGCBx
	oWf3pwpG3JNuAAdVMjH+thOZ65b9rZFAk1wVC52PKmmNWzpnBPMFRWMA6peTDjN9
	X+6cOVBrto4LwIkcMuMgFwy3mZ2p3S5yfL9PreSfZ/E2tARCrO6sG+9aq384I2Cy
	CJc52GGa2bZzayLE18NcUuoMEzHKBT6MkVQB2iyqfm6Cq6t6luqdppyA0h1Qnn1A
	WnqnmZE0sSHt+7Hee/R67ukGRB4fg2Uq5gq12Cbfft3aXVMw/ipeCALsthvrpIDc
	dWzkrFB25Sdmz4nIYxaQHR5g5OTVaPCU7zxaGT5ov8Qro1Ih4fUgw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 486c6hse07-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Jul 2025 07:46:46 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56U5D4L9017950;
	Wed, 30 Jul 2025 07:46:26 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4859btpj6x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Jul 2025 07:46:26 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56U7kMVx55640540
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Jul 2025 07:46:22 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A63D620043;
	Wed, 30 Jul 2025 07:46:22 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0BCAE20040;
	Wed, 30 Jul 2025 07:46:20 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.43.45.161])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 30 Jul 2025 07:46:19 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-block@vger.kernel.org
Cc: axboe@kernel.dk, hch@lst.de, ming.lei@redhat.com, hare@suse.de,
        sth@linux.ibm.com, gjoyce@ibm.com, nilay@linux.ibm.com
Subject: [PATCHv8 1/3] block: move elevator queue allocation logic into blk_mq_init_sched
Date: Wed, 30 Jul 2025 13:16:07 +0530
Message-ID: <20250730074614.2537382-2-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250730074614.2537382-1-nilay@linux.ibm.com>
References: <20250730074614.2537382-1-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: usRyhseiPK7plMbuVITHw4Kl6BG_lkAe
X-Authority-Analysis: v=2.4 cv=Mbtsu4/f c=1 sm=1 tr=0 ts=6889cde6 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Wb1JkmetP80A:10 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=eVjI13sIsFB_z2tHqD4A:9
X-Proofpoint-ORIG-GUID: usRyhseiPK7plMbuVITHw4Kl6BG_lkAe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMwMDA1MyBTYWx0ZWRfX4XLcHQPkFFge
 dboGHScWEWJVvwUGD9ZsejnYn/Guoa7NQfdPOGwcBw4rWuXQosksVaXhi+f9gkcfxHR4Z9Mm//+
 xB9WZZ6YFQOGNb2L+VWGzBPgl/8RsdIPXce98Lhpia7luM/Azr6149Yt8T2oB0GzLsEx5+hGp0n
 b0+6CONEQtSowxunnHZ/JtnT4cFoKLevcBHoI/kZRrreR2WtSqoup3beGIPiCfIK7atCj2duawK
 Y+nMAJv5zR1UiWmRQRbXVt6+rc6yz0GIKRdFE9tMA07rw2OnRMOJL+M0aMITdTcVAjn2pNDGp2d
 OB11LWQ+s+YMw4P+yR11RQPE1i9Pkri0FSrBGkpElb1oqSlbpj8PN8HTasQYhZxmDmYbeANCsBx
 vzIpIT7C8LEsweLhL3oPhDRT3VrAToWb4glJ5dCTqE63w9mbqa3PEPIWzl1ZfEFpzVMyOwAY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-30_03,2025-07-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 spamscore=0 mlxscore=0 impostorscore=0 phishscore=0 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507300053

In preparation for allocating sched_tags before freezing the request
queue and acquiring ->elevator_lock, move the elevator queue allocation
logic from the elevator ops ->init_sched callback into blk_mq_init_sched.
As elevator_alloc is now only invoked from block layer core, we don't
need to export it, so unexport elevator_alloc function.

This refactoring provides a centralized location for elevator queue
initialization, which makes it easier to store pre-allocated sched_tags
in the struct elevator_queue during later changes.

Reviewed-by: Ming Lei <ming.lei@redhat.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
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
index f71ec0887733..aca9886c9ee3 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -7218,22 +7218,16 @@ static void bfq_init_root_group(struct bfq_group *root_group,
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
@@ -7391,7 +7385,6 @@ static int bfq_init_queue(struct request_queue *q, struct elevator_type *e)
 
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
index 88f8f36bed98..939b0c590fbe 100644
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
2.50.1

