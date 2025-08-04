Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27802550A4;
	Mon,  4 Aug 2025 12:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754311417; cv=none; b=AP1tOngeamYvoj2SqMSxAh09wgRNVDMYCOG2RAYHSWS9FUUo+59gp/7b5dKvfiuBUcUZ1k0f7WXLE+0HOUx1m3Z997IcCMwHbZmpftfP2S3qX03tb0AhUE7OdjiQ3wfZwt969zsdei8IW0MUIdg5ibVF9urfqPfGGzx/zmmJoEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754311417; c=relaxed/simple;
	bh=gXQfTddyrmH8Ixen8MMOQFcSDtf75ytBbFmEnbpkIK0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p4t6E7Fpdg+Hcl79ay+BkpfwrTVF4gmzJhOjuApBEGCsCodCljFOpPyaQV7aPEX0FtRFDol86gEWwglsjOfmCK558AJwbPALi3hXJX//ZN6P26kms1WjJQskWhduB4JD305gv9UcjN/W867y4VK5LYVp/3RcE9/LvsaQmIW3EWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WRgsvRlF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WRgsvRlF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7673FC4CEE7;
	Mon,  4 Aug 2025 12:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754311414;
	bh=gXQfTddyrmH8Ixen8MMOQFcSDtf75ytBbFmEnbpkIK0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WRgsvRlFW0e77jc7NIsyBW2keN26coVZrkVCiSkqs4aw+XPWcg7vc+V1XlKoIcE88
	 IOIbPQelgEDLheM/qg7mVhJZzAqXm7CUjMAMKNzC+umg0g7DwYC9YBLyHXL0I66FCh
	 IFbMO71xVEUgxdJl2+IupUgaBpdkpCp+VfiDgWnzz0MMd73xSf4ctXSScspzbf7J4C
	 MQm70SnKxDBQEq6Qi5EQDhrkAfT+WwzTZQfsthVUSLn1pLEnK9pcRGmBAGcQOXI3DR
	 pSMdvMXvMDulNitg5dtAwYyxJ7hDxcGMKpGt6kEpCAlccx1SJGPya+SDEHg8s11i4i
	 u8QgrR2e/DTYQ==
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
Subject: [PATCH v1 04/16] dma-mapping: rename trace_dma_*map_page to trace_dma_*map_phys
Date: Mon,  4 Aug 2025 15:42:38 +0300
Message-ID: <7e10dcba2f3108efc6af13bfdbe8f09073835838.1754292567.git.leon@kernel.org>
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

As a preparation for following map_page -> map_phys API conversion,
let's rename trace_dma_*map_page() to be trace_dma_*map_phys().

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
index 4c1dfbabb8ae5..fe1f0da6dc507 100644
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
2.50.1

