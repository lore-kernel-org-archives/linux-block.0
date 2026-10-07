Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798121E9B37
	for <linux-block@vger.kernel.org>; Wed,  7 Oct 2026 01:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791336737; cv=none; b=VT8Qte2OxPcJl/Vne3Jo4FOntZxOJ5hygylcoo8cmdFM6I8l3gROz+6Q09gr0c5X/05uWo1UFOwCv6FWWSips13MMIvZZZ6SdnB5MPI88m/XP8ed0QnSOsU7lAQ0LZ3dZHAdO6mHCt8vSEm/qrSTo2P3HmA4PbH/GLBhnxJdXL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791336737; c=relaxed/simple;
	bh=QiaXich+youzrooQKoppxmyMfy3XmwjU4ozTtqYqLIo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ffphWYQ7010JZG2n7Y2P2vRm30sWKhhOZTqt4/aXb+HTsN1ZBG85rOpkLC85e+YLj4cmFFpqtre4LHHlOttotW2Q84cJGSx/MyJeJqvwQ6kiuJJbXmDiiH5mK2QJoEYU8sJDP9R8+OQ6fQtMfseAxXozj8rz/TNt4j6IEhBjAcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=btfPN0Bq; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="btfPN0Bq"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a140e7405dso33693095e9.3
        for <linux-block@vger.kernel.org>; Tue, 06 Oct 2026 18:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791336733; x=1791941533; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hvzB42gUMiV/KR6lqPvi8GnnActkQyAM+I4+Sj3I6TM=;
        b=btfPN0BqGEmD7+CM3Z1lZhknO6acCyjQ+VgZeeOd4DvRnGUobYDjvgpNg3w0x5z7fC
         PeEC/BNaKpfHGg9K3gHJrHaLN5eivJ06o/hUqyzTxX3rvMGCpaacU+uaYkiHrM5L/0iQ
         WgfpeYy2N5ZUF/LeqjETRpkWeqq8iRCSC7+OCkcbBAweU93AIhhcQ+A0Dc5E8v1vjyQc
         7gJbEfCpSgKY8Xuj9dyaONqXPRH7wrYoob1BSdrPHaFEE8fbP8PSOGtgfrfu9rcudWkS
         +H59848huFe8LeXHoz4eoyG6BzAmjma+Oauz47CXbX1xp0QEbaXNUWLplL3+Cd9y73cv
         kMZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791336733; x=1791941533;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hvzB42gUMiV/KR6lqPvi8GnnActkQyAM+I4+Sj3I6TM=;
        b=umidANAD/EWrSzGtnxQkgJmk7LplF043uHJdmqA947aETwGQORzOFa4A0YfLLcX8AQ
         z4+Zp9xqd+KhvWPmYOvKvIXpSqWs9PglSDKsr0LJTxjn7UHEywZdTbu3GjuQVzhXvzAy
         bj1IQ5GFijwbvZagDuBRXtcB6wUkT1jBjrQaUI32QXM5pjdx/D7HPg8pthueFw5Xvv4X
         e6JAbiCQ7+cVtZFeybcyWkan37EyO/9pJA4ZTftER4BJI3C24zeNe+K1U9Q0sxGLzvxr
         x5TkFYLPav3eVqupoylgzuuEd077FhObM/ZZVVUw0g8C9WnNoU0wqK4OB7hRoUSpLwn+
         KFwA==
X-Gm-Message-State: AFuF++n0zzOdnbUsz4Gh1I30AbpSrw/sEWnfNyZZ0h5F+wiaEJgdKrqj
	Oh0oddWbxJw+psDiHiW69mlg1VUFU5AU4reebU9jTg4JPbJ3PLFGFUW9qGCxww==
