Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEEEE23183C;
	Wed,  6 May 2026 02:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778035401; cv=none; b=NHg35f+n+OIQRJuI+ONlN9UzhJDOf1SCuXDceC6YHLMoD3QDlO9SZXjNXx4b4x+JbMSlD/cY7PIKzvSrh/tTSgMvY+NZjkei3E8MhS+BixuDE5fg+uojtRm5tG8AKlJEyqZObxSGN8iplVHbRI+7TvGv+1MY+T7dY8ri1m/epxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778035401; c=relaxed/simple;
	bh=46eDNhYic0uPwK8kBO8/u+opbZOLflAr6f3eGbQCxWo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y+n4+yiu5ZIY6gJa7PJgp5dNlUOb+WntOCKUIJ3cJtivpCO20cUm38KmmqasGnvnBTqzXYksG+x3EUuJ4ElDlNYnfe/jTfUSTuF2t/JgV8RqqrJ9X1/ZO6b0M8GcEVXCTIwS/cUJI3WTin1N2oPcQpRzMEZU25NKXuF4pzcSysc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=JAVsjsLp; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="JAVsjsLp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Pg
	npo6Lf/GSuVTnxYWFDVr0mLMZHod6X84KLTgEMTIw=; b=JAVsjsLp98Qiq0GmWY
	Nlly81Wng9MZPDnWFjtMw17op5+EFmlM0Qeo0DoQQv6lEDMvJ3ZC+1NWzvf0TluI
	wQt2ZjBFRcExVD2WLIGmKl/XpWAJ2SOuNfXfdwK2f3zrh+VPhlfeiAOX+dfSh4hr
	d8Cb8LQZbQqv/HJIhINgx3aqs=
Received: from vbox.. (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wDnT7+pqvppHIiCDg--.11596S2;
	Wed, 06 May 2026 10:42:50 +0800 (CST)
From: Li kunyu <likunyu10@163.com>
To: axboe@kernel.dk,
	tj@kernel.org,
	josef@toxicpanda.com
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Li kunyu <likunyu10@163.com>
Subject: [PATCH v2] block/blk-iolatency: Add the processing flow of the chained bio in the QoS and define the related types to solve the problem of incorrect inflight processing in the QoS. The usage of the done_split_bio abstract function in the blk-iolatency project.
Date: Wed,  6 May 2026 10:42:44 +0800
Message-ID: <20260506024244.2741-1-likunyu10@163.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnT7+pqvppHIiCDg--.11596S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXFWUWw4kAr15KF1ktr13Jwb_yoWrtr4Upa
	10gwnIkrZrKF4kWa93GwsrCw4SkanYgryUC3yfA34Syrn2gr12vF18ZF1vyryFyrWfCrW7
	Jrn8tF45Gr45C37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piYFAdUUUUU=
X-CM-SenderInfo: poln30d1xriqqrwthudrp/xtbC-wrtkmn6qqrDagAA3w

Signed-off-by: Li kunyu <likunyu10@163.com>
---
v2: Fix the use of 'split' in the 'bio_set_flag' function to 'bio'

 block/bio.c               |  2 ++
 block/blk-iolatency.c     | 34 ++++++++++++++++++++++++++++++++++
 block/blk-merge.c         |  7 ++++++-
 block/blk-rq-qos.h        | 11 +++++++++++
 include/linux/blk_types.h |  2 ++
 5 files changed, 55 insertions(+), 1 deletion(-)

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

