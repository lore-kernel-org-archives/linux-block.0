Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C9E20CCE4
	for <linux-block@vger.kernel.org>; Mon, 21 Apr 2025 07:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745220424; cv=none; b=uX8T7NYl04M0XsdgAtsFzQo4u+/YKWN5gyaSCOeGaVNj3GqEHLNn3vlHsYcd/hvlKdNkEpRaHSLhpmGTokB/EynC0qcoT2rdArrrpAmwX+A0QWAA1RiHSc1RB8q62zAx5F03Tp/CfCQIhOf/1Mkr7KAiBEd5EyEAmZmsjzbH7IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745220424; c=relaxed/simple;
	bh=xf0hMXKm+8pRfWU1prmEsGzHzuVzoA7njnLniFzFvLc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p43y3fRRIlxV7TAmvRzaNDdiXeer+Qwaiq0YdZ42wyoOb+SIXyL0aGlhcmCefa/tkYJn5rOVcrg5z97xGFKQwETJoxtsyFvcOIn/OZaDa4L/bJ7u8i4Y2ecyp9WwrFiYrAa5DDNzRZCKFMlAxehrFeagd2a3VINQs47+1bLrikM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=FW5LekZD; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FW5LekZD"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=CguZ1bz6kCHB1M8B4SSjaVzEPgwP4KTjDyIFkD+AvxI=; b=FW5LekZDVhJlYkND6NbhOFXeGe
	/yVzEaNvvf5Y/sgY5qqbD7xyWv9oMM2W1bk94B1ZQDsxFelybsu/E5cUuZrB85nXnvcoDldnkdtVT
	+X3MrVShP8zctn+N34aacGJ6zHdiF2yveCdNVKS0uKqEUZOIyvoFgPlKrPnjS9UwBn1DnuZkf40Vp
	C9PRUJHne06ndWx9Shnancnl9qYYgBuxmWsOE2YZHpfjZ7BkAqKdAJvq6KojezZQAAA8dRTsIHh/l
	ev3Gei6pF6lc8jkPPc+UE1wFzoKeGBVn9nuPxBSsv5ZNEYWHiBdUHCqC6tU/ecbyYNgbtkW5bHtMy
	03MxRwHQ==;
Received: from [213.208.157.109] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u6lYR-00000003n34-3dsO;
	Mon, 21 Apr 2025 07:27:01 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Yu Kuai <yukuai1@huaweicloud.com>
Cc: linux-block@vger.kernel.org
Subject: [PATCH 2/5] brd: remove the sector variable in brd_submit_bio
Date: Mon, 21 Apr 2025 09:26:06 +0200
Message-ID: <20250421072641.1311040-3-hch@lst.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250421072641.1311040-1-hch@lst.de>
References: <20250421072641.1311040-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

The bvec iter iterates over the sector already, no need to duplicate the
work.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/brd.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/block/brd.c b/drivers/block/brd.c
index c8974bc545fb..91eb50126355 100644
--- a/drivers/block/brd.c
+++ b/drivers/block/brd.c
@@ -241,12 +241,12 @@ static void brd_do_discard(struct brd_device *brd, sector_t sector, u32 size)
 static void brd_submit_bio(struct bio *bio)
 {
 	struct brd_device *brd = bio->bi_bdev->bd_disk->private_data;
-	sector_t sector = bio->bi_iter.bi_sector;
 	struct bio_vec bvec;
 	struct bvec_iter iter;
 
 	if (unlikely(op_is_discard(bio->bi_opf))) {
-		brd_do_discard(brd, sector, bio->bi_iter.bi_size);
+		brd_do_discard(brd, bio->bi_iter.bi_sector,
+				bio->bi_iter.bi_size);
 		bio_endio(bio);
 		return;
 	}
@@ -254,7 +254,7 @@ static void brd_submit_bio(struct bio *bio)
 	bio_for_each_segment(bvec, bio, iter) {
 		int err;
 
-		err = brd_rw_bvec(brd, &bvec, bio->bi_opf, sector);
+		err = brd_rw_bvec(brd, &bvec, bio->bi_opf, iter.bi_sector);
 		if (err) {
 			if (err == -ENOMEM && bio->bi_opf & REQ_NOWAIT) {
 				bio_wouldblock_error(bio);
@@ -263,7 +263,6 @@ static void brd_submit_bio(struct bio *bio)
 			bio_io_error(bio);
 			return;
 		}
-		sector += bvec.bv_len >> SECTOR_SHIFT;
 	}
 
 	bio_endio(bio);
-- 
2.47.2

