Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9DC2BEFFB;
	Wed, 17 Dec 2025 09:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765964505; cv=none; b=jPPbYPHmegdJ2AgvzWH7bFcFBmsi2lu5B6XUL/i01MjICkmI+5b/BCHbyt/74m0qALauiK1RR7V02M47LOfgEARRh8oN/4Z6Apjda9K3KJN2cnrUBYvQoXt/o1BE2uTIFHlEb7wXegi7U29cYWGzkkZERllbuUmzNT/EcP2k3G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765964505; c=relaxed/simple;
	bh=b/Jh6xjZVFYW/BZ/jwrPDpIcfQ2LNGIe6zTiBVWKzZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DAb3sWQ8ysBJNqLOegGDiF690fTqcaHHNi0JwBDldbrbZONmxoqYCk+wP1iPKF1l0+E2Hjtsdx/lInd0MNLHTmiunJzUzkJJuCsZYUZ5coVYizlHGZbntkUEaMpKRD0CwflndCKfM4fbBnWD9Lyvuc8lA2nYYLAu5ClNq+HvsIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MtazOCT9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MtazOCT9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F01BDC4CEF5;
	Wed, 17 Dec 2025 09:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765964504;
	bh=b/Jh6xjZVFYW/BZ/jwrPDpIcfQ2LNGIe6zTiBVWKzZA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MtazOCT9Qnl2xJPI5agV4eVL6iRrG+kqSMaMtyvq0gYmgG8Zo/TfBGJUoi0vCi43Y
	 9YkvLyujwckc0uJxn5MVbUj/+8rUCRT5NTe+Swi1rRg1ZfdAeyi7RJ4oC/ehSKX6RK
	 dfXfUq9PfTxwb3AINQ0RYfaiY6+G2lxaI23k+Y4uO42sz5PfTPaTwF9adTr9keCdXb
	 p6nYRkc6apnSdWBNG9M+J9HmCNPaxpoFeRUlsseOd/jeTWBztvOdA5kJi2z1ZQkgr7
	 3RxypPG28DnhVwjQLHjaeaJh2qgXWtj2xHjJfIYHDtrs/hR3YIGjYSSjMpvClRcjfo
	 PPFgP1FS35Nwg==
From: Leon Romanovsky <leon@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH v3 2/2] types: move phys_vec definition to common header
Date: Wed, 17 Dec 2025 11:41:24 +0200
Message-ID: <20251217-nvme-phys-types-v3-2-f27fd1608f48@nvidia.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251217-nvme-phys-types-v3-0-f27fd1608f48@nvidia.com>
References: <20251217-nvme-phys-types-v3-0-f27fd1608f48@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-a6db3
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>

Move the struct phys_vec definition from block/blk-mq-dma.c to
include/linux/types.h to make it available for use across the kernel.

The phys_vec structure represents a physical address range with a
length, which is used by the new physical address-based DMA mapping
API. This structure is already used by the block layer and will be
needed for DMA phys API users.

Moving this definition to types.h provides a centralized location
for this common data structure and eliminates code duplication
across subsystems that need to work with physical address ranges.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 block/blk-mq-dma.c    | 5 -----
 include/linux/types.h | 5 +++++
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/block/blk-mq-dma.c b/block/blk-mq-dma.c
index a2bedc8f8666..752060d7261c 100644
--- a/block/blk-mq-dma.c
+++ b/block/blk-mq-dma.c
@@ -6,11 +6,6 @@
 #include <linux/blk-mq-dma.h>
 #include "blk.h"
 
-struct phys_vec {
-	phys_addr_t	paddr;
-	size_t		len;
-};
-
 static bool __blk_map_iter_next(struct blk_map_iter *iter)
 {
 	if (iter->iter.bi_size)
diff --git a/include/linux/types.h b/include/linux/types.h
index d4437e9c452c..d673747eda8a 100644
--- a/include/linux/types.h
+++ b/include/linux/types.h
@@ -171,6 +171,11 @@ typedef u64 phys_addr_t;
 typedef u32 phys_addr_t;
 #endif
 
+struct phys_vec {
+	phys_addr_t	paddr;
+	size_t		len;
+};
+
 typedef phys_addr_t resource_size_t;
 
 /*

-- 
2.51.1

