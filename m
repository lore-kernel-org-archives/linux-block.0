Return-Path: <BATV+71b9c95e0355b61b56b2+5449+infradead.org+hch@bombadil.srs.infradead.org>
Date: Wed, 25 Jul 2018 13:08:35 +0200
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: [GIT PULL] first round of nvme updates for 4.19
Message-ID: <20180725110835.GA1674@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-block@vger.kernel.org>

Hi Jens,

below is the first batch of NVMe updates for Linux 4.19.

Highlights:

 - massively improved tracepoints (Keith Busch)
 - support for larger inline data in the RDMA host and target
   (Steve Wise)
 - RDMA setup/teardown path fixes and refactor (Sagi Grimberg)
 - Command Supported and Effects log support for the NVMe target
   (Chaitanya Kulkarni)
 - buffered I/O support for the NVMe target (Chaitanya Kulkarni)

plus the usual set of cleanups and small enhancements.

The following changes since commit 8824f62246bef288173a6624a363352f0d4d3b09:

  blk-mq: fail the request in case issue failure (2018-07-22 17:31:18 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git nvme-4.19

for you to fetch changes up to 1b0d274523df5ef1caedc834da055ff721e4d4f0:

  nvmet: don't use uuid_le type (2018-07-24 15:55:51 +0200)

----------------------------------------------------------------
Andy Shevchenko (1):
      nvmet: don't use uuid_le type

Chaitanya Kulkarni (2):
      nvmet: add commands supported and effects log page
      nvmet: add buffered I/O support for file backed ns

Gustavo A. R. Silva (1):
      nvme-rdma: mark expected switch fall-through

James Smart (1):
      nvme: move init of keep_alive work item to controller initialization

Keith Busch (3):
      nvme: use hw qid in trace events
      nvme: add controller name to trace events
      nvme: add disk name to trace events

Max Gurtovoy (2):
      nvmet-rdma: add unlikely check in the fast path
      nvmet-rdma: add an error flow for post_recv failures

Revanth Rajashekar (1):
      nvme.h: resync with nvme-cli

Sagi Grimberg (6):
      nvme: cache struct nvme_ctrl reference to struct nvme_request
      nvme-rdma: unquiesce queues when deleting the controller
      nvme-rdma: centralize controller setup sequence
      nvme-rdma: centralize admin/io queue teardown sequence
      nvmet: fix file discard return status
      nvmet: check fileio lba range access boundaries

Steve Wise (2):
      nvme-rdma: support up to 4 segments of inline data
      nvmet-rdma: support max(16KB, PAGE_SIZE) inline data

 drivers/nvme/host/core.c          |  12 +-
 drivers/nvme/host/fc.c            |   1 +
 drivers/nvme/host/nvme.h          |   8 ++
 drivers/nvme/host/pci.c           |   2 +
 drivers/nvme/host/rdma.c          | 234 ++++++++++++++++++--------------------
 drivers/nvme/host/trace.c         |  11 ++
 drivers/nvme/host/trace.h         | 142 +++++++++++------------
 drivers/nvme/target/admin-cmd.c   |  41 ++++++-
 drivers/nvme/target/configfs.c    |  60 ++++++++++
 drivers/nvme/target/core.c        |  13 +++
 drivers/nvme/target/discovery.c   |   2 +-
 drivers/nvme/target/io-cmd-file.c |  68 ++++++++---
 drivers/nvme/target/loop.c        |   1 +
 drivers/nvme/target/nvmet.h       |   5 +-
 drivers/nvme/target/rdma.c        | 197 ++++++++++++++++++++++++--------
 include/linux/nvme.h              |   5 +
 16 files changed, 536 insertions(+), 266 deletions(-)
