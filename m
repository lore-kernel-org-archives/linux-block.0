Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF1549F131
	for <linux-block@vger.kernel.org>; Mon, 21 Sep 2026 13:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789997963; cv=none; b=XrkWOMtobxJ1hYctB/1ZysakudZLynASnruT9Zf1mwPfJ3+uJyyNSaVtcD4SwYNiskHtjurlW4knuFpfzgsXqofQIEqvzzJ7J98rUe05GahHKXsHY4kODERC76U59H1XABaB1jjx6W66aLLMkf8bld0SdX2z1IC7YVlWhHo4WjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789997963; c=relaxed/simple;
	bh=RpITgNHybG/246G0ps7WuEPofE3/AsGe6jzoxiwBDiw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=riC+KiG5+MrDIVBx6ebjsCt57fO/PWMxCi6xFcPLwhqTnZJGIoGPfErFhGQaT6dRuXGTUUS2ZkfMm++fBctcyigHiScXuTFex8nh9TcS35S44cLa0RUrqnOiKwoptVL2lkjACBPSiRiAaBSJ9ZxvRca+LCfcqMbe95eNnJJc4XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b3wRD9Wi; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b3wRD9Wi"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-485ac898fa4so2610571f8f.0
        for <linux-block@vger.kernel.org>; Mon, 21 Sep 2026 06:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789997958; x=1790602758; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=s6kgf6V3xUR//WctRXY84w9DzTYgF20+bN2plXCsnYg=;
        b=b3wRD9WirKCPL4Rg/i0tRlCv9DfDFw76Fkn8bSuoEOYwXlKwyp4M/HkSqQT4R+NFLs
         LP5xWfAhW6h5eN4akZzg1Yj2U39vyvsIakRq5dt3XJ5AG7i+UIYy/UH22FSY+TguyOic
         dFpyfnR8/PGOQXD3q3lMyCBwPOBvNDLBJsOXxQQ1YCtpQwp9hr/T5FIt0tVvUyz2CR9A
         dvEJBgcFIen7xsFGEhmSNaMXE6BWzbDveZESODj25mwBBnEWyKO4ba3ZRSQzIDKyBHzg
         yfmD5yaoTqAyNe8l8jWKfeyplSULONot57+sYXpaRugqtP2SE+NUZ7LNvctgr03PtfNz
         wKQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789997958; x=1790602758;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s6kgf6V3xUR//WctRXY84w9DzTYgF20+bN2plXCsnYg=;
        b=NOZEHO4ZXfp6JZMjaklNrxj54uCmgDMKnivkj5jymzZyX0njkx80SAh+c0zfWvRaFA
         jNTVetDgiRY+uBq9qhqC7dVUhrgpubFPp+DLiG/5QRtr10DroVf3CfKsuTxXhAW5euE4
         USmCo3+S0UvnKCq5Ycr7JQuAzn/BW06sdvZo+RwcwmPf4/ZmCyJYdQmANWvu++Bg0QZZ
         qP/v1mmr1273I2wbk+Dw9eNQ1x19OcWzNZWcIOXu9XJqr7hqviBDp/lwEfEMkD1pvACY
         UUkau3QY7tdKU3cd/GrhinAjic5EoB2x7kz9SkKD2hB+dJCeIQ7D92Xyrl6yXzuG0MK9
         Z4QQ==
X-Gm-Message-State: AFuF++mGCIT0a3eLhoJ7Th4fgLSY8aD0zfgEk787UbMYYVeFGlXVtcFB
	P1AjITO3hlO2SHxFBZrBPIN43uuyVR8EK5kUe09jXaYy5+9Q/JsKcurZB7+tcw==
