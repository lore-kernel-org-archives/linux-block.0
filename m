Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1563845BE
	for <linux-block@vger.kernel.org>; Thu, 28 May 2026 08:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779958002; cv=none; b=iYqqH8SaTpnLq1YwkJPPtvqkKTEk62vR2eJYJhx97OHawMtyuqUwiMgGHH/055ESex6Pyg+SN24oFDIOFgMTVqIqzW8w0sKfSTuI4vfL3gp5lX5dXSgOM/HAYg0mmi0V3lzOqMV44R8VPj+gAFTuIe73/9bTFLhsce9OIl7c01U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779958002; c=relaxed/simple;
	bh=41y0UhR8Bys9lBd9icc6iVX4MMdF7C4v1SzbRdc1z/s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J4+lJpMvfkrHG3smIvE9bjEGVrK7NMl2iJwqOpRHBjtUARwm5yTyRYE3B3XUkubkABuDM38bo5ElMb53m/HmYITUWbOb9bj8i2ePlZqtMx64uAurizZ3fbdyjVzCimTZ3Kq3LlR3HtR6XlZmJ1g23gBk1eKAcO0RWkWPf97Yotw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=1viKC6mJ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="1viKC6mJ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=8PnsYbPQZlh+QBbWpgXy/l+uU2RDYoWFXA5WLvOHjvo=; b=1viKC6mJCWc4ZFKX3uYW3Vn+8W
	wHvOGjIi/plHgxBbudBqN1XX6ToMpWyTgUHRkTC6hwHzWzI75RU3i6haTCNcmPbyyqpOUB0jGWUq5
	ea3X2u3bskNRp7KtmK+GCKZ8fhkm8elQDg8TQiNYoESplkUq76Rvxo2bgzU86BxzlYmc4BA33NB8v
	Tg0wAj3yRPOy5ABzGXUPPLxfvSubaGXlmvJxpgsXR/dox6Sux0Yn2g35YS34Dvx6NxEmOaG731uj/
	/71dO41FAavZ4txlUnTh4Wo09KD1MV+bulcYgL5gilPMy/STXiBwIio7HBIrOeWRwOaE34y/wRJsm
	2xtlapzw==;
Received: from 2a02-8389-2341-5b80-decc-1a96-daaa-a2cc.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:decc:1a96:daaa:a2cc] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSWNx-00000005Qlr-0uDq;
	Thu, 28 May 2026 08:46:37 +0000
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	Keith Busch <kbusch@kernel.org>,
	Md Haris Iqbal <haris.iqbal@linux.dev>,
	Damien Le Moal <dlemoal@kernel.org>,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH v2] block: add a bio_endio_status helper
Date: Thu, 28 May 2026 10:46:13 +0200
Message-ID: <20260528084632.2505277-1-hch@lst.de>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Add a helper that sets bi_status and call bio_endio() as that is a very
common pattern and convert the core block code over to it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Md Haris Iqbal <haris.iqbal@linux.dev>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Hannes Reinecke <hare@kernel.org>
---

Changes since v1:
 - fix the function name in the kerneldoc comment

 block/blk-core.c            | 11 ++++-------
 block/blk-crypto-fallback.c |  9 +++------
 block/blk-crypto.c          |  3 +--
 block/blk-merge.c           |  6 ++----
 block/blk-mq.c              |  6 ++----
 block/fops.c                |  3 +--
 include/linux/bio.h         | 19 +++++++++++++++----
 7 files changed, 28 insertions(+), 29 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 22af5dec112b..b0f0a304ea0b 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -636,12 +636,10 @@ static void __submit_bio(struct bio *bio)
 		struct gendisk *disk = bio->bi_bdev->bd_disk;
 	
 		if ((bio->bi_opf & REQ_POLLED) &&
-		    !(disk->queue->limits.features & BLK_FEAT_POLL)) {
-			bio->bi_status = BLK_STS_NOTSUPP;
-			bio_endio(bio);
-		} else {
+		    !(disk->queue->limits.features & BLK_FEAT_POLL))
+			bio_endio_status(bio, BLK_STS_NOTSUPP);
+		else
 			disk->fops->submit_bio(bio);
-		}
 		blk_queue_exit(disk->queue);
 	}
 
@@ -886,8 +884,7 @@ void submit_bio_noacct(struct bio *bio)
 not_supported:
 	status = BLK_STS_NOTSUPP;
 end_io:
-	bio->bi_status = status;
-	bio_endio(bio);
+	bio_endio_status(bio, status);
 }
 EXPORT_SYMBOL(submit_bio_noacct);
 
diff --git a/block/blk-crypto-fallback.c b/block/blk-crypto-fallback.c
index 61f595410832..8b04d9205b8d 100644
--- a/block/blk-crypto-fallback.c
+++ b/block/blk-crypto-fallback.c
@@ -361,8 +361,7 @@ static void blk_crypto_fallback_encrypt_bio(struct bio *src_bio)
 	status = blk_crypto_get_keyslot(blk_crypto_fallback_profile,
 					bc->bc_key, &slot);
 	if (status != BLK_STS_OK) {
-		src_bio->bi_status = status;
-		bio_endio(src_bio);
+		bio_endio_status(src_bio, status);
 		return;
 	}
 	__blk_crypto_fallback_encrypt_bio(src_bio,
@@ -437,8 +436,7 @@ static void blk_crypto_fallback_decrypt_bio(struct work_struct *work)
 	}
 	mempool_free(f_ctx, bio_fallback_crypt_ctx_pool);
 
