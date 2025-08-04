Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989E425E813;
	Mon,  4 Aug 2025 12:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754311398; cv=none; b=ch7lEYEepNA6R8qr5NUvjyu0u9C8H9Rk33Jt+yzlzrasZibnxBaC99LKCovQ4Ejyt1j0nrOEFIcsEDunLNjK9zv11KvQg7fvd23yUWvAtZUhql8y99QKpVp/KkNlGMyXtKGi1Hci1Gtk23JLA6HE/N/iqLv941yUujQ6D5pVOMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754311398; c=relaxed/simple;
	bh=rlkoLHmieI8GnOBig0uhL3NMd0vvRWDvv2oEih0mzFM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D/D+Y7pD/ERuf16crijL5yp+zSNbyr4i1d1F2JLOq1dGQ6bTLZYpVvydJuT1X/1Zg/bvxjFORvZKxco8VI/dRQdyB/Urf7YJYlv2kqU3fu8OrXA6YTiatmneaf8mvEfkzbwYXiFkikxaBGY1ylUKPuIwmdtEdjMNBGIlpDiWwT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QrFIfUaO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QrFIfUaO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B783C4CEF0;
	Mon,  4 Aug 2025 12:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754311398;
	bh=rlkoLHmieI8GnOBig0uhL3NMd0vvRWDvv2oEih0mzFM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QrFIfUaOpq0zgYoSf2B1eOFHhzxa8uJ9rI7ao3LQ15JdOAmXwx/vS3c+eYH6QTWOC
	 CZmPIb28BNkyQUhEkXmvY3ou31ivX2Y6W+QyRQ5lEcadqA118EYMjd4CMO32TmndIt
	 q9x/mE/Grc0mkPr/feAp0D8366SSjD6FCJuMLM/iEpxRFuKKQJHqb6OZAv8QT4n2gA
	 l8UYQWJxtJiMLDORYH+k0vFOc3W5LIKBdC/UjGKILIXxW7YyF57t2tVDzjmI4Hs2SY
	 Y6Y7brOxqet5SSMB18NQiaM/FfQfmONk81U59gW5ymq8VCTWf5/3zTUjdvPe68z/B6
	 YFqU3TERLKLDQ==
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
Subject: [PATCH v1 02/16] iommu/dma: handle MMIO path in dma_iova_link
Date: Mon,  4 Aug 2025 15:42:36 +0300
Message-ID: <52e39cd31d8f30e54a27afac84ea35f45ae4e422.1754292567.git.leon@kernel.org>
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

Make sure that CPU is not synced if MMIO path is taken.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/iommu/dma-iommu.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index ea2ef53bd4fef..399838c17b705 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -1837,13 +1837,20 @@ static int __dma_iova_link(struct device *dev, dma_addr_t addr,
 		phys_addr_t phys, size_t size, enum dma_data_direction dir,
 		unsigned long attrs)
 {
-	bool coherent = dev_is_dma_coherent(dev);
+	int prot;
 
-	if (!coherent && !(attrs & DMA_ATTR_SKIP_CPU_SYNC))
-		arch_sync_dma_for_device(phys, size, dir);
+	if (attrs & DMA_ATTR_MMIO)
+		prot = dma_info_to_prot(dir, false, attrs) | IOMMU_MMIO;
+	else {
+		bool coherent = dev_is_dma_coherent(dev);
+
+		if (!coherent && !(attrs & DMA_ATTR_SKIP_CPU_SYNC))
+			arch_sync_dma_for_device(phys, size, dir);
+		prot = dma_info_to_prot(dir, coherent, attrs);
+	}
 
 	return iommu_map_nosync(iommu_get_dma_domain(dev), addr, phys, size,
-			dma_info_to_prot(dir, coherent, attrs), GFP_ATOMIC);
+			prot, GFP_ATOMIC);
 }
 
 static int iommu_dma_iova_bounce_and_link(struct device *dev, dma_addr_t addr,
@@ -1949,9 +1956,13 @@ int dma_iova_link(struct device *dev, struct dma_iova_state *state,
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

