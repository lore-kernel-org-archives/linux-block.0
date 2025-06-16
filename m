Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9249C288C29
	for <linux-block@vger.kernel.org>; Mon, 16 Jun 2025 17:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750095195; cv=none; b=jxIoN5fQ75HN8XeUTjZ06Yw/QVdMrKoqVkGFt4V0JHtDeRFu89v+aa5lQJK31NDt+s5fq6XWtj/G3YSEP6As3/PDpcAx8UNO2fe+rLL3JtmAsVy8kP/WSbXcM9/idIMA95fPre63NiGfdU5JtWXzI6LZfKfgoKctz832e6KUXMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750095195; c=relaxed/simple;
	bh=u86Ttvc3ZNjmcgeFkqu3NfQkVQxPgO4ZMajUZC5cYT0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=orG2LlQbbO/DvNgvZ4Z69FDuDMzUw1RGUPcllmVxz5CgiRxK4AfMbD4DJxMhJL7TCusMLWDtB/O47oD+Ra7B+VC7NJ+Z5DnIlvUmeKVmPLDCx37/vxVLDIkxI4eFpHD5dgmTEQ+8cs4pcltkDW9qtyjn8jChnJN+3dkRivOuybw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GiDfiL+Z; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GiDfiL+Z"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55G9fIEK017152;
	Mon, 16 Jun 2025 17:33:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ZBXm1u3DMhOMuNTV9
	HOBxnZAMI4OL4rnVOLsMCsf25U=; b=GiDfiL+ZQkHt/Cb1MY8B2UAkb/+S6FQVN
	QpwWLynPwlQmmim1Ks3Lv5fmxaPm7CMWgZEyiWYaQE6+RISs2IUXJH+GHNanTzI9
	0B7EWq2+KI35s/O2De5ptNm7qhkD46EyievlBV7JOh85zASBiAP87Jo2E61FbRGy
	KvWlFHnKsoWOIwR8b3GBPZmPIEvnrPfjHcqjzs19cJ3rO/dR9Q4w+n6um+4bKOXt
	v6zrOyuUo/jm89fZkRXUs7sPyCksiHgidmpvMMJvyx8DdUkNDdnOgVkOnjlbBIVD
	1OC+laI7raeegv9NqsiWFf28M/BWgswzgLg6rMbp5b+K6jmsEhz3g==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4790s4bbc2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Jun 2025 17:33:05 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55GHPQsD025755;
	Mon, 16 Jun 2025 17:33:04 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 479xy5naht-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Jun 2025 17:33:04 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55GHX2Sg18284826
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Jun 2025 17:33:02 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 861592004B;
	Mon, 16 Jun 2025 17:33:02 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4E53120040;
	Mon, 16 Jun 2025 17:32:59 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.61.44.139])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 16 Jun 2025 17:32:58 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-block@vger.kernel.org
Cc: ming.lei@redhat.com, hch@lst.de, axboe@kernel.dk, sth@linux.ibm.com,
        gjoyce@ibm.com
Subject: [PATCHv3 2/2] block: fix lock dependency between percpu alloc lock and elevator lock
Date: Mon, 16 Jun 2025 23:02:26 +0530
Message-ID: <20250616173233.3803824-3-nilay@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE2MDExNSBTYWx0ZWRfX0w1l0DKF9J5E YjnGZ6tl2pEMKGqv956XPzSGngE4rpmkjqCSM+OB5Da6h3ESghClwGQF1zCB9cjhGIIiLa/Y5Id /6eLxLlfnzeL7N2IdTIVFNGd/rr76jCFnUcuasutHAuy55L89CsOmGe5naufrJMQliXVbdjq1KA
 UqGtOvtMXWONZEmkrjea7y79g99tbvEOBOC+yWmWbgd+y3uiC5JWf5pYgiwu4ihn2+3YYBl6+jV fbYGeKAOSMcZP3zs45LcyihsIv9GaorgncICnE7tIqMQrd7zAR46lyDK8G+h1p1ahq7NxHFrDZs Me6pE6kFhFlRvnZo6gyKcI1wnqxo2T0ScMUqLjnTIoV+cKlxQMWt3Dm4pRrr06Awd+FtmHAZeOV
 WkSuTISBRzdfckefhN5n2hV4Jget53t8DF/GRxL1lxJU+EUjN7SAjhVI1OvbMWmQJxPYyHCp
