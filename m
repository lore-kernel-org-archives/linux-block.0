Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538BE3128C6
	for <linux-block@vger.kernel.org>; Wed, 15 Jul 2026 06:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784097747; cv=none; b=AaRSL65JI1G0dQ7GVxeu1sv5J3juGe/YdRhblpzwzgjlerExfAJGzTCbHeKCdIM5Fldnga51r1Lif7sSDqUA9ZfX1yKcRzTjr+Sq8I/frcfqiUY9SpuJpzP6vJXIP5Z1vGy4Dofqum8oP3fDQ33a3Y+zeTrRzkA1RyLLZgzksAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784097747; c=relaxed/simple;
	bh=h3R+dNRp8cCBCGpHzRqd3qX4m4w2Y/OJ/0e38aEm9aM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FBZB0osUWsEWb7PS4gXHNNd0Nba7I1Oh5nZMHeiOK+cqQEeBIkKzgLbuyTzBv28Fs2HDOeYV9RmdvYku87npaSbi7M9y7V+Rx+MFhsOhUKT97kXnrLd6cmKOmGaI6KCCuxG4VQzfbNhuJBdb/A3OanXfGXn4yhZaBbLPIKnOwO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fnvgE6zB; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fnvgE6zB"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=sGqo/NUBIDSI2qpwa/As/1AUFYgB3qRRiANoCTfu2SU=; b=fnvgE6zBPkedCquPNjheiijRIT
	IFhY3X+xtBb0wTDtYK1OjBvEu8a48Oyh1yPctpP5S/tEXBTURH21mJvwwIMLO80Z1FaAwyf9HpWRt
	34HlWZI0ZlZ5oX77BJAT6mWXvJBufFMXcEEaS33LRxoNQyz+eNBBAIjwjKr6k84cIQv04YV/DtYOj
	oxR1u+jxhUxEhTFo3hT6SlhtVd7CaZmXFLIDdJ/txIFS/zTvMwUPh4Z8YWykbNQ4Iwi56MbZghzxx
	JQKO7LQl5VtD/LnzPcd2QAq/uToEunu8QcXg4Q1dF437joENyQXLt8oTXWyzkdVQxAYmnL6YDKvpe
	0MmsVDdg==;
Received: from 2a02-8389-2301-9f00-3397-c9eb-6d8a-9179.cable.dynamic.v6.surfer.at ([2a02:8389:2301:9f00:3397:c9eb:6d8a:9179] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjtK4-0000000Dviw-1EZL;
	Wed, 15 Jul 2026 06:42:24 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>,
	Neptune <z1281552865@gmail.com>,
	linux-block@vger.kernel.org
Subject: [PATCH 2/2] block: fix aligning of bounced dio read bios
Date: Wed, 15 Jul 2026 08:42:08 +0200
Message-ID: <20260715064215.2934345-3-hch@lst.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260715064215.2934345-1-hch@lst.de>
References: <20260715064215.2934345-1-hch@lst.de>
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
Reported-by: Neptune <z1281552865@gmail.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Keith Busch <kbusch@kernel.org>
---
 block/bio.c | 41 ++++++++++++++++++++++++++---------------
 1 file changed, 26 insertions(+), 15 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 4d6e5f5f5710..9d59cf496328 100644
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
 
@@ -1200,9 +1200,7 @@ static int bio_iov_iter_align_down(struct bio *bio, struct iov_iter *iter,
 
 	iov_iter_revert(iter, nbytes);
 	bio->bi_iter.bi_size -= nbytes;
-	do {
-		struct bio_vec *bv = &bio->bi_io_vec[bio->bi_vcnt - 1];
-
+	for (;;) {
 		if (nbytes < bv->bv_len) {
 			bv->bv_len -= nbytes;
 			break;
@@ -1211,9 +1209,10 @@ static int bio_iov_iter_align_down(struct bio *bio, struct iov_iter *iter,
 		if (bio_flagged(bio, BIO_PAGE_PINNED))
 			unpin_user_page(bv->bv_page);
 
-		bio->bi_vcnt--;
 		nbytes -= bv->bv_len;
-	} while (nbytes);
+		bio->bi_vcnt--;
+		bv--;
+	}
 
 	if (!bio->bi_vcnt)
 		return -EFAULT;
@@ -1276,7 +1275,8 @@ int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter,
 
 	if (is_pci_p2pdma_page(bio->bi_io_vec->bv_page))
 		bio->bi_opf |= REQ_NOMERGE;
-	return bio_iov_iter_align_down(bio, iter, len_align_mask);
+	return bio_iov_iter_align_down(bio, iter,
+			&bio->bi_io_vec[bio->bi_vcnt - 1], len_align_mask);
 }
 
 static struct folio *folio_alloc_greedy(gfp_t gfp, size_t *size,
@@ -1360,7 +1360,8 @@ static int bio_iov_iter_bounce_write(struct bio *bio, struct iov_iter *iter,
 
 	if (!bio->bi_iter.bi_size)
 		return -ENOMEM;
-	return bio_iov_iter_align_down(bio, iter, minsize - 1);
+	return bio_iov_iter_align_down(bio, iter,
+			&bio->bi_io_vec[bio->bi_vcnt - 1], minsize - 1);
 }
 
 static int bio_iov_iter_bounce_read(struct bio *bio, struct iov_iter *iter,
@@ -1368,21 +1369,18 @@ static int bio_iov_iter_bounce_read(struct bio *bio, struct iov_iter *iter,
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
@@ -1398,7 +1396,20 @@ static int bio_iov_iter_bounce_read(struct bio *bio, struct iov_iter *iter,
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

