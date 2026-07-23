Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF893A4F3B
	for <linux-block@vger.kernel.org>; Thu, 23 Jul 2026 20:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784839380; cv=none; b=Em3iut5dN8wjN3FNVSJ3s6/K9+eavNMHI88CBrjbQBIEr6w7TM+63NxCvGDGPA1a6TDm+EdTEHz3fV1ldwcqBntSWT07GMdsLR9VFBF/TcHAdYeJEDkNH2fGVvI42dWrA2FmD9kmMBMucRpM3i5AmxdGEPpOzKFMKEog/BfqkGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784839380; c=relaxed/simple;
	bh=duiRRHdzIykrisUAseIhJOxQn/X2Aiz678fZQ0WGdro=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=piRvoCBG6jQ9v3dppR3VyDSf5HE7SfHCP4ROQOeKEebMOjls3tHvI9ARWvziTdM0wXrYvvQ31aALujAgZG88C+8SXKJoMpp3QZnuY+iX77ydxN+8MXE0sjxbJhUIZY5e+XlG5GzRdrzKsW5D3bzAj8ne6Xza/tJ7+iiy7Pey9oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meshstor.io; spf=pass smtp.mailfrom=meshstor.io; dkim=pass (2048-bit key) header.d=meshstor.io header.i=@meshstor.io header.b=GRRp3Z9O; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meshstor.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meshstor.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meshstor.io header.i=@meshstor.io header.b="GRRp3Z9O"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-47c2b362ee2so947929f8f.1
        for <linux-block@vger.kernel.org>; Thu, 23 Jul 2026 13:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=meshstor.io; s=google; t=1784839373; x=1785444173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=E5idRe2CDp786J3ag0YcRdkJhpW3jRwxGiXDWMRNXt4=;
        b=GRRp3Z9OchYW9aYVO2Z5s4bG+ngjTlLw9V/1GOLi/ER7ZRSMR1kDntz2NBmZW6UdsX
         A423uxBjPyl5vs8fDoa3yGtnSmrTO2LPBDV3GYHtDwOzSowGDBbMl56bY+yLeuc3L4+a
         N83TaUE92jVEeDeHQE2vmzszgdY2pXLvM81SCH0KqhE5QdnLZmlMcxugU/96mFYgcuKE
         k3E5ZeBQltBrS0HVv0Q299axZhbfr21TF8stCmc7a1n2e2CtRK5dUDAP2+tidTk0iDgJ
         SQBkUEjHEwSuWPr/lrAcbCRy/8LSHn4Leya87/Ayt/4ZnVEECxuu/wkzsRy6FyF6kCbR
         D2nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784839373; x=1785444173;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=E5idRe2CDp786J3ag0YcRdkJhpW3jRwxGiXDWMRNXt4=;
        b=qD2vqKZYXT4TmKo9L1Hfq3N73CkvUu7bWPBIaAsM3jFlzfwam7Ske6WjjGW6xRl7jf
         KokW3AzFnU8rrXdVimczNw9iHQkppfU5a6W74hoUEsb8UpaQdlMCax4DBW1RMrV/jz1g
         y/t8YFV4dVTVdqP+V0CpAoWQo7bJWFVE9E+OygmC43MQPdzPW6WKdwqcn5PsvAPdlN8Y
         JiPjX7pEQzEybBKJFxaeo1OoRsXp1e42x7XqAvd+UNVeWklT3qMs1QmeDh00fETsZhbj
         7AyEwszchVT8VIsqAzDafoTnzn3eg5dq1FQoqt85hOzn01iKLh1gcYiomU8EQCfWP6P9
         uF4A==
X-Forwarded-Encrypted: i=1; AHgh+RoB8itg1Da2Schoy/7umM+K3VFeL4zyumKJpRG3kVA30l8tAFGC5lNur3cziWA+PTbKrijk6bp9pawbJQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1mUpa2Cq1eM40tPCGfBdgeSG9r0Fn7U2Ja89rBPhIYWH7iD0a
	jE7EAIiShSw69/E6DlsEPRVZzsBJmx7cQ6NHtS/QBaK5Q95idJdH83wPDLiMbsyZxg==
