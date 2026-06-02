Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D9234040E;
	Tue,  2 Jun 2026 05:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780379193; cv=none; b=oNB8tcBXrrrDO0i02a4PtQW/bzyDRm/S9V6TCPiuSHsgC9+WMJ9/rN49w3y7eMMaxubar/7+oudZlKkgpbh5bdAh+6K+hU2+bJeMZMstKYRpeNjdGdw8nOn0VxSIecic7u8IJ+KQukIFe1hU5NDdNt53UWR3e8EhajpU84kvWYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780379193; c=relaxed/simple;
	bh=67mR/dmkPnQCauROr8RUQT59/09li0tySVebMNGNELI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cK/Y+Bl+XdruiIDAFC0aVo4zQr1WkksAU/gnh2qRwqwJnjApBZqo37WEs3I0gL0w4cy/Hk44asLt4SpICxInABVdcXa+vw9ldtwqWjDTP27LmdbDWySGuQH40q28Y2WwXYHYmV39z38xIUrxQnm+uZiWWFrQDdG9Mo+MWTCx8W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=sQq7oxFH; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sQq7oxFH"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=vsAj4PLYDPcCv6GcmXMLSYoMtUg2wg6ZF+nrwJ85TME=; b=sQq7oxFHgRAvzfHejNwxUfKQXm
	Ga7oRqwtscq/tYSs13904bqDBbJI9HuYg1MH20hzlkjbcF+t5UGWsP7iJPJQEIr+qFHfDf3CojQTf
	9cN2zd7Z6d2QPzvY06A1sK7ENoOyfD8DMkBOT0INEKjFbHqHcwhE/CTxRgUXru/7efouryZpr2rZW
	5G5A+eyZZap0QYGmcOkyYfcIB42kyviRwL43zU6dBGhPprWzD8AARpuXPT8GObhage2oECPnQg9N1
	OHE3xK1Nt3BpR2HdEXsS/hSZMtQSXZqKXw7OQqIR+UBgei/TdYEkPl4HUzZEjhBNFQOIg0/P8rbi9
	Sr0W8VJQ==;
Received: from 2a02-8389-2341-5b80-decc-1a96-daaa-a2cc.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:decc:1a96:daaa:a2cc] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUHxO-0000000CLAR-35oe;
	Tue, 02 Jun 2026 05:46:31 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Jonathan Corbet <corbet@lwn.net>,
	linux-block@vger.kernel.org,
	linux-doc@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 3/9] block: refactor should_fail_bio and should_fail_request
Date: Tue,  2 Jun 2026 07:45:35 +0200
Message-ID: <20260602054615.3788425-4-hch@lst.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260602054615.3788425-1-hch@lst.de>
References: <20260602054615.3788425-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Move the bdev flag checks into a helper and the blk-mq clone
insers so that we can do only a single actual error injection for
I/O to partitions instead of doing it twice.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-core.c          | 28 ++++++++++++++--------------
 block/blk-mq.c            |  3 ++-
 block/blk.h               |  5 ++---
 include/linux/blk_types.h |  2 --
 4 files changed, 18 insertions(+), 20 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index f35e0d3fb127..644888b66f33 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -502,10 +502,9 @@ static int __init setup_fail_make_request(char *str)
 }
 __setup("fail_make_request=", setup_fail_make_request);
 
-bool should_fail_request(struct block_device *part, unsigned int bytes)
+bool should_fail_request(unsigned int bytes)
 {
-	return bdev_test_flag(part, BD_MAKE_IT_FAIL) &&
-	       should_fail(&fail_make_request, bytes);
+	return should_fail(&fail_make_request, bytes);
 }
 
 static int __init fail_make_request_debugfs(void)
@@ -539,11 +538,13 @@ static inline void bio_check_ro(struct bio *bio)
 	}
 }
 
