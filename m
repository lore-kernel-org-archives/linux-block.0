Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94213CE49E;
	Thu, 16 Jul 2026 09:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784193540; cv=none; b=hqJ+LaFIbQsYRioPJkVOF0CExeJ07Du4JTQ/YY+p+00VnWAsWc9RpRyY1K/0TyYMXEAyPhR1ysHNkMHzCBuGr6zBz+qwt7pQY2SXRgyA2FGzRxUMPqdEoG+hoxlHoby9ZBdy4NUl1usV8CYUTGP3xcle9Kr6HOi9sJoKpiWVU+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784193540; c=relaxed/simple;
	bh=XYcgRP+WNf5X4N66zuTUnfmZA9QiY1RBP07YZHoa5nU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OvXgryjDSUFx9GEjj3ZigNmM8CKAQJMwzwrQYoqqG2z6ltieBC6Qmn06bXCa/PHZsRzYCLwkjIAkh5UqKElPYuER8wYGfgE9xwPEw4o5Vuyn9cWVXKz4kAkwrFaeERd2HKcUkJGwnsM9Npc3HxpajOTJwTZ6XcicUwVrKqrA9w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ykX4AY+F; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ykX4AY+F"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=0L5aBg2m3aF5NBVQNQ9mgpmqNjmiAR0elr4DWPa9n1I=; b=ykX4AY+FYC7YuVzZtel+8ngrnU
	uhia8Ff1NY23Gu/Q3/6k0TKYo72WUeL5aa6KeQn3oYuYlodrzmP1BHsIYw3DewtlzL9kA9hv3t6li
	cU61owXGmEhmcGooG3lgCWKy/DwosHEkPZWkIS3CKe4YugXqjEmGnt3zjvn5aJrVtDKkIlIXx9eHP
	5J2o0URizf4IWIe06o8i2xeolguFdGVxGWwjuFVTQxDzcEqquJu4dq+akaduSciM9Lq3bvJDLeabX
	5VVtFWmwW8PTL8Ybfz1Wc/C+vr4G+TaCUjEy42meod/FP0cwFVAJ8b3SctRDY58FsqinO6I5UePbK
	hA33zcfA==;
Received: from 2a02-8389-2301-9f00-b29a-36e9-8c1c-0994.cable.dynamic.v6.surfer.at ([2a02:8389:2301:9f00:b29a:36e9:8c1c:994] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wkIF8-0000000GqFs-3l8B;
	Thu, 16 Jul 2026 09:18:59 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	linux-block@vger.kernel.org,
	io-uring@vger.kernel.org
Subject: [PATCH 6/6] block: implement async io_uring zone reset all
Date: Thu, 16 Jul 2026 11:17:52 +0200
Message-ID: <20260716091838.318082-7-hch@lst.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260716091838.318082-1-hch@lst.de>
References: <20260716091838.318082-1-hch@lst.de>
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
 block/ioctl.c               | 37 +++++++++++++++++++++++++++++++++++++
 include/uapi/linux/blkdev.h |  1 +
 2 files changed, 38 insertions(+)

diff --git a/block/ioctl.c b/block/ioctl.c
index af2a897f13f9..64b4e6c0f696 100644
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
@@ -943,6 +944,40 @@ static int blkdev_cmd_discard(struct io_uring_cmd *cmd)
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
+	if (bic->nowait)
+		bio->bi_opf |= REQ_NOWAIT;
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
@@ -966,6 +1001,8 @@ int blkdev_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags)
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

