Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C694291C34
	for <linux-block@vger.kernel.org>; Tue, 24 Jun 2025 13:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750771056; cv=none; b=BLWVdwPgLcArEhMzPNTorjGWoI6EGhKWVhL2Kf/tatbugsevWxjZvsgV714vr2OcQiUUQ4j2QGNkRkjXeetm77bgEnJcnMAyYoy7ZiQ3o+8AakgH4yWpVWGPKInMo0pRikd38y8JEDymZ8ZzpSAOjlaAT8wCFxJqFnl4wZuhihE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750771056; c=relaxed/simple;
	bh=LYM+ZzYIi7Vo+GN3pS7piNFIgfmyQhMORbD/zUvcj5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IN70PJcMnUyZki0PQC0KKuH0tBnWUP/1bzGNuflG0nnJV64yJcBlKo/UpDviNamyoQx9CzPr0JGIv/h3m1d3m8VWd4y9CVRmyW/CK+k1Cw5JRztwG+rBbhDp84eSaXJKqF0kCSealN2sHc9YIKDRJ6cmDej5YhpfYwlxL9fn2m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ipJ6iE01; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ipJ6iE01"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55OD4A7K002256;
	Tue, 24 Jun 2025 13:17:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=rJbtq9ZND0KSFv/B+
	W7QBl8myoe9JYO4GrFVkfoftSw=; b=ipJ6iE01QjDRlu3xFKfWUd+42vMiHW1n3
	O4gIfh8GeI6VjeHHTvb5tCpUuZnKFTC2Ro0P+prMbSRAu1JXr1WayMsFnUvFYE65
	/AavU9qV010vVvWIRsmDazNo3/JPyN2YVDsG+YOF94zzRaf9PwsrYd4YFw//GS85
	4uKF13VvT6zJUVq/Ek80faUyjxIm6zBzUaiPdBFRYu18DdHoetUBbTg289MqIgQ9
	48NcJQ1DIzAGNL+/5qbWrlDTEbTKxausD/ls9HUOi5euY/pal4mfXkDKsP3lN6T7
	wZUuwgXuL0ak334pPD2Isgs+MwKxVd2PdUKcuwc1L69+0JCyPd4Uw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dm8j8uxy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Jun 2025 13:17:27 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55OAeeXg002471;
	Tue, 24 Jun 2025 13:17:26 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47e8jm4128-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Jun 2025 13:17:26 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55ODHOql28574254
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Jun 2025 13:17:24 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 12A5220043;
	Tue, 24 Jun 2025 13:17:24 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A31F520040;
	Tue, 24 Jun 2025 13:17:22 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.in.ibm.com (unknown [9.109.198.209])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 24 Jun 2025 13:17:22 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-block@vger.kernel.org
Cc: hch@lst.de, ming.lei@redhat.com, axboe@kernel.dk, sth@linux.ibm.com,
        gjoyce@ibm.com
Subject: [PATCHv4 3/3] block: fix potential deadlock while running nr_hw_queue update
Date: Tue, 24 Jun 2025 18:47:05 +0530
Message-ID: <20250624131716.630465-4-nilay@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI0MDExMiBTYWx0ZWRfXylskjvy73zQZ DZMEQ74kPtabGdhQ4R2m6blhVXqlpyRzJSEAkxIdQAqsEFX1IaIvYno7pp0po7HfIX2IePhW8tY WsOJ5aY/+HXn9/8zS69Ck1Nr/5XMaInFu00XZI8Eziyr6H716E4hjuseaYK5jZVeb+HycHsrx/0
 n4HXJ2zwDk0Ur1igq1DYI3epMoY/6Nf2FRbt73sXbOBVzVtlEUzFQ9RqivT92NmH9Nh4UtS39Nm u7YRhIWfGgZPTAA9nlovd3TJbcud8vmd0kmj0G6NDuFfkAH+xDMIu5uIAuzDZmEK6Wq3wWp2Mcy CjdakPi2nMf/V2Bbr36WVIKRNqesAYAj2bTb9M3SX4BJloG6pCRKGbX3E8kS+U/IkpgtH/iUh9j
 pLes6PiXlPrQVQjHG+fvTkoALFWa9irGz/D0QYd3EFzOJxrfZymjY0uGhC9WrjlwlAvAcNrC
