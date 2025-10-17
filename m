Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D86233468F;
	Fri, 17 Oct 2025 05:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760679131; cv=none; b=GcfS0kHC7pkwwX2XMRkC8tvFJBDnYcdk8wPp9ufQx+SzvFDg0To1JW3OSQa2DwGKaIW2xCi7hcJUPFlWHQuYAB/r32zanGe0WEIb42/HXuTsZ5n7VSMvlW3DbR5kwOXGtZ9dTqHFc8xIgW7Qc97Gb7Uih1Q8FlSe9jiKlR/D1jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760679131; c=relaxed/simple;
	bh=OV1AjrdPFJ65x1uyW5xexn0OsRfhPacIT0WgaVlO9TA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WcElsT9hWSj8MdeQTia7fA/lWgV5bfEPUbA2fmiAs4Jo2mqXuZTpIBLWOSa7AzZ12ejWHAxuy19E+8HerDuMJviEyds4CbhlteFUcUlsudV6o51wHK4ENXyqAwtTKfxjixxMZO/I9hOSuat+oYCg94m6ApIRcVinFjJAn6GlFWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mXMH7hn7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mXMH7hn7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F3A1C4CEE7;
	Fri, 17 Oct 2025 05:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760679130;
	bh=OV1AjrdPFJ65x1uyW5xexn0OsRfhPacIT0WgaVlO9TA=;
	h=From:To:Cc:Subject:Date:From;
	b=mXMH7hn7t9bF4evf7iPbPkR1R+H4mM9cDRvMZf4U+xZr/1SJVcwsnB7BrwnnQE9uL
	 7NQdrmdz/25BU73Fgi60Z71xVAkn7XSLtJhbcejTw2CW8PD+B/q8XcBy5IMElSlHN4
	 b+DU4RMiJBBNr1zG41bubClIzVg2njffCx6fxVWLd1UQmHxEub1P1vP1UTYZ3bKbXw
	 bKpoKdjr2Rp+osTr4mG+jfgVTOLEzndfahLFfrPPuBpevAG/7owhp6JitshobCOk5J
	 QA0MvxPkFET5wQBQ/yPHk57iNF7QlwM+FjjLcC0gpBH5NzqUE7WwWbTF64FwxEG76Y
	 F5CTEaAO6Jq3A==
From: Leon Romanovsky <leon@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH 0/3] block: Enable proper MMIO memory handling for P2P DMA
Date: Fri, 17 Oct 2025 08:31:57 +0300
Message-ID: <20251017-block-with-mmio-v1-0-3f486904db5e@nvidia.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20251016-block-with-mmio-02acf4285427
X-Mailer: b4 0.15-dev
Content-Transfer-Encoding: 8bit

Changelog:
v1:
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
Leon Romanovsky (3):
      blk-mq-dma: migrate to dma_map_phys instead of map_page
      nvme-pci: unmap MMIO pages with appropriate interface
      block-dma: properly take MMIO path

 block/blk-mq-dma.c            | 12 +++++++++---
 drivers/nvme/host/pci.c       | 18 +++++++++++++-----
 include/linux/bio-integrity.h |  1 +
 include/linux/blk-integrity.h |  3 ++-
 include/linux/blk-mq-dma.h    | 14 +++++++++++---
 include/linux/blk_types.h     |  2 ++
 6 files changed, 38 insertions(+), 12 deletions(-)
---
base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
change-id: 20251016-block-with-mmio-02acf4285427

Best regards,
--  
Leon Romanovsky <leonro@nvidia.com>

