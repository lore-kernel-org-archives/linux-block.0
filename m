Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E020847C;
	Fri, 20 Sep 2024 00:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726793307; cv=none; b=NMpJVgXSEs9hLtuCFyggslLbNwDnwpu7H77Ati0TUOjFqqglRhZUEnUZuY7hqN2m7atWcNDpBIL7MvuL8IhkVvqIfXumfEKtzktdhHdFob1Ea6DGbBpgZpnImrhhciaMe8hwL/A6rWUpvRPuYML4rI80p2zomlZsZCy1a06qIPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726793307; c=relaxed/simple;
	bh=1125Bsn3gcNwrrK/s5iBw/szpxMx/ayHRV9SLDByiss=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eKFDYWIMY2/9R6BU69znJqDI8hLZOUSZri4QxwXXtsz5PcsEO0QzUW69Bed7pye1m24DN0L3Y114RqltlSxsH4njQaGGBGFJKQDxyDSmtDmM2d1O5PYZVz03UGEnD7a/gdTCpS+bHICU0ryxN+ybX4QB9CjSgAyYD1/3DchRTSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=B05KZrDn; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="B05KZrDn"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=wPfdNjbocK7zlRp7BCVRqJV1USyrv++jXmHPMXQ+sAQ=; b=B05KZrDnZm9U2lPj
	mLxF/81X4ckU0MHIPtQv0/6oss4EOO3Ze5zE4iTin9pTaVr/QetiT5I8wz0OdGNaxrH5VHxaqSFYm
	zAX42YczA4lHpVCTT8erKDJb0NFlj2B59bDwy6M1ZnvwBvIJdUwYHdHaDrcnVjhHmXY78ch6iK7rj
	PyFd1NOqWsRC91gEVj3/f9rlmwFKMVAItW0HxkNrNuDhSkfYw1mWSnxxtFozfTk+lFRE5xL4eMXOI
	XYOPmtShHl0sjTGmucNCkptp26z4H+GlUGsjSWysMugQY9zEB2WmeO9nMEAMk/3x+NJzC7Zl82C0E
	TRNeQ66rZ1YEde2fmw==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1srRoo-006UPh-2n;
	Fri, 20 Sep 2024 00:48:18 +0000
From: linux@treblig.org
To: axboe@kernel.dk,
	hch@lst.de
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] block: Remove unused blk_limits_io_{min,opt}
Date: Fri, 20 Sep 2024 01:48:17 +0100
Message-ID: <20240920004817.676216-1-linux@treblig.org>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

blk_limits_io_min and blk_limits_io_opt are unused since the
recent commit
  0a94a469a4f0 ("dm: stop using blk_limits_io_{min,opt}")

Remove them.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 block/blk-settings.c   | 42 ------------------------------------------
 include/linux/blkdev.h |  2 --
 2 files changed, 44 deletions(-)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index cd8a8eabc9a5..a446654ddee5 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -437,48 +437,6 @@ int queue_limits_set(struct request_queue *q, struct queue_limits *lim)
 }
 EXPORT_SYMBOL_GPL(queue_limits_set);
 
-/**
- * blk_limits_io_min - set minimum request size for a device
- * @limits: the queue limits
- * @min:  smallest I/O size in bytes
- *
- * Description:
- *   Some devices have an internal block size bigger than the reported
- *   hardware sector size.  This function can be used to signal the
- *   smallest I/O the device can perform without incurring a performance
- *   penalty.
- */
-void blk_limits_io_min(struct queue_limits *limits, unsigned int min)
-{
-	limits->io_min = min;
-
-	if (limits->io_min < limits->logical_block_size)
-		limits->io_min = limits->logical_block_size;
-
-	if (limits->io_min < limits->physical_block_size)
-		limits->io_min = limits->physical_block_size;
-}
-EXPORT_SYMBOL(blk_limits_io_min);
-
-/**
- * blk_limits_io_opt - set optimal request size for a device
- * @limits: the queue limits
- * @opt:  smallest I/O size in bytes
- *
- * Description:
- *   Storage devices may report an optimal I/O size, which is the
- *   device's preferred unit for sustained I/O.  This is rarely reported
- *   for disk drives.  For RAID arrays it is usually the stripe width or
- *   the internal track size.  A properly aligned multiple of
- *   optimal_io_size is the preferred request size for workloads where
- *   sustained throughput is desired.
- */
-void blk_limits_io_opt(struct queue_limits *limits, unsigned int opt)
-{
-	limits->io_opt = opt;
-}
-EXPORT_SYMBOL(blk_limits_io_opt);
-
 static int queue_limit_alignment_offset(const struct queue_limits *lim,
 		sector_t sector)
 {
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 643c9020a35a..50c3b959da28 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -968,8 +968,6 @@ static inline void blk_queue_disable_write_zeroes(struct request_queue *q)
 /*
  * Access functions for manipulating queue properties
  */
-extern void blk_limits_io_min(struct queue_limits *limits, unsigned int min);
-extern void blk_limits_io_opt(struct queue_limits *limits, unsigned int opt);
 extern void blk_set_queue_depth(struct request_queue *q, unsigned int depth);
 extern void blk_set_stacking_limits(struct queue_limits *lim);
 extern int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
-- 
2.46.1

