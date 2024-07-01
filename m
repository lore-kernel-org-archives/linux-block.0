Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2F616DC39;
	Mon,  1 Jul 2024 16:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719852752; cv=none; b=kRvhTCzE30b+JGkjB20ybvvGcFavLKVMC6nR+Jt8JUwiTytjtVM4/n0B/Vq5m3qo/x2zVTW4y8zNDSb1o96AFTHkvvwznDky+m7WXgzfBdSskSwmtzDX0Kty/YO9MDHtGD8hv6/nMJvxwfJ0hV3I9OHN89VNk8uyDMV5IWHMKLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719852752; c=relaxed/simple;
	bh=Z1Z+c7oX0SXs1iAkR0IHpp7OVbRRdK9czuSKENBknOY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A6SoVOXy5l4fyRUsE/qZyQX4ruG6S9u7s8C84VVbcf56nP2i+RwKYpH8gMNOUEmozzS+gzlk9qmahntd8CMPSJd2QBXzT4QhUQMiKCjz1iUVUYCm0/2oEd1+4E1LkIPv/TxuDRDl0Ev2OeDz1Q7DXiR8WQbNteCmyY3o7R+ehUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=tJrGTkEU; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tJrGTkEU"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=NVVaxtBxinuCwMKgz8pxtUN+Le0Sbdm4BC3SfXv8GYA=; b=tJrGTkEUv9bPIWdi66FnNiyPtD
	xcpCjQblXfGi2zsYnlUFn/pvxzjiBURa1VUjeNB/oOS1JZKQAOeIv8ymumKKcJxHYKXddItCS1mrb
	0ABvkRH1a/pDcgGGFTDgSxJtCPVFfpyOpKrpzOBrYiak8nm21wp+oJ2CKx2Ja65PIQ4tMHyd1HHoM
	qk9JIk4960OBtahU55B68PMuiXjIOGvzqOFWLZ7z/ZIsKT3K/V0xwXxTP3SJaoZlRTbM1c9PD8Qrb
	qgNHFVO3BH37WCbcRtvk1qdlWpJuvDG52CuqCTayZEucw1zHQalhMXSYY/HnrHxHBS1p6d0W5C5P9
	wABRqtSQ==;
Received: from 2a02-8389-2341-5b80-6bfa-ffbf-d1d1-ec94.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:6bfa:ffbf:d1d1:ec94] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOKGR-00000004BYA-3XIu;
	Mon, 01 Jul 2024 16:52:28 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>,
	Conrad Meyer <conradmeyer@meta.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: [PATCH 01/10] block: move secure erase checks into the ioctl handler
Date: Mon,  1 Jul 2024 18:51:11 +0200
Message-ID: <20240701165219.1571322-2-hch@lst.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240701165219.1571322-1-hch@lst.de>
References: <20240701165219.1571322-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Most bio operations get basic sanity checking in submit_bio and anything
more complicated than that is done in the callers.  Secure erase is a bit
different from that in that a lot of checking is done in
blkdev_issue_secure_erase, and the specific errnos for that are returned
to userspace.  Move the checks that require specific errnos to the ioctl
handler instead, and just leave the basic sanity checking in submit_bio

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-lib.c | 7 -------
 block/ioctl.c   | 8 +++++++-
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/block/blk-lib.c b/block/blk-lib.c
index 442da9dad04213..4aabfc4a7eaa20 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -299,13 +299,6 @@ int blkdev_issue_secure_erase(struct block_device *bdev, sector_t sector,
 		max_sectors = UINT_MAX >> SECTOR_SHIFT;
 	max_sectors &= ~bs_mask;
 
-	if (max_sectors == 0)
-		return -EOPNOTSUPP;
-	if ((sector | nr_sects) & bs_mask)
-		return -EINVAL;
-	if (bdev_read_only(bdev))
-		return -EPERM;
-
 	blk_start_plug(&plug);
 	while (nr_sects) {
 		unsigned int len = min_t(sector_t, nr_sects, max_sectors);
diff --git a/block/ioctl.c b/block/ioctl.c
index d570e16958961e..f53121edb9a15f 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -163,6 +163,7 @@ static int blk_ioctl_discard(struct block_device *bdev, blk_mode_t mode,
 static int blk_ioctl_secure_erase(struct block_device *bdev, blk_mode_t mode,
 		void __user *argp)
 {
+	unsigned int bs_mask = bdev_logical_block_size(bdev) - 1;
 	uint64_t start, len;
 	uint64_t range[2];
 	int err;
@@ -171,12 +172,17 @@ static int blk_ioctl_secure_erase(struct block_device *bdev, blk_mode_t mode,
 		return -EBADF;
 	if (!bdev_max_secure_erase_sectors(bdev))
 		return -EOPNOTSUPP;
+	if (bdev_read_only(bdev))
+		return -EPERM;
 	if (copy_from_user(range, argp, sizeof(range)))
 		return -EFAULT;
 
 	start = range[0];
 	len = range[1];
-	if ((start & 511) || (len & 511))
+
+	if (!len)
+ 		return -EINVAL;
+	if ((start | len) & bs_mask)
 		return -EINVAL;
 	if (start + len > bdev_nr_bytes(bdev))
 		return -EINVAL;
-- 
2.43.0

