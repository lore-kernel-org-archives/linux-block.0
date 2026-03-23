Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEAB129D26E
	for <linux-block@vger.kernel.org>; Mon, 23 Mar 2026 07:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774249926; cv=none; b=BOv1TuG73xs/lJUpILHts8CPGB+uLgBeJ7WngHDibcI9z8FVrs3g/9Q1w0Jj7GBgwWEtJvUaqUREAs6fXvFTbA2F31V4pwkLXYMmDTc0NV85VSJhFkRJ/MEMfyhz5bFSkgDxnN0sjkAx+tyOo8EXac5dTfJcdbBP8hrn8NBFNmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774249926; c=relaxed/simple;
	bh=MaufSqufCzBEGw5AcLvY+HjA3iU3qgyN7kCOPRJtYzI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BzaYxUk5DLwbILNxKXTSI5TJpvmIxFmxhJrrU4mqUb+fco4j6M6lnzS7P9C9+wKM18HGuHqMu3CPKgQELhOAjVML8PeiCHx41HTz0V6GzD71fCVIPfaq4aAQa18wEa87VTbQWAboXWtebIXmRwwJvQqKvCmXHkD+a54IU8yEocE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=RiYUhMeZ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RiYUhMeZ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=9ITQQ6tqXjx7y1RcvJN4i2HtF4tcwMWEbaGq3SJ90qQ=; b=RiYUhMeZf8sO2lmz6PmJiWzbiC
	1JSExDhq7x+ArYtOZWw5/cEiTvaIImf2mbdEOtsSspvKOGCRX/v01nnfhSKKIOxTcqgpHr/ejhvYQ
	tmzr+uTVNIsi0GOOMI8HOAMI1K4oFuCle97RoYUeOP6YyZQKMr20U5gtsLX68Iu0gr3RZwOpUETQe
	6laIf18GpUqOO+Xe/GtWr8zSRu+yzo/kIasVq3fhfuocNRYCRZRBq+eQiJUW87c5/dcktAEUMFJ6+
	J+Bqq1/PA+btzM5B8BJJu9nGGeJ/8A/W08HY0SGJcpeZsrGPUrFDlOPKhVI0ox148L7QhrzlvGhoH
	tcDMJelg==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4ZSF-0000000GAa5-31Yu;
	Mon, 23 Mar 2026 07:12:04 +0000
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 1/2] zloop: refactor zloop_rw
Date: Mon, 23 Mar 2026 08:11:49 +0100
Message-ID: <20260323071156.2940772-2-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260323071156.2940772-1-hch@lst.de>
References: <20260323071156.2940772-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Split out two helpers functions to make the function more readable and
to avoid conditional locking.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
---
 drivers/block/zloop.c | 240 ++++++++++++++++++++++--------------------
 1 file changed, 124 insertions(+), 116 deletions(-)

diff --git a/drivers/block/zloop.c b/drivers/block/zloop.c
index 51c043342127..8ca37ca1935a 100644
--- a/drivers/block/zloop.c
+++ b/drivers/block/zloop.c
@@ -378,125 +378,22 @@ static void zloop_rw_complete(struct kiocb *iocb, long ret)
 	zloop_put_cmd(cmd);
 }
 
