Return-Path: <axboe@kernel.dk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 4.18
Message-ID: <f0440942-489d-a448-54da-942f0329e8aa@kernel.dk>
Date: Fri, 27 Jul 2018 13:37:02 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Linus,

Bigger than usual at this time, mostly due to the O_DIRECT corruption
issue and the fact that I was on vacation last week. This pull request
contains:

- NVMe pull request with 2 fixes for the FC code, and 2 target
  fixes (Christoph).

- A DIF bio reset iteration fix (Greg Edwards).

- Two nbd reply and requeue fixes (Josef).

- SCSI timeout fixup (Keith).

- Small series that fixes an issue with bio_iov_iter_get_pages(), which
  ended up causing corruption for larger sized O_DIRECT writes that
  ended up racing with buffered writes (Martin Wilck).

Please pull!


  git://git.kernel.dk/linux-block.git tags/for-linus-20180727


----------------------------------------------------------------
Greg Edwards (1):
      block: reset bi_iter.bi_done after splitting bio

Hannes Reinecke (2):
      nvmet: fixup crash on NULL device path
      nvmet: only check for filebacking on -ENOTBLK

James Smart (2):
      nvmet-fc: fix target sgl list on large transfers
      nvme: if_ready checks to fail io to deleting controller

Jens Axboe (1):
      Merge branch 'nvme-4.18' of git://git.infradead.org/nvme into for-linus

Josef Bacik (2):
      nbd: don't requeue the same request twice.
      nbd: handle unexpected replies better

Keith Busch (2):
      blk-mq: export setting request completion state
      scsi: set timed out out mq requests to complete

Martin Wilck (3):
      block: bio_iov_iter_get_pages: fix size of last iovec
      blkdev: __blkdev_direct_IO_simple: fix leak in error case
      block: bio_iov_iter_get_pages: pin more pages for multi-segment IOs

 block/bio.c                    | 54 ++++++++++++++++++------
 block/blk-mq.c                 |  4 +-
 drivers/block/nbd.c            | 96 ++++++++++++++++++++++++++++++++++--------
 drivers/nvme/host/fabrics.c    | 10 +++--
 drivers/nvme/host/fabrics.h    |  3 +-
 drivers/nvme/host/fc.c         |  2 +-
 drivers/nvme/host/rdma.c       |  2 +-
 drivers/nvme/target/configfs.c |  9 +++-
 drivers/nvme/target/core.c     |  2 +-
 drivers/nvme/target/fc.c       | 44 +++++++++++++++----
 drivers/nvme/target/loop.c     |  2 +-
 drivers/scsi/scsi_error.c      | 14 ++++++
 fs/block_dev.c                 |  9 ++--
 include/linux/blk-mq.h         | 14 ++++++
 14 files changed, 209 insertions(+), 56 deletions(-)

-- 
Jens Axboe
