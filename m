Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3ABB14A0B8
	for <linux-block@vger.kernel.org>; Tue,  5 Nov 2024 15:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730821965; cv=none; b=AsL7KSQzf/NcXeCZXkM/cps3EaMKIz2hp9gD+CfQxJtFVy/Yevx3IylHYz0why8UIInGV9FI3xCHVC+VOTTYoxkP//a6qMB0OYku+ln0Tq2wAUCghF3zeV86oJd6xzkrwnnDXDgELpRCg4mPNDNkTZzJJQ4lSje/HLrFi+8x518=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730821965; c=relaxed/simple;
	bh=P+2oHcirQwFyVY6RO1glC+BTYXVfjUiu0Ob+gBj8cT8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DashE2hpnXo6L5jSf4SVCD9tDtl+ehtyrqqBcr/ypRusdw8LJVG/QPriOy5s1zJjew26hbgAtXW3lhydQRtONGMw2Tskxh5uwHJNdBloynY0ySRLBexuxZqq+wJvJaw4Hm75ZnF5DW3nvEL2jzryzpf5Eg2gKpQ3SG5UWlEsWdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=oyvoR00c; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oyvoR00c"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=t71+dXVskgE+EKET9YVfQ2jh3ha8Mx9ze/nqQs5O1Fc=; b=oyvoR00cvyedv4O4BeNNWOnlZS
	GIbgpB+GwWplhfnBl6Ig99nm5EPi5+AgdOmpeI2+9QE+moUeBAH6+U0MgBek+mHhVGZBZhxsz90RO
	muH9Abja6vjec14FSOGfIF5N6gKBgyO77hLHSFC9+nO9DSmcgdiJzgP9nOltvNB031JKu4LKOvxVN
	+4OdbP9SpPNWnnDDLPMpLOCLySUkHEul9WETTykqMrUOlaC++acKvtyQ89e5lnefn8JFDqeMt19iH
	1POHsDH8a+FY5Vb9yw9UyyLfAGBKMsPBvEJpnm3JzPvTdAMdxQcIx/SQqrWCssKBa+pea1Uw74p65
	SYyVnNRQ==;
Received: from 2a02-8389-2341-5b80-f6e3-83d3-c134-af6a.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:f6e3:83d3:c134:af6a] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t8LrG-0000000HVDJ-46Wn;
	Tue, 05 Nov 2024 15:52:43 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Subject: [PATCH 2/2] block: share more code for bio addition helpers
Date: Tue,  5 Nov 2024 16:52:31 +0100
Message-ID: <20241105155235.460088-3-hch@lst.de>
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

__bio_iov_iter_get_pages currently open codes adding pages to the bio,
which duplicates a lot of code from bio_add_page.  Add a lower level
bio_do_add_page helpers that passes down the same_page output argument
so that __bio_iov_iter_get_pages can reuse the code and also check
for the error return from it - while no error should happen due to
how the bvec space is used for the pin_user_space result I'd rather
be safe than sorry and actually check for these impossible errors.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bio.c | 66 ++++++++++++++++++++++++-----------------------------
 1 file changed, 30 insertions(+), 36 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 1f6ac44b4881..bc3bca5f0686 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1063,20 +1063,9 @@ void __bio_add_page(struct bio *bio, struct page *page,
 }
 EXPORT_SYMBOL_GPL(__bio_add_page);
 
-/**
- *	bio_add_page	-	attempt to add page(s) to bio
- *	@bio: destination bio
- *	@page: start page to add
- *	@len: vec entry length, may cross pages
- *	@offset: vec entry offset relative to @page, may cross pages
- *
- *	Attempt to add page(s) to the bio_vec maplist. This will only fail
- *	if either bio->bi_vcnt == bio->bi_max_vecs or it's a cloned bio.
- */
-int bio_add_page(struct bio *bio, struct page *page,
-		 unsigned int len, unsigned int offset)
+static int bio_do_add_page(struct bio *bio, struct page *page,
+		 unsigned int len, unsigned int offset, bool *same_page)
 {
-	bool same_page = false;
 
 	if (WARN_ON_ONCE(bio_flagged(bio, BIO_CLONED)))
 		return 0;
@@ -1085,7 +1074,7 @@ int bio_add_page(struct bio *bio, struct page *page,
 
 	if (bio->bi_vcnt > 0 &&
 	    bvec_try_merge_page(&bio->bi_io_vec[bio->bi_vcnt - 1],
-				page, len, offset, &same_page)) {
+				page, len, offset, same_page)) {
 		bio->bi_iter.bi_size += len;
 		return len;
 	}
@@ -1095,6 +1084,24 @@ int bio_add_page(struct bio *bio, struct page *page,
 	__bio_add_page(bio, page, len, offset);
 	return len;
 }
+
+/**
+ * bio_add_page	- attempt to add page(s) to bio
+ * @bio: destination bio
+ * @page: start page to add
+ * @len: vec entry length, may cross pages
+ * @offset: vec entry offset relative to @page, may cross pages
+ *
+ * Attempt to add page(s) to the bio_vec maplist.  Will only fail if the
+ * bio is full, or it is incorrectly used on a cloned bio.
+ */
+int bio_add_page(struct bio *bio, struct page *page,
+		 unsigned int len, unsigned int offset)
+{
+	bool same_page = false;
+
+	return bio_do_add_page(bio, page, len, offset, &same_page);
+}
 EXPORT_SYMBOL(bio_add_page);
 
 void bio_add_folio_nofail(struct bio *bio, struct folio *folio, size_t len,
@@ -1159,27 +1166,6 @@ void bio_iov_bvec_set(struct bio *bio, struct iov_iter *iter)
 	bio_set_flag(bio, BIO_CLONED);
 }
 
-static int bio_iov_add_folio(struct bio *bio, struct folio *folio, size_t len,
-			     size_t offset)
-{
-	bool same_page = false;
-
-	if (WARN_ON_ONCE(bio->bi_iter.bi_size > UINT_MAX - len))
-		return -EIO;
-
-	if (bio->bi_vcnt > 0 &&
-	    bvec_try_merge_page(&bio->bi_io_vec[bio->bi_vcnt - 1],
-				folio_page(folio, 0), len, offset,
-				&same_page)) {
-		bio->bi_iter.bi_size += len;
-		if (same_page && bio_flagged(bio, BIO_PAGE_PINNED))
-			unpin_user_folio(folio, 1);
-		return 0;
-	}
-	bio_add_folio_nofail(bio, folio, len, offset);
-	return 0;
-}
-
 static unsigned int get_contig_folio_len(unsigned int *num_pages,
 					 struct page **pages, unsigned int i,
 					 struct folio *folio, size_t left,
@@ -1274,6 +1260,7 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 	for (left = size, i = 0; left > 0; left -= len, i += num_pages) {
 		struct page *page = pages[i];
 		struct folio *folio = page_folio(page);
+		bool same_page = false;
 
 		folio_offset = ((size_t)folio_page_idx(folio, page) <<
 			       PAGE_SHIFT) + offset;
@@ -1286,7 +1273,14 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 			len = get_contig_folio_len(&num_pages, pages, i,
 						   folio, left, offset);
 
-		bio_iov_add_folio(bio, folio, len, folio_offset);
+		if (bio_do_add_page(bio, folio_page(folio, 0), len,
+				folio_offset, &same_page) != len) {
+			ret = -EINVAL;
+			break;
+		}
+
+		if (same_page && bio_flagged(bio, BIO_PAGE_PINNED))
+			unpin_user_folio(folio, 1);
 		offset = 0;
 	}
 
-- 
2.45.2

