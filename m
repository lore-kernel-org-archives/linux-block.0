Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64FF31799C
	for <linux-block@vger.kernel.org>; Thu, 22 Feb 2024 07:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708586668; cv=none; b=fm5HXe6JqU8hobyctTZCifOSNW/4S9KQRzMT8QbkY3MD9uACKwWTg33As7b5BtzKfftY6K95J0X9HWbpoE1dYGPa3wxj+7+LqfoAYMB1JrtwNIf+AnG7XhmSswXUO7P8o+jYOHXNGraIvr72w7sbM6YvvN4al+BP014vv/geZXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708586668; c=relaxed/simple;
	bh=vb9g5hXZqbWYnhfJqcSYR3cl58PvqYkQbZA21N4y1oI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dZ/QL0JfJfy1JIF9WozyoGHpkBz5rWpKaZ+TDAKZor5FFgiOuU1aRgw2djR8MpNdz99yGXZJ4Fg55lTffGQKzwiPHL/FZZGjha7FyZ4zaUK2DzCMuEmtTm4gOYhXAdocX5xPhK1NwfeSOcFAaAGNdhOOOyDskV1zfSFvx4K02Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HbIiGWGr; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HbIiGWGr"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=cTy5ByRm6yl9copb54tFACKFS8S5cRwyQfPP7IgncdE=; b=HbIiGWGrhljmpDEC6OzKVfdVyd
	V+emT/QF9FFj13OIKzJc3PNTiqHMsSNadL52I7Xk1qIayH+2sma1aukGXuA+Do6+GWrNImq0nX0pn
	76ienUdw2AZjkxTNjZLfZSypLjIg8m28E7lDrMDgzdpzi3+Lmyfmu7Jfw5+Z75DhxWISkQi0GvdRk
	qr7g4m9R1jaR8H4KvdzSZeFHckdlxWY8kfUcpbBF2GAWGG/6Zprx9KpHXBLwy2SJvoIF4A4/8+poE
	qu7MMi+RQXR4o6GtZyi/7OVrcnZMLrNWOO1kd/FVUWzaMH+0br5RVC5SPc2eLOEViG39b1be1+8Ny
	85ChpUjQ==;
Received: from [2001:4bb8:19a:62b2:c70:4a89:bc61:3] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rd3RQ-00000003nd1-0gxi;
	Thu, 22 Feb 2024 07:24:24 +0000
From: Christoph Hellwig <hch@lst.de>
To: Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-um@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: [PATCH 2/7] ubd: remove ubd_disk_register
Date: Thu, 22 Feb 2024 08:24:12 +0100
Message-Id: <20240222072417.3773131-3-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240222072417.3773131-1-hch@lst.de>
References: <20240222072417.3773131-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Fold it into the only caller to remove lots of references to the
global ubd_devs array.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/um/drivers/ubd_kern.c | 37 +++++++++++++++----------------------
 1 file changed, 15 insertions(+), 22 deletions(-)

diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
index b203ebb1785125..ef05157acd6b02 100644
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -849,27 +849,6 @@ static const struct attribute_group *ubd_attr_groups[] = {
 	NULL,
 };
 
-static int ubd_disk_register(int major, u64 size, int unit,
-			     struct gendisk *disk)
-{
-	disk->major = major;
-	disk->first_minor = unit << UBD_SHIFT;
-	disk->minors = 1 << UBD_SHIFT;
-	disk->fops = &ubd_blops;
-	set_capacity(disk, size / 512);
-	sprintf(disk->disk_name, "ubd%c", 'a' + unit);
-
-	ubd_devs[unit].pdev.id   = unit;
-	ubd_devs[unit].pdev.name = DRIVER_NAME;
-	ubd_devs[unit].pdev.dev.release = ubd_device_release;
-	dev_set_drvdata(&ubd_devs[unit].pdev.dev, &ubd_devs[unit]);
-	platform_device_register(&ubd_devs[unit].pdev);
-
-	disk->private_data = &ubd_devs[unit];
-	disk->queue = ubd_devs[unit].queue;
-	return device_add_disk(&ubd_devs[unit].pdev.dev, disk, ubd_attr_groups);
-}
-
 #define ROUND_BLOCK(n) ((n + (SECTOR_SIZE - 1)) & (-SECTOR_SIZE))
 
 static const struct blk_mq_ops ubd_mq_ops = {
@@ -916,7 +895,21 @@ static int ubd_add(int n, char **error_out)
 	ubd_dev->queue = disk->queue;
 
 	blk_queue_write_cache(ubd_dev->queue, true, false);
-	err = ubd_disk_register(UBD_MAJOR, ubd_dev->size, n, disk);
+	disk->major = UBD_MAJOR;
+	disk->first_minor = n << UBD_SHIFT;
+	disk->minors = 1 << UBD_SHIFT;
+	disk->fops = &ubd_blops;
+	set_capacity(disk, ubd_dev->size / 512);
+	sprintf(disk->disk_name, "ubd%c", 'a' + n);
+	disk->private_data = ubd_dev;
+
+	ubd_dev->pdev.id = n;
+	ubd_dev->pdev.name = DRIVER_NAME;
+	ubd_dev->pdev.dev.release = ubd_device_release;
+	dev_set_drvdata(&ubd_dev->pdev.dev, ubd_dev);
+	platform_device_register(&ubd_dev->pdev);
+
+	err = device_add_disk(&ubd_dev->pdev.dev, disk, ubd_attr_groups);
 	if (err)
 		goto out_cleanup_disk;
 
-- 
2.39.2

