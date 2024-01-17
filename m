Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED4F22EE3
	for <linux-block@vger.kernel.org>; Wed, 17 Jan 2024 17:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705514348; cv=none; b=CyK3DzyCuD/VE5xL3eMY8F4/RtSR2gHmh+2HRxbfN5EzpBCyt1WiVUPMLVf8RUSjmkwij+hUM15upmcGxRanFry5z59CrH4YDny3y6P1m5pKp/g7xxcVMZwsmoCtQtYP84SD2eQsayNnQ+KxGJIoeE/g9yjA2rLeAEygvb08KLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705514348; c=relaxed/simple;
	bh=DfV4loBRJ5ZNsLhYr2lFriXjb/0lyYbaOkTKhUdkm9o=;
	h=DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-SRS-Rewrite; b=T5qwt6WoNpy5Wwk2Tpkc7Pe0lYTqqsegzCwdfm1c4gZi4EV16hVUFfs+nwm0M1L3PRWeMdHmBaZ40B7MMvDwHRh0lWJHK8fLL5FfSDgOtLo+97TEBoza/t3LUklCyFYZIi8bZMvzd4RAitIGdAw4K1oeX590YFGVGSbYhYDeAJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=slm/D/Ni; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="slm/D/Ni"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=VCXHlry+DsluVv40kJQKXdVEswPXHTpK1oXC0y2Oxys=; b=slm/D/Nicy8lKGS4b/YPN9QNk1
	D2ZnhogViv9RoyFjviF7cmbs30mU+bQ5vJADKMqunN85vw/ZVgi/1+2E0SChcFh+s89ge6Uo4nsxR
	eL2ROvAdbt6tMorV4Mh5eD5JNKaYNSUL9wd6isrTZDOTBF5B2o79XR1MNfcqHqsp/pioA5SUtYh9h
	JwSqngsF2ZDrmssbbt8IcT+C7bkErMq2vYsf5/EBfylOP0yqx82AS0sMEhkanqYIAFSHjP1O9hKVD
	FWry177gS888zFFx53pzmr8TUL1lZgSkXE/bTwGLVqqW9rE31YAc/d3NucGvVb6bkQsMq0V2npo/W
	Uu5hD16w==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rQABs-000I8d-0a;
	Wed, 17 Jan 2024 17:59:04 +0000
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: ming.lei@redhat.com,
	linux-block@vger.kernel.org
Subject: [PATCH] loop: fix the the direct I/O support check when used on top of block devices
Date: Wed, 17 Jan 2024 18:59:01 +0100
Message-Id: <20240117175901.871796-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

__loop_update_dio only checks the alignment requirement for block backed
file systems, but misses them for the case where the loop device is
created directly on top of another block device.  Due to this creating
a loop device with default option plus the direct I/O flag on a > 512 byte
sector size file system will lead to incorrect I/O being submitted to the
lower block device and a lot of error from the lock layer.  This can
be seen with xfstests generic/563.

Fix the code in __loop_update_dio by factoring the alignment check into
a helper, and calling that also for the struct block_device of a block
device inode.

Also remove the TODO comment talking about dynamically switching between
buffered and direct I/O, which is a would be a recipe for horrible
performance and occasional data loss.

Fixes: 2e5ab5f379f9 ("block: loop: prepare for supporing direct IO")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/loop.c | 52 +++++++++++++++++++++-----------------------
 1 file changed, 25 insertions(+), 27 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 2bd10f3bfcb296..01bb9436240484 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -165,39 +165,37 @@ static loff_t get_loop_size(struct loop_device *lo, struct file *file)
 	return get_size(lo->lo_offset, lo->lo_sizelimit, file);
 }
 
+/*
+ * We support direct I/O only if lo_offset is aligned with the logical I/O size
+ * of backing device, and the logical block size of loop is bigger than that of
+ * the backing device.
+ */
+static bool lo_bdev_can_use_dio(struct loop_device *lo,
+		struct block_device *backing_bdev)
+{
+	unsigned short sb_bsize = bdev_logical_block_size(backing_bdev);
+
+	if (queue_logical_block_size(lo->lo_queue) < sb_bsize)
+		return false;
+	if (lo->lo_offset & (sb_bsize - 1))
+		return false;
+	return true;
+}
+
 static void __loop_update_dio(struct loop_device *lo, bool dio)
 {
 	struct file *file = lo->lo_backing_file;
-	struct address_space *mapping = file->f_mapping;
-	struct inode *inode = mapping->host;
-	unsigned short sb_bsize = 0;
-	unsigned dio_align = 0;
+	struct inode *inode = file->f_mapping->host;
+	struct block_device *backing_bdev = NULL;
 	bool use_dio;
 
-	if (inode->i_sb->s_bdev) {
-		sb_bsize = bdev_logical_block_size(inode->i_sb->s_bdev);
-		dio_align = sb_bsize - 1;
-	}
+	if (S_ISBLK(inode->i_mode))
+		backing_bdev = I_BDEV(inode);
+	else if (inode->i_sb->s_bdev)
+		backing_bdev = inode->i_sb->s_bdev;
 
-	/*
-	 * We support direct I/O only if lo_offset is aligned with the
-	 * logical I/O size of backing device, and the logical block
-	 * size of loop is bigger than the backing device's.
-	 *
-	 * TODO: the above condition may be loosed in the future, and
-	 * direct I/O may be switched runtime at that time because most
-	 * of requests in sane applications should be PAGE_SIZE aligned
-	 */
-	if (dio) {
-		if (queue_logical_block_size(lo->lo_queue) >= sb_bsize &&
-		    !(lo->lo_offset & dio_align) &&
-		    (file->f_mode & FMODE_CAN_ODIRECT))
-			use_dio = true;
-		else
-			use_dio = false;
-	} else {
-		use_dio = false;
-	}
+	use_dio = dio && (file->f_mode & FMODE_CAN_ODIRECT) &&
+		(!backing_bdev || lo_bdev_can_use_dio(lo, backing_bdev));
 
 	if (lo->use_dio == use_dio)
 		return;
-- 
2.39.2

