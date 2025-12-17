Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B7C33A9EA;
	Wed, 17 Dec 2025 09:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765964496; cv=none; b=Q3i9bsDU8d4GrFy2s1IqSgCNBeSMfTyY8aZPdpreooJMTr9i3UcnMKbV0ZaN9ReoXEG2s6ajgclIYQZdfNX+hykE4/H1UKSMB0RtNpzi5nB2kzIpWzljzLZVWy9squJ7q9MFycxPqEZbaYDWvC3PBVBCYZ7PrNOe/6lb5JcnHVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765964496; c=relaxed/simple;
	bh=M+QyWNDQCYDgysdq/2Xe+talz7B50t/KFj/EX0L7Nhc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JI1ZT3JnINqLbFSUAnwjBNARVI/ynMaYzA6ijPasx+tIbp6n/fFwhv0fx2FVey5jsjXfVHYJJ2sivEI8o48+S9yvf5T0VfTYTw/D46lAvQUBpOKe58SLarCxuk+x2hJhffoj8Zdc2/QMK1QgayX39CvteSv9q1odY+6IADT+ExI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N60MN1O3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N60MN1O3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F098FC19421;
	Wed, 17 Dec 2025 09:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765964495;
	bh=M+QyWNDQCYDgysdq/2Xe+talz7B50t/KFj/EX0L7Nhc=;
	h=From:To:Cc:Subject:Date:From;
	b=N60MN1O3LP9MiL8GqhOOwgZbdaRovZ9/LTt/6jc1gVS4WRJ6n9/jP0Zugme6EpBhY
	 kFebNSVGojNIxXIgUK0EFzthiKRQg8/rSz6rGqZHZfvs+NctaNa+O7Uw3E3cwZT+ov
	 eWs5lAdhe4NNghoLl8Az5yB/yFXgxcZJom41OidjHPy2gDRKZvWCq124zG3i4DuWv1
	 +0PZkGs2FTGYocq2JxNi1U0z/EiIsDAyM8f2YBQq0kidiK+gARcsz0CwYq/M3xc84I
	 TLUMhKjIOVcbVsISHssayHhmQBktiyKraWs+6n/4eNB5F7sSXt9FJJREavKT4/Zw2T
	 sq9SAmMQG6cLQ==
From: Leon Romanovsky <leon@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH v3 0/2] block: Generalize physical entry definition
Date: Wed, 17 Dec 2025 11:41:22 +0200
Message-ID: <20251217-nvme-phys-types-v3-0-f27fd1608f48@nvidia.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20251217-nvme-phys-types-5bf34e42b2df
X-Mailer: b4 0.15-dev-a6db3
Content-Transfer-Encoding: 8bit

Jens,

I would like to ask you to put these patches on some shared branch based
on v6.19-rcX tag, so I will be able to reuse this general type in VFIO
and DMABUF code.

--------------------------------------------------------------------------------
Changelog:
v3:
 * Rebased on top v6.19-rc1
 * Added note that memory size is not changed despite change in the
   variable type.
v2: https://lore.kernel.org/linux-nvme/20251117-nvme-phys-types-v2-0-c75a60a2c468@nvidia.com/
 * Added Chaitanya's Reviewed-by tags.
 * Removed explicit casting from size_t to unsigned int.
v1: https://patch.msgid.link/20251115-nvme-phys-types-v1-0-c0f2e5e9163d@kernel.org

--------------------------------------------------------------------------------
The block layer code is declared "struct phys_vec" entry which describes
contiguous chunk of physical memory. That definition is useful for all
possible users of DMA physical address-based API.

This series changes NVMe code to support larger chunks of memory by changing
length field from u32 to be size_t, which will be u64 on 64-bits platforms,
and promotes "struct phys_vec" to general place.

This change doesn't change memory footprint because on 32-bits systems,
size_t will be u32 as before and on 64bits system previous uint32_t
variable was padded to be uint64_t anyway.

Thanks

---
Leon Romanovsky (2):
      nvme-pci: Use size_t for length fields to handle larger sizes
      types: move phys_vec definition to common header

 block/blk-mq-dma.c      | 11 +++++------
 drivers/nvme/host/pci.c |  4 ++--
 include/linux/types.h   |  5 +++++
 3 files changed, 12 insertions(+), 8 deletions(-)
---
base-commit: 5674abb82e2b74205a6a5cd1ffd79a3ba48a469d
change-id: 20251030-nvme-phys-types-988893249454

Best regards,
--
Leon Romanovsky <leonro@nvidia.com>

---
Leon Romanovsky (2):
      nvme-pci: Use size_t for length fields to handle larger sizes
      types: move phys_vec definition to common header

 block/blk-mq-dma.c      | 11 +++++------
 drivers/nvme/host/pci.c |  4 ++--
 include/linux/types.h   |  5 +++++
 3 files changed, 12 insertions(+), 8 deletions(-)
---
base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
change-id: 20251217-nvme-phys-types-5bf34e42b2df

Best regards,
--  
Leon Romanovsky <leonro@nvidia.com>

