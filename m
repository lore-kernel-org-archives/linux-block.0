Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7889C1AE877
	for <linux-block@vger.kernel.org>; Mon, 30 Jun 2025 05:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751262513; cv=none; b=h3UhyeKsdSh2Tkiqd/R+c3bSCnR2FXMBd0tTDC/b7wbeOLL3y7sgWskiYWJWau3O4tQ6WjJrZB8uPF9WNyXNNx45u47rmPhVVVLOcSbPkFXqTIy1j7mu4fdl18bWw8853+H/DAS+mfZs7qOR8Rzu148qYAX1UdmGUjbPbHw8CqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751262513; c=relaxed/simple;
	bh=3gp/SiIiQPhJ/tdfs5/u59+F8goMtViJxBW1BQBLEU0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XePVFcY8VdHYUSXHTTTaO1zvIVpXTHcyJhWmsrb0zN60mUZyVqdt5zNy48f2eNe4IDMSN1JMmnb8dwZ5YXYUQvn1QXSfGSuF8lUiUCTBh6cIcq4IU+hG/YeQA3YWP/SpK9GapQF2mSQ64xUESel6SAxGfNKcPMMbBbrN+GvyXVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IqPRIlQL; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IqPRIlQL"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55TLk6im014460;
	Mon, 30 Jun 2025 05:48:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=NJMqv1hGpTmILDKPI
	kLnBKC0nmtrA/WO+0l4mU/bDnA=; b=IqPRIlQLJhphJM1v4OFdr4V2bcyeu+F+/
	dXpvAjkbNq44B2uBQot8qtipDEbazVwT+FZOp5gaEPQsxdWUnUda8CiAU8erTQB8
	53i/kP1VYqvTD+f6jRdiBGz2a3e9ayfdUcJ99QB4O6zbr39s9JTMGjCQYbD979Nv
	jYR0Xei7706JEYn+edKkdBdzyCkOmmvtsD3PQnsHHj4nQReUmoJWGYdiwPo/62LM
	v1Ai9G05gditVKTGNrImb7nv8q1Uo2PSsvIJhSHZ6ahSeW7ejd3teFrmjDjR0VI0
	1K1xp2+JJM2cEP3beeQZBSiHiZWhm4NRMv9aTKTfJm+J+4mLMrmzg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47j82ff7k9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Jun 2025 05:48:25 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55U4XXEw021088;
	Mon, 30 Jun 2025 05:48:24 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 47jtqu4nvy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Jun 2025 05:48:24 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55U5mNTc30737000
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Jun 2025 05:48:23 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 027532004B;
	Mon, 30 Jun 2025 05:48:23 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 00D7120040;
	Mon, 30 Jun 2025 05:48:19 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.61.92.250])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 30 Jun 2025 05:48:18 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-block@vger.kernel.org
Cc: hch@lst.de, ming.lei@redhat.com, axboe@kernel.dk, sth@linux.ibm.com,
        lkp@intel.com, gjoyce@ibm.com
Subject: [PATCHv6 3/3] block: fix potential deadlock while running nr_hw_queue update
Date: Mon, 30 Jun 2025 10:51:56 +0530
Message-ID: <20250630054756.54532-4-nilay@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: GrnW_i_dDljyKeq2RxSHrJXUxBTFnoBp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjMwMDA0NiBTYWx0ZWRfX9I7s0UeT9P8I SkD8zgkE/E7vIPzcj5wXOChja5fJhdGmMaHznkQdCGQzXSo7kjZokYUcURAPT9uQRzGGsj1C19N aVEjsX5vboERnCOfYoSNURh/vIuh3tmIEEOVpFXi69l+A7v9JCsP/MZuSl8Vvl5TwLYRRr2VxYk
 +1LG4rrZHqe5yqmVkcHkwvQFP65u0ftiW56FBnut/uQyJDlDBfaNWUZwkAC9wVcAQA6q+HR7AdS ecrT9CtHM4pKO2IYn8ShqS4f2P2Pp4SMSEM2UAIzF0yhWHmhA3Yf8N5z/iGanOA6qlsfsc7HVmm 2HkWn0MMCXsvUCOxGzPhl8feuKfI+L82QKJQQbI7LQAjjE9IF5Ga0Bh5iuEJk4DircrYk8WbCJG
 VFWbxUI2dIFbCUQLx0+2H8SqRNEOae5TdiuN5+SkwCSPK4XMJEi9fkNjr3NEmGCkj3+clzd0
