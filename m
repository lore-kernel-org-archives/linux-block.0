Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF129343D62;
	Tue,  9 Sep 2025 13:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757424508; cv=none; b=Cfg0169n6KUPqvUxSUYc+JsB7Lq1JYPZ2GG+wwUisgMVLsRIjKp2kRNmBrnepUanqymVtJsMl3Ly2c5MGaZeDm9Sf561NBBioqOBElZIDrWHDAUg9G0W0MnmFKGPVgwIM49UdrWbO0s0scURsOpx/DdqgMTGim2RbO5yKRDp/kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757424508; c=relaxed/simple;
	bh=m/3FWvMEP+/8V652buMynLIdEwgRPi43wgZz18MTj3M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b1i7CPSodR6Fkqo+l22q0jvaReUqyB8yHPy+lhrH9A7dCkz2hqz0SXRq4TAuxWqJh+scFlSa9zoCNXTXGyllOYqSffRcVzZe7A5fUNxAl2vPzahDSUCDEx3T1FlH3rxsfebrL6b6zQfPM2NQnj9WJWL5wRdG2lUSeYL4qQ1qojI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J1woyVLh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J1woyVLh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5E1DC4CEF5;
	Tue,  9 Sep 2025 13:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757424507;
	bh=m/3FWvMEP+/8V652buMynLIdEwgRPi43wgZz18MTj3M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J1woyVLhqM3siMNPivivEJv4VNv9s6uNc0piiXttUtdg0DDgKmV0YSZ8iAFwn4Alr
	 i3+qMLsfuJ9iNwKrXrEh3Gws4/K2iEAToxhQNQRXHpqnn6JdhSO4dpZT934lxzQik/
	 O7NdvZ5UQ9AQqZA3NGDNaMt/iPOjxHoruIxaXyeL+Muz472ygrFNWUvBi2XbazYeKs
	 f6ctLEh0WQXu5o3Q7G7BI3TeRYALJWhN1JAzf58uBQBm+HT/TLHbHonKigOdYlr4LE
	 wORVtoiGviO3dG7x+I9o7DQ7kX+JtTcYcgSvq5O39pFQ72XF5HX25y58wNQqXX7NAx
	 AVQmxHiCRj5Sw==
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
Subject: [PATCH v6 04/16] dma-mapping: rename trace_dma_*map_page to trace_dma_*map_phys
Date: Tue,  9 Sep 2025 16:27:32 +0300
Message-ID: <c0c02d7d8bd4a148072d283353ba227516a76682.1757423202.git.leonro@nvidia.com>
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

As a preparation for following map_page -> map_phys API conversion,
let's rename trace_dma_*map_page() to be trace_dma_*map_phys().

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 include/trace/events/dma.h | 4 ++--
 kernel/dma/mapping.c       | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/trace/events/dma.h b/include/trace/events/dma.h
index ee90d6f1dcf35..84416c7d6bfaa 100644
--- a/include/trace/events/dma.h
+++ b/include/trace/events/dma.h
@@ -72,7 +72,7 @@ DEFINE_EVENT(dma_map, name, \
 		 size_t size, enum dma_data_direction dir, unsigned long attrs), \
 	TP_ARGS(dev, phys_addr, dma_addr, size, dir, attrs))
 
-DEFINE_MAP_EVENT(dma_map_page);
+DEFINE_MAP_EVENT(dma_map_phys);
 DEFINE_MAP_EVENT(dma_map_resource);
 
 DECLARE_EVENT_CLASS(dma_unmap,
@@ -110,7 +110,7 @@ DEFINE_EVENT(dma_unmap, name, \
 		 enum dma_data_direction dir, unsigned long attrs), \
 	TP_ARGS(dev, addr, size, dir, attrs))
 
-DEFINE_UNMAP_EVENT(dma_unmap_page);
+DEFINE_UNMAP_EVENT(dma_unmap_phys);
 DEFINE_UNMAP_EVENT(dma_unmap_resource);
 
 DECLARE_EVENT_CLASS(dma_alloc_class,
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index 0b7e16c69bf18..bd3bb6d59d722 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -173,7 +173,7 @@ dma_addr_t dma_map_page_attrs(struct device *dev, struct page *page,
 	else
 		addr = ops->map_page(dev, page, offset, size, dir, attrs);
 	kmsan_handle_dma(page, offset, size, dir);
-	trace_dma_map_page(dev, phys, addr, size, dir, attrs);
+	trace_dma_map_phys(dev, phys, addr, size, dir, attrs);
 	debug_dma_map_phys(dev, phys, size, dir, addr, attrs);
 
 	return addr;
@@ -193,7 +193,7 @@ void dma_unmap_page_attrs(struct device *dev, dma_addr_t addr, size_t size,
 		iommu_dma_unmap_page(dev, addr, size, dir, attrs);
 	else
 		ops->unmap_page(dev, addr, size, dir, attrs);
-	trace_dma_unmap_page(dev, addr, size, dir, attrs);
+	trace_dma_unmap_phys(dev, addr, size, dir, attrs);
 	debug_dma_unmap_phys(dev, addr, size, dir);
 }
 EXPORT_SYMBOL(dma_unmap_page_attrs);
-- 
2.51.0

