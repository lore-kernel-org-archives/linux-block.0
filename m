Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA522E7BBB
	for <linux-block@vger.kernel.org>; Thu, 14 Aug 2025 08:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755160001; cv=none; b=iDPKmY4/Laq1G9VlMiBE1J1uqOiT0NdwBztaf6KAsUvyrRqMuw8zCNW9VJXknYooZ8Jh6J+dlF+D0vvRAGkZOd/+NbQlnzIx1Oe3k4Br6s/hh/01ZXS4+lLSqKyDYkw1hW4ge8MaKSWZBWi5EEqnoG7BfmY5IBq71Qqf9MjkNQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755160001; c=relaxed/simple;
	bh=3KihWVjypS+qdj1isTUYXT6BHNMzPioAvTaX42PgeeA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rFogUELnZxRDShiKF6BhBMXESR+AEKszx8GgpYCOjOZl8QTvgnX1fbEub9wL3r3CLi0oD91G8Nu6kxkWgKs4O8eEnqe5YFQ8lUpy8Q6KEdSn3i+LY5hn3rD6/zQYPgGn3QCXAscOHWwS+d7DLtsBVGR01cxCROE0D1rSbyXjftI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Uu8+ghh0; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Uu8+ghh0"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57DMDMGC029508;
	Thu, 14 Aug 2025 08:26:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=pFMYnqcz+7SaHDK95
	iOHLp0luujVrSAKXwBpgn6TV3c=; b=Uu8+ghh0fTGkuFOXOeV3QmQbtmvBghCgV
	tYkOKW48qyAqdyhi/KVVbO3ITqckEzzD+18KQJfOG4v7SK08ptmuXhk7Omay1IHN
	zk1k2eB6jF9zSOrHoyHR5J+J6u/TByArRcYUeD9PF60bU9Jdb7sTO+6npMeTQgEt
	glsDOPZVnXDLWorox5xKv7bxkBK7zwUCQuNhq3gkL8SZi/yTsVamNleX8yl18atV
	pi+C+tH2qhRFqv5o5/SlY3Ev8q0MRXbiwzkJmtt/vFFi4cUm8jucf0xxAvk1Xo6a
	jUxxGBV0YcHicjCg+QXFnuEmk+AAbWYAj1VyJO2jjNP7A94oRdFDw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48dwudh3vn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Aug 2025 08:26:25 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57E8PGBN010824;
	Thu, 14 Aug 2025 08:26:24 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 48egnuuj2t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Aug 2025 08:26:24 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57E8QMLl52888054
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Aug 2025 08:26:22 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7AE0520049;
	Thu, 14 Aug 2025 08:26:22 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 86FF520040;
	Thu, 14 Aug 2025 08:26:20 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.in.ibm.com (unknown [9.109.198.214])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 14 Aug 2025 08:26:20 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-block@vger.kernel.org
Cc: axboe@kernel.dk, ming.lei@redhat.com, yukuai1@huaweicloud.com, hch@lst.de,
        shinichiro.kawasaki@wdc.com, kch@nvidia.com, gjoyce@ibm.com
Subject: [PATCHv3 3/3] block: avoid cpu_hotplug_lock depedency on freeze_lock
Date: Thu, 14 Aug 2025 13:54:59 +0530
Message-ID: <20250814082612.500845-4-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250814082612.500845-1-nilay@linux.ibm.com>
References: <20250814082612.500845-1-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDIyNCBTYWx0ZWRfX6+y7AIIzXBcU
 6M3iYFDG2iKQczmcFNh3NCHOwHHN6BOAraV255BOKr/HWCMbUGw09HII6pltipMTbl9LtYmlC7p
 ThkqMfKlHCy8mrczyFITSFRKeuiWhi7/tTY0IL3npJMO5TZYZ5LIxYRz/Mv+tj/G+3ZUr2W+nZJ
 l16k93qTLG6blCas79t52GmgdKtz4pOtEILQrQiuoW13atKO4f241OqpOhcl2Bf6IvR1xFzRhCF
 UpmjtKNVNziXC/mfPVPSuMk2Ow7WH8UOg5TJiQIp1sZM9DOisNyLketMOq70oUop7xWAWvSArRa
 FtOqLM3s1D5kI41vItQz08tfIcTKZ5T1U13gdNGINi6i85Yak5zKcDdunB+W7YAecl9g1qIXcOK
 kLPzy7K2
