Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB3F3128AF;
	Tue,  2 Sep 2025 14:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756824546; cv=none; b=fQgEcuQJbSEuDQuQITINCvjXxlpqgLWH0EWRvBzZEp4jllqyhu8mGlGh3cOPmmaguNycGjetiQpDzCTfn6qQ6bXK9jnlXW9fYPC95T6Vv0qYm6nTIt2ClbzOOhrZPWED7Tp6mUIhqDW4i7psovIouwXOsTzP6uhOTkpJd8WRKVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756824546; c=relaxed/simple;
	bh=3SAFSguWc3mEh+7tLjgls851bpgvCDXeoOLUKYRDCQw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P21r7udrV+bktR1WwV5X4xw3l2CQfzrG9/RWvfurLGBUqePleqQVV8IJa7okPbQhwiUV0ABqgebVRe4S76vVFIzikz5v27RWTX1dVjioKaEgrsW6sINd/S715l5YaExyAkVYNpbdRQVpGHB0TjTyrTMSnR9gQrYHzLR4OvG+O5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T4z/viMp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T4z/viMp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACFA9C4CEED;
	Tue,  2 Sep 2025 14:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756824545;
	bh=3SAFSguWc3mEh+7tLjgls851bpgvCDXeoOLUKYRDCQw=;
	h=From:To:Cc:Subject:Date:From;
	b=T4z/viMpK/6nZf/nQZOIsRAAm3EHCx98H3vJy/7M+HoAOU06u4ge/kUryG+aCfwUr
	 EPLJmc0enqvgMLu/ql+aqcT5Fj2w9kmxR9H/m3pCJndhGClrY92+csP8H8rqa+M2F0
	 +/tg51ze5lLUyJvb9GuRMyJ6Mnz6YmTZuEbkE8BZXJxNc0WBeGGkH6nfvvoKcKyT7D
	 72RQkLhAK72Yfulrr+BomhHq1M5YBXZDuDEbusIH/tJezD3AHPAbYmPt0An2e0azvi
	 DpDSFe11OrTeaTIEkB3Rx5xhIiAEjLUzU+nXQYo+9uCB+p85bgbRHkcFyUX4QjIfNW
	 +sNnsW+E+uHqg==
From: Leon Romanovsky <leon@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>,
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
Subject: [PATCH v5 00/16] dma-mapping: migrate to physical address-based API
Date: Tue,  2 Sep 2025 17:48:37 +0300
Message-ID: <cover.1756822782.git.leon@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Marek,

Please pay attention that I'm resending all patches which includes
nvme/blk conversion too. The code is based on clean -rc3, but NVMe
tree got patch in this cycle which removes one of their REQ_* bits,
on which I'm relying.

This is the patch:
https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/commit/?h=for-6.18/block&id=7092639031a1bd5320ab827e8f665350f332b7ce
and this is Keith's attempt to restore it:
https://lore.kernel.org/linux-block/20250829142307.3769873-3-kbusch@meta.com/

So there are two possible options:
1. Apply only first 13 patches and I'll resend nvme/blk patches in next
cycle with the hope that REQ_* bits issue is sorted.
2. Apply whole series and deal with merge conflicts by sending PR to
Jens and ask him to merge this DMA series.

Thanks

------------------------------------------------------------------------
Changelog:
v5:
 * Added Jason's and Keith's Reviewed-by tags
 * Fixed DMA_ATTR_MMIO check in dma_direct_map_phys
 * Jason's cleanup suggestions
v4: https://lore.kernel.org/all/cover.1755624249.git.leon@kernel.org/
 * Fixed kbuild error with mismatch in kmsan function declaration due to
   rebase error.
v3: https://lore.kernel.org/all/cover.1755193625.git.leon@kernel.org
 * Fixed typo in "cacheable" word
 * Simplified kmsan patch a lot to be simple argument refactoring
v2: https://lore.kernel.org/all/cover.1755153054.git.leon@kernel.org
 * Used commit messages and cover letter from Jason
 * Moved setting IOMMU_MMIO flag to dma_info_to_prot function
 * Micro-optimized the code
 * Rebased code on v6.17-rc1
v1: https://lore.kernel.org/all/cover.1754292567.git.leon@kernel.org
 * Added new DMA_ATTR_MMIO attribute to indicate
   PCI_P2PDMA_MAP_THRU_HOST_BRIDGE path.
 * Rewrote dma_map_* functions to use thus new attribute
v0: https://lore.kernel.org/all/cover.1750854543.git.leon@kernel.org/
------------------------------------------------------------------------

This series refactors the DMA mapping to use physical addresses
as the primary interface instead of page+offset parameters. This
change aligns the DMA API with the underlying hardware reality where
DMA operations work with physical addresses, not page structures.

The series maintains export symbol backward compatibility by keeping
the old page-based API as wrapper functions around the new physical
address-based implementations.

This series refactors the DMA mapping API to provide a phys_addr_t
based, and struct-page free, external API that can handle all the
mapping cases we want in modern systems:

 - struct page based cacheable DRAM
 - struct page MEMORY_DEVICE_PCI_P2PDMA PCI peer to peer non-cacheable
   MMIO
 - struct page-less PCI peer to peer non-cacheable MMIO
 - struct page-less "resource" MMIO

