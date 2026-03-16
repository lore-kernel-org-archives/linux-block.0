Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0612F872
	for <linux-block@vger.kernel.org>; Mon, 16 Mar 2026 16:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773677527; cv=none; b=J+Qc9LgmP3bUSrvkJIv0iZCHzmLBw8CtugseAFnAgDLcCN1HjgRqADB4DwL958m2g++tqSWQOEcAtBEN8HueRhu8Qy/G57U4S9rY9ZCGkGMpG5qAm9Of2Dqu2VLM4ptfuk4xvzc+t/kVFXmkgjtj9y1gtrV1hnurN8abCSF+8m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773677527; c=relaxed/simple;
	bh=MeaF6HGFUnZQ1EiCNgCD9Rwxyeu2aYcwbBKhlOoS1tU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nG4mlmFiFAFfYYR6UzPB/036EXgE4R5rZLWuYccQTPl96A7kuRheg/x6l4UOTc6Iap/R35tl2a9Czin+PVNdjjfE8pvX+orSPVCIQM/3NP78qieuMCguESaOna4Dd5Yn1Yu6VT0u2439l5McPWWsJVD9V3dHbOkbjZF5X+Dtumc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=o/eP7XyP; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="o/eP7XyP"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=vLDw6ygBkP3FQZf9lOMM42neTZZnsqRUMyMB9R0Emzs=; b=o/eP7XyP57kRb+9Ou2TgiuUAMO
	tuY6M1kKGGPetsXN3obKCa5RUeAG+X/Vr9DX1LquAnz6usZ2Bb87hGD7tQeqOWnm+L1d4r9vbfRYZ
	e1CqAZpdHt/9ifLkOxjr4nv008ByndebUJ/WrXJ7bHV+kq0JNOjiLh0uNickFs08+MC5PYoksqT8p
	Iq3cnDCLlwlzZ82rLD0UmZ7p9XJKq9RDkHRQUfrlHI1be7aEn3EOBswf5co/ArZXbpMZBjGTWO7W7
	zwo5v6VKA/h0G37S9iP7B0/aYu1JdbCq3Ec353RnP/1S0OYK3HniAtPEFcLCFZKLFMT4VTW79/rQ8
	qSKT7UPA==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2AY1-00000004Q69-47dV;
	Mon, 16 Mar 2026 16:12:06 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Subject: [PATCH 3/3] block: remove bvec_free
Date: Mon, 16 Mar 2026 17:11:31 +0100
Message-ID: <20260316161144.1607877-4-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260316161144.1607877-1-hch@lst.de>
References: <20260316161144.1607877-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

bvec_free is only called by bio_free, so inline it there.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bio.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 5982bf069cef..b58bce6b5fea 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -161,17 +161,6 @@ static void bio_put_slab(struct bio_set *bs)
 	mutex_unlock(&bio_slab_lock);
 }
 
-static void bvec_free(struct mempool *pool, struct bio_vec *bv,
-		      unsigned short nr_vecs)
-{
-	BUG_ON(nr_vecs > BIO_MAX_VECS);
-
-	if (nr_vecs == BIO_MAX_VECS)
-		mempool_free(bv, pool);
-	else if (nr_vecs > BIO_INLINE_VECS)
-		kmem_cache_free(biovec_slab(nr_vecs)->slab, bv);
-}
-
 /*
  * Make the first allocation restricted and don't dump info on allocation
  * failures, since we'll fall back to the mempool in case of failure.
@@ -203,9 +192,14 @@ static void bio_free(struct bio *bio)
 	void *p = bio;
 
 	WARN_ON_ONCE(!bs);
+	WARN_ON_ONCE(bio->bi_max_vecs > BIO_MAX_VECS);
 
 	bio_uninit(bio);
-	bvec_free(&bs->bvec_pool, bio->bi_io_vec, bio->bi_max_vecs);
+	if (bio->bi_max_vecs == BIO_MAX_VECS)
+		mempool_free(bio->bi_io_vec, &bs->bvec_pool);
+	else if (bio->bi_max_vecs > BIO_INLINE_VECS)
+		kmem_cache_free(biovec_slab(bio->bi_max_vecs)->slab,
+				bio->bi_io_vec);
 	mempool_free(p - bs->front_pad, &bs->bio_pool);
 }
 
@@ -561,7 +555,7 @@ struct bio *bio_alloc_bioset(struct block_device *bdev, unsigned short nr_vecs,
 
 		/*
 		 * Upgrade nr_vecs to take full advantage of the allocation.
-		 * We also rely on this in bvec_free().
+		 * We also rely on this in bio_free().
 		 */
 		nr_vecs = bvs->nr_vecs;
 		bvecs = kmem_cache_alloc(bvs->slab, gfp);
-- 
2.47.3

