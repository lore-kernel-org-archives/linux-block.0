Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.167
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794553624;
	b=adnR0ZmjeAnNsgTKqW4LvpeeHcxHn0ea2DOJB4b/ORFRywT5tdwDx92QwLPd/qPYQrBX
	 3La80pSqWr5IET0hLZKxikcs/5zlkqnZ2Zn1MqahzTDdhEpLZIZUWKLh99Zhq+8K4u7LW
	 JC1NWwLSmJ+fBhzBv3VtiiKcmM4jLrk88Lk/X+5MiEVNJSevsmaWDbjYrsV1hJbbP38H3
	 P2FCQOVx5iWADYAKuHel5TecOkCl2dCi0TEYR17FGNVRedi2exd7EXoTVEQA9PU0w9OVF
	 fCjpQy9i1BlnGqmSKq6ONy8WLXTefGFeScr0Glj2799/Uqqgve0UA1UOZFSXqtQAuXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794553624;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ov6PsgY3xDvctn8CEb8PaC1/EQ2eM7GolUa4HZ+7g3w=;
	b=Y/G3DYCoI29IkJ+sdohyEB/Knz6gOmmS3oiI3NbNTRF0hng1tawxtc0WGF9GtD+dQho7
	 56wZz2Z9o5XZaWAZLm+vPK2B1RgPke132FNvB4XPVPX1IHwZ+77rjNybjuizqox58hGhj
	 yUrzvHEMrxxLeo8oQXkb1vuLYbcyL/xOIGsXsxNIWauzZOEOYsKcG3CMBdaRIavWK6Asi
	 tZJ4B2mRubF4uHhicMtoo8fgsw4FV/RQ2OcAt365GhjMy3qhPCc8POsGwhLiaF+A4D8v6
	 hilpqQVByKS0/VqGj73jiN4doq0skHLiKC+WA68hExz7doTZvdmjyfFTpzbXp9EDiJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=aJxqmbZp;
	arc=none smtp.remote-ip=95.215.58.167
Received: from mta1.migadu.com (out-167.mta1.migadu.com [95.215.58.167])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56CA606A331
	for <linux-block@vger.kernel.org>; Fri, 13 Nov 2026 07:07:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A56CA606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=aJxqmbZp
X-Envelope-To: linux-block@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=NPYqP2bSnfKk3JDua2A5vqNZ+eJUoj9E6cqywCvpDEg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794553622; v=1; x=1795158422;
 b=aJxqmbZp0K1L3734ltuDuETTg2LiH6P/KC6eTQAP/h439uwMAVwaekaFkF/9bhBdttdV09fJ
 beOMd+SLNAggg61PjS5qH33lCWEMmkOCfSUzYP5LEKORG6Ct7XD408/Afzg/PXHMw51yOu/+8YO
 Ub+DFYDuW8lOuRPIKJhOsq8k=
X-Envelope-To: linux-block@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id da2ed9eb902ef4ec;
	Fri, 13 Nov 2026 07:07:01 +0000
X-Mizu-Trace-ID: da2ed9eb902ef4ec
X-Migadu-Flow: FLOW_OUT
From: Mengmeng Zhao <mengmeng.zhao@linux.dev>
To: Christoph Hellwig <hch@lst.de>,
	Anuj Gupta <anuj1072538@gmail.com>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	christian.koenig@amd.com,
	Philipp Stanner <phasta@kernel.org>,
	Dan Williams <djbw@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	tytso@mit.edu,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Baokun Li <libaokun@linux.alibaba.com>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Zhang Yi <yi.zhang@huawei.com>,
	asml.silence@gmail.com,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	Li Wang <liwang@kylinos.cn>,
	Mengmeng Zhao <zhaomengmeng@kylinos.cn>
