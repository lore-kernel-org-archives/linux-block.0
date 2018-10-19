Return-Path: <BATV+1390e5f2eb4877bdb648+5535+infradead.org+hch@bombadil.srs.infradead.org>
Date: Fri, 19 Oct 2018 17:35:39 +0200
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme updates for Linux 4.20
Message-ID: <20181019153539.GA24842@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-block@vger.kernel.org>

The second batch of updates for Linux 4.20:
 - lot of fixes for issues found by static type checkers from Bart
 - two small fixes from Keith
 - fabrics cleanups in preparation of the TCP transport from Sagi
 - more cleanups from Chaitanya

The following changes since commit 0585b75437d335c6580066c1ab9ea3092139df32:

  sx8: convert to blk-mq (2018-10-16 09:50:55 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git nvme-4.20

for you to fetch changes up to b7c7be6f6bd28ffea7f608ac2d806b8a4bdc82fe:

  nvme-fabrics: move controller options matching to fabrics (2018-10-19 14:22:24 +0200)

----------------------------------------------------------------
Bart Van Assche (14):
      nvmet: use strcmp() instead of strncmp() for subsystem lookup
      nvmet-rdma: check for timeout in nvme_rdma_wait_for_cm()
      nvme-core: declare local symbols static
      nvme-core: rework a NQN copying operation
      nvme-pci: fix nvme_suspend_queue() kernel-doc header
      nvmet: use strlcpy() instead of strcpy()
      nvmet-rdma: declare local symbols static
      nvmet: avoid integer overflow in the discard code
      nvme-fc: fix kernel-doc headers
      nvme-fc: introduce struct nvme_fcp_op_w_sgl
      nvme-fc: rework the request initialization code
      nvmet-fc: fix kernel-doc headers
      nvme-core: make implicit seed truncation explicit
      nvmet-fcloop: suppress a compiler warning

Chaitanya Kulkarni (2):
      nvmet: remove unreachable code
      nvme-pci: remove duplicate check

Keith Busch (2):
      nvme: update node paths after adding new path
      nvme-pci: fix hot removal during error handling

Sagi Grimberg (2):
      nvme-rdma: always have a valid trsvcid
      nvme-fabrics: move controller options matching to fabrics

 drivers/nvme/host/core.c          |  6 +--
 drivers/nvme/host/fabrics.c       | 30 +++++++++++++++
 drivers/nvme/host/fabrics.h       |  2 +
 drivers/nvme/host/fc.c            | 45 +++++++++++++---------
 drivers/nvme/host/multipath.c     |  9 +++++
 drivers/nvme/host/pci.c           |  9 ++---
 drivers/nvme/host/rdma.c          | 78 +++++++++++----------------------------
 drivers/nvme/target/admin-cmd.c   |  2 +-
 drivers/nvme/target/core.c        |  3 +-
 drivers/nvme/target/discovery.c   |  6 +--
 drivers/nvme/target/fc.c          |  6 +--
 drivers/nvme/target/fcloop.c      |  1 +
 drivers/nvme/target/io-cmd-file.c |  3 +-
 drivers/nvme/target/rdma.c        |  2 +-
 14 files changed, 107 insertions(+), 95 deletions(-)
