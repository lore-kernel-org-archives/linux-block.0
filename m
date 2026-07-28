Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D318947A0A5
	for <linux-block@vger.kernel.org>; Tue, 28 Jul 2026 21:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785274201; cv=none; b=lyzoFue5nQy7/GXOtalpyYrUkb+pHZifvN6Tdy6tccg4bjDlr4HPbez1KeafIyo0AWciDJayIrQk4c8rgcAbZKYM+xVdnK9zwY25cztPrqy3py/pO6j/0TTMi3uybkH318jE3V0TTSCcAQ5nrBfDxrFpeOtR9o2GLMGaucEON+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785274201; c=relaxed/simple;
	bh=XDQjNbbhKar8uY0avv/kD/aMx3Th5Bc2yUeUMO7wAXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y9WnGd5XuSfComc12VMIVmHmNiV9XL5q4Wq5TUv6MZjnx5k648ZFU5DbzCojij7zSd4taZvi3uHG3/awrZeyYRnCH1JlJuRr2l+HsB9Wgaqf6WIUxPm6cZeq1xgsBI5T3QGnX67p2So6b9qZXDtjKHx7NZXHerOIgxQrxiqr1II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uj3Ados3; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uj3Ados3"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-47f633e6058so310639f8f.0
        for <linux-block@vger.kernel.org>; Tue, 28 Jul 2026 14:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785274196; x=1785878996; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zGURBnMw6fzU2CZK+DQfnrMi2Ya0rXE6R9ZmtmaHTkk=;
        b=Uj3Ados3I5BygJMeRy1ORSwpuFbNVWU5qbh7dPi1mXyFgd0XbJ7SiSJIzlSSLTWEG3
         O5PtiG0m9pRveLollrN9AX3Xlj8kcX2vuvezY0FIwQ1bEJYoqxlz7RLacuJIa/5THE4Q
         BG+J0mGtIW8OjuShFXBnA/IJvA6FAaII0wF37N5olcgbsBGp8AyOwS9qVGEg+MgFqfkV
         aY1WiHqvj+VJR8oegHWnnvIOq4HKcKRGtC6SxurENOCE/+zImYlNOUKK6zzsdBtUegVu
         CGeI4ugz3Z6J3wegOPtlDrTgjjbdFBmAT+x5dVLWst7Bc7YH3liXWpGRbUWy8MHZuwHt
         qgbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785274196; x=1785878996;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zGURBnMw6fzU2CZK+DQfnrMi2Ya0rXE6R9ZmtmaHTkk=;
        b=IFmzAI7gvDYOPFbsqjlBFGt78Tz5qRg0hjbVJISEBb6f2lVvU3V2FDhfg2i49zK/uj
         HLYz0sx46wf9jF8hYjTvg76ByV3YmKS9qOAf67Ig4UJOfrNpxd+0ovlO/jpsGZoG3XgK
         /zVOq24n/H1uK9IMlu+Gy18yABlxaZb+J+a3Kwn0hOJMdN3E+0kEmfB1+jO4lOn6fZ3F
         HbXevMiw4NmAcu4/f2sAbCYuVrrTOybMrqNzIPSTiCGeZnAL6qhMpzilEL2ARvJixp2B
         Y4YAB+CH68moTgFrZo3UNFHEuKO2sCRoe2xpHw+HkVfx8PJQApUHkYaYSH+1LJQrZ+2H
         oeTA==
X-Forwarded-Encrypted: i=1; AHgh+RocexTqeFMbhe9cPxd1+36vmxd8KXpaj0kibGU9Rnj6G3vWfFpSyHogLsvWitD0bENT0Ov08qtZKzJHQA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxrI+7JZRw307rtD89xC3SJ8Pcup3k5amhmdN/hOip391I1WrsO
	x2gbgSLQSMrgExn64FdKV9y0UlCYl1H1YCF/dGNsD99Y2KT7azfZdAD9
