Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176F621B45D
	for <linux-block@vger.kernel.org>; Fri,  8 Nov 2024 15:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731080828; cv=none; b=I41mVZGNTHGT6wNwQFFPdV1VcE6Rhpo5IwK3EwtrOmGSGsAaEo5V12QZcZF5kmmz3rdM1VooRNGE5cbUOM9Vf+1Kqax+jgyQWJrT5mp3lT4m1qIglhKyc1WGhbUs03T1feSG9sQ+c3JyUyb+lju03oXf1PvP99BrGUvlEMElEo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731080828; c=relaxed/simple;
	bh=ctJqDrzhar5r6p2ftiRxP6lLdozMnhy8hLmOe6TABlM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mXB6f0/1wpjMGWiAI3yg4v0OzJMTNViM3S+tcCaVqoelJZKi8gNoV5Jh+xwGXhTc8dzi+9iGWPbP2qpFCadCnNDIISxVAOf8hSTLoPYXQa9kBbaUorBxnvLDtSMc0ekgWzlAh3ElOsNi1xYrThbfgzZacAc5NM6twugflD8WOpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=3D6ktTIP; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="3D6ktTIP"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=O2pI4muBBDotpdXxdR5iT9OwjkhWYqDjshZgezWHTJk=; b=3D6ktTIP58WA0EFvOgay2Os+YY
	1uX0QBHg/ELmCIYZr/CMF6KRLIfpFGaTV01HZrLyUmtmkfrbpt6GApW/yCY7Roj7fIrtCpY/lvbr7
	4Zqk8rHnfGOU/qkIX7gB3f4SqIOZLeVrLvElN0BMSrKL0WRv/tf90S9CtU7lUefTm26oUTD4BBAbY
	euxnF55W1dqMxmJuBTD6w/9wHS1HNIu9dNilrYALr7cE1SE1BGWTiaEC3acqTpP3n3CxwdNRwCO91
	+ytVUA/Vhxk4kibL2KRh5aSXFrQXAdnjHx8k30Lehnmwmzj5Czkkey2gn0pSS7bwNdCyyAk7M5nxg
	DAoYp5wQ==;
Received: from [212.185.66.19] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t9RCU-0000000B5cq-1N3V;
	Fri, 08 Nov 2024 15:47:06 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	linux-block@vger.kernel.org
Subject: [PATCH 2/2] nvme-multipath: don't bother clearing max_hw_zone_append_sectors
Date: Fri,  8 Nov 2024 16:46:52 +0100
Message-ID: <20241108154657.845768-3-hch@lst.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241108154657.845768-1-hch@lst.de>
References: <20241108154657.845768-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

The limits stacking now properly zeroes it if at least one of the
underlying limits clears it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/multipath.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index c26cb7d3a2e5..f04cfe3fb936 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -635,8 +635,6 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
 	lim.features |= BLK_FEAT_IO_STAT | BLK_FEAT_NOWAIT | BLK_FEAT_POLL;
 	if (head->ids.csi == NVME_CSI_ZNS)
 		lim.features |= BLK_FEAT_ZONED;
-	else
-		lim.max_hw_zone_append_sectors = 0;
 
 	head->disk = blk_alloc_disk(&lim, ctrl->numa_node);
 	if (IS_ERR(head->disk))
-- 
2.45.2

