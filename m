Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794248739;
	b=4aRdFOhzbRgAnETxSubF3h33rYFB/9dHwR7NPy0vgZKNqyViHPzxQFfU8y2dDTERBb/J
	 RrH+jThcUDlv0bxST1gLUY2NqHutMEMQJqt/zaePjTx/Zos/aPsfn4GsIfOrY/38Q8eN8
	 FlHqPtyF9u5w+kp0ysICD0vyfKYhZ/BYs5L+9BMakinsOmeGtiHq4UEidhqPvKSgWlr6b
	 apEHUhAMM0Nnx9U2neYs3DdS3uy5XhLXx2aBBF5OG5ZSYnP8fzBrWP2RPEjdphMS2KEhD
	 0rwREsamkRbbS73UOyZdtiqkW2qyjrFvM/hopctEv+QAEdm6RrS1PjsX3JuNpYWaeqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794248739;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=yXbpKNTutM+q8EpPl46Tft0Cw/JJ6ViVyA1KiMY2C84=;
	b=Dy11NHePX5Liq384UFW7hm59bKFD+opLQCZAWlyaecrqYZ6J9n/zof796FCtsDQUaScs
	 8/JU5sPNKY+KZ07aJS0w/KA//ahPr0LQStTU36iOMfUa2BNAxWU4mqXFhjSOzztqF012K
	 GJYMsBQ58e3LYn3Yz8ZkS1bzbxsNLKlewrayJjbmGYTRwYr0s22Ive5cUEfQQA3orb1+l
	 jUAx6F9BlMpwL98wliSA9O4aYOnl0IAW70Z+wWzKLqRyoFJ7Y3pUMMMWehj8SPQtUU65Z
	 rvkLfRdvqqPlTYGCTxOp9VNx9Ms3KNo1olk8MzNrH2vG09QBpUVgs3SQXV/SdzgpKOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Ej1oO1S0;
	arc=none smtp.remote-ip=209.85.208.72
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2150606A331
	for <linux-block@vger.kernel.org>; Mon,  9 Nov 2026 18:25:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2150606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Ej1oO1S0
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-6a615ab0c06so1024725a12.2
        for <linux-block@vger.kernel.org>; Mon, 09 Nov 2026 10:25:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794248737; x=1794853537; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yXbpKNTutM+q8EpPl46Tft0Cw/JJ6ViVyA1KiMY2C84=;
        b=Ej1oO1S0w1d5G5L/0Q1NFkUNsUmb+jkTFezTc5catOvTSjkW5Ano6ghByl4/xx2aqY
         aVYiNADDKhdZsTzF6c3jOVInPyZXnqpieqfIENSO7bnQNjMYc4olx3xg1SY08d5Fb6J9
         ORePJpQrJKzEx1KoCoAXv8gL093OaCdzmbFp8pHFDhsJNGLuL4D3LHpK8sWIqJnjGlwe
         zIiXFSFKXI0dqUX+JhP1yNn1vZHMxCm2T6ETw++SfFyri8JWpGE0Ve+e18w6mqwUk4dz
         DUctTq6HHXUAnse22kC4ouZKKJjZWS6GBp4KF7Z30xgTs4XqWbEeIOdwe5Tl6RoSI+/q
         fQ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794248737; x=1794853537;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yXbpKNTutM+q8EpPl46Tft0Cw/JJ6ViVyA1KiMY2C84=;
        b=Xn+VwQqoAiF0WnuiwTr/f9vyIODvRL5EXF/dQwk812PTVBpGeXc6Q/tgzvB4whO+3H
         HCihHAH1hcMhFnij4qa515cWtDOOKaTHG0wdXpc8ZHs67HAxiaLQpU6udhoxDCTCUvaA
         Qdbm6mA4rQmhFO55D0Oz6WRxZWhz3EHS8SwpbVFWcg/sB8NLc85Ki+Kv2sxcQMoyQk+N
         adhCixX1KrSqiNb/h7umm5dyhx/ZfRGn5EioohPHxoaGlbIFJh03VEYimS3P7UACG9LC
         ZptlSpOwn64Bw++cmZONvSjFmdLvX7ttSuVYK/uqhTc09oa2lVBJiugRBS0qJRjT3pPE
         G35Q==
