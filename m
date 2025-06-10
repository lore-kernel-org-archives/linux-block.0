Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83DEA4C96
	for <linux-block@vger.kernel.org>; Tue, 10 Jun 2025 05:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749532067; cv=none; b=VAOlOsuPC7zN15XcQT9WG8dJQPKznTrL7YE4t7UT6iHiTWW9GDGZvveR9lIs9DZb8XPbCNqxIDfI8SvF+T0CXB064QAI4hTRA5rCWVeW5RawzPrJ1GCFa7DDH6TOIdSKga9sS7Bt9ExX//yABqZemiLdxgcRBEWeQkO+XyhrW64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749532067; c=relaxed/simple;
	bh=KZ31DLrX/Uwenh8tkGG3p5ZlhBF4EYwrGdMcofurD2o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mySLevjzEFKgqQhbaRTIK6Jw3S7qTVhdyamwJsDia2dmgJieDGbIxfYiGR/667GqK4riu53ZNAZmJvM8x27Tp3cJ9JkkktqvCyU8T9j449JUdDRaGABb9DRJi5WA58JTqct4m3DTuCkZv0iiTtJm1ak+ztYWMOdmLuj54LqeW9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QufkivMd; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QufkivMd"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=jgVMrbIUH7S9f5z7P44kf3rsayMGHSsX4g1Xl7cVfWU=; b=QufkivMd+Bxg3un6kC4auhif2G
	kgYyX8PpAB5kJ2GTq2SYoLnbDRQraaadRK6B27fK4gegHfhlY0X00iVb1t5GibJBw/gcDya8FFbWy
	C5AMGsnCyni49Yw/u5cPU6+a5m+2cfpHOrNb4MdpfQnySX/YaSth0xGBUg+uakpn2CJHa2e2F7w2Y
	OCJnVsBAw7JiaKnD0e21HtVTB4o4lv8DW3DKu35UFYFiobvtj5GO2rzsbDdCVgK64UySM4YlS1Z7/
	ml7dpBMq+w5qHqw2mMtG2UNBE0kWLZCOxN+BlQYtaJJOfnnRMZBoS+BNul/yS9wMi76mdzQBkFzJB
	9Pzx9nsQ==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOrD6-00000005nv9-0lk4;
	Tue, 10 Jun 2025 05:07:45 +0000
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
Subject: [PATCH 8/9] nvme-pci: replace NVME_MAX_KB_SZ with NVME_MAX_BYTE
Date: Tue, 10 Jun 2025 07:06:46 +0200
Message-ID: <20250610050713.2046316-9-hch@lst.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250610050713.2046316-1-hch@lst.de>
References: <20250610050713.2046316-1-hch@lst.de>
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
---
 drivers/nvme/host/pci.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 2d3573293d0c..735f448d8db2 100644
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
@@ -3363,7 +3362,8 @@ static struct nvme_dev *nvme_pci_alloc_dev(struct pci_dev *pdev,
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

