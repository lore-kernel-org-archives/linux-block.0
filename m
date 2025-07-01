Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E074C26A1CC
	for <linux-block@vger.kernel.org>; Tue,  1 Jul 2025 08:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751358012; cv=none; b=BX6WaQMLWnxyodiT10l1xGjBy+LGnaKIlk9PVBoOBkWL3nRS1C60ezvfFWMwu+6ViT5pI6aiHJWYx/qnUDdP6zay1NpcUu+Xh2qNyWLD10GJ9YWWaB97PSclPcTQ2Q0nlGsNmWk+E/oEf2C5I0NU2OZZTFRJG0PjlSEQo5Casws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751358012; c=relaxed/simple;
	bh=D0TBS9VV+EmeQekCaS4KMWD+C4FI7h3+JOgDO1nNeFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZaqQPsYB0ksUnzXcBVt6iAYfbOiefqJodTGe0Yl5BEBK8diZGR6KTvjrBbF9v232yzg6T15PSSMO573jHBpnQ1Z0JDRDDuacZW19GdKROFlbfSr0ynifgxwPUcETj7xoPF6lXmBKQi1sIa3WV5v9TmLOLZtWdJNhp/A2ggjWwDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UT87aP19; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UT87aP19"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56120JEI006100;
	Tue, 1 Jul 2025 08:20:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=+Ed1aoxibwUh2yTGE
	c4pLAslssLcXNhXf+flYfDV3yM=; b=UT87aP192BK50qoOc1M/5THQvu1f+O1cX
	jOUFD+Bgqw6g0NvRNA+E5rcuWl8QCx4F8gbOcYwB+ivmCPXuoCNqsjwZw72f5mTC
	JZNNrI7EaxCzZme7py8ycWm2AU8lgvIbvKiZKH7MFDHFNo8j6Ri3Kjya/felSEoK
	Spz2uoOhpLPc2rECB5yIJz8g8bj3v8gmaruudT2MDB5KIIrgl8QJ3gHcF4yKlDat
	tLG3uo5xMhKikLjdbA4uDffGk7u+4Ii53ISmlgffixY2fNHsa+zWe3Iwe7iEFN15
	PDFa+SjDeEthDpPQnwKjzDO5pTuev4tz82rQ2WfIHsgGFz1gdQ6nQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47j82fnutg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Jul 2025 08:20:01 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5618Cn1n011840;
	Tue, 1 Jul 2025 08:20:01 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47jv7msne2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Jul 2025 08:20:01 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5618Jxjv50987332
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 1 Jul 2025 08:19:59 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 58C382006A;
	Tue,  1 Jul 2025 08:19:59 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 971C32005A;
	Tue,  1 Jul 2025 08:19:57 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.in.ibm.com (unknown [9.109.198.197])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  1 Jul 2025 08:19:57 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-block@vger.kernel.org
Cc: hch@lst.de, ming.lei@redhat.com, hare@suse.de, axboe@kernel.dk,
        sth@linux.ibm.com, gjoyce@ibm.com
Subject: [PATCHv7 1/3] block: move elevator queue allocation logic into blk_mq_init_sched
Date: Tue,  1 Jul 2025 13:48:58 +0530
Message-ID: <20250701081954.57381-2-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250701081954.57381-1-nilay@linux.ibm.com>
References: <20250701081954.57381-1-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: VbrS92AuifCYmbkODwhI8pYG5JXMyN2k
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAxMDA0NyBTYWx0ZWRfX7cao4k/yLqdA zU6XKxY3Mg1FH2YkA7gY3fQuSFu1PpAOGq9Zwg3Mv4EwoQM/wnzrjRJZuyzi2sWSJ55VUJRYyTz w7W908UcYXpv+SeZ4L71fVAElsESr5GRc1FdZHVx8IdnWYjHDu7jPw7ZZQFSHQKVR3gcDEwkZ+A
 CfBvmkWS9d+xnWsK2/oYDrRQs5IDI43GFaVTDDwqBVrar6kzio1PydMj54Fcghb3xqisZjtERz9 zHB3vGgcsvnDPQkZOQZr9Tof4QyiYd5lkJ1sw3/qO9823FodbycznXqJWa/wua0pB1im30BbS7R osmuRT3L+xIJ50XJi74HCSn6sSlmkbpzb4JpQ5irAb4OdHqlwed7aTb3jaWDCFh9HVU2a+r/j5d
 TmmkiHLaROwLm5R6UNLExC+SOKy2Nq1ADYXG8RZlsjHnirZBM9mMGfXpJJlJr+/v2rdPd+/a
X-Authority-Analysis: v=2.4 cv=LpeSymdc c=1 sm=1 tr=0 ts=68639a32 cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=Wb1JkmetP80A:10 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=eVjI13sIsFB_z2tHqD4A:9
X-Proofpoint-GUID: VbrS92AuifCYmbkODwhI8pYG5JXMyN2k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-01_01,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 impostorscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507010047

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

