Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD903B9928
	for <linux-block@vger.kernel.org>; Thu, 16 Jul 2026 09:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784193202; cv=none; b=LuuiJFyNK+vgzeLvPdxxWAzyX+Nws942GQNjquE/2cHoS8c6RFjXtQwLtWfqCHSXY62peWGhg9dWOnwT5/456pMEydMWIAZe3G9BhGWWwonaG97UoGJl56kAxF1M21UQL6sdjFxXR0mvpPdFSAiLYvKffHcfvhCfu3ozGsIdpz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784193202; c=relaxed/simple;
	bh=YYBCjZ/isJ5yh+MFLAVR6RJISiX6NxJ6A89+eIJxn5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DeiMN1oLmC8+SUMESHf6QmJ9eIgQI7UEoCo1XhRNA6+qS9wjdnRQT48WLSeaO7I/s3Kz3ElW++Bt5+ruE41VQSmDu5XvE20W73uP41WOhcQOYGX3JBnhrb0SAX3Slufj7S4ZA1vvhLZ8JcDxTe/eianyHYczhag95jed775sm0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NcLDzjCZ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NcLDzjCZ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=GQ+9VVxz3qvk3C0wTLTVTzvv6dwFHTd380M5nKQE2JY=; b=NcLDzjCZfsvsNv8+FA27NfmwUR
	DNxSoS0I6dJfyXRvCfCWPGSXEWy8sDEf7+Gagpz7bkhQR6iYDfm02k1iNsgIy0/22iHt9LsVq8yBn
	W/eGb/ctyjlo0TonRusqR5NyVULnzzw9lLukPa2xtL50WQMWBopTAwujz+9U1tlj1n5ZujNwnST9r
	nZyF7pP+MS27DQW9fqmp0XpsUIzIKMIGTbu65Tcbwcvq1qQ+Amr7h//PfpBOHYV8sWl6kym6nuJMP
	vmtFsvyfo24w5rggvs+F8vF4w8mbuJ+/r9CZs36Fo80bd8RHuhm9drNUFh3EgQ8URezHlxZSD/c8j
	QG0Q41vQ==;
