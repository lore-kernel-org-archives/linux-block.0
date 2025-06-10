Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9029525DCFF
	for <linux-block@vger.kernel.org>; Tue, 10 Jun 2025 05:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749532071; cv=none; b=C+7vd9MOp0HE9mKPfUs10OyF42wvZjD6VvO9sQ4XUVPo0rPX5ejImCDuORJLqYP9Ig76trDVp6EmpPjFlSkSAdSoZJQCXyBxWBz2hfAqSvozsqjqkjTuj9gmXWank5icIiQAbWzYPmE4ThKvb4gGNeMv59PtfyBml7lzOQ8wjXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749532071; c=relaxed/simple;
	bh=6pWPInS+ozZ4QbSbjKQX196E57InFxgYCBaxu2/vOmM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PAjpAUEwjSYYT6CnJFysAhJ1yg1MsKV73Oro/tFu/bh0wcrkIvA84mgSwh981rxWkp253K933ixg49xiYA0eOBxGZEQiUiBJ+Za54OvZPljSn+1iF3k1fvSjvgpblrq6a/KJSLurDm9tOCKJDSeODJ34C3S8QkTjuXh8LhI1H+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PnqWUOm/; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PnqWUOm/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=HVgBpv5sL2SuwQmKlYHcmWpggTZtVThIILcHaEoCTcM=; b=PnqWUOm/DYpUIwf1bq/704Nx1J
	V+5MvKohFu2pS9y90iv7/hb3D6cpX4mUZsYNxdR5MeeDJBRZhfWk+DUSSkHuFqhPXpI5tnvEAuAUA
	5hO8jGqmAs7Mi808cyd1/kFMch9U32STZIzuL06UnSat8UqxdWCD9WWMmrZg8ZHBDPbHBFHF33ye9
	diW4TvR6HaXix3WNiQwX3M/qov1dJIgs6zi2fKiQz5RWHdtDRzmt8ioJAghWp52jUyfwxLw9wrUkE
	Ekq+2qJdhzB/sH/OcyWR7phUMO4+e4vFmwKagQ338779mQqHSS2tgjo+mOrXnlCKVQXhDCzFmk5kg
	Des6H8HQ==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOrDA-00000005nzz-2314;
	Tue, 10 Jun 2025 05:07:49 +0000
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
	linux-nvme@lists.infradead.org
Subject: [PATCH 9/9] nvme-pci: rework the build time assert for NVME_MAX_NR_DESCRIPTORS
Date: Tue, 10 Jun 2025 07:06:47 +0200
Message-ID: <20250610050713.2046316-10-hch@lst.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250610050713.2046316-1-hch@lst.de>
References: <20250610050713.2046316-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

The current use of an always_inline helper is a bit convoluted.
Instead use macros that represent the arithmerics used for building
up the PRP chain.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/pci.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 735f448d8db2..0f07599e0980 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -57,6 +57,21 @@
 #define NVME_MAX_META_SEGS \
 	((NVME_SMALL_POOL_SIZE / sizeof(struct nvme_sgl_desc)) - 1)
 
+/*
+ * The last entry is used to link to the next descriptor.
+ */
+#define PRPS_PER_PAGE \
+	(((NVME_CTRL_PAGE_SIZE / sizeof(__le64))) - 1)
+
+/*
+ * I/O could be non-aligned both at the beginning and end.
+ */
+#define MAX_PRP_RANGE \
+	(NVME_MAX_BYTES + 2 * (NVME_CTRL_PAGE_SIZE - 1))
+
+static_assert(MAX_PRP_RANGE / NVME_CTRL_PAGE_SIZE <=
+	(1 /* prp1 */ + NVME_MAX_NR_DESCRIPTORS * PRPS_PER_PAGE));
+
 static int use_threaded_interrupts;
 module_param(use_threaded_interrupts, int, 0444);
 
@@ -405,18 +420,6 @@ static bool nvme_dbbuf_update_and_check_event(u16 value, __le32 *dbbuf_db,
 	return true;
 }
 
-/*
- * Will slightly overestimate the number of pages needed.  This is OK
- * as it only leads to a small amount of wasted memory for the lifetime of
- * the I/O.
- */
-static __always_inline int nvme_pci_npages_prp(void)
-{
-	unsigned max_bytes = NVME_MAX_BYTES + NVME_CTRL_PAGE_SIZE;
-	unsigned nprps = DIV_ROUND_UP(max_bytes, NVME_CTRL_PAGE_SIZE);
-	return DIV_ROUND_UP(8 * nprps, NVME_CTRL_PAGE_SIZE - 8);
-}
-
 static struct nvme_descriptor_pools *
 nvme_setup_descriptor_pools(struct nvme_dev *dev, unsigned numa_node)
 {
@@ -3934,7 +3937,6 @@ static int __init nvme_init(void)
 	BUILD_BUG_ON(sizeof(struct nvme_create_sq) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_delete_queue) != 64);
 	BUILD_BUG_ON(IRQ_AFFINITY_MAX_SETS < 2);
-	BUILD_BUG_ON(nvme_pci_npages_prp() > NVME_MAX_NR_DESCRIPTORS);
 
 	return pci_register_driver(&nvme_driver);
 }
-- 
2.47.2

