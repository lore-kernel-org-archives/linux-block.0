Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8678D290D9C
	for <linux-block@vger.kernel.org>; Wed, 30 Jul 2025 07:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753861605; cv=none; b=QSG1agqgdMRjpZOEUvOkHW0OhGiMo6yj35PWOc30kW+rzH4uxZlTiEJCudKDt38h/eB2bdFHgG+QxfQ/rdL3g/z4rrfzPYBPbnqKpNlizkwhk4eSMuDFBNaMeYnxHU+uB5mQA/pXkn5r68lxT6bTs0Iu+fXYY1ZROMv2TDFvG+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753861605; c=relaxed/simple;
	bh=VFSx79UI7RcGF2FvyM9KDRiU31hcnmPVNNk4mO1/CiA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gkh0WPSC0c0sNcvjUtHIQwrAE9DXKjxnPXLdi0MpTF95hnsVCfFfWpKeF6pw0EfPK39gLuikJOr4Z7R8TaUJdSWoH2Y5+tUwx8I3QQAW/xWbJMa1RE8kUxaY8h4+VqS5U79nhmJFJ3YoRKwhTJAyE2BWBy9aaxmnijxmxHB3/+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=irBOKCZv; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="irBOKCZv"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56TNndRF015106;
	Wed, 30 Jul 2025 07:46:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=9vwrEbRtUP1bRdwxF
	n/Op6pEOQNmQ9rUMtPgztpNLjc=; b=irBOKCZvL/4TLl8Eq1TAnWVQj7St4Px10
	8s8L+iUpTFwPP7iYFOuE7Woypj5oEZdZevf3qU6BbPql1bujO0TT6cuX1VFtM08O
	WQbzY88Y9YNYJiGIBhtpjPMlgoSRsrjDeJHN7Ou2ctydr71OfKWUM1t18EJTWBBZ
	/JIi3jyn0++fX4udGUUMWxkKVTwL4Ee3stG5KXHt03az+UtZtGCM4FQ5VAdjjsii
	dJWYgS7mlighrV0KkZh3gSLHtYi3ybethnkRkoAIh/xZcOAax7D9PC6/IvhD169r
	q6hwSOgyRXzXrr93NpZp8SEf5IVHWA9l+71BLcG5JIw8p8HmUYGRg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 484qfquaqu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Jul 2025 07:46:34 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56U5sF12015952;
	Wed, 30 Jul 2025 07:46:33 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 485aumpa5j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Jul 2025 07:46:32 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56U7kT2T48628062
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Jul 2025 07:46:29 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0654220043;
	Wed, 30 Jul 2025 07:46:29 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5709020040;
	Wed, 30 Jul 2025 07:46:26 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.43.45.161])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 30 Jul 2025 07:46:26 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-block@vger.kernel.org
Cc: axboe@kernel.dk, hch@lst.de, ming.lei@redhat.com, hare@suse.de,
        sth@linux.ibm.com, gjoyce@ibm.com, nilay@linux.ibm.com
Subject: [PATCHv8 3/3] block: fix potential deadlock while running nr_hw_queue update
Date: Wed, 30 Jul 2025 13:16:09 +0530
Message-ID: <20250730074614.2537382-4-nilay@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMwMDA1MyBTYWx0ZWRfX+E+NyeztMioc
 E7/zYwchGVu0XHynxEJRtLBmsi3arqcI4cH6Ler1wR+OHDIWwHPgULMY8TB2PVkYg/aCNtTwmHj
 xvGvKycX3IT3/2a4OKcVgMYkD79QBOTonWURmXJxoLdEsmzjSfYi56drd4ArpwdYM1xU4q6PQov
 yaBFvR9REyOMqtWj0dnz0dqy2molA50vlbEzSxpJ6bh6rCEuLZygpq7jGUNlvGuoB0Z0OhpTSJO
 pq6x4qlPxkiKdnHfVOUO9k9yZtga2oV8UAdmy1fIE8WGHdvqfS+q4HmS1pgUAYqUDl4Al6dmpAV
 DHz3Iwp1W6XQbcAYyC/NBE18/OUzExMReLXlZqO8xUnNreRXwv5fPBYOpg7xnTs5I/5/N+wxVNV
 Sq+BgG4P1h7O1z15h3zoofNoTAKDERm6chDwufo2B7NfVSbOsDdUR6uuqzdkYAwmdMk9hpGQ
X-Authority-Analysis: v=2.4 cv=Je28rVKV c=1 sm=1 tr=0 ts=6889cdda cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8
 a=LJFNE_Vb_oYf0bAoxjoA:9
X-Proofpoint-GUID: Ix9woHx0BgKiucYAjiazbMubqcoQrkjR
X-Proofpoint-ORIG-GUID: Ix9woHx0BgKiucYAjiazbMubqcoQrkjR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-30_03,2025-07-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 clxscore=1015 lowpriorityscore=0 spamscore=0 adultscore=0
 suspectscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 mlxscore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507300053