-	bio->bi_status = status;
-	bio_endio(bio);
+	bio_endio_status(bio, status);
 }
 
 /**
@@ -499,8 +497,7 @@ bool blk_crypto_fallback_bio_prep(struct bio *bio)
 
 	if (!__blk_crypto_cfg_supported(blk_crypto_fallback_profile,
 					&bc->bc_key->crypto_cfg)) {
-		bio->bi_status = BLK_STS_NOTSUPP;
-		bio_endio(bio);
+		bio_endio_status(bio, BLK_STS_NOTSUPP);
 		return false;
 	}
 
diff --git a/block/blk-crypto.c b/block/blk-crypto.c
index 856d3c5b1fa0..165c9d2cce07 100644
--- a/block/blk-crypto.c
+++ b/block/blk-crypto.c
@@ -267,8 +267,7 @@ bool __blk_crypto_submit_bio(struct bio *bio)
 		if (!IS_ENABLED(CONFIG_BLK_INLINE_ENCRYPTION_FALLBACK)) {
 			pr_warn_once("%pg: crypto API fallback disabled; failing request.\n",
 				bdev);
-			bio->bi_status = BLK_STS_NOTSUPP;
-			bio_endio(bio);
+			bio_endio_status(bio, BLK_STS_NOTSUPP);
 			return false;
 		}
 		return blk_crypto_fallback_bio_prep(bio);
diff --git a/block/blk-merge.c b/block/blk-merge.c
index fcf09325b22e..7cc82a7a6f4e 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -122,8 +122,7 @@ struct bio *bio_submit_split_bioset(struct bio *bio, unsigned int split_sectors,
 	struct bio *split = bio_split(bio, split_sectors, GFP_NOIO, bs);
 
 	if (IS_ERR(split)) {
-		bio->bi_status = errno_to_blk_status(PTR_ERR(split));
-		bio_endio(bio);
+		bio_endio_status(bio, errno_to_blk_status(PTR_ERR(split)));
 		return NULL;
 	}
 
@@ -143,8 +142,7 @@ EXPORT_SYMBOL_GPL(bio_submit_split_bioset);
 static struct bio *bio_submit_split(struct bio *bio, int split_sectors)
 {
 	if (unlikely(split_sectors < 0)) {
-		bio->bi_status = errno_to_blk_status(split_sectors);
-		bio_endio(bio);
+		bio_endio_status(bio, errno_to_blk_status(split_sectors));
 		return NULL;
 	}
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 4c5c16cce4f8..ade9d3a89743 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3187,8 +3187,7 @@ void blk_mq_submit_bio(struct bio *bio)
 	}
 
 	if ((bio->bi_opf & REQ_POLLED) && !blk_mq_can_poll(q)) {
-		bio->bi_status = BLK_STS_NOTSUPP;
-		bio_endio(bio);
+		bio_endio_status(bio, BLK_STS_NOTSUPP);
 		goto queue_exit;
 	}
 
@@ -3229,8 +3228,7 @@ void blk_mq_submit_bio(struct bio *bio)
 
 	ret = blk_crypto_rq_get_keyslot(rq);
 	if (ret != BLK_STS_OK) {
-		bio->bi_status = ret;
-		bio_endio(bio);
+		bio_endio_status(bio, ret);
 		blk_mq_free_request(rq);
 		return;
 	}
diff --git a/block/fops.c b/block/fops.c
index ffe7b2042f4e..15783a6180de 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -218,8 +218,7 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
 
 		ret = blkdev_iov_iter_get_pages(bio, iter, bdev);
 		if (unlikely(ret)) {
-			bio->bi_status = BLK_STS_IOERR;
-			bio_endio(bio);
+			bio_endio_status(bio, BLK_STS_IOERR);
 			break;
 		}
 		if (iocb->ki_flags & IOCB_NOWAIT) {
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 7597ae4dc52b..e86c0d2613e2 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -371,16 +371,27 @@ void submit_bio(struct bio *bio);
 
 extern void bio_endio(struct bio *);
 
-static inline void bio_io_error(struct bio *bio)
+/**
+ * bio_endio_status - end I/O on a bio with a specific status
+ * @bio:	bio
+ * @status:	status to set
+ *
+ * Set @bio->bi_status to @status and call bio_endio().
+ **/
+static inline void bio_endio_status(struct bio *bio, blk_status_t status)
 {
-	bio->bi_status = BLK_STS_IOERR;
+	bio->bi_status = status;
 	bio_endio(bio);
 }
 
+static inline void bio_io_error(struct bio *bio)
+{
+	bio_endio_status(bio, BLK_STS_IOERR);
+}
+
 static inline void bio_wouldblock_error(struct bio *bio)
 {
-	bio->bi_status = BLK_STS_AGAIN;
-	bio_endio(bio);
+	bio_endio_status(bio, BLK_STS_AGAIN);
 }
 
 /*
-- 
2.53.0

