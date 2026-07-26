Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB123242DF
	for <linux-block@vger.kernel.org>; Sun, 26 Jul 2026 11:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785065559; cv=none; b=FENLTLnj39j3GUymNgKo00HeFhEY3j717vp8qtW4yhcuLg88ffhvsQ1PbaHnQ+QdimTHQLPefMyxbxJBjgW+K2dGklYnDyIXeztOV0O2cLTdoOBr7j5e1kY5bedYuWIjckv/7lvss4dOX7WENf+i5wAAye2mfGjXnw5FX6oZjG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785065559; c=relaxed/simple;
	bh=YgfpfgE1On3sKHo6BvwUe+munCme3srUBUyovRvl9UY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dfS8yqnCrHX7R0pmB8Riu9kdPNdn/6P4vr4ewUJDpovcYqQmyZDghqG5pKGSsEInAbUncpa6WclTF5UMIJw6E6jUVnPl0+MnL3Kvfm9YYgKiZWDob+SnS1hitFOwUfxLgOaSpVlK+KT4ofJYS/r/BgdfN7A2Q5AWNj+EbAxINWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meshstor.io; spf=pass smtp.mailfrom=meshstor.io; dkim=pass (2048-bit key) header.d=meshstor.io header.i=@meshstor.io header.b=OSGX6LbX; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meshstor.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meshstor.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meshstor.io header.i=@meshstor.io header.b="OSGX6LbX"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-47db714766aso1442991f8f.0
        for <linux-block@vger.kernel.org>; Sun, 26 Jul 2026 04:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=meshstor.io; s=google; t=1785065555; x=1785670355; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1Z37TstzxvLPhvEDUnNTL3PywZ4xjkcbPX0WwT+YK50=;
        b=OSGX6LbX76Zqq2kb96PLZpasCB9IkQdkf/FxFirQzWlppmHzHIkVwIkMSsVhlV6dzp
         hrTvEif46cVHBUMJUlNw4bqMd6krHBUysk0fV0YAYkMNGSfr8sykr1Z50//XkyfrlKe5
         jYvEEFYP1PWvArF6+PtPDYki+BXnDE8LmdhKkIdsFQ4aqwRVK38atattfvMqzPb83zT5
         9SVUbFVu1pJ3JMDvjjuJZMHNvnMbTvPiwJ5y//1+Ye7wUn3g5FTJIdZhxwoYd9Ar9j2O
         PWx9/bwXI56c0JOWOo/4xQkDTz1yFdB24O493/lMabcWNKT3hJ0vsuBuxRAcLpWXML4o
         yatA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785065555; x=1785670355;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1Z37TstzxvLPhvEDUnNTL3PywZ4xjkcbPX0WwT+YK50=;
        b=QO/7jLcFYgT1/f5ACxHwgHyCO0Bb7lTIBqo6jgBbIslC2SB9jcT271NeZ/k4BFnb85
         fuJg53856o+7h1qozSMPNQPUHYws0854cUjuGwG20s4zYcE+4XJJL4sBro211vH1uPyO
         rHG+oHDtSB8E6pk6UXWGNzkhaZTu20DcjvletaeTW9+1ebOkkqAL/r8xZ16F56J6k0S/
         p9Ryg+t5j7Pf0NJtV/HliTPUrT5wf9Fmo7O6XXT5RGNvlWgSSDjMG++pU+4EvIUnkK+G
         qtX0gC/2+opDPfReZW8NjG/kNZ0sTUN/NhxORr54Zmlj5cwnQqZX+MAI98LIJYfY0OQs
         amrQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro+40wAQYztSHqZIoy2HjxqmTpN4Cow0M7yURWwKl+lY9OEEjRyKwO3+A1IE7KbHOeCUCFwW2Tw1y27sA==@vger.kernel.org
X-Gm-Message-State: AOJu0YydKDV7s64E9lQyEnt9fSveheK+DnhPVoO17gYQ8X6mRBV53Quc
	cjPfrCPE3pJ33IWy3RXWW/ADmX45JsFOlaFuFEZ33Yw6w9JeadJFzFJfP8wVmaGezg==