X-Gm-Gg: AR+sD12NdCO92lNx12qJZ+giPPFIQbLL89dPQocTc7b0N3TJcVUwMyEgCdF75fX2wSJ
	gZ9WmfK4ndPzk116wxWP2l4EGXVGs64n5yv4ODHlrMUh9Ma2Y85OcXYPg2dFYxzTtB0YESHVBsA
	yjM7MwreLMtqyFxsVXKTbRCyHJNRL4cuyG+KfQa07ZmaUne/p5+XptizgF9bRsJu96YjVNHcJAd
	bAeJD61OvVlXIXPCVX5PvXqw4FRf6XGamL+rmFJyB3yuSmE0AbqZbqn4mYTmxvfMlhvLu85a8xN
	JBtFPaYHo3Kduqk+cIzOjC2rI4/sAfgInVYznlhJVT0axfdHixDn2mzAQmNgL0wQ8+A3oXgejfk
	ySYmUatHzOU0GQrZ6Wy28MErVM5UlcB3E9Gg8XIxfHo7elUf3m9dnEmy7DGJEpZfwA87oA9pnuB
	SFwi9W+RHat+HZH9eGW4tpEDbNriy5kcl77l9k0+KakEqhoKvL1Y6FsYchp+y6Vw/Ceg3bT3YUb
	dUJEqkR
X-Received: by 2002:a5d:5d09:0:b0:47f:94a8:d6db with SMTP id ffacd0b85a97d-47fb1f14a61mr4656094f8f.34.1785274196213;
        Tue, 28 Jul 2026 14:29:56 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fb6ac44bcsm2245329f8f.11.2026.07.28.14.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 14:29:54 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org
Cc: asml.silence@gmail.com,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Tushar Gohad <tushar.gohad@intel.com>,
	William Power <william.power@intel.com>,
	Phil Cayton <phil.cayton@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Benjamin Marzinski <bmarzins@redhat.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	David Sterba <dsterba@suse.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	dm-devel@lists.linux.dev,
	nvdimm@lists.linux.dev,
	linux-btrfs@vger.kernel.org,
	ceph-devel@vger.kernel.org
Subject: [PATCH v4 07/14] block: forward init_dma_buf_io_ctx to drivers
Date: Tue, 28 Jul 2026 22:29:19 +0100
Message-ID: <e0cc82a15419ba7b38eb0bb00ae34cf3d0c3a938.1785274111.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1785274111.git.asml.silence@gmail.com>
References: <cover.1785274111.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a simple proxy implementation of init_dma_buf_io_ctx() forwarding
the call to a new struct block_device_operations operation.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 block/fops.c           | 14 ++++++++++++++
 include/linux/blkdev.h |  2 ++
 2 files changed, 16 insertions(+)

diff --git a/block/fops.c b/block/fops.c
index 37d491f45015..d83cdbab65a6 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -926,6 +926,19 @@ static int blkdev_mmap_prepare(struct vm_area_desc *desc)
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
+		return -EINVAL;
+	return disk->fops->init_dma_buf_io_ctx(bdev, ctx);
+}
+
 const struct file_operations def_blk_fops = {
 	.open		= blkdev_open,
 	.release	= blkdev_release,
@@ -944,6 +957,7 @@ const struct file_operations def_blk_fops = {
 	.fallocate	= blkdev_fallocate,
 	.uring_cmd	= blkdev_uring_cmd,
 	.fop_flags	= FOP_BUFFER_RASYNC,
+	.init_dma_buf_io_ctx = blkdev_init_dma_buf_io_ctx,
 };
 
 static __init int blkdev_init(void)
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 9213a5716f95..9f4c92e51dc9 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1682,6 +1682,8 @@ struct block_device_operations {
 	/* returns the length of the identifier or a negative errno: */
 	int (*get_unique_id)(struct gendisk *disk, u8 id[16],
 			enum blk_unique_id id_type);
+	int (*init_dma_buf_io_ctx)(struct block_device *,
+				   struct dma_buf_io_ctx *);
 	struct module *owner;
 	const struct pr_ops *pr_ops;
 
-- 
2.54.0

