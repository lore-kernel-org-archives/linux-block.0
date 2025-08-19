Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C902E30C35E;
	Tue, 19 Aug 2025 17:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755625061; cv=none; b=Cp0dIaKFF9oQySjZTvp+UxekgTn9ea2zydHI2n3pWtsvXicBHGdrh1oChzpmCqHdGu51zdMizsiAIWSAw+zWTE10PMAWqvm9sxOEpNLT9u5bcpYWkI17WL+ICk52n/HikKxWmKjIfazv30WBTpssiE0h31aNngPOsYbOc2OuAq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755625061; c=relaxed/simple;
	bh=mXPBKGOTAXMaA8YnIACrT4VeK6ColaZH6f/lOi0T5+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ljGw7L9DuJoKwqzMltyoDkvaBzpeEsaIA/Du+eqCFcnC/bgzNdDX+y26qaZ5xItTIWLRYxoHlT2o8S3Bx1ClPsMJ7UZKsT/YQ4yV720OvbsyGt4vJX+6xZnTpx2rwKHCr0cgCMt/75iZ677kWiPT+mvWoqCY8jE52koalG/y/SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZcfXQzEM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZcfXQzEM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53FEBC116B1;
	Tue, 19 Aug 2025 17:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755625061;
	bh=mXPBKGOTAXMaA8YnIACrT4VeK6ColaZH6f/lOi0T5+M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZcfXQzEMtP4+AZ86jo3dtO0Oekoz5PxnIpxVGiM0bP5sSs9WMxZsIT5kYk/VnUi3R
	 /kc0Vzr2i3fBfcwwoPTgAmdyvW5ST0B2y1uv9wp+i8hWG5QgN6gN0jrKDriRJyNDRP
	 26rMrCRUHHKb1TjV3vj8pKsHfYCF8VeZXtu9+b4Vsvi65u3DslqBcB4jsQub3Gt2qD
	 KJFY83CBFYAED4nL0OxEGnoJhmf5HiiRJ0eyTbwf76fL/xpbF4kq0K7Xr5ssJRHfaG
	 Znxa2J61vk0Pu5GfNVrDFyX+mri+BrC7qwdiENTcRxzxBPp/BwoEirtjDV08OZLE7g
	 87wPEgWDV7Xzg==
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
Subject: [PATCH v4 02/16] iommu/dma: implement DMA_ATTR_MMIO for dma_iova_link().
Date: Tue, 19 Aug 2025 20:36:46 +0300
Message-ID: <62d9a6c3ca03037631f6d0640ebec5fbac41d547.1755624249.git.leon@kernel.org>
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

This will replace the hacky use of DMA_ATTR_SKIP_CPU_SYNC to avoid
touching the possibly non-KVA MMIO memory.

Also correct the incorrect caching attribute for the IOMMU, MMIO
memory should not be cachable inside the IOMMU mapping or it can
possibly create system problems. Set IOMMU_MMIO for DMA_ATTR_MMIO.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/iommu/dma-iommu.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index ea2ef53bd4fe..e1185ba73e23 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -724,7 +724,12 @@ static int iommu_dma_init_domain(struct iommu_domain *domain, struct device *dev
 static int dma_info_to_prot(enum dma_data_direction dir, bool coherent,
 		     unsigned long attrs)
 {
-	int prot = coherent ? IOMMU_CACHE : 0;
+	int prot;
+
+	if (attrs & DMA_ATTR_MMIO)
+		prot = IOMMU_MMIO;
+	else
+		prot = coherent ? IOMMU_CACHE : 0;
 
 	if (attrs & DMA_ATTR_PRIVILEGED)
 		prot |= IOMMU_PRIV;
@@ -1838,12 +1843,13 @@ static int __dma_iova_link(struct device *dev, dma_addr_t addr,
 		unsigned long attrs)
 {
 	bool coherent = dev_is_dma_coherent(dev);
+	int prot = dma_info_to_prot(dir, coherent, attrs);
 
-	if (!coherent && !(attrs & DMA_ATTR_SKIP_CPU_SYNC))
+	if (!coherent && !(attrs & (DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_MMIO)))
 		arch_sync_dma_for_device(phys, size, dir);
 
 	return iommu_map_nosync(iommu_get_dma_domain(dev), addr, phys, size,
-			dma_info_to_prot(dir, coherent, attrs), GFP_ATOMIC);
+			prot, GFP_ATOMIC);
 }
 
 static int iommu_dma_iova_bounce_and_link(struct device *dev, dma_addr_t addr,
@@ -1949,9 +1955,13 @@ int dma_iova_link(struct device *dev, struct dma_iova_state *state,
 		return -EIO;
 
 	if (dev_use_swiotlb(dev, size, dir) &&
-	    iova_unaligned(iovad, phys, size))
+	    iova_unaligned(iovad, phys, size)) {
+		if (attrs & DMA_ATTR_MMIO)
+			return -EPERM;
+
 		return iommu_dma_iova_link_swiotlb(dev, state, phys, offset,
 				size, dir, attrs);
+	}
 
 	return __dma_iova_link(dev, state->addr + offset - iova_start_pad,
 			phys - iova_start_pad,
-- 
2.50.1