X-Authority-Analysis: v=2.4 cv=LpeSymdc c=1 sm=1 tr=0 ts=68622529 cx=c_pps a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=D50k6dCgwcB5hzXsUiIA:9
X-Proofpoint-GUID: GrnW_i_dDljyKeq2RxSHrJXUxBTFnoBp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-27_05,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 impostorscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506300046

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
Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 block/blk-mq-sched.c | 63 ++++++++++++++++++++++++++++++++++++++++++++
 block/blk-mq-sched.h |  4 +++
 block/blk-mq.c       | 11 +++++++-
 block/blk.h          |  2 +-
 block/elevator.c     |  4 +--
 5 files changed, 80 insertions(+), 4 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 2d6d1ebdd8fb..da802df34a8c 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -427,6 +427,30 @@ void blk_mq_free_sched_tags(struct elevator_tags *et,
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
+			if (et)
+				blk_mq_free_sched_tags(et, set);
+		}
+	}
+}
+
 struct elevator_tags *blk_mq_alloc_sched_tags(struct blk_mq_tag_set *set,
 		unsigned int nr_hw_queues)
 {
@@ -477,6 +501,45 @@ struct elevator_tags *blk_mq_alloc_sched_tags(struct blk_mq_tag_set *set,
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
index 4806b867e37d..a68b658ce07b 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4972,6 +4972,7 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 	struct request_queue *q;
 	int prev_nr_hw_queues = set->nr_hw_queues;
 	unsigned int memflags;
+	struct xarray et_table;
 	int i;
 
 	lockdep_assert_held(&set->tag_list_lock);
@@ -4984,6 +4985,11 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 		return;
 
 	memflags = memalloc_noio_save();
+
+	xa_init(&et_table);
+	if (blk_mq_alloc_sched_tags_batch(&et_table, set, nr_hw_queues) < 0)
+		goto out_memalloc_restore;
+
 	list_for_each_entry(q, &set->tag_list, tag_set_list) {
 		blk_mq_debugfs_unregister_hctxs(q);
 		blk_mq_sysfs_unregister_hctxs(q);
@@ -4995,6 +5001,7 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 	if (blk_mq_realloc_tag_set_tags(set, nr_hw_queues) < 0) {
 		list_for_each_entry(q, &set->tag_list, tag_set_list)
 			blk_mq_unfreeze_queue_nomemrestore(q);
+		blk_mq_free_sched_tags_batch(&et_table, set);
 		goto reregister;
 	}
 
@@ -5019,7 +5026,7 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 
 	/* elv_update_nr_hw_queues() unfreeze queue for us */
 	list_for_each_entry(q, &set->tag_list, tag_set_list)
-		elv_update_nr_hw_queues(q);
+		elv_update_nr_hw_queues(q, &et_table);
 
 reregister:
 	list_for_each_entry(q, &set->tag_list, tag_set_list) {
@@ -5029,7 +5036,9 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 		blk_mq_remove_hw_queues_cpuhp(q);
 		blk_mq_add_hw_queues_cpuhp(q);
 	}
+out_memalloc_restore:
 	memalloc_noio_restore(memflags);
+	xa_destroy(&et_table);
 
 	/* Free the excess tags when nr_hw_queues shrink. */
 	for (i = set->nr_hw_queues; i < prev_nr_hw_queues; i++)
diff --git a/block/blk.h b/block/blk.h
index 37ec459fe656..c6d1d1458388 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -321,7 +321,7 @@ bool blk_bio_list_merge(struct request_queue *q, struct list_head *list,
 
 bool blk_insert_flush(struct request *rq);
 
-void elv_update_nr_hw_queues(struct request_queue *q);
+void elv_update_nr_hw_queues(struct request_queue *q, struct xarray *et_table);
 void elevator_set_default(struct request_queue *q);
 void elevator_set_none(struct request_queue *q);
 
diff --git a/block/elevator.c b/block/elevator.c
index 50f4b78efe66..8ba8b869d5a4 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -705,7 +705,7 @@ static int elevator_change(struct request_queue *q, struct elv_change_ctx *ctx)
  * The I/O scheduler depends on the number of hardware queues, this forces a
  * reattachment when nr_hw_queues changes.
  */
-void elv_update_nr_hw_queues(struct request_queue *q)
+void elv_update_nr_hw_queues(struct request_queue *q, struct xarray *et_table)
 {
 	struct blk_mq_tag_set *set = q->tag_set;
 	struct elv_change_ctx ctx = {};
@@ -720,7 +720,7 @@ void elv_update_nr_hw_queues(struct request_queue *q)
 	 * acquires same lock in the reader context) can't run concurrently.
 	 */
 	if (q->elevator) {
-		ctx.et = blk_mq_alloc_sched_tags(set, set->nr_hw_queues);
+		ctx.et = xa_load(et_table, q->id);
 		if (!ctx.et) {
 			WARN_ON_ONCE(1);
 			return;
-- 
2.50.0

