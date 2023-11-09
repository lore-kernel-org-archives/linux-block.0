Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71471095B
	for <linux-block@vger.kernel.org>; Thu,  9 Nov 2023 08:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KwaYDw4n"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CDE2210A
	for <linux-block@vger.kernel.org>; Thu,  9 Nov 2023 00:28:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699518534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XMqybCspHwEPwkC3B8c6Mqql7Xpmsiz9Lb4cF/wNt5k=;
	b=KwaYDw4nyl7ICUZ6aUeAHii8g/QbcnKSx7H4+Yiv+l2gSmdhIPDODaxulBBt2S1MZD5LGX
	wEksLwXi5QwOtg9V1zNhC9TajjfbagYmYRyx0Oq+Rl/pu7XhEGEPFlGyqUKQAQxyAFvxxr
	RybjDJxp/k19rlkGCwEnVQ7GjMno6hA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-626-v6nZxSaEPtmfSJaJJVLFCw-1; Thu,
 09 Nov 2023 03:28:50 -0500
X-MC-Unique: v6nZxSaEPtmfSJaJJVLFCw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EA3ED1C04181;
	Thu,  9 Nov 2023 08:28:49 +0000 (UTC)
Received: from localhost (unknown [10.72.120.3])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1366E502A;
	Thu,  9 Nov 2023 08:28:48 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Ed Tsai <ed.tsai@mediatek.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 2/2] block: try to make aligned bio in case of big chunk IO
Date: Thu,  9 Nov 2023 16:28:21 +0800
Message-ID: <20231109082827.2276696-3-ming.lei@redhat.com>
In-Reply-To: <20231109082827.2276696-1-ming.lei@redhat.com>
References: <20231109082827.2276696-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

In case of big chunk sequential IO, bio size is often not aligned with
queue's max IO size because of multipage bvec, and unaligned & small bio
can be caused by bio split, then sequential IO perf drops, so try to align
bio with max IO size for avoiding this issue.

Provide 'max_size' hint to iov_iter_extract_pages() when this bio is close
to be full, and try to keep bio aligned with max IO size, so that we can
minimize bio & iov_iter revert. In my 1GB IO test over VM with 2G ram,
when memory becomes highly fragmented, revert ratio(revert bytes/buf size)
can be kept as small as 0.5% with this algorithm.

Ed Tsai reported that this change improves 64MB read/write by > 15%~25% in
Antutu V10 Storage Test.

Reported-by: Ed Tsai <ed.tsai@mediatek.com>
Closes: https://lore.kernel.org/linux-block/20231025092255.27930-1-ed.tsai@mediatek.com/
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/bio.c            | 116 +++++++++++++++++++++++++++++++++++++++--
 include/linux/blkdev.h |   5 ++
 2 files changed, 118 insertions(+), 3 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 09a5e71a0372..e360ac052764 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1210,6 +1210,57 @@ static int bio_iov_add_zone_append_page(struct bio *bio, struct page *page,
 	return 0;
 }
 
+/*
+ * Figure out max_size hint of iov_iter_extract_pages() for minimizing
+ * bio & iov iter revert so that bio can be aligned with max io size.
+ */
+static unsigned int bio_get_buffer_size_hint(const struct bio *bio,
+		unsigned int left)
+{
+	unsigned int nr_bvecs = bio->bi_max_vecs - bio->bi_vcnt;
+	unsigned int size, predicted_space, max_bytes;
+	unsigned int space = nr_bvecs << PAGE_SHIFT;
+	unsigned int align_deviation;
+
+	/* If we have enough space really, just try to get all pages */
+	if (!bio->bi_bdev || nr_bvecs >= (bio->bi_max_vecs / 4) ||
+			!bio->bi_vcnt || left <= space)
+		return UINT_MAX - size;
+
+	max_bytes = bdev_max_io_bytes(bio->bi_bdev);
+	size = bio->bi_iter.bi_size;
+
+	/*
+	 * One bvec can hold physically continuous page frames with
+	 * multipage bvec and bytes in these pages can be pretty big, so
+	 * predict the available space by averaging bytes on all bvecs
+	 */
+	predicted_space = size * nr_bvecs / bio->bi_vcnt;
+	/*
+	 * If predicted space is bigger than max io bytes and at least two
+	 * vectors left, ask for all pages
+	 */
+	if (predicted_space > max_bytes && nr_bvecs > 2)
+		return UINT_MAX - size;
+
+	/*
+	 * This bio is close to be full, and stop to add pages if it is
+	 * basically aligned, otherwise just get & add pages if the bio
+	 * can be kept as aligned, so that we can minimize bio & iov iter
+	 * revert
+	 */
+	align_deviation = max_t(unsigned int, 16U * 1024, max_bytes / 16);
+	if ((size & (max_bytes - 1)) > align_deviation) {
+		unsigned aligned_bytes = max_bytes - (size & (max_bytes - 1));
+
+		/* try to keep bio aligned if we have enough data and space */
+		if (aligned_bytes <= left && aligned_bytes <= predicted_space)
+			return aligned_bytes;
+	}
+
+	return 0;
+}
+
 #define PAGE_PTRS_PER_BVEC     (sizeof(struct bio_vec) / sizeof(struct page *))
 
 /**
@@ -1229,7 +1280,7 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 	unsigned short entries_left = bio->bi_max_vecs - bio->bi_vcnt;
 	struct bio_vec *bv = bio->bi_io_vec + bio->bi_vcnt;
 	struct page **pages = (struct page **)bv;
-	ssize_t size, left;
+	ssize_t size, left, max_size;
 	unsigned len, i = 0;
 	size_t offset;
 	int ret = 0;
@@ -1245,6 +1296,10 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 	if (bio->bi_bdev && blk_queue_pci_p2pdma(bio->bi_bdev->bd_disk->queue))
 		extraction_flags |= ITER_ALLOW_P2PDMA;
 
+	max_size = bio_get_buffer_size_hint(bio, iov_iter_count(iter));
+	if (!max_size)
+		return -E2BIG;
+
 	/*
 	 * Each segment in the iov is required to be a block size multiple.
 	 * However, we may not be able to get the entire segment if it spans
@@ -1252,8 +1307,7 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 	 * result to ensure the bio's total size is correct. The remainder of
 	 * the iov data will be picked up in the next bio iteration.
 	 */
