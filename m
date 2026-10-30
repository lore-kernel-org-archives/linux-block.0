Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793324751;
	b=zCnrrn6RAKH3zV+0mL2eYEYzKjKIlnwuFQtyoHHBjke34ZGnfAkmyNeCfqx5jUm7KrZP
	 JLSgKmXar6nMk3T0vDthyMlOCR4SH9N9FtH3SQFJw81LbjvUWKTI9JdCMhRYYELCgdNlH
	 GPyQewPlYRpkgleHBUyZWw4BLhuOrxjwae5bVxOPfwZ1+YC+zSnsv3ydp9XiPGeQnZqeZ
	 3g33sXlOqrJMe8GiY9kSBtq2kUauEHfdzuCtlbbGn+7aPoWARR8/qiFsj1t/i97pDsz7l
	 +a0L/1sYoP/RXdwfRIVxs2Fvs6mVJ8ZfvCGPGKjW6oxzDF00BhiFLFRDULZju5wgIrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793324751;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=8e/IpuSYW9d0QekEXFx6bT2Oe0C5XCSMgDyLhp7uw80=;
	b=VCUXrVYdb9R5R3CPSlb62ju0Vz4lSIQP/bBAEu1dF7r+yWbyhSOQSB5c3A3rkerskrjF
	 r98gC7lIAobOknF+ie//vgQc+xhR9Mbsm+hr2sbyWvVGGEQcFuQ87nHXgLmROgD/4baDU
	 5xB7xlS+SY8QaiBYsRWXPGvG5jlfBVsUbu+aqIWBLEmW2mDDodYvH3D9fGblGPuFGSDjH
	 8CnyuMajcoviEGQe9NDcGzAya9xQIZEQtlgzB2qULwAri4Gb5tT16BOkKCwOpowvvfaaT
	 mOYxgqsRSr11pc+S3MkkNn4MxPtrdB7geOmXCeUS7cBimbMM7/x9eF1pcG6CVBuPXAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=grwei3CL;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED36606A31A
	for <linux-block@vger.kernel.org>; Fri, 30 Oct 2026 01:45:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BED36606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=grwei3CL
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-36a1947498bso451096eec.1
        for <linux-block@vger.kernel.org>; Thu, 29 Oct 2026 18:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793324750; x=1793929550; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8e/IpuSYW9d0QekEXFx6bT2Oe0C5XCSMgDyLhp7uw80=;
        b=grwei3CLBhH0n+t8FMxoVn41EIUIORxUG2gg4NQl76HodYhPBrH0i3O0LFwy+YwR9F
         Y051WwR9tNWc/ViI9NCrkq0e+VhlF9WP+auwSRu3BpwQupNVW7sc9g0CmfuXfbHUWl0f
         vycTRltBoygYfYV7wjOQlqh2PB0iPhRLF3CLsuJgzgurCZQdfSMjmSalpoABRFupELBC
         H/i3fQFZAG+AkxZydEHe6Q1P0nv4v2WjaOap6wF7wuLTNgxa3DSNWV5Ur4+ctIYebVvj
         X9DJckYCVvSAmy8MMCGC1w6M9njEsUD7ESz1VtNyY149Q4CtSAAY0jbb7rjX9zPYx8Rw
         hm1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793324750; x=1793929550;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8e/IpuSYW9d0QekEXFx6bT2Oe0C5XCSMgDyLhp7uw80=;
        b=Eo5xLfkaE26NqSSV+8FizDeS+7US4uOXUrzSWJLOSq42RcKGBsEDIPlOSXJxH1JLeI
         8aocPrV03qAW7+EBLhoV4ssVIH/FzMjDe6J/btY4AF2HWDW/daFrfdHCbPJ7smrtk9mv
         v0QL6LxZRD7ku+Es16fIBL6JtfF2/LXqU0DIhXDyEihJ67AAEM1+eQe9t8ADMx6gbcqB
         tngkhGUdMrny32SHf+jRL42NVAsbp6M9uBzPjUdzmqu+wrdTTKsBje6DpgpvAMyVghah
         loyvo+6A3W39insqnLQ2tEZ0jqei1ftA+3NoQQ037QOXXXYIwk/75Slxoi27CBNNiiyc
         HdgQ==
X-Forwarded-Encrypted: i=1; AKwUvBwU06MJqI/SDMNTKI/sUo3AMlJoWO22/NFbCZ9LB1s6a/KkR9ZBdrtwpvc6hMhvAnpGuixWS9UjJoG4Kg==@vger.kernel.org
X-Gm-Message-State: AFq9FYLGIkiX31LEB0IC3dd+HiRd0Qtt3AHNea5NhlXOCL/dK7xGuM5P
	zapWmxiA2pZmilkmQWspPsqHJD1VavyrXL/j9T805qwyySx+WwSW+MA=
