Return-Path: <BATV+f1a9c63dd9d55f86c0ec+5205+infradead.org+hch@bombadil.srs.infradead.org>
Date: Thu, 23 Nov 2017 15:44:38 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for Linux 4.15
Message-ID: <20171123144438.wfs2fo64l6vwgfxj@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-block@vger.kernel.org>

Hi Jens,

a couple nvme fixes for 4.15:

 - expand the queue ready fix that we only had for RDMA to also cover FC and
   loop by moving it to common code (Sagi)
 - fix an array out of bounds in the PCIe HMB code (Minwoo Im)
 - two new device quirks (Jeff Lien and Kai-Heng Feng)
 - static checkers fixes (Keith Busch)
 - FC target refcount fix (James Smart)
 - A trivial spelling fix in new code (Colin Ian King)


The following changes since commit 1690102de5651bb85b23d5eeaff682a6b96d705b:

  blktrace: Use blk_trace_bio_get_cgid inside blk_add_trace_bio (2017-11-19 12:37:26 -0700)

are available in the git repository at:

  git://git.infradead.org/nvme.git nvme-4.15

for you to fetch changes up to 8c97eeccf0ad8783c057830119467b877bdfced7:

  nvme-pci: add quirk for delay before CHK RDY for WDC SN200 (2017-11-23 09:12:08 +0100)

----------------------------------------------------------------
Colin Ian King (1):
      nvme: fix spelling mistake: "requeing" -> "requeuing"

James Smart (1):
      nvmet-fc: correct ref counting error when deferred rcv used

Jeff Lien (1):
      nvme-pci: add quirk for delay before CHK RDY for WDC SN200

Kai-Heng Feng (1):
      nvme-pci: disable APST on Samsung SSD 960 EVO + ASUS PRIME B350M-A

Keith Busch (2):
      nvme: Fix NULL dereference on reservation request
      nvme: Suppress static analyis warning

Minwoo Im (1):
      nvme-pci: avoid hmb desc array idx out-of-bound when hmmaxd set.

Sagi Grimberg (3):
      nvme-fabrics: introduce init command check for a queue that is not alive
      nvme-fc: check if queue is ready in queue_rq
      nvme-loop: check if queue is ready in queue_rq

 drivers/nvme/host/core.c      | 19 ++++++++-----------
 drivers/nvme/host/fabrics.h   | 30 ++++++++++++++++++++++++++++++
 drivers/nvme/host/fc.c        | 19 ++++++++++++++++++-
 drivers/nvme/host/multipath.c |  2 +-
 drivers/nvme/host/nvme.h      |  2 +-
 drivers/nvme/host/pci.c       | 16 +++++++++++++---
 drivers/nvme/host/rdma.c      | 32 ++++++--------------------------
 drivers/nvme/target/fc.c      |  9 ++++++---
 drivers/nvme/target/loop.c    | 25 ++++++++++++++++++++++++-
 9 files changed, 107 insertions(+), 47 deletions(-)