-static int should_fail_bio(struct bio *bio)
+static inline bool may_fail_bio(struct bio *bio)
 {
-	if (should_fail_request(bdev_whole(bio->bi_bdev), bio->bi_iter.bi_size))
-		return -EIO;
-	return 0;
+	if (!IS_ENABLED(CONFIG_FAIL_MAKE_REQUEST))
+		return false;
+	return bdev_test_flag(bio->bi_bdev, BD_MAKE_IT_FAIL) ||
+		(bio_flagged(bio, BIO_REMAPPED) &&
+		 bdev_test_flag(bdev_whole(bio->bi_bdev), BD_MAKE_IT_FAIL));
 }
 
 /*
@@ -577,8 +578,6 @@ static int blk_partition_remap(struct bio *bio)
 {
 	struct block_device *p = bio->bi_bdev;
 
-	if (unlikely(should_fail_request(p, bio->bi_iter.bi_size)))
-		return -EIO;
 	if (bio_sectors(bio)) {
 		bio->bi_iter.bi_sector += p->bd_start_sect;
 		trace_block_bio_remap(bio, p->bd_dev,
@@ -723,10 +722,13 @@ static void __submit_bio_noacct_mq(struct bio *bio)
 
 void submit_bio_noacct_nocheck(struct bio *bio, bool split)
 {
-	if (should_fail_bio(bio)) {
-		bio_io_error(bio);
-		return;
+	if (unlikely(may_fail_bio(bio))) {
+		if (should_fail_request(bio->bi_iter.bi_size)) {
+			bio_io_error(bio);
+			return;
+		}
 	}
+
 	blk_cgroup_bio_start(bio);
 
 	if (!bio_flagged(bio, BIO_TRACE_COMPLETION)) {
@@ -799,8 +801,6 @@ void submit_bio_noacct(struct bio *bio)
 			goto not_supported;
 	}
 
-	if (should_fail_bio(bio))
-		goto end_io;
 	bio_check_ro(bio);
 	if (!bio_flagged(bio, BIO_REMAPPED)) {
 		if (unlikely(bio_check_eod(bio)))
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 629e16003eb7..bf66645622df 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3275,7 +3275,8 @@ blk_status_t blk_insert_cloned_request(struct request *rq)
 		return BLK_STS_IOERR;
 	}
 
-	if (q->disk && should_fail_request(q->disk->part0, blk_rq_bytes(rq)))
+	if (q->disk && bdev_test_flag(q->disk->part0, BD_MAKE_IT_FAIL) &&
+	    should_fail_request(blk_rq_bytes(rq)))
 		return BLK_STS_IOERR;
 
 	ret = blk_crypto_rq_get_keyslot(rq);
diff --git a/block/blk.h b/block/blk.h
index 889a39589356..250a6eee700a 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -647,10 +647,9 @@ int disk_register_independent_access_ranges(struct gendisk *disk);
 void disk_unregister_independent_access_ranges(struct gendisk *disk);
 
 #ifdef CONFIG_FAIL_MAKE_REQUEST
-bool should_fail_request(struct block_device *part, unsigned int bytes);
+bool should_fail_request(unsigned int bytes);
 #else /* CONFIG_FAIL_MAKE_REQUEST */
-static inline bool should_fail_request(struct block_device *part,
-					unsigned int bytes)
+static inline bool should_fail_request(unsigned int bytes)
 {
 	return false;
 }
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 8808ee76e73c..4a3cfa857637 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -51,9 +51,7 @@ struct block_device {
 #define BD_WRITE_HOLDER		(1u<<9)
 #define BD_HAS_SUBMIT_BIO	(1u<<10)
 #define BD_RO_WARNED		(1u<<11)
-#ifdef CONFIG_FAIL_MAKE_REQUEST
 #define BD_MAKE_IT_FAIL		(1u<<12)
-#endif
 	dev_t			bd_dev;
 	struct address_space	*bd_mapping;	/* page cache */
 
-- 
2.53.0

