Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B3030EF97;
	Mon, 13 Oct 2025 15:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760369668; cv=none; b=UMzScgdoIOoXVyyr7lpcbfGAo3znjBh6UlYAmvs2InsPuizDEolT9ZZqYYc5G9nno1YlJQ7pHUzpGd7qcj77BByYVYwKjqgp5eO8zaVFR/R1RKfYFMqFyaOmEag0iAIIw6MFuaRFun07lmK0JyZJvw4byutsE7rNXn4iOOt/RNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760369668; c=relaxed/simple;
	bh=CkZHJYkrGRckP1QGodwp/pnp6qcw83Gg8wQFpG7pkV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jb+dF/kX3HLWMciW4UQzdOfMrltiD79AiCFVyDAAsqSHNU1IbSf7Oykpk6Ky7uW+KWbouZ8ZLgpiYYTbCFSz1HWYIdSVJfiK5Ahf7BLUxRIoQuoytc8ko2/VsESikAVSDGRRft8/EwGod1F5M4FTQuGC+IUZaAMuz1Hloxj1wfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QspFKLI4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QspFKLI4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C79FDC4CEE7;
	Mon, 13 Oct 2025 15:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760369668;
	bh=CkZHJYkrGRckP1QGodwp/pnp6qcw83Gg8wQFpG7pkV4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QspFKLI452/im+Lu8LrFA68k+h/JF4bMOH2CuJQIAv+EdHMu0HZWxRzWwNOQN0LNA
	 65OCcUQm1jAA743ab8ggFJRfH3avB3EdCQq3MMmsIFmbNJa9+x05s/xa0Ei5YGhYP4
	 VDHL/+rXJy4nUz8u3tFaJHn16bzCD/X9WpFBAhH1J/ouuxQsWCwZQlKGm5mkMJUlVs
	 YO9iCuPzoqhLfKxCY4L98I/3iMLejzD3JJUyMEskzu+SENNwdCYqWO70K3S9qzZ1fK
	 yu+pCnynEfB6nG0+h1P81qgeQ/Kare7ahJXBmA1DumM+dJTQ3iF1P6dBLq7mUV27W8
	 Jxf+JOJCi38Hg==
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
Subject: [PATCH 2/4] blk-mq-dma: unify DMA unmap routine
Date: Mon, 13 Oct 2025 18:34:10 +0300
Message-ID: <04baf1fdff8a04197d5f64c2653c29e7482a2840.1760369219.git.leon@kernel.org>
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

Combine regular and meta-intgerity DMA unmapping flow to one
blk_rq_dma_unmap(). This allows us to handle addition of new
DMA_ATTR_MMIO flow without adding extra function parameters.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 block/blk-mq-dma.c            | 29 +++++++++++++++++++++++++++++
 include/linux/blk-integrity.h |  3 +--
 include/linux/blk-mq-dma.h    | 35 ++---------------------------------
 3 files changed, 32 insertions(+), 35 deletions(-)

diff --git a/block/blk-mq-dma.c b/block/blk-mq-dma.c
index 4ba7b0323da4..0648bcb705ff 100644
--- a/block/blk-mq-dma.c
+++ b/block/blk-mq-dma.c
@@ -260,6 +260,35 @@ bool blk_rq_dma_map_iter_next(struct request *req, struct device *dma_dev,
 }
 EXPORT_SYMBOL_GPL(blk_rq_dma_map_iter_next);
 
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
+bool blk_rq_dma_unmap(struct request *req, struct device *dma_dev,
+		struct dma_iova_state *state, size_t mapped_len)
+{
+	struct bio_integrity_payload *bip = bio_integrity(req->bio);
+
+	if ((!bip && req->cmd_flags & REQ_P2PDMA) ||
+	    bio_integrity_flagged(req->bio, BIP_P2P_DMA))
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
+EXPORT_SYMBOL(blk_rq_dma_unmap);
+
 static inline struct scatterlist *
 blk_next_sg(struct scatterlist **sg, struct scatterlist *sglist)
 {
diff --git a/include/linux/blk-integrity.h b/include/linux/blk-integrity.h
index b659373788f6..4a0e65f00bd6 100644
--- a/include/linux/blk-integrity.h
+++ b/include/linux/blk-integrity.h
@@ -32,8 +32,7 @@ static inline bool blk_rq_integrity_dma_unmap(struct request *req,
 		struct device *dma_dev, struct dma_iova_state *state,
 		size_t mapped_len)
 {
-	return blk_dma_unmap(req, dma_dev, state, mapped_len,
-			bio_integrity(req->bio)->bip_flags & BIP_P2P_DMA);
+	return blk_rq_dma_unmap(req, dma_dev, state, mapped_len);
 }
 
 int blk_rq_count_integrity_sg(struct request_queue *, struct bio *);
diff --git a/include/linux/blk-mq-dma.h b/include/linux/blk-mq-dma.h
index 51829958d872..e93e167ec551 100644
--- a/include/linux/blk-mq-dma.h
+++ b/include/linux/blk-mq-dma.h
@@ -29,6 +29,8 @@ bool blk_rq_dma_map_iter_start(struct request *req, struct device *dma_dev,
 		struct dma_iova_state *state, struct blk_dma_iter *iter);
 bool blk_rq_dma_map_iter_next(struct request *req, struct device *dma_dev,
 		struct dma_iova_state *state, struct blk_dma_iter *iter);
+bool blk_rq_dma_unmap(struct request *req, struct device *dma_dev,
+		struct dma_iova_state *state, size_t mapped_len);
 
 /**
  * blk_rq_dma_map_coalesce - were all segments coalesced?
@@ -42,37 +44,4 @@ static inline bool blk_rq_dma_map_coalesce(struct dma_iova_state *state)
 	return dma_use_iova(state);
 }
 
-/**
- * blk_dma_unmap - try to DMA unmap a request
- * @req:	request to unmap
- * @dma_dev:	device to unmap from
- * @state:	DMA IOVA state
- * @mapped_len: number of bytes to unmap
- * @is_p2p:	true if mapped with PCI_P2PDMA_MAP_BUS_ADDR
- *
- * Returns %false if the callers need to manually unmap every DMA segment
- * mapped using @iter or %true if no work is left to be done.
- */
-static inline bool blk_dma_unmap(struct request *req, struct device *dma_dev,
-		struct dma_iova_state *state, size_t mapped_len, bool is_p2p)
-{
-	if (is_p2p)
-		return true;
-
-	if (dma_use_iova(state)) {
-		dma_iova_destroy(dma_dev, state, mapped_len, rq_dma_dir(req),
-				 0);
-		return true;
-	}
-
-	return !dma_need_unmap(dma_dev);
-}
-
-static inline bool blk_rq_dma_unmap(struct request *req, struct device *dma_dev,
-		struct dma_iova_state *state, size_t mapped_len)
-{
-	return blk_dma_unmap(req, dma_dev, state, mapped_len,
-				req->cmd_flags & REQ_P2PDMA);
-}
-
 #endif /* BLK_MQ_DMA_H */
-- 
2.51.0