X-Gm-Gg: AR+sD12Rbm449OcdPEJC3cY2zLvzlKANq93P/dq2HCRiqLzzFHAsYd0FrgIROxw7t/a
	Ze1jzy9IIYDP2uaUIC8Z6R+IMf15W021GPxHmA5ypBO+JlIT13jyiOaSylSl+Kyisqd2wr9vecF
	DvpB1u8wdUKsYUDsOlgC4FQM6k+k0SR9v4OGZv+md0k3Pqeub/IU1/pYH4GHQ/cbqFGGLKgyM8s
	UdNb/txAwd9Tl3MHZFhplCCf/Y7YKTLqEVIAdZEGoJkQau5xmVsQmla/vPqIZx8huzvYPxtQ1NH
	//kOu7Di0TX2yaEEq7Z6JwaxxAP9nOyzwB5PUFF6roMo5jgG+Lb7qoPXCKazUB6x8eRUu+M2UCS
	/2GafQDqSGo2HfQjTNAVPKVk3lYhInE8cUAZWHI/5Fe0Gn6oKMUvu1h/1AxAIBe9RSmsAoL4O1M
	ijVTxJK7t4CI546hGSHhvAbD8IqHDv2G6MXBZwUDN+ab9V0eMGdigICzVIuBr5q5zaPdo2yBDCU
	exQdEQLt8cOSUiVBfsYuZj76UBr30L9YUlQvUw6uw==
X-Received: by 2002:a05:6000:490b:b0:47f:9158:5924 with SMTP id ffacd0b85a97d-47f9fc9c6c8mr6246245f8f.9.1785065554907;
        Sun, 26 Jul 2026 04:32:34 -0700 (PDT)
Received: from meshstor-pc ([185.87.42.56])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85bb57cfsm40533083f8f.11.2026.07.26.04.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 04:32:34 -0700 (PDT)
From: Mykola Marzhan <mykola@meshstor.io>
To: Jens Axboe <axboe@kernel.dk>,
	Song Liu <song@kernel.org>,
	Yu Kuai <yukuai@fygo.io>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org,
	linux-raid@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: Li Nan <magiclinan@didiglobal.com>,
	Xiao Ni <xiao@kernel.org>,
	Guoqing Jiang <guoqing.jiang@linux.dev>,
	Leon Romanovsky <leon@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kiran Kumar Modukuri <kmodukuri@nvidia.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Shivaji Kant <shivajikant@google.com>,
	Pranjal Shrivastava <praan@google.com>,
	Henrique Carvalho <henrique.carvalho@suse.com>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Thorsten Leemhuis <regressions@leemhuis.info>,
	Martin Wilck <mwilck@suse.com>
Subject: [PATCH v6 00/12] block,md,nvme: correct handling of unsupported P2PDMA transfers
Date: Sun, 26 Jul 2026 13:32:17 +0200
Message-ID: <20260726113229.2154269-1-mykola@meshstor.io>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

md treats an unsupported P2PDMA transfer to a member as success, and
nvme-rdma retries one forever.  Whether peer memory can be DMA-mapped
depends on the PCIe topology between the two devices, and since v6.17
the failure completes as BLK_STS_INVAL: retryable for multipath and
deliberately ignored by md for member failures, so mirrors silently
diverge.

v1-v3 restored BLK_STS_TARGET for these failures and tagged P2PDMA
bios in md.  Logan Gunthorpe proposed a dedicated BLK_STS_P2PDMA
instead, so no consumer needs to know whether an I/O was P2P, and
wrote the core patches; v4 onward is built on them.  Patches 1 and 5
are his and keep his authorship.

  1  block: add BLK_STS_P2PDMA (stable, v6.17)
  2  md: ensure REQ_NOMERGE is set on P2PDMA bios
  3  md/raid1: serialize non-write-behind writes on CollisionCheck
     rdevs (pre-existing bug patch 4 would widen; stable)
  4  md/raid1: no write-behind for P2PDMA bios
  5  md/raid1,raid10: factor out raid1_write_error() helper
  6  md/raid1,raid10: keep REQ_NOMERGE on narrow_write_error()
     retry clones
  7  md/raid1,raid10: skip futile retries on P2PDMA mapping
     failures
  8  md/raid1,raid10: set IO_BLOCKED in case of BLK_STS_P2PDMA
  9  nvme-rdma: use ib_dma_map_sgtable_attrs() (stable, v7.1;
     dependency of patch 10)
 10  nvme-rdma: return BLK_STS_P2PDMA (stable, v7.1; needs patches
     1 and 9)
 11  nvme-rdma: ratelimit the map-failure error message (cleanup)
 12  nvme-rdma: factor out the scatterlist DMA mapping helper
     (cleanup)

Routing: patch 1 block, 2-8 md, 9-12 nvme; 7, 8 and 10 use the new
status.  Patch 1 alone stops the divergence and the dm-multipath
requeue loop; the nvme-rdma loop also needs 9-10; everything else
refines the fallout, so the series bisects safely.  The md patches
fix a v7.2-rc1 regression (02666132403a), except 3 (older bug,
stable) and 5 (refactor).  11 and 12 are cleanup only and can be
deferred if you would rather not carry them at -rc.

