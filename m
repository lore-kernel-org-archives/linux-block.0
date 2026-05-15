Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062B03DA7EE
	for <linux-block@vger.kernel.org>; Fri, 15 May 2026 04:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778820959; cv=none; b=I/F72ck9ch1aadnatDuY4ZOS5V9KsloabIBvLN/a6uoK+TSIrkAF+Z7GwPOx7NLAz2azbPsMmvja2EJu44nSAIjGFo1RYsOIf1lqbQPyrkNvONXQ60Bxe04VL+zs0qOcREuSKmp78lWHwF/1snK7/iq5mbHc1E/Y1gFw4GYm9yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778820959; c=relaxed/simple;
	bh=2c1SDtuyzE2Hel/CWj6WB218/uaL99bG1R2DIFSQgz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NfQbJqmyWOnthq0u3uMEzdmMO137kaDo83EMpu/dNYfD2VFqUi06BSslYWCWm0rvh55/G9NKutUqxwWAYznuR5svCH11UsXSP28C3i9GzqIOvzXK2twMiHA+jGeMDAYoyylCy+txwyH3trO2qg/LS4zRE0uxNNUeVtbKr9UX+Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hpBc8fJR; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hpBc8fJR"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=6ycLMw5SujEXNg6AVnJf6zJHrjcy2J3XeLWvjUguyNQ=; b=hpBc8fJR7QCQgLK1TnV1KjJgkm
	gZeD6wq9a2/Em+GH5pzg6b1ZlKXirUTqVIpU+ul3pcK3N3bRlMoHyqK703u8F2nHDCHffUhs07zMO
	t/zceoSACbsW8ERWBidwwg1gZb+uJaOeTyOZUVSoXZoYv6fU+DQMuPrEoa5cFNdzObMXGK9p7BTsW
	358vBJfDqu9M7taVDJKPEpgRWx+XoYMvWYOdIbIFFvj2MnQcSifJAfzUd6Z8jw2Nn7vhaMbxKY2oW
	TC11kgaJnZNEez2i6pEL3hlt49kqukvs0/jXIwrt0OeYWkJUqWTjR9bXe4jGWiQsf2a07ZK/jTVRa
	Un6gS/Sw==;
Received: from 2a02-8389-2341-5b80-decc-1a96-daaa-a2cc.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:decc:1a96:daaa:a2cc] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNkab-00000007LvR-13dr;
	Fri, 15 May 2026 04:55:57 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Subject: [PATCH 2/5] block: remove bio_copy_data_iter
Date: Fri, 15 May 2026 06:55:31 +0200
Message-ID: <20260515045547.3790129-3-hch@lst.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260515045547.3790129-1-hch@lst.de>
References: <20260515045547.3790129-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Only used by bio_copy_data, so implement that directly.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bio.c         | 36 +++++++++++++++---------------------
 include/linux/bio.h |  2 --
 2 files changed, 15 insertions(+), 23 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index b990c453d72f..57d5a87b3e2f 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1575,26 +1575,6 @@ void __bio_advance(struct bio *bio, unsigned bytes)
 }
 EXPORT_SYMBOL(__bio_advance);
 
-void bio_copy_data_iter(struct bio *dst, struct bvec_iter *dst_iter,
-			struct bio *src, struct bvec_iter *src_iter)
-{
-	while (src_iter->bi_size && dst_iter->bi_size) {
-		struct bio_vec src_bv = bio_iter_iovec(src, *src_iter);
-		struct bio_vec dst_bv = bio_iter_iovec(dst, *dst_iter);
-		unsigned int bytes = min(src_bv.bv_len, dst_bv.bv_len);
-		void *src_buf = bvec_kmap_local(&src_bv);
-		void *dst_buf = bvec_kmap_local(&dst_bv);
-
-		memcpy(dst_buf, src_buf, bytes);
-
-		kunmap_local(dst_buf);
-		kunmap_local(src_buf);
-
-		bio_advance_iter_single(src, src_iter, bytes);
-		bio_advance_iter_single(dst, dst_iter, bytes);
-	}
-}
-EXPORT_SYMBOL(bio_copy_data_iter);
 
 /**
  * bio_copy_data - copy contents of data buffers from one bio to another
@@ -1609,7 +1589,21 @@ void bio_copy_data(struct bio *dst, struct bio *src)
 	struct bvec_iter src_iter = src->bi_iter;
 	struct bvec_iter dst_iter = dst->bi_iter;
 
-	bio_copy_data_iter(dst, &dst_iter, src, &src_iter);
+	while (src_iter.bi_size && dst_iter.bi_size) {
+		struct bio_vec src_bv = bio_iter_iovec(src, src_iter);
+		struct bio_vec dst_bv = bio_iter_iovec(dst, dst_iter);
+		unsigned int bytes = min(src_bv.bv_len, dst_bv.bv_len);
+		void *src_buf = bvec_kmap_local(&src_bv);
+		void *dst_buf = bvec_kmap_local(&dst_bv);
+
+		memcpy(dst_buf, src_buf, bytes);
+
+		kunmap_local(dst_buf);
+		kunmap_local(src_buf);
+
+		bio_advance_iter_single(src, &src_iter, bytes);
+		bio_advance_iter_single(dst, &dst_iter, bytes);
+	}
 }
 EXPORT_SYMBOL(bio_copy_data);
 
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 84643fc0fb08..85463981d0f5 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -478,8 +478,6 @@ extern void bio_check_pages_dirty(struct bio *bio);
 int bio_iov_iter_bounce(struct bio *bio, struct iov_iter *iter, size_t maxlen);
 void bio_iov_iter_unbounce(struct bio *bio, bool is_error, bool mark_dirty);
 
-extern void bio_copy_data_iter(struct bio *dst, struct bvec_iter *dst_iter,
-			       struct bio *src, struct bvec_iter *src_iter);
 extern void bio_copy_data(struct bio *dst, struct bio *src);
 extern void bio_free_pages(struct bio *bio);
 void zero_fill_bio(struct bio *bio);
-- 
2.53.0

