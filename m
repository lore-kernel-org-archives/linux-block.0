Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85074F5E0B
	for <linux-block@vger.kernel.org>; Wed, 14 Oct 2026 11:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791975746; cv=none; b=c0PRymfxsV4jHATiIwu5x7ytxPkLkR3Yyv+NVwTeQ5oXPCGpYzV4vdzfds+7a/DqGbbYMaluUQ0smGjDCSLX2p3FCSqPrV7rCnuhRfZTqIsehPgYCOOHyFqVaKYE+yf4RhWSdN9jn3AgSXQ/nia+uULpeYlpYYFYzX4FRJUrpGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791975746; c=relaxed/simple;
	bh=NJY/Jrj3a3HrRrpOxKoYLO8i+hVozYz8WR8RrwPxzbM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pPqr67EKIHx8rgIj1GxG6cOxAU25ixnNIQd2zgjyu0stTBNamX3yOCIFeb7WDFskJuiaKGwiLlOZL2Qzw17yZmQqrviAKk4V3dE9MOFpiJunvxWiUhQ+762G8GUv6/HuzmbwEk2o3Mvzj1Wwd7gXIZic3qI4FlTgcWY+l6LjvcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=spX6b9qi; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="spX6b9qi"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a19cba5c14so33513305e9.3
        for <linux-block@vger.kernel.org>; Wed, 14 Oct 2026 04:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791975738; x=1792580538; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n9LdvIgr/9Qme3vhxjRpx9Sm5e7MKaYv7gruFZ4NeS0=;
        b=spX6b9qiw+GWw/CNIllnQ56LZll4OxpGvodwGGRMQitFPS5No2qroTsbUklsAEBwYt
         K6IY+R8QUT4Cj8whdgWdMg4znSoLXdsYhELamctJ/5Kki1upM3DrhMjFqm+ZFgNRud5Z
         yJDT2r2Mo+zc8Lyl/tTRlyn7+GUp8yh/vTey+r/8svF0fe2aSzRTjOADj82NiI8c8k7c
         ZMMkyIZXmlWql3n9G0de7bmsXSjC7ooYiUMpl9L5dp3BJB1DoNSgDumivj5ofZJLUyuh
         qIbBUOWWak/E9MxMGPytKXSA/7OMIoktCt6mEpOQsbOvvX8iSXu/pE0L31cA678IX3Ud
         qMsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791975738; x=1792580538;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=n9LdvIgr/9Qme3vhxjRpx9Sm5e7MKaYv7gruFZ4NeS0=;
        b=cvIzne0feYP6IB0QJAvh8W6Mjt36aHl75V5HdLVqTkqt/rqqZ33+eih+CXHFsAY14p
         jidKvv/4YIvkTCsKFb0WXVV2yK+GVDiL13RAA70eV7S0N4H8INbBhup89TvgAtUCLfFl
         UDNsZoO0cLfxjp+V/+XfG/eQL9OjV6fX+kk3saOVfAeP4n0+LxoDOlSR07MuCAm37Ryp
         U8wAtu7kWi5B6fQDGmP+K0Q/7gEWO853Cr9ZiYCPWAPjdN4FAhv3JYkApLt94voWxJ/J
         lGlO7TuB3BSe1HO7BHI3y/RXD2L/kBsYSoZ/ePifSuiss1brqOnELuyijkCujzj8RPUK
         YedA==
X-Gm-Message-State: AFq9FYIyJ9LrGB4vHkkUTb0Gwj20uxguvIeUqePJD/tK/lA49sx7HRWt
	DkWj0SuJFWY3uBZ6JNh3L968RyCTKGxuym2XNg9EzrO4EpuH77twaKu2jGldcQ==
X-Gm-Gg: AYBFou2ND3KuZkM03lh0V15eWoF6yIwINmVHGOIJK2gbJha34c6FV+0DzbjTBA9sai3
	1fkgYWKkXQZhqq0gLxau6+PMTeOxiL2uLBrXr5ztthv7XH2qtAZn3gb2EKhUZ/tSWAH6YUevLGJ
	9WRA23m6GwUN4Sv1Ubsz5l/MwB5q/wsLOLoD/1UzG/NICrGaYqZ+r4m+9p44au44bIAYjdR/SjN
	Qa6li8rYduLaXAsjOZouVrrpp+9dTwCa5HrGYD6EkOuDFgyz76rLfc1gOjr2RG2X+vZG1DL+NJF
	WOMXwx7LzJ6ImQzTfILMJDeQH/MM/sPH3G5oDT07yr2zAO0vK7CNrMsMqYIkQCAXlmk5LKZnd36
	HDr/3sXDNWZNX2i0qYsXTWmyxXJxmdbEW5CdA0+SX++vzLQ9His8rQP5dAB3YqTTYRXq4Dl4Iea
	J3fQOAkSWBvTJzAIFGJClqy/AVn3uf3Id7BtuQvhfMql/9ygzP6cB+90GyRGW44htoekmyXBkBZ
	eOcMaCbyX6OdHF4OhN3MVWLCb1XnB8ECW0OSmZvqiUk5bCNfSDz9lUHNjhWsrdM1LvbYruC6a5c
