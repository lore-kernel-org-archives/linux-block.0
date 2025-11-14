Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7060F27EFEF;
	Fri, 14 Nov 2025 09:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763111249; cv=none; b=cK29QUIWPgLSd4a1yiBjlM7E/lvZq8qB9FoUWZ+4x0KO+bMuvT9pwbkCZGbZARQqLNJinFu315LwjX2eWutxmhv2AqkLeLIE3ME9M8VWiK2gOtPIMnp/ZZUryQu13F+gpbchvVWWCtnHTwTU4hWTHvF1MUvNIlpS8Oc02NLC+u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763111249; c=relaxed/simple;
	bh=y03enOMt6iDIjRulioZ2DnXep5g9PTvKHhme/ibbnVU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WFkA0ycLLSQIZVnQx6PkX+yQsnxAd9pkKQd7rgb79ZOWdOhP4bc14UykhyrcgX/dfCjAKofjmB6Xk45RlNBAEYJST/E7ostY9MpC5aXPWlkt24meVIcbAvDvoTeFnkaOu9kQOojp34/amidLHYLGnCefd54k0v88wJUQeeF5L0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HORw+lPA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HORw+lPA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D052C16AAE;
	Fri, 14 Nov 2025 09:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763111248;
	bh=y03enOMt6iDIjRulioZ2DnXep5g9PTvKHhme/ibbnVU=;
	h=From:To:Cc:Subject:Date:From;
	b=HORw+lPAABndqE3H9HqKikACuPnHahn4JvCgHSvPip9qIYSXXX2UKbJ+bIXyBwcEe
	 6omTzjePtjqw6C1EvhZ3m9moVH0EKgT5cqS8Lvw9/9qa81Yj/MctfTxztxyQBXE2u2
	 SELycBr9KeE9rDdbj3SsDLLcxSO1uBMwKrdtf5LphRkxwtxvQD/xluN8ZTbiwG+aSk
	 88+bG1KJEFOclotffguu5pFMk0lWZnrTkKojUDQvmc7yJq9a6JQ4/wY/wQpY8EGWcF
	 pJrIymXD8FQqIYFGX/sWjm0Zead+NATeZTk0muD7q5i37k4Q2cAggBmt31XtKA0ibR
	 LY5AexD75nZ2A==
From: Leon Romanovsky <leon@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH v5 0/2] block: Enable proper MMIO memory handling for P2P DMA
Date: Fri, 14 Nov 2025 11:07:02 +0200
Message-ID: <20251114-block-with-mmio-v5-0-69d00f73d766@nvidia.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20251016-block-with-mmio-02acf4285427
X-Mailer: b4 0.15-dev-a6db3
Content-Transfer-Encoding: 8bit

Changelog:
v5:
 * Rebased on top of 8e1bf774ab18 ("Merge branch 'elevator-switch-6.19' into for-6.19/block")
 * Initialized p2p map to PCI_P2PDMA_MAP_NONE.
v4: https://patch.msgid.link/20251112-block-with-mmio-v4-0-54aeb609d28d@nvidia.com
 * Changed double "if" to be "else if".
 * Added missed PCI_P2PDMA_MAP_NONE case.
v3: https://patch.msgid.link/20251027-block-with-mmio-v3-0-ac3370e1f7b7@nvidia.com
 * Encoded p2p map type in IOD flags instead of DMA attributes.
 * Removed REQ_P2PDMA flag from block layer.
 * Simplified map_phys conversion patch.
v2: https://lore.kernel.org/all/20251020-block-with-mmio-v2-0-147e9f93d8d4@nvidia.com/
 * Added Chirstoph's Reviewed-by tag for first patch.
 * Squashed patches
 * Stored DMA MMIO attribute in NVMe IOD flags variable instead of block layer.
v1: https://patch.msgid.link/20251017-block-with-mmio-v1-0-3f486904db5e@nvidia.com
 * Reordered patches.
 * Dropped patch which tried to unify unmap flow.
 * Set MMIO flag separately for data and integrity payloads.
v0: https://lore.kernel.org/all/cover.1760369219.git.leon@kernel.org/

----------------------------------------------------------------------

This patch series improves block layer and NVMe driver support for MMIO
memory regions, particularly for peer-to-peer (P2P) DMA transfers that
go through the host bridge.

The series addresses a critical gap where P2P transfers through the host
bridge (PCI_P2PDMA_MAP_THRU_HOST_BRIDGE) were not properly marked as
MMIO memory, leading to potential issues with:

- Inappropriate CPU cache synchronization operations on MMIO regions
- Incorrect DMA mapping/unmapping that doesn't respect MMIO semantics  
- Missing IOMMU configuration for MMIO memory handling

This work is extracted from the larger DMA physical API improvement
series [1] and focuses specifically on block layer and NVMe requirements
for MMIO memory support.

Thanks

[1] https://lore.kernel.org/all/cover.1757423202.git.leonro@nvidia.com/

---
Leon Romanovsky (2):
      nvme-pci: migrate to dma_map_phys instead of map_page
      block-dma: properly take MMIO path

 block/blk-mq-dma.c            | 20 ++++++----
 drivers/nvme/host/pci.c       | 90 +++++++++++++++++++++++++++++++++++--------
 include/linux/bio-integrity.h |  1 -
 include/linux/blk-integrity.h | 14 -------
 include/linux/blk-mq-dma.h    | 28 +++++++-------
 include/linux/blk_types.h     |  2 -
 6 files changed, 100 insertions(+), 55 deletions(-)
---
base-commit: 8e1bf774ab18157cb8041628f2661aa12e425914
change-id: 20251016-block-with-mmio-02acf4285427

Best regards,
--  
Leon Romanovsky <leonro@nvidia.com>