X-Proofpoint-GUID: lpnOAUWhF4NOYfxMqbYr_27gr5BjL-LE
X-Proofpoint-ORIG-GUID: lpnOAUWhF4NOYfxMqbYr_27gr5BjL-LE
X-Authority-Analysis: v=2.4 cv=combk04i c=1 sm=1 tr=0 ts=685aa567 cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=Tz36AgOCWGy_ESXodBQA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-24_05,2025-06-23_07,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 spamscore=0 adultscore=0 mlxlogscore=999 clxscore=1015
 impostorscore=0 suspectscore=0 mlxscore=0 phishscore=0 lowpriorityscore=0
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506240112

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
 block/blk-mq-sched.c | 51 ++++++++++++++++++++++++++++++++++++++++++++
 block/blk-mq-sched.h |  5 +++++
 block/blk-mq.c       | 12 ++++++++++-
 block/blk.h          |  3 ++-
 block/elevator.c     | 23 ++------------------
 5 files changed, 71 insertions(+), 23 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 5d3132ac7777..acdc03718ebd 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -508,6 +508,57 @@ int blk_mq_alloc_sched_tags(struct elevator_tags *et,
 	return -ENOMEM;
 }
 
+int blk_mq_alloc_sched_tags_batch(struct elevator_tags *et,
+		struct blk_mq_tag_set *set)
+{
+	struct request_queue *q;
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
+			if (blk_mq_alloc_sched_tags(et, set, q->id))
+				goto out_unwind;
+		}
+	}
+	return 0;
+
+out_unwind:
+	list_for_each_entry_continue_reverse(q, &set->tag_list, tag_set_list) {
+		if (q->elevator)
+			blk_mq_free_sched_tags(et, set, q->id);
+	}
+
+	return -ENOMEM;
+}
+
+void blk_mq_free_sched_tags_batch(struct elevator_tags *et,
+		struct blk_mq_tag_set *set)
+{
+	struct request_queue *q;
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
+		if (q->elevator)
+			blk_mq_free_sched_tags(et, set, q->id);
+	}
+}
+
 /* caller must have a reference to @e, will grab another one if successful */
 int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e,
 		struct elevator_tags *et)