X-Gm-Gg: AYBFou1zKsvujrqMzP3/59XAhu8D0LQx3nOxD4bDtvLhTW9imI5yLDveiqoCQRmrYbI
	eE1FRboqjLmSvDzThrhBbxE/H7IXvZXW7oyNxrG2rjUjP1wty5Pflpx4lOHzkxK95Zp55Gq90sM
	I0kR4+wo9fvs1ms+1/sYc7Z84u3bfhfDtyx0RKSKwakjphOvWu9qCfIkRrV1IpikTEQE85TyfgR
	/ys0Uj5C/J0VzxLggHr+wDnmyJpGLdXU3nG8cYsCGDb+fCr7UUS3s0e3/z9/a5zBqdi5XQhmhRD
	0+AiyGjd4bPcRgTv/q3OjSWbmZWbL5bot8SDAttyeSiMde+ifQzejgJ4DzxNxCAgLFs82rpAOcN
	4DJcpB/4n8EfKBBtrR9q7hZ9iMsATUBf+hTzAXx3POVYDWd8tIEAiXX+jZb3bCn57C5Uv2MVdF0
	DPB2hkEfU/7t6XMzuV6ft9IFh00MT1wJJM/S7VzGDz1ur/z0/+tW98UxQvPhC1dvf+YDVTatNVh
	oL5VXp6M4V/16jtaJucZgVW2ZL1xlH3cIj4Q4/NZA9nJmd9FCKjLTn7PihMSryZEZjjRYswv8lt
X-Received: by 2002:a05:600c:3f16:b0:4a0:23f:8b0d with SMTP id 5b1f17b1804b1-4a1800d3f2emr7099925e9.2.1791336732453;
        Tue, 06 Oct 2026 18:32:12 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a17f6538b7sm21183615e9.13.2026.10.06.18.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 18:32:11 -0700 (PDT)
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
Subject: [PATCH v8 00/13] Add dmabuf read/write via io_uring
Date: Wed,  7 Oct 2026 02:31:43 +0100
Message-ID: <cover.1791336002.git.asml.silence@gmail.com>
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
git: https://github.com/isilence/liburing.git rw-dmabuf-tests-v8
url: https://github.com/isilence/liburing/tree/rw-dmabuf-tests-v8

The patches are based on Jens' for-next. Also available as a branch:
git: https://github.com/isilence/linux.git rw-dmabuf-v8
url: https://github.com/isilence/linux/tree/rw-dmabuf-v8

[1] https://lore.kernel.org/io-uring/20220805162444.3985535-1-kbusch@fb.com/

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
  block: always adjust bi_offset on bio_advance_iter
  block: introduce dma map backed bio type
  block: add dma-buf support for raw bdev
  nvme-pci: implement dma-buf backed requests
  nvme seaparate file
  nvme sgl fixup
  io_uring/rsrc: introduce buf registration structure
  io_uring/rsrc: extend buffer update
  io_uring/rsrc: add uncloneable regbuf flag
  io_uring/rsrc: add regbuf import flags
  io_uring/rsrc: add dmabuf backed registered buffers

 block/bio.c                    |  15 +-
 block/blk-merge.c              |  50 +++++++
 block/fops.c                   |  24 +++-
 drivers/md/dm-io-rewind.c      |   6 +-
 drivers/nvme/host/Makefile     |   1 +
 drivers/nvme/host/core.c       |  12 ++
 drivers/nvme/host/nvme.h       |   2 +
 drivers/nvme/host/pci-dmabuf.c | 164 ++++++++++++++++++++++
 drivers/nvme/host/pci-dmabuf.h |  73 ++++++++++
 drivers/nvme/host/pci.c        | 249 ++++++++++++++++++++++++++++++++-
 include/linux/bio.h            |  21 +--
 include/linux/blk-mq.h         |   7 +
 include/linux/blk_types.h      |  14 +-
 include/linux/blkdev.h         |   2 +
 include/linux/bvec.h           |   3 +-
 include/linux/io_uring_types.h |   5 +
 include/uapi/linux/io_uring.h  |  31 +++-
 io_uring/Makefile              |   1 +
 io_uring/dma-buf.c             |  68 +++++++++
 io_uring/dma-buf.h             |  67 +++++++++
 io_uring/rsrc.c                | 172 +++++++++++++++++------
 io_uring/rsrc.h                |  32 ++++-
 io_uring/rw.c                  |  33 +++--
 23 files changed, 974 insertions(+), 78 deletions(-)
 create mode 100644 drivers/nvme/host/pci-dmabuf.c
 create mode 100644 drivers/nvme/host/pci-dmabuf.h
 create mode 100644 io_uring/dma-buf.c
 create mode 100644 io_uring/dma-buf.h

-- 
2.54.0

