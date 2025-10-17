Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E1C33468F;
	Fri, 17 Oct 2025 05:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760679139; cv=none; b=GG5buHUz1+M4G4QLs0a0y5bbBIgKcZE17Iaod+H1eii07autmGtv6GG2dW5Oq/aHfO0i+lWUgVlDgJgI4IHsc7gB+Z3uepfkDKKHFhYmpwcCH8pbQ1DyzqndE7Vf/j3swKGEOs8+KBadsNf7++9+xExPF9qskP+DbJgDz+lms+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760679139; c=relaxed/simple;
	bh=XPHX/eHvGPXhe7Cbw4X4FLHQozypPe//xTo6GQUz20c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gcr2mVwpu28sY0eofzL2MgFRmCOk7NDVKKIrXx9J+bdOJjqCsZQLwgzc4nl94zKoHdWglrqALSIv9VyEl9NhKZZl2LxtQDrt4Gj5XP8HIHZ7U8Qf8+I/+rQ4ii0XQIxpVQRIIx+b7FfdbXwge/L0qtOKviFSXVUwvfb+f8dwgXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gCjpkbiS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gCjpkbiS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF116C113D0;
	Fri, 17 Oct 2025 05:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760679138;
	bh=XPHX/eHvGPXhe7Cbw4X4FLHQozypPe//xTo6GQUz20c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gCjpkbiShSqT4gKgh1M2MEZbEZ2Vc/DNTaksMsNyGFGAB1tAEABTaYT2P/W8Ext8E
	 2sg1w2LFPRf+it0F42GOcnS+m75CoSGR2se6be0FYCunVEjzyOPeWtx5a0rDWv8Lg0
	 9HwGZIUIQL2t+K8t1djhHWLDh0fl74n7CXM1TzH8bqOZc25h92JFjisC7Gcel+0j2A
	 zU1+0C2NvTDryR7yu1HXF/cbyf7Em6FwtN95gzi4QgvGtquhvsSMFadA+g1bgQB3+f
	 8wrqPc4hdSmyuHfOey1noWZTc6v8WB6cpXFsWtiE2zaD4UoHr/5i6KCgG1YwOdICtT
	 VAvhY7B70Yl5Q==
From: Leon Romanovsky <leon@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH 1/3] blk-mq-dma: migrate to dma_map_phys instead of map_page
Date: Fri, 17 Oct 2025 08:31:58 +0300
Message-ID: <20251017-block-with-mmio-v1-1-3f486904db5e@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017-block-with-mmio-v1-0-3f486904db5e@nvidia.com>
References: <20251017-block-with-mmio-v1-0-3f486904db5e@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>

After introduction of dma_map_phys(), there is no need to convert
from physical address to struct page in order to map page. So let's
use it directly.

Reviewed-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 block/blk-mq-dma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq-dma.c b/block/blk-mq-dma.c
index 449950029872..4ba7b0323da4 100644
--- a/block/blk-mq-dma.c
+++ b/block/blk-mq-dma.c
@@ -93,8 +93,8 @@ static bool blk_dma_map_bus(struct blk_dma_iter *iter, struct phys_vec *vec)
 static bool blk_dma_map_direct(struct request *req, struct device *dma_dev,
 		struct blk_dma_iter *iter, struct phys_vec *vec)
 {
-	iter->addr = dma_map_page(dma_dev, phys_to_page(vec->paddr),
-			offset_in_page(vec->paddr), vec->len, rq_dma_dir(req));
+	iter->addr = dma_map_phys(dma_dev, vec->paddr, vec->len,
+			rq_dma_dir(req), 0);
 	if (dma_mapping_error(dma_dev, iter->addr)) {
 		iter->status = BLK_STS_RESOURCE;
 		return false;

-- 
2.51.0

