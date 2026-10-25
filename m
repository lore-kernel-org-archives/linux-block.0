Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792934999;
	b=GFvjeqiaeF3QxNl5ZDjB3FdUfZckvc3ciMtPlg/nf1GPYtp8zzgJM1y6Fq03U87eGQqX
	 HlAphvDaPurK29UKn1p9qFQEMq/Akicl2TuKx4Kl9K5VvGECnRZq70fL5kqHtxcslTQaV
	 Sc9TkfegRy9oZ0+L1IpR/An03gLcmoupezRVjsNPzjH/mkiNOEUtNXDRNPaCztnP2MpB+
	 vHHUnvEt44/xfRV/PtBpk8myZQvKf2wE6nb14dKj2wS48FzRxRlPeyNP2zPI+BAuUd0tb
	 ohgNDbXsHjym0IZtoQbjjTMe+beSYZ2GdLCC6+9E6FdMXyd/RF0ptp09kumcWjPTLAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792934999;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Content-Language:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding;
	bh=JbzvD86YHcBEyz7BEI1bUEiWMcAVsdqKwyAbbxU1r8E=;
	b=LZK7tOFyCmXe0GGFX0QtXkRh5GQmN6wTEt8gWOK34FdidAjrQh8WJM4kFWiwb1fDfHyG
	 SVsCgJ8YOJnx5yuSf75mDTShKn1cuimYe2N3zPeWIuwE0HnFTa6wtZhfOHAQfguaYATm7
	 hYiz9AUG50dGIgSsnnb3/zvWrbcJxhOc4J8WVoYOjaflrLHKZlkQ9gP6GOyaq6Lnj7yaE
	 rWeZ4Q3EFS6P43iEFhxUkXjuNo/bRdAHJVjucjLbcrwqa4yfA71IWawkjqZXtK5DFN1vL
	 nXsTWB5C4hyynvGenM1szCBCPRQR9sVyumx61uH6E6r1SS6JTmyaJK1+ydDtloqkN8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=rlhnYpuv;
	arc=none smtp.remote-ip=74.125.82.52
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D587606A31B
	for <linux-block@vger.kernel.org>; Sun, 25 Oct 2026 13:29:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D587606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=rlhnYpuv
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-156cbe59622so1424172c88.0
        for <linux-block@vger.kernel.org>; Sun, 25 Oct 2026 06:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1792934997; x=1793539797; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=JbzvD86YHcBEyz7BEI1bUEiWMcAVsdqKwyAbbxU1r8E=;
        b=rlhnYpuvzs00rwDdgVaRdVrBThjwb9QVmb5NEdUgITBKCTiXPX/4Q1WOtoatWdPtK3
         wJPG2jTviPbkP1IujspeawTyXUsAMmKR9IlaBaljyne09uoEavLRrbRQjJsb07AhElIb
         KwSz6LqHbiq05r6MeuzQGPlm2Fe2GBjcF1vWIwU6NI1bVyUHcR43R+NFcWwJDZ9XfHGc
         GDcssz5/0BeA0cvoXnB4MaqU+uShB6y/Keehn51Z3dX1Pfg4skNt+tL6lZ7zYcDvWLSX
         XRxmlE1Mft4M+/vl1+Ga8ExYmHEPBBefcxtU+xMlAxVTfpoj4jWgpn4tcRgj36/+aKM5
         i2Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792934997; x=1793539797;
        h=content-transfer-encoding:content-type:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JbzvD86YHcBEyz7BEI1bUEiWMcAVsdqKwyAbbxU1r8E=;
        b=khW7k3NRpDQ3WcDltTPX8UZjSQ2H4dlAle4b7013/2qId3n/0+9blgcXOSOU7Wo0TK
         0YWD4SCQy43y3pZNqa1T0h3YBq/3EkGBkAFFOu+Lve4BwPNX5EBa4o7coCQ5q9xQtd8W
         k9qa+lO+oApfso/uP0Urwnh8gEEWr/ZOAcX+5zg18/SJJFVfhSz9Me8AioDYfUws8h4l
         eVOCCzg6Q/zv8NmIvMv69j6an1eRGRRv6tBC/DqBPis4Vo1TDb9IlOiKsKunfRf10FKM
         vqo1+EviKkJrQbsF+TVkrBTkrveXYqixjC1Auz9ZmJ9MwrORDvAEUBCcUTSU/btmaIrV
         D36g==
