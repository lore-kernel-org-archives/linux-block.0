Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442EB2580E2
	for <linux-block@vger.kernel.org>; Thu, 12 Jun 2025 14:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749739291; cv=none; b=M74Bxskpxo/Ie8DQw7Uo0yr2R8q2Kxixn0VyyrckNq8BqHhprw2FkNqHZxh8DJQTk7NP1k1psQwsq+aJ0+9zABHVQ34XbuU8CaD4Umcfj52kNCdIT1RALOajTIHFyirGFwNBIiP7IAOY9Nk+3lrus+kAFIVgbC4qEUj6fK9y9rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749739291; c=relaxed/simple;
	bh=uNWFJLxGhZdR8etDRqRhag19KxqNtD6WJc2DvNGfTXw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TaVVhqSjDBKJdM08kGnicLJuVUSj3k60HDdbUMdPjKV7Pwsc6oa9y7js/hQA0Nc732yhpsObOvSwbQb25Hw129A1WGYZTwZEqx3OwUffn4a3znwEya43cHiMTml/ORsx/w8RKONzrD2KAB/hX1CY6cjZBga2HEyD0Lm8xr77y4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=lVIKBl3J; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lVIKBl3J"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=aWPPrtc/M23XmK4ZHe0j7BG+RUBYT982UIgUQspKsxU=; b=lVIKBl3Jq4gwcoQ49JUnUN+OLg
	7z0xa0pY0NyqX5fs3bRxDHtQpox5Muo9Fg900Dcxy1sppwBVEaarx9tlZdEF2nBbxlifV4r55fzxS
	BzHnUvrVBut4YSyzfxPftnppE0oJTyP+TO15vzzvLsAriMQmr+GvY8fo7TdY2kugOLSNNtFPWEdQd
	lI8T6kUtNKbb8qfs+NqnuOc+honBiuvpz9FJiJXt1p0i+fRxN4OYzEK40wDqssaUC8VGK4MVFArTf
	rc+3QB1Rw21HDSVTWxWqSw+8JGZGNQwJLvUpNGobMBPe64qhvOeOKZAG4ZLt+SQaxckg6nUPXcOAb
	JHzo9WUw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPj7Q-0000000BxPX-1kus;
	Thu, 12 Jun 2025 14:41:28 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-block@vger.kernel.org
Subject: [PATCH] bio: Fix bio_first_folio() for SPARSEMEM without VMEMMAP
Date: Thu, 12 Jun 2025 15:41:25 +0100
Message-ID: <20250612144126.2849931-1-willy@infradead.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is possible for physically contiguous folios to have discontiguous
struct pages if SPARSEMEM is enabled and SPARSEMEM_VMEMMAP is not.
This is correctly handled by folio_page_idx(), so remove this open-coded
implementation.

Fixes: 640d1930bef4 (block: Add bio_for_each_folio_all())
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/bio.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/bio.h b/include/linux/bio.h
index 9c37c66ef9ca..46ffac5caab7 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -291,7 +291,7 @@ static inline void bio_first_folio(struct folio_iter *fi, struct bio *bio,
 
 	fi->folio = page_folio(bvec->bv_page);
 	fi->offset = bvec->bv_offset +
-			PAGE_SIZE * (bvec->bv_page - &fi->folio->page);
+			PAGE_SIZE * folio_page_idx(fi->folio, bvec->bv_page);
 	fi->_seg_count = bvec->bv_len;
 	fi->length = min(folio_size(fi->folio) - fi->offset, fi->_seg_count);
 	fi->_next = folio_next(fi->folio);
-- 
2.47.2

