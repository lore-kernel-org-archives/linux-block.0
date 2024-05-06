Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F48443ABC
	for <linux-block@vger.kernel.org>; Mon,  6 May 2024 04:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714969236; cv=none; b=NEHuoVF5WutxQXZ3QCZqlXcZFCw5zg1BYMMR36IvBOVUlE2lMRMqoKdENQBVZZa290u6t+HpgjCaXxd1eoldq+i4l3Xjv6ZJDtSyU2KwjknxLwtiwBJ4w9ZpShyZq6Ic2lQQVD6I2O/Zmm0nfn+kFpHSTaJfsJN1T6K9LCMYpPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714969236; c=relaxed/simple;
	bh=E0DYUDG4l9aEK60M12y3MAsyF1oy8ZxKY/5Si+eyptU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pr2mbsjoysNCQX71Vqm9nhMMmVOjpYBZgg9MFvockUi82GakXuRZzFf8zEKnjYMEGvA7mCriryPa8bMRnpAzgt63cNv9E0bcYrQbAZqttraJRC0275IDZRIdeMt4MQw1mg4kyeY8ZMxTnK7kEJo28VXV2MyhgZlpM16lBuZBG9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dcumZn/2; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dcumZn/2"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=R9xSF1MXch23RfbVp2uK3KxJeMtGVod4GHpDLdUAsLI=; b=dcumZn/2q0+oS7omkOnNRuH3vq
	ZzQU7rmXIawHnDFYu98HL9taGzk40PH1D0HNEEQ3EEdlVEKBpbMjepPD8JPYyi6nSejdt6Mn32eLS
	/k50IkuAw/Yy2Zf4scRM2WlGkf6wPx5eeGiVsq8u/OU77ViXVWQWluq3l1VEuK3f3P0Ho7hWr4UrF
	0QgVjpqkVALLyik1djY+n9/+Hq3/W6BrS+9tTN30wfitswz+Ju1qObUGYkh6dfPPXu7Lu921VX/JN
	Y1OdOWtwfCKCgzE+uPSwow9v7medFZn83u8M5+ClIHAlMhb64HGmAPa1Mq439Vigk+MwTS0BFaA9s
	BEVue0uw==;
Received: from [2001:4bb8:188:7ba8:c70:4a89:bc61:3] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s3pq6-000000060KQ-1bTG;
	Mon, 06 May 2024 04:20:34 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>,
	Conrad Meyer <conradmeyer@meta.com>,
	linux-block@vger.kernel.org
Subject: [PATCH 2/6] block: move discard checks into the ioctl handler
Date: Mon,  6 May 2024 06:20:23 +0200
Message-Id: <20240506042027.2289826-3-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240506042027.2289826-1-hch@lst.de>
References: <20240506042027.2289826-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Most bio operations get basic sanity checking in submit_bio and anything
more complicated than that is done in the callers.  Discards are a bit
different from that in that a lot of checking is done in
__blkdev_issue_discard, and the specific errnos for that are returned
to userspace.  Move the checks that require specific errnos to the ioctl
handler instead, and just leave the basic sanity checking in submit_bio
for the other handlers.  This introduces two changes in behavior:

 1) the logical block size alignment check of the start and len is lost
    for non-ioctl callers.
    This matches what is done for other operations including reads and
    writes.  We should probably verify this for all bios, but for now
    make discards match the normal flow.
 2) for non-ioctl callers all errors are reported on I/O completion now
    instead of synchronously.  Callers in general mostly ignore or log
    errors so this will actually simplify the code once cleaned up

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-lib.c | 13 -------------
 block/ioctl.c   |  7 +++++--
 2 files changed, 5 insertions(+), 15 deletions(-)

diff --git a/block/blk-lib.c b/block/blk-lib.c
index 7ec3e170e7f629..6e54ef140bab12 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -39,19 +39,6 @@ int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
 		sector_t nr_sects, gfp_t gfp_mask, struct bio **biop)
 {
 	struct bio *bio = *biop;
-	sector_t bs_mask;
-
-	if (bdev_read_only(bdev))
-		return -EPERM;
-	if (!bdev_max_discard_sectors(bdev))
-		return -EOPNOTSUPP;
-
-	bs_mask = (bdev_logical_block_size(bdev) >> 9) - 1;
-	if ((sector | nr_sects) & bs_mask)
-		return -EINVAL;
-
-	if (!nr_sects)
-		return -EINVAL;
 
 	while (nr_sects) {
 		sector_t req_sects =
diff --git a/block/ioctl.c b/block/ioctl.c
index 0c76137adcaaa5..03bcdf2783b508 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -95,6 +95,7 @@ static int compat_blkpg_ioctl(struct block_device *bdev,
 static int blk_ioctl_discard(struct block_device *bdev, blk_mode_t mode,
 		unsigned long arg)
 {
+	unsigned int bs_mask = bdev_logical_block_size(bdev) - 1;
 	uint64_t range[2];
 	uint64_t start, len;
 	struct inode *inode = bdev->bd_inode;
@@ -105,6 +106,8 @@ static int blk_ioctl_discard(struct block_device *bdev, blk_mode_t mode,
 
 	if (!bdev_max_discard_sectors(bdev))
 		return -EOPNOTSUPP;
+	if (bdev_read_only(bdev))
+		return -EPERM;
 
 	if (copy_from_user(range, (void __user *)arg, sizeof(range)))
 		return -EFAULT;
@@ -112,9 +115,9 @@ static int blk_ioctl_discard(struct block_device *bdev, blk_mode_t mode,
 	start = range[0];
 	len = range[1];
 
-	if (start & 511)
+	if (!len)
 		return -EINVAL;
-	if (len & 511)
+	if ((start | len) & bs_mask)
 		return -EINVAL;
 
 	if (start + len > bdev_nr_bytes(bdev))
-- 
2.39.2

