Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163A234166D;
	Tue,  9 Sep 2025 13:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757424546; cv=none; b=cvlPo8zZNczyfCpZvQYdUqGwdL7GELeNkSp0G6Zmwc5ZKtQ6uaVQeY8sZtV8b+ar9cH8XzL61d3wrY0r8Svxu6nx7x93yEi0vVqzYFR4RP8mpIkcBAml4nErDgQwxorAYJhn5d2lSV9HrRjKNFhJyvpV2lXoNHs9H5+Vm8ve+h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757424546; c=relaxed/simple;
	bh=ThC+GnSzG3vqrBq8iTzTPlcPa91tU2BQkMRg6ndRAuA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U1Hf1zY4Xr9xVaJo7MhP85FDvt5i1RE5wrHNoSFlh4bEte+QAjIZmovO10VNh2/kCW7Kn8fcKpoqTxeDO0B78nNpzaIznM+i50ibK/Mh8HJx7q2ZxW70WjNU+Qku4QKiB8Al8Cm9RZRVuqIaZmDVAp74fmdpK0Mqd0ohva+JprA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tnTViotB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tnTViotB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE671C4CEF4;
	Tue,  9 Sep 2025 13:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757424545;
	bh=ThC+GnSzG3vqrBq8iTzTPlcPa91tU2BQkMRg6ndRAuA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tnTViotBzgzX8VJMiUdP1iBUBwTcHGl4cXP5/xMCQJd3NuJ+v83PZRp+IV4I6m6Oo
	 rii0+a9xxI6kUod6ywO0FDmoTZ6nHn1Sm9TRhAhDLtUAwTh72wrfQLc04U7MeCpJP7
	 S+VB1HVBG2J4AB5r/4HEc/HDCNwV9/HfLsWB9aqhPOk5wvZ5OXodZEfSrk5TQI0YSe
	 2rgbYngdJVyQWuu3KtxqmyHFWhVGXg7iRlR+oGtwNzAeTNGHstyq5kW2vRrVG1sC4O
	 sQLrmM3sgvgI/IElfjSWQ/akyQs02UZyEB+0KaMdypAsViiUDxdz4nCkmXQU4JWJEG
	 mVUoTlUsHhrUw==
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
Subject: [PATCH v6 13/16] mm/hmm: properly take MMIO path
Date: Tue,  9 Sep 2025 16:27:41 +0300
Message-ID: <998251caf3f9d1a3f6f8205f1f494c707fb4d8fa.1757423202.git.leonro@nvidia.com>
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

In case peer-to-peer transaction traverses through host bridge,
the IOMMU needs to have IOMMU_MMIO flag, together with skip of
CPU sync.

The latter was handled by provided DMA_ATTR_SKIP_CPU_SYNC flag,
but IOMMU flag was missed, due to assumption that such memory
can be treated as regular one.

Reuse newly introduced DMA attribute to properly take MMIO path.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 mm/hmm.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/mm/hmm.c b/mm/hmm.c
index 015ab243f0813..6556c0e074ba8 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -746,7 +746,7 @@ dma_addr_t hmm_dma_map_pfn(struct device *dev, struct hmm_dma_map *map,
 	case PCI_P2PDMA_MAP_NONE:
 		break;
 	case PCI_P2PDMA_MAP_THRU_HOST_BRIDGE:
-		attrs |= DMA_ATTR_SKIP_CPU_SYNC;
+		attrs |= DMA_ATTR_MMIO;
 		pfns[idx] |= HMM_PFN_P2PDMA;
 		break;
 	case PCI_P2PDMA_MAP_BUS_ADDR:
@@ -776,7 +776,7 @@ dma_addr_t hmm_dma_map_pfn(struct device *dev, struct hmm_dma_map *map,
 			goto error;
 
 		dma_addr = dma_map_phys(dev, paddr, map->dma_entry_size,
-					DMA_BIDIRECTIONAL, 0);
+					DMA_BIDIRECTIONAL, attrs);
 		if (dma_mapping_error(dev, dma_addr))
 			goto error;
 
@@ -811,16 +811,17 @@ bool hmm_dma_unmap_pfn(struct device *dev, struct hmm_dma_map *map, size_t idx)
 	if ((pfns[idx] & valid_dma) != valid_dma)
 		return false;
 
+	if (pfns[idx] & HMM_PFN_P2PDMA)
+		attrs |= DMA_ATTR_MMIO;
+
 	if (pfns[idx] & HMM_PFN_P2PDMA_BUS)
 		; /* no need to unmap bus address P2P mappings */
-	else if (dma_use_iova(state)) {
-		if (pfns[idx] & HMM_PFN_P2PDMA)
-			attrs |= DMA_ATTR_SKIP_CPU_SYNC;
+	else if (dma_use_iova(state))
 		dma_iova_unlink(dev, state, idx * map->dma_entry_size,
 				map->dma_entry_size, DMA_BIDIRECTIONAL, attrs);
-	} else if (dma_need_unmap(dev))
+	else if (dma_need_unmap(dev))
 		dma_unmap_phys(dev, dma_addrs[idx], map->dma_entry_size,
-			       DMA_BIDIRECTIONAL, 0);
+			       DMA_BIDIRECTIONAL, attrs);
 
 	pfns[idx] &=
 		~(HMM_PFN_DMA_MAPPED | HMM_PFN_P2PDMA | HMM_PFN_P2PDMA_BUS);
-- 
2.51.0

