Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF5930F548;
	Mon, 13 Oct 2025 15:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760369672; cv=none; b=eYPZQt1zrwbNX5jo2jL34AwvkEOR/pie2ImAJ6rXzE37HIs7mxKDb2r8KmufqqYxhz1fo/oY9TIaAQzcOvRhCaj7mnRPrPcJO/sepOzn1F7rIHxTIat6DKYDMsQYX2loq8DSZFPNzoEr+rzPD+N3oUbZc9LeJ/icntHGoAYRMXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760369672; c=relaxed/simple;
	bh=I/bIg0SylyULmnELuDpSe4YzHJvk370MpRdC3YqM1nE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J6WmwFUO6QL3MPXCzZdpp0v+SFffJG+iVMT8liO5qbazl5iziTlLOFc9NcfHJJiByEzuEen6hyIj7VOiwsq8L8yCpuVVNSRF4Gb2gFLgPAFmWnZDTvnv9kRP2cwVhI5E2he1kpFS4iWkmMr2t3oJxBBUH6opEeUig0DVOJGAD3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IBPvh7xR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IBPvh7xR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91320C4CEFE;
	Mon, 13 Oct 2025 15:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760369672;
	bh=I/bIg0SylyULmnELuDpSe4YzHJvk370MpRdC3YqM1nE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IBPvh7xRMMewUScVOm/eXWpnWns22gL3BrIOK8cV43ptyFh2xtEGdjQSOblaApeUF
	 9/Q0qATsR2ygAJBHupUuvZlKSyDPgkyf+8gtJb3HdqYres5ibwxGiLYDFWyFT619vz
	 +UdSLgV7QTKW9+2wW8kL0qyzLnaOYasvokPH1P5bo1NNQnqIMhvjnXD7IBhylVnndc
	 kq/547Q+w+5XDkhZDh0gXOmcNBT8wiDoXEc+ZfqhY4rgK9z9kY8ul4qlx7sYJMkFpv
	 L/8BGjgERorFQpjRM7ddh1w+X5XLa9VcTUBNiLfZMkroaOLlLQnJhQROs6qVwgzAUX
	 cCn3UOGFb/+SQ==
From: Leon Romanovsky <leon@kernel.org>
To: Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>
Cc: Leon Romanovsky <leonro@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Keith Busch <kbusch@kernel.org>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH 3/4] block-dma: properly take MMIO path
Date: Mon, 13 Oct 2025 18:34:11 +0300
Message-ID: <cf4f6dfee380351e68932d4d114422364097dda5.1760369219.git.leon@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1760369219.git.leon@kernel.org>
References: <cover.1760369219.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>

Make sure that CPU is not synced and IOMMU is configured to take
MMIO path by providing newly introduced DMA_ATTR_MMIO attribute.

Reviewed-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 block/blk-mq-dma.c            | 23 ++++++++++++++++++++---
 include/linux/bio-integrity.h |  1 +
 include/linux/blk_types.h     |  2 ++
 3 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/block/blk-mq-dma.c b/block/blk-mq-dma.c
