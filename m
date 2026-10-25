Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792935010;
	b=VhliFraXFzy/lNkYlIvwdCRDjKrZeMC04TdSI0sP76AlpgCkqOR0uXqesT21kf9Hmn9y
	 xsLtsgwacTul+r3VczeJ7Oo3EtxgD3jiqLKcHzMk6ieg6msEeZB4hIJYRvQSvVsoZq3iV
	 o6O838a0/3ftlwPQ5xYhoTdW94EQrkpgxy/1uVEUIBOEUTL0SERod8pboBmpGgh4agXua
	 iQrktW6ohJA+BxOlEzjQ7ZM/MHPxYmXkdyR3id89FtZGVeJPzLTEXbfZnYPljWSJEwtLT
	 Q1Vp3A8rgnF+pyFsBmjjLIdOmRUeSYck+JPB0Lc0RhyxJ/gSjs3SV8NIwTdJOe7cXjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792935010;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Content-Language:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding;
	bh=JbzvD86YHcBEyz7BEI1bUEiWMcAVsdqKwyAbbxU1r8E=;
	b=J8lIBhPN4drCHaswJH1DXYg1B3NIpT/jS0iK5Jh6I3ArlckHBgKg9X+qxW2Vmdw0DxY7
	 XKV9+/PJprQ2j03Gya6R0STawXqs+HCEsY58GPv8Iig5crsT6LfISFdeZCnR+Fn0PuH1+
	 bQoaeiK0Cn36HE5Nd08BTxAdIHlQ7LnnZbcM1fwn5hDsw3yPoxlYbGf9hzqt/vEqpnNd+
	 XQagPXqeS13ZmEg+Im97j7DB1mKNqfydTUKOFOwZ+QbHGHqXM5c9RPat2RQr6mhNR4kiE
	 zZgPnx2hJTu5CAfXwkSXTV0y30gn+nHmIUQ6J18DFFzv0nJpTb+V4Sh2ik5HZKH67kQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=kUuWctmL;
	arc=none smtp.remote-ip=74.125.82.48
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7B9606A31F
	for <linux-block@vger.kernel.org>; Sun, 25 Oct 2026 13:30:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD7B9606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=kUuWctmL
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-15dd124bbe7so1155694c88.1
        for <linux-block@vger.kernel.org>; Sun, 25 Oct 2026 06:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1792935009; x=1793539809; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=JbzvD86YHcBEyz7BEI1bUEiWMcAVsdqKwyAbbxU1r8E=;
        b=kUuWctmLak5Eh7juuql2f4dAsFLDLLH4cCrjNHb/IFr3xpwqaLHZ40XLa+tSoMF8+a
         ujBDLBJZOpFIa/f5COIxPWuJsmegR/wo9YGB/kuJNyryQrCJjyK4PYwa27nakIBkx5sN
         wFHtFnFrZ/6kSLQJPgyCf0j95LjKF5s7hBFfMgB/ZLyMf250FkfjfH8L5VhGdN/ZgFss
         dfIFkuix8sfs7pf3HboCahMn6nTFH8LnFI4s9namQBDW0jIkHd604PZQvdar1R1EVTJB
         x8vojzznw9Do5vilI9cKWzxNWSxQfHyJhHT5OqecoVNPYh4udvP38TL9gYblD2Pr3pf/
         mDIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792935009; x=1793539809;
        h=content-transfer-encoding:content-type:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JbzvD86YHcBEyz7BEI1bUEiWMcAVsdqKwyAbbxU1r8E=;
        b=ubebsYP7FU3XFca/5kYf+7nsJ8NhbBIBcYoxX75d2LEn98X1CFgIz4cpHRkPMtfirO
         5waeRLVW9HJVGHDX0fZbATj8n8qO3e4ZjTnPajr4bma1MQ3BKQl5v+CWkDa1KS8NKLkQ
         9cQyCZbk6RnC89/WN/bdABDRSLJdmrRf57v3zgcOEsjUZKuSpXMb/Z6Ag8N2F85JMd4t
         twEguhcJfXFraZbUGZkx9ucoRWLsme52tPPzhB2oCXHP9lufGvN3ifAhuc7qmfuxnNpq
         PZf6HiPYJaVDOB8kJUGWYJUcSP3vy9bdlHns2CnxX6tpp30TEAPz6ijYpZXZlJhLVg15
         5M6Q==
X-Forwarded-Encrypted: i=1; AKwUvBwxyfPZyzkVUdc8eUhf/CuL84AItLg5Zrx+rq+cvXnkfu+YRrdqZNOKhVJBITmo0BYQcmb30wKTmKLWDg==@vger.kernel.org
X-Gm-Message-State: AFq9FYJGQRQWMAbIuHg0qPNZAIY9kTzOkUXCyVfh04uCOL0HBhGuo1ly
	HDczf3u0LKRBfw3jazQ86l3v1yxh8S/XCl3/CP5VwS2cJbRSG/80oREFvXU3yAZDTCc=
X-Gm-Gg: AYBFou3UiGZK3bH3dDCcOs7yNlgDKUcxHTVCtkwEXGhMwaxrmufGvlVQFwZ8vxvqD5q
	yiX5ODnMh7dHL9O4BwP90MTFruQ6sdqoKsDXdIh2QYhUQ0IlF5Vl5BmdVcPukgJ+SvYJBNUq1c2
	pV3maRumcePRqcbAMBn2s/n77EuI0SJKockvmsjaxxPOtPqTuRr0NmOoWM6ETaKFrKHNeg1NQLo
	6Xd37Y2OZfIwTguLobB3QPFmX8Z7SidmlAqYkLGfpwEi6A1u72ofMoak+2r6WqMcYV6hOMmngAz
	AO+s8t7LpRnmxXHaXdlcQPzGLJZgs8JFxh/lv2x5cyfNor5yFZJc2eTUCIvw8nu8DVtGbwuCLkd
	LsKzOKQ1DccVHErOrG9aOgw641PZ3u7c8F7OqTueKJ3Cp+hGjFAd0H8FNs9B17fLeBgrv/1P6CX
	cf785iPfaoaFLoHEF4CZv5tZlGvIMWm9FryKoakauU/21Y6/j4m3d/AKFDSPUq/HrAHnK/uGpew
	I73cKBA6Yqhi0D0alSH7VV3qWea/09aUgrRP9FNqhJlVwW5VOl9kj6C5uB7tteNFInGaWcBC3ej
	sQhePauAF591m/XPJxDZmpmqMpMU9/rRsB0oW8n5
X-Received: by 2002:a05:701b:464b:b0:14f:505d:813 with SMTP id a92af1059eb24-1993f2020f1mr5713322c88.41.1792935008917;
        Sun, 25 Oct 2026 06:30:08 -0700 (PDT)
Received: from [192.168.1.106] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369ef6a71a4sm14500641eec.8.2026.10.25.06.30.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Oct 2026 06:30:08 -0700 (PDT)
Message-ID: <b97140d2-df87-4cdf-9f0b-d5ca404d50da@kernel.dk>
Date: Sun, 25 Oct 2026 07:30:07 -0600
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

