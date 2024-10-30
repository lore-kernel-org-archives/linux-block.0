Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2ED33E7
	for <linux-block@vger.kernel.org>; Wed, 30 Oct 2024 05:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730265548; cv=none; b=VIh/A8R1pm+QWmj4nF6NWkcLNAmA6WzXW70QJEhlYnpUdJke1gJBVKq4IBSVNYuegHvvqvc09PqYwmJ7PDgzV3GOm1vqot2+/FgXLLfIfuGS9nk+Pqdojv3HA/JhfdX2PppUtUYuwFs/cX9IrQr5ynPtc5IXbiUMPFcA6PnZxww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730265548; c=relaxed/simple;
	bh=PWv7yetHly3TZXc+M+kBrelgGWIIJgdxrYlRnNU5REo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pfu+4xz5WNKbG3JZucbKxLPzS+8WUNbh0EuQmSTHMZlh0U2hvKyW1J2Pul1Vw8RaOHVJUUi8kzgOiyve3sYu5s9ZRmz2Z7GzBJvA7rg832iqyOkL4UtZgWgcIYdG878nxmh0N/MUpvrYli1Y68Zd2PEJJgyIx6KNpILjmcCgl2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=EumhCIrW; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EumhCIrW"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=o5YqS8gmho0aPr4hUf6TP0kU0mL014ttmXW/JoMITlc=; b=EumhCIrWkJs9lQxd0t0ZOdSKC0
	azABv7mcP2+jFI8fldbis8VBCwjR6B8CPWH/2jHcupBP4Qzzj7JyUvajdHLm0DKYknQWFZL63cdju
	RfgfI2A5MWQMqU1pIa95NG6k9+VyZJ2MctAOkegPq/MnnXE/RXnecmeJZBmpNC+0QB7cv5JlnbHO+
	b5nOb+pv0IlSwWOsyaJKz0cAzFiZhmOy867NasWJRn0SiWtk0Hcz8n6puyYxiA3DvHvbehK6SSXrA
	k83vEchu++deGLzeoKdklUZWSY4TyiyQNjRymm0GqzWzMDmBjuCIDZN8fg9aBZ9KziSe+6ZjqWv2E
	QfEvUfKQ==;
Received: from 2a02-8389-2341-5b80-bb25-9391-28eb-c7ed.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:bb25:9391:28eb:c7ed] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t616n-0000000GlPm-0160;
	Wed, 30 Oct 2024 05:19:05 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Chaitanya Kulkarni <kch@nvidia.com>,
	Kundan Kumar <kundan.kumar@samsung.com>,
	linux-block@vger.kernel.org
Subject: [PATCH 1/2] block: remove zone append special casing from the direct I/O path
Date: Wed, 30 Oct 2024 06:18:51 +0100
Message-ID: <20241030051859.280923-2-hch@lst.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241030051859.280923-1-hch@lst.de>
References: <20241030051859.280923-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

This code is unused, and all future zoned file systems should follow
the btrfs lead of splitting the bios themselves to the zoned limits
in the I/O submission handler, because if they didn't they would be
hit by commit ed9832bc08db ("block: introduce folio awareness and add
a bigger size from folio") breaking this code when the zone append
limit (that is usually the max_hw_sectors limit) is smaller than the
largest possible folio size.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bio.c | 34 ++--------------------------------
 1 file changed, 2 insertions(+), 32 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index ac4d77c88932..6a60d62a529d 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1206,21 +1206,12 @@ EXPORT_SYMBOL_GPL(__bio_release_pages);
 
 void bio_iov_bvec_set(struct bio *bio, struct iov_iter *iter)
 {
-	size_t size = iov_iter_count(iter);
-
 	WARN_ON_ONCE(bio->bi_max_vecs);
 
-	if (bio_op(bio) == REQ_OP_ZONE_APPEND) {
-		struct request_queue *q = bdev_get_queue(bio->bi_bdev);
-		size_t max_sectors = queue_max_zone_append_sectors(q);
-
-		size = min(size, max_sectors << SECTOR_SHIFT);
-	}
-
 	bio->bi_vcnt = iter->nr_segs;
 	bio->bi_io_vec = (struct bio_vec *)iter->bvec;
 	bio->bi_iter.bi_bvec_done = iter->iov_offset;
-	bio->bi_iter.bi_size = size;
+	bio->bi_iter.bi_size = iov_iter_count(iter);
 	bio_set_flag(bio, BIO_CLONED);
 }
 
@@ -1245,20 +1236,6 @@ static int bio_iov_add_folio(struct bio *bio, struct folio *folio, size_t len,
 	return 0;
 }
 
-static int bio_iov_add_zone_append_folio(struct bio *bio, struct folio *folio,
-					 size_t len, size_t offset)
-{
-	struct request_queue *q = bdev_get_queue(bio->bi_bdev);
-	bool same_page = false;
-
-	if (bio_add_hw_folio(q, bio, folio, len, offset,
-			queue_max_zone_append_sectors(q), &same_page) != len)
-		return -EINVAL;
-	if (same_page && bio_flagged(bio, BIO_PAGE_PINNED))
-		unpin_user_folio(folio, 1);
-	return 0;
-}
-
 static unsigned int get_contig_folio_len(unsigned int *num_pages,
 					 struct page **pages, unsigned int i,
 					 struct folio *folio, size_t left,
@@ -1365,14 +1342,7 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 			len = get_contig_folio_len(&num_pages, pages, i,
 						   folio, left, offset);
 
-		if (bio_op(bio) == REQ_OP_ZONE_APPEND) {
-			ret = bio_iov_add_zone_append_folio(bio, folio, len,
-					folio_offset);
-			if (ret)
-				break;
-		} else
-			bio_iov_add_folio(bio, folio, len, folio_offset);
-
+		bio_iov_add_folio(bio, folio, len, folio_offset);
 		offset = 0;
 	}
 
-- 
2.45.2

