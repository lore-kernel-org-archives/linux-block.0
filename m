Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E23759B46;
	Mon, 22 Jan 2024 17:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705945035; cv=none; b=MmFhjEwbUC6c7avxJP11vrNMBpqWgojN4dCNIYyeYw3Ed2y+4rScK9GkllEF5LKENFg4Wdrr8r0La6shy3a1TE43NzP5Kr5efarE2/VgOqOYV7bQjfmjIM7eeudIn+0ZHZJMM0wr4LDnuYJKhNtMi7TXD9JVRlCGZhYDZyBzuUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705945035; c=relaxed/simple;
	bh=xy0BeYL3mUJ5e7KYLsaN9ZPi/KXZkZeh/8QlMyEp2Cg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s4KnmhoAAqATMLpwDoXFYdaCzHgiJhl3CAvDtMUuUMbXeiSOsnjcnA0WwJ6w7EBJXF7i8FsRyjmVE737YD+mMxXuDUDeHeDuggmAS7/BVCKwPj10xq7UeZxRJ9PSPcLY0vzx6X9PLk8XZUU1oKimFP1xoDC76skbyk8Mjh3uqLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qXLjG4SO; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qXLjG4SO"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=QGWbKYlVFWK+oadU1xwjKPo8yRfdDiY9GpjAcsWorHA=; b=qXLjG4SO2PpqWaS53xSdhHfCEw
	BEtbSC+n7soYkoyfUsNlunf3c+VjbN8pGaMF7tRrD5n+yRa7riOdrtU2L3wM+91USBC55pqwGgm53
	43iCqXVBRdkJwC0k69xFrDqiASCFc+IM3qPteLkTwGCtHcWCoo8tvlkvOmK39XDiiIM+Sp+mbsmhk
	SZmAQrRYr2KBR+gN9IikcjLMDJu9SQNRi1Tcigm2Dsz/KIQxtwJCmIKWrxD4OoABCjEH+U81i0xeP
	Ea3iYifMuyxVOlMAuvrdL8aJmXYfHoESDNadBVRKU3QXQtSYBhm5HKIGS95lMl6XPnESNxZ71Gliv
	VUc1w5ww==;
Received: from [2001:4bb8:198:a22c:146a:86ef:5806:b115] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rRyEK-00DGiY-2D;
	Mon, 22 Jan 2024 17:37:05 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	virtualization@lists.linux.dev
Subject: [PATCH 06/15] nvme: remove the hack to not update the discard limits in nvme_config_discard
Date: Mon, 22 Jan 2024 18:36:36 +0100
Message-Id: <20240122173645.1686078-7-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240122173645.1686078-1-hch@lst.de>
References: <20240122173645.1686078-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Now that the block layer tracks a separate user max discard limit, there
is no need to prevent nvme from updating it on controller capability
changes.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 85ab0fcf9e8864..ef70268dccbc5a 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1754,16 +1754,6 @@ static void nvme_config_discard(struct nvme_ctrl *ctrl, struct gendisk *disk,
 	BUILD_BUG_ON(PAGE_SIZE / sizeof(struct nvme_dsm_range) <
 			NVME_DSM_MAX_RANGES);
 
-	/*
-	 * If discard is already enabled, don't reset queue limits.
-	 *
-	 * This works around the fact that the block layer can't cope well with
-	 * updating the hardware limits when overridden through sysfs.  This is
-	 * harmless because discard limits in NVMe are purely advisory.
-	 */
-	if (queue->limits.max_discard_sectors)
-		return;
-
 	blk_queue_max_discard_sectors(queue, max_discard_sectors);
 	if (ctrl->dmrl)
 		blk_queue_max_discard_segments(queue, ctrl->dmrl);
-- 
2.39.2

