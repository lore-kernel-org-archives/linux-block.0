Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D8558207
	for <linux-block@vger.kernel.org>; Tue, 20 Feb 2024 05:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708407202; cv=none; b=CsGclUqm46JB0EkRm867CUKSnOJhgnjTxxa7rxGgqhgx2Uee/JJDJJfiWSLeo4220/1blh+hKCg4vQwFkU1aq/qO/6j5T2HLsLbrACC3FtZ2SypF9g1jZbkFqUCDYZK7vQkBoJ9d95yJxJeZ2LP5SMxCYxldCyYPwr4aSQqMJ1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708407202; c=relaxed/simple;
	bh=na5yQ55AHPacu8N4bGSYZ0CYpSf3Vam8QaB0s7Mz/PQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AS3h5Vgy5fInmkztppk7D7CJeC4b0A5ANuSCz4wHZRIGH0CTUBq19Pz64Dm7LxbQbqWQlAvYAjFRsL+47ds5tdWyB9ekFJfrzjaf6jiD2omSO3jdjPQ+vxfyrtSqTuwFLMTf3K2Pvips9uJAy36+rqWnc8M0K+pfsW8gbzjTVis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=n0+ZUpWp; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="n0+ZUpWp"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=TIeSr4xd6S4sOqIqSCMaVmEn1kHtVHe4N36W3L/xMSw=; b=n0+ZUpWpfiZkNS03g4AU2imMfJ
	D1l16y9tQgvHv8riGVE+imHMRRZ37HgNK3uNmRslgTKQLzo+kfyYUqQXbOrbZfhU/V/8qREDSmq3+
	Ww4R6Vu5AzxTjan2U4ylql2Fquj17A1ZFWkRcEggH1R5KXy4xjeTsFGthg7BPX93lm6QLP9fzefXG
	598MgNTBnrt1HETUenqUQw2Yju0dXPgtaiya+2mhXlqjNuBxdYO3jTKqP850tTAduQdnxUDcowSMA
	FbYzrlG4VCLLfBB7fbcZLS6nEhLV5DE/5MigxX+2qEpq4DSHABEy2rPg6qetBhRhPVEGOK71VWAC7
	IPwSQj1w==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcIkd-0000000DDte-2TVv;
	Tue, 20 Feb 2024 05:33:07 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 4/5] null_blk: remove null_gendisk_register
Date: Tue, 20 Feb 2024 06:33:02 +0100
Message-Id: <20240220053303.3211004-5-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240220053303.3211004-1-hch@lst.de>
References: <20240220053303.3211004-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

null_gendisk_register isn't a very useful abstraction given that it
doesn't even allocate the gendisk.  Merge it into the only caller
instead.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Tested-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/block/null_blk/main.c | 41 ++++++++++++++---------------------
 1 file changed, 16 insertions(+), 25 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 03c3917a56fa28..0c8d5042321302 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1735,30 +1735,6 @@ static int setup_queues(struct nullb *nullb)
 	return 0;
 }
 
-static int null_gendisk_register(struct nullb *nullb)
-{
-	sector_t size = ((sector_t)nullb->dev->size * SZ_1M) >> SECTOR_SHIFT;
-	struct gendisk *disk = nullb->disk;
-
-	set_capacity(disk, size);
-
-	disk->major		= null_major;
-	disk->first_minor	= nullb->index;
-	disk->minors		= 1;
-	disk->fops		= &null_ops;
-	disk->private_data	= nullb;
-	strscpy_pad(disk->disk_name, nullb->disk_name, DISK_NAME_LEN);
-
-	if (nullb->dev->zoned) {
-		int ret = null_register_zoned_dev(nullb);
-
-		if (ret)
-			return ret;
-	}
-
-	return add_disk(disk);
-}
-
 static int null_init_tag_set(struct blk_mq_tag_set *set, int poll_queues)
 {
 	set->ops = &null_mq_ops;
@@ -1972,7 +1948,22 @@ static int null_add_dev(struct nullb_device *dev)
 		sprintf(nullb->disk_name, "nullb%d", nullb->index);
 	}
 
-	rv = null_gendisk_register(nullb);
+	set_capacity(nullb->disk,
+		((sector_t)nullb->dev->size * SZ_1M) >> SECTOR_SHIFT);
+	nullb->disk->major = null_major;
+	nullb->disk->first_minor = nullb->index;
+	nullb->disk->minors = 1;
+	nullb->disk->fops = &null_ops;
+	nullb->disk->private_data = nullb;
+	strscpy_pad(nullb->disk->disk_name, nullb->disk_name, DISK_NAME_LEN);
+
+	if (nullb->dev->zoned) {
+		rv = null_register_zoned_dev(nullb);
+		if (rv)
+			goto out_ida_free;
+	}
+
+	rv = add_disk(nullb->disk);
 	if (rv)
 		goto out_ida_free;
 
-- 
2.39.2

