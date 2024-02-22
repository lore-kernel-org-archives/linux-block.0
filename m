Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0E317988
	for <linux-block@vger.kernel.org>; Thu, 22 Feb 2024 07:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708586677; cv=none; b=ZekjA7RvpOc0HmxZVMRRPPWEDGX1LCJxBFcPadiNEGCsCNEJiODnV1q9Ni/KvR7RJi2fTol8A54sKIksh3aMGGvEdEWuiK9tZRDXk8XksOjMg2nJOKyXh0Bp+XavolVlxkYQsF/1SfMFhcBnu5OB78B1nzp9Jmqfcxd/GjP0YJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708586677; c=relaxed/simple;
	bh=JyRp/OahnGgPHjxodDKgy3d0/tKem2XxDYNixBXcIeM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RPe2k5qlbFsQzUUIkuCJ/OwcIITH+cxX+a/owyXboFIPzp2fzu5WpAKCJJ0e223Qe07KUJ24jvt3Gyr4mb6yJ6FfzV6Nv1fH4Eavcw8ZzT2xicegJ+Hjq+d4/W/BqXwuIKqNxa4lIFFM1+6zaNi9zFKh33gc6vkvgRk7NFhzK60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VEAmIdFv; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VEAmIdFv"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=g/2GmS4AXLXXjlfuzEY4M+H/g1Vi8otqWk2R/DkaXmE=; b=VEAmIdFvHIObdHoyFHLq6Tqj3r
	i3mZ8eu8VLsb2bkNXK29+np+SjT2qXOP2HWbPC+6pV3nG5HdiRj1oryU7/fA/SOdg2cxYoWCqQtft
	3jvkBW01nYDUP2lBwp3kOLxK1DtqTNatyswDGheIB+KOWJ39i6LwM5bpFwj9OiFFRHY4kN1rMHbj2
	x6+ACBJeIwTIr93DJxDbfY+Y25hO+fn5G6GS/aDrGoLD47tKI18OdPY0IwNTj/Rnnfo8IezMjpaiu
	q0Q7tvHRQHimK8NyJS2ebgSAhB8JHyAfJPBeNk9uNt737/vfYrJGB9dJIE3hwqxYc/UnS53H5Bfig
	QsHcR62A==;
Received: from [2001:4bb8:19a:62b2:c70:4a89:bc61:3] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rd3Ra-00000003nhe-2Cdb;
	Thu, 22 Feb 2024 07:24:34 +0000
From: Christoph Hellwig <hch@lst.de>
To: Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-um@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: [PATCH 6/7] ubd: remove the queue pointer in struct ubd
Date: Thu, 22 Feb 2024 08:24:16 +0100
Message-Id: <20240222072417.3773131-7-hch@lst.de>
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

No need for it now, everything goes through the gendisk.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/um/drivers/ubd_kern.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
index c5d32e75426366..9bf1d6a88bae59 100644
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -163,7 +163,6 @@ struct ubd {
 	struct cow cow;
 	struct platform_device pdev;
 	struct gendisk *disk;
-	struct request_queue *queue;
 	struct blk_mq_tag_set tag_set;
 	spinlock_t lock;
 };
@@ -892,10 +891,9 @@ static int ubd_add(int n, char **error_out)
 		err = PTR_ERR(disk);
 		goto out_cleanup_tags;
 	}
-	ubd_dev->queue = disk->queue;
 
 	blk_queue_flag_set(QUEUE_FLAG_NONROT, disk->queue);
-	blk_queue_write_cache(ubd_dev->queue, true, false);
+	blk_queue_write_cache(disk->queue, true, false);
 	disk->major = UBD_MAJOR;
 	disk->first_minor = n << UBD_SHIFT;
 	disk->minors = 1 << UBD_SHIFT;
-- 
2.39.2

