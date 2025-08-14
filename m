Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668E3301021;
	Thu, 14 Aug 2025 10:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755166489; cv=none; b=sr0Bshty54QxWBb6jNPrUzO/4aGnn/6FtmMB0a4zNErySRchh4zWEM+iTKVydrSJN1ePEVaGicYOuyy3XWRNHaziwTxY319I3MUl75skIOIss/aQ45UR0YxwaOJ4tQ0XaammUhLp5nPQaH8Xz7yL4YUNrswcOQH24mi3NPeWW6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755166489; c=relaxed/simple;
	bh=stLVV7BdINySQbyeqCDmRbXyWeQEecbuIkQ/rhX45FU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=byLyxJ+k9FlSAJPjfqnu+Qtx2w1xFGn5MkniErspIwSpC1M62GzDr8hm6jIDwJNNgpFyK7jkVq0ebszRdvRSWFX3E9gh2Sx8nbUBaE/GYVGhm8WHge3W3O1hK0r1+5POO1sH0Pd9rDhdtmoCGxHNH9w8nwrtaFIEzeVJmqvoiMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yjr61GWr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yjr61GWr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BB3EC4CEED;
	Thu, 14 Aug 2025 10:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755166489;
	bh=stLVV7BdINySQbyeqCDmRbXyWeQEecbuIkQ/rhX45FU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Yjr61GWrMpZlZVsXr5trn6jduj7CwGSyfxXeA06jORzsuA8yWJLjGdU0E33cfjQh3
	 Hmx937j1Z95EXTMOUcTvwDAO3vhf7bMaKYV/TFQIyfc9mvSdYnQef9iZHXZNqE0oto
	 jcvZA8NK73HDjVgX/hAwi/xQMDOAaVmOkY66NF2PR1cDhVoVMkjKM0ZK4TRAmvUgWx
	 xqpsC9wxH1QmETO7S0kHdNpKw2xEF/nOFmPE3YzJHCVYhyuyfoPUg+dVNC7Gx475X0
	 rMcX3zG9znpLtrX/5YzuL4HwLR540SE+s9lhJRS4wAN2T/i4QuJ6U2hv8YLNA/kK+q
	 abKechpUNU6VA==
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
Subject: [PATCH v2 14/16] block-dma: migrate to dma_map_phys instead of map_page
Date: Thu, 14 Aug 2025 13:13:32 +0300
Message-ID: <a48cbbc074bf11c92b29b547e44f495a4504ae9f.1755153054.git.leon@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1755153054.git.leon@kernel.org>
References: <cover.1755153054.git.leon@kernel.org>
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

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 block/blk-mq-dma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq-dma.c b/block/blk-mq-dma.c
index ad283017caef..37e2142be4f7 100644
--- a/block/blk-mq-dma.c
+++ b/block/blk-mq-dma.c
@@ -87,8 +87,8 @@ static bool blk_dma_map_bus(struct blk_dma_iter *iter, struct phys_vec *vec)
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
2.50.1