-static void zloop_rw(struct zloop_cmd *cmd)
+static int zloop_do_rw(struct zloop_cmd *cmd)
 {
 	struct request *rq = blk_mq_rq_from_pdu(cmd);
+	int rw = req_op(rq) == REQ_OP_READ ? ITER_DEST : ITER_SOURCE;
+	unsigned int nr_bvec = blk_rq_nr_bvec(rq);
 	struct zloop_device *zlo = rq->q->queuedata;
-	unsigned int zone_no = rq_zone_no(rq);
-	sector_t sector = blk_rq_pos(rq);
-	sector_t nr_sectors = blk_rq_sectors(rq);
-	bool is_append = req_op(rq) == REQ_OP_ZONE_APPEND;
-	bool is_write = req_op(rq) == REQ_OP_WRITE || is_append;
-	int rw = is_write ? ITER_SOURCE : ITER_DEST;
+	struct zloop_zone *zone = &zlo->zones[rq_zone_no(rq)];
 	struct req_iterator rq_iter;
-	struct zloop_zone *zone;
 	struct iov_iter iter;
-	struct bio_vec tmp;
-	unsigned long flags;
-	sector_t zone_end;
-	unsigned int nr_bvec;
-	int ret;
-
-	atomic_set(&cmd->ref, 2);
-	cmd->sector = sector;
-	cmd->nr_sectors = nr_sectors;
-	cmd->ret = 0;
-
-	if (WARN_ON_ONCE(is_append && !zlo->zone_append)) {
-		ret = -EIO;
-		goto out;
-	}
-
-	/* We should never get an I/O beyond the device capacity. */
-	if (WARN_ON_ONCE(zone_no >= zlo->nr_zones)) {
-		ret = -EIO;
-		goto out;
-	}
-	zone = &zlo->zones[zone_no];
-	zone_end = zone->start + zlo->zone_capacity;
-
-	/*
-	 * The block layer should never send requests that are not fully
-	 * contained within the zone.
-	 */
-	if (WARN_ON_ONCE(sector + nr_sectors > zone->start + zlo->zone_size)) {
-		ret = -EIO;
-		goto out;
-	}
-
-	if (test_and_clear_bit(ZLOOP_ZONE_SEQ_ERROR, &zone->flags)) {
-		mutex_lock(&zone->lock);
-		ret = zloop_update_seq_zone(zlo, zone_no);
-		mutex_unlock(&zone->lock);
-		if (ret)
-			goto out;
-	}
-
-	if (!test_bit(ZLOOP_ZONE_CONV, &zone->flags) && is_write) {
-		mutex_lock(&zone->lock);
-
-		spin_lock_irqsave(&zone->wp_lock, flags);
-
-		/*
-		 * Zone append operations always go at the current write
-		 * pointer, but regular write operations must already be
-		 * aligned to the write pointer when submitted.
-		 */
-		if (is_append) {
-			/*
-			 * If ordered zone append is in use, we already checked
-			 * and set the target sector in zloop_queue_rq().
-			 */
-			if (!zlo->ordered_zone_append) {
-				if (zone->cond == BLK_ZONE_COND_FULL ||
-				    zone->wp + nr_sectors > zone_end) {
-					spin_unlock_irqrestore(&zone->wp_lock,
-							       flags);
-					ret = -EIO;
-					goto unlock;
-				}
-				sector = zone->wp;
-			}
-			cmd->sector = sector;
-		} else if (sector != zone->wp) {
-			spin_unlock_irqrestore(&zone->wp_lock, flags);
-			pr_err("Zone %u: unaligned write: sect %llu, wp %llu\n",
-			       zone_no, sector, zone->wp);
-			ret = -EIO;
-			goto unlock;
-		}
-
-		/* Implicitly open the target zone. */
-		if (zone->cond == BLK_ZONE_COND_CLOSED ||
-		    zone->cond == BLK_ZONE_COND_EMPTY)
-			zone->cond = BLK_ZONE_COND_IMP_OPEN;
-
-		/*
-		 * Advance the write pointer, unless ordered zone append is in
-		 * use. If the write fails, the write pointer position will be
-		 * corrected when the next I/O starts execution.
-		 */
-		if (!is_append || !zlo->ordered_zone_append) {
-			zone->wp += nr_sectors;
-			if (zone->wp == zone_end) {
-				zone->cond = BLK_ZONE_COND_FULL;
-				zone->wp = ULLONG_MAX;
-			}
-		}
-
-		spin_unlock_irqrestore(&zone->wp_lock, flags);
-	}
-
-	nr_bvec = blk_rq_nr_bvec(rq);
 
 	if (rq->bio != rq->biotail) {
-		struct bio_vec *bvec;
+		struct bio_vec tmp, *bvec;
 
 		cmd->bvec = kmalloc_objs(*cmd->bvec, nr_bvec, GFP_NOIO);
-		if (!cmd->bvec) {
-			ret = -EIO;
-			goto unlock;
-		}
+		if (!cmd->bvec)
+			return -EIO;
 
 		/*
 		 * The bios of the request may be started from the middle of
@@ -522,7 +419,7 @@ static void zloop_rw(struct zloop_cmd *cmd)
 		iter.iov_offset = rq->bio->bi_iter.bi_bvec_done;
 	}
 
-	cmd->iocb.ki_pos = (sector - zone->start) << SECTOR_SHIFT;
+	cmd->iocb.ki_pos = (cmd->sector - zone->start) << SECTOR_SHIFT;
 	cmd->iocb.ki_filp = zone->file;
 	cmd->iocb.ki_complete = zloop_rw_complete;
 	if (!zlo->buffered_io)
@@ -530,12 +427,123 @@ static void zloop_rw(struct zloop_cmd *cmd)
 	cmd->iocb.ki_ioprio = IOPRIO_PRIO_VALUE(IOPRIO_CLASS_NONE, 0);
 
 	if (rw == ITER_SOURCE)
-		ret = zone->file->f_op->write_iter(&cmd->iocb, &iter);
-	else
-		ret = zone->file->f_op->read_iter(&cmd->iocb, &iter);
-unlock:
-	if (!test_bit(ZLOOP_ZONE_CONV, &zone->flags) && is_write)
+		return zone->file->f_op->write_iter(&cmd->iocb, &iter);
+	return zone->file->f_op->read_iter(&cmd->iocb, &iter);
+}
+
+static int zloop_seq_write_prep(struct zloop_cmd *cmd)
+{
+	struct request *rq = blk_mq_rq_from_pdu(cmd);
+	struct zloop_device *zlo = rq->q->queuedata;
+	unsigned int zone_no = rq_zone_no(rq);
+	sector_t nr_sectors = blk_rq_sectors(rq);
+	bool is_append = req_op(rq) == REQ_OP_ZONE_APPEND;
+	struct zloop_zone *zone = &zlo->zones[zone_no];
+	sector_t zone_end = zone->start + zlo->zone_capacity;
+	unsigned long flags;
+	int ret = 0;
+
+	spin_lock_irqsave(&zone->wp_lock, flags);
+
+	/*
+	 * Zone append operations always go at the current write pointer, but
+	 * regular write operations must already be aligned to the write pointer
+	 * when submitted.
+	 */
+	if (is_append) {
+		/*
+		 * If ordered zone append is in use, we already checked and set
+		 * the target sector in zloop_queue_rq().
+		 */
+		if (!zlo->ordered_zone_append) {
+			if (zone->cond == BLK_ZONE_COND_FULL ||
+			    zone->wp + nr_sectors > zone_end) {
+				ret = -EIO;
+				goto out_unlock;
+			}
+			cmd->sector = zone->wp;
+		}
+	} else {
+		if (cmd->sector != zone->wp) {
+			pr_err("Zone %u: unaligned write: sect %llu, wp %llu\n",
+			       zone_no, cmd->sector, zone->wp);
+			ret = -EIO;
+			goto out_unlock;
+		}
+	}
+
+	/* Implicitly open the target zone. */
+	if (zone->cond == BLK_ZONE_COND_CLOSED ||
+	    zone->cond == BLK_ZONE_COND_EMPTY)
+		zone->cond = BLK_ZONE_COND_IMP_OPEN;
+
+	/*
+	 * Advance the write pointer, unless ordered zone append is in use. If
+	 * the write fails, the write pointer position will be corrected when
+	 * the next I/O starts execution.
+	 */
+	if (!is_append || !zlo->ordered_zone_append) {
+		zone->wp += nr_sectors;
+		if (zone->wp == zone_end) {
+			zone->cond = BLK_ZONE_COND_FULL;
+			zone->wp = ULLONG_MAX;
+		}
+	}
+out_unlock:
+	spin_unlock_irqrestore(&zone->wp_lock, flags);
+	return ret;
+}
+
+static void zloop_rw(struct zloop_cmd *cmd)
+{
+	struct request *rq = blk_mq_rq_from_pdu(cmd);
+	struct zloop_device *zlo = rq->q->queuedata;
+	unsigned int zone_no = rq_zone_no(rq);
+	sector_t nr_sectors = blk_rq_sectors(rq);
+	bool is_append = req_op(rq) == REQ_OP_ZONE_APPEND;
+	bool is_write = req_op(rq) == REQ_OP_WRITE || is_append;
+	struct zloop_zone *zone;
+	int ret = -EIO;
+
+	atomic_set(&cmd->ref, 2);
+	cmd->sector = blk_rq_pos(rq);
+	cmd->nr_sectors = nr_sectors;
+	cmd->ret = 0;
+
+	if (WARN_ON_ONCE(is_append && !zlo->zone_append))
+		goto out;
+
+	/* We should never get an I/O beyond the device capacity. */
+	if (WARN_ON_ONCE(zone_no >= zlo->nr_zones))
+		goto out;
+
+	zone = &zlo->zones[zone_no];
+
+	/*
+	 * The block layer should never send requests that are not fully
+	 * contained within the zone.
+	 */
+	if (WARN_ON_ONCE(cmd->sector + nr_sectors >
+			 zone->start + zlo->zone_size))
+		goto out;
+
+	if (test_and_clear_bit(ZLOOP_ZONE_SEQ_ERROR, &zone->flags)) {
+		mutex_lock(&zone->lock);
+		ret = zloop_update_seq_zone(zlo, zone_no);
 		mutex_unlock(&zone->lock);
+		if (ret)
+			goto out;
+	}
+
+	if (!test_bit(ZLOOP_ZONE_CONV, &zone->flags) && is_write) {
+		mutex_lock(&zone->lock);
+		ret = zloop_seq_write_prep(cmd);
+		if (!ret)
+			ret = zloop_do_rw(cmd);
+		mutex_unlock(&zone->lock);
+	} else {
+		ret = zloop_do_rw(cmd);
+	}
 out:
 	if (ret != -EIOCBQUEUED)
 		zloop_rw_complete(&cmd->iocb, ret);
-- 
2.47.3

