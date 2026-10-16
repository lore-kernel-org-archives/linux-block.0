Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825B0453A29
	for <linux-block@vger.kernel.org>; Fri, 16 Oct 2026 09:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792142417; cv=none; b=I6e3r2ipvFpTzbqcLiCxdchwh4osHKM/mwAUMJvoHBwQ203uNrbsMF8cC6E85wGs1t9xWVpolx5ZUFeaY06BXZecwXx9YnMMbenJBFR47qWftwXBgcIHt9TwHNuqdaToLnDItm8Kbp8L+60/CePsYDU3kL/Szbgpru88eneK//Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792142417; c=relaxed/simple;
	bh=Ycr52JERApajpnzpQEpfpa1Sk7Py2NlhuetofLIAJLE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EK4VQR672GWYxrS0yJX0Tmoh0dGhOUIVRWwjwhagvMsOUadACyHiuXpw94D1fV4k5L6OK3gtWt2H3sDct4ub8pzRr9uUNr9bKIzu6dd+kBZlhQwXrSIuBFl/izaWnSF8Fjf2ZMae5k30vs/xDLB68emkqnOFyezwkR8BO4nBbSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DuemZmJm; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DuemZmJm"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-33fb4680717so2092624eec.1
        for <linux-block@vger.kernel.org>; Fri, 16 Oct 2026 02:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792142414; x=1792747214; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7Jlt5MbUPW2eY7/M7ExgfYc+H3JDnkcPLDIxbgIvOrU=;
        b=DuemZmJmewaN9aDAcVm0rAaxbPNqSkTNTdx94tOTSVZMOx8E666wm7/bwyl1ArfDy2
         8n7cAg5lMK4ewF72jHFkOphHWzCE8QDqcxOwcJlnueh0JY9xDd70W5iZrI25qq0Tjfy+
         YTMZaN2zVbWB6V5QuIwMQ/8OhhyutpWlEveAfaTLxDBdh0NPakl2zXFqu4pwqENft8iK
         RjrvES7HKo5Y4+3qyL8MAdaJ5nEFLkbnrFN/Q4h39/NWUSwZW3PXqFZZfv2kMAYtsxWd
         V+Bl4SszIAAwfR895IKawvq73q6vJ44zdPe3MvcAzoXVbOHBJt0ZpeQ3uC17vWUip/PV
         pv9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792142414; x=1792747214;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7Jlt5MbUPW2eY7/M7ExgfYc+H3JDnkcPLDIxbgIvOrU=;
        b=F2NnlmtZ+1HTyXupR+6gDCkXY4aGIQg9Uf7lzjpQ2J8FBh2VRXAkw/e/3CCkGFmgBg
         IY1OZ94PytcNgDdiYa7E7yWOwMeD2EDlcf1IDhr+VFgpdlzVudy+xzdmKjQNsghiaifB
         W7C9/B9qP/og5I7WrNCL1a+WKGlM3W5TMuGacA4p6vgD706UlO9WOXZHkwkjuH0bmBO6
         ZKJeGAAdJ5k3CClJUesCs+joI/tlmNWR/MjbXTj4qjiWbXKa1jfsV7UIksiWNsu8cDWb
         XLdGF3+W5Frr5mD1vSSi3/+dDZfmQBjb64AKQv0mJiixjT5D+hexZ5PP4H76eZOQ+MuG
         NIlw==
X-Gm-Message-State: AFq9FYLBLcmdsqQxdaxKZaWdemVR9+YnnTNwu8+AbBoGFQkznJlDpgs3
	uz72IZe7xaYn1paYx9Z5EFreuiRIEDt/Nyd6O8/0IQRvu2l2qrL+DZ0=
