Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4E33DEFE3
	for <linux-block@vger.kernel.org>; Mon, 13 Jul 2026 09:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783934991; cv=none; b=i1OPNXFyobtbsWZPSJygr9NNhHO3HR+DLP0UyI0vVqCxXsmrGIIXV6AXiB9NyG/1CVywEE0xEnefiBWz3TUpw8PIPjA0vUU45HPf7h8STqtrJzL+hiR4U3gv5i59L7mMIOIzFoSvSgyS5CVxXYTE57UqG7HZNy8Ap+YOUUdk5aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783934991; c=relaxed/simple;
	bh=BJguOKGjoeZZwOBvxZmICWIDlHSstWCN5H9UIN9Y77w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W8SOweVIyVHGfd2/c2FybIe3zESon1JWWMPIuwWuiLN5KhQxOeOWjKnE3Vy/WMaTv5fpU8RTvT1YkonMW8deRfTnyGTZzgUOYGqRZHDLlch33d+Ptw6An57RjR113TWP7XAFLn7la3a/HjaGGEkY+VtMrjxAIy98lxWMEqhIV6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2C22068BFE; Mon, 13 Jul 2026 11:29:46 +0200 (CEST)
Date: Mon, 13 Jul 2026 11:29:45 +0200
From: Christoph Hellwig <hch@lst.de>
To: Neptune <z1281552865@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	linux-block@vger.kernel.org, security@kernel.org
Subject: Re: [RESEND][SECURITY] block: double unpin in bounced direct reads
Message-ID: <20260713092945.GA8612@lst.de>
References: <CAKTh279tH68oS4gTQd9DFqNuegvAhwZ8ck2uViR+cbeJDW9jDA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKTh279tH68oS4gTQd9DFqNuegvAhwZ8ck2uViR+cbeJDW9jDA@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Does fix the issue for you?  

---
From dda17e13c91e917dd3e317dd740917849472994b Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Mon, 13 Jul 2026 10:42:34 +0200
Subject: block: fix aligning of bonced dio read bios

bio_iov_iter_align_down expects the "normal" biovec layout from vector 0,
while bio_iov_iter_bounce_read abuses vector 0 for a bounce buffer
allocation.  Pass an explicit bvec to bio_iov_iter_align_down to deal
with this case to avoid a double unpin.

Fixes: e7b8b3c5b2a6 ("block: align down bounces bios")
Reported-by: Neptune <z1281552865@gmail.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bio.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index f2a5f4d0a967..885b01b6915d 100644
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
 
@@ -1200,21 +1200,16 @@ static int bio_iov_iter_align_down(struct bio *bio, struct iov_iter *iter,
 
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
 		nbytes -= bv->bv_len;
-	} while (nbytes);
+		bio->bi_vcnt--;
+		bv--;
+	}
 
+	bv->bv_len -= nbytes;
 	if (!bio->bi_vcnt)
 		return -EFAULT;
 	return 0;
@@ -1276,7 +1271,8 @@ int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter,
 
 	if (is_pci_p2pdma_page(bio->bi_io_vec->bv_page))
 		bio->bi_opf |= REQ_NOMERGE;
-	return bio_iov_iter_align_down(bio, iter, len_align_mask);
+	return bio_iov_iter_align_down(bio, iter,
+			&bio->bi_io_vec[bio->bi_vcnt - 1], len_align_mask);
 }
 
 static struct folio *folio_alloc_greedy(gfp_t gfp, size_t *size,
@@ -1360,7 +1356,8 @@ static int bio_iov_iter_bounce_write(struct bio *bio, struct iov_iter *iter,
 
 	if (!bio->bi_iter.bi_size)
 		return -ENOMEM;
-	return bio_iov_iter_align_down(bio, iter, minsize - 1);
+	return bio_iov_iter_align_down(bio, iter,
+			&bio->bi_io_vec[bio->bi_vcnt - 1], minsize - 1);
 }
 
 static int bio_iov_iter_bounce_read(struct bio *bio, struct iov_iter *iter,
@@ -1398,7 +1395,10 @@ static int bio_iov_iter_bounce_read(struct bio *bio, struct iov_iter *iter,
 	bvec_set_folio(&bio->bi_io_vec[0], folio, bio->bi_iter.bi_size, 0);
 	if (iov_iter_extract_will_pin(iter))
 		bio_set_flag(bio, BIO_PAGE_PINNED);
-	return bio_iov_iter_align_down(bio, iter, minsize - 1);
+
+	/* The first vec stores the bounce buffer, so do not subtract 1 here. */
+	return bio_iov_iter_align_down(bio, iter,
+			&bio->bi_io_vec[bio->bi_vcnt], minsize - 1);
 }
 
 /**
-- 
2.53.0

