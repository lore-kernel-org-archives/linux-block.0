Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167CF397347
	for <linux-block@vger.kernel.org>; Tue, 23 Jun 2026 14:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782225006; cv=none; b=PV4OZ+1zWTHQzCPs6Bk0tcZZszRVyEcXX1gAg0YusIJwLDD9+yt8ss6sSxEhquWJClUai/QMGi8QJRF9fLiXIgOcSoSozupm3aV4CdA3N+q9jCInWS2CF0LehKPfC3nWrpwIUslnMCy4JxBggH3XSG9GyxnM9agc/jdatnG/PTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782225006; c=relaxed/simple;
	bh=hfOIkdc5Zw35qHanttUbIO589yyCr5XL89QkEnK9iYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hLHNijQzV5n/UgxVZrQESswdjmEStwSLoWbzRXrfnj5lLA1ilUGbzST6gWy7OhDDZLKFShnAcd5+9xRzzW8/43WuABXRqClUNKHmBvw1gLdNb/g9rClEx2pUzUNE2YxhDvbK55QRsNKm2Q++kjz/z6WWt7016OkxLQVG7sc0gtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Ianb92FC; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ianb92FC"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=w0KlmDpFAdrq6Y07EZi/LCUCq731YMzjPQAL0znZki8=; b=Ianb92FCYefp5Qyn8rJ0FA7nwB
	9B2mu+ePFJgvGoAjnERVPAjQxkhcSGh3y1Vtpjkyyy43GSf56gH8npsYcM8nR/3HfYBDUD1KLn/lI
	ISB0OKOPvdEPSOTAAvuE9qj24avg5qBrlcdTq2m3LqRCYFMtMbOgmpOE5dggf8noBlhcR0YZtuFUU
	k9mvVyj/E0DpRqUV9J5kLnfsGsxtYcb1IJT66wANUUISA949zwJQpRNFslTOG2TouORELv0SCXOPb
	sBIvsYeF6MY605Ij1rP6hDCpqJAkj72vlKqVRZNKlZrnNOYVLO2vsmgBBiYbEuypTyeDkC2z5ymJz
	dcTFb0EA==;
Received: from [2001:4bb8:2f6:ef61:5b2b:8638:3844:9408] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wc28a-00000006RZ2-0tvF;
	Tue, 23 Jun 2026 14:30:04 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-block@vger.kernel.org
Subject: [PATCH 1/2] block: fix GFP_ flags confusion in bio_integrity_alloc_buf
Date: Tue, 23 Jun 2026 16:29:48 +0200
Message-ID: <20260623142957.1839474-2-hch@lst.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260623142957.1839474-1-hch@lst.de>
References: <20260623142957.1839474-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

bio_integrity_alloc_buf usage of GFP_ flags is messed up.  For one it
mixes GFP_NOFS and GFP_NOIO for neighbouring allocations, but it also
makes the allocations fail more often than needed.  That code was copied
from bio_alloc_bioset which needs to do that so that it can punt to the
rescuer workqueue, but none of that is needed for the integrity
allocations that either sits in the file system or at the very bottom
of the I/O stack.  Failing early means we'll do a fully waiting
allocation from the mempool ->alloc callback which is usually much
larger than required.

Fix this by passing a gfp_t so that the file system path can pass
GFP_NOFS and the auto-integrity code can pass GFP_NOIO, and don't
modify the allocation type except for disabling warnings.

Fixes: ec7f31b2a2d3 ("block: make bio auto-integrity deadlock safe")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bio-integrity-auto.c    | 2 +-
 block/bio-integrity-fs.c      | 4 ++--
 block/bio-integrity.c         | 8 +++-----
 include/linux/bio-integrity.h | 2 +-
 4 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/block/bio-integrity-auto.c b/block/bio-integrity-auto.c
