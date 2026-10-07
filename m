Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21B5332637
	for <linux-block@vger.kernel.org>; Wed,  7 Oct 2026 01:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791337392; cv=none; b=UTl3n9VqfaBd8SulpqgUV7qvYVwinMh97kddAcUShvCXt88b2gqEdkTDJbL5qfnFv3G/Qms5q/bCgIX/YqwTxBOQKiUEDB4vyjQZgubK2JJ/grbdMN4TjZYdQwN7mg4VCrfyFOEEVbt5eItaic2MvwL5jze41Q3NzmF2Zv7/eSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791337392; c=relaxed/simple;
	bh=rOFroLHcZ9vJ/CtI4ZEaKRG0FzGWCcmE9/Hztq/BZ+s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R8DTcaPoh87DsFI8tliq7Nx97WG4ucEJdp9r12Fsx+rCuB1bdDDcn2w8yzEZ0wU6GwF9PXzBWiYEEI5wzdHsad5x31ekc4mYsNNVINW5gE9WItwZr1BC89S7bbtIRoWQlclFS7rlZYyynyknxm9z/VE4qM9g7wENIYM4mZHM/kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xp3UaNhO; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xp3UaNhO"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-49e73611928so8952125e9.1
        for <linux-block@vger.kernel.org>; Tue, 06 Oct 2026 18:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791337389; x=1791942189; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fc70of9qa63H69HPY6cKldSOdAbIZywdpsgVw4Pfjac=;
        b=Xp3UaNhOTStI1WfwK53zsneDHVAAad4P/MZIo3igWo454loYaJb49wapCAjVh1sxFS
         GnpICV77CocjQFKTRS2lRDgzddm6SUi5Hd8G+13wGdnyc90eXOTeTjT11ApfDXYrwC15
         2QLlL/M69jnpG+JtxORNPU8VVTAUwqMDTGpdbjzIMpqzvXeV2MJhpKqXsEkSximWfhqh
         TTx82FYENgy1BJPeGyrJyiZigxuqYBhjkPyMmSxaBZGyik/24wA5+xjJVzDbnsBAUv2J
         95725MXvsQNUCu/HC8I6EkISNrY/HAB9OZ20aTubglwL9irLGtCxQl7nn9OZzD7CV7Fw
         QY5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791337389; x=1791942189;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fc70of9qa63H69HPY6cKldSOdAbIZywdpsgVw4Pfjac=;
        b=AJzvAY5+jxZ5Z1xr0dkpIPKb8YoMi0lMcn+VmWscJJZBO52hchfNNU9dEtMsjPZlRO
         ZaadYNiBvKZQLL0lPkPAwaKxdGKmJ77oIKdHniCGjJK/hSvjfrjd6mPXCraE74wD3Ejd
         rK4OF8K57kRPswUh1w5obAVjgClpjt2y8VXgdYMvsejkrRAS6vpoCFaNWIPNM9CJrkNI
         9AT9WWQZ0dOUtkZp7OvtOUWxA+N8jBUehfeN6q0ImFbzKVAbHy7qfE6NecR5mtvLGU6b
         9LIRL4UJ1hN1EIXTrmNATeuG9w+YHZFyiBC3tB9OQdwuEnXt2gXkPJBCg2nuAIahSvwW
         v2kw==
X-Gm-Message-State: AFuF++krD/fvJ/SorkymYgzazIkhrtxh7b/tAyiFKpwGms52HmLxnjBZ
	zeNrL0L55OoLao5bdraeCB50aAzZ4nrCp43675L9WyiTHUJGedVUTE5YRE4IKw==
X-Gm-Gg: AYBFou0Iu7+5OIs344SQ0r0vx4RP8q8dV0qy61TZn4wY6ZVAFMbGrxaFvS3Bk8HzoIZ
	t/eLomjoOcXqHJdKGbM1dQdG20y0ZbAIAfpPAgbb3jLjgLlOSIRe9fuW7N3dW/KvwX7ezlroV9V
	UyapRJmcmTed4X4qQ5WsqG0A7raGaVEAOj56XuODmTH2aDgZAbkonSANF98eftl1i6ViO0Swb91
	wpqNyQ1YI4oGU7pH8hn/h/6hYiecTxrjFOO5ITOzT4l3AvaydadMniN2RNYUap+ejypMMuVtHB9
	aTMPKtzrR4bnTCnzk6+1f/JGXHoEI9e0S/dY7aRec2bFHOfNQYV5v9q36AhDC62Q8kUqBwbBOcj
	MlCqQgFF5zPMqOFQt8iC1oycwLE2rtvaTFfttHoPy3JKcYruifHNRQK+1p64qglmVDk4OeRXVQb
	GIZGm5IpC6AmPKcykxZT1vQbY+29xrj5FPcr0467TnE8/A9phZpnwvwNiJkDVdsfHtDeFTKpwnl
	AVw+TOOwsS1gMh1Cu9/kKKPZ1ir2sqfEbo6v/jmsQ1tGQ8Tq4H9afbvzzcvgYIdec0bcfYq0jwG
	vmDMdvC08B8=
X-Received: by 2002:a05:600c:820d:b0:4a1:7a1e:6910 with SMTP id 5b1f17b1804b1-4a1802ea26fmr8467945e9.4.1791337389107;
        Tue, 06 Oct 2026 18:43:09 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a17f653d7csm26423895e9.14.2026.10.06.18.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 18:43:08 -0700 (PDT)
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
Subject: [PATCH v9 00/13] Add dmabuf read/write via io_uring
Date: Wed,  7 Oct 2026 02:42:43 +0100
Message-ID: <cover.1791336930.git.asml.silence@gmail.com>
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
git: https://github.com/isilence/linux.git rw-dmabuf-v9
url: https://github.com/isilence/linux/tree/rw-dmabuf-v9

[1] https://lore.kernel.org/io-uring/20220805162444.3985535-1-kbusch@fb.com/

v9 - resend

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
 block/blk-merge.c              |  50 +++++++
 block/fops.c                   |  24 +++-
 drivers/dma-buf/Makefile       |   2 +-
 drivers/dma-buf/dma-buf-io.c   | 183 ++++++++++++++++++++++++
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
 include/linux/dma-buf-io.h     | 105 ++++++++++++++
 include/linux/fs.h             |   2 +
 include/linux/io_uring_types.h |   5 +
 include/linux/iov_iter.h       |   2 +
 include/linux/uio.h            |  11 ++
 include/uapi/linux/io_uring.h  |  31 +++-
 io_uring/Makefile              |   1 +
 io_uring/dma-buf.c             |  68 +++++++++
 io_uring/dma-buf.h             |  67 +++++++++
 io_uring/rsrc.c                | 172 +++++++++++++++++------
 io_uring/rsrc.h                |  32 ++++-
 io_uring/rw.c                  |  33 +++--
 lib/iov_iter.c                 |  29 +++-
 30 files changed, 1301 insertions(+), 85 deletions(-)
 create mode 100644 drivers/dma-buf/dma-buf-io.c
 create mode 100644 drivers/nvme/host/pci-dmabuf.c
 create mode 100644 drivers/nvme/host/pci-dmabuf.h
 create mode 100644 include/linux/dma-buf-io.h
 create mode 100644 io_uring/dma-buf.c
 create mode 100644 io_uring/dma-buf.h

-- 
2.54.0

