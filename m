Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31AC6288C12
	for <linux-block@vger.kernel.org>; Mon, 16 Jun 2025 17:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750095188; cv=none; b=RP+BfUAcFjRlanL6ZhzVDnGu+oxvSPei7Wimm6p9govaoRaJN+tk7a/sGrvA9iZJECZlrC2dCmuKZibRNvUNAfoYVmZdKnTSGZkkQBs8TP1AGUiVeZhVqwtTWCJ5JJj+aHi+x6PNH+e8+i6p+iD7YL0qyCeMJ6qcdP6/M6WTqQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750095188; c=relaxed/simple;
	bh=5jcZ3dEMC2ncz/K4g93f41S/gN4UbaHxXnL9NUfScis=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SDaDTkBCB+4oAvyzIQwGb84M2fZv3MCKMjPlELmZnaeu2YmqCJCyQ2F1yHp/+4moQ6qo8cMXHx9Ht56xvhwZ/YDs9LNQnbcH3INgY3oWNqeWwsbAZ2B7z6vvKfaWtb3V15sPEE48v1qpQwR9akLGZSGAvg5vQPdlUUPZBt7yX7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kGwd0//+; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kGwd0//+"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55GCUM1P022825;
	Mon, 16 Jun 2025 17:33:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=vAaQRaV8p5AUlnGlD
	f5y5JdWRAyCYu9muWLo2OozmxM=; b=kGwd0//++NXpMmo9sYtDSp4kYAjGqh11D
	2xbs6ok19+NR30+fb+NegrITEYpIPAisWYEYfGadS62BTeC8KAEvLhnTDXMNJZmG
	6z00EDsDufwO2U/+89HFjz2QXzAxhuWG9UTSmfNyVMis5razacxCW/4fodjlSTPG
	D824fQBEtC3QATpBrjhd0kAtugr9sCX+I2GXDYrWeiOhvWrEsFyOAlZz4sviiafl
	9I/ZE5jLn2VwqhmRiNcJNzi+3M2jBwDXqb0/qzXffOq+UzBwhI64y97fO2touXUO
	URJTjJfQwuut2/090BUHJSq/QjWTrlD8v6kBjuce2BW7hNfugFCTw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 478ygn39e3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Jun 2025 17:33:01 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55GGuIIi005495;
	Mon, 16 Jun 2025 17:33:00 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 479mwky4cr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Jun 2025 17:33:00 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55GHWwJ648300542
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Jun 2025 17:32:58 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7E44A20040;
	Mon, 16 Jun 2025 17:32:58 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 20D8B20043;
	Mon, 16 Jun 2025 17:32:55 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.61.44.139])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 16 Jun 2025 17:32:54 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-block@vger.kernel.org
Cc: ming.lei@redhat.com, hch@lst.de, axboe@kernel.dk, sth@linux.ibm.com,
        gjoyce@ibm.com
Subject: [PATCHv3 1/2] block: move elevator queue allocation logic into blk_mq_init_sched
Date: Mon, 16 Jun 2025 23:02:25 +0530
Message-ID: <20250616173233.3803824-2-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250616173233.3803824-1-nilay@linux.ibm.com>
References: <20250616173233.3803824-1-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE2MDExNSBTYWx0ZWRfXwUlM0/1sXsJV 1aHJnLfOUdBneYFDilvtPyCkH2dfJdBsq/cvTS9kIY4OyDtQhtbhAHT+8k1/29Mj3IIoYaxPiCi la1WJWX8/oD13EosGDslJz5iEilUiXhFhE/FV2PaJUAabMz4QlflrOeLN8KkymE6BfYTMDiJJzu
 sLCU9MDJFnDLwdTED2TD17tG1ZfUvw+BVr0TEBCLms/Vi6Q9YX/sauuI5iHqeT2f3twnS4KUPA+ OyMwYuPbptyrqplScT4P+aJsrdnvlM4P/PpeqmRinyamsvmz4aybVkn4eL0RnLO4wXk2FDKMOg9 RyXdIwnqzfn3aySVRbD3H6uZlqN7w7VqQjZpdLrxMtRswCeWdWztTQQF45Z1KZcgGk4pcs51uLs
 Kg9b5N35UKphF+rhJQdIoQad7IhMDyJFYcTc1ige4j7haLOHTUCp98NzMqo4Cqyq/3FoIHbi
X-Authority-Analysis: v=2.4 cv=fYSty1QF c=1 sm=1 tr=0 ts=6850554d cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=C8d9XlvR5LFkZxsZmFoA:9
X-Proofpoint-ORIG-GUID: MyPC0RKcWPwSqrx5DsjuvQqZq2hNqawd
X-Proofpoint-GUID: MyPC0RKcWPwSqrx5DsjuvQqZq2hNqawd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-16_08,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 spamscore=0 mlxlogscore=999 lowpriorityscore=0 adultscore=0 mlxscore=0
 impostorscore=0 bulkscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506160115

In preparation for allocating sched_tags before freezing the request
queue and acquiring ->elevator_lock, move the elevator queue allocation
logic from the elevator ops ->init_sched callback into blk_mq_init_sched.

This refactoring provides a centralized location for elevator queue
initialization, which makes it easier to store pre-allocated sched_tags
in the struct elevator_queue during later changes.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 block/bfq-iosched.c   | 13 +++----------
 block/blk-mq-sched.c  |  7 ++++++-
 block/elevator.h      |  2 +-
 block/kyber-iosched.c | 11 ++---------
 block/mq-deadline.c   | 14 ++------------
 5 files changed, 14 insertions(+), 33 deletions(-)

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
index 55a0fd105147..d914eb9d61a6 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -475,6 +475,10 @@ int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e)
 	q->nr_requests = 2 * min_t(unsigned int, q->tag_set->queue_depth,
 				   BLKDEV_DEFAULT_RQ);
 
+	eq = elevator_alloc(q, e);
+	if (!eq)
+		return -ENOMEM;
+
 	if (blk_mq_is_shared_tags(flags)) {
 		ret = blk_mq_init_sched_shared_tags(q);
 		if (ret)
@@ -487,7 +491,7 @@ int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e)
 			goto err_free_map_and_rqs;
 	}
 
-	ret = e->ops.init_sched(q, e);
+	ret = e->ops.init_sched(q, eq);
 	if (ret)
 		goto err_free_map_and_rqs;
 
@@ -509,6 +513,7 @@ int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e)
 	blk_mq_sched_free_rqs(q);
 	blk_mq_sched_tags_teardown(q, flags);
 
+	kobject_put(&eq->kobj);
 	q->elevator = NULL;
 	return ret;
 }
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

