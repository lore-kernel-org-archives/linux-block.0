Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF30E257AEE
	for <linux-block@vger.kernel.org>; Mon,  4 Aug 2025 12:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754310104; cv=none; b=ChIkhbHcUwsjZZalbRWI5d1yonM2taqTQXF3l3xpZI43yYELfNqx3Nl734dPbuI5tHrcYZrmh3k1g/KkMeLWqTqu4S8RaUGNMsz1gUFGGOwmut1AeD5RKe+PonY9nTelShY3zJ45Lqs6u/Lxzq+RF0wOu4+mQohbiZ4BUQ9C36o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754310104; c=relaxed/simple;
	bh=qihhYwXDdEtH3wcpsuL5tLG5f9Gxlfpim1LPqSUuwlE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ApAOe8rhDZYrcPg4Ifr35tSF1D2uSwLffhdBfGe2H/37JZP9XintUNC6ptvWKnieJCtHVaJX5yJ4bx3QJAQmOw/JawClHaMr0eXlpEpi51tLhHBA5pIcUenrzqmi8rCg5x3Bljxz/uy1S/2YtzKqdT+Z8GY67pikkmjpvkJ85eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=M3V0OM3+; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="M3V0OM3+"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 574A3Et2014258;
	Mon, 4 Aug 2025 12:21:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=zAnEWSSb0FGTC6D9C
	Ed7XDctfdK8EfdcM99Us2uN/yM=; b=M3V0OM3+BI8cnv7U+XHL9tQv4UL8g4ZeG
	e1mQYLl4g1k9CxkXnDCITvt7z+Y035IkM3FEyssEaalsybzWfrlnZ59NS8HNb1rX
	ZehR1Ub+XydzTIjnmmKrh4uL4uaR8jC2X7IRvk9FNZ1rtpILa7ydhjUCsfwpjX1a
	QAnnfDRoxPmWFdpr8Yxh9hjE6ulO1wbWeb/6jQbAOySJjPsfoGePW1nKcMDgYwau
	uwZ8AQaXQvc68+HJXgFKG7DtepxY3f5H0Gnj4RYQH/ew43JwISszU1IXGKpeDHcz
	2ljR0P0//e5bxJR7rhPIFU0DiNvYXMuJsK+t4cHqfeJR5+aTq42IA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 489a6d8vp6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Aug 2025 12:21:32 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5749dNtX001855;
	Mon, 4 Aug 2025 12:21:31 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 489wcywwkf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Aug 2025 12:21:31 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 574CLTfA47710512
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 4 Aug 2025 12:21:29 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 90FDE20043;
	Mon,  4 Aug 2025 12:21:29 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DE6DA20040;
	Mon,  4 Aug 2025 12:21:27 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.in.ibm.com (unknown [9.109.198.209])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  4 Aug 2025 12:21:27 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-block@vger.kernel.org
Cc: axboe@kernel.dk, kch@nvidia.com, shinichiro.kawasaki@wdc.com, hch@lst.de,
        ming.lei@redhat.com, gjoyce@ibm.com
Subject: [PATCH 1/2] block: avoid cpu_hotplug_lock depedency on freeze_lock
Date: Mon,  4 Aug 2025 17:51:10 +0530
Message-ID: <20250804122125.3271397-2-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250804122125.3271397-1-nilay@linux.ibm.com>
References: <20250804122125.3271397-1-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA0MDA2OCBTYWx0ZWRfXyxeH0v17MoE1
 zZHpvzrWW/a1L9uWeSHwTcGUvap8KPij+gks2JKyua8Wxj/JEeIlug7PBhrsKe/Vh4xog37HxaM
 WmgL4mcUspC4YIdgrrvSjNJt+1eQSm82n5x9gNAhnDPPBqnqs6eioS5IY3tekBQXZaF1WpGIxMX
 rzX27/YtydBbzQYsVg8QnxtMCCZ7jLHTOv7tnOdYnzeoFbqrnYwJ9UUqlUf1VAD4AMavrNu5vh0
 BtzxIom5csdh59agN8Vah699P1wewtMdJyZ/CzaWH0wYUFqmaIJX8frDTAUaTF1ZkqpgtEHO0Ew
 TrcMGXm9jbRoKFe+I949f+QcgsJeBKBY0w/A7Spxt7IbNXYdJecmR0uyZjjmlg+29IkWnwwxaIf
 5CPZ31Xu0BxrOdrcpbakIIAJ7GQZT4ImfHrlTjRCz7VmiQivuS46yXlLv7Z4HNBVQkrQIQRD
X-Authority-Analysis: v=2.4 cv=Qp9e3Uyd c=1 sm=1 tr=0 ts=6890a5cc cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=twLY2_itOEWcE9j9UWoA:9
X-Proofpoint-ORIG-GUID: yFr-h9aDthKTA81wgHRt5gDE2MdZHm_m
X-Proofpoint-GUID: yFr-h9aDthKTA81wgHRt5gDE2MdZHm_m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-04_05,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 phishscore=0 malwarescore=0 adultscore=0 clxscore=1015
 priorityscore=1501 mlxlogscore=999 spamscore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508040068