X-Proofpoint-ORIG-GUID: rRiHOV8LVQE6sFrHMabrhIBlob7t3pv6
X-Authority-Analysis: v=2.4 cv=Qc9mvtbv c=1 sm=1 tr=0 ts=68505551 cx=c_pps a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=HgeCGqvi6TDAvQlOVBEA:9
X-Proofpoint-GUID: rRiHOV8LVQE6sFrHMabrhIBlob7t3pv6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-16_08,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 spamscore=0 impostorscore=0 phishscore=0 mlxscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506160115

Recent lockdep reports [1] have revealed a potential deadlock caused by a
lock dependency between the percpu allocator lock and the elevator lock.
This issue can be avoided by ensuring that the allocation and release of
scheduler tags (sched_tags) are performed outside the elevator lock.
Furthermore, the queue does not need to be remain frozen during these
operations.

To address this, move all sched_tags allocations and deallocations outside
of both the ->elevator_lock and the ->freeze_lock. Moreover, since the
lifetime of the elevator queue and its associated sched_tags is closely
tied, the allocated sched_tags are now stored in the elevator queue
structure. Then, during the actual elevator switch (which runs under
->freeze_lock and ->elevator_lock), the pre-allocated sched_tags are
assigned to the appropriate q->hctx. Once the elevator switch is complete
and the locks are released, the old elevator queue and its associated
sched_tags are freed.

This restructuring ensures that sched_tags memory management occurs
entirely outside of the ->elevator_lock and ->freeze_lock context,
eliminating the lock dependency problem seen during scheduler updates
or hardware queue update.

[1] https://lore.kernel.org/all/0659ea8d-a463-47c8-9180-43c719e106eb@linux.ibm.com/

Reported-by: Stefan Haberland <sth@linux.ibm.com>
Closes: https://lore.kernel.org/all/0659ea8d-a463-47c8-9180-43c719e106eb@linux.ibm.com/
Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 block/blk-mq-sched.c | 244 +++++++++++++++++++++++++++++++------------
 block/blk-mq-sched.h |  13 ++-
 block/blk-mq.c       |  14 ++-
 block/blk.h          |   4 +-
 block/elevator.c     |  82 +++++++++++----
 block/elevator.h     |  28 ++++-
 6 files changed, 296 insertions(+), 89 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index d914eb9d61a6..dd00d8c9fb78 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -374,27 +374,17 @@ bool blk_mq_sched_try_insert_merge(struct request_queue *q, struct request *rq,
 }
 EXPORT_SYMBOL_GPL(blk_mq_sched_try_insert_merge);
 
-static int blk_mq_sched_alloc_map_and_rqs(struct request_queue *q,
-					  struct blk_mq_hw_ctx *hctx,
-					  unsigned int hctx_idx)
+static void blk_mq_init_sched_tags(struct request_queue *q,
+				   struct blk_mq_hw_ctx *hctx,
+				   unsigned int hctx_idx,
+				   struct elevator_queue *eq)
 {
 	if (blk_mq_is_shared_tags(q->tag_set->flags)) {
 		hctx->sched_tags = q->sched_shared_tags;
-		return 0;
+		return;
 	}
 
-	hctx->sched_tags = blk_mq_alloc_map_and_rqs(q->tag_set, hctx_idx,
-						    q->nr_requests);
-
-	if (!hctx->sched_tags)
-		return -ENOMEM;
-	return 0;
-}
-
-static void blk_mq_exit_sched_shared_tags(struct request_queue *queue)
-{
-	blk_mq_free_rq_map(queue->sched_shared_tags);
-	queue->sched_shared_tags = NULL;
+	hctx->sched_tags = eq->tags->u.tags[hctx_idx];
 }
 
 /* called in queue's release handler, tagset has gone away */
