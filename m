Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6A9145FE8
	for <linux-block@vger.kernel.org>; Mon, 23 Jun 2025 14:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750687993; cv=none; b=TRfDgMBJEgr2GaurZQO/2cZfuE4EYOq3oEPR2egczgQ4MmpmigS5TrcdtOduf7IDFV8BvH8VT5oWMvyDjPq3MPkQxWs5U3feP3T1+9OLnzqD8eO4ihp+FzSU+zEPme0s3taJDadfdlBmrRF1wxGmnjYXEs3NgW7KNgwOqGzRWG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750687993; c=relaxed/simple;
	bh=wrTlFo3aMnm8nQLKscKqlCdwbhS6DNBo2QtBdwP4TUo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oxw4tTIBQSvszYxqZ3zqcYVvskfEurm7wUTmas1nVXBAs9UPyiIQ2hdWUz/RoLUqQY+SiTeA7b7g/4HlOFyNIKn2okMt4g6D7yAYUgIhT+mW8gANh/piumVkggP+FVKk4UzKYIqZtsx58i/DyQCuwMviskNrnxxpkrBzjh+aJWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=2zcmlC44; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2zcmlC44"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=StYT37BMhRQIWBmgpqvpGSm0p8vJciWiV2lqcPpdD9k=; b=2zcmlC441Lzrc7sbVBjXkUvJQ8
	hwqo7qlrRO8BavEiJcCPG03IHhi8LkRchWh+XbWR08c8QSS7cOSER7k3AaCaIp2hDULZF6MTkaRHE
	mUMaORek5ZOxqRd+TJ5gQ6uF5oquhuUtPvBZVfjcXfUSehWz1NkrbZWipcLxvY+C/9BG8rG4HEZTI
	2Owvlb84CSKi686vx5IN56npGizJAi/M/KHNtljDJTcImTlGhkyo51ZGV2wg3KQow2Sk3lGCugQxD
	dceflnJNICUtBz489QoE7adnTIKHw77aVBomzOmwDtON/HDGG1m3m5R7d9dc9VKWEMZRzYmTm5rmm
	4ri632pA==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uThv3-00000002zof-0Le6;
	Mon, 23 Jun 2025 14:13:09 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Leon Romanovsky <leon@kernel.org>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Leon Romanovsky <leonro@nvidia.com>
Subject: [PATCH 2/8] block: add scatterlist-less DMA mapping helpers
Date: Mon, 23 Jun 2025 16:12:24 +0200
Message-ID: <20250623141259.76767-3-hch@lst.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250623141259.76767-1-hch@lst.de>
References: <20250623141259.76767-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Add a new blk_rq_dma_map / blk_rq_dma_unmap pair that does away with
the wasteful scatterlist structure.  Instead it uses the mapping iterator
to either add segments to the IOVA for IOMMU operations, or just maps
them one by one for the direct mapping.  For the IOMMU case instead of
a scatterlist with an entry for each segment, only a single [dma_addr,len]
pair needs to be stored for processing a request, and for the direct
mapping the per-segment allocation shrinks from
[page,offset,len,dma_addr,dma_len] to just [dma_addr,len].

One big difference to the scatterlist API, which could be considered
downside, is that the IOVA collapsing only works when the driver sets
a virt_boundary that matches the IOMMU granule.  For NVMe this is done
already so it works perfectly.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
---
 block/blk-mq-dma.c         | 161 +++++++++++++++++++++++++++++++++++++
 include/linux/blk-mq-dma.h |  63 +++++++++++++++
 2 files changed, 224 insertions(+)
 create mode 100644 include/linux/blk-mq-dma.h

diff --git a/block/blk-mq-dma.c b/block/blk-mq-dma.c
index 82bae475dfa4..ad283017caef 100644
--- a/block/blk-mq-dma.c
+++ b/block/blk-mq-dma.c
@@ -2,6 +2,7 @@
 /*
  * Copyright (C) 2025 Christoph Hellwig
  */
