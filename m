Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017A61E633C
	for <linux-block@vger.kernel.org>; Tue,  7 Oct 2025 09:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759828023; cv=none; b=goKcQDEKAEMCe99wPpKeND6crbbuVbG3ffaOhGIAyKfkXLdcRLSdVa7ahVif8SNq0C/UIq+GYn3EEDNZSpzQyqZLoSNsOOtgog+rmAo9364CAp0dqQo5AtgxC8XS116nWLbBjag6Wyx0Xm+1Ecb+OEHIRQa5pBQjiP5FMp9Gnxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759828023; c=relaxed/simple;
	bh=+WMLAvEKEgACCCn/tw6yU2W1vXT5VCc4yEDBt+eiqro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QxqdnqyzXjqUrYUPmi4vABJcRM2b7aIO6mloixMaefZJ+pstP+uaDB3tpGAEysvSn9cVh063Dgn23eHmb8aFxIu8xH1ylCv5/uxuscMJTaFirAGkNbL4LsBMKzmVWP2+4Wi5K2r0CVkkaZ6lQAbtI79622MEKgmeQyiMD0QV1nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=m/x4yXb6; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="m/x4yXb6"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=EHBNkhxUOOgHCdTQqCRXSITYyoWDMxwKBi33HGZ/94U=; b=m/x4yXb6jofKTMsIiS1c9wooZV
	R2nsKmPdWCJqccJHiT8Al9kLG80GMli39KtSU4frlsyIVWfpsVAY8tSNp+JM09AcEfU8J9J0pjzP/
	hAXozxXr+alSz09lBzRkt07yZUFamxbIHZO4Z+XHWRIYmdC35cm23+nb7IRXrYivNBQGXMPq4hO4S
	4sy9+fMWenhdbAnLduHNSvaRc7a0EPKz+KX8CZ0iev459q/7FUyW6uoFgtthutBsUEd2fmNJBkt3g
	t4jvG1mMBAJBb+yGFQVvYhpCk/8p0wta/0uFB38d8JgpibkUN9x0rtUzqt0gTpsARBl4K19kgojRk
	glygT/sA==;
Received: from [2001:4bb8:2c1:22e6:ca8d:97b7:39cd:b2e9] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v63ev-00000001fYB-0zb1;
	Tue, 07 Oct 2025 09:07:01 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Qu Wenruo <quwenruo.btrfs@gmx.com>,
	Keith Busch <kbusch@kernel.org>,
	linux-block@vger.kernel.org
Subject: [PATCH 4/4] block: move bio_iov_iter_get_bdev_pages to block/fops.c
Date: Tue,  7 Oct 2025 11:06:28 +0200
Message-ID: <20251007090642.3251548-5-hch@lst.de>
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

Keep bio_iov_iter_get_bdev_pages local with the callers, as blindly
looking at the bdev logical block size is often not the best idea
unless on a block device.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/fops.c           | 13 ++++++++++---
 include/linux/blkdev.h |  7 -------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index c2c0396ea9ee..5e3db9fead77 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -43,6 +43,13 @@ static bool blkdev_dio_invalid(struct block_device *bdev, struct kiocb *iocb,
 			(bdev_logical_block_size(bdev) - 1);
 }
 
+static inline int blkdev_iov_iter_get_pages(struct bio *bio,
+		struct iov_iter *iter, struct block_device *bdev)
+{
+	return bio_iov_iter_get_pages(bio, iter,
+			bdev_logical_block_size(bdev) - 1);
+}
+
 #define DIO_INLINE_BIO_VECS 4
 
 static ssize_t __blkdev_direct_IO_simple(struct kiocb *iocb,
@@ -78,7 +85,7 @@ static ssize_t __blkdev_direct_IO_simple(struct kiocb *iocb,
 	if (iocb->ki_flags & IOCB_ATOMIC)
 		bio.bi_opf |= REQ_ATOMIC;
 
-	ret = bio_iov_iter_get_bdev_pages(&bio, iter, bdev);
+	ret = blkdev_iov_iter_get_pages(&bio, iter, bdev);
 	if (unlikely(ret))
 		goto out;
 	ret = bio.bi_iter.bi_size;
@@ -212,7 +219,7 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
 		bio->bi_end_io = blkdev_bio_end_io;
 		bio->bi_ioprio = iocb->ki_ioprio;
 
-		ret = bio_iov_iter_get_bdev_pages(bio, iter, bdev);
+		ret = blkdev_iov_iter_get_pages(bio, iter, bdev);
 		if (unlikely(ret)) {
 			bio->bi_status = BLK_STS_IOERR;
 			bio_endio(bio);
@@ -348,7 +355,7 @@ static ssize_t __blkdev_direct_IO_async(struct kiocb *iocb,
 		 */
 		bio_iov_bvec_set(bio, iter);
 	} else {
-		ret = bio_iov_iter_get_bdev_pages(bio, iter, bdev);
+		ret = blkdev_iov_iter_get_pages(bio, iter, bdev);
 		if (unlikely(ret))
 			goto out_bio_put;
 	}
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 134f974ac92d..70b671a9a7f7 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1873,13 +1873,6 @@ static inline int bio_split_rw_at(struct bio *bio,
 	return bio_split_io_at(bio, lim, segs, max_bytes, lim->dma_alignment);
 }
 
-static inline int bio_iov_iter_get_bdev_pages(struct bio *bio,
-		struct iov_iter *iter, struct block_device *bdev)
-{
-	return bio_iov_iter_get_pages(bio, iter,
-					bdev_logical_block_size(bdev) - 1);
-}
-
 #define DEFINE_IO_COMP_BATCH(name)	struct io_comp_batch name = { }
 
 #endif /* _LINUX_BLKDEV_H */
-- 
2.47.3