Overall this gets much closer to Matthew's long term wish for
struct-pageless IO to cacheable DRAM. The remaining primary work would
be in the mm side to allow kmap_local_pfn()/phys_to_virt() to work on
phys_addr_t without a struct page.

The general design is to remove struct page usage entirely from the
DMA API inner layers. For flows that need to have a KVA for the
physical address they can use kmap_local_pfn() or phys_to_virt(). This
isolates the struct page requirements to MM code only. Long term all
removals of struct page usage are supporting Matthew's memdesc
project which seeks to substantially transform how struct page works.

Instead make the DMA API internals work on phys_addr_t. Internally
there are still dedicated 'page' and 'resource' flows, except they are
now distinguished by a new DMA_ATTR_MMIO instead of by callchain. Both
flows use the same phys_addr_t.

When DMA_ATTR_MMIO is specified things work similar to the existing
'resource' flow. kmap_local_pfn(), phys_to_virt(), phys_to_page(),
pfn_valid(), etc are never called on the phys_addr_t. This requires
rejecting any configuration that would need swiotlb. CPU cache
flushing is not required, and avoided, as ATTR_MMIO also indicates the
address have no cacheable mappings. This effectively removes any
DMA API side requirement to have struct page when DMA_ATTR_MMIO is
used.

In the !DMA_ATTR_MMIO mode things work similarly to the 'page' flow,
except on the common path of no cache flush, no swiotlb it never
touches a struct page. When cache flushing or swiotlb copying
kmap_local_pfn()/phys_to_virt() are used to get a KVA for CPU
usage. This was already the case on the unmap side, now the map side
is symmetric.

Callers are adjusted to set DMA_ATTR_MMIO. Existing 'resource' users
must set it. The existing struct page based MEMORY_DEVICE_PCI_P2PDMA
path must also set it. This corrects some existing bugs where iommu
mappings for P2P MMIO were improperly marked IOMMU_CACHE.

Since ATTR_MMIO is made to work with all the existing DMA map entry
points, particularly dma_iova_link(), this finally allows a way to use
the new DMA API to map PCI P2P MMIO without creating struct page. The
VFIO DMABUF series demonstrates how this works. This is intended to
replace the incorrect driver use of dma_map_resource() on PCI BAR
addresses.

This series does the core code and modern flows. A followup series
will give the same treatment to the legacy dma_ops implementation.

Thanks

Leon Romanovsky (16):
  dma-mapping: introduce new DMA attribute to indicate MMIO memory
  iommu/dma: implement DMA_ATTR_MMIO for dma_iova_link().
  dma-debug: refactor to use physical addresses for page mapping
  dma-mapping: rename trace_dma_*map_page to trace_dma_*map_phys
  iommu/dma: rename iommu_dma_*map_page to iommu_dma_*map_phys
  iommu/dma: implement DMA_ATTR_MMIO for iommu_dma_(un)map_phys()
  dma-mapping: convert dma_direct_*map_page to be phys_addr_t based
  kmsan: convert kmsan_handle_dma to use physical addresses
  dma-mapping: implement DMA_ATTR_MMIO for dma_(un)map_page_attrs()
  xen: swiotlb: Open code map_resource callback
  dma-mapping: export new dma_*map_phys() interface
  mm/hmm: migrate to physical address-based DMA mapping API
  mm/hmm: properly take MMIO path
  block-dma: migrate to dma_map_phys instead of map_page
  block-dma: properly take MMIO path
  nvme-pci: unmap MMIO pages with appropriate interface

 Documentation/core-api/dma-api.rst        |   4 +-
 Documentation/core-api/dma-attributes.rst |  18 ++++
 arch/powerpc/kernel/dma-iommu.c           |   4 +-
 block/blk-mq-dma.c                        |  15 ++-
 drivers/iommu/dma-iommu.c                 |  61 +++++------
 drivers/nvme/host/pci.c                   |  18 +++-
 drivers/virtio/virtio_ring.c              |   4 +-
 drivers/xen/swiotlb-xen.c                 |  21 +++-
 include/linux/blk-mq-dma.h                |   6 +-
 include/linux/blk_types.h                 |   2 +
 include/linux/dma-direct.h                |   2 -
 include/linux/dma-map-ops.h               |   8 +-
 include/linux/dma-mapping.h               |  33 ++++++
 include/linux/iommu-dma.h                 |  11 +-
 include/linux/kmsan.h                     |   9 +-
 include/linux/page-flags.h                |   1 +
 include/trace/events/dma.h                |   9 +-
 kernel/dma/debug.c                        |  81 ++++-----------
 kernel/dma/debug.h                        |  37 ++-----
 kernel/dma/direct.c                       |  22 +---
 kernel/dma/direct.h                       |  57 +++++++----
 kernel/dma/mapping.c                      | 117 +++++++++++++---------
 kernel/dma/ops_helpers.c                  |   6 +-
 mm/hmm.c                                  |  19 ++--
 mm/kmsan/hooks.c                          |   8 +-
 rust/kernel/dma.rs                        |   3 +
 tools/virtio/linux/kmsan.h                |   2 +-
 27 files changed, 315 insertions(+), 263 deletions(-)

-- 
2.50.1