+#include <linux/blk-mq-dma.h>
 #include "blk.h"
 
 struct phys_vec {
@@ -61,6 +62,166 @@ static bool blk_map_iter_next(struct request *req, struct req_iterator *iter,
 	return true;
 }
 
+/*
+ * The IOVA-based DMA API wants to be able to coalesce at the minimal IOMMU page
+ * size granularity (which is guaranteed to be <= PAGE_SIZE and usually 4k), so
+ * we need to ensure our segments are aligned to this as well.
+ *
+ * Note that there is no point in using the slightly more complicated IOVA based
+ * path for single segment mappings.
+ */
+static inline bool blk_can_dma_map_iova(struct request *req,
+		struct device *dma_dev)
+{
+	return !((queue_virt_boundary(req->q) + 1) &
+		dma_get_merge_boundary(dma_dev));
+}
+
+static bool blk_dma_map_bus(struct blk_dma_iter *iter, struct phys_vec *vec)
+{
+	iter->addr = pci_p2pdma_bus_addr_map(&iter->p2pdma, vec->paddr);
+	iter->len = vec->len;
+	return true;
+}
+
+static bool blk_dma_map_direct(struct request *req, struct device *dma_dev,
+		struct blk_dma_iter *iter, struct phys_vec *vec)
+{
+	iter->addr = dma_map_page(dma_dev, phys_to_page(vec->paddr),
+			offset_in_page(vec->paddr), vec->len, rq_dma_dir(req));
+	if (dma_mapping_error(dma_dev, iter->addr)) {
+		iter->status = BLK_STS_RESOURCE;
+		return false;
+	}
+	iter->len = vec->len;
+	return true;
+}
+
+static bool blk_rq_dma_map_iova(struct request *req, struct device *dma_dev,
+		struct dma_iova_state *state, struct blk_dma_iter *iter,
+		struct phys_vec *vec)
+{
+	enum dma_data_direction dir = rq_dma_dir(req);
+	unsigned int mapped = 0;
+	int error;
+
+	iter->addr = state->addr;
+	iter->len = dma_iova_size(state);
+
+	do {
+		error = dma_iova_link(dma_dev, state, vec->paddr, mapped,
+				vec->len, dir, 0);
+		if (error)
+			break;
+		mapped += vec->len;
+	} while (blk_map_iter_next(req, &iter->iter, vec));
+
+	error = dma_iova_sync(dma_dev, state, 0, mapped);
+	if (error) {
+		iter->status = errno_to_blk_status(error);
+		return false;
+	}
+
+	return true;
+}
+
+/**
+ * blk_rq_dma_map_iter_start - map the first DMA segment for a request
+ * @req:	request to map
+ * @dma_dev:	device to map to
+ * @state:	DMA IOVA state
+ * @iter:	block layer DMA iterator
+ *
+ * Start DMA mapping @req to @dma_dev.  @state and @iter are provided by the
+ * caller and don't need to be initialized.  @state needs to be stored for use
+ * at unmap time, @iter is only needed at map time.
+ *
+ * Returns %false if there is no segment to map, including due to an error, or
+ * %true ft it did map a segment.
+ *
+ * If a segment was mapped, the DMA address for it is returned in @iter.addr and
+ * the length in @iter.len.  If no segment was mapped the status code is
+ * returned in @iter.status.
+ *
+ * The caller can call blk_rq_dma_map_coalesce() to check if further segments
+ * need to be mapped after this, or go straight to blk_rq_dma_map_iter_next()
+ * to try to map the following segments.
+ */
+bool blk_rq_dma_map_iter_start(struct request *req, struct device *dma_dev,
+		struct dma_iova_state *state, struct blk_dma_iter *iter)
+{
+	unsigned int total_len = blk_rq_payload_bytes(req);
+	struct phys_vec vec;
+
+	iter->iter.bio = req->bio;
+	iter->iter.iter = req->bio->bi_iter;
+	memset(&iter->p2pdma, 0, sizeof(iter->p2pdma));
+	iter->status = BLK_STS_OK;
+
+	/*
+	 * Grab the first segment ASAP because we'll need it to check for P2P
+	 * transfers.
+	 */
+	if (!blk_map_iter_next(req, &iter->iter, &vec))
+		return false;
+
+	if (IS_ENABLED(CONFIG_PCI_P2PDMA) && (req->cmd_flags & REQ_P2PDMA)) {
+		switch (pci_p2pdma_state(&iter->p2pdma, dma_dev,
+					 phys_to_page(vec.paddr))) {
+		case PCI_P2PDMA_MAP_BUS_ADDR:
+			return blk_dma_map_bus(iter, &vec);
+		case PCI_P2PDMA_MAP_THRU_HOST_BRIDGE:
+			/*
+			 * P2P transfers through the host bridge are treated the
+			 * same as non-P2P transfers below and during unmap.
+			 */
+			req->cmd_flags &= ~REQ_P2PDMA;
+			break;
+		default:
+			iter->status = BLK_STS_INVAL;
+			return false;
+		}
+	}
+
+	if (blk_can_dma_map_iova(req, dma_dev) &&
+	    dma_iova_try_alloc(dma_dev, state, vec.paddr, total_len))
+		return blk_rq_dma_map_iova(req, dma_dev, state, iter, &vec);
+	return blk_dma_map_direct(req, dma_dev, iter, &vec);
+}
+EXPORT_SYMBOL_GPL(blk_rq_dma_map_iter_start);
+
+/**
+ * blk_rq_dma_map_iter_next - map the next DMA segment for a request
+ * @req:	request to map
+ * @dma_dev:	device to map to
+ * @state:	DMA IOVA state
+ * @iter:	block layer DMA iterator
+ *
+ * Iterate to the next mapping after a previous call to
+ * blk_rq_dma_map_iter_start().  See there for a detailed description of the
+ * arguments.
+ *
+ * Returns %false if there is no segment to map, including due to an error, or
+ * %true ft it did map a segment.
+ *
+ * If a segment was mapped, the DMA address for it is returned in @iter.addr and
+ * the length in @iter.len.  If no segment was mapped the status code is
+ * returned in @iter.status.
+ */
+bool blk_rq_dma_map_iter_next(struct request *req, struct device *dma_dev,
+		struct dma_iova_state *state, struct blk_dma_iter *iter)
+{
+	struct phys_vec vec;
+
+	if (!blk_map_iter_next(req, &iter->iter, &vec))
+		return false;
+
+	if (iter->p2pdma.map == PCI_P2PDMA_MAP_BUS_ADDR)
+		return blk_dma_map_bus(iter, &vec);
+	return blk_dma_map_direct(req, dma_dev, iter, &vec);
+}
+EXPORT_SYMBOL_GPL(blk_rq_dma_map_iter_next);
+
 static inline struct scatterlist *
 blk_next_sg(struct scatterlist **sg, struct scatterlist *sglist)
 {
diff --git a/include/linux/blk-mq-dma.h b/include/linux/blk-mq-dma.h
new file mode 100644
index 000000000000..c26a01aeae00
--- /dev/null
+++ b/include/linux/blk-mq-dma.h
@@ -0,0 +1,63 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef BLK_MQ_DMA_H
+#define BLK_MQ_DMA_H
+
+#include <linux/blk-mq.h>
+#include <linux/pci-p2pdma.h>
+
+struct blk_dma_iter {
+	/* Output address range for this iteration */
+	dma_addr_t			addr;
+	u32				len;
+
+	/* Status code. Only valid when blk_rq_dma_map_iter_* returned false */
+	blk_status_t			status;
+
+	/* Internal to blk_rq_dma_map_iter_* */
+	struct req_iterator		iter;
+	struct pci_p2pdma_map_state	p2pdma;
+};
+
+bool blk_rq_dma_map_iter_start(struct request *req, struct device *dma_dev,
+		struct dma_iova_state *state, struct blk_dma_iter *iter);
+bool blk_rq_dma_map_iter_next(struct request *req, struct device *dma_dev,
+		struct dma_iova_state *state, struct blk_dma_iter *iter);
+
+/**
+ * blk_rq_dma_map_coalesce - were all segments coalesced?
+ * @state: DMA state to check
+ *
+ * Returns true if blk_rq_dma_map_iter_start coalesced all segments into a
+ * single DMA range.
+ */
+static inline bool blk_rq_dma_map_coalesce(struct dma_iova_state *state)
+{
+	return dma_use_iova(state);
+}
+
+/**
+ * blk_rq_dma_unmap - try to DMA unmap a request
+ * @req:	request to unmap
+ * @dma_dev:	device to unmap from
+ * @state:	DMA IOVA state
+ * @mapped_len: number of bytes to unmap
+ *
+ * Returns %false if the callers need to manually unmap every DMA segment
+ * mapped using @iter or %true if no work is left to be done.
+ */
+static inline bool blk_rq_dma_unmap(struct request *req, struct device *dma_dev,
+		struct dma_iova_state *state, size_t mapped_len)
+{
+	if (req->cmd_flags & REQ_P2PDMA)
+		return true;
+
+	if (dma_use_iova(state)) {
+		dma_iova_destroy(dma_dev, state, mapped_len, rq_dma_dir(req),
+				 0);
+		return true;
+	}
+
+	return !dma_need_unmap(dma_dev);
+}
+
+#endif /* BLK_MQ_DMA_H */
-- 
2.47.2

