Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BFB155C8D
	for <linux-block@vger.kernel.org>; Tue,  5 Nov 2024 15:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730821962; cv=none; b=t2U1txfhSo/guzLUJ5sZvmr/Vuhyqh10JSA2r0XuNZ6dn1d2pErheGM53kr3oTA8t5CKAAh7bVie+GcmmOgmWOJpdv1tVbBL4ArX2wurCZRViUfn04myuPLGyCTfN0OrZed2KScjGF6/4/0VpPYkYCEj4rALo+gAmaE9vzap1sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730821962; c=relaxed/simple;
	bh=hKeuogTj3g5XrU2TfgScTxnpOLdTO4e9PQFUEEa+4E4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yz5hWQ+OQ3hNB+pfok9RhYYaAjCVbfTCasJedMbdw3h4TBhiIL/1MxkXAtjjC4mJqjhEgPlNrqw/gOLOROBl2r/mHaRN2kZ+znnUWwSkng/nkCTV0g7Q6GccDd27FtqdJXd+QuP9yvg9KNFcEc5vYXiLLOJkhjVoJMNMBD7sgoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fAsvo9I9; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fAsvo9I9"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=5Gc89PpLvBQIbwaJR2YLDb/nrrMbQ/+z/uWtAiAfH9U=; b=fAsvo9I97SG7PvYf/avZpdHESB
	ht4SBlkylTUAywWvs21IvmYdrGBUH44neynoUUrECkYs2DsKC3aBlRkiugBYALV/++0ynbv57Y45e
	vU7ZXWbNPMGil2pPdjMAh9ggDOKtdzjAU4IcimUVOR3JimhtTrG7JNuYu7fMlmxhEKyTe7VFtse+P
	9JSQDpPOKJB0C0POHyQsbPP2E1o2xaq+k0xJ+8ObPk05GaCNgxhQ7UhcM4qjyfybEGaLeaxse3Cbr
	QLdplRKhmo+7rdppiI3H1f0Yl+CrNBNEHml9A807RS+8yBda4QtZvjNJMhJBTFCtgJQWeceGVj4CJ
	shu26AfA==;
Received: from 2a02-8389-2341-5b80-f6e3-83d3-c134-af6a.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:f6e3:83d3:c134:af6a] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t8LrE-0000000HVCb-1wG9;
	Tue, 05 Nov 2024 15:52:40 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Subject: [PATCH 1/2] block: remove bio_add_hw_folio
Date: Tue,  5 Nov 2024 16:52:30 +0100
Message-ID: <20241105155235.460088-2-hch@lst.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241105155235.460088-1-hch@lst.de>
References: <20241105155235.460088-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

The only user of bio_add_hw_folio was removed in commit cafd00d0e909
("block: remove zone append special casing from the direct I/O path"),
so remove it as well.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bio.c | 23 -----------------------
 block/blk.h |  4 ----
 2 files changed, 27 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index daceb0a5c1d7..1f6ac44b4881 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1017,29 +1017,6 @@ int bio_add_hw_page(struct request_queue *q, struct bio *bio,
 	return len;
 }
 
-/**
- * bio_add_hw_folio - attempt to add a folio to a bio with hw constraints
- * @q: the target queue
- * @bio: destination bio
- * @folio: folio to add
- * @len: vec entry length
- * @offset: vec entry offset in the folio
- * @max_sectors: maximum number of sectors that can be added
- * @same_page: return if the segment has been merged inside the same folio
- *
- * Add a folio to a bio while respecting the hardware max_sectors, max_segment
- * and gap limitations.
- */
-int bio_add_hw_folio(struct request_queue *q, struct bio *bio,
-		struct folio *folio, size_t len, size_t offset,
-		unsigned int max_sectors, bool *same_page)
-{
-	if (len > UINT_MAX || offset > UINT_MAX)
-		return 0;
-	return bio_add_hw_page(q, bio, folio_page(folio, 0), len, offset,
-			       max_sectors, same_page);
-}
-
 /**
  * bio_add_pc_page	- attempt to add page to passthrough bio
  * @q: the target queue
diff --git a/block/blk.h b/block/blk.h
index 63d5df0dc29c..837a57ed1911 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -569,10 +569,6 @@ int bio_add_hw_page(struct request_queue *q, struct bio *bio,
 		struct page *page, unsigned int len, unsigned int offset,
 		unsigned int max_sectors, bool *same_page);
 
-int bio_add_hw_folio(struct request_queue *q, struct bio *bio,
-		struct folio *folio, size_t len, size_t offset,
-		unsigned int max_sectors, bool *same_page);
-
 /*
  * Clean up a page appropriately, where the page may be pinned, may have a
  * ref taken on it or neither.
-- 
2.45.2

