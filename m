Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45191292B26
	for <linux-block@vger.kernel.org>; Tue,  5 Aug 2025 17:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754414297; cv=none; b=S9LFOVECSf+PaWIm5kemAAx5tPP6kzhpfhM8wB5pdcN44kYulx3ly9ankCK9vBG1O2o6jnuGr/25ycUuz4RUASbudqIWDrDsc+fg7HycNDcMC1VspzKSzrpQPJCjEq2PBL1EAnKMqslsNeKxCg7QGNzvA2uIP9Ha+vQ7JmrrMSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754414297; c=relaxed/simple;
	bh=1a4yyC+jlFIHOPaiOv0v4r5DbBCtV//Q3bwmMyDItZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a0vgLuB/QNPeY66E6cj3nYrBxEoGj0DzKnYwGhQhxYsEmnHpiMV7gUt0PoFaknhm89d7gOQKn3rWld93I43eGI8QY2VBJAH+VVJSV/4H1g8dIUvP9ZUcRxkHprpWvGsr4pJTjUj2usovPGMHf3dk4/ff20x07nxnH6nE84Q1fik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qcGq6LMK; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qcGq6LMK"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 575H3EL4017511;
	Tue, 5 Aug 2025 17:18:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=wi8H+QLkIUUjeSRDy
	4ptEvcqYEmlWVYgZUa0M6BJx5Y=; b=qcGq6LMKg3Lbl9DiOXCZ+QWKn4qRlqqDU
	QwDL4fe7y1p+Uz8cAXL7CaGXRzBPgGjT6jgJiJUALE21ZY7DoPk3bdd3zvfYyB8z
	h0uuPdQZPSJPWMMN5rS1K1PkYapgWj91Fw6x3gjZORNMVn/W7/19NOpeBXafFepZ
	zUyO4KgfYXi8F2MFVNaPr805VdVafZlfnCkVw7qwD27mK7zLrBR9cAVPBRj4oDby
	Z49Yx3Q8JwuNnyEUIzuOoPdZbQve9AP/pYgRHAAZG0QHHOI3XAlc5XSSOkWYyFu4
	pY9L/wTOTENlwz+uvZ2Z9DoFH4m1ZB+J2pYY9KANYTXac92dc5yuQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 489ac0yveu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Aug 2025 17:17:59 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 575EEcjo001928;
	Tue, 5 Aug 2025 17:17:58 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 489y7ku8v5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Aug 2025 17:17:58 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 575HHvek50397658
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 5 Aug 2025 17:17:57 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 19DE02004B;
	Tue,  5 Aug 2025 17:17:57 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 58E5120040;
	Tue,  5 Aug 2025 17:17:54 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.43.35.190])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  5 Aug 2025 17:17:54 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-block@vger.kernel.org
Cc: ming.lei@redhat.com, yukuai1@huaweicloud.com, axboe@kernel.dk, hch@lst.de,
        kch@nvidia.com, shinichiro.kawasaki@wdc.com, gjoyce@ibm.com
Subject: [PATCHv2 1/2] block: avoid cpu_hotplug_lock depedency on freeze_lock
Date: Tue,  5 Aug 2025 22:47:40 +0530
Message-ID: <20250805171749.3448694-2-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250805171749.3448694-1-nilay@linux.ibm.com>
References: <20250805171749.3448694-1-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: nY7X3avpPHlRa0Cm7GgyB39m911ZCBng
X-Proofpoint-ORIG-GUID: nY7X3avpPHlRa0Cm7GgyB39m911ZCBng
X-Authority-Analysis: v=2.4 cv=GNoIEvNK c=1 sm=1 tr=0 ts=68923cc7 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=JF9118EUAAAA:8 a=VnNF1IyMAAAA:8
 a=twLY2_itOEWcE9j9UWoA:9 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA1MDExOCBTYWx0ZWRfXw4yXVO9S7r4P
 /CL0pCj0O98iJcCs6Yz+dCuGuBdQt3zp/5ZKaGWb4cjmobRr1PLO0d5XK7Bo+hd+qvk0RMMPTS0
 G554/uwFPIkpyBQE6QSfDtHNQ4kYwjtmFTrUV5f8NY3nkFG9YirTTkItJt/LI8cK8qnZ7EQUIQM
 NaU8Z0DjH3eNV74WvLDByU/Wp3hhfK80krKN7K1iR1O8MyqN3kXlmoZIlnXUGRr88T0+zFfxk20
 HJsX3jI2eTrFkHVG8VU1KwnapGDxZexmmvLcMkXByzbrkpDzZ3DNxAKf7S3DZg1KR7FaX4gnS0C
 yHfW5e0SDHlnlZMRNJb43cSAItbSfngI/QZU51nm6iTkIaqKh9PjFxRM3hGjYjF/8D43buoHBoR
 KBAN9xfe/QRxOgaaMvqNZZ6/Ffj+EWDDAlqHEAHVUHp6e7eYqL3O1FaqivlwsL86yzx5i6Lq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-05_04,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 adultscore=0 spamscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 impostorscore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2508050118

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
lock to ->freeze_lock, which leads to a potential deadlock reported by
lockdep [1].

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

Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Closes: https://lore.kernel.org/linux-block/4fdm37so3o4xricdgfosgmohn63aa7wj3ua4e5vpihoamwg3ui@fq42f5q5t5ic/
Fixes: 033b667a823e ("block: blk-rq-qos: guard rq-qos helpers by static key")
Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 block/blk-mq-debugfs.c |  1 +
 block/blk-rq-qos.c     |  6 ++----
 block/blk-rq-qos.h     | 43 +++++++++++++++++++++++++-----------------
 include/linux/blkdev.h |  1 +
 4 files changed, 30 insertions(+), 21 deletions(-)

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
index 39749f4066fb..c4242508fa5e 100644
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
 
 static inline void rq_qos_issue(struct request_queue *q, struct request *rq)
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

