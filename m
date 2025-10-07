Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7D62D592F
	for <linux-block@vger.kernel.org>; Tue,  7 Oct 2025 09:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759828013; cv=none; b=H7Yo2w/BGqNlsa926qrogBj/qU1Ez0byAEQXe/9K/jNPWaH4wLZ2+vn8LYM/ZlhJO9llfqCHLEJXIqIHxukY6D+7KUtaDxPgHGQdxULn5wf6JB9IVPYK35mfs+Vo/4J43FM53h4KstrhRKVuHLA+LzE7rVS9+SxsU+LoDFxYQvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759828013; c=relaxed/simple;
	bh=97Hvpcpfa0n6b8Ca/h6UrWXy+7i9F3W27tG71wlKxP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k/4O6vFpFMtFbo0LwCWnaHyO7gCtlbgI5caXZOZZ3TfxdRxP+M/lzSgejzokaeQsWBWYlut0ZLizk3DvJkxm2XoAlRHahvcsKoZQxaxxuifJHr0zdmeqcBUr4c22sj6FTFwpGRfbfufxvbWmF1WWhRRShMP5XCz7jp5iyVroKko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OEocUrIY; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OEocUrIY"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=26nPrP1FFklf/gVaVYTngOSttllDD0HI5uw3dtH2Mo0=; b=OEocUrIYqCZ/5zZUr7PdtYGlFM
	OPhPmdWtnHMCGymPTt6FKXLKXrmpqUY5FCxiZBwFoceuHmk6tb0JE9Ewvl1RwB9EXRlyeblqi6CDL
	Bq7g12RDyPq2EU25qw7DDw6X6WbQGtIkp0ruknbLpcEldn0tFd0yvVQ4JCTrNbfrd9DgRVq5OVRrS
	O/aP1ItHQJmDZzGyMGutzqn6C3r8IVCjlz8OKEXW9jLievAP8s/RHxc1n9RjoWPlBo7k9KsHtZM3+
	zS21jvX3H20LmN8Uu7R8MQKDiJXeF2BeXiW5Kryqq2pcxyMCFwKXNCpiqtU8Xt29PuNvqZpGH4ZUi
	S9oru3sA==;
Received: from [2001:4bb8:2c1:22e6:ca8d:97b7:39cd:b2e9] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v63el-00000001fWH-0neI;
	Tue, 07 Oct 2025 09:06:51 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Qu Wenruo <quwenruo.btrfs@gmx.com>,
	Keith Busch <kbusch@kernel.org>,
	linux-block@vger.kernel.org
Subject: [PATCH 1/4] block: remove bio_iov_iter_get_pages
Date: Tue,  7 Oct 2025 11:06:25 +0200
Message-ID: <20251007090642.3251548-2-hch@lst.de>
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

Switch the only caller to bio_iov_iter_get_pages, and explain why it does
not have any alignment requirements.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-map.c     | 6 +++++-
 include/linux/bio.h | 5 -----
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/block/blk-map.c b/block/blk-map.c
index 165f2234f00f..6cce652c7fa6 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -283,7 +283,11 @@ static int bio_map_user_iov(struct request *rq, struct iov_iter *iter,
 	bio = blk_rq_map_bio_alloc(rq, nr_vecs, gfp_mask);
 	if (!bio)
 		return -ENOMEM;
-	ret = bio_iov_iter_get_pages(bio, iter);
+	/*
+	 * No alignment requirements on our part to support arbitrary
+	 * passthrough commands.
+	 */
+	ret = bio_iov_iter_get_pages_aligned(bio, iter, 0);
 	if (ret)
 		goto out_put;
 	ret = blk_rq_append_bio(rq, bio);
diff --git a/include/linux/bio.h b/include/linux/bio.h
index a64a30131031..b01dae9506de 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -449,11 +449,6 @@ int bdev_rw_virt(struct block_device *bdev, sector_t sector, void *data,
 int bio_iov_iter_get_pages_aligned(struct bio *bio, struct iov_iter *iter,
 		unsigned len_align_mask);
 
-static inline int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
-{
-	return bio_iov_iter_get_pages_aligned(bio, iter, 0);
-}
-
 void bio_iov_bvec_set(struct bio *bio, const struct iov_iter *iter);
 void __bio_release_pages(struct bio *bio, bool mark_dirty);
 extern void bio_set_pages_dirty(struct bio *bio);
-- 
2.47.3

