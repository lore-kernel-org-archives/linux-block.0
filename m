Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FBE137757
	for <linux-block@vger.kernel.org>; Thu, 29 Feb 2024 14:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709217552; cv=none; b=Flu260eSFybJ6nyK4/7tEKxBIzLeeAmpZzjjCunzvlSGKckPWnMValcB4/CjCLoTZgJLb3STOk/udMzt3XLPhgl5azk8Vzw9zlRn53OTNysOzLJK7zcXOU7GOLN3RGc5IRAF9hJtRflMnOei2mee2nWz085S0IQPr1LovgsPlCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709217552; c=relaxed/simple;
	bh=wrUO6NjJ5EO0fL9Kr6s3bBM49H1kgVhnwqvJSzc9s2Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TSg1M7QjuKO9r4Eo1Ov+DM0yOjc+6iMJM31cSbLDLyipe2gqESUU8Mbb9pGNZbH0Acg20BTnLH8xfVOEkMJh/FX1ZPfejwqFt1xH+s4QtZf+iR4n0VFQ1NPaYm0Til3UMOUiPgZmHG6Fa8kYTxlYK+jb8qQ46r7QSxA576kBIpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=xr5lFHR7; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="xr5lFHR7"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=3d3wiWZ4gh1IydUuJ2k1At36hB0TiDUfLbBdK9F+NZ0=; b=xr5lFHR7tOU5dhc+DH1jc7FFGW
	iS0cp+D2T6m7l980piwU3CBetRvNnlpAc01/GGPRf7/eni+OLG4Rp2ydjY7kVa8nPaFHC5gamdR6Z
	YpJ8kYboKda0jJgPnnXrtJEfLcz/l7SYKAHQ2AdoTzih/OcwAv5mKTrMn2epFW1F1ne3iO83zE4Me
	3LO/jk1m4l5GoP/TYRkdGFohbiSl6Co+gbdm2jwX6BPfy1IyT6RnsuqrBXg/DDC2nN2VaoRNn6JJn
	gI37V0F1JolwUzIaH685+ZPMutCaq824EsWJsIkbcWkBOYOoTSoTOtzeEzw0vHABM0W2TTgRMCytK
	0yGBrGBA==;
Received: from [216.9.110.7] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfhYy-0000000Dtkt-2EQU;
	Thu, 29 Feb 2024 14:39:08 +0000
From: Christoph Hellwig <hch@lst.de>
To: Josef Bacik <josef@toxicpanda.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	nbd@other.debian.org
Subject: [PATCH 1/3] nbd: don't clear discard_sectors in nbd_config_put
Date: Thu, 29 Feb 2024 06:38:44 -0800
Message-Id: <20240229143846.1047223-2-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240229143846.1047223-1-hch@lst.de>
References: <20240229143846.1047223-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

nbd_config_put currently clears discard_sectors when unusing a device.
This is pretty odd behavior and different from the sector size
configuration which is simply left in places and then reconfigured when
nbd_set_size is as part of configuring the device.  Change nbd_set_size
to clear discard_sectors if discard is not supported so that all the
queue limits changes are handled in one place.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/nbd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 9ee9587375fac3..384750d5259fb8 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -336,6 +336,8 @@ static int nbd_set_size(struct nbd_device *nbd, loff_t bytesize,
 
 	if (nbd->config->flags & NBD_FLAG_SEND_TRIM)
 		blk_queue_max_discard_sectors(nbd->disk->queue, UINT_MAX);
+	else
+		blk_queue_max_discard_sectors(nbd->disk->queue, 0);
 	blk_queue_logical_block_size(nbd->disk->queue, blksize);
 	blk_queue_physical_block_size(nbd->disk->queue, blksize);
 
@@ -1351,7 +1353,6 @@ static void nbd_config_put(struct nbd_device *nbd)
 		nbd->config = NULL;
 
 		nbd->tag_set.timeout = 0;
-		blk_queue_max_discard_sectors(nbd->disk->queue, 0);
 
 		mutex_unlock(&nbd->config_lock);
 		nbd_put(nbd);
-- 
2.39.2

