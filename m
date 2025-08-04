Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F012550A4;
	Mon,  4 Aug 2025 12:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754311420; cv=none; b=Fo5l9zW4Iou+8v2zEPxoALhwM/eEGRbx2Cc2Fwe6Zb4vreXltFcLCJFrK6mZJmS99BLxpaniNDHzAa3JcuBYzoH3d6F/EFTNWeLbVp5ttufsJiHsx/NVxd3lEEjnSzNUuJkXtFPZErKHweq38oZSJruxsufmz7TPb6vYHZkERIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754311420; c=relaxed/simple;
	bh=KuB85oQ1zEvHewxjvaa7TgR+vPeGP91gwiah2Yizc2c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XnZ61X0N2ZKQ3+wLTTY0ffsQ23sSLBzCgGIAnBEQ0ER5P1bR95g4nZgX5tYbPQXRfQt/xmBLwE6uzTxUK/3Y/QhQj8uRLtMyqKy93UcHW/Ja1yI+h0dUH1TU1fbxJDePEss1XzaQe6JpppO6QH5E5oE8AJWfy39DTg8/O0hC7Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hwpc/2Lt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hwpc/2Lt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6868C4CEF0;
	Mon,  4 Aug 2025 12:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754311420;
	bh=KuB85oQ1zEvHewxjvaa7TgR+vPeGP91gwiah2Yizc2c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hwpc/2Lt2D3anuuHX/CywReJ+JevkzY6FynhQNLZcPcidH3a8z4Y3cZmYKqJx40aB
	 HuWBeZEysO6t3oSzFklaWg8fzR58b4rw4vPFNALiUc9A9irWH9TDeW0nOLlTcNMjg5
	 8y75jvY8oofTniAsxP4pz8Mu3KaSfgmilMiaTliZ/mjlKSNBhY+c10mFYtQHZ4AR/7
	 Xmk6xDyL82OWzMQWw/B3tiObakK+I7qRBS7g9Wgz6viepi3WB5CZHiWKKRcEEGPKzI
	 Kj0BbJnhOLGzRPSZ09k5YVjeQRC0y6mBjsRtkaL/iwYbfSRrLhH2F4a0OA4eEyJn4C
	 wZIRnvkij7dkA==
From: Leon Romanovsky <leon@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Leon Romanovsky <leonro@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>,
	Danilo Krummrich <dakr@kernel.org>,
	iommu@lists.linux.dev,
	Jason Wang <jasowang@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Joerg Roedel <joro@8bytes.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Juergen Gross <jgross@suse.com>,
	kasan-dev@googlegroups.com,
	Keith Busch <kbusch@kernel.org>,
	linux-block@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-nvme@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-trace-kernel@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	rust-for-linux@vger.kernel.org,
	Sagi Grimberg <sagi@grimberg.me>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	virtualization@lists.linux.dev,
	Will Deacon <will@kernel.org>,
	xen-devel@lists.xenproject.org
Subject: [PATCH v1 06/16] iommu/dma: extend iommu_dma_*map_phys API to handle MMIO memory
Date: Mon,  4 Aug 2025 15:42:40 +0300
Message-ID: <09c04e0428f422c1b13d2b054af16e719de318a3.1754292567.git.leon@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1754292567.git.leon@kernel.org>
References: <cover.1754292567.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>

Combine iommu_dma_*map_phys with iommu_dma_*map_resource interfaces in
order to allow single phys_addr_t flow.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/iommu/dma-iommu.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 11c5d5f8c0981..0a19ce50938b3 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -1193,12 +1193,17 @@ static inline size_t iova_unaligned(struct iova_domain *iovad, phys_addr_t phys,
 dma_addr_t iommu_dma_map_phys(struct device *dev, phys_addr_t phys, size_t size,
 		enum dma_data_direction dir, unsigned long attrs)
 {
-	bool coherent = dev_is_dma_coherent(dev);
-	int prot = dma_info_to_prot(dir, coherent, attrs);
 	struct iommu_domain *domain = iommu_get_dma_domain(dev);
 	struct iommu_dma_cookie *cookie = domain->iova_cookie;
 	struct iova_domain *iovad = &cookie->iovad;
 	dma_addr_t iova, dma_mask = dma_get_mask(dev);
+	bool coherent;
+	int prot;
+
+	if (attrs & DMA_ATTR_MMIO)
+		return __iommu_dma_map(dev, phys, size,
+				dma_info_to_prot(dir, false, attrs) | IOMMU_MMIO,
+				dma_get_mask(dev));
 
 	/*
 	 * If both the physical buffer start address and size are page aligned,
@@ -1211,6 +1216,9 @@ dma_addr_t iommu_dma_map_phys(struct device *dev, phys_addr_t phys, size_t size,
 			return DMA_MAPPING_ERROR;
 	}
 
+	coherent = dev_is_dma_coherent(dev);
+	prot = dma_info_to_prot(dir, coherent, attrs);
+
 	if (!coherent && !(attrs & DMA_ATTR_SKIP_CPU_SYNC))
 		arch_sync_dma_for_device(phys, size, dir);
 
@@ -1223,10 +1231,14 @@ dma_addr_t iommu_dma_map_phys(struct device *dev, phys_addr_t phys, size_t size,
 void iommu_dma_unmap_phys(struct device *dev, dma_addr_t dma_handle,
 		size_t size, enum dma_data_direction dir, unsigned long attrs)
 {
-	struct iommu_domain *domain = iommu_get_dma_domain(dev);
 	phys_addr_t phys;
 
-	phys = iommu_iova_to_phys(domain, dma_handle);
+	if (attrs & DMA_ATTR_MMIO) {
+		__iommu_dma_unmap(dev, dma_handle, size);
+		return;
+	}
+
+	phys = iommu_iova_to_phys(iommu_get_dma_domain(dev), dma_handle);
 	if (WARN_ON(!phys))
 		return;
 
-- 
2.50.1

