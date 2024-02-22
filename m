Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F8B1799F
	for <linux-block@vger.kernel.org>; Thu, 22 Feb 2024 07:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708586672; cv=none; b=ncsEJdY2cZ/wVkfxf1V0Ox626AX3ndDrHY0dMhfIAarIKPNRgIQHx4tPyEvORQTBdIlGDgI3ciOv5Jq9PJq2/iO6M6O4ofiR4A3OFS+hwHXtkVldjJcGNGUqmoXVywKY9g4gaiqCJxlIbuhkJuYBZQdZtDkOGJJsXufNg9wQZfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708586672; c=relaxed/simple;
	bh=ZsJemB2Am7PLEDU4QmQys8AqWXEaYW5k4r1EZGTk3W0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Dkiy/BjaQaQNmceW5WxFTmGVqX6qEa/QBSvQvUoWb+IL8oQlXhAB3VI3PHE3h+x2qbf4K7k5SrBKL9lpr4aT7htp3auy70791MqieJKuVgHFBvgLQFc3dP/W8FsVUnis/adOOAYE/e31DHrkaY0HUAs6h2coJFK6NR/bU98UFws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Eag9BblR; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Eag9BblR"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=XOrf8aRVfOLyUlEU9mfD8SHhHCuj9KCbbzXY0gtM8to=; b=Eag9BblRnTk83NT+8JgmaNd0LD
	MB5fC5BGQQUAm7yz4fSziww73vtO4ZRUC0VIH1eQgUzV3XyudjSEd35DPRJjMyLV+8BSEBV0CSjcx
	jrliV6bffM900tnL6ANHhhTyePN86uIGI5nzulLUEH5DFp/HPAoeXfZdGPK+gqLRy8PYT3l8aFfSI
	PWS/yjh3RT/EOzJyMowoNAKv7OBsoG3rn8/UWSObkBDJR9hhYD8Aou/Whkia1/nvl6b11cEvFSPk6
	mZZ6PfQI7eHjfWN1cK7Sdom1Z3fKxRDAauipfe/lEMAUm+tWNyw9lC1UIF39QNUl+I8oVDH+U1YWL
	C6I+0A/A==;
Received: from [2001:4bb8:19a:62b2:c70:4a89:bc61:3] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rd3RV-00000003nfE-1eoJ;
	Thu, 22 Feb 2024 07:24:29 +0000
From: Christoph Hellwig <hch@lst.de>
To: Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-um@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: [PATCH 4/7] ubd: move setting the variable queue limits to ubd_add
Date: Thu, 22 Feb 2024 08:24:14 +0100
Message-Id: <20240222072417.3773131-5-hch@lst.de>
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

No reason to delay this until open time.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/um/drivers/ubd_kern.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
index 9dcf41f7d49606..26bc8306356263 100644
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -772,8 +772,6 @@ static int ubd_open_dev(struct ubd *ubd_dev)
 	ubd_dev->fd = fd;
 
 	if(ubd_dev->cow.file != NULL){
-		blk_queue_max_hw_sectors(ubd_dev->queue, 8 * sizeof(long));
-
 		err = -ENOMEM;
 		ubd_dev->cow.bitmap = vmalloc(ubd_dev->cow.bitmap_len);
 		if(ubd_dev->cow.bitmap == NULL){
@@ -795,10 +793,6 @@ static int ubd_open_dev(struct ubd *ubd_dev)
 		if(err < 0) goto error;
 		ubd_dev->cow.fd = err;
 	}
-	if (ubd_dev->no_trim == 0) {
-		blk_queue_max_discard_sectors(ubd_dev->queue, UBD_MAX_REQUEST);
-		blk_queue_max_write_zeroes_sectors(ubd_dev->queue, UBD_MAX_REQUEST);
-	}
 	return 0;
  error:
 	os_close_file(ubd_dev->fd);
@@ -867,6 +861,13 @@ static int ubd_add(int n, char **error_out)
 	if(ubd_dev->file == NULL)
 		goto out;
 
+	if (ubd_dev->cow.file)
+		lim.max_hw_sectors = 8 * sizeof(long);
+	if (!ubd_dev->no_trim) {
+		lim.max_hw_discard_sectors = UBD_MAX_REQUEST;
+		lim.max_write_zeroes_sectors = UBD_MAX_REQUEST;
+	}
+
 	err = ubd_file_size(ubd_dev, &ubd_dev->size);
 	if(err < 0){
 		*error_out = "Couldn't determine size of device's file";
-- 
2.39.2

