Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671BB85C74
	for <linux-block@vger.kernel.org>; Tue,  5 Mar 2024 13:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709646047; cv=none; b=Tmipv3n4sFbOxbolto2vI8zBxbROWtNv8RpA+AsPK2WXuiYLpzu4TcAeB+OBD2RjlTvGIzlNPTUz34ldhMiCpmEiziuV/qhHHI94WK7S1ijpLPphxbuNACy64ias3ULJLRcEcp4DUEFrdKDyKJoxjMerlctnN63MhN+hy/MekhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709646047; c=relaxed/simple;
	bh=AsrYHsG7r6XadTI3QCTSg4hezSD4FYHHHuLdbXXQ+TA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pVFX60yciloeKlVCS5EmutnJIlKCySPDVYtruhiaQeYAi9RxK8yXq9ii5Bs0Q9H+m20ZeeYMgnYAmFsONRLLedmRCxM1inElw2kYjJo478jQ5IcV21eRcv1xdN9ZWY74A4GAmIuryuptin08mYDHGsbGx0R7FtZ2tEZhXzQBOVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dFP+iUTx; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dFP+iUTx"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=0KKDb4GuesD/jXOw/b5195T9S3k6Ul/k1CdB+JFeMjg=; b=dFP+iUTx2o+lCf3Y9d7gSOwI9t
	Xmn4p9+u1ZOhK7D8OiTfR5tZzwdxiGTE3opudJ7Cvs6pINLaIywa1t+3lBgJ2F6KWCSJDUQnsWhPL
	1jZOhsPeZOrS10UlXyj3eOR0TglqnVHSjTeXwfI1ZwKhk3QHUNapl1d3Hra6VtBPiHyz3WMbjk8mS
	FPWVaAmF8gTtECBkoMUU61QtFIoMhLR/sjhI8hCVCvCoTsXw3pFWuXu4ZWV3lQsEvxkktrQVf0HsW
	3zMePC3dBSsrHjkncm65otmUJL1Aeha+o6kPrkx10zqzKQFkUf+hCl9EA5wxaZ5rRqxBUjlKLW34v
	OKmNsxuA==;
Received: from [50.219.53.154] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhV2D-0000000Dqxj-0BPR;
	Tue, 05 Mar 2024 13:40:45 +0000
From: Christoph Hellwig <hch@lst.de>
To: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: drbd-dev@lists.linbit.com,
	linux-block@vger.kernel.org
Subject: [PATCH 3/7] drbd: refactor the backing dev max_segments calculation
Date: Tue,  5 Mar 2024 06:40:37 -0700
Message-Id: <20240305134041.137006-4-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240305134041.137006-1-hch@lst.de>
References: <20240305134041.137006-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Factor out a drbd_backing_dev_max_segments helper that checks the
backing device limitation.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/drbd/drbd_nl.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index 9135001a8e572d..0326b7322ceb48 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -1295,30 +1295,39 @@ static void fixup_discard_support(struct drbd_device *device, struct request_que
 	}
 }
 
+/* This is the workaround for "bio would need to, but cannot, be split" */
+static unsigned int drbd_backing_dev_max_segments(struct drbd_device *device)
+{
+	unsigned int max_segments;
+
+	rcu_read_lock();
+	max_segments = rcu_dereference(device->ldev->disk_conf)->max_bio_bvecs;
+	rcu_read_unlock();
+
+	if (!max_segments)
+		return BLK_MAX_SEGMENTS;
+	return max_segments;
+}
+
 static void drbd_setup_queue_param(struct drbd_device *device, struct drbd_backing_dev *bdev,
 				   unsigned int max_bio_size, struct o_qlim *o)
 {
 	struct request_queue * const q = device->rq_queue;
 	unsigned int max_hw_sectors = max_bio_size >> 9;
-	unsigned int max_segments = 0;
+	unsigned int max_segments = BLK_MAX_SEGMENTS;
 	struct request_queue *b = NULL;
-	struct disk_conf *dc;
 
 	if (bdev) {
 		b = bdev->backing_bdev->bd_disk->queue;
 
 		max_hw_sectors = min(queue_max_hw_sectors(b), max_bio_size >> 9);
-		rcu_read_lock();
-		dc = rcu_dereference(device->ldev->disk_conf);
-		max_segments = dc->max_bio_bvecs;
-		rcu_read_unlock();
+		max_segments = drbd_backing_dev_max_segments(device);
 
 		blk_set_stacking_limits(&q->limits);
 	}
 
 	blk_queue_max_hw_sectors(q, max_hw_sectors);
-	/* This is the workaround for "bio would need to, but cannot, be split" */
-	blk_queue_max_segments(q, max_segments ? max_segments : BLK_MAX_SEGMENTS);
+	blk_queue_max_segments(q, max_segments);
 	blk_queue_segment_boundary(q, PAGE_SIZE-1);
 	decide_on_discard_support(device, bdev);
 
-- 
2.39.2

