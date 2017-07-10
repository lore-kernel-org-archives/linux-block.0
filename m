Return-Path: <sagi@grimberg.me>
From: Sagi Grimberg <sagi@grimberg.me>
To: Jens Axboe <axboe@kernel.dk>,
	linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <keith.busch@intel.com>,
	linux-block@vger.kernel.org
Subject: [GIT PULL] another round of nvme patches for kernel 4.13
Date: Mon, 10 Jul 2017 20:16:52 +0300
Message-Id: <1499707012-19014-1-git-send-email-sagi@grimberg.me>
List-ID: <linux-block@vger.kernel.org>

Hey Jens,

Another round of early patches for 4.13.

I added the quiesce/unquiesce patches in here as it's
easy for me easily apply changes on top. It has accumulated
reviews and includes mostly nvme anyway, please tell me if
you don't want to take them with this.

This includes:
- quiesce/unquiesce fixes in nvme and others from me
- nvme-fc add create association padding spec updates from James
- some more quirking from MKP
- nvmet nit cleanup from Max
- Fix nvme-rdma racy RDMA completion signalling from Marta
- some centralization patches from me
- add tagset nr_hw_queues updates on controller resets in
  nvme drivers from me
- nvme-rdma fix resources recycling when doing error recovery from me
- minor cleanups in nvme-fc from me

please consider pulling from:

  git://git.infradead.org/nvme.git nvme-4.13

It's rebased on top of your for-4.13/block.

Thanks!

----------------------------------------------------------------
Dan Carpenter (1):
      nvme-pci: compile warnings in nvme_alloc_host_mem()

James Smart (2):
      nvme_fc/nvmet_fc: revise Create Association descriptor length
      nvmet_fc: Accept variable pad lengths on Create Association LS

Marta Rybczynska (1):
      nvme-rdma: remove race conditions from IB signalling

Martin K. Petersen (1):
      nvme: Quirks for PM1725 controllers

Max Gurtovoy (1):
      nvmet: avoid unneeded assignment of submit_bio return value

Sagi Grimberg (18):
      nvme: move queue_count to the nvme_ctrl
      nvme: move ctrl cap to struct nvme_ctrl
      nvme-pci: rename to nvme_pci_configure_admin_queue
      nvme-fc: don't override opts->nr_io_queues
      nvme-rdma: update tagset nr_hw_queues after reconnecting/resetting
      nvme-loop: update tagset nr_hw_queues after reconnecting/resetting
      nvme-fc: update tagset nr_hw_queues after queues reinit
      nvme-fc: use blk_mq_delay_run_hw_queue instead of open-coding it
      nvme-rdma: quiesce/unquiesce admin_q instead of start/stop its hw queues
      nvme-fc: quiesce/unquiesce admin_q instead of start/stop its hw queues
      nvme-loop: quiesce/unquiesce admin_q instead of start/stop its hw queues
      nvme-pci: quiesce/unquiesce admin_q instead of start/stop its hw queues
      nvme: kick requeue list when requeueing a request instead of when starting the queues
      nbd: quiesce request queues to make sure no submissions are inflight
      mtip32xx: quiesce request queues to make sure no submissions are inflight
      virtio_blk: quiesce/unquiesce live IO when entering PM states
      nvme: split nvme_uninit_ctrl into stop and uninit
      nvme-rdma: unconditionally recycle the request mr

weiping zhang (1):
      nvme-pci: add module parameter for io queue depth

 drivers/block/mtip32xx/mtip32xx.c |  19 +++++--
 drivers/block/nbd.c               |   4 +-
 drivers/block/virtio_blk.c        |   4 +-
 drivers/nvme/host/core.c          |  40 +++++++-------
 drivers/nvme/host/fc.c            |  83 ++++++++++++++---------------
 drivers/nvme/host/nvme.h          |   4 ++
 drivers/nvme/host/pci.c           |  96 +++++++++++++++++++--------------
 drivers/nvme/host/rdma.c          | 108 +++++++++++++++++---------------------
 drivers/nvme/target/fc.c          |  20 ++++---
 drivers/nvme/target/io-cmd.c      |   2 +-
 drivers/nvme/target/loop.c        |  47 ++++++++---------
 include/linux/nvme-fc.h           |  23 +++++++-
 12 files changed, 248 insertions(+), 202 deletions(-)
