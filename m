Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE05A253359;
	Thu, 14 May 2026 10:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778752834; cv=none; b=Lh0hKH572pB02gZ+dKdZ996zj+kQfSmpHiYl6/z+m2ADawycZ4DoBcLbAq8IZ9WdpRBKbKAGRLJvFtlqjx+xkPDquHSwZKLZebV+3ctWYvp4Pdn1fhOUtQgLNrbGst9f1m/SPSPyCQNWg2R/4EfyszS+koRkpQ70RHwf8h1ow8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778752834; c=relaxed/simple;
	bh=g8LyYj4ASpQ07gHTXbMAAfN+BJ2nIGhfP2S/BfbTyz0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L1T/jYLOwocR7Jlf65E2qmH1agGfZXxCGRqdSjHj6Our01hnWf4ho14G516gyo5evNCf6I6JBNEOdIk6pCAqe2uhfKPpPLdxC8kOWOht8xZTltpdEv4QRlM/yupvV+NQqdmo4mpJziEuOvGs2DsvCFz5nz58JZdYzZaxJ6iyHzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=bmp9a4JS; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="bmp9a4JS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Cd
	TFkbIJTB3Qq1iZm/0QO77CaO0ORz2AXduzcdSnWwI=; b=bmp9a4JSjOMxShX34U
	NYAMh9+nFjWoCy/QpwuYABq9cSn1cmC9qrZj7/x1/oKNKmhs7QewNr2hQlTtKiV4
	/4WxF87A0IawxkrcUJgmuJ/ENCeM4JZz4lF+VmVy23OnicF/232kxtHyOJN/7bLz
	LCk9ua3qkN+qIkglNADvynkv8=
Received: from vbox.. (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wDnj6gdnQVqQ+k6BQ--.38959S2;
	Thu, 14 May 2026 17:59:58 +0800 (CST)
From: Li kunyu <likunyu10@163.com>
To: axboe@kernel.dk,
	tj@kernel.org,
	josef@toxicpanda.com
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Li kunyu <likunyu10@163.com>
Subject: [PATCH v3] block/blk-iolatency: Add the processing flow of the chained bio in the QoS and define the related types to solve the problem of incorrect inflight processing in the QoS. The usage of the done_split_bio abstract function in the blk-iolatency project.
Date: Thu, 14 May 2026 17:59:52 +0800
Message-ID: <20260514095952.135403-1-likunyu10@163.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260506024244.2741-1-likunyu10@163.com>
References: <20260506024244.2741-1-likunyu10@163.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnj6gdnQVqQ+k6BQ--.38959S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxtF1rtFyxuw15XFyfAry5urg_yoW7WF1xpa
	10grnIkrWDKF4kWa97Gws7Cw4Ska1rKryUA3yfZ34Syrn29r12vF18ZF1vyryFyrW3CF47
	Jrn8tFW5Gr45C37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pi89NxUUUUU=
X-CM-SenderInfo: poln30d1xriqqrwthudrp/xtbC4x5K7moFnR4eWAAA3z

Signed-off-by: Li kunyu <likunyu10@163.com>
---
v2: Fix the use of 'split' in the 'bio_set_flag' function to 'bio'
v3: Fix the missing implementation of the '__rq_qos_done_split_bio' function

 block/bio.c               |  2 ++
 block/blk-iolatency.c     | 34 ++++++++++++++++++++++++++++++++++
 block/blk-merge.c         |  7 ++++++-
 block/blk-rq-qos.c        |  9 +++++++++
 block/blk-rq-qos.h        | 11 +++++++++++
 include/linux/blk_types.h |  2 ++
 6 files changed, 64 insertions(+), 1 deletion(-)

diff --git a/block/bio.c b/block/bio.c
index b8972dba68a0..7740701afc7f 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1733,6 +1733,8 @@ static inline bool bio_remaining_done(struct bio *bio)
 		return true;
 	}
 
+	rq_qos_done_split_bio(bio);
+
 	return false;
 }
 
diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
index 53e8dd2dfa8a..ba5870bf14c5 100644
--- a/block/blk-iolatency.c
+++ b/block/blk-iolatency.c
@@ -632,6 +632,39 @@ static void blkcg_iolatency_done_bio(struct rq_qos *rqos, struct bio *bio)
 	}
 }
 
