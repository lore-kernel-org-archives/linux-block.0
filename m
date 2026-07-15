Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB55D25B088
	for <linux-block@vger.kernel.org>; Wed, 15 Jul 2026 06:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784097467; cv=none; b=Ffox4o2w8kJNPJ05/bWTAzFRcI/JnWKhVIIla+YQ5edKbswsRpzlqw7uJ09xabEDTKqJLyAbWk80utZCmkH+fHGBb/n+NNt2jDLq7KiYyVb0hcbytnhqfqPSfrYRY6f0B16KNIHZwk/OObNocAt+llkU+n/KpE6ksIY87fpQhaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784097467; c=relaxed/simple;
	bh=VUT6dB+EaH1o/FnDqcKkXAc2Oy1jLyEZXT4HHZmPb1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r2exgKJgsT3dxzZBSHVNqQxCmjDVqEdzxqGdkvmiccHJtBLErzQBb0SkteheTkwfMh0BDqrQFbJcgu4kGIdVHE4uMspyGt38604/Wh/AYRqFtZbFkKmLHAv0grOs3J0HXXV259vbLzZ5tg5HkVGkVi/PvD/P37/m0KqcrrXM8Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=RGg0f2Sz; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RGg0f2Sz"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=zO5heXvzNW4wL2wXg1UR/MHfEMtuRZIxRnF8eBlc1Vs=; b=RGg0f2SzfeB/sRhVsJ5fWZrJNL
	jo7mvDZHPqHEfUGuYME4HBBwj8I2GkX5o7zsM0bZUPO4c9/CHdNlscfl0nm1DgAJuaUbc7fLgFGlr
	pU2286wDHnHBNKuASvyzKQ6Vq9q8WVZgbpstC0BEl4UeZKllVP3074i05vOwZLGzcdFIBWL99n/5a
	zR9uJLdgXIPBjPV/6Inu7nC2uOpTsYyx/yXrYwDFxqE/MFSoJtknKXUrkohXoEnaSP05oJCaAVyoA
	JkrZMfiPCB9BDg7oqqoaidmeR4PgxQTZlU3g4/FtG9uxwfQIDC9BUC2YBQ5hbo+S8uly9HC/LqTBx
	KuAmaVGg==;
Received: from 2a02-8389-2301-9f00-3397-c9eb-6d8a-9179.cable.dynamic.v6.surfer.at ([2a02:8389:2301:9f00:3397:c9eb:6d8a:9179] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjtFY-0000000DuzV-3ksN;
	Wed, 15 Jul 2026 06:37:45 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	linux-block@vger.kernel.org
Subject: [PATCH 2/2] block: implement async io_uring zone reset all
Date: Wed, 15 Jul 2026 08:37:16 +0200
Message-ID: <20260715063734.2933511-3-hch@lst.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260715063734.2933511-1-hch@lst.de>
References: <20260715063734.2933511-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Add a new BLOCK_URING_CMD_ZONE_RESET_ALL uring cmd to reset all zones
for a given block device.  This can be used by storage systems or
file system mkfs tools to initialize multiple devices in parallel.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/ioctl.c               | 35 +++++++++++++++++++++++++++++++++++
 include/uapi/linux/blkdev.h |  1 +
 2 files changed, 36 insertions(+)

diff --git a/block/ioctl.c b/block/ioctl.c
index af2a897f13f9..a6bdf7dd1fc1 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -14,6 +14,7 @@
 #include <linux/pagemap.h>
 #include <linux/io_uring/cmd.h>
 #include <linux/blk-integrity.h>
+#include <trace/events/block.h>
 #include <uapi/linux/blkdev.h>
 #include "blk.h"
 #include "blk-crypto-internal.h"
@@ -943,6 +944,38 @@ static int blkdev_cmd_discard(struct io_uring_cmd *cmd)
 	return -EIOCBQUEUED;
 }
 
+static int blkdev_cmd_zone_reset_all(struct io_uring_cmd *cmd)
+{
+	struct blk_iou_cmd *bic = io_uring_cmd_to_pdu(cmd, struct blk_iou_cmd);
+	struct block_device *bdev = I_BDEV(cmd->file->f_mapping->host);
+	struct bio *bio;
+	int err;
+
+	if (!(file_to_blk_mode(cmd->file) & BLK_OPEN_WRITE))
+		return -EBADF;
+	if (bdev_read_only(bdev))
+		return -EPERM;
+	if (!bdev_is_zoned(bdev))
+		return -EOPNOTSUPP;
+	if (bic->start || bic->len)
+		return -EINVAL;
+
+	err = filemap_invalidate_pages(bdev->bd_mapping, 0,
+				bdev_nr_bytes(bdev) - 1, bic->nowait);
+	if (err)
+		return err;
+
+	bio = bio_alloc(bdev, 0, REQ_OP_ZONE_RESET_ALL,
+			bic->nowait ? GFP_NOWAIT : GFP_KERNEL);
+	if (!bio)
+		return -EAGAIN;
+	trace_blkdev_zone_mgmt(bio, 0);
+	bio->bi_private = cmd;
+	bio->bi_end_io = bio_cmd_bio_end_io;
+	submit_bio(bio);
+	return -EIOCBQUEUED;
+}
+
 int blkdev_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags)
 {
 	struct blk_iou_cmd *bic = io_uring_cmd_to_pdu(cmd, struct blk_iou_cmd);
@@ -966,6 +999,8 @@ int blkdev_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags)
 	switch (cmd_op) {
 	case BLOCK_URING_CMD_DISCARD:
 		return blkdev_cmd_discard(cmd);
+	case BLOCK_URING_CMD_ZONE_RESET_ALL:
+		return blkdev_cmd_zone_reset_all(cmd);
 	}
 	return -EINVAL;
 }
diff --git a/include/uapi/linux/blkdev.h b/include/uapi/linux/blkdev.h
index 66373cd1a83a..57b0bbd04e2b 100644
--- a/include/uapi/linux/blkdev.h
+++ b/include/uapi/linux/blkdev.h
@@ -10,5 +10,6 @@
  * It's a different number space from ioctl(), reuse the block's code 0x12.
  */
 #define BLOCK_URING_CMD_DISCARD			_IO(0x12, 0)
+#define BLOCK_URING_CMD_ZONE_RESET_ALL		_IO(0x12, 1)
 
 #endif
-- 
2.53.0

