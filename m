Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F5E559C80
	for <linux-block@vger.kernel.org>; Tue, 13 Oct 2026 20:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791924933; cv=none; b=hXlXrLeNV9ycPYzMEW1xsubonnTR5BIQucPjem3xtKt8+Bp8JcBIqW3slQH0upTwhv+EDQ6ASd+IGXR+Z9BilAFuY2DjPHLPCehAnvKOj52NM4mumsMtgyjkyL47f7PEAy1ogADzhknpLYTd+zQSYQDbBxTde2xF0aO4pUJsvCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791924933; c=relaxed/simple;
	bh=poMU3IMk+s1i+OL6PspfjWv+5wjZjdnLVtCEDY3Hn+k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hVYNBPWcQGoZ8m86w3QJNQ0Dj2i441Tc1p+NelTBIVrTECvfCGCPa4yIAL+f6hfXRZFj7VeZGTTzf574wNcxhQzJSeX/q6BZt8T2eu+OQnKzkk9gfpix4O3PvN2HmsAhq/50B9NWoCZ9y88u8TUgxlCIChJAI51x7qvSvp3QmW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cpx1yTle; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cpx1yTle"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-48b060ec084so2208210f8f.0
        for <linux-block@vger.kernel.org>; Tue, 13 Oct 2026 13:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791924927; x=1792529727; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sjQY12JZJkEEoHUMGZ5pLsy3Pmh4yJs101KM8nm2S/U=;
        b=cpx1yTleLYGeSHlX9yy3Sxz8IdjAPl+6Qo8dMsIM1xUdhWk9hVBqChb2Ft2PMIToUM
         l5f431zB4lkLv5sd9yrqxMwO9wQDdAcXTc5j9ewInPWInwqbQyd6O+dzYoK2/DJiDpN3
         p3I9xKC8xUbr6TC1/KeoicEAuiHUJPo2lSpPcs6c1ACIZnD1UngpaWeyvA5LNWbJYwCz
         upwd2Waem9goDNXoRXMXGSDrhZo/viSvfHebc9upJlNQRScoPHsQJ1/g4iOLceA0jdSj
         J6PIQXejwkh1IPolJDgKBakNFh8OvtzJjBr2X+rAQ8AASpc+hg4JPYb50tlQrydlREa1
         5TCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791924927; x=1792529727;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sjQY12JZJkEEoHUMGZ5pLsy3Pmh4yJs101KM8nm2S/U=;
        b=Ut1tbkV0V833FuLGCVq7Xm1OBleOBcJrjxJgX9CbpcEJiPsm3wCou8NFuXIx5VvK6V
         Lo45MS36SKANcYWofbGgc13VJ0pS+IdlJzrum84y6tsfE+SKV21O5atLR0/4+PEawR2l
         /vD/W/ge0SAE7UGOCwj+QqKtIj/kzrfBENkSe/+mV3MCeMCbAuFMAV7+5cLqQVsiGQmL
         4V39pWu8FD9/YLipcmEgKdVLUBNigaVXRQUR3C6xECtYg0Mly6qcZu16LQjLjrmAJ7bQ
         GNWFKsS5EhEmok87zUVqaXqp8/UBQN18Lgvx3mpjx5Zuk8CAmAaEhplTH9cxVjdEo9j+
         n0Eg==
X-Gm-Message-State: AFq9FYL/6PwC788oeN7NBzE9a+Q+Y9Te7fzCpRzaq4vKOy1VSUNWZ0Eu
	kmqgay0geAzNnEMn9Mrxz0mstT2Q6zGBhqlg9Y6bDoxC9n/pFEBaiBF79fFmVg==
X-Gm-Gg: AYBFou1rI8LpCV+bzdFDR1rofC/RJAA2FiJz0jWNPvWPpkaevbWYgY2jI95ix5CWni5
	zPTHBmhV+hS5EDj35KUMAqNKmsoPWb9of8KOb0Qz1dtfTe6jIUuDESta/osLP4MqrfW5NQ+DMkV
	8V/GeeEt2wPOTuE4Z1CIbY4TkJlyRTSpedqddq2uKNMX71VKZ9rN+D77/49EUU8Sb6C2mI+hmex
	peSHRfYrC/pOg5x+draQSKycs6hxPow+36uaaZbxIj4BzteASRgcr0x4oN2Ws/dJJGjodHcjTEx
	6z5BfuI0u+fFoYrE5DsLpFz2CpmSehalJywqrj8ZZCO9dWZ5oQskrYtmwC87YHzRycqDDL7oC2v
	6upRUTN1aQhf0w8HjhuplsLjFqPL62V7nsLwGPhUUf5PUYW/j4u2P7vyXNmdokI7nua1v8EQUrz
	FsL1wXdZIUclhJtyCKxx1YhvIIqZPGKrQLxFeFCfIwPq/KL/y+mE3eeY0cBOUPmWIuYHv7SbqzE
	5dFXexK8eDlQgrZYKSVs8nvCMXZXLUKfrWNT4d0XZtoUyZ+CJlYzoUkAiQ3FronwhJyO8/o79lD