index 353eed632fcc..b1c733ecfd2e 100644
--- a/block/bio-integrity-auto.c
+++ b/block/bio-integrity-auto.c
@@ -94,7 +94,7 @@ void bio_integrity_prep(struct bio *bio, unsigned int action)
 	bio_integrity_init(bio, &bid->bip, &bid->bvec, 1);
 	bid->bio = bio;
 	bid->bip.bip_flags |= BIP_BLOCK_INTEGRITY;
-	bio_integrity_alloc_buf(bio, action & BI_ACT_ZERO);
+	bio_integrity_alloc_buf(bio, GFP_NOIO, action & BI_ACT_ZERO);
 	if (action & BI_ACT_CHECK)
 		bio_integrity_setup_default(bio);
 
diff --git a/block/bio-integrity-fs.c b/block/bio-integrity-fs.c
index 0daa42d9ead7..9c5fe5fa8f0d 100644
--- a/block/bio-integrity-fs.c
+++ b/block/bio-integrity-fs.c
@@ -23,10 +23,10 @@ unsigned int fs_bio_integrity_alloc(struct bio *bio)
 	if (!action)
 		return 0;
 
-	iib = mempool_alloc(&fs_bio_integrity_pool, GFP_NOIO);
+	iib = mempool_alloc(&fs_bio_integrity_pool, GFP_NOFS);
 	bio_integrity_init(bio, &iib->bip, &iib->bvec, 1);
 
-	bio_integrity_alloc_buf(bio, action & BI_ACT_ZERO);
+	bio_integrity_alloc_buf(bio, GFP_NOFS, action & BI_ACT_ZERO);
 	if (action & BI_ACT_CHECK)
 		bio_integrity_setup_default(bio);
 	return action;
diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index e796de1a749e..488eba228c6e 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -64,20 +64,18 @@ unsigned int __bio_integrity_action(struct bio *bio)
 }
 EXPORT_SYMBOL_GPL(__bio_integrity_action);
 
-void bio_integrity_alloc_buf(struct bio *bio, bool zero_buffer)
+void bio_integrity_alloc_buf(struct bio *bio, gfp_t gfp, bool zero_buffer)
 {
 	struct blk_integrity *bi = blk_get_integrity(bio->bi_bdev->bd_disk);
 	struct bio_integrity_payload *bip = bio_integrity(bio);
 	unsigned int len = bio_integrity_bytes(bi, bio_sectors(bio));
-	gfp_t gfp = GFP_NOIO | (zero_buffer ? __GFP_ZERO : 0);
 	void *buf;
 
-	buf = kmalloc(len, (gfp & ~__GFP_DIRECT_RECLAIM) |
-			__GFP_NOMEMALLOC | __GFP_NORETRY | __GFP_NOWARN);
+	buf = kmalloc(len, gfp | __GFP_NOWARN | zero_buffer ? __GFP_ZERO : 0);
 	if (unlikely(!buf)) {
 		struct page *page;
 
-		page = mempool_alloc(&integrity_buf_pool, GFP_NOFS);
+		page = mempool_alloc(&integrity_buf_pool, gfp);
 		if (zero_buffer)
 			memset(page_address(page), 0, len);
 		bvec_set_page(&bip->bip_vec[0], page, len, 0);
diff --git a/include/linux/bio-integrity.h b/include/linux/bio-integrity.h
index af5178434ec6..c3dda32fd803 100644
--- a/include/linux/bio-integrity.h
+++ b/include/linux/bio-integrity.h
@@ -141,7 +141,7 @@ static inline int bio_integrity_add_page(struct bio *bio, struct page *page,
 }
 #endif /* CONFIG_BLK_DEV_INTEGRITY */
 
-void bio_integrity_alloc_buf(struct bio *bio, bool zero_buffer);
+void bio_integrity_alloc_buf(struct bio *bio, gfp_t gfp, bool zero_buffer);
 void bio_integrity_free_buf(struct bio_integrity_payload *bip);
 void bio_integrity_setup_default(struct bio *bio);
 
-- 
2.53.0

