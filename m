Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824DF29D27D;
	Sat, 15 Nov 2025 16:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763223788; cv=none; b=NXl6bYQQ4ocdo1tYY253rYKbXFEkEaW5gF1ADW5ECtLvj8dV4wOrQSF8yz8vATCmnOqV7r5vUM7f+GV99sjpL4S8tSqgiE9e/GbaE2WU6LJcWnMyO5ivFo57rpaJPxEqwFrk3Bt9imKctikXvq24l2aqe5YZjnhYJKFixSXFgLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763223788; c=relaxed/simple;
	bh=HDXPNdXppJb1pAbOT94cDsK4rTiYS3j0SclK6olru+w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m7PxeW4oXKckwrt57sPDRCzXJhAHO1VzutzeckqRcfxdKYMC6xRxDij0/V86v3Wd92VBbgoP1/notS5ufHiKiAPsQ1Qm+x8icqATa1hnZwZ0MRpQvz7QdkfJ/Rh+0czw9Lq6PzXAitE0OJ2NlZcVYm4JJ1Le2WrEaV2dinZW6ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K+Idzc3x; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K+Idzc3x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06AFCC2BC87;
	Sat, 15 Nov 2025 16:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763223784;
	bh=HDXPNdXppJb1pAbOT94cDsK4rTiYS3j0SclK6olru+w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K+Idzc3xOAQ4zjNNlGS128lm1BpGU5tU4lceLk1ExeffmXaAFkIoms2ig9/D5Iak/
	 MxK6bJ4tbCsH5rKN0NFUyxHqqVyKxYeNW5Jkqb/0k5NmG9WTlFKPqrwyPB5ksQrvYC
	 5fjWxRCzvVWPVCAZgHSPvzBGAqKLXK1ZvtBKnth20w8tb1oAbOkvuU+dHkE5n2hkDE
	 aoCGwzBGlG1VrQ7G/U6ixotTmPBx7S0WdalleEa9pe1IJOo6IJCmLyMbsBaStFhNB3
	 KbMPIgY75yCWq6OV0sP8UBKT7LlF17KA8p5jjGQixSFcBOLVyWAELChD9IPxEXEmpf
	 0Ma2rrb/+T/8Q==
From: Leon Romanovsky <leon@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH 2/2] types: move phys_vec definition to common header
Date: Sat, 15 Nov 2025 18:22:46 +0200
Message-ID: <20251115-nvme-phys-types-v1-2-c0f2e5e9163d@kernel.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251115-nvme-phys-types-v1-0-c0f2e5e9163d@kernel.org>
References: <20251115-nvme-phys-types-v1-0-c0f2e5e9163d@kernel.org>
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
---
 block/blk-mq-dma.c    | 5 -----
 include/linux/types.h | 5 +++++
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/block/blk-mq-dma.c b/block/blk-mq-dma.c
index cc3e2548cc30..ba7e77bbe7fa 100644
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

