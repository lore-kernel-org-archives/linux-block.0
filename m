Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3039B16DC35;
	Mon,  1 Jul 2024 16:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719852762; cv=none; b=mEmPMlHzHAWJ4iXwzEJDP3XK56eX0vBFIDmU6fec3Ref9N3Tf4JF7TcPoI5SZHf8DLQtYvwTIFsoAaqItZQPBtgYlELGvtfQXbcZHIS7LOoB9Slb6ElKzF6TYij7bY7YD03ugn6IZruWTlqJ/44v9aHUUL7kFWEZ0lfolpG0HWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719852762; c=relaxed/simple;
	bh=VEMRQwfeIWs70rHujqfrqoaMQ9Uh6Mfmgvpl96QOpwM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QK6FtPek+anfOVHxYQGwRQA51ibCz2ZRSpOlO0n9/x67AU38IZSme79zsLzSbyIegoS3ruI0zDzS7aoshkHEi6aXhljvTbuCvypIg4XKV6Hs25u2xsod6Z5+4ixhBbcVwadoTLk3jXLIV/H69H5HXoTPuGknMbLqefgqgjCBpDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=3zbsQa4i; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="3zbsQa4i"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=Oqdc6V8xwAdvyBJbY3RHzAse+UGgP4u6Afcst4sdYMk=; b=3zbsQa4iYn/8FdgbtQAMm9GHjz
	/NqRlhiaxbEOMvyQOxPRJyhjZWOK81jVMi5yS/NGVCQBL5bi2vIK1TC1ba7mfkAZYGbfgaU0dV1Vy
	y95UDYEu0CrJMEckAwUXGp0c2EO/TjLGxGNphVFJIItIUMZZU9vGjm7yQh2VBXRkX73K9u9e8k9hV
	ooAYPwwWvYD+9la9ClcSV1kJGVNp4qmVF2pWusl4h2OY6BFXu4WJMmcd+vw3QZ6lVpDABotTft5ja
	GdvVI1MgC/51iCOSuni4G4WfwNlh4xa5G//R0z6xzVFtMHnP6yTksijHHA+QMEfqnx7/lP5TOW4Zt
	V0b6pxbg==;
Received: from 2a02-8389-2341-5b80-6bfa-ffbf-d1d1-ec94.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:6bfa:ffbf:d1d1:ec94] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOKGd-00000004Bdw-2AQA;
	Mon, 01 Jul 2024 16:52:40 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>,
	Conrad Meyer <conradmeyer@meta.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: [PATCH 04/10] blk-lib: check for kill signal in ioctl BLKSECDISCARD
Date: Mon,  1 Jul 2024 18:51:14 +0200
Message-ID: <20240701165219.1571322-5-hch@lst.de>
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

Secure Erase can access a significant capacity and take longer than the
user expected.  A user may change their mind about wanting to run that
command and attempt to kill the process and do something else with their
device. But since the task is uninterruptable, they have to wait for it
to finish, which could be many hours.

Open code blkdev_issue_secure_erase in the BLKSECDISCARD ioctl handler
and check for a fatal signal at each iteration so the user doesn't have
to wait for their regretted operation to complete naturally.

Heavily based on an earlier patch from Keith Busch.

Reported-by: Conrad Meyer <conradmeyer@meta.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/ioctl.c | 34 +++++++++++++++++++++++++++++++---
 1 file changed, 31 insertions(+), 3 deletions(-)

diff --git a/block/ioctl.c b/block/ioctl.c
index f53121edb9a15f..45668a21cdb374 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -164,6 +164,9 @@ static int blk_ioctl_secure_erase(struct block_device *bdev, blk_mode_t mode,
 		void __user *argp)
 {
 	unsigned int bs_mask = bdev_logical_block_size(bdev) - 1;
+	struct bio *prev = NULL, *bio;
+	sector_t sector, nr_sects;
+	struct blk_plug plug;
 	uint64_t start, len;
 	uint64_t range[2];
 	int err;
@@ -187,11 +190,36 @@ static int blk_ioctl_secure_erase(struct block_device *bdev, blk_mode_t mode,
 	if (start + len > bdev_nr_bytes(bdev))
 		return -EINVAL;
 
+	sector = start >> SECTOR_SHIFT;
+	nr_sects = len >> SECTOR_SHIFT;
+
 	filemap_invalidate_lock(bdev->bd_mapping);
 	err = truncate_bdev_range(bdev, mode, start, start + len - 1);
-	if (!err)
-		err = blkdev_issue_secure_erase(bdev, start >> 9, len >> 9,
-						GFP_KERNEL);
+	if (err)
+		goto out_unlock;
+
+	blk_start_plug(&plug);
+	while (1) {
+		if (fatal_signal_pending(current)) {
+			if (prev)
+				bio_await_chain(prev);
+			err = -EINTR;
+			goto out_unplug;
+		}
+		bio = blk_alloc_secure_erase_bio(bdev, &sector, &nr_sects,
+				GFP_KERNEL);
+		if (!bio)
+			break;
+		prev = bio_chain_and_submit(prev, bio);
+	}
+	if (prev) {
+		err = submit_bio_wait(prev);
+		bio_put(prev);
+	}
+
+out_unplug:
+	blk_finish_plug(&plug);
+out_unlock:
 	filemap_invalidate_unlock(bdev->bd_mapping);
 	return err;
 }
-- 
2.43.0