X-Received: by 2002:a05:600c:4688:b0:4a1:8d46:6228 with SMTP id 5b1f17b1804b1-4a18e4a9ba5mr321894465e9.14.1791975738524;
        Wed, 14 Oct 2026 04:02:18 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1b45eb78csm38078845e9.2.2026.10.14.04.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 04:02:17 -0700 (PDT)
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
	Matthew Brost <matthew.brost@intel.com>,
	Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Benjamin Marzinski <bmarzins@redhat.com>,
	dm-devel@lists.linux.dev
Subject: [PATCH v11 00/13] Add dmabuf read/write via io_uring
Date: Wed, 14 Oct 2026 12:01:58 +0100
Message-ID: <cover.1791975048.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
git: https://github.com/isilence/liburing.git rw-dmabuf-tests-v8
url: https://github.com/isilence/liburing/tree/rw-dmabuf-tests-v8

The patches are based on Jens' for-next. Also available as a branch:
git: https://github.com/isilence/linux.git rw-dmabuf-v11
url: https://github.com/isilence/linux/tree/rw-dmabuf-v11

[1] https://lore.kernel.org/io-uring/20220805162444.3985535-1-kbusch@fb.com/

v11: - Disallow creating I/O ctxs for a nvme dead device
     - Add dma-buf-io.* kerneldocs and Ack from Christian

v10: - Mark io_uring registered bufs uncloneable
     - Check io_uring size/offset on type truncation
     - Include dma-buf + PI fix from Anuj
     - Fix io_uring build failures w/o CONFIG_DMA_SHARED_BUFFER
     - Don't poke at bio_vec with dma-buf in blk_recalc_rq_segments()

v9: - resend

v8: - fix blkdev_buffered_write() returning 0
    - fix kvmalloc-kfree mismatch
    - fix invalidation hang
    - remove cpu dma sync as unnecessary for dev-to-dev transfers
    - move nvme dma-buf code into a new file
    - tighten dma-buf [re]export around io_uring issue
    - simplify dma-buf-io locking/sync as proposed by Matthew Brost

v7: - refcount *_io_ctx 
    - wait rcu grace period for ctx->map before freeing maps
    - increment map counters under dma resv lock
    - more comments about bio splitting
    - make ->unmap responsible for freeing maps to match ->map
    - replace dma_sync_single* with full table sync
    - detach dma-buf on nvme reset after cancel nvme_cancel_tagset

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
 block/blk-merge.c              |  52 +++++++
 block/blk-mq.c                 |   6 +
 block/fops.c                   |  26 +++-
 drivers/dma-buf/Makefile       |   2 +-
 drivers/dma-buf/dma-buf-io.c   | 229 ++++++++++++++++++++++++++++++
 drivers/md/dm-io-rewind.c      |   6 +-
 drivers/nvme/host/Makefile     |   1 +
 drivers/nvme/host/core.c       |  12 ++
 drivers/nvme/host/nvme.h       |   2 +
 drivers/nvme/host/pci-dmabuf.c | 169 ++++++++++++++++++++++
 drivers/nvme/host/pci-dmabuf.h |  75 ++++++++++
 drivers/nvme/host/pci.c        | 249 ++++++++++++++++++++++++++++++++-
 include/linux/bio.h            |  21 +--
 include/linux/blk-mq.h         |   7 +
 include/linux/blk_types.h      |  14 +-
 include/linux/blkdev.h         |   2 +
 include/linux/bvec.h           |   3 +-
 include/linux/dma-buf-io.h     | 125 +++++++++++++++++
 include/linux/fs.h             |   2 +
 include/linux/io_uring_types.h |   5 +
 include/linux/iov_iter.h       |   2 +
 include/linux/uio.h            |  11 ++
 include/uapi/linux/io_uring.h  |  31 +++-
 io_uring/Makefile              |   1 +
 io_uring/dma-buf.c             |  66 +++++++++
 io_uring/dma-buf.h             |  76 ++++++++++
 io_uring/rsrc.c                | 174 +++++++++++++++++------
 io_uring/rsrc.h                |  32 ++++-
 io_uring/rw.c                  |  33 +++--
 lib/iov_iter.c                 |  29 +++-
 31 files changed, 1393 insertions(+), 85 deletions(-)
 create mode 100644 drivers/dma-buf/dma-buf-io.c
 create mode 100644 drivers/nvme/host/pci-dmabuf.c
 create mode 100644 drivers/nvme/host/pci-dmabuf.h
 create mode 100644 include/linux/dma-buf-io.h
 create mode 100644 io_uring/dma-buf.c
 create mode 100644 io_uring/dma-buf.h

-- 
2.54.0

