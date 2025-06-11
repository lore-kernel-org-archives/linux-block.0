Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBAF517E
	for <linux-block@vger.kernel.org>; Wed, 11 Jun 2025 04:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749617062; cv=none; b=YqpSSSAY05HKshFUjKnYIgmoMht6qLaAB+p2++HPj3HsGL+KdpSRm642JZIQYh+OEtbbhzFfPP0J/J+Iqzo1LGJr6KmTHJF0ItB2mZ2guX6UFt3lpyTPk4ssTPCOMB46l6/UwheRdOFuBXF7Ri7rJiGy9yY/vgDrAEYcDkHxbxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749617062; c=relaxed/simple;
	bh=G7JWojgG4//ms9i5vSjUMwT5ktktmxRAhhuV1H5DNCg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tnDQfKjimBTS2+Eaa9/YuUQsp8BmxA/duLtS3SpeRfUOptS502uqtWcHcetgL5c83yOVbghnK949qNBsnkzSCVOmOggaT0qW9tcys585ENaKbL1fr6A+BXEkIRH8vpsh7zYUHJERU7xasba/d5kS+3OPDsswDRi/HesdFS7XUAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ywO6DHIj; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ywO6DHIj"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=EIxh+NFCEgWshuEoGSNngdOiQmg4pryu0fQ3knqA/QA=; b=ywO6DHIjHLjepIL0w3u1q/9llF
	a64/qhyaV+x7fwOFfJcuHU41qHRnZyK/mcuOgs1XYD52YDBf745TEOl4czUXvTRBs7240ASDvkAfZ
	GxiKisTwivXHLOxti++NQBjfzYSpzKK0KHtMsKijZNxa6i3Fc+8YDdTi2NX3LPj65iWcPNyJ/IfSW
	p5+ktOkm+YxAWz2Z4DrEeNIeJX03bfNeQwJT+K7/IHcKlNXEE4F4l/mLShr+FaV/RyU6T7GisE7S0
	zLiBqgRsglw3YKlwQPGmJV4yocAmRISeZaRJlUzL7JnpD8tdc9GS5roJ31UUerDQyNSoj64FF6M41
	XHd5iavQ==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPDJz-00000008q3j-3XZ1;
	Wed, 11 Jun 2025 04:44:20 +0000
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH] block: don't use submit_bio_noacct_nocheck in blk_zone_wplug_bio_work
Date: Wed, 11 Jun 2025 06:44:16 +0200
Message-ID: <20250611044416.2351850-1-hch@lst.de>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Bios queued up in the zone write plug have already gone through all all
preparation in the submit_bio path, including the freeze protection.

Submitting them through submit_bio_noacct_nocheck duplicates the work
and can can cause deadlocks when freezing a queue with pending bio
write plugs.

Go straight to ->submit_bio or blk_mq_submit_bio to bypass the
superfluous extra freeze protection and checks.

Fixes: 9b1ce7f0c6f8 ("block: Implement zone append emulation")
Reported-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-zoned.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 8f15d1aa6eb8..45c91016cef3 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -1306,7 +1306,6 @@ static void blk_zone_wplug_bio_work(struct work_struct *work)
 	spin_unlock_irqrestore(&zwplug->lock, flags);
 
 	bdev = bio->bi_bdev;
-	submit_bio_noacct_nocheck(bio);
 
 	/*
 	 * blk-mq devices will reuse the extra reference on the request queue
@@ -1314,8 +1313,12 @@ static void blk_zone_wplug_bio_work(struct work_struct *work)
 	 * path for BIO-based devices will not do that. So drop this extra
 	 * reference here.
 	 */
-	if (bdev_test_flag(bdev, BD_HAS_SUBMIT_BIO))
+	if (bdev_test_flag(bdev, BD_HAS_SUBMIT_BIO)) {
+		bdev->bd_disk->fops->submit_bio(bio);
 		blk_queue_exit(bdev->bd_disk->queue);
+	} else {
+		blk_mq_submit_bio(bio);
+	}
 
 put_zwplug:
 	/* Drop the reference we took in disk_zone_wplug_schedule_bio_work(). */
-- 
2.47.2

