Return-Path: <axboe@kernel.dk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block changes for 4.16-rc4
Message-ID: <54bfe85d-f857-bbb8-3f72-751d85e66b27@kernel.dk>
Date: Fri, 2 Mar 2018 08:55:14 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Linus,

A collection of fixes for this series. This is a little larger than
usual at this time, but that's mainly because I was out on vacation last
week. Nothing in here is major in any way, it's just two weeks of fixes.
This pull request contains:

- NVMe pull from Keith, with a set of fixes from the usual suspects.

- mq-deadline zone unlock fix from Damien, fixing an issue with the SMR
  zone locking added for 4.16.

- Two bcache fixes sent in by Michael, with changes from Coly and Tang.

- Comment typo fix from Eric for blktrace.

- Return value error handling fix for nbd, from Gustavo.

- Fix a direct-io case where we don't defer to a completion handler,
  making us sleep from IRQ device completion. From Jan.

- A small series from Jan fixing up holes around handling of bdev
  references.

- Small set of regression fixes from Jiufei, mostly fixing problems
  around the gendisk pointer -> partition index change.

- Regression fix from Ming, fixing a boundary issue with the discard
  page cache invalidation.

- Two patch series from Ming, fixing both a core blk-mq-sched and kyber
  issue around token freeing on a requeue condition.

Please pull!


  git://git.kernel.dk/linux-block.git tags/for-linus-20180302


Baegjae Sung (1):
      nvme-multipath: fix sysfs dangerously created links

Christoph Hellwig (3):
      nvme-fabrics: don't check for non-NULL module in nvmf_register_transport
      nvme-rdma: use blk_rq_payload_bytes instead of blk_rq_bytes
      nvmet-loop: use blk_rq_payload_bytes for sgl selection

Coly Li (1):
      bcache: correct flash only vols (check all uuids)

Damien Le Moal (1):
      mq-deadline: Make sure to always unlock zones

Eric Biggers (1):
      blktrace_api.h: fix comment for struct blk_user_trace_setup

Gustavo A. R. Silva (1):
      nbd: fix return value in error handling path

Jan Kara (7):
      direct-io: Fix sleep in atomic due to sync AIO
      genhd: Fix leaked module reference for NVME devices
      genhd: Rename get_disk() to get_disk_and_module()
      genhd: Add helper put_disk_and_module()
      genhd: Fix use after free in __blkdev_get()
      genhd: Fix BUG in blkdev_open()
      blockdev: Avoid two active bdev inodes for one device

Jens Axboe (1):
      Merge branch 'for-jens' of git://git.infradead.org/nvme into for-linus

Jianchao Wang (1):
      nvme-pci: Fix nvme queue cleanup if IRQ setup fails

Jiufei Xue (3):
      block: fix the count of PGPGOUT for WRITE_SAME
      block: display the correct diskname for bio
      block: fix a typo

Max Gurtovoy (1):
      nvmet: fix PSDT field check in command format

Ming Lei (3):
      block: pass inclusive 'lend' parameter to truncate_inode_pages_range
      blk-mq: don't call io sched's .requeue_request when requeueing rq to ->dispatch
      block: kyber: fix domain token leak during requeue

Tang Junhui (1):
      bcache: fix kcrashes with fio in RAID5 backend dev

 block/blk-cgroup.c                | 11 ++-------
 block/blk-core.c                  |  2 +-
 block/blk-mq.c                    |  4 +++-
 block/genhd.c                     | 48 +++++++++++++++++++++++++++++++-------
 block/ioctl.c                     |  2 +-
 block/kyber-iosched.c             |  1 +
 block/mq-deadline.c               | 16 ++++++++++---
 block/partition-generic.c         |  6 +++++
 drivers/block/amiflop.c           |  2 +-
 drivers/block/ataflop.c           |  2 +-
 drivers/block/brd.c               |  2 +-
 drivers/block/floppy.c            |  2 +-
 drivers/block/loop.c              |  2 +-
 drivers/block/nbd.c               |  2 +-
 drivers/block/pktcdvd.c           |  2 +-
 drivers/block/swim.c              |  2 +-
 drivers/block/z2ram.c             |  2 +-
 drivers/ide/ide-probe.c           |  2 +-
 drivers/md/bcache/request.c       |  2 +-
 drivers/md/bcache/super.c         |  2 +-
 drivers/nvme/host/core.c          | 12 +++-------
 drivers/nvme/host/fabrics.c       |  2 +-
 drivers/nvme/host/multipath.c     | 15 ++++++++----
 drivers/nvme/host/pci.c           |  5 +++-
 drivers/nvme/host/rdma.c          |  4 ++--
 drivers/nvme/target/core.c        |  9 ++++---
 drivers/nvme/target/loop.c        |  4 ++--
 fs/block_dev.c                    | 49 +++++++++++++++++++++++++--------------
 fs/direct-io.c                    |  3 +--
 include/linux/bio.h               |  4 +---
 include/linux/genhd.h             |  4 +++-
 include/uapi/linux/blktrace_api.h |  2 +-
 32 files changed, 145 insertions(+), 82 deletions(-)

-- 
Jens Axboe
