Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C9725F99F
	for <linux-block@vger.kernel.org>; Wed, 25 Jun 2025 11:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750851340; cv=none; b=SyLBeyFgGafohrtA8P/Zd4gasuTZ6PfpiH5IcTH851tZ0tqBVG84+2n9suQ/j4eANNOnnJtSk/bBei+2gc7v5LWRcQsu9OohUEksOM05E/pojL+784/SXccM7VuiqZc1wERSAI+JivDPak73RrbQl3qxRf0Ea5h5m5DqiSFEH1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750851340; c=relaxed/simple;
	bh=Sh47LFpnAMWCB7fC217TanCpuO2b9d7LEz9ILH9r/co=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S9Pr4MdMGZ2InafQ9cPItokc21mLOl3GmrX16hp61ihrJzNMErI+LtjdUmvVT3rvSy7fSx1ipjOkFirDuQeIMvj0CGqQzJvrDQPKPA775QDHuWR+IM6CTuDHJLZeDY2zHD4IjlQg+PxFguqsSRAoD90gmdrwm/HYJqmajGoAlEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=R2S/Cpxi; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="R2S/Cpxi"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=c29CYBpAPPEOfpJB62td/zLaZYqQJd0Dmy9+pT82Gfs=; b=R2S/Cpxi84jSPRcbZ7UCBc0nn7
	ToyXwzfrKQmSk2ZBc11BY2AaXXMzJ9qgHRY21QcPX14+ca3FB472jH2FzuSflwxNV0/A1sYeII+qQ
	cqDg6Wgfb4cXU1Y6eaQg0QUrEwq9x76Uqwgqb9oFnP1tiQ3gTMY+wCmZm0JANdGCV26H5KREO2Wp/
	MbHpyYAM0T8I71EHpSVX6AYMaYXGe+oE7C8aTlJpWC8qCLVdVNPzoPm6VrKTpXRzpny/pAI3bbFl/
	7WraVB8WBglULog+Yot4HX1c+mhEJPcKYhYR/JM8gM678QTTrNfkMPAAAdlGsll13mDj9gJtxVFIg
	fJ9Lrzdw==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUOPe-00000008Uxc-3IKi;
	Wed, 25 Jun 2025 11:35:35 +0000
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
Subject: new DMA API conversion for nvme-pci v3
Date: Wed, 25 Jun 2025 13:34:57 +0200
Message-ID: <20250625113531.522027-1-hch@lst.de>
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

Chances since v2:
 - fix handling of sgl_threshold=0

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
