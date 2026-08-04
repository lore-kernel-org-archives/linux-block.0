Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98973DCDBC;
	Tue,  4 Aug 2026 12:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785847889; cv=none; b=nLXqKtLCRuupOj9XpmP9Hf8Vx6QPx6zG3aIr5yWlRIb1c019RSU/72YCCO6blgGFK8MT+1BvXsqAHoGiLGTMuZxB0Y+bcooOHioyPDmDBU4kXEOXPioQjzi9wYXXS3Wg37StYuaKjan1kvVrTXsIY+geCnMaAh/m8tMCr94nwBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785847889; c=relaxed/simple;
	bh=8XcqBLsIPlzn1BuIL1y343CHT/0METFcXTA3XQQzDkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UROE/8tEP0Xwe/0wpEkezzn4Tc7EoHoiOYRxKeApLZIky+JXdfJw3mveieODK6FjWMD4ig1Y+3nalRMsU0avAe0ij+y2BueSAWJTT+NqqzcUXjlbix/xS/IDHFoVdukkx9B3LZvd50Bc+Fth5Ip+jH6ec+yPNwxSHWNuXjqpvFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=1h6mUyiO; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="1h6mUyiO"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=kmp6uSGhLdwpc283eDcgOIspouZ8lDrmR4gUJ8ueVRc=; b=1h6mUyiONoBmRlrtJLsyBMnY45
	5Og3ocdL8jkip/ryuuXluGQPV/aOmEfb1Gn01XuwqD0PHC/e2fUa4kyLUEw27tbKbyqJfxyo5RBm4
	peOabVGLX45gSH7aO2j6e3+VDccWRb4nTiLI6iLaH5GNgQHSQdL6zvQmZqvj/TeUDvWw6Tx3g6fNA
	Tijvcq3NV7J603aSfedPL9PJgquI8CmYKVsexRrgAgg9X3BSPaeH3zyhy1RIkJYH6hT05idhzRWw9
	7nBgLoOCZs8OOBC5EdbZ6NxmE2jSK3OhWdYYsiNJG1ShQKm59kiytRPe1qWNruwm08Jrq0xO0tXmq
	88hDNc4A==;
Received: from [93.123.20.94] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wrEc5-00000001rCN-25BN;
	Tue, 04 Aug 2026 12:51:22 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	linux-block@vger.kernel.org,
	io-uring@vger.kernel.org
Subject: [PATCH 5/6] block: remove most blkdev_cmd_discard arguments
Date: Tue,  4 Aug 2026 05:50:21 -0700
Message-ID: <20260804125038.740388-6-hch@lst.de>
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

All other arguments can be derived from cmd, so do that to simplify the
calling convention.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
---
 block/ioctl.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/block/ioctl.c b/block/ioctl.c
index 3d4ea1537457..af2a897f13f9 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -887,14 +887,13 @@ static void bio_cmd_bio_end_io(struct bio *bio)
 	bio_put(bio);
 }
 
-static int blkdev_cmd_discard(struct io_uring_cmd *cmd,
-			      struct block_device *bdev,
-			      uint64_t start, uint64_t len, bool nowait)
+static int blkdev_cmd_discard(struct io_uring_cmd *cmd)
 {
 	struct blk_iou_cmd *bic = io_uring_cmd_to_pdu(cmd, struct blk_iou_cmd);
-	gfp_t gfp = nowait ? GFP_NOWAIT : GFP_KERNEL;
-	sector_t sector = start >> SECTOR_SHIFT;
-	sector_t nr_sects = len >> SECTOR_SHIFT;
+	struct block_device *bdev = I_BDEV(cmd->file->f_mapping->host);
+	gfp_t gfp = bic->nowait ? GFP_NOWAIT : GFP_KERNEL;
+	sector_t sector = bic->start >> SECTOR_SHIFT;
+	sector_t nr_sects = bic->len >> SECTOR_SHIFT;
 	struct bio *prev = NULL, *bio;
 	int err;
 
@@ -904,12 +903,12 @@ static int blkdev_cmd_discard(struct io_uring_cmd *cmd,
 		return -EBADF;
 	if (bdev_read_only(bdev))
 		return -EPERM;
-	err = blk_validate_byte_range(bdev, start, len);
+	err = blk_validate_byte_range(bdev, bic->start, bic->len);
 	if (err)
 		return err;
 
-	err = filemap_invalidate_pages(bdev->bd_mapping, start,
-					start + len - 1, nowait);
+	err = filemap_invalidate_pages(bdev->bd_mapping, bic->start,
+				       bic->start + bic->len - 1, bic->nowait);
 	if (err)
 		return err;
 
@@ -917,7 +916,7 @@ static int blkdev_cmd_discard(struct io_uring_cmd *cmd,
 		bio = blk_alloc_discard_bio(bdev, &sector, &nr_sects, gfp);
 		if (!bio)
 			break;
-		if (nowait) {
+		if (bic->nowait) {
 			/*
 			 * Don't allow multi-bio non-blocking submissions as
 			 * subsequent bios may fail but we won't get a direct
@@ -946,7 +945,6 @@ static int blkdev_cmd_discard(struct io_uring_cmd *cmd,
 
 int blkdev_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags)
 {
-	struct block_device *bdev = I_BDEV(cmd->file->f_mapping->host);
 	struct blk_iou_cmd *bic = io_uring_cmd_to_pdu(cmd, struct blk_iou_cmd);
 	u32 cmd_op = cmd->cmd_op;
 
@@ -967,8 +965,7 @@ int blkdev_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags)
 
 	switch (cmd_op) {
 	case BLOCK_URING_CMD_DISCARD:
-		return blkdev_cmd_discard(cmd, bdev, bic->start, bic->len,
-					  bic->nowait);
+		return blkdev_cmd_discard(cmd);
 	}
 	return -EINVAL;
 }
-- 
2.53.0

