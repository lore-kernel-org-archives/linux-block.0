Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE60730C34A;
	Tue, 19 Aug 2025 17:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755625073; cv=none; b=NCWnwkaLK4JJbfnIhshzCbVkgZ8PY3jyogNvNMDj1EwYK4qD8Y2ilsEqhOPIRVr5biD9F4ddmv1G5ZHX4NT4iQjmlU6ND7KFlZbWpWIg1JDCF8Sxne26ClSgTjrZeO93/wD1eyt9d8F3Nn73BQ9owtMv3x23Wrj95wzweob5l9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755625073; c=relaxed/simple;
	bh=dJuAJRFwFKXIJkybNGJNx5df3xqMYXp7O5ndEMDZg04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AOSb/M9EtGqwKXSPzaLmVgFu2KcLz/yNJpdjHIY2tPjI0obQDJZ6ehfpdwJDMjLv8yAtrOmpeYVSTJ3MR7DvnFU+KkU93zLBV4oOdAulstdPYIYAJ6Q92XxaoAiCOh82asVxjQxOI7VcgbwAs5gi42VF/9lge/ZYit52WCPwR78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KCfTK4M1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KCfTK4M1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16E9AC4CEF4;
	Tue, 19 Aug 2025 17:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755625073;
	bh=dJuAJRFwFKXIJkybNGJNx5df3xqMYXp7O5ndEMDZg04=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KCfTK4M16fZcS3idu4B2UtcPGBxqBCQW/ThUlPcSPjuZpk9imzaVn20BMZHpPLbyc
	 3sv0wYVSp65eod2nGPwJoVRbqWUP8iwVx1qGbM406J7EQpm2oXaICC90d6Ro5TVuLo
	 TYKUR+gfoaSSqlCAv5Zfuuwbhw+6pj13nHVJkk9nSAsT5zgqNZmrwO925lW0owpuEU
	 q+J3Pg0hHwFJc1ESksWCrS/+yq6AvaPGtnZ/mQ6gvtWd96ELDPoDM/2hRZRbzxrJGH
	 3nVNacD9SmUqnDN3yL+Ud7ESjKc3S/vPtHWyLZM7vnsGB7Xxfh7jUyQGNO7ifQQ+BT
	 knehqEHs781Uw==
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
Subject: [PATCH v4 06/16] iommu/dma: extend iommu_dma_*map_phys API to handle MMIO memory
Date: Tue, 19 Aug 2025 20:36:50 +0300
Message-ID: <4f84639baf6d5d0e107fd2001dff91b6538ff9ae.1755624249.git.leon@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1755624249.git.leon@kernel.org>
References: <cover.1755624249.git.leon@kernel.org>
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

In the following patches, the iommu_dma_map_resource() will be removed
in favour of iommu_dma_map_phys(..., attrs | DMA_ATTR_MMIO) flow.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/iommu/dma-iommu.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index aea119f32f96..6804aaf034a1 100644
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
2.50.1

