Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.137.202.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793286245;
	b=Juee/xdNui+PQrsufkyx7O4YJW73MapFbzDmAgkllwJTSOgbDAKldYUg/ztMMluQRGsX
	 lyyXKRFPDoXCShe+C91JfjlfYJgAuzd7Utprr1S6iAH26ng/mkWusfQEAIHNbUIyQ3nMx
	 7IqIEvMlSx9VqtF5ZIrq2pwJ0TdSKES10tvdqcLTUt+9nnnvD6/hUDA9u/3qCh3mlJZ7i
	 1ZNRoc1ieMGCpdWs5OUv3eVlqCL9PAQimeeHiOW7dh31C6wbB/J5OXuSa5UCTsuLaFzUM
	 6s4jw9Eqz4DUS6hUZEj92eQRXtDs9YVq6KKUmg7HDNC3h0k+ScHaLzgpeKrnnKurFOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793286245;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-SRS-Rewrite;
	bh=L0ExvTHj8RwxPRVI2BFjfgzCjPfxvme8GhGL5cOlHig=;
	b=yKbjahEALjUTgV6GssYT99A1Il/ITG5geqEJMrCNNFx1VAGOdMW8vAi7Nn9UW0No4SwR
	 +cu7TzZssvOnpSXxU9jXpqUqnOgpcEWHeNv05mqmpbqhucN+Gxo6mTG0FTmhWoBWsIMlq
	 EOawAuqkMWrJ9mDKs4PL8AtSPYV7EQDCyMgJLkvHuhecdXy7gZqLb2oC5GRDJ/u70aQcf
	 zMHqhvTslCyk9iDd+vQNqar32gD02tMTpGEGkkqeiatRfNbKDHnpVRBCj6pwCzJvjTx20
	 rTegbWnXaiFUAdrc4OcItRv7IWFSGby5iKDskdLoEqeg+cnjV3Jms1WMaDWjKSfnQCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=lst.de;
	spf=none smtp.mailfrom=bombadil.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=mddKEAXU;
	arc=none smtp.remote-ip=198.137.202.133
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A985606A323
	for <linux-block@vger.kernel.org>; Thu, 29 Oct 2026 15:04:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A985606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=mddKEAXU
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=L0ExvTHj8RwxPRVI2BFjfgzCjPfxvme8GhGL5cOlHig=; b=mddKEAXUukQm5WUalWKKTHDU8Y
	1DJykeIPG5r9nQLv8hILTrMwjeH+XdcFQWiDk9CTMapEE0bqw6vDiD/dJ7ncgt0sJa7jJ0KHEYM9L
	w5426qiccfL1TTvg2RiEfUCiMMvTvqnXtc+c7Y4xdzVMgVthUEmR67Hs4OZ9qbVab+Ca51Lfk7SI5
	G9gxr5oIKDLjQChm77ux2f/L+pltJsXi80HFvtgifBTRYuZozt6eX19Y3u2qvj31U1dKe/SwxXiDn
	MUApUeWbG5CIsXcmwSPDDgv/T9ZH+fEV7nCfUfelW0b/WFhymzPzOUTfZlhPn4WemdooZO/p+q+wV
	MygPUEFQ==;
