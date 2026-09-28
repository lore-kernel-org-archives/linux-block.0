Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071194C6F02
	for <linux-block@vger.kernel.org>; Mon, 28 Sep 2026 13:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790602368; cv=none; b=nGxmggdzfZCYb9gu1jdli8xcIAfjCLFtmWeoMaAJRqORqbdHBz1leqNbME/W/CvCFINE3kNB0+kF/3csDKOVkizdJ4wvk/16FaKCnuTpKxz5fVmisEHW9nSv2OsTai7xWoiieBehJ4CNqm5XknGpJNeDG2oxhE+hsffUWQN/p2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790602368; c=relaxed/simple;
	bh=7bSpI+UlKJeavw95eq5lp71WLeCCxaCV8VTeA6M6pM0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LoR3209BZiZukBccct7LjXJwmjyu94or4kWedZs1OkZiOPz/86ywbYqYIwe9m0rT7zRqsgkHEfh4wZo00Jk9zmNw+8pjNfMq4k4CZTSH81vh/W2RCP7Me+BcvnFGHxvIeeKxdWYGtcLQ1Au3PYHjqtx+l9xBxA+axX1NZByXfiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OWr6s1R5; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OWr6s1R5"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-4843378fb37so1826285f8f.3
        for <linux-block@vger.kernel.org>; Mon, 28 Sep 2026 06:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790602364; x=1791207164; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rDgWSkzXb9T2f2eSv4f8loR9LBdnnTqRZoSNaSt6PRU=;
        b=OWr6s1R5vg68Vk0EAPRxrqoeKPiQgRgpjQHWSBDZnziKm3MF9VauEOFqJG5wouh2kj
         ZE2K+QTpAGsj7Ry5mNbB3EfQfiZcRcLriFL4Vg3bNvd3/97g8GBjsyvjkp3PtYsDtF9a
         rUJeBiu9VdAWIqGuxXImicDQ6TFnuWSuvgAou3raX1YIJddYPA0WhPKZ+ElA02aMtc5C
         Yo6rbiFjcna54oFvqMKCSPzCVbQmxt4aeiFScSHLnjXQIGL/zWqJhBq7XlbgzDAQb/NK
         EbYpUm7o6/6ns657dhVcthvkK8hnD/jHe92jW6ZtAP0fePPcbWM3ZiNHYUzHvEzB5nhm
         jrtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790602364; x=1791207164;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rDgWSkzXb9T2f2eSv4f8loR9LBdnnTqRZoSNaSt6PRU=;
        b=R8gWPY1Ay9n3EDIHOE8kkXEBsXV1LiIMStRntKGBDGz9dKnHHOchq/cPg2+rYC7Bew
         +lBc8UMuz/8NTXU1k99SfP0gkzsThbB+rOzIaamPI8ZEuj6NoiOe/NlqDnTY3hKZ1d+w
         UZc3ualGHyD95R6TtlZW8cNe3fAJSqT4lI4ZcipGF7cDyOcWLuO42Yuh7yIOI3gX3e55
         Yy7JHcN/naLrPi9XdnJeqtjpamPPqrJmhmm+0AV1slTm0dzHKANxuhyihIrFyc4cEPfJ
         bhIwVQwP1JMubuMVp6HHcfwFiS2klnpA0YKRuryeNf6JxYDkEyuRqqlDG7GYEdZjkV30
         x0qg==
X-Gm-Message-State: AFq9FYLdnbUI+wWJ/+tLJHh5tqHiRT6p0N6qnm0HAU6I/zIVpar7alHB
	lHAor6UPUs63KeE5YcR4bcOg63IEI4NzEgmVxDAVzgI1WK/JKHa8EIhOWv/Bpj5m
X-Gm-Gg: AYBFou3vVOTsKZR89ihJDzhmkwqXmpjM8Qedlk/vQRzWnAnc3ZdpTwiyEtODXT3xz5z
	WBe7l0i1kOwsjfIsc90EyBo5GshMR8fz5sbNkSm+/rOjJqMWN1dOhbjM3EGHx7JTUCEt11Lviir
	w9t1t25Xz58ha6KAjBKq7l4YCUOX+IACJ28zIvZz2Cbr3LqUEIuL/XMo4esReImf65z/G93T1Wy
	080jHtfIzID8jpcPTcyUWSy9KgwIszCVBRvNDpN6dm28LuQztzJ9elKrMTW7zLxBTeuKp49mJPW
	EPxBIRxRvWVSLsrHBSe1l5UTjoA7LQeFCKnTYwN8uu5gR3lyCYHVVL/Mb5PuutYtURoEfDBKNTx
	32H8pLHjlO9Mx936Y2Uayp0W+WTZmLy1/z0Hu4UDmhSa6/rJdyZ6RyKk5wc6eWl62WXmDBmLcpP
	qiRSB/fRAffu91wZL0IFi91yQQkyRchQkGcaejJqgceqq9DjZfUyTRFtrfz+HFnoovYcWyt7Bhw
	r9HLi71hmZiTSUI4xUJXccRgr4zMYJ7KcAUPHaKWwaYiBG2lfWQjEfpyAR2yinjvZv4mQqqClU8
	1T49fHKN8a+e
X-Received: by 2002:a05:6000:4693:b0:487:342:d141 with SMTP id ffacd0b85a97d-488774f4f02mr13825713f8f.23.1790602364016;
        Mon, 28 Sep 2026 06:32:44 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a349731sm28090164f8f.12.2026.09.28.06.32.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 06:32:43 -0700 (PDT)
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
Subject: [PATCH v7 00/13] Add dmabuf read/write via io_uring
Date: Mon, 28 Sep 2026 14:32:16 +0100
Message-ID: <cover.1790602223.git.asml.silence@gmail.com>
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
git: https://github.com/isilence/linux.git rw-dmabuf-v7
url: https://github.com/isilence/linux/tree/rw-dmabuf-v7

[1] https://lore.kernel.org/io-uring/20220805162444.3985535-1-kbusch@fb.com/

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
 block/blk-merge.c              |  50 ++++
 block/fops.c                   |  27 +-
 drivers/dma-buf/Makefile       |   2 +-
 drivers/dma-buf/dma-buf-io.c   | 230 ++++++++++++++++
 drivers/md/dm-io-rewind.c      |   6 +-
 drivers/nvme/host/core.c       |  12 +
 drivers/nvme/host/nvme.h       |   2 +
 drivers/nvme/host/pci.c        | 467 ++++++++++++++++++++++++++++++++-
 include/linux/bio.h            |  21 +-
 include/linux/blk-mq.h         |   7 +
 include/linux/blk_types.h      |  14 +-
 include/linux/blkdev.h         |   2 +
 include/linux/bvec.h           |   3 +-
 include/linux/dma-buf-io.h     | 117 +++++++++
 include/linux/fs.h             |   2 +
 include/linux/io_uring_types.h |   5 +
 include/linux/iov_iter.h       |   2 +
 include/linux/uio.h            |  11 +
 include/uapi/linux/io_uring.h  |  31 ++-
 io_uring/io_uring.c            |   3 +-
 io_uring/rsrc.c                | 275 ++++++++++++++++---
 io_uring/rsrc.h                |  45 +++-
 io_uring/rw.c                  |   6 +-
 lib/iov_iter.c                 |  29 +-
 25 files changed, 1304 insertions(+), 80 deletions(-)
 create mode 100644 drivers/dma-buf/dma-buf-io.c
 create mode 100644 include/linux/dma-buf-io.h

-- 
2.54.0