@@ -403,35 +393,18 @@ static void blk_mq_sched_tags_teardown(struct request_queue *q, unsigned int fla
 	struct blk_mq_hw_ctx *hctx;
 	unsigned long i;
 
-	queue_for_each_hw_ctx(q, hctx, i) {
-		if (hctx->sched_tags) {
-			if (!blk_mq_is_shared_tags(flags))
-				blk_mq_free_rq_map(hctx->sched_tags);
-			hctx->sched_tags = NULL;
-		}
-	}
+	queue_for_each_hw_ctx(q, hctx, i)
+		hctx->sched_tags = NULL;
 
 	if (blk_mq_is_shared_tags(flags))
-		blk_mq_exit_sched_shared_tags(q);
+		q->sched_shared_tags = NULL;
 }
 
-static int blk_mq_init_sched_shared_tags(struct request_queue *queue)
+static void blk_mq_init_sched_shared_tags(struct request_queue *queue,
+		struct elevator_queue *eq)
 {
-	struct blk_mq_tag_set *set = queue->tag_set;
-
-	/*
-	 * Set initial depth at max so that we don't need to reallocate for
-	 * updating nr_requests.
-	 */
-	queue->sched_shared_tags = blk_mq_alloc_map_and_rqs(set,
-						BLK_MQ_NO_HCTX_IDX,
-						MAX_SCHED_RQ);
-	if (!queue->sched_shared_tags)
-		return -ENOMEM;
-
+	queue->sched_shared_tags = eq->tags->u.shared_tags;
 	blk_mq_tag_update_sched_shared_tags(queue);
-
-	return 0;
 }
 
 void blk_mq_sched_reg_debugfs(struct request_queue *q)
@@ -458,8 +431,165 @@ void blk_mq_sched_unreg_debugfs(struct request_queue *q)
 	mutex_unlock(&q->debugfs_mutex);
 }
 
