Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37ED426EDE
	for <linux-block@vger.kernel.org>; Wed, 27 May 2026 15:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779894416; cv=none; b=Gsmr/xDTiJFXf5hmHpReuRKLmQcV2qP1azL+4jVwnQ9PJMOvtioTM9hYXV5vF6iepqrP/RWHpg+LhSmADYIdDFFxk+X2UVRlDpi/825jKfsebDQp9I5kAXR/+hOr+0Q/+mBEP/2Wd0En3Yn6FeBTYd29cHzvoDppKNRwc5hGDzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779894416; c=relaxed/simple;
	bh=xu/eaUeHsmJh2gfJkHk4xhrw4GXPTDAdinYt2w0Avwk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E9bfCvP196EiobRVag+ydlDRj8N2VWs8my8cfbniueTaZiT4s6p6/6w0rLYTcNJ6FpWCsc3BhX32Wa7L3OMUlaSbN6xOw0xe/jOUFo72n1XzHYyn3dME4LhHNvLUFKU34VaUdMIn36d9YS2CqsSialM0wBsd5CZ5o5tRI8Z25zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DhJ831nA; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DhJ831nA"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=PJtqRTcrBMegvLYDm9YccHxY5s3iKn04PYfG8mA/J60=; b=DhJ831nAIgsKbYlJU+yuorXa94
	0Wmy67u5vvUPBAyiChX3xAGasGeDBeWg0XfxLo47gw+yBL6RVw4yFQ1EoJUKrtKsg/weOyphOFL+/
	z8StsjmgSTHBpwAttsO3WY7PuzQbHZVyBh1YU3/liwijboCjTjnBIubV0tttx5C6m6hg4YwK46FR7
	CmDZIrhnp/GthcnBsm5JWxzT1K7amoC+BK780f0Z1Rwk2oR5x9x2t5zXZmsCRKU7nDIestxJyezuL
	vPZH0lKw+2CxX4+GJFT/iWMOlzthTkLVW+rzHgJko3szASsH9cHotHlvQl20JoMdJlutRHCoHekGN
	n9Mu7LPw==;
Received: from 2a02-8389-2341-5b80-decc-1a96-daaa-a2cc.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:decc:1a96:daaa:a2cc] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSFqL-00000004N9d-0OOv;
	Wed, 27 May 2026 15:06:49 +0000
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org
Subject: [PATCH] block: mark biovec_init_pool static
Date: Wed, 27 May 2026 17:06:46 +0200
Message-ID: <20260527150646.2349405-1-hch@lst.de>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bio.c         | 2 +-
 include/linux/bio.h | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 2d880d1255fe..e9944dab0132 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1873,7 +1873,7 @@ EXPORT_SYMBOL_GPL(bio_trim);
  * create memory pools for biovec's in a bio_set.
  * use the global biovec slabs created for general use.
  */
-int biovec_init_pool(mempool_t *pool, int pool_entries)
+static int biovec_init_pool(mempool_t *pool, int pool_entries)
 {
 	struct biovec_slab *bp = bvec_slabs + ARRAY_SIZE(bvec_slabs) - 1;
 
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 7597ae4dc52b..e60d2f5bd3dc 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -347,7 +347,6 @@ enum {
 };
 extern int bioset_init(struct bio_set *, unsigned int, unsigned int, int flags);
 extern void bioset_exit(struct bio_set *);
-extern int biovec_init_pool(mempool_t *pool, int pool_entries);
 
 struct bio *bio_alloc_bioset(struct block_device *bdev, unsigned short nr_vecs,
 			     blk_opf_t opf, gfp_t gfp, struct bio_set *bs);
-- 
2.53.0