Subject: [RFC PATCH v2 1/8] block: factor out bdev_init_dma_buf_io_ctx()
Date: Fri, 13 Nov 2026 15:06:14 +0800
Message-ID: <20261113070621.273953-2-mengmeng.zhao@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261113070621.273953-1-mengmeng.zhao@linux.dev>
References: <20261113070621.273953-1-mengmeng.zhao@linux.dev>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nitesh Shetty <nj.shetty@samsung.com>

Factor the checks and the driver setup out of
blkdev_init_dma_buf_io_ctx() into an exported helper that takes the
block device as an argument, so callers can set up a dma-buf I/O
context for any block device.  The block device file operation becomes
a thin wrapper using file_bdev(), so its behavior is unchanged.

Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
Signed-off-by: Mengmeng Zhao <zhaomengmeng@kylinos.cn>
Signed-off-by: Li Wang <liwang@kylinos.cn>
---
 block/bdev.c           | 14 ++++++++++++++
 block/fops.c           | 12 +-----------
 include/linux/blkdev.h |  3 +++
 3 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index f20f91b3176e..88e3f552f5d4 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -17,6 +17,7 @@
 #include <linux/blkpg.h>
 #include <linux/magic.h>
 #include <linux/buffer_head.h>
+#include <linux/dma-buf-io.h>
 #include <linux/swap.h>
 #include <linux/writeback.h>
 #include <linux/mount.h>
@@ -60,6 +61,19 @@ struct block_device *file_bdev(struct file *bdev_file)
 }
 EXPORT_SYMBOL(file_bdev);
 
+int bdev_init_dma_buf_io_ctx(struct file *file, struct block_device *bdev,
+			     struct dma_buf_io_ctx *ctx)
+{
+	if (!(file->f_flags & O_DIRECT))
+		return -EINVAL;
+	if (ctx->dmabuf->size > UINT_MAX)
+		return -EINVAL;
+	if (!bdev->bd_disk->fops->init_dma_buf_io_ctx)
+		return -EOPNOTSUPP;
+	return bdev->bd_disk->fops->init_dma_buf_io_ctx(bdev, ctx);
+}
+EXPORT_SYMBOL_GPL(bdev_init_dma_buf_io_ctx);
+
 static void bdev_write_inode(struct block_device *bdev)
 {
 	struct inode *inode = BD_INODE(bdev);
diff --git a/block/fops.c b/block/fops.c
index a0ccadaa9c79..86bf1f298b79 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -19,7 +19,6 @@
 #include <linux/iomap.h>
 #include <linux/module.h>
 #include <linux/io_uring/cmd.h>
-#include <linux/dma-buf-io.h>
 #include "blk.h"
 
 static inline struct inode *bdev_file_inode(struct file *file)
@@ -1009,16 +1008,7 @@ static int blkdev_mmap_prepare(struct vm_area_desc *desc)
 static int blkdev_init_dma_buf_io_ctx(struct file *file,
 				      struct dma_buf_io_ctx *ctx)
 {
-	struct block_device *bdev = file_bdev(file);
-	struct gendisk *disk = bdev->bd_disk;
-
-	if (!(file->f_flags & O_DIRECT))
-		return -EINVAL;
-	if (ctx->dmabuf->size > UINT_MAX)
-		return -EINVAL;
-	if (!disk->fops->init_dma_buf_io_ctx)
-		return -EOPNOTSUPP;
-	return disk->fops->init_dma_buf_io_ctx(bdev, ctx);
+	return bdev_init_dma_buf_io_ctx(file, file_bdev(file), ctx);
 }
 
 const struct file_operations def_blk_fops = {
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 215753171cef..b98f43478cc0 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1610,6 +1610,9 @@ struct block_device_operations {
 	int (*alternative_gpt_sector)(struct gendisk *disk, sector_t *sector);
 };
 
+int bdev_init_dma_buf_io_ctx(struct file *file, struct block_device *bdev,
+			     struct dma_buf_io_ctx *ctx);
+
 #ifdef CONFIG_COMPAT
 extern int blkdev_compat_ptr_ioctl(struct block_device *, blk_mode_t,
 				      unsigned int, unsigned long);
-- 
2.43.0