+void __blk_mq_free_sched_tags(struct blk_mq_tag_set *set,
+		struct elevator_tags *tags)
+{
+	unsigned long i;
+
+	if (!tags)
+		return;
+
+	if (blk_mq_is_shared_tags(set->flags)) {
+		if (tags->u.shared_tags) {
+			blk_mq_free_rqs(set, tags->u.shared_tags,
+					BLK_MQ_NO_HCTX_IDX);
+			blk_mq_free_rq_map(tags->u.shared_tags);
+		}
+		goto out;
+	}
+
+	if (!tags->u.tags)
+		goto out;
+
+	for (i = 0; i < tags->nr_hw_queues; i++) {
+		if (tags->u.tags[i]) {
+			blk_mq_free_rqs(set, tags->u.tags[i], i);
+			blk_mq_free_rq_map(tags->u.tags[i]);
+		}
+	}
+
+	kfree(tags->u.tags);
+out:
+	kfree(tags);
+}
+
+void blk_mq_free_sched_tags(struct blk_mq_tag_set *set,
+		struct elevator_tags **tags)
+{
+	unsigned long i, count = 0;
+	struct request_queue *q;
+
+	lockdep_assert_held_write(&set->update_nr_hwq_lock);
+
+	if (!tags)
+		return;
+
+	/*
+	 * Accessing q->elevator without holding q->elevator_lock is safe
+	 * because we're holding here set->update_nr_hwq_lock in the writer
+	 * context. So, scheduler update/switch code (which acquires the same
+	 * lock but in the reader context) can't run concurrently.
+	 */
+	list_for_each_entry(q, &set->tag_list, tag_set_list) {
+		if (q->elevator)
+			count++;
+	}
+
+	for (i = 0; i < count; i++)
+		__blk_mq_free_sched_tags(set, tags[i]);
+
+	kfree(tags);
+}
+
+struct elevator_tags *__blk_mq_alloc_sched_tags(struct blk_mq_tag_set *set,
+				unsigned int nr_hw_queues, int id)
+{
+	unsigned int i;
+	struct elevator_tags *tags;
+	gfp_t gfp = GFP_NOIO | __GFP_NOWARN | __GFP_NORETRY;
+
+	tags = kcalloc(1, sizeof(struct elevator_tags), gfp);
+	if (!tags)
+		return NULL;
+
+	tags->id = id;
+	/*
+	 * Default to double of smaller one between hw queue_depth and
+	 * 128, since we don't split into sync/async like the old code
+	 * did. Additionally, this is a per-hw queue depth.
+	 */
+	tags->nr_requests = 2 * min_t(unsigned int, set->queue_depth,
+			BLKDEV_DEFAULT_RQ);
+
+	if (blk_mq_is_shared_tags(set->flags)) {
+
+		tags->u.shared_tags = blk_mq_alloc_map_and_rqs(set,
+					BLK_MQ_NO_HCTX_IDX,
+					MAX_SCHED_RQ);
+		if (!tags->u.shared_tags)
+			goto out;
+
+		return tags;
+	}
+
+	tags->u.tags = kcalloc(nr_hw_queues, sizeof(struct blk_mq_tags *), gfp);
+	if (!tags->u.tags)
+		goto out;
+
+	tags->nr_hw_queues = nr_hw_queues;
+	for (i = 0; i < nr_hw_queues; i++) {
+		tags->u.tags[i] = blk_mq_alloc_map_and_rqs(set, i,
+				tags->nr_requests);
+		if (!tags->u.tags[i])
+			goto out;
+	}
+
+	return tags;
+
+out:
+	__blk_mq_free_sched_tags(set, tags);
+	return NULL;
+}
+
+int blk_mq_alloc_sched_tags(struct blk_mq_tag_set *set,
+			    unsigned int nr_hw_queues,
+			    struct elevator_tags ***elv_tags)
+{
+	unsigned long idx = 0, count = 0;
+	struct request_queue *q;
+	struct elevator_tags **tags;
+	gfp_t gfp = GFP_NOIO | __GFP_NOWARN | __GFP_NORETRY;
+
+	lockdep_assert_held_write(&set->update_nr_hwq_lock);
+	/*
+	 * Accessing q->elevator without holding q->elevator_lock is safe
+	 * because we're holding here set->update_nr_hwq_lock in the writer
+	 * context. So, scheduler update/switch code (which acquires the same
+	 * lock but in the reader context) can't run concurrently.
+	 */
+	list_for_each_entry(q, &set->tag_list, tag_set_list) {
+		if (q->elevator)
+			count++;
+	}
+
+	if (!count)
+		return 0;
+
+	tags = kcalloc(count, sizeof(struct elevator_tags *), gfp);
+	if (!tags)
+		return -ENOMEM;
+
+	list_for_each_entry(q, &set->tag_list, tag_set_list) {
+		if (q->elevator) {
+			tags[idx] = __blk_mq_alloc_sched_tags(set, nr_hw_queues,
+					q->id);
+			if (!tags[idx])
+				goto out;
+
+			idx++;
+		}
+	}
+
+	*elv_tags = tags;
+	return count;
+out:
+	blk_mq_free_sched_tags(set, tags);
+	return -ENOMEM;
+}
+
 /* caller must have a reference to @e, will grab another one if successful */
-int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e)
+int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e,
+		struct elevator_tags *tags)
 {
 	unsigned int flags = q->tag_set->flags;
 	struct blk_mq_hw_ctx *hctx;
@@ -467,40 +597,26 @@ int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e)
 	unsigned long i;
 	int ret;
 