Tested with the QEMU raid1/raid10 error matrix and a ConnectX-4 Lx.
After patch 1, block-layer error injection accepts status=P2PDMA, so
the md completion paths can be exercised on any member with no P2P
hardware.  The patches were developed with AI assistance (see the
Assisted-by trailers); all code was human-reviewed and tested.

Against v7.2-rc4 (Logan's base).

Changes in v6:
 - patches 7, 9, 10: picked up Logan's Reviewed-by; on 7 it replaces
   his now-stale Signed-off-by, as he asked
 - patch 10: the map-failure ratelimit conversion moves out to its
   own patch 11 (Logan); the stable note now names both prerequisites
 - new patch 12: the data and the metadata mapping share a helper
   (Logan's suggestion on patch 9).  Kept out of 9 so the
   stable-tagged fix stays minimal

Changes in v5:
 - patch 7: From: is now Mykola, at Logan's request; patch 8 follows
   for consistency.  Logan keeps Signed-off-by on both,
   Co-developed-by on 8
 - patch 8: raid10 declares bio up front and bi_status sits in a
   blk_status_t local in both files.
 - old patch 9 split: 9 is the mechanical sgtable conversion,
   10 the -EREMOTEIO -> BLK_STS_P2PDMA translation; both stable
   since 10 needs 9

Changes in v4:
 - new BLK_STS_P2PDMA (Logan) replaces restoring BLK_STS_TARGET; the
   R1BIO_P2PDMA/R10BIO_P2PDMA state bits are gone and the md changes
   shrink to completion-time status tests
 - blk_dma_map_iter_start() gets the explicit
   PCI_P2PDMA_MAP_NOT_SUPPORTED case (Logan's patch; v3 kept
   default: only)
 - write completions record the whole failed range as bad blocks
   instead of narrow_write_error()'s per-block retries; v3's coarse
   retry is gone -- the new status is deterministic, nothing to
   re-attempt

Link: https://lore.kernel.org/linux-raid/20260718162547.448892-1-mykola@meshstor.io/ [v1]
Link: https://lore.kernel.org/linux-raid/20260719105327.864949-1-mykola@meshstor.io/ [v2]
Link: https://lore.kernel.org/linux-raid/20260721174502.111503-1-mykola@meshstor.io/ [v3]
Link: https://lore.kernel.org/linux-raid/20260722185841.449934-1-mykola@meshstor.io/ [v4]
Link: https://lore.kernel.org/linux-raid/20260723204206.76930-1-mykola@meshstor.io/ [v5]
Link: https://lore.kernel.org/linux-raid/9f846c85-f427-433a-b87d-8e9e3a4406e7@deltatee.com/ [Logan's proposal]

Logan Gunthorpe (2):
  block: add BLK_STS_P2PDMA for unsupported peer-to-peer transfers
  md/raid1,raid10: factor out raid1_write_error() helper

Mykola Marzhan (10):
  md: ensure REQ_NOMERGE is set on P2PDMA bios
  md/raid1: serialize non-write-behind writes on CollisionCheck rdevs
  md/raid1: don't use write-behind for P2PDMA bios
  md/raid1,raid10: keep REQ_NOMERGE on narrow_write_error() retry clones
  md/raid1,raid10: skip futile retries on P2PDMA mapping failures
  md/raid1,raid10: set IO_BLOCKED in case of BLK_STS_P2PDMA
  nvme-rdma: use ib_dma_map_sgtable_attrs()
  nvme-rdma: return BLK_STS_P2PDMA for unsupported P2P transfers
  nvme-rdma: ratelimit the map-failure error message
  nvme-rdma: factor out the scatterlist DMA mapping helper

 block/blk-core.c          |  3 +++
 block/blk-mq-dma.c        |  3 ++-
 drivers/md/md.c           | 10 ++++++--
 drivers/md/md.h           | 15 +++++++++++
 drivers/md/raid1-10.c     | 16 ++++++++++++
 drivers/md/raid1.c        | 47 ++++++++++++++++++++--------------
 drivers/md/raid10.c       | 27 ++++++++++----------
 drivers/nvme/host/rdma.c  | 54 +++++++++++++++++++++++++++------------
 include/linux/blk_types.h | 10 ++++++++
 9 files changed, 134 insertions(+), 51 deletions(-)


base-commit: 1590cf0329716306e948a8fc29f1d3ee87d3989f
-- 
2.52.0

