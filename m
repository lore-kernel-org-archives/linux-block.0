Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375F22EBBAC
	for <linux-block@vger.kernel.org>; Fri, 27 Jun 2025 17:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751046973; cv=none; b=UZ1YyKTAdIOVq4KOGFUQu+K5H75yNaBBmxcPlV/yeuC/Kg9VNWy0jv0yHqXBLC9Bd6inpegwDeaL6UP6L1ChSuP32T3rDlwMHnPIyMTXDkjBmGAK10GUNlbxVX+LrInUL/5KMcz81JI9LIkUPvFXPSPigrK5rncR1mjtafxt5OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751046973; c=relaxed/simple;
	bh=KkBNYTyQqFyeQhRX1kfX9lCu6fWDJSpDgZuK5robtEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QQl0stOTYHI4m4mUaNqUdBQSp3GX+eTR3pzQyX4LH/xNOx8hOxDvZDYFKdc6uMQK1EZIwp4hv6atfwAwa/5MddShi0mrKYzIcPZzazX1mxIoV3wdxO7xu0ck5PzD0CbHyWFyqzwL0y96Z3Xm5rJBwidL5cG6KwLg+6bEcroRQno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bZ99bama; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bZ99bama"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55RBoFqt031218;
	Fri, 27 Jun 2025 17:56:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=mBGl/zFlk1AUOUXuT
	6jnYwvAAgp0tenIAAY6tpKhML4=; b=bZ99bamaZQvzar15Zv8Fw1W2hwJFVdOha
	whwsdAVV05QrW3Tr55U+RLKZNL3WRWFYWekw2NPVJlf9WX+J1LNszYB8ohlKQNX1
	WpJNxwpQ/wIqvL+50Tll4szf8gHzF7rO0izp3007ZizLVsQjYwvBb3B6tg3Dizs3
	US+EgZTrBaQhsekaLOcrb9TMEeD7WudTAYmQUeftKH3gJf4T/KBLDiTC5MRAP4q2
	mBuvomjvUTFUQ8dAS0odpH4Pe6AU7JlN5yadvor7bik2/HMITLV164W8xNQ+p1E+
	D7HRADOPDUbIxIjxQIwAB+hjiVddBc0f2xR1aRaaEmL2cX1edp3HQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dk64ekv3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Jun 2025 17:56:06 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55RHNp0L002471;
	Fri, 27 Jun 2025 17:56:06 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47e8jmn7eb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Jun 2025 17:56:05 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55RHu4kG53674242
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Jun 2025 17:56:04 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F3BD820043;
	Fri, 27 Jun 2025 17:56:03 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 965EA20040;
	Fri, 27 Jun 2025 17:56:00 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.61.18.63])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 27 Jun 2025 17:56:00 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-block@vger.kernel.org
Cc: hch@lst.de, ming.lei@redhat.com, axboe@kernel.dk, sth@linux.ibm.com,
        gjoyce@ibm.com
Subject: [PATCHv5 3/3] block: fix potential deadlock while running nr_hw_queue update
Date: Fri, 27 Jun 2025 23:25:21 +0530
Message-ID: <20250627175544.1063910-4-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250627175544.1063910-1-nilay@linux.ibm.com>
References: <20250627175544.1063910-1-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI3MDE0NCBTYWx0ZWRfXxU06VZa+BGzK Fl1J+e7nxuqVwG6FUxRl4V92b9rCzxVc8O/9kkBZh76vVQS0Ms0aossNZ9kLomrp2nryH1njZ5U ipM6iZHUeunkFEKpuiCvTVeZCOIegWULVNi/dYozVTGy+ez+h+k2JpRX+otsNS+i643n1PuQHx/
 K6XqSMttJDABjAFtsfDdqpzw9mMcAmKOhPW9y7fSiJO8hMOAtRV/85+spFaV2F+bLu5z9wqOZsu q8kRidsqjQh0zCP+PjkW4oetBBVt89saei/kMhhjyJ8dBXDxL6Cf1qcEVfvOGcNLyxy3Qf1QN1H SYLrh/L87Ql3JjAzdgFf9YeZDxl2DtLIVfC0oiVRSu2FMwVaLguq8SbA5TuTkmR/dJFayTyA+4s
 9RySkwB/4egnM8nCZyLj16bpkTUQJJAJdz+3eZXJs0O7ebpqtQaK1yajJWXEWSextLHd9JhY
X-Proofpoint-ORIG-GUID: NCX8Cmb_n3LXeoNWYqTZza2aLK210wXa
X-Proofpoint-GUID: NCX8Cmb_n3LXeoNWYqTZza2aLK210wXa
X-Authority-Analysis: v=2.4 cv=BfvY0qt2 c=1 sm=1 tr=0 ts=685edb36 cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=D50k6dCgwcB5hzXsUiIA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-27_05,2025-06-26_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 suspectscore=0 adultscore=0 spamscore=0
 impostorscore=0 mlxlogscore=999 malwarescore=0 phishscore=0 bulkscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506270144

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
index 7bc15b4cff89..dcc4036647b0 100644
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
@@ -476,6 +500,45 @@ struct elevator_tags *blk_mq_alloc_sched_tags(struct blk_mq_tag_set *set,
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
2.49.0