index 0648bcb705ff..9495b78b6fd3 100644
--- a/block/blk-mq-dma.c
+++ b/block/blk-mq-dma.c
@@ -93,8 +93,13 @@ static bool blk_dma_map_bus(struct blk_dma_iter *iter, struct phys_vec *vec)
 static bool blk_dma_map_direct(struct request *req, struct device *dma_dev,
 		struct blk_dma_iter *iter, struct phys_vec *vec)
 {
+	unsigned int attrs = 0;
+
+	if (req->cmd_flags & REQ_MMIO)
+		attrs |= DMA_ATTR_MMIO;
+
 	iter->addr = dma_map_phys(dma_dev, vec->paddr, vec->len,
-			rq_dma_dir(req), 0);
+			rq_dma_dir(req), attrs);
 	if (dma_mapping_error(dma_dev, iter->addr)) {
 		iter->status = BLK_STS_RESOURCE;
 		return false;
@@ -109,14 +114,17 @@ static bool blk_rq_dma_map_iova(struct request *req, struct device *dma_dev,
 {
 	enum dma_data_direction dir = rq_dma_dir(req);
 	unsigned int mapped = 0;
+	unsigned int attrs = 0;
 	int error;
 
 	iter->addr = state->addr;
 	iter->len = dma_iova_size(state);
+	if (req->cmd_flags & REQ_MMIO)
+		attrs |= DMA_ATTR_MMIO;
 
 	do {
 		error = dma_iova_link(dma_dev, state, vec->paddr, mapped,
-				vec->len, dir, 0);
+				vec->len, dir, attrs);
 		if (error)
 			break;
 		mapped += vec->len;
@@ -184,6 +192,11 @@ static bool blk_dma_map_iter_start(struct request *req, struct device *dma_dev,
 		 * P2P transfers through the host bridge are treated the
 		 * same as non-P2P transfers below and during unmap.
 		 */
+		if (iter->iter.is_integrity)
+			bio_integrity(req->bio)->bip_flags |= BIP_MMIO;
+		else
+			req->cmd_flags |= REQ_MMIO;
+		fallthrough;
 	case PCI_P2PDMA_MAP_NONE:
 		break;
 	default:
@@ -274,14 +287,18 @@ bool blk_rq_dma_unmap(struct request *req, struct device *dma_dev,
 		struct dma_iova_state *state, size_t mapped_len)
 {
 	struct bio_integrity_payload *bip = bio_integrity(req->bio);
+	unsigned int attrs = 0;
 
 	if ((!bip && req->cmd_flags & REQ_P2PDMA) ||
 	    bio_integrity_flagged(req->bio, BIP_P2P_DMA))
 		return true;
 
 	if (dma_use_iova(state)) {
+		if ((!bip && req->cmd_flags & REQ_MMIO) ||
+		    bio_integrity_flagged(req->bio, BIP_MMIO))
+			attrs |= DMA_ATTR_MMIO;
 		dma_iova_destroy(dma_dev, state, mapped_len, rq_dma_dir(req),
-				 0);
+				 attrs);
 		return true;
 	}
 
diff --git a/include/linux/bio-integrity.h b/include/linux/bio-integrity.h
index 851254f36eb3..b77b2cfb7b0f 100644
--- a/include/linux/bio-integrity.h
+++ b/include/linux/bio-integrity.h
@@ -14,6 +14,7 @@ enum bip_flags {
 	BIP_CHECK_REFTAG	= 1 << 6, /* reftag check */
 	BIP_CHECK_APPTAG	= 1 << 7, /* apptag check */
 	BIP_P2P_DMA		= 1 << 8, /* using P2P address */
+	BIP_MMIO		= 1 << 9, /* contains MMIO memory */
 };
 
 struct bio_integrity_payload {
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 8e8d1cc8b06c..9affa3b2d047 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -382,6 +382,7 @@ enum req_flag_bits {
 	__REQ_FS_PRIVATE,	/* for file system (submitter) use */
 	__REQ_ATOMIC,		/* for atomic write operations */
 	__REQ_P2PDMA,		/* contains P2P DMA pages */
+	__REQ_MMIO,		/* contains MMIO memory */
 	/*
 	 * Command specific flags, keep last:
 	 */
@@ -415,6 +416,7 @@ enum req_flag_bits {
 #define REQ_FS_PRIVATE	(__force blk_opf_t)(1ULL << __REQ_FS_PRIVATE)
 #define REQ_ATOMIC	(__force blk_opf_t)(1ULL << __REQ_ATOMIC)
 #define REQ_P2PDMA	(__force blk_opf_t)(1ULL << __REQ_P2PDMA)
+#define REQ_MMIO	(__force blk_opf_t)(1ULL << __REQ_MMIO)
 
 #define REQ_NOUNMAP	(__force blk_opf_t)(1ULL << __REQ_NOUNMAP)
 
-- 
2.51.0

