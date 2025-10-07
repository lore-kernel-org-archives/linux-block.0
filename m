Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627E51E633C
	for <linux-block@vger.kernel.org>; Tue,  7 Oct 2025 09:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759828016; cv=none; b=IbPuMPhPaz7R8J+wlnU8wpfAlhHzS0gs53DvKMNz77Uctpo8xxNbhqWj+X+Oc8pyWvjgkfgw1Fus2PuyzCCv3M0WESC8m62Jis23xqYAYONCEThdC3Y2+8bXZopFWxJMUWz9u/Nqa6RTE72CBw+IzJVr9iWjSv979NCB4mixiTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759828016; c=relaxed/simple;
	bh=Qi893i6MoA5mGApCKFwEOl2H5N4sX0aI5oLS96F6hxM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rsgFLroDXAEfi3Wk5WxeI1VGmyd5KcjYFCD3Vqyky3sQ6/JiJsNAqgJf55ZndsKGoLBjRUhnuiD3D8G4l8iJA/Ce3yPRMyupy8mmoBp3jHBfiqcYRz3zGvg95Mbd4T1N4xSvng8V113IZHx3sgTqlFya3TGdN1g4U4zWmLfiJKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=azdCAB2i; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="azdCAB2i"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=HG55pw8K6TjoKpPrjCZaDt6+eFdKFOZhstESFj15cXA=; b=azdCAB2iM8hacemidwjsQl2mxG
	ZmLS0CojgwrnvfppSmtuNv0Wmzx7LergA0oifRj6+tEz1842aTFe349q/20wmcdg20vPqm/HejQGQ
	mk9Tt82QBbz1bjiblLbabBjTpd46gJ8UVssIVo1LVLoXYJpQr9CgdqELnFXL9FisWNTJFCbYCeHYE
	k8vSvFv77lTNGQZ//oWFK6jgo5EG8ztU4lrnh2QmJEv+k74Z6RxbNTX9JCwY+57nSHUaMCADAdK6p
	JFm4Y9ZMuopd7QhmVrD1mVh93FGECB4Hna8IJ9DwwxEEf0g6C0+s7APGSFWE08gkdNO1Y5eNsaShL
	H8ZlGtEg==;
Received: from [2001:4bb8:2c1:22e6:ca8d:97b7:39cd:b2e9] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v63eo-00000001fWU-23FG;
	Tue, 07 Oct 2025 09:06:54 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Qu Wenruo <quwenruo.btrfs@gmx.com>,
	Keith Busch <kbusch@kernel.org>,
	linux-block@vger.kernel.org
Subject: [PATCH 2/4] block: rename bio_iov_iter_get_pages_aligned to bio_iov_iter_get_pages
Date: Tue,  7 Oct 2025 11:06:26 +0200
Message-ID: <20251007090642.3251548-3-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251007090642.3251548-1-hch@lst.de>
References: <20251007090642.3251548-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Now that the bio_iov_iter_get_pages is free again, use it instead of
the more complicated now.  Also drop the unused export.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bio.c            | 5 ++---
 block/blk-map.c        | 2 +-
 include/linux/bio.h    | 2 +-
 include/linux/blkdev.h | 2 +-
 4 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 3a1a848940dd..b3a79285c278 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1316,7 +1316,7 @@ static int bio_iov_iter_align_down(struct bio *bio, struct iov_iter *iter,
 }
 
 /**
- * bio_iov_iter_get_pages_aligned - add user or kernel pages to a bio
+ * bio_iov_iter_get_pages - add user or kernel pages to a bio
  * @bio: bio to add pages to
  * @iter: iov iterator describing the region to be added
  * @len_align_mask: the mask to align the total size to, 0 for any length
@@ -1336,7 +1336,7 @@ static int bio_iov_iter_align_down(struct bio *bio, struct iov_iter *iter,
  * MM encounters an error pinning the requested pages, it stops. Error
  * is returned only if 0 pages could be pinned.
  */
-int bio_iov_iter_get_pages_aligned(struct bio *bio, struct iov_iter *iter,
+int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter,
 			   unsigned len_align_mask)
 {
 	int ret = 0;
@@ -1360,7 +1360,6 @@ int bio_iov_iter_get_pages_aligned(struct bio *bio, struct iov_iter *iter,
 		return bio_iov_iter_align_down(bio, iter, len_align_mask);
 	return ret;
 }
-EXPORT_SYMBOL_GPL(bio_iov_iter_get_pages_aligned);
 
 static void submit_bio_wait_endio(struct bio *bio)
 {
diff --git a/block/blk-map.c b/block/blk-map.c
index 6cce652c7fa6..60faf036fb6e 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -287,7 +287,7 @@ static int bio_map_user_iov(struct request *rq, struct iov_iter *iter,
 	 * No alignment requirements on our part to support arbitrary
 	 * passthrough commands.
 	 */
-	ret = bio_iov_iter_get_pages_aligned(bio, iter, 0);
+	ret = bio_iov_iter_get_pages(bio, iter, 0);
 	if (ret)
 		goto out_put;
 	ret = blk_rq_append_bio(rq, bio);
diff --git a/include/linux/bio.h b/include/linux/bio.h
index b01dae9506de..16c1c85613b7 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -446,7 +446,7 @@ int submit_bio_wait(struct bio *bio);
 int bdev_rw_virt(struct block_device *bdev, sector_t sector, void *data,
 		size_t len, enum req_op op);
 
-int bio_iov_iter_get_pages_aligned(struct bio *bio, struct iov_iter *iter,
+int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter,
 		unsigned len_align_mask);
 
 void bio_iov_bvec_set(struct bio *bio, const struct iov_iter *iter);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index dad5cb5b3812..134f974ac92d 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1876,7 +1876,7 @@ static inline int bio_split_rw_at(struct bio *bio,
 static inline int bio_iov_iter_get_bdev_pages(struct bio *bio,
 		struct iov_iter *iter, struct block_device *bdev)
 {
-	return bio_iov_iter_get_pages_aligned(bio, iter,
+	return bio_iov_iter_get_pages(bio, iter,
 					bdev_logical_block_size(bdev) - 1);
 }
 
-- 
2.47.3