Received: from 2a02-8389-2301-9f00-b29a-36e9-8c1c-0994.cable.dynamic.v6.surfer.at ([2a02:8389:2301:9f00:b29a:36e9:8c1c:994] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wkI9c-0000000GpSK-03He;
	Thu, 16 Jul 2026 09:13:16 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>,
	Neptune <z1281552865@gmail.com>,
	0wnerD1ed <l7z@0b1t.tech>,
	linux-block@vger.kernel.org
Subject: [PATCH 2/2] block: fix aligning of bounced dio read bios
Date: Thu, 16 Jul 2026 11:12:46 +0200
Message-ID: <20260716091306.316625-3-hch@lst.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260716091306.316625-1-hch@lst.de>
References: <20260716091306.316625-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

bio_iov_iter_align_down expects the "normal" biovec layout from vector 0,
while bio_iov_iter_bounce_read abuses vector 0 for a bounce buffer
allocation.  Pass an explicit bvec to bio_iov_iter_align_down to deal
with this case to avoid a double unpin.

Additionally we need to free the folio if no bio_vec could be added,
and adjust the size of the first bio_vec that contains the bounce buffer
when the I/O size is aligned down.

Fixes: e7b8b3c5b2a6 ("block: align down bounces bios")
Reported-by: 0wnerD1ed <l7z@0b1t.tech>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Tested-by: 0wnerD1ed <l7z@0b1t.tech>
Reviewed-by: Keith Busch <kbusch@kernel.org>
---
 block/bio.c | 51 ++++++++++++++++++++++++++++-----------------------
 1 file changed, 28 insertions(+), 23 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 4d6e5f5f5710..e0f6439150b1 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1191,7 +1191,7 @@ void bio_iov_bvec_set(struct bio *bio, const struct iov_iter *iter)
  * for the next iteration.
  */
 static int bio_iov_iter_align_down(struct bio *bio, struct iov_iter *iter,
-			    unsigned len_align_mask)
+				   struct bio_vec *bv, unsigned len_align_mask)
 {
 	size_t nbytes = bio->bi_iter.bi_size & len_align_mask;
 
@@ -1200,23 +1200,16 @@ static int bio_iov_iter_align_down(struct bio *bio, struct iov_iter *iter,
 
 	iov_iter_revert(iter, nbytes);
 	bio->bi_iter.bi_size -= nbytes;
-	do {
-		struct bio_vec *bv = &bio->bi_io_vec[bio->bi_vcnt - 1];
-
-		if (nbytes < bv->bv_len) {
-			bv->bv_len -= nbytes;
-			break;
-		}
-
+	while (nbytes >= bv->bv_len) {
 		if (bio_flagged(bio, BIO_PAGE_PINNED))
 			unpin_user_page(bv->bv_page);
 
-		bio->bi_vcnt--;
+		if (!--bio->bi_vcnt)
+			return -EFAULT;
 		nbytes -= bv->bv_len;
-	} while (nbytes);
-
-	if (!bio->bi_vcnt)
-		return -EFAULT;
+		bv--;
+	}
+	bv->bv_len -= nbytes;
 	return 0;
 }
 
@@ -1276,7 +1269,8 @@ int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter,
 
 	if (is_pci_p2pdma_page(bio->bi_io_vec->bv_page))
 		bio->bi_opf |= REQ_NOMERGE;
-	return bio_iov_iter_align_down(bio, iter, len_align_mask);
+	return bio_iov_iter_align_down(bio, iter,
+			&bio->bi_io_vec[bio->bi_vcnt - 1], len_align_mask);
 }
 
 static struct folio *folio_alloc_greedy(gfp_t gfp, size_t *size,
@@ -1360,7 +1354,8 @@ static int bio_iov_iter_bounce_write(struct bio *bio, struct iov_iter *iter,
 
 	if (!bio->bi_iter.bi_size)
 		return -ENOMEM;
-	return bio_iov_iter_align_down(bio, iter, minsize - 1);
+	return bio_iov_iter_align_down(bio, iter,
+			&bio->bi_io_vec[bio->bi_vcnt - 1], minsize - 1);
 }
 
 static int bio_iov_iter_bounce_read(struct bio *bio, struct iov_iter *iter,
@@ -1368,21 +1363,18 @@ static int bio_iov_iter_bounce_read(struct bio *bio, struct iov_iter *iter,
 {
 	size_t len = min3(iov_iter_count(iter), maxlen, SZ_1M);
 	struct folio *folio;
+	ssize_t ret;
 
 	folio = folio_alloc_greedy(GFP_KERNEL, &len, minsize);
 	if (!folio)
 		return -ENOMEM;
 
 	do {
-		ssize_t ret;
-
 		ret = iov_iter_extract_bvecs(iter, bio->bi_io_vec + 1, len,
 				&bio->bi_vcnt, bio->bi_max_vecs - 1, 0);
 		if (ret <= 0) {
-			if (!bio->bi_vcnt) {
-				folio_put(folio);
-				return ret;
-			}
+			if (!bio->bi_vcnt)
+				goto out_folio_put;
 			break;
 		}
 		len -= ret;
@@ -1398,7 +1390,20 @@ static int bio_iov_iter_bounce_read(struct bio *bio, struct iov_iter *iter,
 	bvec_set_folio(&bio->bi_io_vec[0], folio, bio->bi_iter.bi_size, 0);
 	if (iov_iter_extract_will_pin(iter))
 		bio_set_flag(bio, BIO_PAGE_PINNED);
-	return bio_iov_iter_align_down(bio, iter, minsize - 1);
+
+	/* The first vec stores the bounce buffer, so do not subtract 1 here. */
+	ret = bio_iov_iter_align_down(bio, iter,
+			&bio->bi_io_vec[bio->bi_vcnt], minsize - 1);
+	if (ret)
+		goto out_folio_put;
+
+	/* Update the bounc buffer bv_len to the aligned down size. */
+	bio->bi_io_vec[0].bv_len = bio->bi_iter.bi_size;
+	return 0;
+
+out_folio_put:
+	folio_put(folio);
+	return ret;
 }
 
 /**
-- 
2.53.0

