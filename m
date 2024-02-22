Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9E917988
	for <linux-block@vger.kernel.org>; Thu, 22 Feb 2024 07:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708586674; cv=none; b=t3uK/+L3bBtoRS5CCCp09oPFHkx+xowgbLjeIrj5lPMZV3Yre5W3VoQJ0gv0uAcI2YXKl36Sahxq/nyyzGIbD8e3FQB5mie6ruhRbp1aYD2u/1ZcWIdGqvOLTvO/ihjrbsoGjBpMSg/17GsXGe13OTZARiUQua8gA8oYsQqIDcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708586674; c=relaxed/simple;
	bh=xtAx8cWP72AJuDwX5dfWdD60bPkyuO57428kgFzM/xw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ulLpheZHzsNpFs1q/uju6H6ORnJ/out+VE/ijTVfPAlPncTxa7wo6Hx2pIrm2HTKrJumPIwH0LJN7YXstlUjpKZ621vwSdnc4FOGP4KRlrTtaiCKthNF4lgsVZ2pKSexj1NvGdV2oJpCkgbIhoXEU5lb3ayY+yQQP6O3kS2MKEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=iDw57dsC; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iDw57dsC"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=rSTF8EhkpxTeqhstKIyynLGq4fa8o7QHCgP9WngjV84=; b=iDw57dsCp+CcU/y95KaxGg4bEM
	DE6Dmhigd8MGFVx5s8UHtQNNHc97+JeMOqINLaRKtlRDVm4k+8LYH2hZC/Mn2GI+d6uy/03mx4eN3
	L4JncjhapPO8VvQPBt11219fLFO8Uz2pr1EiUMEMvxEtgDgddQLVlOKi/ENDgmcfFpuWn3dyxfyu/
	IQ+VEOcQASlQ0rrQHJMJTrUCJvY6RY/dQJx8IeJiTILBdL7McQraRz2TGjtMnuA870gl5nUPu7r/i
	qZbTOVvfn3tKtLi/UimuK3o6t2uOE2H/4NqENXvDAKU7KAa9ct0RcT4FVlSPTPmO5CREC9aG2Adyb
	Wz4dmRYg==;
Received: from [2001:4bb8:19a:62b2:c70:4a89:bc61:3] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rd3RX-00000003nfv-4465;
	Thu, 22 Feb 2024 07:24:32 +0000
From: Christoph Hellwig <hch@lst.de>
To: Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-um@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: [PATCH 5/7] ubd: move set_disk_ro to ubd_add
Date: Thu, 22 Feb 2024 08:24:15 +0100
Message-Id: <20240222072417.3773131-6-hch@lst.de>
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

No need to delay this until open time.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/um/drivers/ubd_kern.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
index 26bc8306356263..c5d32e75426366 100644
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -903,6 +903,7 @@ static int ubd_add(int n, char **error_out)
 	set_capacity(disk, ubd_dev->size / 512);
 	sprintf(disk->disk_name, "ubd%c", 'a' + n);
 	disk->private_data = ubd_dev;
+	set_disk_ro(disk, !ubd_dev->openflags.w);
 
 	ubd_dev->pdev.id = n;
 	ubd_dev->pdev.name = DRIVER_NAME;
@@ -1159,7 +1160,6 @@ static int ubd_open(struct gendisk *disk, blk_mode_t mode)
 		}
 	}
 	ubd_dev->count++;
-	set_disk_ro(disk, !ubd_dev->openflags.w);
 out:
 	mutex_unlock(&ubd_mutex);
 	return err;
-- 
2.39.2