A recent lockdep[1] splat observed while running blktest block/005
reveals a potential deadlock caused by the cpu_hotplug_lock dependency
on ->freeze_lock. This dependency was introduced by commit 033b667a823e
("block: blk-rq-qos: guard rq-qos helpers by static key").

That change added a static key to avoid fetching q->rq_qos when neither
blk-wbt nor blk-iolatency is configured. The static key dynamically
patches kernel text to a NOP when disabled, eliminating overhead of
fetching q->rq_qos in the I/O hot path. However, enabling a static key
at runtime requires acquiring both cpu_hotplug_lock and jump_label_mutex.
When this happens after the queue has already been frozen (i.e., while
holding ->freeze_lock), it creates a locking dependency from cpu_hotplug_
lock/jump_label_mutex to ->freeze_lock, which leads to a potential deadlock
reported by lockdep[1].

To resolve this, replace the static key mechanism with q->queue_flags:
QUEUE_FLAG_QOS_ENABLED. This flag is evaluated in the fast path before
accessing q->rq_qos. If the flag is set, we proceed to fetch q->rq_qos;
otherwise, the access is skipped.

Since q->queue_flags is commonly accessed in IO hotpath and resides in
the first cacheline of struct request_queue, checking it imposes minimal
overhead while eliminating the deadlock risk.

This change avoids the lockdep splat without introducing performance
regressions.

[1] https://lore.kernel.org/linux-block/4fdm37so3o4xricdgfosgmohn63aa7wj3ua4e5vpihoamwg3ui@fq42f5q5t5ic/

Fixes: 033b667a823e ("block: blk-rq-qos: guard rq-qos helpers by static key")
Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 block/blk-mq-debugfs.c |  1 +
 block/blk-rq-qos.c     |  6 ++----
 block/blk-rq-qos.h     | 45 +++++++++++++++++++++++++-----------------
 include/linux/blkdev.h |  1 +
 4 files changed, 31 insertions(+), 22 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 7ed3e71f2fc0..32c65efdda46 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -95,6 +95,7 @@ static const char *const blk_queue_flag_name[] = {
 	QUEUE_FLAG_NAME(SQ_SCHED),
 	QUEUE_FLAG_NAME(DISABLE_WBT_DEF),
 	QUEUE_FLAG_NAME(NO_ELV_SWITCH),
+	QUEUE_FLAG_NAME(QOS_ENABLED),
 };
 #undef QUEUE_FLAG_NAME
 
diff --git a/block/blk-rq-qos.c b/block/blk-rq-qos.c
index 848591fb3c57..460c04715321 100644
--- a/block/blk-rq-qos.c
+++ b/block/blk-rq-qos.c
@@ -2,8 +2,6 @@
 
 #include "blk-rq-qos.h"
 
