Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD5B1EF39E;
	Mon, 20 Oct 2025 17:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760979629; cv=none; b=JNa+UQNCkwP4Dv9HQVyMCdfQ5MORdstFwLDDCjMMp/M8h8XknORDT1/aF4Cp+Pw2AM997bGEXw78PsSsCV5fbR0Ke1th+cgl57Us7h5W+CpfFGjrue3HtVQ8JDdJWGrmjNP9LRwTTuFK080guiaDm2TUsxi1caZ9Ss6aKSrlkmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760979629; c=relaxed/simple;
	bh=aDeOnEEz1nETobkR0liGykS0l8wmYPsfShAs2ltzD7w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NBKD0bkIJ+Pg7QslehhLjO1u0IsDd6vdaH3cttl8sH11ucSV2YrcfvXwlHjzMsabRQd4+Ce0mUMOatBUiyVu6Pi2Pc7u1RNo9UbKwmVk1bpcwrDq0jXNSJpM9YRKdeNuzkPamjtTNTDEvustOikT+4+Rj17MvxoNW/XFJS4GNDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=naKhHO64; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="naKhHO64"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0393BC4CEF9;
	Mon, 20 Oct 2025 17:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760979628;
	bh=aDeOnEEz1nETobkR0liGykS0l8wmYPsfShAs2ltzD7w=;
	h=From:To:Cc:Subject:Date:From;
	b=naKhHO642wpE6pJC8jUqPZgMFbjxkebP1+tixYGLmX5nENZioJ/daM/nUGEc7DskT
	 eQjfLka959SMZlj/bj2szpSo9I2JUoNKEOaEOylFI8c/AIYjF9se1BKzjx7tJmds3v
	 ZGAKSrifgiAX2Zeb97ZcBfnPOhj0cBhis9PUgyvmusF8HkxmzuCtqaXeA9lHfRTF2O
	 Qgh1tbyDSsX0DGggMWV5E5YI/UY+ZxffSoZNmiUZ1xTEvOFBFHEZzLNoo2vBdVMFjY
	 qM1WvYJWDE6innT8ar4vyx5cFqPQ79Oz7EON2h4oT6Abf88RhXVUcwqktWKcFjhy0m
	 t8wzAXfYQNadw==
From: Leon Romanovsky <leon@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH v2 0/2] block: Enable proper MMIO memory handling for P2P DMA
Date: Mon, 20 Oct 2025 20:00:19 +0300
Message-ID: <20251020-block-with-mmio-v2-0-147e9f93d8d4@nvidia.com>
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
v2:
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

 block/blk-mq-dma.c            |  8 ++++---
 drivers/nvme/host/pci.c       | 50 +++++++++++++++++++++++++++++++------------
 include/linux/blk-integrity.h |  7 +++---
 include/linux/blk-mq-dma.h    | 12 +++++++----
 4 files changed, 53 insertions(+), 24 deletions(-)
---
base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
change-id: 20251016-block-with-mmio-02acf4285427

Best regards,
--  
Leon Romanovsky <leonro@nvidia.com>

