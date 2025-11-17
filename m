Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA77B2E36F8;
	Mon, 17 Nov 2025 19:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763407375; cv=none; b=fh1SWVPuqqsO68VNC8pYUrIV3XDaqnDan+RF7XzDTYHnTW3RmbQjuIxX2W1z/NO1nB5f9TGm4pFLb3Zy5Q0ve82k4e4pQx+rbM0tVNm9O/cN1MuL0ORzv7Cb8WRKf1p7Pno2UnuSwI8uNADfrL9CX+QP8yQgXiz/QadXDDfNa8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763407375; c=relaxed/simple;
	bh=3ySbpAQyseH1RhiKvjgsi6fsV/pq2ZWK5we3mb8diHw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YTCz/CiDJgvhWrJbNU8J4fmBvUfmXesyXsIV/hitgg+jhpy85LSVMi9P7jNWxLBjWAX4xJhm8UJijlKd0R/I7i6FLYtqk75rdHz3BHrDyUsv7rMaY1OSI7wIoCFkJiXencobZ88N1D94gwxu7GctW4zsMHcLvgf39PsUBrUT2LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rVgaTdlh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rVgaTdlh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 637F1C2BCB2;
	Mon, 17 Nov 2025 19:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763407374;
	bh=3ySbpAQyseH1RhiKvjgsi6fsV/pq2ZWK5we3mb8diHw=;
	h=From:To:Cc:Subject:Date:From;
	b=rVgaTdlhtHnMZSq5T5rdweysNMZHC8x98jK9Qp5CaK+I14LJdDbv5aLczqEytYmux
	 criGijr65saOewT7Zf/6+zFyVFONsFBCKp2uvDJUe74YyGnpWfMKqD0Fhze2jG/0s0
	 RFHQhoS0vrlsKAH57stZ+Vl1HWqCQPr5vPFN4kk/bTdcknStRaNX+vhkoDrpNFtiTZ
	 AZ9t6zT7BMibCxhG28wCqaPc+fp1UtHtA4PIWeefHhQy/15NNbhEGZY04qSYpt9oqe
	 fqw1/InvELLjOYHjfxOk8RgR0VZfnh0KRJ8WPvdniEoGSuXEKKAq2+dVuFZ5Fvxwiw
	 ti8Rs7/QKnl6Q==
From: Leon Romanovsky <leon@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH v2 0/2] block: Generalize physical entry definition
Date: Mon, 17 Nov 2025 21:22:42 +0200
Message-ID: <20251117-nvme-phys-types-v2-0-c75a60a2c468@nvidia.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20251030-nvme-phys-types-988893249454
X-Mailer: b4 0.15-dev-a6db3
Content-Transfer-Encoding: 8bit

Changelog:
v2:
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

