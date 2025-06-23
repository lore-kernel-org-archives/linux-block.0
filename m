Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D4424BC0A
	for <linux-block@vger.kernel.org>; Mon, 23 Jun 2025 14:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750688008; cv=none; b=E5A7M8sgdlj2I/88YxzZxQcyowuetVX7sXx5xxvp2GzrpuFBMuTnsEdLkoptqd9ty5gjmSMTnJSvu7fxm0bEquAPY+EqPNwEDTyn85978pYOWFfL/90VXHr+JygUSayq5Bx5q69lG2hMfCX9TGr2VfOSIfJoWmWOMLxi8bLIJwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750688008; c=relaxed/simple;
	bh=Hxb89UgMr8OUX4B4AtnXJhHTLdBcZzeSZi5SP48QNdk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AeMJcKOUZgq8isWJ8nTPj8HBRM2bUlYD+psHpocXEyIO33jMHEtZadxWIWfy9BVtNpKfbAsBEbaGbQ9hb08xckUmujKISpflETIdsLbgc89eySpglBTcAvqt8rjCi2JTp0EazNYLXF0bdyQpfRwTIvPazwaPuacM6yPFeI4fHww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hzVFcWvf; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hzVFcWvf"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=nCK2heZ2hSWzYFxFxIIZWJKPXrvEXshT9rSTUJdQzLI=; b=hzVFcWvf9DN5KgiousGwCUY6Wy
	2Q1NSowiYfmnVhz2R7MZ37ex9K1NPPWAXz5b81p546mF6KbCQMZdll68TnPtVjGvv/Il/vQsdLQSJ
	ZbTqNiVdVPEiDbMhbghOMAv5f2INCWSZ0qCrqPmzdzC3LLzl8Xo7nko2sx+Aw5hSXHoWQJKtniaB8
	Cx55FUf/6cf03L1Vkx54qjdLfDlUYlfUFhCTSycPUXuyRONrcvAejNhTboOyaVzqceye3vuOufbev
	AzOPUdATj8fQad6cU2cPnwbcmt9r5twozqMGutZyZQvB13x8PFyPrrZZWhd9KksID8QBqZAGiyL9g
	KbIYZdfg==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uThvI-00000002zrz-3jXZ;
	Mon, 23 Jun 2025 14:13:25 +0000
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
	linux-nvme@lists.infradead.org,
	Daniel Gomez <da.gomez@samsung.com>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: [PATCH 7/8] nvme-pci: replace NVME_MAX_KB_SZ with NVME_MAX_BYTE
Date: Mon, 23 Jun 2025 16:12:29 +0200
Message-ID: <20250623141259.76767-8-hch@lst.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250623141259.76767-1-hch@lst.de>
References: <20250623141259.76767-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Having a define in kiB units is a bit weird.  Also update the
comment now that there is not scatterlist limit.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Daniel Gomez <da.gomez@samsung.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/nvme/host/pci.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 040ed906c580..4bcd1fdf9a71 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -38,10 +38,9 @@
 #define NVME_SMALL_POOL_SIZE	256
 
 /*
- * These can be higher, but we need to ensure that any command doesn't
- * require an sg allocation that needs more than a page of data.
+ * Arbitrary upper bound.
  */
-#define NVME_MAX_KB_SZ	8192
+#define NVME_MAX_BYTES		SZ_8M
 #define NVME_MAX_NR_DESCRIPTORS	5
 
 /*
@@ -413,7 +412,7 @@ static bool nvme_dbbuf_update_and_check_event(u16 value, __le32 *dbbuf_db,
  */
 static __always_inline int nvme_pci_npages_prp(void)
 {
-	unsigned max_bytes = (NVME_MAX_KB_SZ * 1024) + NVME_CTRL_PAGE_SIZE;
+	unsigned max_bytes = NVME_MAX_BYTES + NVME_CTRL_PAGE_SIZE;
 	unsigned nprps = DIV_ROUND_UP(max_bytes, NVME_CTRL_PAGE_SIZE);
 	return DIV_ROUND_UP(8 * nprps, NVME_CTRL_PAGE_SIZE - 8);
 }
@@ -3367,7 +3366,8 @@ static struct nvme_dev *nvme_pci_alloc_dev(struct pci_dev *pdev,
 	 * over a single page.
 	 */
 	dev->ctrl.max_hw_sectors = min_t(u32,
-		NVME_MAX_KB_SZ << 1, dma_opt_mapping_size(&pdev->dev) >> 9);
+			NVME_MAX_BYTES >> SECTOR_SHIFT,
+			dma_opt_mapping_size(&pdev->dev) >> 9);
 	dev->ctrl.max_segments = NVME_MAX_SEGS;
 	dev->ctrl.max_integrity_segments = 1;
 	return dev;
-- 
2.47.2

