Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7783DA7D7
	for <linux-block@vger.kernel.org>; Fri, 15 May 2026 04:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778820957; cv=none; b=Io6MZSIbCHalq2aDD19HyPCGwxwpRSEfnTt8gOOkWI9gkiDMTNRKS43YMXswouNbgP3Hvh1htWT40m07h4gt5KorXIyh/5Z7tFiPzTeS8X0cWAf5NB/Sgnxq/9HG/Aqv81lwxhp+cdNtFgIdpc3d1HBPhV5051G0D1J/A2Ecs7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778820957; c=relaxed/simple;
	bh=2EZCAGYYUiOzQ2Wnyhgm0ulGDSwzj0IGGT50NZXcIVk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qMCaEP/vdeOYZRxRIFdkbLKa+CAo9wuQLndRQ7MPv0XvVD4T6+27UU7iA87AYOVLYhz75YycYx0Ensluv+mhGndD0w1hwBDYWePuD6wcYpf1SVWlj3g8yBDiXur9lu3Q0GwOP5c6A36j0n4Nu4MEobC3xY8V2umQyuSC7FB8Eac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=RQkrmj2c; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RQkrmj2c"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=iswZr+HmR3G5Ez9fObwsczaTjxgDEBflyTgN0HqtCf0=; b=RQkrmj2c9+7640xGLwczzby06H
	eaFtGCkEvAHmikvQOWIBOUxVrzGpcVWgczYRTyFeZPXeWrkr5aCe91L3sKlyH0kOX/JmvjJmxwgBF
	YiGy8pjh0QvSorKln3vZvv50pzK2RvbaJui5YjnoykscRIRrdv9Ge7iI1IEUZesyrf3fN5wHpXP5D
	x1DfDHmMI7P27ecMX1lO2BRWMteugA4fkri5Piw0f8Foi3DWizFIPkCb7gykFaNcCq9rHtr5yBhRW
	umiDcnOJXMJoU/7UNZA+a4cZ2wZrKVHg5gyCRF9RS3DXKzZcnLNBEMgoHNUSohuDz1hacJpr/Q4cW
	yNIBum6Q==;
Received: from 2a02-8389-2341-5b80-decc-1a96-daaa-a2cc.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:decc:1a96:daaa:a2cc] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNkaY-00000007Lv2-2Rm1;
	Fri, 15 May 2026 04:55:54 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Subject: [PATCH 1/5] block: remove zero_fill_bio_iter
Date: Fri, 15 May 2026 06:55:30 +0200
Message-ID: <20260515045547.3790129-2-hch@lst.de>
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

Only used to implement zero_fill_bio, so directly implement that.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bio.c         | 6 +++---
 include/linux/bio.h | 7 +------
 2 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index b8972dba68a0..b990c453d72f 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -635,15 +635,15 @@ struct bio *bio_kmalloc(unsigned short nr_vecs, gfp_t gfp_mask)
 }
 EXPORT_SYMBOL(bio_kmalloc);
 
-void zero_fill_bio_iter(struct bio *bio, struct bvec_iter start)
+void zero_fill_bio(struct bio *bio)
 {
 	struct bio_vec bv;
 	struct bvec_iter iter;
 
-	__bio_for_each_segment(bv, bio, iter, start)
+	bio_for_each_segment(bv, bio, iter)
 		memzero_bvec(&bv);
 }
-EXPORT_SYMBOL(zero_fill_bio_iter);
+EXPORT_SYMBOL(zero_fill_bio);
 
 /**
  * bio_truncate - truncate the bio to small size of @new_size
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 97d747320b35..84643fc0fb08 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -482,13 +482,8 @@ extern void bio_copy_data_iter(struct bio *dst, struct bvec_iter *dst_iter,
 			       struct bio *src, struct bvec_iter *src_iter);
 extern void bio_copy_data(struct bio *dst, struct bio *src);
 extern void bio_free_pages(struct bio *bio);
+void zero_fill_bio(struct bio *bio);
 void guard_bio_eod(struct bio *bio);
-void zero_fill_bio_iter(struct bio *bio, struct bvec_iter iter);
-
-static inline void zero_fill_bio(struct bio *bio)
-{
-	zero_fill_bio_iter(bio, bio->bi_iter);
-}
 
 static inline void bio_release_pages(struct bio *bio, bool mark_dirty)
 {
-- 
2.53.0

