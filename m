Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E204243ABC
	for <linux-block@vger.kernel.org>; Mon,  6 May 2024 04:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714969240; cv=none; b=FB4FkjBj+W+zFsdeCaoP3VxTURDjfPPCsVMXBWp/YOfRRiZDnGFooUWolbjpzSXOlBVSlFbQB8Ev5vVJ2h3+w7S9ewU0KaWI54Da1Ht5M7bCLzyoRjE927KFxA1LEquzG2bUTYwAYA2xsMSFUTapTXwbJfV6ut8fqqB9TGCUR70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714969240; c=relaxed/simple;
	bh=+XOmUvqvbkxshVMwbWkiNmY89oiwHlp0WmLP0Ol5ZMg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qboBCS7eLiuwxvSqHoUS0xlL25mNyEcg6BrNZ2X1CYViR4Zy65bLf9U01VJPkjqIF1JTXt2q7IcymPoyWL/twttA0m0Bh8NJ9wXlNb6/fjXaxsyVIWGLduVl0EppeQXDjdIimR7Lq+aGUJA9qXvqIcHkGrRIy29W0IewVkYtSbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TCZyNO/e; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TCZyNO/e"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=r7j69I3xEuicF0tvAgL59fBhWIatWNlkiAB+VJk1FPw=; b=TCZyNO/e7Ovxw7e50+soXa8oa9
	JueuDlGABmRkGRT6tM5/K8v22KDBpvu2hXqC/Kb7JaORYff6/rfF5k1x9c42V5esomdp7rkDKpVEc
	Xd8TIG6dbSHmoRjdbCs9FS005/MPUdUKeK/Cw3PX65hZRqlOtoiaETLw0bD6TLyGAo/g0VlE2TPaQ
	3dv4uHG1Ufai6KY3lH0MlpL1BlakdSH4kKI9/Vm+GOH7rftarneQq+5tBSDY7rWjFe+8AHFq0+eRC
	YDjIRdsyF4MuRKzXD9td7xwGviFs/plprWVaY5o3YI/gYMvvIgI2EOmD7zGMl54eqU4dp+uQ7TvLy
	42BN4wog==;
Received: from [2001:4bb8:188:7ba8:c70:4a89:bc61:3] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s3pq8-000000060L6-3uOM;
	Mon, 06 May 2024 04:20:37 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>,
	Conrad Meyer <conradmeyer@meta.com>,
	linux-block@vger.kernel.org
Subject: [PATCH 3/6] block: add a bio_chain_and_submit helper
Date: Mon,  6 May 2024 06:20:24 +0200
Message-Id: <20240506042027.2289826-4-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240506042027.2289826-1-hch@lst.de>
References: <20240506042027.2289826-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

This is basically blk_next_bio just with the bio allocation moved
to the caller to allow for more flexible bio handling in the caller.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bio.c         | 27 +++++++++++++++++++--------
 include/linux/bio.h |  1 +
 2 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 38baedb39c6f2e..d82ef4fd545cb2 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -345,18 +345,29 @@ void bio_chain(struct bio *bio, struct bio *parent)
 }
 EXPORT_SYMBOL(bio_chain);
 
-struct bio *blk_next_bio(struct bio *bio, struct block_device *bdev,
-		unsigned int nr_pages, blk_opf_t opf, gfp_t gfp)
+/**
+ * bio_chain_and_submit - submit a bio after chaining it to another one
+ * @prev: bio to chain and submit
+ * @new: bio to chain to
+ *
+ * If @prev is non-NULL, chain it to @new and submit it.
+ *
+ * Return: @new.
+ */
+struct bio *bio_chain_and_submit(struct bio *prev, struct bio *new)
 {
-	struct bio *new = bio_alloc(bdev, nr_pages, opf, gfp);
-
-	if (bio) {
-		bio_chain(bio, new);
-		submit_bio(bio);
+	if (prev) {
+		bio_chain(prev, new);
+		submit_bio(prev);
 	}
-
 	return new;
 }
+
+struct bio *blk_next_bio(struct bio *bio, struct block_device *bdev,
+		unsigned int nr_pages, blk_opf_t opf, gfp_t gfp)
+{
+	return bio_chain_and_submit(bio, bio_alloc(bdev, nr_pages, opf, gfp));
+}
 EXPORT_SYMBOL_GPL(blk_next_bio);
 
 static void bio_alloc_rescue(struct work_struct *work)
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 9b8a369f44bc6b..283a0dcbd1de61 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -831,5 +831,6 @@ static inline void bio_clear_polled(struct bio *bio)
 
 struct bio *blk_next_bio(struct bio *bio, struct block_device *bdev,
 		unsigned int nr_pages, blk_opf_t opf, gfp_t gfp);
+struct bio *bio_chain_and_submit(struct bio *prev, struct bio *new);
 
 #endif /* __LINUX_BIO_H */
-- 
2.39.2

