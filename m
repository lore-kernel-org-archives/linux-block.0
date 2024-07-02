Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE231BBBC8
	for <linux-block@vger.kernel.org>; Tue,  2 Jul 2024 15:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719933067; cv=none; b=ulyrxAL8YGhqYqtZWw/+UXvjllXxw/d5/C3YghkA7aVruajfgP97hiltVRZQh/3pntUjqhaJHl9xev6OOB7ayUgvcU1uqUEX6cFLttMMf/Y9hPZe+znIzkv9Py7uD6cUvHqTZb+3Jtd7/DWE5FX7yRjzlTCAAtOcI2Fxfw8l0C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719933067; c=relaxed/simple;
	bh=6qzbI9W0dIjuMs0tR6+1cR/DQHZG+GO9fhr825YOT+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j1RciIopJGXiE1ZOCUOEthsdtDPxmJTSPIJjqvg0w/mfP6bQ/4xozx7eD7iEJ4PcsxsMNVEGSsY0LmsRIs5eWCT8dB/DLhwK1Wro7YHrI2/FdR3FhEXSmlGpkP5yUYi9R55D7UFNCvsVQrHD0LwkabvlFqyKv7fbs2OzsGSs3C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=2y3NEA2K; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2y3NEA2K"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=qnVQ0Zsyk5yLVE9nCi8pUTdqtQJmDy7FRD4pSkUnbOQ=; b=2y3NEA2KrF66gmYcsX8VktbPFu
	57x5XDmmfewaL86pRo/QgA1ls8ctiMAXpumLkl/OUK5cKjoq4dVcMJTWySqBdtuFFbTOWgK4oLSCR
	sGFHssxUixGf0v6A408eBsgN3gy8VrviENztG9K2FPJMCjsviImL5rCFr02rgckJ/cegcpaBPH1I5
	hPvKSqkysGxrwORhXYb/AQk1oDZiMsERYPY1QGJm9VFO47vm6qSL1IiWJUjMfNsMUOCt0d+nhf9Tp
	VrHhacYf+PDANxMzkr1HTzx3KJpkF/vB/9Nl/KXf516BdyuZEbCoEiLOY+h2EyY0LOWAi+jk4zQM2
	N0f0RsKw==;
Received: from 2a02-8389-2341-5b80-4c69-cf21-4832-bbca.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:4c69:cf21:4832:bbca] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOf9s-000000079VF-3378;
	Tue, 02 Jul 2024 15:11:05 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	linux-block@vger.kernel.org
Subject: [PATCH 6/6] block: don't free the integrity payload in bio_integrity_unmap_free_user
Date: Tue,  2 Jul 2024 17:10:24 +0200
Message-ID: <20240702151047.1746127-7-hch@lst.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240702151047.1746127-1-hch@lst.de>
References: <20240702151047.1746127-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Now that the integrity payload is always freed in bio_uninit, don't
bother freeing it a little earlier in bio_integrity_unmap_free_user.
With that the separate bio_integrity_unmap_free_user can go away by
just passing the bio to bio_integrity_unmap_user.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bio-integrity.c         | 31 +++++++++++--------------------
 block/blk-map.c               |  2 +-
 include/linux/bio-integrity.h |  4 ++--
 3 files changed, 14 insertions(+), 23 deletions(-)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index 4aa836d603fb23..4b5c604585561e 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -131,34 +131,25 @@ static void bio_integrity_uncopy_user(struct bio_integrity_payload *bip)
 	bio_integrity_unpin_bvec(copy, nr_vecs, true);
 }
 
-static void bio_integrity_unmap_user(struct bio_integrity_payload *bip)
+/**
+ * bio_integrity_unmap_user - Unmap user integrity payload
+ * @bio:	bio containing bip to be unmapped
+ *
+ * Unmap the user mapped integrity portion of a bio.
+ */
+void bio_integrity_unmap_user(struct bio *bio)
 {
-	bool dirty = bio_data_dir(bip->bip_bio) == READ;
+	struct bio_integrity_payload *bip = bio_integrity(bio);
 
 	if (bip->bip_flags & BIP_COPY_USER) {
-		if (dirty)
+		if (bio_data_dir(bio) == READ)
 			bio_integrity_uncopy_user(bip);
 		kfree(bvec_virt(bip->bip_vec));
 		return;
 	}
 
-	bio_integrity_unpin_bvec(bip->bip_vec, bip->bip_max_vcnt, dirty);
-}
-
-/**
- * bio_integrity_unmap_free_user - Unmap and free bio user integrity payload
- * @bio:	bio containing bip to be unmapped and freed
- *
- * Description: Used to unmap and free the user mapped integrity portion of a
- * bio. Submitter attaching the user integrity buffer is responsible for
- * unmapping and freeing it during completion.
- */
-void bio_integrity_unmap_free_user(struct bio *bio)
-{
-	struct bio_integrity_payload *bip = bio_integrity(bio);
-
-	bio_integrity_unmap_user(bip);
-	bio_integrity_free(bio);
+	bio_integrity_unpin_bvec(bip->bip_vec, bip->bip_max_vcnt,
+			bio_data_dir(bio) == READ);
 }
 
 /**
diff --git a/block/blk-map.c b/block/blk-map.c
index df5f82d114720f..0e1167b239342f 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -758,7 +758,7 @@ int blk_rq_unmap_user(struct bio *bio)
 		}
 
 		if (bio_integrity(bio))
-			bio_integrity_unmap_free_user(bio);
+			bio_integrity_unmap_user(bio);
 
 		next_bio = bio;
 		bio = bio->bi_next;
diff --git a/include/linux/bio-integrity.h b/include/linux/bio-integrity.h
index 3823d9be0d0790..dd831c269e9948 100644
--- a/include/linux/bio-integrity.h
+++ b/include/linux/bio-integrity.h
@@ -73,7 +73,7 @@ struct bio_integrity_payload *bio_integrity_alloc(struct bio *bio, gfp_t gfp,
 int bio_integrity_add_page(struct bio *bio, struct page *page, unsigned int len,
 		unsigned int offset);
 int bio_integrity_map_user(struct bio *bio, void __user *ubuf, ssize_t len, u32 seed);
-void bio_integrity_unmap_free_user(struct bio *bio);
+void bio_integrity_unmap_user(struct bio *bio);
 bool bio_integrity_prep(struct bio *bio);
 void bio_integrity_advance(struct bio *bio, unsigned int bytes_done);
 void bio_integrity_trim(struct bio *bio);
@@ -104,7 +104,7 @@ static inline int bio_integrity_map_user(struct bio *bio, void __user *ubuf,
 	return -EINVAL;
 }
 
-static inline void bio_integrity_unmap_free_user(struct bio *bio)
+static inline void bio_integrity_unmap_user(struct bio *bio)
 {
 }
 
-- 
2.43.0

