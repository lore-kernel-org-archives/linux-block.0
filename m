Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197B61ACEAC
	for <linux-block@vger.kernel.org>; Fri, 31 Jan 2025 12:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738324889; cv=none; b=edFJKWJ0E9CA0FXWfhyzlP+4+ug5zvX8X3VSdRKl688lTaKzDCxloSy+vCoInlp/xfn5o39MhOxyFsEviHzSe05N3ZgFSL0JrD9WD2/n1CUxkIqOhIQD0XlqSEYttHAyofMlcz6/4hbiPhFPsC17ZznlT1HKG42Lko3uxg/lL5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738324889; c=relaxed/simple;
	bh=J4lSUVoBnwYAsLqKJJxQMjM7uNoDKuuCFOoVXoYZE1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VedsApWBKIfmP6kmLpKwplZmybVTkCnKFcFeZN1xTEz9ktgg/wVtLnE6/0NN0EqDVbvjFR4y4kAfkvp4lODGTfAlxiUfY6Z9G3V4D0rox6XOqv900AEso1N2NZ1JEklUYUx7eLDlwyMdnkgivbaC0aiBAO+2N6niAKHMExN1HrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hVKAMcBe; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hVKAMcBe"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=rvuWOBK87ohTQCVy86FKvupTdhgrzXF+EJeoLIFFd6A=; b=hVKAMcBeav+Dodi86uW5Pbbp4R
	XtLzM5XG2zZMDSN8f/E9WVJxIS8cTi97RiDUnB+fPGUJHiLYeAP0sNfS9T2bWgiM+RWqapv1lTSAh
	nNug2uQctqeQsE02UsMhrak6Nx5r0V7iY9LfaF2QV5qwKGsvfXGKOTG4Yh1M46ENR+xDpshuIAfMS
	grcwBIhNlC4wME2ke0RhyTepMXYWb43djiDMG4o27zOYKGt1bRlU+RKhHbvJ55XhX/rGrQeV4E9aT
	fF3JDOkEfSC3Kib2jQ3VjiWTHBshkCy4ptGL0Rhra/qwosdVq8J7ArOayubY1wypdo2PByz3l0chq
	dUVl8oMw==;
Received: from 2a02-8389-2341-5b80-85a0-dd45-e939-a129.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:85a0:dd45:e939:a129] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tdpiB-0000000AZCC-0Rtp;
	Fri, 31 Jan 2025 12:01:27 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	linux-block@vger.kernel.org
Subject: [PATCH 1/4] loop: factor out a loop_assign_backing_file helper
Date: Fri, 31 Jan 2025 13:00:38 +0100
Message-ID: <20250131120120.1315125-2-hch@lst.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250131120120.1315125-1-hch@lst.de>
References: <20250131120120.1315125-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Split the code for setting up a backing file into a helper in preparation
of adding more code to this path.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/loop.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 1ec7417c7f00..85a6aa551bb5 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -573,6 +573,14 @@ static int loop_validate_file(struct file *file, struct block_device *bdev)
 	return 0;
 }
 
+static void loop_assign_backing_file(struct loop_device *lo, struct file *file)
+{
+	lo->lo_backing_file = file;
+	lo->old_gfp_mask = mapping_gfp_mask(file->f_mapping);
+	mapping_set_gfp_mask(file->f_mapping,
+			lo->old_gfp_mask & ~(__GFP_IO | __GFP_FS));
+}
+
 /*
  * loop_change_fd switched the backing store of a loopback device to
  * a new file. This is useful for operating system installers to free up
@@ -625,10 +633,7 @@ static int loop_change_fd(struct loop_device *lo, struct block_device *bdev,
 	disk_force_media_change(lo->lo_disk);
 	blk_mq_freeze_queue(lo->lo_queue);
 	mapping_set_gfp_mask(old_file->f_mapping, lo->old_gfp_mask);
-	lo->lo_backing_file = file;
-	lo->old_gfp_mask = mapping_gfp_mask(file->f_mapping);
-	mapping_set_gfp_mask(file->f_mapping,
-			     lo->old_gfp_mask & ~(__GFP_IO|__GFP_FS));
+	loop_assign_backing_file(lo, file);
 	loop_update_dio(lo);
 	blk_mq_unfreeze_queue(lo->lo_queue);
 	partscan = lo->lo_flags & LO_FLAGS_PARTSCAN;
@@ -1018,7 +1023,6 @@ static int loop_configure(struct loop_device *lo, blk_mode_t mode,
 			  const struct loop_config *config)
 {
 	struct file *file = fget(config->fd);
-	struct address_space *mapping;
 	struct queue_limits lim;
 	int error;
 	loff_t size;
@@ -1054,8 +1058,6 @@ static int loop_configure(struct loop_device *lo, blk_mode_t mode,
 	if (error)
 		goto out_unlock;
 
-	mapping = file->f_mapping;
-
 	if ((config->info.lo_flags & ~LOOP_CONFIGURE_SETTABLE_FLAGS) != 0) {
 		error = -EINVAL;
 		goto out_unlock;
@@ -1087,9 +1089,7 @@ static int loop_configure(struct loop_device *lo, blk_mode_t mode,
 	set_disk_ro(lo->lo_disk, (lo->lo_flags & LO_FLAGS_READ_ONLY) != 0);
 
 	lo->lo_device = bdev;
-	lo->lo_backing_file = file;
-	lo->old_gfp_mask = mapping_gfp_mask(mapping);
-	mapping_set_gfp_mask(mapping, lo->old_gfp_mask & ~(__GFP_IO|__GFP_FS));
+	loop_assign_backing_file(lo, file);
 
 	lim = queue_limits_start_update(lo->lo_queue);
 	loop_update_limits(lo, &lim, config->block_size);
-- 
2.45.2

