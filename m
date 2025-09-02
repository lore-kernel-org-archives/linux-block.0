Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A367A31158C;
	Tue,  2 Sep 2025 14:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756824602; cv=none; b=puCl+kMgbzuaLkCGsYU1GGw3jeSREE9sPdHWNzYW7s/AT8YVNSCWqHIcrzB9ZWtdjBm9SNaz1ZYsbYMNnwKKVkpE9n8k5ecGf6vrONTIHiUw+r/BgSwPX4pdDLwUzajFuytlCHBzMr7uIexVubyoGczedRl4yWFaP7V6fvc3l30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756824602; c=relaxed/simple;
	bh=ZBDCCXKOUbAW2GsG2jVC6suB2pwDgJLZN0OvrJL85zc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JqdGNNXUm91iaV5OSwqJ9kINNIzJta9nro71/l0khW0C9U6DjXQmKK341evEyL7Xpd3loVdXgT+VUKhcwBisDbyrtrny6+fb7gl7ZjJjYU1+ODopIjAph+R8K4FYFY3lperPXmRKg3LODKoDdLsO5iqs8mbwrThIZTzqaXo6D98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lkdauzdp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lkdauzdp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5010C4CEF5;
	Tue,  2 Sep 2025 14:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756824602;
	bh=ZBDCCXKOUbAW2GsG2jVC6suB2pwDgJLZN0OvrJL85zc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lkdauzdpN/SIpGSSfK8kLRUi86AA3+TOqmqD24ZnSor88UIrlGHjQsAmCWO6e2anl
	 K1lRyv4MmrXkJu2ofOy32MFwkshextQSVPwvtX4cA3dJRuVSZhM7Jx9KBi5eSNonrI
	 z4cGmqRTm+5StjFtRxvIwsoIxLa3y6W46EmimmukeeLvHkuxCFF2Vrt9w4OBWq+PE8
	 obKDUurvbMwMhMZ1bRG/wLIUXAqpLU+zCaTKDld6pT5B4hrYSp0DUwIX2ynJrtw+wC
	 fv6qY0+duowp3cuGhIqsRETMXtVLq780uF5XI7RuDfeie+OQAT9g3cPsIbtn3Lr6Ky
	 j7H6Q0F41/mKg==
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
Subject: [PATCH v5 14/16] block-dma: migrate to dma_map_phys instead of map_page
Date: Tue,  2 Sep 2025 17:48:51 +0300
Message-ID: <b6356fbc547963548f2d4f035fb2e85f9d83ff99.1756822782.git.leon@kernel.org>
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

After introduction of dma_map_phys(), there is no need to convert
from physical address to struct page in order to map page. So let's
use it directly.

Reviewed-by: Keith Busch <kbusch@kernel.org>
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

