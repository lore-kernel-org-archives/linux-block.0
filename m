Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C8437E30A
	for <linux-block@vger.kernel.org>; Wed, 29 Apr 2026 15:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777476384; cv=none; b=oqRfTOAHj8I8rpgidQpv5AEgWFX7N3fPq1vKEb/gNS2NtrlUz8H+YIsg+RidvT5Sd7etAYmTguW9PV9rNphS0AcspkHEpENxM9nlqugmiX2M3X4B9S/4HO3doBaRR2o4Kbx1jgm0OMy2b2/AHaaRY18karMnSnU/k7ZYodyNoYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777476384; c=relaxed/simple;
	bh=hELMxdIqirWfZE9lS3jphk/Hs00RokLAMWOkF4lalT0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qP51ntkOfh2qYQi3UOU2bPflTfWbWlX0thiYseOidIAWInnjMtpV3Bn8x8HaFbk71sYk5613eJAkx3X0VJPQiT96hUJQwpbKN/mHvgNpG2WPlRLc4lNXazWGKSZY6eU9H3oIbYcVuuNlvUhU1zRsC5g3v6zCcftmpv3DYsJgNm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XWB8xc98; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XWB8xc98"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-488b0046078so114871905e9.1
        for <linux-block@vger.kernel.org>; Wed, 29 Apr 2026 08:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777476378; x=1778081178; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G9kqbgnidQC23bEvrBAVDYa4e7L0vOouqvUY0ysfe8Y=;
        b=XWB8xc98up29GzY7kFjywBjNyG9lgycOlMLs1dHgrQ32RQEWjh6cxO4yMt8G/UntSC
         4kksswLeJ03wupTCWEvdS7ZG2if40crUlus2GT8pR5xWNiEWI/uiK7N0mIrzbrNFKnOL
         PySlG5myV9tLCrrkUmRq49nU7xHF8nIgRKHwlG1Qw6DzKvYg+kl+vYewodjHeZ/fQUEU
         HY93XBkBemETwZXXuPpu1nm9a0NV/vd06xGE571ZmDtPeca3KlAnQ65PZTTkTqnPOBbw
         REGD+nzd0M52LFRdTDuoc0l8KZasOYu1p3bNIERwFJvAJXQABZDlS0H/3MO75ARW9ztW
         V5ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777476378; x=1778081178;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G9kqbgnidQC23bEvrBAVDYa4e7L0vOouqvUY0ysfe8Y=;
        b=jdise/tO2TUza/SyysIq3ftMKx9j7awDmvxc7XpIpTC4pA+WdNyJ6MIUDjvW9wb4G3
         K1K19JC7T/5WHRCrUMe+DosBa4IVxckHVrmlPNR9Xtfptqhz0f5AzOkkReIHPT7akmYi
         4AzRxjyPVTuO17SvBUJwYx+TDPlgxPMrDrmQfsBYucFJetTTlgd8Cx8RvEE45zonSqpH
         LSj3qvnLL+4W/lHuIlyzdMtI2BdgEBdEGx1N9B8l6XPImVwOQVV9JhFiFcRuvVW9KZmQ
         dtlLmrBjiPeCcNbMmi6+XQb6zZ3sqqFTExCOmavwXGT/KUUnHqllgOzEVcXdyrpi7sM2
         H54g==
X-Forwarded-Encrypted: i=1; AFNElJ9wUA7vrZBw2wdRVQsM5jlgXfq71OEsFC2j0pELtVOGYhbnknMme8jhPudaBfwfoHW4EkIYOu/TCFcjYw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5OV+VaXR4LjnVrZUenMDH9Jafz3RG0mAg4ebM4oSdEAKDDBci
	ZqwEdUvMLGkeXyI6Upji73U4Vce/wcfWj1LiL0IrjXJvZAWffk0r0kp7
X-Gm-Gg: AeBDieuAkPHTTfLjjXYAKQJ9COnWaoF3agnOpnz0kGd9f4fc5RfZF2+Ad7BLq9EBgB1
	+24Ir8qJyuXI3WT45z9l2DMaxmRy6WgpVCCAin6ZPdNLpTJp93kgvF8UR8nqER/sOudKZfhxDcg
	JUhiUQ0DWIQOM4t+mXa1Sx3ELrr3NElkQQPQ2yPTh80I+q2mEbLKWm/6VXExNdrr0WY6kTJ/pYh
	ogHRoE6uKSxyzNhdQft7+sKMAOgsplmTTBJkfBlbDDrx9YLuDImXAZDNo4pyNH1d3FQcfUqKbOd
	H6GKD5i3XD+R6Ae8wgUXYsBPfZrFs7sHP8BpceuxFmo9LZbelMo81G+Ulrm0gDfOzCuk8kDGDtB
	qqeqFjqNlrOgE+ySRoNbx8sv+HhhW5FMPIyQiXpC30upopk7BOYbq4L5RvzJ+h1/oxRKy5Tuae9
	YhodN9TOp44QjOhEjgQG/RBcdCwVezT1GcGS809trphswAFa70LWYBkFX/7TaqbkoKPR0SsLHAi
	NDBgV37qhghVZPipPXy3JNnXb5d/VBV3ssn5g45iTHJ