-	/*
-	 * Default to double of smaller one between hw queue_depth and 128,
-	 * since we don't split into sync/async like the old code did.
-	 * Additionally, this is a per-hw queue depth.
-	 */
-	q->nr_requests = 2 * min_t(unsigned int, q->tag_set->queue_depth,
-				   BLKDEV_DEFAULT_RQ);
-
-	eq = elevator_alloc(q, e);
+	eq = elevator_alloc(q, e, tags);
 	if (!eq)
 		return -ENOMEM;
 
-	if (blk_mq_is_shared_tags(flags)) {
-		ret = blk_mq_init_sched_shared_tags(q);
-		if (ret)
-			return ret;
-	}
+	q->nr_requests = tags->nr_requests;
 
-	queue_for_each_hw_ctx(q, hctx, i) {
-		ret = blk_mq_sched_alloc_map_and_rqs(q, hctx, i);
-		if (ret)
-			goto err_free_map_and_rqs;
-	}
+	if (blk_mq_is_shared_tags(flags))
+		blk_mq_init_sched_shared_tags(q, eq);
+
+	queue_for_each_hw_ctx(q, hctx, i)
+		blk_mq_init_sched_tags(q, hctx, i, eq);
 
 	ret = e->ops.init_sched(q, eq);
 	if (ret)
-		goto err_free_map_and_rqs;
+		goto out;
 
 	queue_for_each_hw_ctx(q, hctx, i) {
 		if (e->ops.init_hctx) {
 			ret = e->ops.init_hctx(hctx, i);
 			if (ret) {
-				eq = q->elevator;
-				blk_mq_sched_free_rqs(q);
 				blk_mq_exit_sched(q, eq);
 				kobject_put(&eq->kobj);
 				return ret;
@@ -509,10 +625,8 @@ int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e)
 	}
 	return 0;
 
-err_free_map_and_rqs:
-	blk_mq_sched_free_rqs(q);
+out:
 	blk_mq_sched_tags_teardown(q, flags);
-
 	kobject_put(&eq->kobj);
 	q->elevator = NULL;
 	return ret;
diff --git a/block/blk-mq-sched.h b/block/blk-mq-sched.h
index 1326526bb733..01c43192b98a 100644
--- a/block/blk-mq-sched.h
+++ b/block/blk-mq-sched.h
@@ -18,7 +18,18 @@ void __blk_mq_sched_restart(struct blk_mq_hw_ctx *hctx);
 
 void blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx);
 
