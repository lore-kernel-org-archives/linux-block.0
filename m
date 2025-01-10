Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507F4207E04
	for <linux-block@vger.kernel.org>; Fri, 10 Jan 2025 07:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736494686; cv=none; b=ub7DPsPVRJ8JHvRZRBD1hek19DdVcq+ZhLNu6Mhd+cohR2pJkWXn7zMVGSBUpqrXIVTYy0ySauRDqNUooyd4hRfXmahEKja1tGKdfG7HAL4CSBdmow3K1eE8j6Vl0ZoYOUsEO0R+hLxUkxe4Uk0kmB5m2yMREnS3OauJ0X34AUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736494686; c=relaxed/simple;
	bh=fwUiEUotSYYxZVBcBMctwTNQgs88VkGKfNj3lTd6jk8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RFkQv2PgjPQe5AlRbWOM2uA2+fzPRGVj3tT8CdtPdMlaSonqLNnebC+MLJ1aJOe/FkRxZw0N4woOw29kTqMtidm0zyYXVI4iCEu0DNQSCNAnAoo/r4kXCLRFIBMgsoNsKxOIrT4NSfyeCwHtUshQx550ENvMXaNvOyfY3zC7Jq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=IhUWewzQ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IhUWewzQ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=fBFw0G03it4OiNiy6X+kXPRWCZfiX1LeXRK/O8w7x3w=; b=IhUWewzQ20Ang1bE7vHz2yaKP4
	6XNYswC5TrL/J68qL/y54uWvMpmS2rO5EBrZLEOMaCq+UK6ZkXqAxf6HtL+RU+wq8Wv08yfq8u2jW
	kKt4SsAIzBJXyoUZDcQMqSwF9DORBv5973sedcfKuPhS5YhOoDyPW4Kri3wJlrdHVzgMPrAVI6V8G
	N9o6whccmxsUIa+Uqps92gQigKDmmtRVL6uYIQgyVEVqEObwxB/+xC5/JHtwsNHfoq24yEgVFr1a4
	VohiJGt/xyMTqTXfGsHy08+f3/QCNrojWhAkQ8l5Y1yJcxKWrfBcFHVEcWg4Nhlq3aLOChbniTaRm
	Laow9Bag==;
Received: from 2a02-8389-2341-5b80-76c3-a3dc-14f6-94e8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:76c3:a3dc:14f6:94e8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tW9am-0000000EOR4-2GSz;
	Fri, 10 Jan 2025 07:38:05 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Subject: [PATCH 3/8] loop: create a lo_can_use_dio helper
Date: Fri, 10 Jan 2025 08:37:33 +0100
Message-ID: <20250110073750.1582447-4-hch@lst.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250110073750.1582447-1-hch@lst.de>
References: <20250110073750.1582447-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Factor out a part of __loop_update_dio in preparation for further
refactoring.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/loop.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 0c7dfc6eee12..55bea9c95b45 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -182,26 +182,29 @@ static bool lo_bdev_can_use_dio(struct loop_device *lo,
 	return true;
 }
 
-static void __loop_update_dio(struct loop_device *lo, bool dio)
+static bool lo_can_use_dio(struct loop_device *lo)
 {
-	struct file *file = lo->lo_backing_file;
-	struct inode *inode = file->f_mapping->host;
-	struct block_device *backing_bdev = NULL;
-	bool use_dio;
+	struct inode *inode = lo->lo_backing_file->f_mapping->host;
+
+	if (!(lo->lo_backing_file->f_mode & FMODE_CAN_ODIRECT))
+		return false;
 
 	if (S_ISBLK(inode->i_mode))
-		backing_bdev = I_BDEV(inode);
-	else if (inode->i_sb->s_bdev)
-		backing_bdev = inode->i_sb->s_bdev;
+		return lo_bdev_can_use_dio(lo, I_BDEV(inode));
+	if (inode->i_sb->s_bdev)
+		return lo_bdev_can_use_dio(lo, inode->i_sb->s_bdev);
+	return true;
+}
 
-	use_dio = dio && (file->f_mode & FMODE_CAN_ODIRECT) &&
-		(!backing_bdev || lo_bdev_can_use_dio(lo, backing_bdev));
+static void __loop_update_dio(struct loop_device *lo, bool dio)
+{
+	bool use_dio = dio && lo_can_use_dio(lo);
 
 	if (lo->use_dio == use_dio)
 		return;
 
 	/* flush dirty pages before changing direct IO */
-	vfs_fsync(file, 0);
+	vfs_fsync(lo->lo_backing_file, 0);
 
 	/*
 	 * The flag of LO_FLAGS_DIRECT_IO is handled similarly with
-- 
2.45.2