X-Received: by 2002:a05:600c:4f92:b0:489:1ff1:74df with SMTP id 5b1f17b1804b1-48a77ae5430mr125646225e9.1.1777476377153;
        Wed, 29 Apr 2026 08:26:17 -0700 (PDT)
Received: from 127.0.0.1localhost ([82.132.184.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-447b76e5c22sm6382951f8f.28.2026.04.29.08.26.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 08:26:16 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org
Cc: asml.silence@gmail.com,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Tushar Gohad <tushar.gohad@intel.com>,
	William Power <william.power@intel.com>,
	Phil Cayton <phil.cayton@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v3 00/10] Add dmabuf read/write via io_uring
Date: Wed, 29 Apr 2026 16:25:46 +0100
Message-ID: <cover.1777475843.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.53.0
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
from where I borrowed a good number of changes, and later was brough up
by Tushar and Vishal from Intel.

It's an opt-in feature for files, and they need to implement a new
file operation to use it. Only NVMe block devices are supported in this
series. The user API is built on top of io_uring's "registered buffers",
where a dmabuf is registered in a special way, but after it can be used
as any other "registered buffer" with IORING_OP_{READ,WRITE}_FIXED
requests. It's created via a new file operation and the resulted map is
then passed through the I/O stack in a new iterator type. There is some
additional infrastructure to bind it all, which also counts requests
using a dmabuf map and managing lifetimes, which is used to implement
map invalidation.

It was tested for GPU <-> NVMe transfers. Also, as it maintains a
long-term dma mapping, it helps with the IOMMU cost. The numbers
below are for udmabuf reads previously run by Anuj for different
IOMMU modes:

- STRICT: before = 570 KIOPS, after = 5.01 MIOPS
- LAZY: before = 1.93 MIOPS, after = 5.01 MIOPS
- PASSTHROUGH: before = 5.01 MIOPS, after = 5.01 MIOPS

There are some liburing tests that can serve as an example:
git: https://github.com/isilence/liburing.git rw-dmabuf-tests-v3
url: https://github.com/isilence/liburing/tree/rw-dmabuf-tests-v3

[1] https://lore.kernel.org/io-uring/20220805162444.3985535-1-kbusch@fb.com/

v3: - Rework io_uring registration
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

Pavel Begunkov (10):
  file: add callback for creating long-term dmabuf maps
  iov_iter: add iterator type for dmabuf maps
  block: move bvec init into __bio_clone
  block: introduce dma map backed bio type
  lib: add dmabuf token infrastructure
  block: forward create_dmabuf_token to drivers
  nvme-pci: implement dma_token backed requests
  io_uring/rsrc: introduce buf registration structure
  io_uring/rsrc: extend buffer update
  io_uring/rsrc: add dmabuf backed registered buffers

 block/bio.c                     |  28 +++-
 block/blk-merge.c               |  14 ++
 block/blk.h                     |   3 +-
 block/fops.c                    |  16 ++
 drivers/nvme/host/pci.c         | 282 ++++++++++++++++++++++++++++++++
 include/linux/bio.h             |  19 ++-
 include/linux/blk-mq.h          |   9 +
 include/linux/blk_types.h       |   8 +-
 include/linux/fs.h              |   2 +
 include/linux/io_dmabuf_token.h |  92 +++++++++++
 include/linux/io_uring_types.h  |   5 +
 include/linux/uio.h             |  11 ++
 include/uapi/linux/io_uring.h   |  31 +++-
 io_uring/io_uring.c             |   3 +-
 io_uring/rsrc.c                 | 266 +++++++++++++++++++++++++-----
 io_uring/rsrc.h                 |  30 +++-
 io_uring/rw.c                   |   4 +-
 lib/Kconfig                     |   4 +
 lib/Makefile                    |   2 +
 lib/io_dmabuf_token.c           | 272 ++++++++++++++++++++++++++++++
 lib/iov_iter.c                  |  29 +++-
 21 files changed, 1071 insertions(+), 59 deletions(-)
 create mode 100644 include/linux/io_dmabuf_token.h
 create mode 100644 lib/io_dmabuf_token.c

-- 
2.53.0