-__read_mostly DEFINE_STATIC_KEY_FALSE(block_rq_qos);
-
 /*
  * Increment 'v', if 'v' is below 'below'. Returns true if we succeeded,
  * false if 'v' + 1 would be bigger than 'below'.
@@ -319,8 +317,8 @@ void rq_qos_exit(struct request_queue *q)
 		struct rq_qos *rqos = q->rq_qos;
 		q->rq_qos = rqos->next;
 		rqos->ops->exit(rqos);
-		static_branch_dec(&block_rq_qos);
 	}
+	blk_queue_flag_clear(QUEUE_FLAG_QOS_ENABLED, q);
 	mutex_unlock(&q->rq_qos_mutex);
 }
 
@@ -346,7 +344,7 @@ int rq_qos_add(struct rq_qos *rqos, struct gendisk *disk, enum rq_qos_id id,
 		goto ebusy;
 	rqos->next = q->rq_qos;
 	q->rq_qos = rqos;
-	static_branch_inc(&block_rq_qos);
+	blk_queue_flag_set(QUEUE_FLAG_QOS_ENABLED, q);
 
 	blk_mq_unfreeze_queue(q, memflags);
 
diff --git a/block/blk-rq-qos.h b/block/blk-rq-qos.h
index 39749f4066fb..0eeb5beb1f4d 100644
--- a/block/blk-rq-qos.h
+++ b/block/blk-rq-qos.h
@@ -12,7 +12,6 @@
 #include "blk-mq-debugfs.h"
 
 struct blk_mq_debugfs_attr;
-extern struct static_key_false block_rq_qos;
 
 enum rq_qos_id {
 	RQ_QOS_WBT,
@@ -113,43 +112,50 @@ void __rq_qos_queue_depth_changed(struct rq_qos *rqos);
 
 static inline void rq_qos_cleanup(struct request_queue *q, struct bio *bio)
 {
-	if (static_branch_unlikely(&block_rq_qos) && q->rq_qos)
+	if (unlikely(test_bit(QUEUE_FLAG_QOS_ENABLED, &q->queue_flags)) &&
+			q->rq_qos)
 		__rq_qos_cleanup(q->rq_qos, bio);
 }
 
 static inline void rq_qos_done(struct request_queue *q, struct request *rq)
 {
-	if (static_branch_unlikely(&block_rq_qos) && q->rq_qos &&
-	    !blk_rq_is_passthrough(rq))
+	if (unlikely(test_bit(QUEUE_FLAG_QOS_ENABLED, &q->queue_flags)) &&
+			q->rq_qos && !blk_rq_is_passthrough(rq))
 		__rq_qos_done(q->rq_qos, rq);
 }
 
-static inline void rq_qos_issue(struct request_queue *q, struct request *rq)
+static __maybe_unused noinline void rq_qos_issue(struct request_queue *q, struct request *rq)
 {
-	if (static_branch_unlikely(&block_rq_qos) && q->rq_qos)
+	if (unlikely(test_bit(QUEUE_FLAG_QOS_ENABLED, &q->queue_flags)) &&
+			q->rq_qos)
 		__rq_qos_issue(q->rq_qos, rq);
 }
 
 static inline void rq_qos_requeue(struct request_queue *q, struct request *rq)
 {
-	if (static_branch_unlikely(&block_rq_qos) && q->rq_qos)
+	if (unlikely(test_bit(QUEUE_FLAG_QOS_ENABLED, &q->queue_flags)) &&
+			q->rq_qos)
 		__rq_qos_requeue(q->rq_qos, rq);
 }
 
 static inline void rq_qos_done_bio(struct bio *bio)
 {
-	if (static_branch_unlikely(&block_rq_qos) &&
-	    bio->bi_bdev && (bio_flagged(bio, BIO_QOS_THROTTLED) ||
-			     bio_flagged(bio, BIO_QOS_MERGED))) {
-		struct request_queue *q = bdev_get_queue(bio->bi_bdev);
-		if (q->rq_qos)
-			__rq_qos_done_bio(q->rq_qos, bio);
-	}
+	struct request_queue *q;
+
+	if (!bio->bi_bdev || (!bio_flagged(bio, BIO_QOS_THROTTLED) &&
+			     !bio_flagged(bio, BIO_QOS_MERGED)))
+		return;
+
+	q = bdev_get_queue(bio->bi_bdev);
+	if (unlikely(test_bit(QUEUE_FLAG_QOS_ENABLED, &q->queue_flags)) &&
+			q->rq_qos)
+		__rq_qos_done_bio(q->rq_qos, bio);
 }
 
 static inline void rq_qos_throttle(struct request_queue *q, struct bio *bio)
 {
-	if (static_branch_unlikely(&block_rq_qos) && q->rq_qos) {
+	if (unlikely(test_bit(QUEUE_FLAG_QOS_ENABLED, &q->queue_flags)) &&
+			q->rq_qos) {
 		bio_set_flag(bio, BIO_QOS_THROTTLED);
 		__rq_qos_throttle(q->rq_qos, bio);
 	}
@@ -158,14 +164,16 @@ static inline void rq_qos_throttle(struct request_queue *q, struct bio *bio)
 static inline void rq_qos_track(struct request_queue *q, struct request *rq,
 				struct bio *bio)
 {
-	if (static_branch_unlikely(&block_rq_qos) && q->rq_qos)
+	if (unlikely(test_bit(QUEUE_FLAG_QOS_ENABLED, &q->queue_flags)) &&
+			q->rq_qos)
 		__rq_qos_track(q->rq_qos, rq, bio);
 }
 
 static inline void rq_qos_merge(struct request_queue *q, struct request *rq,
 				struct bio *bio)
 {
-	if (static_branch_unlikely(&block_rq_qos) && q->rq_qos) {
+	if (unlikely(test_bit(QUEUE_FLAG_QOS_ENABLED, &q->queue_flags)) &&
+			q->rq_qos) {
 		bio_set_flag(bio, BIO_QOS_MERGED);
 		__rq_qos_merge(q->rq_qos, rq, bio);
 	}
@@ -173,7 +181,8 @@ static inline void rq_qos_merge(struct request_queue *q, struct request *rq,
 
 static inline void rq_qos_queue_depth_changed(struct request_queue *q)
 {
-	if (static_branch_unlikely(&block_rq_qos) && q->rq_qos)
+	if (unlikely(test_bit(QUEUE_FLAG_QOS_ENABLED, &q->queue_flags)) &&
+			q->rq_qos)
 		__rq_qos_queue_depth_changed(q->rq_qos);
 }
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 95886b404b16..fe1797bbec42 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -656,6 +656,7 @@ enum {
 	QUEUE_FLAG_SQ_SCHED,		/* single queue style io dispatch */
 	QUEUE_FLAG_DISABLE_WBT_DEF,	/* for sched to disable/enable wbt */
 	QUEUE_FLAG_NO_ELV_SWITCH,	/* can't switch elevator any more */
+	QUEUE_FLAG_QOS_ENABLED,		/* qos is enabled */
 	QUEUE_FLAG_MAX
 };
 
-- 
2.50.1