X-Gm-Gg: AYBFou3ZJ7w6N6yA5UxItVcSu4+wI505ubQ/IK6g9vBaYpVGvPvQ2mKpL0sAreGbLVE
	waxKZwiQjf505sVwEKIrgwEKHH+EQgk2SiaVfEUkpxTEEmOjxz7IoH9Jaha1JQpEOzzE2fbydHH
	bZZvQIUuLNbkxWxxqAx5/q5ylsLB5dE0GpPhYh4XVYpgwDiwOn2UlmisUCpUNTt6qlZMP2PMJy3
	86sj5Gnl8x/fqfoZ17IP9LRRlb78z17qDsrlsmr6zBvuxhNT7cLkyGebd28o5WJ88VLd1WdvrhP
	k06+wO0W1L4NQZC+VA2GukH61v+gr3w4L20W7Hxq6SDyv5ne3JMm8UuPOHzqXNK44+ShqBQ9NMO
	B5hQgt38/sR86E0DwLzKKCpMkX96FQfC3fc/WIXVFO9+OVu6/GETOEUTLXZ5wxy9jNnjZyNKrwh
	Z0zPVhX65gRX5zfN+bK798aDYNCq4e60AcfRcwNmdOry7gJogEuzp4ueiCj+B6nQzUGU2OUxGj0
	OFK1Kxv2PTqtsYEZj3I+Uzeoop9wXxKNO9PEA22r+10S2zGUlns9dbVUJXzPqcZUkHxcRR/T02W
	Y46yj+kY7xcZXyNoxxabLjlcaoZQiw==
X-Received: by 2002:a05:600c:1989:b0:49e:8184:f617 with SMTP id 5b1f17b1804b1-49fc573610cmr163288645e9.22.1789997957649;
        Mon, 21 Sep 2026 06:39:17 -0700 (PDT)