-	size = iov_iter_extract_pages(iter, &pages,
-				      UINT_MAX - bio->bi_iter.bi_size,
+	size = iov_iter_extract_pages(iter, &pages, max_size,
 				      nr_pages, extraction_flags, &offset);
 	if (unlikely(size <= 0))
 		return size ? size : -EFAULT;
@@ -1298,6 +1352,46 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 	return ret;
 }
 
+/* should only be called before submission */
+static void bio_shrink(struct bio *bio, unsigned bytes)
+{
+	unsigned int size = bio->bi_iter.bi_size;
+	int idx;
+
+	if (bytes >= size)
+		return;
+
+	WARN_ON_ONCE(bio_flagged(bio, BIO_CLONED));
+
+	idx = bio->bi_vcnt - 1;
+	bio->bi_iter.bi_size -= bytes;
+	while (bytes > 0) {
+		struct bio_vec *bv = &bio->bi_io_vec[idx];
+		unsigned int len = min_t(unsigned, bv->bv_len, bytes);
+
+		bytes -= len;
+		bv->bv_len -= len;
+		if (!bv->bv_len) {
+			bio_release_page(bio, bv->bv_page);
+			idx--;
+		}
+	}
+	WARN_ON_ONCE(idx < 0);
+	bio->bi_vcnt = idx + 1;
+}
+
+static unsigned bio_align_with_io_size(struct bio *bio)
+{
+	unsigned int size = bio->bi_iter.bi_size;
+	unsigned int trim = size & (bdev_max_io_bytes(bio->bi_bdev) - 1);
+
+	if (trim && trim != size) {
+		bio_shrink(bio, trim);
+		return trim;
+	}
+	return 0;
+}
+
 /**
  * bio_iov_iter_get_pages - add user or kernel pages to a bio
  * @bio: bio to add pages to
@@ -1337,6 +1431,22 @@ int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 		ret = __bio_iov_iter_get_pages(bio, iter);
 	} while (!ret && iov_iter_count(iter) && !bio_full(bio, 0));
 
+
+	/*
+	 * If we still have data and bio is full, this bio size may not be
+	 * aligned with max io size, small bio can be caused by split, try
+	 * to avoid this situation by aligning bio with max io size.
+	 *
+	 * Big chunk of sequential IO workload can benefit from this way.
+	 */
+	if (!ret && iov_iter_count(iter) && bio->bi_bdev &&
+			bio_op(bio) != REQ_OP_ZONE_APPEND) {
+		unsigned trim = bio_align_with_io_size(bio);
+
+		if (trim)
+			iov_iter_revert(iter, trim);
+	}
+
 	return bio->bi_vcnt ? 0 : ret;
 }
 EXPORT_SYMBOL_GPL(bio_iov_iter_get_pages);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index eef450f25982..2d275cdc39d8 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1151,6 +1151,11 @@ static inline unsigned queue_logical_block_size(const struct request_queue *q)
 	return retval;
 }
 
+static inline unsigned int bdev_max_io_bytes(struct block_device *bdev)
+{
+	return queue_max_bytes(bdev_get_queue(bdev));
+}
+
 static inline unsigned int bdev_logical_block_size(struct block_device *bdev)
 {
 	return queue_logical_block_size(bdev_get_queue(bdev));
-- 
2.41.0

