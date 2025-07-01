Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F95226A0F3
	for <linux-block@vger.kernel.org>; Tue,  1 Jul 2025 08:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751358016; cv=none; b=EcVn7rPI6JCNsrSHP4Rj6Vk6zgczEPeZaoN+cR+QaWQT7mskkArA5KqKhNrJRmikHXEkD0OtMC26ywappIhN/U9duZYaa5L5VR/DAgNGW0DfiPj64m9OKSXL3W9ky44oR/c7NXhpqbq1JCGim1fS1zgfMucYnGInwohVFlhBLy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751358016; c=relaxed/simple;
	bh=ns7z4oaZ+GX+aWAqD5VG0Ard63gKtdDFCihxj47FBOU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZhA6CYuBMz2fxxfQJNaq+2qMRBCMOYzuBU042QsmQvUmRlfLgc80rWClz7XAVBztph9t8ItagxGmD8hC56xXema91I+he+kGUqUGUm7AIWDcGzSJJTAFpog1lD94u0/3ke2Rt9/a4oRthdyIE+0CnLX0RmE0XgPqB5eoOD08TaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HvzrJuiB; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HvzrJuiB"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56189Cqr024499;
	Tue, 1 Jul 2025 08:20:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=GC9rRH/fmFdizSCj3
	I/TRlMZs64OkBNP3crMdzKzyZM=; b=HvzrJuiBIxCIKjcBUqvy31wqEmA4mP/9G
	lHqaPUI33z8TH3l+ykDBxTkGfeAZP0IF0F7vggv2vYHYJSek0NXaCC+Fu+Cm0LRN
	JuTPpY/WPWUoJGcTUuxZgzfqQF1k3OYVXZo4sw6DOEok48hPkeZdMIFUs/gsgjPI
	Qce0n4uhNsgRowXNA0XBJ3Hmbv34RYlijZwlVH5UqqrZy4mQHYjml9w/UkPlqnKt
	c5E5GsR7mRR1uDbE5OpSRVeRAK5wGbnbOgAz4HaCT9kmC2vTdZMfWCnbwWd74iFE
	IleT6bM15Uds1PegFnulg9BY0BQIUEuLDoYs/zOmEA1kOBcXRCYJA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47j830p40b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Jul 2025 08:20:06 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56140jRU006911;
	Tue, 1 Jul 2025 08:20:05 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 47jvxm9j91-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Jul 2025 08:20:05 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5618K4QQ51053036
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 1 Jul 2025 08:20:04 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ED6522006A;
	Tue,  1 Jul 2025 08:20:03 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1E3022005A;
	Tue,  1 Jul 2025 08:20:02 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.in.ibm.com (unknown [9.109.198.197])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  1 Jul 2025 08:20:01 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-block@vger.kernel.org
Cc: hch@lst.de, ming.lei@redhat.com, hare@suse.de, axboe@kernel.dk,
        sth@linux.ibm.com, gjoyce@ibm.com
Subject: [PATCHv7 3/3] block: fix potential deadlock while running nr_hw_queue update
Date: Tue,  1 Jul 2025 13:49:00 +0530
Message-ID: <20250701081954.57381-4-nilay@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: gMXm-MB-3mXWYbvtcOoICK-A2wB4WaRj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAxMDA0NyBTYWx0ZWRfXy84Af4BKB/Ta DRzb02/wBMq5LEXynQYRWbZEl1l015XUd2WOYRh2S3MMoHV0SQy62M6nFSYme45l1VlUUtTbQq9 2VTEfJ1Rt3PdyiXiBFgPEgM5y2XmsaUJNxo/+09iYl5MR5u8XoEE4qBNMinQ7e1Q5b4lAiRIIkQ
 uOIlIIjNkqhtEiKH/IJP4fnL/0vp9WIqqSSzKT3czIHDMzyWZCXe29GskhOQRVW5WBROlZdFFpq H9caeymhFB46rWuRulUZQpC7gD9HD0DDrL9VAZ47IwdhjlqiYRNXO3SWbP+1bxgKQWduEwgylx9 DYcUBIvUMdqBBl2k6r0rE88HGo0wPsHSHGlOFNELoFUCzSUPyZNMGwTum46EzObKAo6TjPd2m6g
 tX6SzsISSZW0hDqt36RS9RxrsQVdDgV37DnviH9hv2AHXLpWUxj57WZAEcc9fq/aZu5Y2skt