diff --git a/block/blk-mq-sched.h b/block/blk-mq-sched.h
index 92aa50b8376a..4b3bf8946ae2 100644
--- a/block/blk-mq-sched.h
+++ b/block/blk-mq-sched.h
@@ -29,6 +29,11 @@ struct blk_mq_tags **__blk_mq_alloc_sched_tags(struct blk_mq_tag_set *set,
 void __blk_mq_free_sched_tags(struct blk_mq_tag_set *set,
 		struct blk_mq_tags **tags, unsigned int nr_hw_queues);
 
+int blk_mq_alloc_sched_tags_batch(struct elevator_tags *et,
+		struct blk_mq_tag_set *set);
+void blk_mq_free_sched_tags_batch(struct elevator_tags *et,
+		struct blk_mq_tag_set *set);
+
 int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e,
 		struct elevator_tags *et);
 void blk_mq_exit_sched(struct request_queue *q, struct elevator_queue *e);
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 4806b867e37d..a06f184f1d9a 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4970,6 +4970,7 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 							int nr_hw_queues)
 {
 	struct request_queue *q;
+	struct elevator_tags et;
 	int prev_nr_hw_queues = set->nr_hw_queues;
 	unsigned int memflags;
 	int i;
@@ -4984,6 +4985,12 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 		return;
 
 	memflags = memalloc_noio_save();
+
+	et.nr_hw_queues = nr_hw_queues;
+	xa_init(&et.tags_table);
+	if (blk_mq_alloc_sched_tags_batch(&et, set) < 0)
+		goto memalloc_restore;
+
 	list_for_each_entry(q, &set->tag_list, tag_set_list) {
 		blk_mq_debugfs_unregister_hctxs(q);
 		blk_mq_sysfs_unregister_hctxs(q);
@@ -4995,6 +5002,7 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 	if (blk_mq_realloc_tag_set_tags(set, nr_hw_queues) < 0) {
 		list_for_each_entry(q, &set->tag_list, tag_set_list)
 			blk_mq_unfreeze_queue_nomemrestore(q);
+		blk_mq_free_sched_tags_batch(&et, set);
 		goto reregister;
 	}
 
@@ -5019,7 +5027,7 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 
 	/* elv_update_nr_hw_queues() unfreeze queue for us */
 	list_for_each_entry(q, &set->tag_list, tag_set_list)
-		elv_update_nr_hw_queues(q);
+		elv_update_nr_hw_queues(q, &et);
 
 reregister:
 	list_for_each_entry(q, &set->tag_list, tag_set_list) {
@@ -5029,7 +5037,9 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 		blk_mq_remove_hw_queues_cpuhp(q);
 		blk_mq_add_hw_queues_cpuhp(q);
 	}
+memalloc_restore:
 	memalloc_noio_restore(memflags);
+	xa_destroy(&et.tags_table);
 
 	/* Free the excess tags when nr_hw_queues shrink. */
 	for (i = set->nr_hw_queues; i < prev_nr_hw_queues; i++)
diff --git a/block/blk.h b/block/blk.h
index 37ec459fe656..a312518fb8f3 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -12,6 +12,7 @@
 #include "blk-crypto-internal.h"
 
 struct elevator_type;
+struct elevator_tags;
 
 #define	BLK_DEV_MAX_SECTORS	(LLONG_MAX >> 9)
 #define	BLK_MIN_SEGMENT_SIZE	4096
@@ -321,7 +322,7 @@ bool blk_bio_list_merge(struct request_queue *q, struct list_head *list,
 
 bool blk_insert_flush(struct request *rq);
 
-void elv_update_nr_hw_queues(struct request_queue *q);
+void elv_update_nr_hw_queues(struct request_queue *q, struct elevator_tags *et);
 void elevator_set_default(struct request_queue *q);
 void elevator_set_none(struct request_queue *q);
 
diff --git a/block/elevator.c b/block/elevator.c
index 1408894c0396..4272f9bc7e11 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -717,31 +717,14 @@ static int elevator_change(struct request_queue *q, struct elv_change_ctx *ctx)
  * The I/O scheduler depends on the number of hardware queues, this forces a
  * reattachment when nr_hw_queues changes.
  */
-void elv_update_nr_hw_queues(struct request_queue *q)
+void elv_update_nr_hw_queues(struct request_queue *q, struct elevator_tags *et)
 {
 	struct blk_mq_tag_set *set = q->tag_set;
-	struct elevator_tags et;
-	struct elv_change_ctx ctx = {};
+	struct elv_change_ctx ctx = {.et = et};
 	int ret = -ENODEV;
 
 	WARN_ON_ONCE(q->mq_freeze_depth == 0);
 
-	et.nr_hw_queues = set->nr_hw_queues;
-	xa_init(&et.tags_table);
-	ctx.et = &et;
-	/*
-	 * Accessing q->elevator without holding q->elevator_lock is safe here
-	 * because nr_hw_queue update is protected by set->update_nr_hwq_lock
-	 * in the writer context. So, scheduler update/switch code (which
-	 * acquires same lock in the reader context) can't run concurrently.
-	 */
-	if (q->elevator) {
-		if (blk_mq_alloc_sched_tags(ctx.et, set, q->id)) {
-			WARN_ON_ONCE(1);
-			goto out;
-		}
-	}
-
 	mutex_lock(&q->elevator_lock);
 	if (q->elevator && !blk_queue_dying(q) && blk_queue_registered(q)) {
 		ctx.name = q->elevator->type->elevator_name;
@@ -758,8 +741,6 @@ void elv_update_nr_hw_queues(struct request_queue *q)
 	 */
 	if (!xa_empty(&ctx.et->tags_table) && !ctx.new)
 		blk_mq_free_sched_tags(ctx.et, set, q->id);
-out:
-	xa_destroy(&ctx.et->tags_table);
 }
 
 /*
-- 
2.49.0

