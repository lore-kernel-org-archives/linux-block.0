Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4CF930E85C;
	Mon, 13 Oct 2025 15:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760369665; cv=none; b=lytnXFioEG+kcVSg+hTjLrNv02ZyXzIn/0Zb8+vT4wX9Wbd1wQNXS16rrO0qWgq3p9kZDNYUAKttx3r0OHzQU31bPHCaU6LoFOg65SBVHvYzOVj6c9ZyGlD3cWDlazys3wxcT6Q31ismaL+F7X67Lpfd/NSDYuQ2wvk76vpwB04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760369665; c=relaxed/simple;
	bh=hzuVFe8nCL+iIBGDL2sXtfGJ2m3xwMmUvUxsg09OtX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cjTK+AIFgJPRkvru7k8PyOk3LjG3XPk9e8R8jldVrJVzrnG0LWwdMPjxPtYbr1UoEmczCW9rOa0N4LlC5IhYMh9PWW8VYL1BHvo98Y8tpUWHPYHmJ8n/+n46NCgCwy2olTikViHBdqsf3rPevak0UlEjNGDpHlYUqhLqFBwSEMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ibwLtD0L; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ibwLtD0L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10EFEC4CEE7;
	Mon, 13 Oct 2025 15:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760369664;
	bh=hzuVFe8nCL+iIBGDL2sXtfGJ2m3xwMmUvUxsg09OtX4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ibwLtD0LulBqDzZDpXozjmI/P7HtfW8A0lH49aPinhSgG3HSCoEEoZXb2hbxV2WLc
	 FH1cVDnlg+phv3I8c7Ghc+cHQ9PmdD8gkheuTWpQA1IH21QA+gEIC4fcm+fd8MgN8t
	 0GL9zSmux/bfE2MuX0+pDpD2Kx3kE07VwzSzAaSRTf2PcirYz/IJA4hsKcq4kvEPIs
	 otRWBmUPabNrJCqWSlCnpty6Y25PN1bxifAG1pIRWu3vwI9Dk7P+Y6oV4GLGjo2K8b
	 EdfvMk73E4gdf6ZKbWTinKiZD57GDIyc0LsMDrgyeqzzVTYJcTYKlhdB+Etd8RnOUB
	 7RmbzimrVtqAw==
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
Subject: [PATCH 1/4] blk-mq-dma: migrate to dma_map_phys instead of map_page
Date: Mon, 13 Oct 2025 18:34:09 +0300
Message-ID: <a40705f38a9f3c757f30228b9b848ce0a87cbcdd.1760369219.git.leon@kernel.org>
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