X-Gm-Gg: AYBFou1U5TpmIY7wPLVQBXqSSEltMw890xGqW8uAUY0sYUmIpeyB0hgSNwuNKX5LaTl
	5207a30aqd9h6ur03Sz4auR8IbKAklCAgTP9XDWR4e5GMui/2vc+t7xZol2fwwjZinlcg0V4zhl
	/ASze/X9eJKu+76C7jKUoei/sj0W/g1Whv9KK9arIrDwv4PNHTgM5x/2axYKmL+3P3bD7jcMbx5
	BEP/ke/l7f1oPhDN6+iTkLgWPcIAloCGG2noRSKFTJS2rMfOyr9RUnBmU4RBEryJBK0IiRebw0d
	bGje2XMSrrjCKZLG6xtAg5nuPZ07nZfIsgU7JJUQZmaXnzNkYZwoWa4Pdd/fxdxBTOw/e/t21VN
	qr6ezy27O0Iw1b0PkfgVKsdMaaiSSAWxqWvtRgRn6Urv+ubQR1OwbeX8F1NeyNTnGlBoIvS2GVi
	mBb8d4Ygc+ELruzNE7RwRJ4es+oZ+3Q+hGGNXwqoxv9etJSQwM2N+nf1a7UFg51FFkXVWEPykpI
	NiNBg9Pj0zdCWg6yFhbIOkZ4ow8KSgnFrP4FVVYWAHU6DEYor+g5uJY28woRmYlBswtkpHJkyU4
	2lO4TD+CjTvhDoAdbrfXy2xWRDaVq3u8yoY5azJjzuBGwF/2pcSeCP5/VGNzc8p66YFSpl3aBlF
	ICdD9sv6LS9IcM5FbbBM7Xb6eLxk/eByS9ih1nA==
X-Received: by 2002:a05:693c:8806:10b0:369:f97f:72c1 with SMTP id 5a478bee46e88-36a4241bbd5mr1678012eec.36.1793324749832;
        Thu, 29 Oct 2026 18:45:49 -0700 (PDT)
Received: from anuj-MacBookPro.. ([2406:7400:63:75fd:f9a4:4062:7980:1324])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a428fa380sm2209020eec.12.2026.10.29.18.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 18:45:49 -0700 (PDT)
From: Anuj Gupta <anuj1072538@gmail.com>
To: axboe@kernel.dk,
	asml.silence@gmail.com,
	kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me,
	James.Bottomley@HansenPartnership.com,
	mkp@kernel.org,
	bernd@bsbernd.com,
	joannelkoong@gmail.com,
	miklos@szeredi.hu
Cc: io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	fuse-devel@lists.linux.dev,
	joshi.k@samsung.com,
	anuj20.g@samsung.com
Subject: [PATCH v3 0/5] dma-buf backed NVMe passthrough I/O
Date: Fri, 30 Oct 2026 07:15:35 +0530
Message-ID: <20261030014540.3065403-1-anuj1072538@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds support for dma-buf registered buffers in NVMe
uring_cmd passthrough.

Patches 1-2 add import flags to the fixed buffer import helpers, so
uring_cmd users have to opt in to dma-buf. Patch 3 adds the io_uring
side, patch 4 lets the block layer map dma-buf iterators for
passthrough, and patch 5 enables it for the NVMe namespace character
device.

Tested with this liburing test:
https://github.com/anuj7781/liburing/tree/rw-dmabuf-pt

Changes since v2:
- return -EOPNOTSUPP when the controller has no dma-buf support (Pavel)

v2: https://lore.kernel.org/linux-block/20261022144501.2478417-1-anuj1072538@gmail.com/

Changes since v1:
- split into io_uring, block and nvme patches (Christoph)
- pass import flags to io_import_reg_buf() and
  io_uring_cmd_import_fixed(), and make callers opt in to dma-buf
  (Christoph, Pavel)
- add io_uring_cmd_hw_done(), so nvme no longer handles the dma-buf
  map (Pavel)
- warn if task_work is queued with a dma-buf map attached (Pavel)
- make the -EREMOTEIO conversion explicit and comment it (Christoph)
- refuse dma-bufs larger than 4GiB on the character device

v1: https://lore.kernel.org/linux-nvme/20261016103453.1129150-1-anuj1072538@gmail.com/

Anuj Gupta (5):
  io_uring/rsrc: pass import flags to io_import_reg_buf()
  io_uring/uring_cmd: add import flags to io_uring_cmd_import_fixed()
  io_uring/uring_cmd: support dma-buf registered buffers
  block: map dma-buf iterators in blk_rq_map_user_iov()
  nvme: support dma-buf registered buffers for passthrough

 block/blk-map.c              | 15 ++++++++++++++-
 drivers/nvme/host/core.c     | 16 ++++++++++++++++
 drivers/nvme/host/ioctl.c    |  5 +++--
 drivers/scsi/scsi_bsg.c      |  2 +-
 fs/fuse/dev_uring.c          |  2 +-
 include/linux/io_uring/cmd.h | 14 ++++++++++++--
 io_uring/net.c               |  6 +++---
 io_uring/rsrc.c              |  6 +++---
 io_uring/rsrc.h              | 13 +++----------
 io_uring/rw.c                |  5 +++--
 io_uring/uring_cmd.c         | 31 +++++++++++++++++++++++++++++--
 11 files changed, 88 insertions(+), 27 deletions(-)


base-commit: 70866cfa169d5ee149364267289e71d50f9a7ae9
-- 
2.43.0

