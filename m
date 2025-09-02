Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C775311C10;
	Tue,  2 Sep 2025 14:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756824554; cv=none; b=HFZF513mKBEU0FIwONqcuoolxTg96WuvlsE74LsPoZQL9jcJaCnvKrUGYDKExHjuHgcI22KBaMY21mDcH8wuWH8GbGqYUNQP0f1ODM7MwugCpKQpVKj8WZjmmvBtv2BKmax4nNHV22ePQtpPvwQNs4D5XnKoImyp8+KG/l+rZFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756824554; c=relaxed/simple;
	bh=bQCJOhk6/urs9rnk28jsW9huZ5BmqRf4rlNcWoQochY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u04PQXmWOp2KdQtdlK0hREGeJpUwSNcNDW6I0tENpETtNzK9Lcdpl6RMCSYCriGeNNhwp2oC0O6WBDsipwjYSKmHVQU8EoHCngyFrePlU/GwNsIKMADzEStmAkpAGiXcaPLbBGmAcWpozmEzS+N81Q+lUx10LIoss3Oowxi7UBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qNA0rpdI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qNA0rpdI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D3AAC4CEED;
	Tue,  2 Sep 2025 14:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756824553;
	bh=bQCJOhk6/urs9rnk28jsW9huZ5BmqRf4rlNcWoQochY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qNA0rpdIfDKcKY8jylpr6rIPXKRrMZ2SSvxdExkc4iYFUg9CGiS5XwAxPyEf8F+qA
	 AFogSmagV9JyRlbdhVx9tx/4ZYBW3H5JGbQk2Cby5UXJj532uQQp72RE6MsPyvuxDQ
	 uroJ+7G99RhoyzZEntv72aqyl+sgfCBGI21ScktmjfktL21+44tukkP/L5aZVh3NC5
	 iE3uMu+rgCByY9sAMLkloAREC/O3bNxIEONVHjqR+3zFFnDdxFyQ+sUuX5VXRZOo1X
	 3naF/+0zGlWHD0/zMTwdb3f5RNa+dkqF/arrZ1VZMVnkpGQYpnYYxl5o8UVINu+IDv
	 zbchkle3zvSEQ==
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
Subject: [PATCH v5 01/16] dma-mapping: introduce new DMA attribute to indicate MMIO memory
Date: Tue,  2 Sep 2025 17:48:38 +0300
Message-ID: <9cce2a2bf181edacb33151388caa47725f780907.1756822782.git.leon@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1756822782.git.leon@kernel.org>
References: <cover.1756822782.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>

This patch introduces the DMA_ATTR_MMIO attribute to mark DMA buffers
that reside in memory-mapped I/O (MMIO) regions, such as device BARs
exposed through the host bridge, which are accessible for peer-to-peer
(P2P) DMA.

This attribute is especially useful for exporting device memory to other
devices for DMA without CPU involvement, and avoids unnecessary or
potentially detrimental CPU cache maintenance calls.

DMA_ATTR_MMIO is supposed to provide dma_map_resource() functionality
without need to call to special function and perform branching when
processing generic containers like bio_vec by the callers.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 Documentation/core-api/dma-attributes.rst | 18 ++++++++++++++++++
 include/linux/dma-mapping.h               | 20 ++++++++++++++++++++
 include/trace/events/dma.h                |  3 ++-
 rust/kernel/dma.rs                        |  3 +++
 4 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/Documentation/core-api/dma-attributes.rst b/Documentation/core-api/dma-attributes.rst
index 1887d92e8e92..0bdc2be65e57 100644
--- a/Documentation/core-api/dma-attributes.rst
+++ b/Documentation/core-api/dma-attributes.rst
@@ -130,3 +130,21 @@ accesses to DMA buffers in both privileged "supervisor" and unprivileged
 subsystem that the buffer is fully accessible at the elevated privilege
 level (and ideally inaccessible or at least read-only at the
 lesser-privileged levels).
