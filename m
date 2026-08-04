Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191073DBD5E;
	Tue,  4 Aug 2026 12:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785847890; cv=none; b=aXwt8cFhTTrS+WqOTlBUFTOn5Ri6YojpQS6tJ8QJX9Qdg7hWFHuk5JvH0SGUoIfgatvoOLN6EQeTOTg7Gn1UkujP/921d5bNhV+h1G9JdXlvfWXvCJtuznzpqT5hvCUJwJ1cDFVmtIh7HAu/j+ENOZt9axseCabg/pQAMDqXUzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785847890; c=relaxed/simple;
	bh=ZVT0G2kA4oyVs2eVm7cwDUaUENSFY4ENvJovxXb8LVc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fZkwT46Rjtv5ppL799+GUKS7dPPO9GNCzeuFv/tJvqsI2vHc0s8PkPvBcgxqokYTyiZZXwYiNrxZwk+AxvH5R5oJsqRz4rFgFWzEiSkTag92T4d5PGNfHGCkY1N8swBGq3NeIgw3J9UhauqdkTlvCzr3Adz08o9FhQM3R3FRXWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=lgY/Yns+; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lgY/Yns+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=y7rO0CcF+seQLZBWtepUHErHudEtNfBSRyaEEjvdBIk=; b=lgY/Yns+DRMwXDm6GbgmTBrNSv
	raBdipM4eCxn9ISxp9UAHe5cVra2nt6mxNB2ex95TTrOM2/1Qm0cAVYJv3qqhHQSgnRh5EoYYOhMm
	6tL+S06QNZJ5YwXr0oTwwnaWDEedsTLfgbZSQA9yTyryQ2xulzNkd78JGJEdX9SzVmMSwFvMX4dv8
	WVxz+3V7g4Q4LjRDSJg4POm3tXS/YuPY18s7pUNy0xtwYTV2aJxKxevFXeEKft0F72KB4fHaN990e
	0M6H2du7ktKgeLwlbtd8BUuUEDSkq3ttLWAidyUeI+faeCoSwbWKH7/M9ZUGlvc3o5r6jS4JwEGYg
	3FCGR0RQ==;
Received: from [93.123.20.94] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wrEcB-00000001rDw-2fbW;
	Tue, 04 Aug 2026 12:51:28 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	linux-block@vger.kernel.org,
	io-uring@vger.kernel.org
Subject: [PATCH 6/6] block: implement async io_uring zone reset all
Date: Tue,  4 Aug 2026 05:50:22 -0700
Message-ID: <20260804125038.740388-7-hch@lst.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260804125038.740388-1-hch@lst.de>
References: <20260804125038.740388-1-hch@lst.de>
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
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
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

