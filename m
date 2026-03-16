Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43DB2F872
	for <linux-block@vger.kernel.org>; Mon, 16 Mar 2026 16:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773677520; cv=none; b=UXGtaL0+IdoL0DSAk6l2U6BQPiYjkUWlZwEgRtrEoQIoPRrkppFo4WLN56XGvTXx5z/E0UoPEfF9RaHTvVPppnSvQ3tzvXnmW6mrrlXqBs4kyMX1J4qNMNGuCJJYHNhTmCQyT+yRpdlSJqIxT6QeOehbXsH54wiRUK7DCLvB3Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773677520; c=relaxed/simple;
	bh=S2uQzdenpK9mQAkhGPMAwPoLFfo27X2zpiuZSysx5do=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uQDFNfj+MEjmxRoDHrzYpwEl7SueREqadodVLSN6cHrnsDfUUzyHVUPYebZObIcN8LjQXJMHPCLsZZz54jIPHou2O1J8o2W+LVo+u7LGI3r3eJIjoVLRtWRe5/WufnIAq5lxSPXqpB8xltHfKNbIdpbSbUE8JguxyDr1zuUhK2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hUcKR4wZ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hUcKR4wZ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=D93tlq0kH7cPWSybJnsMCurzrSqbTsjqRrL64z5a2aA=; b=hUcKR4wZItDSJgzeJ8+CIfclv3
	NzOpc5DZuBjn3A0nHOF5D/5TNeg6zD/MBMjLvUBvZHsyliyW3CeCCXpjugdRX1bV63dvw/89VkEVj
	AM4QtWf8GZrS0pPRiRtfKhFedKYXzTkjG3GAsY3x82rgNkIM564SklxXizCdE7AMGeqWpmApIw34Q
	R8MfZK3j+78fxETx3eTfGmcqFL815qp+1nRT7iFkjjxgk1kpo/kx0d4rpYOxeaMMI6s6EmNP17Ns0
	OxzlR0pVmr4l24R7yfmTSP+JucqefDEhkF7gxzi6aX7AsbfxXitkkvFXsFen9hbI3OI1ItyoTo/Oq
	QYl3INcw==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2AXu-00000004Q5v-3dIh;
	Mon, 16 Mar 2026 16:11:59 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Subject: [PATCH 1/3] block: mark bvec_{alloc,free} static
Date: Mon, 16 Mar 2026 17:11:29 +0100
Message-ID: <20260316161144.1607877-2-hch@lst.de>
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

Only used in bio.c these days.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bio.c | 7 +++++--
 block/blk.h | 5 -----
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index bf1f3670e85a..6131ccb7284a 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -34,6 +34,8 @@ struct bio_alloc_cache {
 	unsigned int		nr_irq;
 };
 
+#define BIO_INLINE_VECS 4
+
 static struct biovec_slab {
 	int nr_vecs;
 	char *name;
@@ -159,7 +161,8 @@ static void bio_put_slab(struct bio_set *bs)
 	mutex_unlock(&bio_slab_lock);
 }
 
-void bvec_free(mempool_t *pool, struct bio_vec *bv, unsigned short nr_vecs)
+static void bvec_free(struct mempool *pool, struct bio_vec *bv,
+		      unsigned short nr_vecs)
 {
 	BUG_ON(nr_vecs > BIO_MAX_VECS);
 
@@ -179,7 +182,7 @@ static inline gfp_t bvec_alloc_gfp(gfp_t gfp)
 		__GFP_NOMEMALLOC | __GFP_NORETRY | __GFP_NOWARN;
 }
 
-struct bio_vec *bvec_alloc(mempool_t *pool, unsigned short *nr_vecs,
+static struct bio_vec *bvec_alloc(struct mempool *pool, unsigned short *nr_vecs,
 		gfp_t gfp_mask)
 {
 	struct biovec_slab *bvs = biovec_slab(*nr_vecs);
diff --git a/block/blk.h b/block/blk.h
index c5b2115b9ea4..103cb1d0b9cb 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -108,11 +108,6 @@ static inline void blk_wait_io(struct completion *done)
 struct block_device *blkdev_get_no_open(dev_t dev, bool autoload);
 void blkdev_put_no_open(struct block_device *bdev);
 
-#define BIO_INLINE_VECS 4
-struct bio_vec *bvec_alloc(mempool_t *pool, unsigned short *nr_vecs,
-		gfp_t gfp_mask);
-void bvec_free(mempool_t *pool, struct bio_vec *bv, unsigned short nr_vecs);
-
 bool bvec_try_merge_hw_page(struct request_queue *q, struct bio_vec *bv,
 		struct page *page, unsigned len, unsigned offset);
 
-- 
2.47.3