X-Authority-Analysis: v=2.4 cv=MOlgmNZl c=1 sm=1 tr=0 ts=68639a36 cx=c_pps a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8 a=L_SnxBb1UgEGMhxGnJwA:9
X-Proofpoint-GUID: gMXm-MB-3mXWYbvtcOoICK-A2wB4WaRj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-01_01,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 adultscore=0 suspectscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 mlxlogscore=999 spamscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507010047

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
Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 block/blk-mq-sched.c | 65 ++++++++++++++++++++++++++++++++++++++++++++
 block/blk-mq-sched.h |  4 +++
 block/blk-mq.c       | 16 +++++++++--
 block/blk.h          |  3 +-
 block/elevator.c     |  6 ++--
 5 files changed, 88 insertions(+), 6 deletions(-)

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
index 4806b867e37d..af7aae699ede 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4972,6 +4972,8 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 	struct request_queue *q;
 	int prev_nr_hw_queues = set->nr_hw_queues;
 	unsigned int memflags;
+	struct xarray et_table;
+	struct elevator_tags *et;
 	int i;
 
 	lockdep_assert_held(&set->tag_list_lock);
@@ -4984,6 +4986,11 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
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
@@ -4995,6 +5002,7 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 	if (blk_mq_realloc_tag_set_tags(set, nr_hw_queues) < 0) {
 		list_for_each_entry(q, &set->tag_list, tag_set_list)
 			blk_mq_unfreeze_queue_nomemrestore(q);
+		blk_mq_free_sched_tags_batch(&et_table, set);
 		goto reregister;
 	}
 
@@ -5018,8 +5026,10 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 	}
 
 	/* elv_update_nr_hw_queues() unfreeze queue for us */
-	list_for_each_entry(q, &set->tag_list, tag_set_list)
-		elv_update_nr_hw_queues(q);
+	list_for_each_entry(q, &set->tag_list, tag_set_list) {
+		et = xa_load(&et_table, q->id);
+		elv_update_nr_hw_queues(q, et);
+	}
 
 reregister:
 	list_for_each_entry(q, &set->tag_list, tag_set_list) {
@@ -5029,7 +5039,9 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 		blk_mq_remove_hw_queues_cpuhp(q);
 		blk_mq_add_hw_queues_cpuhp(q);
 	}
+out_memalloc_restore:
 	memalloc_noio_restore(memflags);
+	xa_destroy(&et_table);
 
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
index 50f4b78efe66..92a0a4851583 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -705,7 +705,7 @@ static int elevator_change(struct request_queue *q, struct elv_change_ctx *ctx)
  * The I/O scheduler depends on the number of hardware queues, this forces a
  * reattachment when nr_hw_queues changes.
  */
-void elv_update_nr_hw_queues(struct request_queue *q)
+void elv_update_nr_hw_queues(struct request_queue *q, struct elevator_tags *et)
 {
 	struct blk_mq_tag_set *set = q->tag_set;
 	struct elv_change_ctx ctx = {};
@@ -720,11 +720,11 @@ void elv_update_nr_hw_queues(struct request_queue *q)
 	 * acquires same lock in the reader context) can't run concurrently.
 	 */
 	if (q->elevator) {
-		ctx.et = blk_mq_alloc_sched_tags(set, set->nr_hw_queues);
-		if (!ctx.et) {
+		if (!et) {
 			WARN_ON_ONCE(1);
 			return;
 		}
+		ctx.et = et;
 	}
 
 	mutex_lock(&q->elevator_lock);
-- 
2.50.0

