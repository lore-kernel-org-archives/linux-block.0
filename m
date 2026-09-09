Received: from mail-vs1-f100.google.com (mail-vs1-f100.google.com [209.85.217.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EACEC48EC83
	for <linux-block@vger.kernel.org>; Wed,  9 Sep 2026 22:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788992954; cv=none; b=q7JGOE/hdhunjgYvRqHoaJA6XaT5NZsxnanbknNYXZfXDPFKw3BLG3PYDxveoCln1WVybRN1i65era9CqIDwZ9iu5DL+iotnnNiY9tLUe5KIh25nC8MmBRqtlnZ30upl+hkOeqtB/2gWkNTK0MQVBZIg/6KtHMiiF9uF8h7s/oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788992954; c=relaxed/simple;
	bh=sLx20K+qsQCJyEhfpGSQLav0qN/DYI0usp+NjaEikj4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dlbVopJ6bXqZrmttVwGzYg4fuOu50Hfwk2VDJCROQkc7sgUNgepcyZ+Uou4He1tDWGoA6YKA4eH26ujz4WGqyahfVc4L9Wbipa2/uFmaUJFIox3RPs46wdXdUrsCw81mXJSLaPFV+meEkRqz2wxjXBdmlLm4WljdSUDmN5Gd4co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=KsbjO2R7; arc=none smtp.client-ip=209.85.217.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="KsbjO2R7"
Received: by mail-vs1-f100.google.com with SMTP id ada2fe7eead31-7904f893dd2so2482137.2
        for <linux-block@vger.kernel.org>; Wed, 09 Sep 2026 15:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1788992944; x=1789597744; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bsGabQTCyGBOnewN0WNVIraAhvd9VdUc8vuvn8dczvo=;
        b=KsbjO2R7+0OPuTjY3C0ERl15E9eo9zWNKvSfvZRhnCNfUd90OlEj7rfh4C7rB4rkP0
         2cCEevAEmeEkCHuG9+rH8yckFQWVsVRgXN9OnrAhOgtYBNNGdATsAg/IkLstcw/SGAr1
         rqq3GIM50w1PHJo9I9Rtt2WP6nCdfGXhmodTLpi5Crkb7eVcMZOPWeak6oGP4RfzVq5L
         ax0VGJ/en1AF94r5bTaJ53CMkMrvPonSGJwfF5k+i0VsPl1Kh+YWdRMj/REhPXNWtEmv
         yUlUNDeMHRDe+IPYSGtsyJy04SXbHxk2d66uwJmLcXRCJhF0QNzkTyZj/sLvHq8A0SfV
         M8eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788992944; x=1789597744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bsGabQTCyGBOnewN0WNVIraAhvd9VdUc8vuvn8dczvo=;
        b=Cf29eRzPcCuMpVlfMGUScuXI8DgT3gEwtF82S9sxFYxgmjbZ73wdaQo4mqpAJ09gWA
         btygi5efzJyaJ3n+BwbXuzFWzFi+dNwg1wKKx9sXt6iyaBbrKG4aHwy6kLa6DOkd2atd
         Ypv7YzTjdKvknsgwmD6Lfyn8DKItyM3i8e5XotBo9D2vWWHggINXeBzEZcp3sgVYsjR1
         zzVDsuLkglVaMcVGRa9zGhVN6uRsTOJJOV8BEzJE1RWLV+IdBw/3Cvtihj4faxAsjy29
         wGOkkAHrj8qv4fhvgYMREHoHLDGcTOFSpB/6nLUvakEZQLg/RJpt0fiPwMpr5AARDlKZ
         3H9g==
X-Forwarded-Encrypted: i=1; AKwUvBynU0xTcwGa/lEDJfXrbZgViNDxrkoA5HDJ836ln9P2zY1YFBFaF/W+jyB66BkrHDB59f4/QfhVexEk3g==@vger.kernel.org
X-Gm-Message-State: AFuF++nvAS3vGnavHUBStprbGLSipxWkr1kR8Z1uozSdgRHlKAWP1az/
	Y5D4FjD2lXEdITsu8lCEL01vcvGfuARh7xJU3uWKTSAKEvVfTHComvVreaKWrS34aMoHdyYLsTS
	AM63rxUKsdTXmtFBcJUul9gR5JuDUlKrajtsg
X-Gm-Gg: AYBFou36xlq5L/XT7ymD1ulb9UzOq58SnaXtOKJYi3gF3PQ2yYyveLQz9TT2iZhnxnw
	X+c5qqq6OkTWKoXOCq7+k1l2QGh20aQcjt4zpdOVxfwwHbHroN+MnbPbtaqU+qU/j4/5zBSaCJw
	UhWsaizfHIaMZi6KuSDotgG5pG1yJ6esmA/+7Wkf3zcAzbRNIuFHEZprtjWA5zpnlOBmEz0NqcS
	IqpI7cJTVt5zhYIIvxbkZUnnO2zUsKWt8MPf0zRxyc+KRXIz7SkhC1WN1jiX7qnXnKfkuoH+pBY
	k16f172us/e1HDw/zSN13VjnMsL00p1UvZXVXgYGNsuXk4oZQVg6qi3P4LbZjX2PIF1dhcWQS+R
	VsmMGsbIJtmAh9IQljrcz0vAaco8jP8xN
X-Received: by 2002:a67:ebd5:0:b0:790:563:8d1b with SMTP id ada2fe7eead31-79005639f22mr1285898137.0.1788992944076;
        Wed, 09 Sep 2026 15:29:04 -0700 (PDT)
Received: from c7-smtp-2026.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id a1e0cc1a2514c-9808e9758adsm5500843241.0.2026.09.09.15.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 15:29:04 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (bond0.slc5-n17m28-k8s.dev.purestorage.com [IPv6:2620:125:9025:20::a31:41f])
	by c7-smtp-2026.dev.purestorage.com (Postfix) with ESMTP id 4F0D6402BA;
	Wed,  9 Sep 2026 16:29:03 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 4C79CE40322; Wed,  9 Sep 2026 16:29:03 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 3/6] blk-integrity: pass iov_iter to blk_rq_integrity_map_user()
Date: Wed,  9 Sep 2026 16:28:33 -0600
Message-ID: <20260909222836.2475352-4-csander@purestorage.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260909222836.2475352-1-csander@purestorage.com>
References: <20260909222836.2475352-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To allow blk_rq_integrity_map_user() to accept an io_uring registered
buffer (represented as a ITER_BVEC iov_iter), take the buffer as an
iov_iter argument. Move the conversion from a user address-length pair
into an iov_iter to the caller.

Since a non-ITER_UBUF iov_iter could be passed in the future,
iov_iter_extract_pages() in bio_integrity_map_user() won't necessarily
pin the pages. Condition the page unpins on iov_iter_extract_will_pin().
Add a BIP_PAGE_PINNED bit to bip_flags to track if the pages are pinned.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 block/bio-integrity.c         | 43 +++++++++++++++++++++++------------
 block/blk-integrity.c         |  7 ++----
 drivers/nvme/host/ioctl.c     |  6 ++++-
 include/linux/bio-integrity.h |  1 +
 include/linux/blk-integrity.h |  6 ++---
 5 files changed, 38 insertions(+), 25 deletions(-)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index 8ba8bfa41f8a..3a5554d3ea2f 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -187,11 +187,12 @@ static void bio_integrity_uncopy_user(struct bio_integrity_payload *bip)
 
 	iov_iter_bvec(&orig_iter, ITER_DEST, orig_bvecs, orig_nr_vecs, bytes);
 	ret = copy_to_iter(bvec_virt(bounce_bvec), bytes, &orig_iter);
 	WARN_ON_ONCE(ret != bytes);
 
-	bio_integrity_unpin_bvec(orig_bvecs, orig_nr_vecs);
+	if (bip->bip_flags & BIP_PAGE_PINNED)
+		bio_integrity_unpin_bvec(orig_bvecs, orig_nr_vecs);
 }
 
 /**
  * bio_integrity_unmap_user - Unmap user integrity payload
  * @bio:	bio containing bip to be unmapped
@@ -207,11 +208,12 @@ void bio_integrity_unmap_user(struct bio *bio)
 			bio_integrity_uncopy_user(bip);
 		kfree(bvec_virt(bip->bip_vec));
 		return;
 	}
 
-	bio_integrity_unpin_bvec(bip->bip_vec, bip->bip_max_vcnt);
+	if (bip->bip_flags & BIP_PAGE_PINNED)
+		bio_integrity_unpin_bvec(bip->bip_vec, bip->bip_max_vcnt);
 }
 
 /**
  * bio_integrity_add_page - Attach integrity metadata
  * @bio:	bio to update
@@ -257,11 +259,11 @@ int bio_integrity_add_page(struct bio *bio, struct page *page,
 	return len;
 }
 EXPORT_SYMBOL(bio_integrity_add_page);
 
 static int bio_integrity_copy_user(struct bio *bio, struct bio_vec *bvec,
-				   int nr_vecs, unsigned int len)
+				   int nr_vecs, unsigned int len, bool pinned)
 {
 	bool write = op_is_write(bio_op(bio));
 	struct bio_integrity_payload *bip;
 	struct iov_iter iter;
 	void *buf;
@@ -292,14 +294,18 @@ static int bio_integrity_copy_user(struct bio *bio, struct bio_vec *bvec,
 	if (IS_ERR(bip)) {
 		ret = PTR_ERR(bip);
 		goto free_buf;
 	}
 
-	if (write)
-		bio_integrity_unpin_bvec(bvec, nr_vecs);
-	else
+	if (write) {
+		if (pinned)
+			bio_integrity_unpin_bvec(bvec, nr_vecs);
+	} else {
 		memcpy(&bip->bip_vec[1], bvec, nr_vecs * sizeof(*bvec));
+		if (pinned)
+			bip->bip_flags |= BIP_PAGE_PINNED;
+	}
 
 	ret = bio_integrity_add_page(bio, virt_to_page(buf), len,
 				     offset_in_page(buf));
 	WARN_ON_ONCE(ret != len);
 	bip->bip_flags |= BIP_COPY_USER;
@@ -308,27 +314,29 @@ static int bio_integrity_copy_user(struct bio *bio, struct bio_vec *bvec,
 	kfree(buf);
 	return ret;
 }
 
 static int bio_integrity_init_user(struct bio *bio, struct bio_vec *bvec,
-				   int nr_vecs, unsigned int len)
+				   int nr_vecs, unsigned int len, bool pinned)
 {
 	struct bio_integrity_payload *bip;
 
 	bip = bio_integrity_alloc(bio, GFP_KERNEL, nr_vecs);
 	if (IS_ERR(bip))
 		return PTR_ERR(bip);
 
 	memcpy(bip->bip_vec, bvec, nr_vecs * sizeof(*bvec));
 	bip->bip_iter.bi_size = len;
 	bip->bip_vcnt = nr_vecs;
+	if (pinned)
+		bip->bip_flags |= BIP_PAGE_PINNED;
 	return 0;
 }
 
 static unsigned int bvec_from_pages(struct bio_vec *bvec, struct page **pages,
 				    int nr_vecs, ssize_t bytes, ssize_t offset,
-				    bool *is_p2p)
+				    bool *is_p2p, bool pinned)
 {
 	unsigned int nr_bvecs = 0;
 	int i, j;
 
 	for (i = 0; i < nr_vecs; i = j) {
@@ -340,11 +348,12 @@ static unsigned int bvec_from_pages(struct bio_vec *bvec, struct page **pages,
 			size_t next = min_t(size_t, PAGE_SIZE, bytes);
 
 			if (page_folio(pages[j]) != folio ||
 			    pages[j] != pages[j - 1] + 1)
 				break;
-			unpin_user_page(pages[j]);
+			if (pinned)
+				unpin_user_page(pages[j]);
 			size += next;
 			bytes -= next;
 		}
 
 		if (is_pci_p2pdma_page(pages[i]))
@@ -361,10 +370,11 @@ static unsigned int bvec_from_pages(struct bio_vec *bvec, struct page **pages,
 int bio_integrity_map_user(struct bio *bio, struct iov_iter *iter)
 {
 	struct request_queue *q = bdev_get_queue(bio->bi_bdev);
 	struct page *stack_pages[UIO_FASTIOV], **pages = stack_pages;
 	struct bio_vec stack_vec[UIO_FASTIOV], *bvec = stack_vec;
+	bool pinned = iov_iter_extract_will_pin(iter);
 	iov_iter_extraction_t extraction_flags = 0;
 	size_t offset, bytes = iter->count;
 	bool copy, is_p2p = false;
 	unsigned int nr_bvecs;
 	int ret, nr_vecs;
@@ -397,12 +407,12 @@ int bio_integrity_map_user(struct bio *bio, struct iov_iter *iter)
 
 	/*
 	 * Handle partial pinning. This can happen when pin_user_pages_fast()
 	 * returns fewer pages than requested.
 	 */
