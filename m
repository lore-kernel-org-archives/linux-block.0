Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA18156677
	for <linux-block@vger.kernel.org>; Mon, 28 Apr 2025 14:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745849423; cv=none; b=lD2MRT8z3gqIIL1g7nSi2p4Psu+9VVemhmXhQWxKFNUynzia3B7MHjl7n6zWCmE2kXnICxe9SC8GCEVMbIgDMUG3eIVDRN3gmZtHxbHL5Z+CSB5KyDTNBtNys6gYQa5gvtH1zfa7c/0W8DxezEQCUiGuS9IcjSDa0d/emGP8i4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745849423; c=relaxed/simple;
	bh=9zpWiSTyKmH5+kBlC1fVdcXbaraAEkYQB5AUW4+VNZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QkVws0+ZaYNp5m9PownZepyfm836pCuKMRemp6pMxEKwJ4RIJ3Trx11Isx6AdDdEkkrFY/xfKKJOa9tOpWRVJBhV01d3ZhlaXpkOzjd24MAqllC1x5mkmXgDPyrb9Gkq7G758PtNKkvBYgKj9DMz5B+u+uK0MXFTG92izebVmvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Mkb3D6wT; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Mkb3D6wT"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=5zT9IIWdVX3YKZjzYOMgc3f8Oof3hKxuxMa24fBj07c=; b=Mkb3D6wTTJKbMJknicA0Y8cjaP
	jgXbTS0hJ1qwWasz8Tnpzh3l87VOxtiB/K2Ni+bYiho74iktiR0mLlxBbSuw54ieV2AfFBZop61yo
	8CbQVoqmSsN3KYZww1fmDWcbYgve34g84sMMQe7V8Ysq9Em2Q/Jzl2tKQhUPNH9DQzOaN2bdI2cqr
	hKWZRfQQDFpLXBlezgMVYnA4iCZFDQyccC9gk58SaHmo8vP/GHLRGv9u7zGM9yh91xbHrlcYko4+c
	LG1d7K2gDSgCdaAYHI8cNxlwIf+l7ohpEBOCNMhtz39mI7X6q8sBeMrUJFUgdoLyyjwPBy9c5GA6C
	70HSw1/Q==;
Received: from [206.0.71.28] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9PBd-00000006aVR-2tCQ;
	Mon, 28 Apr 2025 14:10:22 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Yu Kuai <yukuai1@huaweicloud.com>
Cc: linux-block@vger.kernel.org,
	Yu Kuai <yukuai3@huawei.com>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 2/5] brd: remove the sector variable in brd_submit_bio
Date: Mon, 28 Apr 2025 07:09:48 -0700
Message-ID: <20250428141014.2360063-3-hch@lst.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250428141014.2360063-1-hch@lst.de>
References: <20250428141014.2360063-1-hch@lst.de>
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
Reviewed-by: Yu Kuai <yukuai3@huawei.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
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