X-Gm-Gg: AYBFou1swi+MGvfpIioc2iaRWTWdUvfv32LgHPoeQ3+TkDLM4wicuciZFBS7Ln7SPr9
	iKSjvbwmxJXJdkjDiSZQ+r5mIovE7mm61xd6gzw37Oo3EUllempwPhDN3No/mrNVenBeWDZTbdh
	yzAUMWNZlSSQkNIXjQ2WkvavxsoPwPjbKD6Mjrfvg5bPNTI+/RndKig1vB5rTkCnPkONXgKFmZo
	PXvnjYLWvP6p1xi6wHcVi2cvtg3dS9HbPFwtUSG3shLWONuFhHSZXqH7rxyu7D9zIuqP/Rfhi+H
	BUkkqtC+kN2OZk37tBpAO0clZOb9C0oZPJrI7Z9746O5sxaxFKEzxjW9/FEEgPMnpOrBREcPEJj
	Mm8VSgMda1CAMbXTvD/HOc9Q+6u5JSpYFqDOafpNUC0wF2kHni2RXt0rfDzvaCruE/EbJfU9w1+
	FB8xbfX6gKgVG7dX9WzR/I2w4bR+YqY8za64jgD3F9kvkbRClBSTBBK4gJzbapi0akIKyDc5dpd
	wEvB5Zw/71dOQPeE/7yx/cVjW6WEsiQxdc2JQ8+fAzw9P3tMv8=
X-Received: by 2002:a05:7300:da15:b0:359:6382:5e52 with SMTP id 5a478bee46e88-359638267cfmr24171298eec.17.1792142414309;
        Fri, 16 Oct 2026 02:20:14 -0700 (PDT)
Received: from anuj-MacBookPro.. ([2406:7400:63:e55a:7bfc:fc3a:e718:89f6])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36082a7b33bsm9840943eec.24.2026.10.16.02.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 02:20:13 -0700 (PDT)
From: Anuj Gupta <anuj1072538@gmail.com>
To: asml.silence@gmail.com,
	hch@lst.de,
	djwong@kernel.org,
	cem@kernel.org,
	brauner@kernel.org,
	axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	joshi.k@samsung.com,
	anuj20.g@samsung.com,
	nj.shetty@samsung.com
Subject: [RFC 1/4] block: factor out bdev_init_dma_buf_io_ctx()
Date: Fri, 16 Oct 2026 14:49:11 +0530
Message-ID: <20261016091919.971295-2-anuj1072538@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261016091919.971295-1-anuj1072538@gmail.com>
References: <20261016091919.971295-1-anuj1072538@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nitesh Shetty <nj.shetty@samsung.com>

Factor the checks and driver setup into an exported helper that takes
an explicit block device, so filesystems can initialize a dma-buf I/O
context for the device backing a regular file. The block-device file
operation becomes a wrapper using file_bdev(), so its behavior is
unchanged.

Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
---
 block/fops.c           | 12 +++++++++---
 include/linux/blkdev.h |  3 +++
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index 49ae0302f123..18a755f6e0b0 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -934,10 +934,9 @@ static int blkdev_mmap_prepare(struct vm_area_desc *desc)
 	return generic_file_mmap_prepare(desc);
 }
 
-static int blkdev_init_dma_buf_io_ctx(struct file *file,
-				      struct dma_buf_io_ctx *ctx)
+int bdev_init_dma_buf_io_ctx(struct file *file, struct block_device *bdev,
+			     struct dma_buf_io_ctx *ctx)
 {
-	struct block_device *bdev = file_bdev(file);
 	struct gendisk *disk = bdev->bd_disk;
 
 	if (!(file->f_flags & O_DIRECT))
@@ -948,6 +947,13 @@ static int blkdev_init_dma_buf_io_ctx(struct file *file,
 		return -EOPNOTSUPP;
 	return disk->fops->init_dma_buf_io_ctx(bdev, ctx);
 }
+EXPORT_SYMBOL_GPL(bdev_init_dma_buf_io_ctx);
+
+static int blkdev_init_dma_buf_io_ctx(struct file *file,
+				      struct dma_buf_io_ctx *ctx)
+{
+	return bdev_init_dma_buf_io_ctx(file, file_bdev(file), ctx);
+}
 
 const struct file_operations def_blk_fops = {
 	.open		= blkdev_open,
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 2d555a992e75..a0abdf94e7d6 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1609,6 +1609,9 @@ struct block_device_operations {
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