-	if (user_backed_iter(iter) && unlikely(ret != bytes)) {
-		if (ret > 0) {
+	if (unlikely(ret != bytes)) {
+		if (pinned && ret > 0) {
 			int npinned = DIV_ROUND_UP(offset + ret, PAGE_SIZE);
 			int i;
 
 			for (i = 0; i < npinned; i++)
 				unpin_user_page(pages[i]);
@@ -412,31 +422,34 @@ int bio_integrity_map_user(struct bio *bio, struct iov_iter *iter)
 		ret = -EFAULT;
 		goto free_bvec;
 	}
 
 	nr_bvecs = bvec_from_pages(bvec, pages, nr_vecs, bytes, offset,
-				   &is_p2p);
+				   &is_p2p, pinned);
 	if (pages != stack_pages)
 		kvfree(pages);
 	if (nr_bvecs > queue_max_integrity_segments(q))
 		copy = true;
 	if (is_p2p)
 		bio->bi_opf |= REQ_NOMERGE;
 
 	if (copy)
-		ret = bio_integrity_copy_user(bio, bvec, nr_bvecs, bytes);
+		ret = bio_integrity_copy_user(bio, bvec, nr_bvecs, bytes,
+					      pinned);
 	else
-		ret = bio_integrity_init_user(bio, bvec, nr_bvecs, bytes);
+		ret = bio_integrity_init_user(bio, bvec, nr_bvecs, bytes,
+					      pinned);
 	if (ret)
 		goto release_pages;
 	if (bvec != stack_vec)
 		kfree(bvec);
 
 	return 0;
 
 release_pages:
-	bio_integrity_unpin_bvec(bvec, nr_bvecs);
+	if (pinned)
+		bio_integrity_unpin_bvec(bvec, nr_bvecs);
 free_bvec:
 	if (bvec != stack_vec)
 		kfree(bvec);
 	return ret;
 }
diff --git a/block/blk-integrity.c b/block/blk-integrity.c
index 964eebbee14d..6977bfd96927 100644
--- a/block/blk-integrity.c
+++ b/block/blk-integrity.c
@@ -118,18 +118,15 @@ int blk_get_meta_cap(struct block_device *bdev, unsigned int cmd,
 out:
 	return copy_struct_to_user(argp, usize, &meta_cap, sizeof(meta_cap),
 				   NULL);
 }
 
-int blk_rq_integrity_map_user(struct request *rq, void __user *ubuf,
-			      ssize_t bytes)
+int blk_rq_integrity_map_user(struct request *rq, struct iov_iter *iter)
 {
 	int ret;
-	struct iov_iter iter;
 
-	iov_iter_ubuf(&iter, rq_data_dir(rq), ubuf, bytes);
-	ret = bio_integrity_map_user(rq->bio, &iter);
+	ret = bio_integrity_map_user(rq->bio, iter);
 	if (ret)
 		return ret;
 
 	rq->nr_integrity_segments = blk_rq_count_integrity_sg(rq->q, rq->bio);
 	rq->cmd_flags |= REQ_INTEGRITY;
diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 748a4cbf7e90..e69c49c334a0 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -175,11 +175,15 @@ static int nvme_map_user_request(struct request *req, u64 ubuffer,
 				0, rq_data_dir(req));
 	if (ret)
 		return ret;
 
 	if (has_metadata) {
-		ret = blk_rq_integrity_map_user(req, meta_buffer, meta_len);
+		struct iov_iter meta_iter;
+
+		iov_iter_ubuf(&meta_iter, rq_data_dir(req), meta_buffer,
+			      meta_len);
+		ret = blk_rq_integrity_map_user(req, &meta_iter);
 		if (ret)
 			goto out_unmap;
 	}
 
 	return ret;
diff --git a/include/linux/bio-integrity.h b/include/linux/bio-integrity.h
index 0ea2a8bf7efb..740acb8c1077 100644
--- a/include/linux/bio-integrity.h
+++ b/include/linux/bio-integrity.h
@@ -12,10 +12,11 @@ enum bip_flags {
 	BIP_COPY_USER		= 1 << 4, /* Kernel bounce buffer in use */
 	BIP_CHECK_GUARD		= 1 << 5, /* guard check */
 	BIP_CHECK_REFTAG	= 1 << 6, /* reftag check */
 	BIP_CHECK_APPTAG	= 1 << 7, /* apptag check */
 
+	BIP_PAGE_PINNED		= 1 << 14, /* pages need to be unpinned */
 	BIP_MEMPOOL		= 1 << 15, /* buffer backed by mempool */
 };
 
 /* flags that require generate/verify action. */
 #define BIP_CHECK_FLAGS (BIP_CHECK_GUARD | BIP_CHECK_REFTAG | BIP_CHECK_APPTAG)
diff --git a/include/linux/blk-integrity.h b/include/linux/blk-integrity.h
index b1b530613c34..8b655ac165e8 100644
--- a/include/linux/blk-integrity.h
+++ b/include/linux/blk-integrity.h
@@ -28,12 +28,11 @@ static inline bool queue_limits_stack_integrity_bdev(struct queue_limits *t,
 
 #ifdef CONFIG_BLK_DEV_INTEGRITY
 int blk_rq_map_integrity_sg(struct request *, struct scatterlist *);
 
 int blk_rq_count_integrity_sg(struct request_queue *, struct bio *);
-int blk_rq_integrity_map_user(struct request *rq, void __user *ubuf,
-			      ssize_t bytes);
+int blk_rq_integrity_map_user(struct request *rq, struct iov_iter *iter);
 int blk_get_meta_cap(struct block_device *bdev, unsigned int cmd,
 		     struct logical_block_metadata_cap __user *argp);
 bool blk_rq_integrity_dma_map_iter_start(struct request *req,
 		struct device *dma_dev,  struct dma_iova_state *state,
 		struct blk_dma_iter *iter);
@@ -116,12 +115,11 @@ static inline int blk_rq_map_integrity_sg(struct request *q,
 					  struct scatterlist *s)
 {
 	return 0;
 }
 static inline int blk_rq_integrity_map_user(struct request *rq,
-					    void __user *ubuf,
-					    ssize_t bytes)
+					    struct iov_iter *iter)
 {
 	return -EINVAL;
 }
 static inline bool blk_rq_integrity_dma_map_iter_start(struct request *req,
 		struct device *dma_dev,  struct dma_iova_state *state,
-- 
2.55.0