Move scheduler tags (sched_tags) allocation and deallocation outside
both the ->elevator_lock and ->freeze_lock when updating nr_hw_queues.
This change breaks the dependency chain from the percpu allocator lock
to the elevator lock, helping to prevent potential deadlocks, as
observed in the reported lockdep splat[1].

This commit introduces batch allocation and deallocation helpers for
sched_tags, which are now used from within __blk_mq_update_nr_hw_queues
routine while iterating through the tagset.

With this change, all sched_tags memory management is handled entirely
outside the ->elevator_lock and the ->freeze_lock context, thereby
eliminating the lock dependency that could otherwise manifest during
nr_hw_queues updates.

[1] https://lore.kernel.org/all/0659ea8d-a463-47c8-9180-43c719e106eb@linux.ibm.com/

Reported-by: Stefan Haberland <sth@linux.ibm.com>
Closes: https://lore.kernel.org/all/0659ea8d-a463-47c8-9180-43c719e106eb@linux.ibm.com/
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 block/blk-mq-sched.c | 65 ++++++++++++++++++++++++++++++++++++++++++++
 block/blk-mq-sched.h |  4 +++
 block/blk-mq.c       | 16 +++++++----
 block/blk.h          |  4 ++-
 block/elevator.c     | 15 ++++------
 5 files changed, 89 insertions(+), 15 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 2d6d1ebdd8fb..e2ce4a28e6c9 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -427,6 +427,32 @@ void blk_mq_free_sched_tags(struct elevator_tags *et,
 	kfree(et);
 }
 
+void blk_mq_free_sched_tags_batch(struct xarray *et_table,
+		struct blk_mq_tag_set *set)
+{
+	struct request_queue *q;
+	struct elevator_tags *et;
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
+			et = xa_load(et_table, q->id);
+			if (unlikely(!et))
+				WARN_ON_ONCE(1);
+			else
+				blk_mq_free_sched_tags(et, set);
+		}
+	}
+}
+
 struct elevator_tags *blk_mq_alloc_sched_tags(struct blk_mq_tag_set *set,
 		unsigned int nr_hw_queues)
 {
@@ -477,6 +503,45 @@ struct elevator_tags *blk_mq_alloc_sched_tags(struct blk_mq_tag_set *set,
 	return NULL;
 }
 
+int blk_mq_alloc_sched_tags_batch(struct xarray *et_table,
+		struct blk_mq_tag_set *set, unsigned int nr_hw_queues)
+{
+	struct request_queue *q;
+	struct elevator_tags *et;
+	gfp_t gfp = GFP_NOIO | __GFP_ZERO | __GFP_NOWARN | __GFP_NORETRY;
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
+			et = blk_mq_alloc_sched_tags(set, nr_hw_queues);
+			if (!et)
+				goto out_unwind;
+			if (xa_insert(et_table, q->id, et, gfp))
+				goto out_free_tags;
+		}
+	}
+	return 0;
+out_free_tags:
+	blk_mq_free_sched_tags(et, set);
+out_unwind:
+	list_for_each_entry_continue_reverse(q, &set->tag_list, tag_set_list) {
+		if (q->elevator) {
+			et = xa_load(et_table, q->id);
+			if (et)
+				blk_mq_free_sched_tags(et, set);
+		}
+	}
+	return -ENOMEM;
+}
+
 /* caller must have a reference to @e, will grab another one if successful */
 int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e,
 		struct elevator_tags *et)
diff --git a/block/blk-mq-sched.h b/block/blk-mq-sched.h
index 0cde00cd1c47..b554e1d55950 100644
--- a/block/blk-mq-sched.h
+++ b/block/blk-mq-sched.h
@@ -25,8 +25,12 @@ void blk_mq_sched_free_rqs(struct request_queue *q);
 
 struct elevator_tags *blk_mq_alloc_sched_tags(struct blk_mq_tag_set *set,
 		unsigned int nr_hw_queues);
+int blk_mq_alloc_sched_tags_batch(struct xarray *et_table,
+		struct blk_mq_tag_set *set, unsigned int nr_hw_queues);
 void blk_mq_free_sched_tags(struct elevator_tags *et,
 		struct blk_mq_tag_set *set);