-int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e);
+void __blk_mq_free_sched_tags(struct blk_mq_tag_set *set,
+		struct elevator_tags *tags);
+void blk_mq_free_sched_tags(struct blk_mq_tag_set *set,
+		struct elevator_tags **elv_t);
+int blk_mq_alloc_sched_tags(struct blk_mq_tag_set *set,
+			    unsigned int nr_hw_queues,
+			    struct elevator_tags ***tags);
+struct elevator_tags *__blk_mq_alloc_sched_tags(struct blk_mq_tag_set *set,
+		unsigned int nr_hw_queues, int id);
+
+int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e,
+		struct elevator_tags *elv_t);
 void blk_mq_exit_sched(struct request_queue *q, struct elevator_queue *e);
 void blk_mq_sched_free_rqs(struct request_queue *q);
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 4806b867e37d..b8b616c79742 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4970,6 +4970,8 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 							int nr_hw_queues)
 {
 	struct request_queue *q;
+	int count;
+	struct elevator_tags **elv_tags = NULL;
 	int prev_nr_hw_queues = set->nr_hw_queues;
 	unsigned int memflags;
 	int i;
@@ -4984,6 +4986,11 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 		return;
 
 	memflags = memalloc_noio_save();
+
+	count = blk_mq_alloc_sched_tags(set, nr_hw_queues, &elv_tags);
+	if (count < 0)
+		goto out;
+
 	list_for_each_entry(q, &set->tag_list, tag_set_list) {
 		blk_mq_debugfs_unregister_hctxs(q);
 		blk_mq_sysfs_unregister_hctxs(q);
@@ -4995,6 +5002,9 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 	if (blk_mq_realloc_tag_set_tags(set, nr_hw_queues) < 0) {
 		list_for_each_entry(q, &set->tag_list, tag_set_list)
 			blk_mq_unfreeze_queue_nomemrestore(q);
+
+		blk_mq_free_sched_tags(set, elv_tags);
+		elv_tags = NULL;
 		goto reregister;
 	}
 
@@ -5019,7 +5029,7 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 
 	/* elv_update_nr_hw_queues() unfreeze queue for us */
 	list_for_each_entry(q, &set->tag_list, tag_set_list)
-		elv_update_nr_hw_queues(q);
+		elv_update_nr_hw_queues(q, elv_tags, count);
 
 reregister:
 	list_for_each_entry(q, &set->tag_list, tag_set_list) {
@@ -5029,6 +5039,8 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 		blk_mq_remove_hw_queues_cpuhp(q);
 		blk_mq_add_hw_queues_cpuhp(q);
 	}
+	kfree(elv_tags);
+out:
 	memalloc_noio_restore(memflags);
 
 	/* Free the excess tags when nr_hw_queues shrink. */
diff --git a/block/blk.h b/block/blk.h
index 37ec459fe656..cd50305da84e 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -10,6 +10,7 @@
 #include <linux/timekeeping.h>
 #include <xen/xen.h>
 #include "blk-crypto-internal.h"
+#include "elevator.h"
 
 struct elevator_type;
 
@@ -321,7 +322,8 @@ bool blk_bio_list_merge(struct request_queue *q, struct list_head *list,
 
 bool blk_insert_flush(struct request *rq);
 
-void elv_update_nr_hw_queues(struct request_queue *q);
+void elv_update_nr_hw_queues(struct request_queue *q,
+		struct elevator_tags **elv_tags, int count);
 void elevator_set_default(struct request_queue *q);
 void elevator_set_none(struct request_queue *q);
 
diff --git a/block/elevator.c b/block/elevator.c
index ab22542e6cf0..849dbe347cb2 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -45,17 +45,6 @@
 #include "blk-wbt.h"
 #include "blk-cgroup.h"
 
-/* Holding context data for changing elevator */
-struct elv_change_ctx {
-	const char *name;
-	bool no_uevent;
-
-	/* for unregistering old elevator */
-	struct elevator_queue *old;
-	/* for registering new elevator */
-	struct elevator_queue *new;
-};
-
 static DEFINE_SPINLOCK(elv_list_lock);
 static LIST_HEAD(elv_list);
 
@@ -132,7 +121,7 @@ static struct elevator_type *elevator_find_get(const char *name)
 static const struct kobj_type elv_ktype;
 
 struct elevator_queue *elevator_alloc(struct request_queue *q,
-				  struct elevator_type *e)
+		struct elevator_type *e, struct elevator_tags *tags)
 {
 	struct elevator_queue *eq;
 
@@ -142,6 +131,7 @@ struct elevator_queue *elevator_alloc(struct request_queue *q,
 
 	__elevator_get(e);
 	eq->type = e;
+	eq->tags = tags;
 	kobject_init(&eq->kobj, &elv_ktype);
 	mutex_init(&eq->sysfs_lock);
 	hash_init(eq->hash);
@@ -166,13 +156,25 @@ static void elevator_exit(struct request_queue *q)
 	lockdep_assert_held(&q->elevator_lock);
 
 	ioc_clear_queue(q);
-	blk_mq_sched_free_rqs(q);
 
 	mutex_lock(&e->sysfs_lock);
 	blk_mq_exit_sched(q, e);
 	mutex_unlock(&e->sysfs_lock);
 }
 
+static struct elevator_tags *elevator_tags_lookup(struct elevator_tags **tags,
+		struct request_queue *q, int count)
+{
+	int i;
+
+	for (i = 0; i < count; i++) {
+		if (tags[i]->id == q->id)
+			return tags[i];
+	}
+
+	return NULL;
+}
+
 static inline void __elv_rqhash_del(struct request *rq)
 {
 	hash_del(&rq->hash);
@@ -570,7 +572,8 @@ EXPORT_SYMBOL_GPL(elv_unregister);
  * If switching fails, we are most likely running out of memory and not able
  * to restore the old io scheduler, so leaving the io scheduler being none.
  */
-static int elevator_switch(struct request_queue *q, struct elv_change_ctx *ctx)
+static int elevator_switch(struct request_queue *q, struct elv_change_ctx *ctx,
+		struct elevator_tags *tags)
 {
 	struct elevator_type *new_e = NULL;
 	int ret = 0;
@@ -592,7 +595,7 @@ static int elevator_switch(struct request_queue *q, struct elv_change_ctx *ctx)
 	}
 
 	if (new_e) {
-		ret = blk_mq_init_sched(q, new_e);
+		ret = blk_mq_init_sched(q, new_e, tags);
 		if (ret)
 			goto out_unfreeze;
 		ctx->new = q->elevator;
@@ -627,8 +630,10 @@ static void elv_exit_and_release(struct request_queue *q)
 	elevator_exit(q);
 	mutex_unlock(&q->elevator_lock);
 	blk_mq_unfreeze_queue(q, memflags);
-	if (e)
+	if (e) {
+		__blk_mq_free_sched_tags(q->tag_set, e->tags);
 		kobject_put(&e->kobj);
+	}
 }
 
 static int elevator_change_done(struct request_queue *q,
@@ -641,6 +646,7 @@ static int elevator_change_done(struct request_queue *q,
 				&ctx->old->flags);
 
 		elv_unregister_queue(q, ctx->old);
+		__blk_mq_free_sched_tags(q->tag_set, ctx->old->tags);
 		kobject_put(&ctx->old->kobj);
 		if (enable_wbt)
 			wbt_enable_default(q->disk);
@@ -659,9 +665,17 @@ static int elevator_change_done(struct request_queue *q,
 static int elevator_change(struct request_queue *q, struct elv_change_ctx *ctx)
 {
 	unsigned int memflags;
+	struct elevator_tags *tags = NULL;
+	struct blk_mq_tag_set *set = q->tag_set;
 	int ret = 0;
 
-	lockdep_assert_held(&q->tag_set->update_nr_hwq_lock);
+	lockdep_assert_held(&set->update_nr_hwq_lock);
+
+	if (strncmp(ctx->name, "none", 4)) {
+		tags = __blk_mq_alloc_sched_tags(set, set->nr_hw_queues, q->id);
+		if (!tags)
+			return -ENOMEM;
+	}
 
 	memflags = blk_mq_freeze_queue(q);
 	/*
@@ -676,11 +690,16 @@ static int elevator_change(struct request_queue *q, struct elv_change_ctx *ctx)
 	blk_mq_cancel_work_sync(q);
 	mutex_lock(&q->elevator_lock);
 	if (!(q->elevator && elevator_match(q->elevator->type, ctx->name)))
-		ret = elevator_switch(q, ctx);
+		ret = elevator_switch(q, ctx, tags);
 	mutex_unlock(&q->elevator_lock);
 	blk_mq_unfreeze_queue(q, memflags);
 	if (!ret)
 		ret = elevator_change_done(q, ctx);
+	/*
+	 * Free sched tags if it's allocated but we couldn't switch elevator.
+	 */
+	if (tags && !ctx->new)
+		__blk_mq_free_sched_tags(set, tags);
 
 	return ret;
 }
@@ -689,24 +708,47 @@ static int elevator_change(struct request_queue *q, struct elv_change_ctx *ctx)
  * The I/O scheduler depends on the number of hardware queues, this forces a
  * reattachment when nr_hw_queues changes.
  */
-void elv_update_nr_hw_queues(struct request_queue *q)
+void elv_update_nr_hw_queues(struct request_queue *q,
+		struct elevator_tags **elv_tags, int count)
 {
+	struct elevator_tags *tags = NULL;
+	struct blk_mq_tag_set *set = q->tag_set;
 	struct elv_change_ctx ctx = {};
 	int ret = -ENODEV;
 
 	WARN_ON_ONCE(q->mq_freeze_depth == 0);
 
+	/*
+	 * Accessing q->elevator without holding q->elevator_lock is safe here
+	 * because nr_hw_queue update is protected by set->update_nr_hwq_lock
+	 * in the writer context. So, scheduler update/switch code (which
+	 * acquires same lock in the reader context) can't run concurrently.
+	 */
+	if (q->elevator) {
+		tags = elevator_tags_lookup(elv_tags, q, count);
+		if (!tags) {
+			WARN_ON(1);
+			goto out_unfreeze;
+		}
+	}
+
 	mutex_lock(&q->elevator_lock);
 	if (q->elevator && !blk_queue_dying(q) && blk_queue_registered(q)) {
 		ctx.name = q->elevator->type->elevator_name;
 
 		/* force to reattach elevator after nr_hw_queue is updated */
-		ret = elevator_switch(q, &ctx);
+		ret = elevator_switch(q, &ctx, tags);
 	}
 	mutex_unlock(&q->elevator_lock);
+out_unfreeze:
 	blk_mq_unfreeze_queue_nomemrestore(q);
 	if (!ret)
 		WARN_ON_ONCE(elevator_change_done(q, &ctx));
+	/*
+	 * Free sched tags if it's allocated but we couldn't switch elevator.
+	 */
+	if (tags && !ctx.new)
+		__blk_mq_free_sched_tags(set, tags);
 }
 
 /*
diff --git a/block/elevator.h b/block/elevator.h
index a4de5f9ad790..0b92121005cf 100644
--- a/block/elevator.h
+++ b/block/elevator.h
@@ -23,6 +23,17 @@ enum elv_merge {
 struct blk_mq_alloc_data;
 struct blk_mq_hw_ctx;
 
+/* Holding context data for changing elevator */
+struct elv_change_ctx {
+	const char *name;
+	bool no_uevent;
+
+	/* for unregistering old elevator */
+	struct elevator_queue *old;
+	/* for registering new elevator */
+	struct elevator_queue *new;
+};
+
 struct elevator_mq_ops {
 	int (*init_sched)(struct request_queue *, struct elevator_queue *);
 	void (*exit_sched)(struct elevator_queue *);
@@ -107,12 +118,27 @@ void elv_rqhash_add(struct request_queue *q, struct request *rq);
 void elv_rqhash_reposition(struct request_queue *q, struct request *rq);
 struct request *elv_rqhash_find(struct request_queue *q, sector_t offset);
 
+struct elevator_tags {
+	/* num. of hardware queues for which tags are allocated */
+	unsigned int nr_hw_queues;
+	/* depth used while allocating tags */
+	unsigned int nr_requests;
+	/* request queue id (q->id) used during elevator_tags_lookup() */
+	int id;
+	union {
+		/* tags shared across all queues */
+		struct blk_mq_tags *shared_tags;
+		/* array of blk_mq_tags pointers, one per hardware queue. */
+		struct blk_mq_tags **tags;
+	} u;
+};
 /*
  * each queue has an elevator_queue associated with it
  */
 struct elevator_queue
 {
 	struct elevator_type *type;
+	struct elevator_tags *tags;
 	void *elevator_data;
 	struct kobject kobj;
 	struct mutex sysfs_lock;
@@ -153,7 +179,7 @@ ssize_t elv_iosched_store(struct gendisk *disk, const char *page, size_t count);
 
 extern bool elv_bio_merge_ok(struct request *, struct bio *);
 extern struct elevator_queue *elevator_alloc(struct request_queue *,
-					struct elevator_type *);
+		struct elevator_type *, struct elevator_tags *);
 
 /*
  * Helper functions.
-- 
2.49.0