Received: from 127.0.0.1localhost (82-132-213-26.dab.02.net. [82.132.213.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fc585920fsm617171605e9.4.2026.09.21.06.39.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 06:39:16 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: linux-block@vger.kernel.org
Cc: asml.silence@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jens Axboe <axboe@kernel.dk>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Tushar Gohad <tushar.gohad@intel.com>,
	William Power <william.power@intel.com>,
	Phil Cayton <phil.cayton@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Benjamin Marzinski <bmarzins@redhat.com>,
	dm-devel@lists.linux.dev
Subject: [PATCH v6 00/13] Add dmabuf read/write via io_uring
Date: Mon, 21 Sep 2026 14:38:44 +0100
Message-ID: <cover.1789997898.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The patch set allows to register a dmabuf to an io_uring instance for
a specified file and use it with io_uring read / write requests. The
infrastructure is not tied to io_uring and there could be more users
in the future. A similar idea was attempted some years ago by Keith [1],
from where I borrowed a number of changes. Later it was brough back up
to life by Tushar and Vishal.

It's an opt-in feature for files, and they need to implement a new
file operation to use it. Only NVMe block devices are supported in this
series. The user API is built on top of io_uring's "registered buffers",
where a dmabuf is registered in a special way, but after it can be used
as any other "registered buffer" with IORING_OP_{READ,WRITE}_FIXED
requests. It's created via a new file operation and the resulted map is
then passed through the I/O stack in a new iterator type. There is some
additional infrastructure to glue it together, count requests, manage
lifetime and implement invalidation.

Tushar, William, Phil did a lot of testing and experimentation on various
devices with previous versions of the patch set, and I've received lots
of help from Anuj, Kanchan and Nitesh with investigations, testing, and
patching. Earlier benchmarks by Anuj for IOMMU optimisations with udmabuf
showed:

STRICT: before = 570 KIOPS, after = 5.01 MIOPS
LAZY: before = 1.93 MIOPS, after = 5.01 MIOPS
PASSTHROUGH: before = 5.01 MIOPS, after = 5.01 MIOPS

# Patch set structure:
- Patches 1-2 introduce internal API and infrastructure mediating
  io_uring and target subsystem / devices
- Patches 3-5: block layer support + prep patches
- Patches 6-8 implement NVMe support
- Patches 9-13 add io_uring support and uapi.

There are some liburing tests that can serve as an example:
git: https://github.com/isilence/liburing.git rw-dmabuf-tests-v5
url: https://github.com/isilence/liburing/tree/rw-dmabuf-tests-v5

The patches are based on Jens' for-next. Also available as a branch:
git: https://github.com/isilence/linux.git rw-dmabuf-v6
url: https://github.com/isilence/linux/tree/rw-dmabuf-v6

[1] https://lore.kernel.org/io-uring/20220805162444.3985535-1-kbusch@fb.com/

v6: - remove fences and wait on invalidation synchronously
    - report all map requests are detached earlier, outside of wq
    - handle nvme removal
    - gate nvme_free_descriptors() on iod->nr_descriptors 
    - fix error handling in nvme_rq_setup_dmabuf_map() 
    - fix iov_iter_alignment()
    - relax the 1G io_uring registered dma-buf limit
    - fix type overflow issue in bio split
    - allocate struct dma_buf_io_ctx inside the dma-buf-io code
    - harden block checks against dma-buf + buffered io

v5: - Reject dma-buf with buffered IO for raw bdev
    - Add lim->max_segments bio splitting
    - Add bio_iov_iter_set() helper
    - Fix io_uring uapi validation
    - Other minor changes
    NVMe:
    - Rename nvme_pci_sgl_set_data() to nvme_pci_dma_iter_set_sgl(), split 
      into its own prep patch.
    - Convert segment walk loops to do-while.
    - Drop adjacent segment coalescing logic.
    - Drop first_dma/first_len from nvme_pci_dmabuf_sgl_nents()
    - Remove entries > NVME_MAX_SEGS bailout; moving to the block layer.
    - Factor SGL vs PRP decision making into a helper.

v4: - https://lore.kernel.org/all/cover.1785274111.git.asml.silence@gmail.com/
    - Add sgl support from Anuj
    - Move it under drivers/dma-buf/ and rename
    - Fix mis-sized allocations
    - Fix io_uring re-import mishandling
    - Drop map before io_uring "task work"
    - Move blk-mq callback to block_device_operations
    - Convert bio flag to REQ_OP*
    - Other small changes

v3: https://lore.kernel.org/io-uring/cover.1777475843.git.asml.silence@gmail.com/
    - Rework io_uring registration
    - Move token/map infrastructure code out of blk-mq
    - Simplify callbacks: remove a separate blk-mq table, which was
      mostly just forwarding calls (to nvme).
    - Don't skip dma sync depending on request direction
    - Fix a couple of hangs
    - Rename s/dma/dmabuf/
    - Other small changes

v2: - Don't pass raw dma addresses, wrap it into a driver specific object
    - Split into two objects: token and map
    - Implement move_notify

Anuj Gupta (2):
  nvme-pci: rename nvme_pci_sgl_set_data to nvme_pci_dma_iter_set_sgl
  nvme-pci: add SGL support for the dmabuf path

Pavel Begunkov (11):
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

 block/bio.c                    |  15 +-
 block/blk-merge.c              |  45 +++
 block/fops.c                   |  24 +-
 drivers/dma-buf/Makefile       |   2 +-
 drivers/dma-buf/dma-buf-io.c   | 219 +++++++++++++++
 drivers/md/dm-io-rewind.c      |   6 +-
 drivers/nvme/host/core.c       |  12 +
 drivers/nvme/host/nvme.h       |   2 +
 drivers/nvme/host/pci.c        | 484 ++++++++++++++++++++++++++++++++-
 include/linux/bio.h            |  21 +-
 include/linux/blk-mq.h         |   7 +
 include/linux/blk_types.h      |  14 +-
 include/linux/blkdev.h         |   2 +
 include/linux/bvec.h           |   3 +-
 include/linux/dma-buf-io.h     | 113 ++++++++
 include/linux/fs.h             |   2 +
 include/linux/io_uring_types.h |   5 +
 include/linux/uio.h            |  11 +
 include/uapi/linux/io_uring.h  |  31 ++-
 io_uring/io_uring.c            |   3 +-
 io_uring/rsrc.c                | 274 ++++++++++++++++---
 io_uring/rsrc.h                |  45 ++-
 io_uring/rw.c                  |   6 +-
 lib/iov_iter.c                 |  29 +-
 24 files changed, 1295 insertions(+), 80 deletions(-)
 create mode 100644 drivers/dma-buf/dma-buf-io.c
 create mode 100644 include/linux/dma-buf-io.h

-- 
2.54.0

