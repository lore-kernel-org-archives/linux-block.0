Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6464B340D8F;
	Tue,  9 Sep 2025 13:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757424515; cv=none; b=Iwt8UxLCfP4mJf3SBuXipqWr4g6iAGEWX7P3xKefOe0FwfohPeROQWqBBLyTU58tmrWzL9G1tiB0EZ74lJjR7g/eV9y34Q+N2I62xJmpRkoYTQP+JQIE26nRBIRGKY9AaqbRDfBQ70rLES1qrnCJRC1igl2m+sdEH/i/CHuFlYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757424515; c=relaxed/simple;
	bh=A63sCU1us486CfnvbybDoy2DvC4mWvbNv9XH5e8Grdg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l1xS23EfzxLgeIw7O4f9SdKwUqpSBPEzrzscXO7KraSgyCd4l3kBe9SGPjYrjl9A9wl8BYbhlD9WN2uacxlJXabcfj0qsE1r5bSaXtT9o8I771dSuMIrNWd0j+cq/Z6am9K0bxGGppG0+ex5NWQ9prr7nqthHr/K8wyw5yLEhBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wi8yN8n2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wi8yN8n2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9385AC4CEF4;
	Tue,  9 Sep 2025 13:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757424515;
	bh=A63sCU1us486CfnvbybDoy2DvC4mWvbNv9XH5e8Grdg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Wi8yN8n22gc8EHttTIy6nTDZdyyXoXQ/Pldkc75H1b6hLRfWF7W91QongjbmQvASx
	 sv6rDJHl2MJSbLxPwGa3dmCMbrX9j01Em95NpNXM4cIDH7UJTEwX83geF/iBTaLFuP
	 z9936grIMWYOudFZFyWQaaATwNqlVd7G9UV/xV6GFF/aAOUbPO06Q/ST7pKHRaUbg7
	 zvG59sLnQHkzA0x5NeN55UQGwo5PwCywmKPSo//7gII1NKJ57XsBVOqW3xGebHV5Ho
	 GeffiYBcLO2jLid5aJ6HsuI1v5dL0okkwlGaoFgMfg5DtNWLYRKj5r9JHHMSD8Ink5
	 CRsGJPvVMTubA==
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
	David Hildenbrand <david@redhat.com>,
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
Subject: [PATCH v6 06/16] iommu/dma: implement DMA_ATTR_MMIO for iommu_dma_(un)map_phys()
Date: Tue,  9 Sep 2025 16:27:34 +0300
Message-ID: <acc255bee358fec9c7da6b2a5904ee50abcd09f1.1757423202.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1757423202.git.leonro@nvidia.com>
References: <cover.1757423202.git.leonro@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>

Make iommu_dma_map_phys() and iommu_dma_unmap_phys() respect
DMA_ATTR_MMIO.

DMA_ATTR_MMIO makes the functions behave the same as
iommu_dma_(un)map_resource():
 - No swiotlb is possible
 - No cache flushing is done (ATTR_MMIO should not be cached memory)
 - prot for iommu_map() has IOMMU_MMIO not IOMMU_CACHE

This is preparation for replacing iommu_dma_map_resource() callers
with iommu_dma_map_phys(DMA_ATTR_MMIO) and removing
iommu_dma_(un)map_resource().

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/iommu/dma-iommu.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index aea119f32f965..6804aaf034a16 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -1211,16 +1211,19 @@ dma_addr_t iommu_dma_map_phys(struct device *dev, phys_addr_t phys, size_t size,
 	 */
 	if (dev_use_swiotlb(dev, size, dir) &&
 	    iova_unaligned(iovad, phys, size)) {
+		if (attrs & DMA_ATTR_MMIO)
+			return DMA_MAPPING_ERROR;
+
 		phys = iommu_dma_map_swiotlb(dev, phys, size, dir, attrs);
 		if (phys == (phys_addr_t)DMA_MAPPING_ERROR)
 			return DMA_MAPPING_ERROR;
 	}
 
-	if (!coherent && !(attrs & DMA_ATTR_SKIP_CPU_SYNC))
+	if (!coherent && !(attrs & (DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_MMIO)))
 		arch_sync_dma_for_device(phys, size, dir);
 
 	iova = __iommu_dma_map(dev, phys, size, prot, dma_mask);
-	if (iova == DMA_MAPPING_ERROR)
+	if (iova == DMA_MAPPING_ERROR && !(attrs & DMA_ATTR_MMIO))
 		swiotlb_tbl_unmap_single(dev, phys, size, dir, attrs);
 	return iova;
 }
@@ -1228,10 +1231,14 @@ dma_addr_t iommu_dma_map_phys(struct device *dev, phys_addr_t phys, size_t size,
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
2.51.0

