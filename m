Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF82189F58
	for <linux-block@vger.kernel.org>; Wed,  9 Oct 2024 11:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728473923; cv=none; b=onbMwwfphQk6S7VJI9L5JndALo7m/jBPL4JWW3v1bU02YTaszS2KPc960TC5aCTsOfupSMLxXXfIstEcmvY6ZNap3gS7yWziuRFZC5HKMQX3JuUUNlf2NFYSpqm0QTmfglXYHRgarqSOLKYqToYL6kVFHvlCfhnk6VRor+lqZyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728473923; c=relaxed/simple;
	bh=dTVrWIXH0bQQE0Sa3Fsh4hIuQfEVtyPnVkXbooENBac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eQUb2EkuBC/1W/yL8v/R3sZQtQP3c3dFhqEXOV2tFlumXfCtaRTnAHnOUpMZPiaOQ9gJ2qrxzi2pn+nC3zzi5G3mDJ+zqSsytyA1IoShJ6z/0gKPQAv7+eVQsWAHCfAzPk9TJPiT+BDMB2uLYcakBZALmTvQGQr+4VspLjHufIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=CaGD9eBE; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CaGD9eBE"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=nbfphBq3+o7+gUpbohB0JrKsFZAivHY2xF+Yldprnb4=; b=CaGD9eBEplpKym09WESEmZlSOQ
	vHp7n0L8RvLcyCPrgO0PBBoPPOnas0/umwlpKcAETxdJHCmT/WbGeRHb1Htte0jcF1HXJ0j1bFSnc
	+m6PbrV5lJHt9vi5CvApDbQY9dAiKmL0XGjB9u4NDfji4B1tvuKq2lFP4WKKvF81TXoOZ3SRkJz+e
	AQOtGcb8bXTApe7T0RkTHphP0pM+EPtNOMkUBEMMgSJk51ZsMsxbALljX+mnD/DyU0bxsYuf+Hb1A
	LosACAXVg9ST3tHGOKMayq6D9jIwMnxw8HHltarxQp/LqE9wpfobLXsKUQmYL6EzFPpBTUv1+GGbq
	pW2VhFgg==;
Received: from 2a02-8389-2341-5b80-164d-fdb4-bac5-9f5e.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:164d:fdb4:bac5:9f5e] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1syV1c-000000095H8-2H7k;
	Wed, 09 Oct 2024 11:38:40 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	YangYang <yang.yang@vivo.com>,
	linux-block@vger.kernel.org
Subject: [PATCH 2/2] block: mark the disk dead before taking open_mutx in del_gendisk
Date: Wed,  9 Oct 2024 13:38:21 +0200
Message-ID: <20241009113831.557606-3-hch@lst.de>
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

Now that we stop sd and sr from submitting passthrough commands from
their ->release methods we can and should start the drain before taking
->open_mutex, so that we can entirely prevent this kind of deadlock by
ensuring that the disk is clearly marked dead before open_mutex is
taken in del_gendisk.

This includes a revert of commit 7e04da2dc701 ("block: fix deadlock
between sd_remove & sd_release"), which was a partial fix for a similar
deadlock.

Reported-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Suggested-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 block/genhd.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 7026569fa8a0be..c15e8f1163664b 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -655,16 +655,6 @@ void del_gendisk(struct gendisk *disk)
 	if (WARN_ON_ONCE(!disk_live(disk) && !(disk->flags & GENHD_FL_HIDDEN)))
 		return;
 
-	disk_del_events(disk);
-
-	/*
-	 * Prevent new openers by unlinked the bdev inode.
-	 */
-	mutex_lock(&disk->open_mutex);
-	xa_for_each(&disk->part_tbl, idx, part)
-		bdev_unhash(part);
-	mutex_unlock(&disk->open_mutex);
-
 	/*
 	 * Tell the file system to write back all dirty data and shut down if
 	 * it hasn't been notified earlier.
@@ -673,10 +663,22 @@ void del_gendisk(struct gendisk *disk)
 		blk_report_disk_dead(disk, false);
 
 	/*
-	 * Drop all partitions now that the disk is marked dead.
+	 * Then mark the disk dead to stop new requests from being served ASAP.
+	 * This needs to happen before taking ->open_mutex to prevent deadlocks
+	 * with SCSI ULPs that send passthrough commands from their ->release
+	 * methods.
 	 */
-	mutex_lock(&disk->open_mutex);
 	__blk_mark_disk_dead(disk);
+
+	disk_del_events(disk);
+
+	/*
+	 * Prevent new openers by unlinking the bdev inode, and drop all
+	 * partitions.
+	 */
+	mutex_lock(&disk->open_mutex);
+	xa_for_each(&disk->part_tbl, idx, part)
+		bdev_unhash(part);
 	xa_for_each_start(&disk->part_tbl, idx, part, 1)
 		drop_partition(part);
 	mutex_unlock(&disk->open_mutex);
-- 
2.45.2

