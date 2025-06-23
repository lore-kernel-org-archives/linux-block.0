Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E0D76C61
	for <linux-block@vger.kernel.org>; Mon, 23 Jun 2025 14:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750687989; cv=none; b=iwyk80TzQQeIL4HcW92tePQmNHpSBiIFExMCsWOHeOw55z8AUQva2ecYYRJN6999RLxAVk69C9O/lnXkbo4GIazm4K0859LLUS07LYj4jwyIhZTupZ0OTOxUcuiA7jaAn5nSEP7xa1fBBdGBCzF1UNjCHxkgb1be9IC5uOQwb6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750687989; c=relaxed/simple;
	bh=9uWRHairGuzG4eQaRfvpePihHdXzvdIwFzCfZe6VTFo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WOM/UYTqqbIVEnv5CLX9AVG08GBi/lLKl549NGiBgcNX7+DwI9E1dmOgAl8XaqQj8sRwpfe5Cv/hw1HZo40xFxu0K6+9DOVgqh2dAzLTxqe55bXE+niLm31Y4KOxIAjeUpj5tKCDYUGVmqx+e1wSsx36gEFLALZ/WZaZMLlb/bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=3l9J+0YK; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="3l9J+0YK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=Q097w0ZyqCvrAzlM9OmfT43N2f+DOIgOZ476YQyVkRM=; b=3l9J+0YKZy3F76xtYL8a3DMpDe
	qFioPaYXPXfIRXR8GyRfGAxMSqZQjCDrFCjaMhcuOeMQGHcrsQatzl5UpGbqbpMjEmu8pyr9y0Hf0
	kM2OhyU4tcmunNZLx6n6QIih6CpBWoO6utB6bQ1XVeof0Ry/cpmASPC+SDhcxWXZsa0cnmnxKaJYv
	EzKczPBKNItnXVwat0OqrD2gxH+1K9/6EHiq6ZNCJZrplL78LJbmXKl7nAG66gt3LWB3zCt0kxoh4
	tcimSy5zpNJto/e8Ejn32sz7Lwf8akA1DB0UPv9SV/tXTyIs5Dk24yTRAg2SpHEH5Xj4ciSm6MOmz
	d1yLv5dw==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uThuy-00000002zn3-0oc2;
	Mon, 23 Jun 2025 14:13:04 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Leon Romanovsky <leon@kernel.org>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: new DMA API conversion for nvme-pci v2
Date: Mon, 23 Jun 2025 16:12:22 +0200
Message-ID: <20250623141259.76767-1-hch@lst.de>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Hi all,

this series converts the nvme-pci driver to the new IOVA-based DMA API
for the data path.

Chances since v1:
 - minor cleanups to the block dma mapping helpers
 - fix the metadata SGL supported check for bisectability
 - fix SGL threshold check
 - fix/simplify metadata SGL force checks

Diffstat:
 block/bio-integrity.c      |    3 
 block/bio.c                |   20 -
 block/blk-mq-dma.c         |  161 +++++++++++
 drivers/nvme/host/pci.c    |  615 +++++++++++++++++++++++++--------------------
 include/linux/blk-mq-dma.h |   63 ++++
 include/linux/blk_types.h  |    2 
 6 files changed, 597 insertions(+), 267 deletions(-)
