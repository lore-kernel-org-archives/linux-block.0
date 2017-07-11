Return-Path: <axboe@kernel.dk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 4.13-rc1
Message-ID: <f19ab771-e5ea-d8e8-eccb-7bda45b90ce0@kernel.dk>
Date: Tue, 11 Jul 2017 13:04:47 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Linus,

This is a followup pull request for block changes, that didn't make the
initial pull request. It's a bit of a mixed bag, this pull request
contains:

- A followup pull request from Sagi for NVMe. Outside of fixups for
  NVMe, it also includes a series for ensuring that we properly quiesce
  hardware queues when browsing live tags.

- Set of integrity fixes from Dmitry (mostly), fixing various issues for
  folks using DIF/DIX.

- Fix for a bug introduced in cciss, with the req init changes. From
  Christoph.

- Fix for a bug in BFQ, from Paolo.

- Two followup fixes for lightnvm/pblk from Javier.

- Depth fix from Ming for blk-mq-sched.

- Also from Ming, performance fix for mtip32xx that was introduced with
  the dynamic initialization of commands.

Please pull!


  git://git.kernel.dk/linux-block.git for-linus


----------------------------------------------------------------
Christoph Hellwig (2):
      bio-integrity: stop abusing bi_end_io
      cciss: initialize struct scsi_req

Damien Le Moal (1):
      block: Fix __blkdev_issue_zeroout loop

Dan Carpenter (1):
      nvme-pci: compile warnings in nvme_alloc_host_mem()

Dmitry Monakhov (8):
      bio-integrity: bio_trim should truncate integrity vector accordingly
      bio-integrity: bio_integrity_advance must update integrity seed
      bio-integrity: fix interface for bio_integrity_trim
      bio-integrity: fold bio_integrity_enabled to bio_integrity_prep
      t10-pi: Move opencoded contants to common header
      block: guard bvec iteration logic
      bio: add bvec_iter rewind API
      bio-integrity: Restore original iterator on verify stage

James Smart (2):
      nvme_fc/nvmet_fc: revise Create Association descriptor length
      nvmet_fc: Accept variable pad lengths on Create Association LS

Javier González (2):
      lightnvm: pblk: control I/O flow also on tear down
      lightnvm: pblk: remove unnecessary checks

Jens Axboe (1):
      Merge branch 'nvme-4.13' of git://git.infradead.org/nvme into for-linus

Marta Rybczynska (1):
      nvme-rdma: remove race conditions from IB signalling

Martin K. Petersen (1):
      nvme: Quirks for PM1725 controllers

Max Gurtovoy (2):
      null_blk: fix error flow for shared tags during module_init
      nvmet: avoid unneeded assignment of submit_bio return value

Ming Lei (2):
      blk-mq-sched: fix performance regression of mq-deadline
      mtip32xx: avoid to read HOST_CAP from HW in .queue_rq()

Paolo Valente (1):
      block, bfq: don't change ioprio class for a bfq_queue on a service tree

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

Shaohua Li (1):
      block: call bio_uninit in bio_endio

kbuild test robot (1):
      bio-integrity: fix boolreturn.cocci warnings

weiping zhang (1):
      nvme-pci: add module parameter for io queue depth

 Documentation/block/data-integrity.txt |   6 +-
 block/bfq-iosched.c                    |  14 ++-
 block/bfq-iosched.h                    |   3 +-
 block/bfq-wf2q.c                       |  39 +++++++-
 block/bio-integrity.c                  | 165 +++++++++++++++------------------
 block/bio.c                            |  13 ++-
 block/blk-core.c                       |   5 +-
 block/blk-lib.c                        |  23 ++++-
 block/blk-mq-sched.c                   |   8 +-
 block/blk-mq.c                         |   4 +-
 block/blk.h                            |  11 +++
 block/t10-pi.c                         |   9 +-
 drivers/block/cciss.c                  |   8 ++
 drivers/block/mtip32xx/mtip32xx.c      |  23 +++--
 drivers/block/mtip32xx/mtip32xx.h      |   1 +
 drivers/block/nbd.c                    |   4 +-
 drivers/block/null_blk.c               |  18 +++-
 drivers/block/virtio_blk.c             |   4 +-
 drivers/lightnvm/pblk-core.c           |  61 +++++++++---
 drivers/lightnvm/pblk-recovery.c       |  31 +++++--
 drivers/lightnvm/pblk-write.c          |  26 ++----
 drivers/lightnvm/pblk.h                |   2 +
 drivers/md/dm.c                        |   2 +-
 drivers/nvdimm/blk.c                   |  16 +---
 drivers/nvdimm/btt.c                   |  16 +---
 drivers/nvme/host/core.c               |  40 ++++----
 drivers/nvme/host/fc.c                 |  83 ++++++++---------
 drivers/nvme/host/nvme.h               |   4 +
 drivers/nvme/host/pci.c                |  96 +++++++++++--------
 drivers/nvme/host/rdma.c               | 108 ++++++++++-----------
 drivers/nvme/target/fc.c               |  20 ++--
 drivers/nvme/target/io-cmd.c           |   2 +-
 drivers/nvme/target/loop.c             |  47 +++++-----
 drivers/scsi/lpfc/lpfc_scsi.c          |   5 +-
 drivers/scsi/qla2xxx/qla_isr.c         |   8 +-
 drivers/target/target_core_sbc.c       |   2 +-
 include/linux/bio.h                    |  47 +++++-----
 include/linux/bvec.h                   |  41 +++++++-
 include/linux/nvme-fc.h                |  23 ++++-
 include/linux/t10-pi.h                 |   2 +
 40 files changed, 600 insertions(+), 440 deletions(-)

-- 
Jens Axboe
