Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6A33DDAFA;
	Tue,  4 Aug 2026 12:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785847880; cv=none; b=QseYco290B+2y4/yeD8ESAzhFKu9XtO03qmjzd/GGmnBUeO8kAKkFRYiEAdIJ/cJUBrfr8J3SqH0h3VGjRPODM1xC+7xko9dlJWZIcEZARNVi5zRoY5K4ckAITwByOTCXeeVPhmpXoU2S35No21vLuLnuLuBUIwrMMiQ1IY6C10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785847880; c=relaxed/simple;
	bh=DbvX5oHSeKl69OmF2BYaQl6YsUvM8YQ8HeUbBZ9nWSE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cvk0Kq+z1PKbAm4XTItEVJQxoTiLACdkUQe+U1kL6RNpOrZep70lpTzsY1JtbBef8Du2RrwzRyVWFYc5WnnHizZUhy7N8I9NfaF2tUyCDm3IHQSyNYb8pYsNcnO9DDT8tYC9OdGPJfEl0uKbji1n1PG0JJnsCYYXL6bsnNsxxXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JCA51yUb; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JCA51yUb"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=lJYvKB9ttappj/b7foMGZo6SVTH7Lk5l+cJChzuiynw=; b=JCA51yUb+arh3rtoGv4WQgyLdQ
	Zt0gVXlirOgbLiaR1LvL4etlOVR4ae7CIr6B7WK/dm5rpLThlK2vqKiAEJJmoyi7kat1pjgyGAGoZ
	LfLzL94eCO9OkVdRllzADPIyiDFLyJnqOIQJisAsNwEYQORm5UpbYEi4SMZ+hCxzjJHypK+xD5SDL
	PawAXzoXTyCIg3E4BdSrZVbFLOHypwxL/a7qsCtbSst6NEO0zGrTDAcr8obHtGfe8uN2LWcWZSSx0
	2Yvp+CABdrimjGq3UU7oBQ/Pw+xEWx4c7+mGwQobYg58+lbjdMmeoJTxSKrkH8CDld8K35f6w5eqb
	Uo9bqTeA==;
Received: from [93.123.20.94] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wrEbt-00000001r7b-017n;
	Tue, 04 Aug 2026 12:51:09 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	linux-block@vger.kernel.org,
	io-uring@vger.kernel.org
Subject: [PATCH 3/6] block: remove blk_zone_wplug_handle_zone_mgmt
Date: Tue,  4 Aug 2026 05:50:19 -0700
Message-ID: <20260804125038.740388-4-hch@lst.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260804125038.740388-1-hch@lst.de>
References: <20260804125038.740388-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

blk_zone_wplug_handle_zone_mgmt now only checks that zone reset and
zone finish operations are directed to a sequential write required
zone.  This has nothing to do with zone write plugs and is better
handled with other bio validity checks in submit_bio_noacct.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
---
 block/blk-core.c  |  9 ++++++++-
 block/blk-zoned.c | 19 -------------------
 2 files changed, 8 insertions(+), 20 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 365641266c9e..67cfd7bd8542 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -898,9 +898,16 @@ void submit_bio_noacct(struct bio *bio)
 			goto not_supported;
 		break;
 	case REQ_OP_ZONE_RESET:
+	case REQ_OP_ZONE_FINISH:
+		/*
+		 * Zone reset and zone finish operations do not apply to
+		 * conventional zones.
+		 */
+		if (!bdev_zone_is_seq(bio->bi_bdev, bio->bi_iter.bi_sector))
+			goto end_io;
+		break;
 	case REQ_OP_ZONE_OPEN:
 	case REQ_OP_ZONE_CLOSE:
-	case REQ_OP_ZONE_FINISH:
 	case REQ_OP_ZONE_RESET_ALL:
 		if (!bdev_is_zoned(bio->bi_bdev))
 			goto not_supported;
diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 3b7a5f2bdf98..a5afb842bf35 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -1574,21 +1574,6 @@ static void blk_zone_wplug_handle_native_zone_append(struct bio *bio)
 	disk_put_zone_wplug(zwplug);
 }
 
-static bool blk_zone_wplug_handle_zone_mgmt(struct bio *bio)
-{
-	if (bio_op(bio) != REQ_OP_ZONE_RESET_ALL &&
-	    !bdev_zone_is_seq(bio->bi_bdev, bio->bi_iter.bi_sector)) {
-		/*
-		 * Zone reset and zone finish operations do not apply to
-		 * conventional zones.
-		 */
-		bio_io_error(bio);
-		return true;
-	}
-
-	return false;
-}
-
 /**
  * blk_zone_plug_bio - Handle a zone write BIO with zone write plugging
  * @bio: The BIO being submitted
@@ -1635,10 +1620,6 @@ bool blk_zone_plug_bio(struct bio *bio, unsigned int nr_segs)
 	case REQ_OP_WRITE:
 	case REQ_OP_WRITE_ZEROES:
 		return blk_zone_wplug_handle_write(bio, nr_segs);
-	case REQ_OP_ZONE_RESET:
-	case REQ_OP_ZONE_FINISH:
-	case REQ_OP_ZONE_RESET_ALL:
-		return blk_zone_wplug_handle_zone_mgmt(bio);
 	default:
 		return false;
 	}
-- 
2.53.0