+
+DMA_ATTR_MMIO
+-------------
+
+This attribute indicates the physical address is not normal system
+memory. It may not be used with kmap*()/phys_to_virt()/phys_to_page()
+functions, it may not be cacheable, and access using CPU load/store
+instructions may not be allowed.
+
+Usually this will be used to describe MMIO addresses, or other non-cacheable
+register addresses. When DMA mapping this sort of address we call
+the operation Peer to Peer as a one device is DMA'ing to another device.
+For PCI devices the p2pdma APIs must be used to determine if
+DMA_ATTR_MMIO is appropriate.
+
+For architectures that require cache flushing for DMA coherence
+DMA_ATTR_MMIO will not perform any cache flushing. The address
+provided must never be mapped cacheable into the CPU.
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 55c03e5fe8cb..4254fd9bdf5d 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -58,6 +58,26 @@
  */
 #define DMA_ATTR_PRIVILEGED		(1UL << 9)
 
+/*
+ * DMA_ATTR_MMIO - Indicates memory-mapped I/O (MMIO) region for DMA mapping
+ *
+ * This attribute indicates the physical address is not normal system
+ * memory. It may not be used with kmap*()/phys_to_virt()/phys_to_page()
+ * functions, it may not be cacheable, and access using CPU load/store
+ * instructions may not be allowed.
+ *
+ * Usually this will be used to describe MMIO addresses, or other non-cacheable
+ * register addresses. When DMA mapping this sort of address we call
+ * the operation Peer to Peer as a one device is DMA'ing to another device.
+ * For PCI devices the p2pdma APIs must be used to determine if DMA_ATTR_MMIO
+ * is appropriate.
+ *
+ * For architectures that require cache flushing for DMA coherence
+ * DMA_ATTR_MMIO will not perform any cache flushing. The address
+ * provided must never be mapped cacheable into the CPU.
+ */
+#define DMA_ATTR_MMIO		(1UL << 10)
+
 /*
  * A dma_addr_t can hold any valid DMA or bus address for the platform.  It can
  * be given to a device to use as a DMA source or target.  It is specific to a
diff --git a/include/trace/events/dma.h b/include/trace/events/dma.h
index d8ddc27b6a7c..ee90d6f1dcf3 100644
--- a/include/trace/events/dma.h
+++ b/include/trace/events/dma.h
@@ -31,7 +31,8 @@ TRACE_DEFINE_ENUM(DMA_NONE);
 		{ DMA_ATTR_FORCE_CONTIGUOUS, "FORCE_CONTIGUOUS" }, \
 		{ DMA_ATTR_ALLOC_SINGLE_PAGES, "ALLOC_SINGLE_PAGES" }, \
 		{ DMA_ATTR_NO_WARN, "NO_WARN" }, \
-		{ DMA_ATTR_PRIVILEGED, "PRIVILEGED" })
+		{ DMA_ATTR_PRIVILEGED, "PRIVILEGED" }, \
+		{ DMA_ATTR_MMIO, "MMIO" })
 
 DECLARE_EVENT_CLASS(dma_map,
 	TP_PROTO(struct device *dev, phys_addr_t phys_addr, dma_addr_t dma_addr,
diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
index 2bc8ab51ec28..61d9eed7a786 100644
--- a/rust/kernel/dma.rs
+++ b/rust/kernel/dma.rs
@@ -242,6 +242,9 @@ pub mod attrs {
     /// Indicates that the buffer is fully accessible at an elevated privilege level (and
     /// ideally inaccessible or at least read-only at lesser-privileged levels).
     pub const DMA_ATTR_PRIVILEGED: Attrs = Attrs(bindings::DMA_ATTR_PRIVILEGED);
+
+    /// Indicates that the buffer is MMIO memory.
+    pub const DMA_ATTR_MMIO: Attrs = Attrs(bindings::DMA_ATTR_MMIO);
 }
 
 /// An abstraction of the `dma_alloc_coherent` API.
-- 
2.50.1