X-Received: by 2002:a5d:5d09:0:b0:482:fd9c:3740 with SMTP id ffacd0b85a97d-48dbaae8af0mr23656771f8f.22.1791924926558;
        Tue, 13 Oct 2026 13:55:26 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de7273a0esm2380730f8f.29.2026.10.13.13.55.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 13:55:24 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: linux-block@vger.kernel.org
Cc: asml.silence@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jens Axboe <axboe@kernel.dk>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Tushar Gohad <tushar.gohad@intel.com>,
	William Power <william.power@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Benjamin Marzinski <bmarzins@redhat.com>,
	dm-devel@lists.linux.dev
Subject: [PATCH v10 05/13] block: add dma-buf support for raw bdev
Date: Tue, 13 Oct 2026 21:54:49 +0100
Message-ID: <78b3f2bb6e3ce576ee99252b88f0af8602b436d1.1791924581.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1791924581.git.asml.silence@gmail.com>
References: <cover.1791924581.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a simple proxy implementation of init_dma_buf_io_ctx() forwarding
the call to a new struct block_device_operations operation. Also reject
dma-buf backed iterators for buffered IO.

Reviewed-by: Christoph Hellwig <hch@lst.de>
[pavel: reject dma-buf without O_DIRECT]
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 block/fops.c           | 24 ++++++++++++++++++++++++
 include/linux/blkdev.h |  2 ++
 2 files changed, 26 insertions(+)

diff --git a/block/fops.c b/block/fops.c
index 827dc9eecba7..6c6700df943c 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -730,6 +730,9 @@ blkdev_direct_write(struct kiocb *iocb, struct iov_iter *from)
 
 static ssize_t blkdev_buffered_write(struct kiocb *iocb, struct iov_iter *from)
 {
+	if (unlikely(iov_iter_is_dmabuf_map(from)))
+		return -EOPNOTSUPP;
+
 	return iomap_file_buffered_write(iocb, from, &blkdev_iomap_ops, NULL,
 			NULL);
 }
@@ -855,6 +858,11 @@ static ssize_t blkdev_read_iter(struct kiocb *iocb, struct iov_iter *to)
 		if (ret < 0 || !count)
 			goto reexpand;
 	}
+	if (unlikely(iov_iter_is_dmabuf_map(to))) {
+		if (!ret)
+			ret = -EOPNOTSUPP;
+		goto reexpand;
+	}
 
 	/*
 	 * Take i_rwsem and invalidate_lock to avoid racing with set_blocksize
@@ -958,6 +966,21 @@ static int blkdev_mmap_prepare(struct vm_area_desc *desc)
 	return generic_file_mmap_prepare(desc);
 }
 
+static int blkdev_init_dma_buf_io_ctx(struct file *file,
+				      struct dma_buf_io_ctx *ctx)
+{
+	struct block_device *bdev = file_bdev(file);
+	struct gendisk *disk = bdev->bd_disk;
+
+	if (!(file->f_flags & O_DIRECT))
+		return -EINVAL;
+	if (!disk->fops->init_dma_buf_io_ctx)
+		return -EOPNOTSUPP;
+	if (bdev_has_integrity_csum(bdev))
+		return -EOPNOTSUPP;
+	return disk->fops->init_dma_buf_io_ctx(bdev, ctx);
+}
+
 const struct file_operations def_blk_fops = {
 	.open		= blkdev_open,
 	.release	= blkdev_release,
@@ -976,6 +999,7 @@ const struct file_operations def_blk_fops = {
 	.fallocate	= blkdev_fallocate,
 	.uring_cmd	= blkdev_uring_cmd,
 	.fop_flags	= FOP_BUFFER_RASYNC | FOP_DONTCACHE,
+	.init_dma_buf_io_ctx = blkdev_init_dma_buf_io_ctx,
 };
 
 static __init int blkdev_init(void)
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index d003a9d2d1f6..2d5c30823aab 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1599,6 +1599,8 @@ struct block_device_operations {
 	/* returns the length of the identifier or a negative errno: */
 	int (*get_unique_id)(struct gendisk *disk, u8 id[16],
 			enum blk_unique_id id_type);
+	int (*init_dma_buf_io_ctx)(struct block_device *,
+				   struct dma_buf_io_ctx *);
 	struct module *owner;
 	const struct pr_ops *pr_ops;
 
-- 
2.54.0