X-Forwarded-Encrypted: i=1; AKwUvBycf2UXulomaZCy97aCnmLr473gdfu24HveJRwlAotvY541PMUEaRY2TSF/btvpBgr5HBwMqjjrG58DZA==@vger.kernel.org
X-Gm-Message-State: AFq9FYLidSV66SHDUmhOCGX2+nA9V6zxtMudTocGMMXoIziNViHAl6wZ
	lOwlyk01ilx3QzSSgB7YIRt49LgCDJbS+e1cuzxnd7rrLWEn8uhVSzft3PJ7oJtEyac=
X-Gm-Gg: AYBFou0k4ij6FZ4B4Jq3oKJQOvHd3q0CrDHNTkeRIA+VezuxYfMeqrhme+FaICVSWSR
	WHojRR3p/RAdM3qdXcyZA57nGK06gGnIyjo3pf3VBH00jaI5X1rzLCEcfTd38+y5dJSuvDOuX3N
	3WslJZZfqeEuVNWJrE9sq6+4ugmRuS3aIFst6CtHhKikZJNbDCihvDH/eYRNbOvQrUjtmRUl0qN
	gvIHIsUacIJY/7D8hPEUhrMQOE+QoSEk+gDFMNYww7d1m4qWSjOEqyHXqjIytPhbzuaMSdUAppn
	4lWOcVlAx7lv3ygJb5QrWU6Rmxx5nhYax947DEfqUpJXxQ0LjSK6HBO+hlLfOK2tKsBuhF2wnn+
	9/s5VH2oaLJo3rxrsZ5/SIYVNUhbFLCxl7jJKho2MyP4762KW0lXOHmuExuddNREIiZgBwgzsX0
	idyEGcKPdemaaqi0RVTauvSe6X41sZS90eW7lpdH/CKUtkUrG/hy9SRTWW2d+rv7ijARJDHtqVr
	6UClZ/myH5+aT/deXIKwbeTZDNN89MSdYGYwz1nwZT/AxOYtO+zNnHf2jVp4qxQw5DRMsNX+os3
	7CgCxGtoLXKOnt3P3zwIZwEpyTwDmosZ0OdJuRw=
X-Received: by 2002:a05:7022:3a85:b0:18d:9eec:e0be with SMTP id a92af1059eb24-199290fe430mr6943741c88.2.1792934996812;
        Sun, 25 Oct 2026 06:29:56 -0700 (PDT)
Received: from [192.168.1.106] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-19894d5a10csm16098231c88.1.2026.10.25.06.29.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Oct 2026 06:29:55 -0700 (PDT)
Message-ID: <d38042c3-75f6-41fd-8998-da38f9420354@kernel.dk>
Date: Sun, 25 Oct 2026 07:29:55 -0600
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: io-uring <io-uring@vger.kernel.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] io_uring dma-buf support for 7.4
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus,

This adds native dma-buf support to the I/O path, exposed through
io_uring. It's been in development for a while and should be ready
to go now. Since it depends on both the io_uring and block trees,
I've deferred sending it out until those were merged. This pull
request contains:

- dma-buf file I/O infrastructure: a dma_buf_io_ctx created through a
  new ->init_dma_buf_io_ctx file operation, and a dma_buf_io_map holding
  the device DMA mapping. The two are split so a mapping can be
  invalidated and re-established underneath a live context, with the map
  counting in-flight requests so it can be torn down safely.

- A new iov_iter type for dmabuf maps, and a dma map backed bio type for
  the block layer, with raw block device support on top.

- nvme-pci backend implementing dma-buf backed requests, including SGL
  support.

- io_uring dmabuf backed registered buffers, built on a reworked buffer
  registration structure with an extended update path, regbuf import
  flags, an uncloneable flag for buffer types that can't be cloned, and
  cloning support for registered dma-bufs.

Note that this conflicts with block/fops.c in your tree, as the dma-buf
rejection in the buffered write fallback landed next to the NOWAIT and
i_rwsem changes from the block pull. Fixup is trivial, it's just adding
the iov_iter_is_dmabuf_map() check in the changed
blkdev_buffered_write().