X-Forwarded-Encrypted: i=1; AL+hErEbuaW1DgLcAHY14ohQqCNvPUK9LI+8IPq8jJ6fHY4DVmUWFv/8w8qXlRSmuiytQNneUREOmcsyiHdUCQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z8UL48R0Gpmgi0Hc/odtzhiAupFtgeHkVHvZuv2b+4dntLUfRUL
	Oow8PcwcDWMGmFsGdT0BYwVW8EDAo+6xdQ9R/EaAnYg5ueuKENbCMEPwdCsYUe6SCMQLLxgQHlg
	Hns5FWA==
X-Received: from edsu12.prod.google.com ([2002:aa7:d98c:0:b0:6ac:c4fc:4feb])
 (user=lrizzo job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:234a:b0:6ac:8ef4:177d
 with SMTP id 4fb4d7f45d1cf-6b756ad59a4mr348040a12.20.1794248736768; Mon, 09
 Nov 2026 10:25:36 -0800 (PST)
Date: Mon,  9 Nov 2026 18:25:08 +0000
In-Reply-To: <20261003212241.3432303-1-lrizzo@google.com>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261003212241.3432303-1-lrizzo@google.com>
X-Mailer: git-send-email 2.56.0.542.g3ef89b7020-goog
Message-ID: <20261109182533.3594984-1-lrizzo@google.com>
Subject: [RFC PATCH v2 00/25] PISA: Pre-mapped IOVA Superpage Allocator for
 DMA and CoCo
From: Luigi Rizzo <lrizzo@google.com>
To: Luigi Rizzo <rizzo.unipi@gmail.com>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@kernel.org>, David Hildenbrand <david@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Matthew Wilcox <willy@infradead.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Willem de Bruijn <willemb@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Joshua Washington <joshwash@google.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Alexander Lobakin <aleksander.lobakin@intel.com>, 
	iommu@lists.linux.dev, netdev@vger.kernel.org, linux-mm@kvack.org, 
	linux-block@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Luigi Rizzo <lrizzo@google.com>
Content-Type: text/plain; charset="UTF-8"

This is v2 of the RFC previously posted as DMA_PMD [0] (renamed to avoid
confusion with CPU page table PMD levels).

PISA stands for "Pre-mapped IOVA Superpage Allocator" and as the name
says, it is a specialized memory allocator. Invoked via __GFP_PISA* flag
to alloc_pages(), it returns pages ("PISA memory") that make DMA-related
operations on that memory a lot more efficient, both in software and
in hardware.

Specifically, PISA memory has the following properties:

- it is backed by 2MB contiguous physical pages, so the IOMMU can
  use large leaf mappings and significantly reduce IOTLB pressure see [1]

- IOMMU mappings are recycled while PISA memory is used for IO buffers,
  thus greatly reducing IOVA allocation and dma map/unmap costs.
  This includes cases (e.g. overcommitted VMs or Confidential Compute)
  where they would trigger expensive VM exits or bounce buffer copies.

- PISA memory is returned to the buddy allocator in background, and
  only after all existing IOMMU and IOTLB mappings have been flushed.
  This removes a significant security problem in DMA-FQ, which instead returns 
  pages before flushing the IOTLB, without the performance penalty of
  strict iommu (DMA) where the flushes are synchronous.

The pitch line remains:

  PISA has the performance of identity mapping, guarantees that only active
  I/O buffers have IOMMU/IOTLB mappings (unlike DMA-FQ), removes bounce-buffer
  copies in Confidential Computing VMs, and integrates transparently with
  existing kernel subsystems and drivers.

=== KEY IDEA: A SPECIALIZED MEMORY ALLOCATOR

For avoidance of doubt, PISA is NOT a new buffer cache, page_pool
replacement, slab allocator, or custom netdev feature. The kernel already
has plenty of specialized caches and pools (page_pool, socket page_frags,
SLUB, page cache) built on top of the buddy allocator.

Instead, PISA sits *below* those existing subsystems as a specialized
memory provider modeled after alloc_pages() and __free_pages_prepare().
It enforces a few properties on the memory it dispenses so that IOMMU
mapping, unmapping, and CoCo page decryption become nearly free:

1. PISA allocates order-N blocks out of physically contiguous 2MB pages that
   are mapped once per IOMMU domain using 2MB IOMMU leaf entries in a
   reserved per-domain IOVA window (and decrypted once upfront in CoCo
   guests). Subsequent dma_map_*() calls resolve the IOVA with a simple
   window offset calculation, and dma_unmap_*() is a no-op.

2. Freed blocks are intercepted in __free_pages_prepare() and recycled
   back into their PISA allocator while their 2MB IOMMU mappings remain
   active. A 2MB page is returned to the buddy allocator only when all
   of its blocks are idle, its IOMMU mappings have been removed from all
   domains, a synchronous IOTLB flush has completed, and an RCU grace
   period has elapsed.

3. Callers allocate from per-NUMA-node PISA allocators using standard page
   allocator calls with __GFP_PISA_RW (DMA_BIDIRECTIONAL) or __GFP_PISA_RO
   (DMA_TO_DEVICE, mapped IOMMU_READ-only so devices cannot overwrite
   shared/adjacent data), falling back to the buddy allocator on failure.

Because PISA operates at the page allocator and DMA mapping boundary,
existing clients require minimal changes. For example, the entire patch
integrating page_pool with PISA (patch 13/25) is just 3 lines:

  --- a/net/core/page_pool.c
  +++ b/net/core/page_pool.c
  @@ -16,6 +16,7 @@
   #include <net/page_pool/helpers.h>
   #include <net/page_pool/memory_provider.h>
   #include <net/xdp.h>
  +#include <linux/pisa.h>
  @@ -622,6 +623,8 @@ static noinline netmem_ref __page_pool_alloc_netmems_slow(...)
   	if ((gfp & GFP_ATOMIC) == GFP_ATOMIC)
   		gfp |= __GFP_NOWARN;
  +	if (dma_map)
  +		gfp |= pisa_rx_gfp(pool->p.dev);

Similarly:
- Coherent rings/queues (dma_alloc_attrs()) are served from the per-node
  order-0 PISA allocator when dev->pisa_coherent is enabled; no driver
  changes needed.
- Socket TX page fragments (skb_page_frag_refill()) use a per-task
  page_frag fed by __GFP_PISA_RO when the egress device has pisa_tx_bufs
  enabled; no driver changes needed.
- Small TX skb heads (kmalloc_reserve()) use a parallel
  skbuff_small_head_pisa SLUB cache backed by zeroed, read-only PISA
  folios (SLAB_CACHE_PISA_RO) when pisa_tx_skb_heads is enabled. This
  eliminates the per-driver TX header bounce-buffer patches from v1.
- TX MSG_ZEROCOPY, O_DIRECT, and buffered disk I/O migrates or allocates
  order-0 user and page-cache folios from per-node PISA allocators so
  zero-copy network sends and storage I/O also use 2MB IOMMU mappings.

All features are strictly opt-in per device via
/sys/devices/.../pisa_{coherent,rx_bufs,tx_bufs,tx_skb_heads} (and
pisa.user_max_4K_pages for user/page-cache folios). Until a device opts in,
PISA is gated off by a static key and allocates no metadata.

=== CHANGES SINCE v1 [0]

I have make use and applied several comments and suggestions received on
the previous version. The changes are massive so perhaps it makes sense
to look at the new code in isolation, unless you have already revised
in detail the previous version.

A high level summary is the following:

- Renamed DMA_PMD to PISA (CONFIG_PISA, include/linux/pisa.h,
  drivers/iommu/pisa-*.c, /sys/devices/.../pisa_*).

- Hooked __GFP_PISA_RO and __GFP_PISA_RW into __alloc_frozen_pages_noprof()
  and alloc_pages_bulk_noprof(), replacing custom pool calls in page_pool
  and socket TX refill.

- Added lockless per-CPU block caches (pisa_enable_pcp()) in front of the
  per-node order-0 RW and SKB_FRAG_PAGE_ORDER RO allocators.

- Added SLAB_CACHE_PISA_RO in SLUB and skbuff_small_head_pisa for small
  TX skb heads, dropping the per-driver TX header bounce-buffer patches.

- Added PISA support for MSG_ZEROCOPY user pages (madvise(MADV_PISA) and
  automatic upgrade on send) and block/page-cache I/O (O_DIRECT and
  buffered reads/writes), plus age/waste-based compaction and scrub
  migration (pisa.wasted_pct, pisa.old_ms, pisa.scrub_migrate).

- Made metadata table initialization and static key activation lazy on
  first device opt-in.

=== PERFORMANCE BENEFITS

Your mileage may vary. Enabling the IOMMU may have no throughput impact
until system components (bus, IOTLB, CPU) become overloaded. Aside from
throughput reduction, one key metric is IOTLB effectiveness. Below are SMMU
performance counters on a large ARM64 system with 2x200G NICs running
bidirectional traffic:

    === DMA-FQ MODE (total throughput ~440Gbps)
    25,757,488      smmuv3_pmcg_*/event=0x80/   IOTLB lookups
    16,634,941      smmuv3_pmcg_*/event=0x81/   IOTLB misses

    === PISA on top of strict DMA (total throughput ~745Gbps)
    22,693,218      smmuv3_pmcg_*/event=0x80/   IOTLB lookups
        30,536      smmuv3_pmcg_*/event=0x81/   IOTLB misses

The 2MB mappings make IOTLB misses almost non-existent because the working
set of IOTLB entries is reduced by a factor of ~512.

=== NOTES

[0] v1 (DMA_PMD):
    https://lore.kernel.org/all/20261003212241.3432303-1-lrizzo@google.com/

[1] IOMMU IMPACT AND IOTLB THRASHING
Documented in detail in Documentation/core-api/pisa.rst. In short, there
are three main costs with the IOMMU:
- CPU cost for dma_map/unmap
- CPU cost and latency for synchronous IOTLB flush (required for security)
- IOTLB thrashing when the working set of 4KB pages exceeds IOTLB capacity,
  causing IOMMU page walks that backpressure PCIe/bus traffic (30..60%
  throughput drop on high-speed NICs). See also:
  https://lore.kernel.org/all/4b42f2eb-dc29-153e-ace9-5584ea2e5070@redhat.com/
  https://www.ncbi.nlm.nih.gov/pmc/articles/PMC10280580/

[2] WHY NOT USE PAGE_POOL FOR EVERYTHING
page_pool is a consumer of PISA (via __GFP_PISA_RW), not a replacement:
- page_pool does not split 2MB pages into order-N blocks or manage shared
  2MB IOMMU mappings across domains;
- page_pool pages cannot be managed by arbitrary get_page()/put_page()
  callers (socket TX fragments, SLUB slabs, user/page-cache folios);
- page_pool requires a single NAPI consumer with BH disabled and a known
  device at allocation time, whereas socket TX, SLUB, and dma_alloc_attrs()
  run in process/preemptible context across arbitrary devices.

Luigi Rizzo (25):
  iommu/dma: Introduce CONFIG_PISA and metadata table
  iommu/dma: Add PISA allocator lifecycle and page recycle hook
  iommu/dma: Add per-NUMA-node PISA page reservoir
  iommu/dma: Add PISA block allocation
  iommu/dma: Add global cap and shrinker for PISA pages
  iommu/dma: Reserve a per-domain IOVA window for PISA pages
  iommu/dma: Release PISA domain mappings on domain teardown
  iommu/dma: Use per-domain IOVA window to map PISA memory
  driver core: Add per-device pisa_* sysfs attributes for PISA optin
  iommu/dma: Use PISA for coherent DMA allocations
  iommu/dma: Add per-CPU block caches to PISA allocators
  net/core: Use per-node PISA allocators for skb_page_frag_refill()
  net/core: Use PISA for page_pool memory
  iommu/dma: Support decrypted PISA pages
  iommu/dma: Add background page scrubber for PISA allocators
  mm/slub: Add SLAB_CACHE_PISA_RO for PISA-backed slab caches
  net: Allocate small skb heads from PISA
  iommu/dma: Migrate user pages into PISA for TX zerocopy
  iommu/dma: Stop recycling old PISA pages when allocator waste is high
  net/libeth: Use GFP_KERNEL when pre-filling RX rings
  net/gve: Use GFP_KERNEL when pre-filling RX rings
  net/gve: Use PISA memory for RX buffers
  block, mm, iommu/dma: Support PISA for disk I/O and scrub migration
  Documentation: Add PISA architecture documentation
  iommu/dma: Add PISA statistics and debugfs

 .../admin-guide/kernel-parameters.txt         |    6 +
 Documentation/core-api/index.rst              |    1 +
 Documentation/core-api/pisa.rst               |  426 ++++
 block/bio.c                                   |   46 +
 drivers/base/core.c                           |   78 +
 drivers/iommu/Kconfig                         |   34 +
 drivers/iommu/Makefile                        |    5 +
 drivers/iommu/dma-iommu.c                     |   48 +-
 drivers/iommu/dma-iommu.h                     |   16 +
 drivers/iommu/iommu.c                         |   10 +-
 drivers/iommu/pisa-alloc.c                    | 2063 +++++++++++++++++
 drivers/iommu/pisa-kunit.c                    |  669 ++++++
 drivers/iommu/pisa-map.c                      |  553 +++++
 drivers/iommu/pisa-meta.c                     |  300 +++
 drivers/iommu/pisa-node.c                     |  378 +++
 drivers/iommu/pisa-priv.h                     |  511 ++++
 drivers/iommu/pisa-user.c                     |  662 ++++++
 .../ethernet/google/gve/gve_buffer_mgmt_dqo.c |    7 +-
 drivers/net/ethernet/google/gve/gve_rx.c      |   40 +-
 include/linux/device.h                        |   27 +
 include/linux/gfp_types.h                     |   17 +-
 include/linux/netdevice.h                     |    4 +
 include/linux/pisa.h                          |  367 +++
 include/linux/sched.h                         |    4 +
 include/linux/skbuff.h                        |    2 +
 include/linux/slab.h                          |   10 +
 include/linux/swap.h                          |    1 +
 include/net/libeth/rx.h                       |   11 +-
 include/net/sock.h                            |  143 ++
 include/trace/events/mmflags.h                |   11 +-
 include/uapi/asm-generic/mman-common.h        |    2 +
 kernel/dma/direct.c                           |   14 +-
 kernel/exit.c                                 |    2 +
 kernel/fork.c                                 |    2 +
 mm/filemap.c                                  |   15 +-
 mm/madvise.c                                  |   11 +
 mm/page-writeback.c                           |    8 +
 mm/page_alloc.c                               |   59 +
 mm/readahead.c                                |    5 +-
 mm/slab.h                                     |    3 +-
 mm/slab_common.c                              |    5 +-
 mm/slub.c                                     |   14 +-
 net/core/datagram.c                           |   85 +-
 net/core/page_pool.c                          |    3 +
 net/core/skbuff.c                             |   42 +-
 net/core/sock.c                               |   62 +-
 net/ipv4/esp4.c                               |    4 +-
 net/ipv4/ip_output.c                          |   19 +-
 net/ipv4/tcp.c                                |   17 +-
 net/ipv4/tcp_output.c                         |   12 +-
 net/ipv6/esp6.c                               |    4 +-
 net/ipv6/ip6_output.c                         |   19 +-
 52 files changed, 6784 insertions(+), 73 deletions(-)
 create mode 100644 Documentation/core-api/pisa.rst
 create mode 100644 drivers/iommu/pisa-alloc.c
 create mode 100644 drivers/iommu/pisa-kunit.c
 create mode 100644 drivers/iommu/pisa-map.c
 create mode 100644 drivers/iommu/pisa-meta.c
 create mode 100644 drivers/iommu/pisa-node.c
 create mode 100644 drivers/iommu/pisa-priv.h
 create mode 100644 drivers/iommu/pisa-user.c
 create mode 100644 include/linux/pisa.h

-- 
2.56.0.542.g3ef89b7020-goog

