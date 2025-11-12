Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE54D2FB;
	Wed, 12 Nov 2025 19:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762976914; cv=none; b=Jb1EHd51OdG02L3oZbMoI/s7xKdW7uR8DQKxvLQIuO33b6k/3hcOLWTt5d5ch0JjhCfKiIdclhECxmvw+3kzseKtC+XUcu4Bo0TtiL061MipMn8tYFLyB7fLINrZxJvTLQE8r6W5KR7d/vz3NKLuBsAgd2vLVpk3D/eVMXeHGMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762976914; c=relaxed/simple;
	bh=FF8ym0Nr6x78Cnwv/qCRgIJVk2CWsFoj4rk60gQ5Spw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OCMIBB6p/5tWrV/IDXYF0jT6PManj8qeoqK2KMh4BFzwXdE+OsOQZ9kT7x96Ceck17yFRsgzpFiZQIo7QMG6ZsADsoDYfAX6jYq81aUwK2VAiUr9FTz3vytJBWbsjslKR+dpQJuQ7B99941Jn4SFrm5ROGE0Hve+vJTajgdGOH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HVaOUBND; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HVaOUBND"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B069DC2BC9E;
	Wed, 12 Nov 2025 19:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762976914;
	bh=FF8ym0Nr6x78Cnwv/qCRgIJVk2CWsFoj4rk60gQ5Spw=;
	h=From:To:Cc:Subject:Date:From;
	b=HVaOUBNDapgo26DjZXFKkHeI6CaPZWJSFqQxCQO14yzoLZWSqupNN9RZrHi2RRIIh
	 IWOvpR9i1mG5V1zwKhl7iqsHZIJeNQFVOQ1GamfToda9Wz3DNVniLdwq10mVvc04Vw
	 2lCD+TbNlGjxYVeWCRa2Qrg1x9tmf6RjXjj060jZ9nYFuFjpyNHgyD+PjAknstoKJ6
	 KizkOEXMj3J4YfHt8bWJniD2AsYACqYLBLFo9lY0XrnZziIn7NFf+5Mm6gIa0aWaoq
	 RJzjUU3pozxO6yIM1wdolCfTYjAEuyD0wjDZ+nxrFpKr3ul/01jMMA80D92Y8I5UvA
	 K7cWFZFF+d96A==
From: Leon Romanovsky <leon@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH v4 0/2] block: Enable proper MMIO memory handling for P2P DMA
Date: Wed, 12 Nov 2025 21:48:03 +0200
Message-ID: <20251112-block-with-mmio-v4-0-54aeb609d28d@nvidia.com>
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
v4:
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

 block/blk-mq-dma.c            | 19 +++++----
 drivers/nvme/host/pci.c       | 90 +++++++++++++++++++++++++++++++++++--------
 include/linux/bio-integrity.h |  1 -
 include/linux/blk-integrity.h | 14 -------
 include/linux/blk-mq-dma.h    | 28 +++++++-------
 include/linux/blk_types.h     |  2 -
 6 files changed, 99 insertions(+), 55 deletions(-)
---
base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
change-id: 20251016-block-with-mmio-02acf4285427

Best regards,
--  
Leon Romanovsky <leonro@nvidia.com>