X-Authority-Analysis: v=2.4 cv=d/31yQjE c=1 sm=1 tr=0 ts=689d9db1 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=JF9118EUAAAA:8 a=VnNF1IyMAAAA:8
 a=2PAPBbM3dCpi0lPrkR4A:9 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-GUID: e9uwSvD_K2K0X9hZGseQbgxLE_yX3aNv
X-Proofpoint-ORIG-GUID: e9uwSvD_K2K0X9hZGseQbgxLE_yX3aNv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_02,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 spamscore=0 adultscore=0 bulkscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508120224

A recent lockdep[1] splat observed while running blktest block/005
reveals a potential deadlock caused by the cpu_hotplug_lock dependency
on ->freeze_lock. This dependency was introduced by commit 033b667a823e
("block: blk-rq-qos: guard rq-qos helpers by static key").

That change added a static key to avoid fetching q->rq_qos when
neither blk-wbt nor blk-iolatency is configured. The static key
dynamically patches kernel text to a NOP when disabled, eliminating
overhead of fetching q->rq_qos in the I/O hot path. However, enabling
a static key at runtime requires acquiring both cpu_hotplug_lock and
jump_label_mutex. When this happens after the queue has already been
frozen (i.e., while holding ->freeze_lock), it creates a locking
dependency from cpu_hotplug_lock to ->freeze_lock, which leads to a
potential deadlock reported by lockdep [1].

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
Tested-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 block/blk-mq-debugfs.c |  1 +
 block/blk-rq-qos.c     |  9 ++++---
 block/blk-rq-qos.h     | 54 ++++++++++++++++++++++++------------------
 include/linux/blkdev.h |  1 +
 4 files changed, 37 insertions(+), 28 deletions(-)

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
index b1e24bb85ad2..654478dfbc20 100644
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
 
@@ -374,10 +372,11 @@ void rq_qos_del(struct rq_qos *rqos)
 	for (cur = &q->rq_qos; *cur; cur = &(*cur)->next) {
 		if (*cur == rqos) {
 			*cur = rqos->next;
-			static_branch_dec(&block_rq_qos);
 			break;
 		}
 	}
+	if (!q->rq_qos)
+		blk_queue_flag_clear(QUEUE_FLAG_QOS_ENABLED, q);
 	blk_mq_unfreeze_queue(q, memflags);
 
 	mutex_lock(&q->debugfs_mutex);
diff --git a/block/blk-rq-qos.h b/block/blk-rq-qos.h
index 28125fc49eff..1fe22000a379 100644
--- a/block/blk-rq-qos.h
+++ b/block/blk-rq-qos.h
@@ -12,7 +12,6 @@
 #include "blk-mq-debugfs.h"
 
 struct blk_mq_debugfs_attr;
-extern struct static_key_false block_rq_qos;
 
 enum rq_qos_id {
 	RQ_QOS_WBT,
@@ -113,49 +112,55 @@ void __rq_qos_queue_depth_changed(struct rq_qos *rqos);
 
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
-
-		/*
-		 * If a bio has BIO_QOS_xxx set, it implicitly implies that
-		 * q->rq_qos is present. So, we skip re-checking q->rq_qos
-		 * here as an extra optimization and directly call
-		 * __rq_qos_done_bio().
-		 */
-		__rq_qos_done_bio(q->rq_qos, bio);
-	}
+	struct request_queue *q;
+
+	if (!bio->bi_bdev || (!bio_flagged(bio, BIO_QOS_THROTTLED) &&
+			     !bio_flagged(bio, BIO_QOS_MERGED)))
+		return;
+
+	q = bdev_get_queue(bio->bi_bdev);
+
+	/*
+	 * If a bio has BIO_QOS_xxx set, it implicitly implies that
+	 * q->rq_qos is present. So, we skip re-checking q->rq_qos
+	 * here as an extra optimization and directly call
+	 * __rq_qos_done_bio().
+	 */
+	__rq_qos_done_bio(q->rq_qos, bio);
 }
 
 static inline void rq_qos_throttle(struct request_queue *q, struct bio *bio)
 {
-	if (static_branch_unlikely(&block_rq_qos) && q->rq_qos) {
+	if (unlikely(test_bit(QUEUE_FLAG_QOS_ENABLED, &q->queue_flags)) &&
+			q->rq_qos) {
 		bio_set_flag(bio, BIO_QOS_THROTTLED);
 		__rq_qos_throttle(q->rq_qos, bio);
 	}
@@ -164,14 +169,16 @@ static inline void rq_qos_throttle(struct request_queue *q, struct bio *bio)
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
@@ -179,7 +186,8 @@ static inline void rq_qos_merge(struct request_queue *q, struct request *rq,
 
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