Received: from 2a02-8389-2301-9f00-31e8-efb6-e973-61ca.cable.dynamic.v6.surfer.at ([2a02:8389:2301:9f00:31e8:efb6:e973:61ca] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMRff-00000009btC-3m4a;
	Thu, 29 Oct 2026 15:04:04 +0000
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>,
	Jens Axboe <axboe@kernel.dk>
Cc: Josef Bacik <josef@toxicpanda.com>,
	linux-block@vger.kernel.org
Subject: [PATCH 2/4] zloop: share more code for opening a zone backing file
Date: Thu, 29 Oct 2026 16:03:33 +0100
Message-ID: <20261029150353.2503201-3-hch@lst.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261029150353.2503201-1-hch@lst.de>
References: <20261029150353.2503201-1-hch@lst.de>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Use a common path for opening and querying the block size.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/zloop.c | 65 +++++++++++++++++--------------------------
 1 file changed, 26 insertions(+), 39 deletions(-)

diff --git a/drivers/block/zloop.c b/drivers/block/zloop.c
index 71f7685efb13..3dc484e3c700 100644
--- a/drivers/block/zloop.c
+++ b/drivers/block/zloop.c
@@ -1107,8 +1107,6 @@ static int zloop_init_zone(struct zloop_device *zlo, struct zloop_options *opts,
 {
 	struct zloop_zone *zone = &zlo->zones[zone_no];
 	int oflags = O_RDWR;
-	struct kstat stat;
-	sector_t file_sectors;
 	int ret;
 
 	mutex_init(&zone->lock);
@@ -1122,27 +1120,33 @@ static int zloop_init_zone(struct zloop_device *zlo, struct zloop_options *opts,
 	if (!opts->buffered_io)
 		oflags |= O_DIRECT;
 
+	zone->file = zloop_filp_open_fmt(oflags, 0600, "%s/%u/%s-%06u",
+				zlo->base_dir, zlo->id,
+				zone_no < zlo->nr_conv_zones ? "cnv" : "seq",
+				zone_no);
+	if (IS_ERR(zone->file)) {
+		pr_err("Failed to open zone %u file %s/%u/%s-%06u (err=%ld)",
+		       zone_no, zlo->base_dir, zlo->id,
+		       zone_no < zlo->nr_conv_zones ? "cnv" : "seq",
+		       zone_no, PTR_ERR(zone->file));
+		return PTR_ERR(zone->file);
+	}
+
+	if (zlo->block_size) {
+		ret = zloop_get_block_size(zlo, zone);
+		if (ret)
+			return ret;
+	}
+
 	if (zone_no < zlo->nr_conv_zones) {
+		sector_t file_sectors;
+		struct kstat stat;
+
 		/* Conventional zone file. */
 		set_bit(ZLOOP_ZONE_CONV, &zone->flags);
 		zone->cond = BLK_ZONE_COND_NOT_WP;
 		zone->wp = U64_MAX;
 
-		zone->file = zloop_filp_open_fmt(oflags, 0600, "%s/%u/cnv-%06u",
-					zlo->base_dir, zlo->id, zone_no);
-		if (IS_ERR(zone->file)) {
-			pr_err("Failed to open zone %u file %s/%u/cnv-%06u (err=%ld)",
-			       zone_no, zlo->base_dir, zlo->id, zone_no,
-			       PTR_ERR(zone->file));
-			return PTR_ERR(zone->file);
-		}
-
-		if (!zlo->block_size) {
-			ret = zloop_get_block_size(zlo, zone);
-			if (ret)
-				return ret;
-		}
-
 		ret = vfs_getattr(&zone->file->f_path, &stat, STATX_SIZE, 0);
 		if (ret < 0) {
 			pr_err("Failed to get zone %u file stat\n", zone_no);
@@ -1163,30 +1167,13 @@ static int zloop_init_zone(struct zloop_device *zlo, struct zloop_options *opts,
 			       zone_no, ret);
 			return ret;
 		}
-
-		return 0;
-	}
-
-	/* Sequential zone file. */
-	zone->file = zloop_filp_open_fmt(oflags, 0600, "%s/%u/seq-%06u",
-					 zlo->base_dir, zlo->id, zone_no);
-	if (IS_ERR(zone->file)) {
-		pr_err("Failed to open zone %u file %s/%u/seq-%06u (err=%ld)",
-		       zone_no, zlo->base_dir, zlo->id, zone_no,
-		       PTR_ERR(zone->file));
-		return PTR_ERR(zone->file);
-	}
-
-	if (!zlo->block_size) {
-		ret = zloop_get_block_size(zlo, zone);
-		if (ret)
-			return ret;
+	} else {
+		/* Sequential zone file. */
+		mutex_lock(&zone->lock);
+		ret = zloop_update_seq_zone(zlo, zone_no);
+		mutex_unlock(&zone->lock);
 	}
 
-	mutex_lock(&zone->lock);
-	ret = zloop_update_seq_zone(zlo, zone_no);
-	mutex_unlock(&zone->lock);
-
 	return ret;
 }
 
-- 
2.53.0

