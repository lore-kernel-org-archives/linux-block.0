Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D73F179A4
	for <linux-block@vger.kernel.org>; Thu, 22 Feb 2024 07:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708587417; cv=none; b=S7qaVNgOXbGJDU8qJu4fF/gDY2fV/VEOiaVnp6d5M/+7qQ72EWyQA1rF5+YxZV1dGNfkAxwdm3yejH8kffL1t3XvGm6807B2JOccF2Ne+XttpiQGZZTPhliN/rb0yt9j/f8ZGpUwZupujRiG5MfWHWSVLxrMF/m8qdyU+Ev0Iz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708587417; c=relaxed/simple;
	bh=9zkAhtWfxJ2dNpbPoFbNLhCeu6eAC4Kin7/jqfcHs9I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Fyd+bjvGEKVPx3xjZhQ0tdFgWMYSugC4KDd3J2URMtJ2Y9VvF1ngt9sAOQSskAsH7q9cuRj/7L0xZYJU7VO8DKLn+XjyzKV2kfIJpmT4nHL2mtARqZAT8cp7Ui8Cvrac5XYTLyEG287hulkvWAGCn1tSro+oE7j9Wmzh14Tn65g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HibUqFoZ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HibUqFoZ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=rS1tMcXj9jp7jpu8D9nPDQ1LD7P6bi5sz2Xap6q80iU=; b=HibUqFoZZmgcH2jOXkXi4waaG3
	otvh0Ej85KVBFfjGVm4faxTPeO2DcM93I/QNelh2pydmLnnyudrvNvWny1msRjRq17E1x1NDvj9Df
	s32evzkwyw5gmg32BHYaAKGz81NSOYY/pdD/pDABTklJDFQI8hxOof04oFKsxbfiexJxNb2cjsaKO
	qbFIrdvY7lTZzawuh0tj3w7UxmIxNeQisSWgDmnmGRka9wm8PpnNhx9adZKuuJ2mg+DjsfCkzVf8S
	W0PNnyZ2abG2W5QWKQCtq1Qq+9wvafs2si/Fou29wK9X+hjDqj1GcU0aN0ulhPvFhlvoGDryfpUb8
	lP1DZAYw==;
Received: from [2001:4bb8:19a:62b2:c70:4a89:bc61:3] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rd3dW-00000003psW-1ZlD;
	Thu, 22 Feb 2024 07:36:54 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Subject: [PATCH 2/2] pktcdvd: set queue limits at disk allocation time
Date: Thu, 22 Feb 2024 08:36:47 +0100
Message-Id: <20240222073647.3776769-3-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240222073647.3776769-1-hch@lst.de>
References: <20240222073647.3776769-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Remove pkt_init_queue and just pass the two parameters directly to
blk_alloc_disk.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/pktcdvd.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index 0cd65b27c19717..12fcc881b04f54 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -2484,14 +2484,6 @@ static void pkt_submit_bio(struct bio *bio)
 	bio_io_error(bio);
 }
 
-static void pkt_init_queue(struct pktcdvd_device *pd)
-{
-	struct request_queue *q = pd->disk->queue;
-
-	blk_queue_logical_block_size(q, CD_FRAMESIZE);
-	blk_queue_max_hw_sectors(q, PACKET_MAX_SECTORS);
-}
-
 static int pkt_new_dev(struct pktcdvd_device *pd, dev_t dev)
 {
 	struct device *ddev = disk_to_dev(pd->disk);
@@ -2535,8 +2527,6 @@ static int pkt_new_dev(struct pktcdvd_device *pd, dev_t dev)
 	pd->bdev_handle = bdev_handle;
 	set_blocksize(bdev_handle->bdev, CD_FRAMESIZE);
 
-	pkt_init_queue(pd);
-
 	atomic_set(&pd->cdrw.pending_bios, 0);
 	pd->cdrw.thread = kthread_run(kcdrwd, pd, "%s", pd->disk->disk_name);
 	if (IS_ERR(pd->cdrw.thread)) {
@@ -2633,6 +2623,10 @@ static const struct block_device_operations pktcdvd_ops = {
  */
 static int pkt_setup_dev(dev_t dev, dev_t* pkt_dev)
 {
+	struct queue_limits lim = {
+		.max_hw_sectors		= PACKET_MAX_SECTORS,
+		.logical_block_size	= CD_FRAMESIZE,
+	};
 	int idx;
 	int ret = -ENOMEM;
 	struct pktcdvd_device *pd;
@@ -2672,7 +2666,7 @@ static int pkt_setup_dev(dev_t dev, dev_t* pkt_dev)
 	pd->write_congestion_on  = write_congestion_on;
 	pd->write_congestion_off = write_congestion_off;
 
-	disk = blk_alloc_disk(NULL, NUMA_NO_NODE);
+	disk = blk_alloc_disk(&lim, NUMA_NO_NODE);
 	if (IS_ERR(disk)) {
 		ret = PTR_ERR(disk);
 		goto out_mem;
-- 
2.39.2