+static void blkcg_iolatency_done_split_bio(struct rq_qos *rqos, struct bio *bio)
+{
+	struct blkcg_gq *blkg;
+	struct rq_wait *rqw;
+	struct iolatency_grp *iolat;
+	int inflight = 0;
+
+	blkg = bio->bi_blkg;
+	if (!blkg || !bio_flagged(bio, BIO_QOS_CHAIN_CHILD))
+		return;
+
+	iolat = blkg_to_lat(bio->bi_blkg);
+	if (!iolat)
+		return;
+
+	if (!iolat->blkiolat->enabled)
+		return;
+
+	while (blkg && blkg->parent) {
+		iolat = blkg_to_lat(blkg);
+		if (!iolat) {
+			blkg = blkg->parent;
+			continue;
+		}
+		rqw = &iolat->rq_wait;
+
+		inflight = atomic_dec_return(&rqw->inflight);
+		WARN_ON_ONCE(inflight < 0);
+
+		blkg = blkg->parent;
+	}
+}
+
 static void blkcg_iolatency_exit(struct rq_qos *rqos)
 {
 	struct blk_iolatency *blkiolat = BLKIOLATENCY(rqos);
@@ -645,6 +678,7 @@ static void blkcg_iolatency_exit(struct rq_qos *rqos)
 static const struct rq_qos_ops blkcg_iolatency_ops = {
 	.throttle = blkcg_iolatency_throttle,
 	.done_bio = blkcg_iolatency_done_bio,
+	.done_split_bio = blkcg_iolatency_done_split_bio,
 	.exit = blkcg_iolatency_exit,
 };
 
diff --git a/block/blk-merge.c b/block/blk-merge.c
index fcf09325b22e..84373e3e1bbe 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -151,8 +151,13 @@ static struct bio *bio_submit_split(struct bio *bio, int split_sectors)
 	if (split_sectors) {
 		bio = bio_submit_split_bioset(bio, split_sectors,
 				&bio->bi_bdev->bd_disk->bio_split);
-		if (bio)
+		if (bio) {
 			bio->bi_opf |= REQ_NOMERGE;
+			/* Fix the issue where the inflight statistics
+			 * of the chained bio in the QoS are incorrect.
+			 */
+			bio_set_flag(bio, BIO_QOS_CHAIN_CHILD);
+		}
 	}
 
 	return bio;
diff --git a/block/blk-rq-qos.c b/block/blk-rq-qos.c
index 85cf74402a09..41ee04defca7 100644
--- a/block/blk-rq-qos.c
+++ b/block/blk-rq-qos.c
@@ -95,6 +95,15 @@ void __rq_qos_done_bio(struct rq_qos *rqos, struct bio *bio)
 	} while (rqos);
 }
 
+void __rq_qos_done_split_bio(struct rq_qos *rqos, struct bio *bio)
+{
+	do {
+		if (rqos->ops->done_split_bio)
+			rqos->ops->done_split_bio(rqos, bio);
+		rqos = rqos->next;
+	} while (rqos);
+}
+
 void __rq_qos_queue_depth_changed(struct rq_qos *rqos)
 {
 	do {
diff --git a/block/blk-rq-qos.h b/block/blk-rq-qos.h
index a747a504fe42..496a27b9d412 100644
--- a/block/blk-rq-qos.h
+++ b/block/blk-rq-qos.h
@@ -45,6 +45,7 @@ struct rq_qos_ops {
 	void (*cleanup)(struct rq_qos *, struct bio *);
 	void (*queue_depth_changed)(struct rq_qos *);
 	void (*exit)(struct rq_qos *);
+	void (*done_split_bio)(struct rq_qos *, struct bio *);
 	const struct blk_mq_debugfs_attr *debugfs_attrs;
 };
 
@@ -108,6 +109,7 @@ void __rq_qos_throttle(struct rq_qos *rqos, struct bio *bio);
 void __rq_qos_track(struct rq_qos *rqos, struct request *rq, struct bio *bio);
 void __rq_qos_merge(struct rq_qos *rqos, struct request *rq, struct bio *bio);
 void __rq_qos_done_bio(struct rq_qos *rqos, struct bio *bio);
+void __rq_qos_done_split_bio(struct rq_qos *rqos, struct bio *bio);
 void __rq_qos_queue_depth_changed(struct rq_qos *rqos);
 
 static inline void rq_qos_cleanup(struct request_queue *q, struct bio *bio)
@@ -157,6 +159,15 @@ static inline void rq_qos_done_bio(struct bio *bio)
 		__rq_qos_done_bio(q->rq_qos, bio);
 }
 
+static inline void rq_qos_done_split_bio(struct bio *bio)
+{
+	if (bio->bi_bdev && bio_flagged(bio, BIO_QOS_CHAIN_CHILD)) {
+		struct request_queue *q = bdev_get_queue(bio->bi_bdev);
+		if (q->rq_qos)
+			__rq_qos_done_split_bio(q->rq_qos, bio);
+	}
+}
+
 static inline void rq_qos_throttle(struct request_queue *q, struct bio *bio)
 {
 	if (test_bit(QUEUE_FLAG_QOS_ENABLED, &q->queue_flags) && q->rq_qos) {
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 8808ee76e73c..63fee89ecc14 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -322,6 +322,8 @@ enum {
 	BIO_REMAPPED,
 	BIO_ZONE_WRITE_PLUGGING, /* bio handled through zone write plugging */
 	BIO_EMULATES_ZONE_APPEND, /* bio emulates a zone append operation */
+	BIO_QOS_CHAIN_CHILD,    /* chained bio child, used for segmenting out
+				* the bio */
 	BIO_FLAG_LAST
 };
 
-- 
2.47.3

