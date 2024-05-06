Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6DA43AD4
	for <linux-block@vger.kernel.org>; Mon,  6 May 2024 04:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714969247; cv=none; b=ks0cJA8KKLyuTwQF2AqK+lgIrLg/YPGyPbG2iybpYLZw5GqKzphD5hcUYGnl3vdOsckAM958qPj/5TTLQjKG7A6MIRIxVDdn45EJda6fV97LFTWwsFNke+OwCV56X5h0st9tbcLd4yoKksE1C+UNm690HHIxPcQys1IlZJwnBRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714969247; c=relaxed/simple;
	bh=/2tBtxZzSDxn5DgC3zUtJp9JJrlJvFs0jB1tGkV3u+A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a8HNEt1ByV7mChJ9GRvNzOQ7NXg6fqqsfVFrH4CAMMbpSpwrj6tfXnPXTJHvgpaJ0w61sVcSNKNGXW88YwFYcw/ClfflpcixciThs5gfMbAkpfeHxLvbHYG8EY0uruYY1ucFV53IdjVgNafyIaoNjV6KNNHaAjE2A24mFSJkq9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fWadFoyo; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fWadFoyo"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=ICzvPLnKCjqbvrzst2txWHdjNu7MZMnaZDVGNIQ6QRU=; b=fWadFoyohaHY1Ew0WRdGfwxYkl
	uTlznNb0AM6aFtg0Z/Ef8FvziF+tO5n/lEcSwPtSfNgVLNKjJ0QY80YkexKLjPRpfHjVM1z/Dz8zi
	8VznWMQBtpAe0hp7jLYWlBgvEuKwwu0RZn/+AkxpK42bfyGipuc87pJziyt0hhq8C4d0y7ghXTnZB
	CKvz/BoFIhIvL4oW6IQjH/nKZZigz9Bm2s44wSKyRm2IIOlBa56ohE6Fhu/edC021tDWlsxYlf4d4
	wrYPx6kLbGXSsbj/Kz/1KtpxtQvmyLn1pKP6L41krlpVd5JAITSP9tvYfQH6tF/kVfqQPaGshggck
	+T94HDSA==;
Received: from [2001:4bb8:188:7ba8:c70:4a89:bc61:3] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s3pqG-000000060Nd-21HP;
	Mon, 06 May 2024 04:20:45 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>,
	Conrad Meyer <conradmeyer@meta.com>,
	linux-block@vger.kernel.org
Subject: [PATCH 6/6] blk-lib: check for kill signal in ioctl BLKDISCARD
Date: Mon,  6 May 2024 06:20:27 +0200
Message-Id: <20240506042027.2289826-7-hch@lst.de>
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

Discards can access a significant capacity and take longer than the user
expected.  A user may change their mind about wanting to run that command
and attempt to kill the process and do something else with their device.
But since the task is uninterruptable, they have to wait for it to
finish, which could be many hours.

Open code blkdev_issue_discard in the BLKDISCARD ioctl handler and check
for a fatal signal at each iteration so the user doesn't have to wait
for their regretted operation to complete naturally.

Heavily based on an earlier patch from Keith Busch.

Reported-by: Conrad Meyer <conradmeyer@meta.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/ioctl.c | 33 ++++++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/block/ioctl.c b/block/ioctl.c
index 03bcdf2783b508..003d134779db56 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -96,9 +96,11 @@ static int blk_ioctl_discard(struct block_device *bdev, blk_mode_t mode,
 		unsigned long arg)
 {
 	unsigned int bs_mask = bdev_logical_block_size(bdev) - 1;
-	uint64_t range[2];
-	uint64_t start, len;
 	struct inode *inode = bdev->bd_inode;
+	uint64_t range[2], start, len;
+	struct bio *prev = NULL, *bio;
+	sector_t sector, nr_sects;
+	struct blk_plug plug;
 	int err;
 
 	if (!(mode & BLK_OPEN_WRITE))
@@ -127,7 +129,32 @@ static int blk_ioctl_discard(struct block_device *bdev, blk_mode_t mode,
 	err = truncate_bdev_range(bdev, mode, start, start + len - 1);
 	if (err)
 		goto fail;
-	err = blkdev_issue_discard(bdev, start >> 9, len >> 9, GFP_KERNEL);
+
+	sector = start >> SECTOR_SHIFT;
+	nr_sects = len >> SECTOR_SHIFT;
+
+	blk_start_plug(&plug);
+	while (1) {
+		if (fatal_signal_pending(current)) {
+			if (prev)
+				bio_await_chain(prev);
+			err = -EINTR;
+			goto out_unplug;
+		}
+		bio = blk_alloc_discard_bio(bdev, &sector, &nr_sects,
+				GFP_KERNEL);
+		if (!bio)
+			break;
+		prev = bio_chain_and_submit(prev, bio);
+	}
+	if (prev) {
+		err = submit_bio_wait(prev);
+		if (err == -EOPNOTSUPP)
+			err = 0;
+		bio_put(prev);
+	}
+out_unplug:
+	blk_finish_plug(&plug);
 fail:
 	filemap_invalidate_unlock(inode->i_mapping);
 	return err;
-- 
2.39.2

