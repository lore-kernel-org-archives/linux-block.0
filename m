Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95157D29F
	for <linux-block@vger.kernel.org>; Thu, 21 Dec 2023 07:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iq82MPjL"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=xq2Ky6vF4FonHnKCEaQ8IMP4b/FONVflbWvzO0/uOM8=; b=iq82MPjLyv5G6bLzZtKAmkEtt6
	wawn5CIuZM0NQ0ndMNSw/5PVWjjCxv2WWTxE30jicFZPgJIhKAxL7Dab2kQQmPquNZp6k+f3SVabq
	LXTSIr6FpQOKWo6YAhWxas2hQfwPal4o0EiAQyJFf1qFD8ofuXqFg0GO923um6s2+NSAqyQvzr7Nq
	b3F3ULwuoqqWtd/cybyowe4l/vK2blLje32zGTaz+kQ0C36aDDHHuHew7vo6DvZUaggBPP+x1iz87
	Zx3a3KEPWSVFxj0yWh8HXTgLUs2jAwtkWpsNNgVIzIARhaJc3xnZ39Pw9xeJsYdKJuUSAoRjQZJ6J
	kN1zzbAw==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rGD7h-001shl-2M;
	Thu, 21 Dec 2023 07:05:38 +0000
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org
Subject: [PATCH] block: reject invalid operation in submit_bio_noacct
Date: Thu, 21 Dec 2023 08:05:38 +0100
Message-Id: <20231221070538.1112446-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

submit_bio_noacct allows completely invalid operations, or operations
that are not supported in the bio path.  Extent the existing switch
statement to rejcect all invalid types.

Move the code point for REQ_OP_ZONE_APPEND so that it's not right in the
middle of the zone management operations and the switch statement can
follow the numerical order of the operations.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-core.c          | 26 +++++++++++++++++++++-----
 include/linux/blk_types.h |  8 ++++----
 2 files changed, 25 insertions(+), 9 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index fdf25b8d6e784f..9520ccab305007 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -764,6 +764,15 @@ void submit_bio_noacct(struct bio *bio)
 		bio_clear_polled(bio);
 
 	switch (bio_op(bio)) {
+	case REQ_OP_READ:
+	case REQ_OP_WRITE:
+		break;
+	case REQ_OP_FLUSH:
+		/*
+		 * REQ_OP_FLUSH can't be submitted through bios, it is only
+		 * synthetized in struct request by the flush state machine.
+		 */
+		goto not_supported;
 	case REQ_OP_DISCARD:
 		if (!bdev_max_discard_sectors(bdev))
 			goto not_supported;
@@ -777,6 +786,10 @@ void submit_bio_noacct(struct bio *bio)
 		if (status != BLK_STS_OK)
 			goto end_io;
 		break;
+	case REQ_OP_WRITE_ZEROES:
+		if (!q->limits.max_write_zeroes_sectors)
+			goto not_supported;
+		break;
 	case REQ_OP_ZONE_RESET:
 	case REQ_OP_ZONE_OPEN:
 	case REQ_OP_ZONE_CLOSE:
@@ -788,12 +801,15 @@ void submit_bio_noacct(struct bio *bio)
 		if (!bdev_is_zoned(bio->bi_bdev) || !blk_queue_zone_resetall(q))
 			goto not_supported;
 		break;
-	case REQ_OP_WRITE_ZEROES:
-		if (!q->limits.max_write_zeroes_sectors)
-			goto not_supported;
-		break;
+	case REQ_OP_DRV_IN:
+	case REQ_OP_DRV_OUT:
+		/*
+		 * Driver private operations are only used with passthrough
+		 * requests.
+		 */
+		fallthrough;
 	default:
-		break;
+		goto not_supported;
 	}
 
 	if (blk_throtl_bio(bio))
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index d5c5e59ddbd25a..68c9eb2374a465 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -378,6 +378,8 @@ enum req_op {
 	REQ_OP_DISCARD		= (__force blk_opf_t)3,
 	/* securely erase sectors */
 	REQ_OP_SECURE_ERASE	= (__force blk_opf_t)5,
+	/* write data at the current zone write pointer */
+	REQ_OP_ZONE_APPEND	= (__force blk_opf_t)7,
 	/* write the zero filled sector many times */
 	REQ_OP_WRITE_ZEROES	= (__force blk_opf_t)9,
 	/* Open a zone */
@@ -386,12 +388,10 @@ enum req_op {
 	REQ_OP_ZONE_CLOSE	= (__force blk_opf_t)11,
 	/* Transition a zone to full */
 	REQ_OP_ZONE_FINISH	= (__force blk_opf_t)12,
-	/* write data at the current zone write pointer */
-	REQ_OP_ZONE_APPEND	= (__force blk_opf_t)13,
 	/* reset a zone write pointer */
-	REQ_OP_ZONE_RESET	= (__force blk_opf_t)15,
+	REQ_OP_ZONE_RESET	= (__force blk_opf_t)13,
 	/* reset all the zone present on the device */
-	REQ_OP_ZONE_RESET_ALL	= (__force blk_opf_t)17,
+	REQ_OP_ZONE_RESET_ALL	= (__force blk_opf_t)15,
 
 	/* Driver private requests */
 	REQ_OP_DRV_IN		= (__force blk_opf_t)34,
-- 
2.39.2

