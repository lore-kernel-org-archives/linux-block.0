Return-Path: <prvs=473169c3e=Bart.VanAssche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, Christoph Hellwig <hch@lst.de>, "Ard
 Biesheuvel" <ard.biesheuvel@linaro.org>, Herbert Xu
	<herbert@gondor.apana.org.au>, Bart Van Assche <bart.vanassche@wdc.com>
Subject: [PATCH v3 0/8] Introduce sgl_alloc() and sgl_free()
Date: Fri, 3 Nov 2017 15:23:31 -0700
Message-ID: <20171103222339.26540-1-bart.vanassche@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: bart.vanassche@wdc.com
List-ID: <linux-block@vger.kernel.org>

Hello Jens,

As you know there are multiple drivers that both allocate a scatter/gather
list and populate that list with pages. This patch series moves the code for
allocating and freeing such scatterlists from these drivers into
lib/scatterlist.c. Please consider this patch series for kernel v4.15.

Notes:
- Only the ib_srpt and ipr changes have been tested.
- The next step is to introduce a caching mechanism for these scatterlists
  and make the nvmet/rdma and SCSI target drivers use that caching mechanism
  since for these drivers sgl allocation occurs in the hot path.

Changes between v2 and v3:
- Added Reviewed-by tags that had been posted as replies on v2.
- Cc'ed the crypto maintainers for the entire patch series.

Changes between v1 and v2:
- Moved the sgl_alloc*() and sgl_free() functions from a new source file into
  lib/scatterlist.c.
- Changed the argument order for the sgl_alloc*() functions such that the
  (pointer to) the output argument comes last.

Thanks,

Bart.

Bart Van Assche (8):
  lib/scatterlist: Introduce sgl_alloc() and sgl_free()
  crypto: scompress - use sgl_alloc() and sgl_free()
  nvmet/fc: Use sgl_alloc() and sgl_free()
  nvmet/rdma: Use sgl_alloc() and sgl_free()
  target: Use sgl_alloc_order() and sgl_free()
  scsi/ipr: Use sgl_alloc_order() and sgl_free_order()
  scsi/pmcraid: Remove an unused structure member
  scsi/pmcraid: Use sgl_alloc_order() and sgl_free_order()

 crypto/Kconfig                         |   1 +
 crypto/scompress.c                     |  51 +---------------
 drivers/nvme/target/Kconfig            |   2 +
 drivers/nvme/target/fc.c               |  36 +----------
 drivers/nvme/target/rdma.c             |  63 ++------------------
 drivers/scsi/Kconfig                   |   2 +
 drivers/scsi/ipr.c                     |  49 +++------------
 drivers/scsi/ipr.h                     |   2 +-
 drivers/scsi/pmcraid.c                 |  43 ++------------
 drivers/scsi/pmcraid.h                 |   3 +-
 drivers/target/Kconfig                 |   1 +
 drivers/target/target_core_transport.c |  46 ++-------------
 include/linux/scatterlist.h            |  10 ++++
 lib/Kconfig                            |   4 ++
 lib/scatterlist.c                      | 105 +++++++++++++++++++++++++++++++++
 15 files changed, 151 insertions(+), 267 deletions(-)

-- 
2.14.3
