Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C7D27B4EB;
	Mon, 17 Nov 2025 19:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763407379; cv=none; b=cQRz4jKvqyLREAWahy3FXHPjBI0/fVoPXfmRiabRZXtu0r7S/aA9sJG4/xpydPjdn5ZGuQ1MOh6Al5i5entwYef4SxRErPBFefNb/6jS5g+86I/XxN2A9VPbgk6xGvIRVr87Owb9fMUMUPZG1TVTyLipfd+IYIktTQvmwWm19NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763407379; c=relaxed/simple;
	bh=EEyesgsiG54ob2krMXcOxgW1MQE8gG2p/1YYRAn3wos=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hf2MJazrgW2xVyX5qx0Rb7oJcA7mWI/NWw1c8LmIkHNHMhHmklXA1Td+OwtZ6KcHgvieiIl1SHRAvriyILjXF9EKgW5rVh5vGLoQ3GL5ipN9ODUUYS/16V/Lw5ow6ERzetp4mRJPDlreWe74xkxY0wmRvCMKeLk1UmS5wQ6sA0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RHaJYLMJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RHaJYLMJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AF9EC2BCB0;
	Mon, 17 Nov 2025 19:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763407379;
	bh=EEyesgsiG54ob2krMXcOxgW1MQE8gG2p/1YYRAn3wos=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RHaJYLMJuXsq90w4WM5RT+iGeIz56hG81clfHld9xfs6uIP9Gfo/ua133vNPaoc81
	 7o5t5aMJK9AFuI4urLjefRYGSXgZWJ/Aj5MjDF69M33fGLWX3jhJTcqhcQztlwtQfa
	 eSNSx/KFZRYZDOjUO3sDPHT+EMvzuk8HUsnRro5eZqTHeAQkxTPReCCU9JUBeCbXEn
	 4XX7u2knu/jo8KTUkDRN5mZujmUTauLVbb+e94OiOca51bbYqOb12nqWShSK2I6GnV
	 z0DgTcaL+kpNwZtbkHkZly8KLDcPaFrN6Duu0y3N0MlN+L2lVZsLWl4GWDIuqxRFId
	 LvNlhCdx6w8XQ==
From: Leon Romanovsky <leon@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH v2 2/2] types: move phys_vec definition to common header
Date: Mon, 17 Nov 2025 21:22:44 +0200
Message-ID: <20251117-nvme-phys-types-v2-2-c75a60a2c468@nvidia.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251117-nvme-phys-types-v2-0-c75a60a2c468@nvidia.com>
References: <20251117-nvme-phys-types-v2-0-c75a60a2c468@nvidia.com>
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
index e7d9b54c3eed..be2ccf224f9c 100644
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
index 6dfdb8e8e4c3..6cc2d7cba9b3 100644
--- a/include/linux/types.h
+++ b/include/linux/types.h
@@ -170,6 +170,11 @@ typedef u64 phys_addr_t;
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

