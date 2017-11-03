Return-Path: <BATV+4f5d8ac065f641832dc0+5185+infradead.org+hch@bombadil.srs.infradead.org>
Date: Fri, 3 Nov 2017 15:17:03 +0300
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme updates for Linux 4.15
Message-ID: <20171103121703.kupyb5rvuyvaevsr@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-block@vger.kernel.org>

Hi Jens,

below are the currently queue nvme updates for Linux 4.15.  There are
a few more things that could make it for this merge window, but I'd
like to get things into linux-next, especially for the unlikely case
that Linus decided to cut -rc8.

Highlights:
 - support for SGLs in the PCIe driver (Chaitanya Kulkarni)
 - disable I/O schedulers for the admin queue (Israel Rukshin)
 - various Fibre Channel fixes and enhancements (James Smart)
 - various refactoring for better code sharing between transports
   (Sagi Grimberg and me)

as well as lots of little bits from various contributors.

The following changes since commit 9c9883744dda1cc38339a448dd8435140537027e:

  block: move __elv_next_request to blk-core.c (2017-10-03 08:43:04 -0600)

are available in the git repository at:

  git://git.infradead.org/nvme.git nvme-4.15

for you to fetch changes up to a806c6c81e6c0d07c8a8b2643bad4a37a196d681:

  nvme: comment typo fixed in clearing AER (2017-11-03 10:02:20 +0300)

----------------------------------------------------------------
Chaitanya Kulkarni (1):
      nvme-pci: add SGL support

Christoph Hellwig (11):
      nvme: simplify compat_ioctl handling
      nvme: use ida_simple_{get,remove} for the controller instance
      nvme: use kref_get_unless_zero in nvme_find_get_ns
      nvme: simplify nvme_open
      nvme: switch controller refcounting to use struct device
      nvme: get rid of nvme_ctrl_list
      nvme: check for a live controller in nvme_dev_open
      nvme-fc: merge __nvme_fc_schedule_delete_work into __nvme_fc_del_ctrl
      nvme: move controller deletion to common code
      nvme-rdma: remove nvme_rdma_remove_ctrl
      nvme: consolidate common code from ->reset_work

Israel Rukshin (3):
      nvme-rdma: Add BLK_MQ_F_NO_SCHED flag to admin tag set
      nvme-fc: Add BLK_MQ_F_NO_SCHED flag to admin tag set
      nvme-loop: Add BLK_MQ_F_NO_SCHED flag to admin tag set

James Smart (18):
      nvmet: bump NVMET_NR_QUEUES to 128
      nvme-fc: add uevent for auto-connect
      nvme-fc: create fc class and transport device
      nvme-fc: move remote port get/put/free location
      nvme-fc: correct io termination handling
      nvme-fc: correct io timeout behavior
      nvme: add duplicate_connect option
      nvme: add helper to compare options to controller
      nvme-rdma: add support for duplicate_connect option
      nvme-fc: add support for duplicate_connect option
      nvme-fc: remove NVME_FC_MAX_SEGMENTS
      nvme-fc: avoid workqueue flush stalls
      nvme-fc: change ctlr state assignments during reset/reconnect
      nvme-fc: add a dev_loss_tmo field to the remoteport
      nvme-fc: check connectivity before initiating reconnects
      nvme: allow controller RESETTING to RECONNECTING transition
      nvme-fc: add dev_loss_tmo timeout and remoteport resume support
      nvmet: fix fatal_err_work deadlock

Keith Busch (1):
      nvme: Remove unused headers

Marc Olson (1):
      nvme: update timeout module parameter type

Max Gurtovoy (1):
      nvme-rdma: align nvme_rdma_device structure

Minwoo Im (2):
      nvme-pci: fix typos in comments
      nvme: comment typo fixed in clearing AER

Nitzan Carmi (1):
      nvme-rdma: Add debug message when reaches timeout

Randy Dunlap (1):
      nvme: use menu Kconfig interface

Roy Shterman (1):
      nvmet: Change max_nsid in subsystem due to ns_disable if needed

Sagi Grimberg (14):
      nvme-fabrics: request transport module
      block: introduce blk_mq_tagset_iter
      nvme: introduce nvme_reinit_tagset
      block: remove blk_mq_reinit_tagset
      nvme-rdma: pass tagset to directly nvme_rdma_free_tagset
      nvme-rdma: fix wrong logging message
      nvme-rdma: move assignment to declaration
      nvme-rdma: Check that reinit_request got a proper mr
      nvme-rdma: teardown admin/io queues once on error recovery
      nvme-rdma: Don't local invalidate if the queue is not live
      nvme-rdma: change queue flag semantics DELETING -> ALLOCATED
      nvme-rdma: stop controller reset if the controller is deleting
      nvme-rdma: reuse nvme_delete_ctrl when reconnect attempts expire
      nvme: flush reset_work before safely continuing with delete operation

 block/blk-mq-tag.c             |  11 +-
 drivers/nvme/Kconfig           |   4 +
 drivers/nvme/host/core.c       | 260 +++++++---------
 drivers/nvme/host/fabrics.c    |  12 +-
 drivers/nvme/host/fabrics.h    |  14 +
 drivers/nvme/host/fc.c         | 656 ++++++++++++++++++++++++++++++-----------
 drivers/nvme/host/nvme.h       |  26 +-
 drivers/nvme/host/pci.c        | 224 +++++++++++---
 drivers/nvme/host/rdma.c       | 225 ++++++++------
 drivers/nvme/target/core.c     |  13 +
 drivers/nvme/target/fc.c       |  16 +-
 drivers/nvme/target/loop.c     |  47 +--
 drivers/nvme/target/nvmet.h    |   2 +-
 include/linux/blk-mq.h         |   4 +-
 include/linux/nvme-fc-driver.h |  15 +-
 15 files changed, 1026 insertions(+), 503 deletions(-)
