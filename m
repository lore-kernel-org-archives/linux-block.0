Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F389313CFBC
	for <linux-block@vger.kernel.org>; Wed, 26 Jun 2024 04:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719378001; cv=none; b=vGsrrK3oo+PQzqCCPC5kRzyun0Xsax0QZNJ4mRWQI2YRF3THkFrKpCndH+Oq40vD93rVhMB4HHrSOieGsUP8Oe8rLhN6oKud0jVTmdFoEcq436dHvdiuXvp+/vsVX52ocSmZFn9Dgmc5bEtE8vNsZWDLJrk68mYCZtBePRbHHak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719378001; c=relaxed/simple;
	bh=OkUz3D4zTiO+M92ZwlVv+M7E3coDi1XTWr/8s2b1Q8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WUNwGpsUc+cTBBAVgkmfIzv5zlHyb5U88MBrVA9xShuyh/O5WwpWwV9OSwkgdyqVRDvf9Fk2QK55h+sra45Bk1TMGBUAS5c36fz1a2nCBDnGlHPgCSrIJoubahS3fwbzIDiGkwgQHnf4MIpu+pdmfVlOmu1xzA/gzYjVdH1Svvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=m/brbMqs; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="m/brbMqs"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=Lnzs8yVYRfhv6PKYE+JHT4C8PmQeaT+ZxW6JYLi2Evw=; b=m/brbMqsrEu0/KK99VfmITEFpW
	1bhqfSJW5A3ZJxSOUHVHQ5wcu/LXV9tQqYUS/cQ0KrKMNw9sMn02SNiQmuNq2G6utEBst+09hCFLW
	isCmx5iY+I6nVa1KkcmCY4QqtbG+wLoGUaqTJa+zFEt6KuJiNvB2VQTFSIZAM4OJgHqGSKKqIIMTc
	DePWLGrA/9VWIV101Ow1+ADQ85Qk+U/recHXn0i4FCvfthTD5mpWx4HJkCRGQ5LFr2bggaJ8zyfLe
	0ZlO8EJOobPywaA8GIUm273+GqNb3qZAK3LLDtNsdPCzHgthshDllQ3w1uxMoc8WFX+vvqPROsmI0
	UrrH6qsw==;
Received: from [2001:4bb8:2cd:5bfc:fac4:f2e7:8d6c:958e] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMKlC-00000005Nkm-49UC;
	Wed, 26 Jun 2024 04:59:59 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-block@vger.kernel.org
Subject: [PATCH 2/5] block: simplify adding the payload in bio_integrity_prep
Date: Wed, 26 Jun 2024 06:59:35 +0200
Message-ID: <20240626045950.189758-3-hch@lst.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240626045950.189758-1-hch@lst.de>
References: <20240626045950.189758-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

bio_integrity_add_page can add physically contiguous regions of any size,
so don't bother chunking up the kmalloced buffer.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bio-integrity.c | 32 ++++++--------------------------
 1 file changed, 6 insertions(+), 26 deletions(-)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index 8c5991a1c535af..2efab4b3957978 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -428,10 +428,8 @@ bool bio_integrity_prep(struct bio *bio)
 {
 	struct bio_integrity_payload *bip;
 	struct blk_integrity *bi = blk_get_integrity(bio->bi_bdev->bd_disk);
+	unsigned int len;
 	void *buf;
-	unsigned long start, end;
-	unsigned int len, nr_pages;
-	unsigned int bytes, offset, i;
 	gfp_t gfp = GFP_NOIO;
 
 	if (!bi)
@@ -471,12 +469,7 @@ bool bio_integrity_prep(struct bio *bio)
 		goto err_end_io;
 	}
 
-	end = (((unsigned long) buf) + len + PAGE_SIZE - 1) >> PAGE_SHIFT;
-	start = ((unsigned long) buf) >> PAGE_SHIFT;
-	nr_pages = end - start;
-
-	/* Allocate bio integrity payload and integrity vectors */
-	bip = bio_integrity_alloc(bio, GFP_NOIO, nr_pages);
+	bip = bio_integrity_alloc(bio, GFP_NOIO, 1);
 	if (IS_ERR(bip)) {
 		printk(KERN_ERR "could not allocate data integrity bioset\n");
 		kfree(buf);
@@ -489,23 +482,10 @@ bool bio_integrity_prep(struct bio *bio)
 	if (bi->csum_type == BLK_INTEGRITY_CSUM_IP)
 		bip->bip_flags |= BIP_IP_CHECKSUM;
 
-	/* Map it */
-	offset = offset_in_page(buf);
-	for (i = 0; i < nr_pages && len > 0; i++) {
-		bytes = PAGE_SIZE - offset;
-
-		if (bytes > len)
-			bytes = len;
-
-		if (bio_integrity_add_page(bio, virt_to_page(buf),
-					   bytes, offset) < bytes) {
-			printk(KERN_ERR "could not attach integrity payload\n");
-			goto err_end_io;
-		}
-
-		buf += bytes;
-		len -= bytes;
-		offset = 0;
+	if (bio_integrity_add_page(bio, virt_to_page(buf), len,
+			offset_in_page(buf)) < len) {
+		printk(KERN_ERR "could not attach integrity payload\n");
+		goto err_end_io;
 	}
 
 	/* Auto-generate integrity metadata if this is a write */
-- 
2.43.0

