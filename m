Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A64F2620E4;
	Mon,  4 Aug 2025 12:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754311435; cv=none; b=Ubcn4jfBUMFHsPvs8NtCH8XcvdGtJLPNzvF6yfT/GfEgAtnm5QWD/FTvE52h1zhTo1tKLG7vM2Q8f/5Z78hcaJ+5oFcG/UGac2lLQ1eHibrtepnO1l8S0tOHu9MkzrolMQ7sf4ESAxLQX9OS54LLXijgY3Rl1P1CKX+X2bOa/S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754311435; c=relaxed/simple;
	bh=j/IXC/mk0CucPDkDZSOLBQ/UHxOlDcVl+SoZNP0e+X0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ny4OU1xGlND6WhFe4nqZAoxmFN0TCXIXNAuDAuFYJ9vcdPEBm6wZJ15zU47ojk2/BLJmQvpivKp5bFF9ZX/ze6sQFCoWIApVnX1NBc1SSCRgZIrbRtF+MYziaTKjN0nzHpFGJsRU5DzQD8+ZV74NOuA7jJXd44ijxMwgW1NoT3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ihw3Mu90; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ihw3Mu90"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91EBCC4CEF0;
	Mon,  4 Aug 2025 12:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754311435;
	bh=j/IXC/mk0CucPDkDZSOLBQ/UHxOlDcVl+SoZNP0e+X0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ihw3Mu90j8p2iuP5oqZQ0qRYRAR/2eX9T50SB8VLM/IpeY+W5wW61GhW3av4wc29C
	 5rQPXs1M+s6jjy1+nIw6SWxZuIavX26CaEl38gSuxVMHKz9Ozga++BdX/JbT+AreaD
	 thi1puaSRP5nUcta2FCkabbmnkHrUDPmtBsN8oUFKF0vUAnM1ZHd3jM+br9WjySLQ8
	 NTL3Vo53fSv59+EK2VgBP0cZFK4osZ7IM6oRQqchl8AnWygksQAVNXy453HYzPo2QW
	 I3SOs53kRy1kdIAph2yeNZ5VK6beeqdsIxQeMAXinFMWTJElchVQzM+2upe9a5Me8M
	 xXtsI8WERuQcg==
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
Subject: [PATCH v1 09/16] dma-mapping: handle MMIO flow in dma_map|unmap_page
Date: Mon,  4 Aug 2025 15:42:43 +0300
Message-ID: <152745932ce4200e4baaedcc59ef45c230e47896.1754292567.git.leon@kernel.org>
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

Extend base DMA page API to handle MMIO flow.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 kernel/dma/mapping.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index 709405d46b2b4..f5f051737e556 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -158,6 +158,7 @@ dma_addr_t dma_map_page_attrs(struct device *dev, struct page *page,
 {
 	const struct dma_map_ops *ops = get_dma_ops(dev);
 	phys_addr_t phys = page_to_phys(page) + offset;
+	bool is_mmio = attrs & DMA_ATTR_MMIO;
 	dma_addr_t addr;
 
 	BUG_ON(!valid_dma_direction(dir));
@@ -166,12 +167,23 @@ dma_addr_t dma_map_page_attrs(struct device *dev, struct page *page,
 		return DMA_MAPPING_ERROR;
 
 	if (dma_map_direct(dev, ops) ||
-	    arch_dma_map_phys_direct(dev, phys + size))
+	    (!is_mmio && arch_dma_map_phys_direct(dev, phys + size)))
 		addr = dma_direct_map_phys(dev, phys, size, dir, attrs);
 	else if (use_dma_iommu(dev))
 		addr = iommu_dma_map_phys(dev, phys, size, dir, attrs);
-	else
+	else if (is_mmio) {
+		if (!ops->map_resource)
+			return DMA_MAPPING_ERROR;
+
+		addr = ops->map_resource(dev, phys, size, dir, attrs);
+	} else {
+		/*
+		 * All platforms which implement .map_page() don't support
+		 * non-struct page backed addresses.
+		 */
 		addr = ops->map_page(dev, page, offset, size, dir, attrs);
+	}
+
 	kmsan_handle_dma(phys, size, dir);
 	trace_dma_map_phys(dev, phys, addr, size, dir, attrs);
 	debug_dma_map_phys(dev, phys, size, dir, addr, attrs);
@@ -184,14 +196,18 @@ void dma_unmap_page_attrs(struct device *dev, dma_addr_t addr, size_t size,
 		enum dma_data_direction dir, unsigned long attrs)
 {
 	const struct dma_map_ops *ops = get_dma_ops(dev);
+	bool is_mmio = attrs & DMA_ATTR_MMIO;
 
 	BUG_ON(!valid_dma_direction(dir));
 	if (dma_map_direct(dev, ops) ||
-	    arch_dma_unmap_phys_direct(dev, addr + size))
+	    (!is_mmio && arch_dma_unmap_phys_direct(dev, addr + size)))
 		dma_direct_unmap_phys(dev, addr, size, dir, attrs);
 	else if (use_dma_iommu(dev))
 		iommu_dma_unmap_phys(dev, addr, size, dir, attrs);
-	else
+	else if (is_mmio) {
+		if (ops->unmap_resource)
+			ops->unmap_resource(dev, addr, size, dir, attrs);
+	} else
 		ops->unmap_page(dev, addr, size, dir, attrs);
 	trace_dma_unmap_phys(dev, addr, size, dir, attrs);
 	debug_dma_unmap_phys(dev, addr, size, dir);
-- 
2.50.1