+void blk_mq_free_sched_tags_batch(struct xarray *et_table,
+		struct blk_mq_tag_set *set);
 
 static inline void blk_mq_sched_restart(struct blk_mq_hw_ctx *hctx)
 {
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 9692fa4c3ef2..b67d6c02eceb 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4974,12 +4974,13 @@ int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr)
  * Switch back to the elevator type stored in the xarray.
  */
 static void blk_mq_elv_switch_back(struct request_queue *q,
-		struct xarray *elv_tbl)
+		struct xarray *elv_tbl, struct xarray *et_tbl)
 {
 	struct elevator_type *e = xa_load(elv_tbl, q->id);
+	struct elevator_tags *t = xa_load(et_tbl, q->id);
 
 	/* The elv_update_nr_hw_queues unfreezes the queue. */
-	elv_update_nr_hw_queues(q, e);
+	elv_update_nr_hw_queues(q, e, t);
 
 	/* Drop the reference acquired in blk_mq_elv_switch_none. */
 	if (e)
@@ -5031,7 +5032,7 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 	int prev_nr_hw_queues = set->nr_hw_queues;
 	unsigned int memflags;
 	int i;
-	struct xarray elv_tbl;
+	struct xarray elv_tbl, et_tbl;
 
 	lockdep_assert_held(&set->tag_list_lock);
 
@@ -5044,6 +5045,10 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 
 	memflags = memalloc_noio_save();
 
+	xa_init(&et_tbl);
+	if (blk_mq_alloc_sched_tags_batch(&et_tbl, set, nr_hw_queues) < 0)
+		goto out_memalloc_restore;
+
 	xa_init(&elv_tbl);
 
 	list_for_each_entry(q, &set->tag_list, tag_set_list) {
@@ -5087,7 +5092,7 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 switch_back:
 	/* The blk_mq_elv_switch_back unfreezes queue for us. */
 	list_for_each_entry(q, &set->tag_list, tag_set_list)
-		blk_mq_elv_switch_back(q, &elv_tbl);
+		blk_mq_elv_switch_back(q, &elv_tbl, &et_tbl);
 
 	list_for_each_entry(q, &set->tag_list, tag_set_list) {
 		blk_mq_sysfs_register_hctxs(q);
@@ -5098,7 +5103,8 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 	}
 
 	xa_destroy(&elv_tbl);
-
+	xa_destroy(&et_tbl);
+out_memalloc_restore:
 	memalloc_noio_restore(memflags);
 
 	/* Free the excess tags when nr_hw_queues shrink. */
diff --git a/block/blk.h b/block/blk.h
index 76901a39997f..0a2eccf28ca4 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -12,6 +12,7 @@
 #include "blk-crypto-internal.h"
 
 struct elevator_type;
+struct elevator_tags;
 
 /*
  * Default upper limit for the software max_sectors limit used for regular I/Os.
@@ -330,7 +331,8 @@ bool blk_bio_list_merge(struct request_queue *q, struct list_head *list,
 
 bool blk_insert_flush(struct request *rq);
 
-void elv_update_nr_hw_queues(struct request_queue *q, struct elevator_type *e);
+void elv_update_nr_hw_queues(struct request_queue *q, struct elevator_type *e,
+		struct elevator_tags *t);
 void elevator_set_default(struct request_queue *q);
 void elevator_set_none(struct request_queue *q);
 
diff --git a/block/elevator.c b/block/elevator.c
index e9dc837b7b70..fe96c6f4753c 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -705,7 +705,8 @@ static int elevator_change(struct request_queue *q, struct elv_change_ctx *ctx)
  * The I/O scheduler depends on the number of hardware queues, this forces a
  * reattachment when nr_hw_queues changes.
  */
-void elv_update_nr_hw_queues(struct request_queue *q, struct elevator_type *e)
+void elv_update_nr_hw_queues(struct request_queue *q, struct elevator_type *e,
+		struct elevator_tags *t)
 {
 	struct blk_mq_tag_set *set = q->tag_set;
 	struct elv_change_ctx ctx = {};
@@ -715,25 +716,21 @@ void elv_update_nr_hw_queues(struct request_queue *q, struct elevator_type *e)
 
 	if (e && !blk_queue_dying(q) && blk_queue_registered(q)) {
 		ctx.name = e->elevator_name;
-		ctx.et = blk_mq_alloc_sched_tags(set, set->nr_hw_queues);
-		if (!ctx.et) {
-			WARN_ON_ONCE(1);
-			goto unfreeze;
-		}
+		ctx.et = t;
+
 		mutex_lock(&q->elevator_lock);
 		/* force to reattach elevator after nr_hw_queue is updated */
 		ret = elevator_switch(q, &ctx);
 		mutex_unlock(&q->elevator_lock);
 	}
-unfreeze:
 	blk_mq_unfreeze_queue_nomemrestore(q);
 	if (!ret)
 		WARN_ON_ONCE(elevator_change_done(q, &ctx));
 	/*
 	 * Free sched tags if it's allocated but we couldn't switch elevator.
 	 */
-	if (ctx.et && !ctx.new)
-		blk_mq_free_sched_tags(ctx.et, set);
+	if (t && !ctx.new)
+		blk_mq_free_sched_tags(t, set);
 }
 
 /*
-- 
2.50.1