X-Gm-Gg: AR+sD10fxoE75L+k/F3GFXcVVJVItRSgWjr8ndgVaQmyJvD7l7yadTUHfvJXsYtf0RO
	I64bEaSs03J4ppT8d4o93KPdToLuIwVwRJhkNjFAXGKbsn7lGxdK5TOPKGfE+ZhpiS0woVlNqVi
	eMIhuFL8knb3ZTnr3w5PdLL3qWBYl3vHLGqjRGrxsWZ9NS5dAEXKUxjS60AIYn6Oy2pe159LV0p
	t8B87Y/sk9Az+f30df5qv1NhlMqg14YzqKLq+OWJ7MZlBByUJTLcxPaFczXIODyTS2of1m3OvIL
	f3RitiYTSnlxLBzX6/rGmh/pV0WabMVK5ub/haLasnHGGyzX/ICtcWzegLEABfGoHjOcpE9PT41
	am3PERq2cmHhPvJiYJxCkOV0ebn8M9C7bpircsj+36JAaSJV44sAUcKPaBe8l/ERBxlASCkG7fV
	4Ftp05Jccme9ji17DDnABdskiQplVPq1Zwwpe+B50R5nQ0os2CwFr+QpfhZggftvx2MMp6A4qr0
	7YQ1Q43ZVxY+P/EGe8AnezW2anDFAOCsoi2CAMoLA==
X-Received: by 2002:a05:6000:46d4:b0:47f:93b9:b76c with SMTP id ffacd0b85a97d-47f93b9b770mr1881409f8f.56.1784839373145;
        Thu, 23 Jul 2026 13:42:53 -0700 (PDT)
Received: from meshstor-pc ([185.87.42.56])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85c52fc0sm18268192f8f.23.2026.07.23.13.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 13:42:52 -0700 (PDT)
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
	linux-pci@vger.kernel.org
Subject: [PATCH v5 00/10] block,md,nvme: correct handling of unsupported P2PDMA transfers
Date: Thu, 23 Jul 2026 22:41:56 +0200
Message-ID: <20260723204206.76930-1-mykola@meshstor.io>
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
wrote the core patches; v5 is built on them.  Patches 1 and 5 are
his and keep his authorship.

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

Routing: patch 1 block, 2-8 md, 9-10 nvme; 7, 8 and 10 use the new
status.  Patch 1 alone stops the divergence and the dm-multipath
requeue loop; the nvme-rdma loop also needs 9-10; everything else
refines the fallout, so the series bisects safely.  The md patches
fix a v7.2-rc1 regression (02666132403a), except 3 (older bug,
stable) and 5 (refactor).

Tested with the QEMU raid1/raid10 error matrix and a ConnectX-4 Lx.
After patch 1, block-layer error injection accepts status=P2PDMA, so
the md completion paths can be exercised on any member with no P2P
hardware.  The patches were developed with AI assistance (see the
Assisted-by trailers); all code was human-reviewed and tested.

Against v7.2-rc4 (Logan's base).

Changes in v5:
 - patches 7, 8: From: is now Mykola (Logan's request)
   Logan keeps Signed-off-by on both, Co-developed-by on 8
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
 - read path: bi_status is evaluated before bio_put()

Link: https://lore.kernel.org/linux-raid/20260718162547.448892-1-mykola@meshstor.io/ [v1]
Link: https://lore.kernel.org/linux-raid/20260719105327.864949-1-mykola@meshstor.io/ [v2]
Link: https://lore.kernel.org/linux-raid/20260721174502.111503-1-mykola@meshstor.io/ [v3]
Link: https://lore.kernel.org/linux-raid/20260722185841.449934-1-mykola@meshstor.io/ [v4]
Link: https://lore.kernel.org/linux-raid/9f846c85-f427-433a-b87d-8e9e3a4406e7@deltatee.com/ [Logan's proposal]

Logan Gunthorpe (2):
  block: add BLK_STS_P2PDMA for unsupported peer-to-peer transfers
  md/raid1,raid10: factor out raid1_write_error() helper

Mykola Marzhan (8):
  md: ensure REQ_NOMERGE is set on P2PDMA bios
  md/raid1: serialize non-write-behind writes on CollisionCheck rdevs
  md/raid1: don't use write-behind for P2PDMA bios
  md/raid1,raid10: keep REQ_NOMERGE on narrow_write_error() retry clones
  md/raid1,raid10: skip futile retries on P2PDMA mapping failures
  md/raid1,raid10: set IO_BLOCKED in case of BLK_STS_P2PDMA
  nvme-rdma: use ib_dma_map_sgtable_attrs()
  nvme-rdma: return BLK_STS_P2PDMA for unsupported P2P transfers

 block/blk-core.c          |  3 +++
 block/blk-mq-dma.c        |  3 ++-
 drivers/md/md.c           | 10 +++++++--
 drivers/md/md.h           | 15 +++++++++++++
 drivers/md/raid1-10.c     | 16 +++++++++++++
 drivers/md/raid1.c        | 47 +++++++++++++++++++++++----------------
 drivers/md/raid10.c       | 27 +++++++++++-----------
 drivers/nvme/host/rdma.c  | 38 ++++++++++++++++++-------------
 include/linux/blk_types.h | 10 +++++++++
 9 files changed, 118 insertions(+), 51 deletions(-)


base-commit: 1590cf0329716306e948a8fc29f1d3ee87d3989f
-- 
2.52.0

