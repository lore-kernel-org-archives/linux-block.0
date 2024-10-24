Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA78157A72;
	Thu, 24 Oct 2024 05:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729746032; cv=none; b=J03gC5+XjIwMysAAcmaydm5whx08b5J2ktk5eod7WrVwdy+jkarYMhZQtj/kr7Qj3qPKRlPbUygoGPxfIKurcN6F2FYGVMsbVjtUM6rJCKntfgaqaMLvJtlJKg6S7wErWtwHh/mf4fjHNcvupoEJdWtJjyb3h7yk/6zFtxy/mvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729746032; c=relaxed/simple;
	bh=vOZlOfvvHlHdcmizotR254p75Ian99uDLg8Ra3nRPIM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R6X+73q4f62OxlLnTMmCKD6eI/aj05F39MD2/P1Vpce/R2dXTGN0/YpnKdXrx3dlK73dSFDcrBwwKOX0BcUgISLYrkY+z9F8p/IiCYkHOrPUbOJcUDcNA3E3S6q4C1ryzWCJQEayP+1dIJydaG4MKrpP4VtIu0VXbUKZJBtAaRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Shq5lTT3; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Shq5lTT3"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=33dh5ptf7K7+w6J4b7L5weA0XvmksgkwCzeOBkeP89o=; b=Shq5lTT3Kj73IdrJUEXNEZbe8q
	pxY0v9rSHfd+OEG3Vap2aTUNBgBxskWnC4J7jKlA5g1vJP6S1wQF6tIMUfrKxfdIydJHzuRThmhMp
	uB9t8wYEbf5RMCd80lFrBetdCWjX0qQEVj61kR7n5vbaafwWn2r3dPLgZvTJgchQ6LJDXAqVJ9lHi
	mwLANL5lUqJnEO4+AXOjmSxXivxvGmk21S7FmYNB/oOOeQ5prndkpIdw9VEgnai+2ca9eOgWedQwN
	OwxZKwn5V8X6x0AkEId2jV9BngwV+rVC14NXPFS+D6+tn8ytr8ej4Dv2IU86+K/dHB/3ykAafxRs+
	99z8jOgg==;
Received: from 2a02-8389-2341-5b80-fb3e-99eb-94f3-ec06.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:fb3e:99eb:94f3:ec06] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t3pxR-0000000Gkoz-3sPl;
	Thu, 24 Oct 2024 05:00:26 +0000
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: akpm@linux-foundation.org,
	viro@zeniv.linux.org.uk,
	dhowells@redhat.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ming.lei@redhat.com
Subject: [PATCH] iov_iter: don't require contiguous pages in iov_iter_extract_bvec_pages
Date: Thu, 24 Oct 2024 07:00:15 +0200
Message-ID: <20241024050021.627350-1-hch@lst.de>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

From: Ming Lei <ming.lei@redhat.com>

The iov_iter_extract_pages interface allows to return physically
discontiguous pages, as long as all but the first and last page
in the array are page aligned and page size.  Rewrite
iov_iter_extract_bvec_pages to take advantage of that instead of only
returning ranges of physically contiguous pages.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
[hch: minor cleanups, new commit log]
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 lib/iov_iter.c | 67 +++++++++++++++++++++++++++++++++-----------------
 1 file changed, 45 insertions(+), 22 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 1abb32c0da50..9fc06f5fb748 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1677,8 +1677,8 @@ static ssize_t iov_iter_extract_xarray_pages(struct iov_iter *i,
 }
 
 /*
- * Extract a list of contiguous pages from an ITER_BVEC iterator.  This does
- * not get references on the pages, nor does it get a pin on them.
+ * Extract a list of virtually contiguous pages from an ITER_BVEC iterator.
+ * This does not get references on the pages, nor does it get a pin on them.
  */
 static ssize_t iov_iter_extract_bvec_pages(struct iov_iter *i,
 					   struct page ***pages, size_t maxsize,
@@ -1686,35 +1686,58 @@ static ssize_t iov_iter_extract_bvec_pages(struct iov_iter *i,
 					   iov_iter_extraction_t extraction_flags,
 					   size_t *offset0)
 {
-	struct page **p, *page;
-	size_t skip = i->iov_offset, offset, size;
-	int k;
+	size_t skip = i->iov_offset, size = 0;
+	struct bvec_iter bi;
+	int k = 0;
 
-	for (;;) {
-		if (i->nr_segs == 0)
-			return 0;
-		size = min(maxsize, i->bvec->bv_len - skip);
-		if (size)
-			break;
+	if (i->nr_segs == 0)
+		return 0;
+
+	if (i->iov_offset == i->bvec->bv_len) {
 		i->iov_offset = 0;
 		i->nr_segs--;
 		i->bvec++;
 		skip = 0;
 	}
+	bi.bi_size = maxsize + skip;
+	bi.bi_bvec_done = skip;
+
+	maxpages = want_pages_array(pages, maxsize, skip, maxpages);
+
+	while (bi.bi_size && bi.bi_idx < i->nr_segs) {
+		struct bio_vec bv = bvec_iter_bvec(i->bvec, bi);
+
+		/*
+		 * The iov_iter_extract_pages interface only allows an offset
+		 * into the first page.  Break out of the loop if we see an
+		 * offset into subsequent pages, the caller will have to call
+		 * iov_iter_extract_pages again for the reminder.
+		 */
+		if (k) {
+			if (bv.bv_offset)
+				break;
+		} else {
+			*offset0 = bv.bv_offset;
+		}
 
-	skip += i->bvec->bv_offset;
-	page = i->bvec->bv_page + skip / PAGE_SIZE;
-	offset = skip % PAGE_SIZE;
-	*offset0 = offset;
+		(*pages)[k++] = bv.bv_page;
+		size += bv.bv_len;
 
-	maxpages = want_pages_array(pages, size, offset, maxpages);
-	if (!maxpages)
-		return -ENOMEM;
-	p = *pages;
-	for (k = 0; k < maxpages; k++)
-		p[k] = page + k;
+		if (k >= maxpages)
+			break;
+
+		/*
+		 * We are done when the end of the bvec doesn't align to a page
+		 * boundary as that would create a hole in the returned space.
+		 * The caller will handle this with another call to
+		 * iov_iter_extract_pages.
+		 */
+		if (bv.bv_offset + bv.bv_len != PAGE_SIZE)
+			break;
+
+		bvec_iter_advance_single(i->bvec, &bi, bv.bv_len);
+	}
 
-	size = min_t(size_t, size, maxpages * PAGE_SIZE - offset);
 	iov_iter_advance(i, size);
 	return size;
 }
-- 
2.45.2

