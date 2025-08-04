Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32FD7273D82;
	Mon,  4 Aug 2025 12:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754311455; cv=none; b=HC8Kz926ZOAP9eyIGGoi+e9Jsxyn5BObcKHsxGHZVh048koPKtCe5gdV0sBgHyuRc1N8h9FKPaVqD2XpTbW/CZyYZhxKW7nxlMLsVF++vdrS9TwsG17gRnxlqPW83uys4k10tsOyMPK3tFtKVH2bb439CStQuSOD5+xiuMbbXB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754311455; c=relaxed/simple;
	bh=qnVGWPERMw1BTa2/gk85Rr9nCLsamOSAPU4HKvyJS1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IdIageNjSejis1cl/9twl5nCfQhZrx/VgM2cHFFjCtc8QUHH81GuDn/ZoSMW0FNB7RF4RSfVNihCtkvzqjS1BfUcS2BrPaSr4FXxcxhlYttD9TtttiUVtEVqiP04QWapG+/YPKYgaanF9iDuXUvBcDtAh0gbT2tXYSFuwrBUSrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OtgAnXB9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OtgAnXB9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58081C4CEF0;
	Mon,  4 Aug 2025 12:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754311454;
	bh=qnVGWPERMw1BTa2/gk85Rr9nCLsamOSAPU4HKvyJS1c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OtgAnXB9G/hO4kHiG6lUbx1lGdhplK8QSnQvERbDkZeJ2rBPi5BohP2fOcU1EY1H0
	 LWK7JmM6eYjvDV85Iv2oqAeUvxpoecgv6pnhGevxoOAJjwoIKIBVlnyhDtWl6iMFdx
	 RkkwEUkNj1PK4RIEa7lvhblH+3HASR9LDXUdd9ooPuLmkTQNLafsqp7vExm+lHX79L
	 xgsW9Dlqtb1H+ROfUItFyQuMNgUa0HHgvJ+5cBoMm5E0OKANto/+eCMPooaSWD2S6k
	 W4Hqu5Itep2BtJPMCEt1CECg7NNUHsl45+R6007i0eogZT7o+A+uJhsGr5xPHo73g0
	 Vn+VRBXex4Xsg==
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
Subject: [PATCH v1 10/16] xen: swiotlb: Open code map_resource callback
Date: Mon,  4 Aug 2025 15:42:44 +0300
Message-ID: <e69e9510d9024d664133dc788f5186aac414318e.1754292567.git.leon@kernel.org>
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

General dma_direct_map_resource() is going to be removed
in next patch, so simply open-code it in xen driver.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/xen/swiotlb-xen.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index da1a7d3d377cf..dd7747a2de879 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -392,6 +392,25 @@ xen_swiotlb_sync_sg_for_device(struct device *dev, struct scatterlist *sgl,
 	}
 }
 
+static dma_addr_t xen_swiotlb_direct_map_resource(struct device *dev,
+						  phys_addr_t paddr,
+						  size_t size,
+						  enum dma_data_direction dir,
+						  unsigned long attrs)
+{
+	dma_addr_t dma_addr = paddr;
+
+	if (unlikely(!dma_capable(dev, dma_addr, size, false))) {
+		dev_err_once(dev,
+			     "DMA addr %pad+%zu overflow (mask %llx, bus limit %llx).\n",
+			     &dma_addr, size, *dev->dma_mask, dev->bus_dma_limit);
+		WARN_ON_ONCE(1);
+		return DMA_MAPPING_ERROR;
+	}
+
+	return dma_addr;
+}
+
 /*
  * Return whether the given device DMA address mask can be supported
  * properly.  For example, if your device can only drive the low 24-bits
@@ -426,5 +445,5 @@ const struct dma_map_ops xen_swiotlb_dma_ops = {
 	.alloc_pages_op = dma_common_alloc_pages,
 	.free_pages = dma_common_free_pages,
 	.max_mapping_size = swiotlb_max_mapping_size,
-	.map_resource = dma_direct_map_resource,
+	.map_resource = xen_swiotlb_direct_map_resource,
 };
-- 
2.50.1

