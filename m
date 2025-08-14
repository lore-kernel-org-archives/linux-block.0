Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69FEC29D268;
	Thu, 14 Aug 2025 17:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755194068; cv=none; b=uiK6JdMjgupO8T+P+anKlF5oDo5baa5kG3iV7wCKXVZHRJHuq+okty8hDPwzS6c1j3ufhTo7KK8UKjJ+RM8SntZk9nFJTAba2YP2llIy3zEyoJGCOMgEWcNkajI1iBpMCiGMabVoCQTPE7UPykc5ZSlBOVk7OBEtbkSKip3sf7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755194068; c=relaxed/simple;
	bh=/KA5/iirzA+7NBo2WhreWFarQonN7Bxg4iw8kozROnk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kyxRCT7uoXGQsVF1njaF37vwnWZSsaRk8xO4faOG5Fjh6j+TdIl+hcD0CCZBwOQoap7Y8gufCqp5fZkmdy6Wfc6o54fHOi1mi9WVZVjRT9rluY7SlMYYnsEoYApi4R3EQN2OZvXxSkbevtWfiKrghN3senvL1Pm48CHdBlvyTRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EOeexjxP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EOeexjxP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F8C1C4CEED;
	Thu, 14 Aug 2025 17:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755194068;
	bh=/KA5/iirzA+7NBo2WhreWFarQonN7Bxg4iw8kozROnk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EOeexjxPS/6ckwAPFRbfEI6in/li8Umj4rsGNm9PozGB9vSpZDA0l2HVvxKXWJY0H
	 c9kRUP//VlmtqQDo7vP2pT9qUIq35CfPoyCVtFUgYbGTuqU/IrXxy5Zis4lOPAfKpv
	 Qn42KxzqThq/CBCoqG+x30f0YbctMymqllyLmd8r41SkZLk0a4Vld+fYgdMxy/D7oK
	 KkD8kBg+gl3/b6HrQsdWNvwrzee1F50J0L4mqfd/q98lj6BCMP40rfPDepY0NoMJLi
	 /vr2KcIfm8mHX5eJ4IXShqV3DtPJ2Y2dAIyk9uE1jeVq3oTEm0AUda85Mgz4J38cN8
	 S/2gU/vm5nOng==
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
Subject: [PATCH v3 04/16] dma-mapping: rename trace_dma_*map_page to trace_dma_*map_phys
Date: Thu, 14 Aug 2025 20:53:55 +0300
Message-ID: <d7c9b5bedd4bacd78490799917948192dd537ca7.1755193625.git.leon@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1755193625.git.leon@kernel.org>
References: <cover.1755193625.git.leon@kernel.org>
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
index ee90d6f1dcf3..84416c7d6bfa 100644
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
index 4c1dfbabb8ae..fe1f0da6dc50 100644
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