Please pull!


The following changes since commit e889b0e4cafddb3d68c3595dc01b7128fd35fbef:

  io_uring/io-wq: don't call try_to_wake_up() twice in io_wq_worker_wake() (2026-10-12 10:19:52 -0600)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git tags/for-7.4/io_uring-dmabuf-20261023

for you to fetch changes up to 45b716456dd99488a0cef58482120dc0474aa696:

  io_uring/dma-buf: don't fail fixed buffers without dma-buf support (2026-10-22 09:27:00 -0600)

----------------------------------------------------------------
for-7.4/io_uring-dmabuf-20261023

----------------------------------------------------------------
Anuj Gupta (3):
      nvme-pci: rename nvme_pci_sgl_set_data to nvme_pci_dma_iter_set_sgl
      nvme-pci: add SGL support for the dmabuf path
      io_uring/dma-buf: don't fail fixed buffers without dma-buf support

Keith Busch (2):
      block: reject dma-bufs larger than 4GiB
      nvme-pci: detach dma-bufs only on removal

Pavel Begunkov (15):
      dma-buf: introduce initial file I/O infrastructure
      iov_iter: add iterator type for dmabuf maps
      block: always adjust bi_offset on bio_advance_iter
      block: introduce dma map backed bio type
      block: add dma-buf support for raw bdev
      nvme-pci: implement dma-buf backed requests
      io_uring/rsrc: introduce buf registration structure
      io_uring/rsrc: extend buffer update
      io_uring/rsrc: add uncloneable regbuf flag
      io_uring/rsrc: add regbuf import flags
      io_uring/rsrc: add dmabuf backed registered buffers
      block: fix indention for dma-buf checks
      dma-buf-io: fix typos in kernel docs
      dma-buf-io: document dma_buf_io_init_map
      io_uring/dma-buf: allow cloning registered dma-bufs

 block/bio.c                    |  15 +-
 block/blk-merge.c              |  52 +++++++
 block/blk-mq.c                 |   6 +
 block/fops.c                   |  29 +++-
 drivers/dma-buf/Makefile       |   2 +-
 drivers/dma-buf/dma-buf-io.c   | 241 ++++++++++++++++++++++++++++++++
 drivers/md/dm-io-rewind.c      |   6 +-
 drivers/nvme/host/Makefile     |   1 +
 drivers/nvme/host/core.c       |  12 ++
 drivers/nvme/host/nvme.h       |   2 +
 drivers/nvme/host/pci-dmabuf.c | 169 ++++++++++++++++++++++
 drivers/nvme/host/pci-dmabuf.h |  75 ++++++++++
 drivers/nvme/host/pci.c        | 247 ++++++++++++++++++++++++++++++++-
 include/linux/bio.h            |  21 +--
 include/linux/blk-mq.h         |   7 +
 include/linux/blk_types.h      |  14 +-
 include/linux/blkdev.h         |   2 +
 include/linux/bvec.h           |   3 +-
 include/linux/dma-buf-io.h     | 126 +++++++++++++++++
 include/linux/fs.h             |   2 +
 include/linux/io_uring_types.h |   5 +
 include/linux/iov_iter.h       |   2 +
 include/linux/uio.h            |  11 ++
 include/uapi/linux/io_uring.h  |  31 ++++-
 io_uring/Makefile              |   1 +
 io_uring/dma-buf.c             |  71 ++++++++++
 io_uring/dma-buf.h             |  76 ++++++++++
 io_uring/rsrc.c                | 178 ++++++++++++++++++------
 io_uring/rsrc.h                |  31 ++++-
 io_uring/rw.c                  |  33 +++--
 lib/iov_iter.c                 |  29 +++-
 31 files changed, 1414 insertions(+), 86 deletions(-)
 create mode 100644 drivers/dma-buf/dma-buf-io.c
 create mode 100644 drivers/nvme/host/pci-dmabuf.c
 create mode 100644 drivers/nvme/host/pci-dmabuf.h
 create mode 100644 include/linux/dma-buf-io.h
 create mode 100644 io_uring/dma-buf.c
 create mode 100644 io_uring/dma-buf.h

-- 
Jens Axboe

