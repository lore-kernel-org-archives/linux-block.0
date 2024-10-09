Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05FD191F66
	for <linux-block@vger.kernel.org>; Wed,  9 Oct 2024 11:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728473921; cv=none; b=bwBt1d9UWpMWVZ2baTZNcll8DTk0xx3UBNKoQcMD/gwBQGaOMZxif0ToY2YguN4pMr/5AFhevhGqxM4xI7nCg/j+y99z/tKWp0wkXKL2zxOj60yEgcH8ahLh1y0q4Uyz/ZU5obG0PcrLvFhMYJT3dGsq0geOJhLTuV1xtO8HdHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728473921; c=relaxed/simple;
	bh=9QkwcH0VumDboj4B2xpKLZ6NdZFXQ9w2grYzUVv+jLA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T1C1pDyHO1pSlpMby+/JvA/01S7r1igOSo4gVDIPATqp6yfONcsdShxpA2sCIIKn8lXUczE6HA8D1qiqiYYdh8PshDlmQbtdGHkYVAaR4vn+59wqWJIRTiHFqahgB+17e6D0WZr8i5+EGNnsqEZnBfdBjO26NGOrrNCwHDCFmAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LDK/uRLs; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LDK/uRLs"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=7HF9cCUfrXQa4eyGVF19sAbSeKAS3Db4XxWEDiN+6gw=; b=LDK/uRLs6Qr9e0PSDhd4TJ3PCp
	VnXxlbsgH49LBP02YDg8tbfKluacnAbneGLEmB6gGYCaXf1/8N7UPzyQjV923uQS39sdVfKqi8Xir
	MGm3q3PXM8HXkzRwNLCuoBMNEltkWDMNKxO7TiVTTBPcR9jT3qFSAgYzbeve2jwi8ynejd+1ORuaw
	JtNfRMc500G0rAFIzLDoOTpvuggJwChd8HGNm+PXYGHiY0Qe6IjDiUj+s2Uw3lD1uHzBFSeDDFyoD
	yT89Kj+1/Flpwo1ei2kYWWlBH6Ey6u9twX3CgjDXNJPIQTJ7SeDu9qRD2J4u/QumIPfRJsADcuNRj
	QpQbd4Xw==;
Received: from 2a02-8389-2341-5b80-164d-fdb4-bac5-9f5e.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:164d:fdb4:bac5:9f5e] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1syV1Z-000000095H1-3T7S;
	Wed, 09 Oct 2024 11:38:38 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	YangYang <yang.yang@vivo.com>,
	linux-block@vger.kernel.org
Subject: [PATCH 1/2] block: also mark disk-owned queues as dying in __blk_mark_disk_dead
Date: Wed,  9 Oct 2024 13:38:20 +0200
Message-ID: <20241009113831.557606-2-hch@lst.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241009113831.557606-1-hch@lst.de>
References: <20241009113831.557606-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

When del_gendisk shuts down access to a gendisk, it could lead to a
deadlock with sd or, which try to submit passthrough SCSI commands from
their ->release method under open_mutex.  The submission can be blocked
in blk_enter_queue while del_gendisk can't get to actually telling them
top stop and wake them up.

As the disk is going away there is no real point in sending these
commands, but we have no really good way to distinguish between the
cases.  For now mark even standalone (aka SCSI queues) as dying in
del_gendisk to avoid this deadlock, but the real fix will be to split
freeing a disk from freezing a queue for not disk associated requests.

Reported-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 block/genhd.c          | 16 ++++++++++++++--
 include/linux/blkdev.h |  1 +
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 1c05dd4c6980b5..7026569fa8a0be 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -589,8 +589,16 @@ static void __blk_mark_disk_dead(struct gendisk *disk)
 	if (test_and_set_bit(GD_DEAD, &disk->state))
 		return;
 
-	if (test_bit(GD_OWNS_QUEUE, &disk->state))
-		blk_queue_flag_set(QUEUE_FLAG_DYING, disk->queue);
+	/*
+	 * Also mark the disk dead if it is not owned by the gendisk.  This
+	 * means we can't allow /dev/sg passthrough or SCSI internal commands
+	 * while unbinding a ULP.  That is more than just a bit ugly, but until
+	 * we untangle q_usage_counter into one owned by the disk and one owned
+	 * by the queue this is as good as it gets.  The flag will be cleared
+	 * at the end of del_gendisk if it wasn't set before.
+	 */
+	if (!test_and_set_bit(QUEUE_FLAG_DYING, &disk->queue->queue_flags))
+		set_bit(QUEUE_FLAG_RESURRECT, &disk->queue->queue_flags);
 
 	/*
 	 * Stop buffered writers from dirtying pages that can't be written out.
@@ -719,6 +727,10 @@ void del_gendisk(struct gendisk *disk)
 	 * again.  Else leave the queue frozen to fail all I/O.
 	 */
 	if (!test_bit(GD_OWNS_QUEUE, &disk->state)) {
+		if (test_bit(QUEUE_FLAG_RESURRECT, &q->queue_flags)) {
+			clear_bit(QUEUE_FLAG_DYING, &q->queue_flags);
+			clear_bit(QUEUE_FLAG_RESURRECT, &q->queue_flags);
+		}
 		blk_queue_flag_clear(QUEUE_FLAG_INIT_DONE, q);
 		__blk_mq_unfreeze_queue(q, true);
 	} else {
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 50c3b959da2816..391e3eb3bb5e61 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -590,6 +590,7 @@ struct request_queue {
 /* Keep blk_queue_flag_name[] in sync with the definitions below */
 enum {
 	QUEUE_FLAG_DYING,		/* queue being torn down */
+	QUEUE_FLAG_RESURRECT,		/* temporarily dying */
 	QUEUE_FLAG_NOMERGES,		/* disable merge attempts */
 	QUEUE_FLAG_SAME_COMP,		/* complete on same CPU-group */
 	QUEUE_FLAG_FAIL_IO,		/* fake timeout */
-- 
2.45.2

