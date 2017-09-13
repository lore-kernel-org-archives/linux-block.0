Return-Path: <axboe@kernel.dk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Follow up block fixes for 4.14-rc1
Message-ID: <fb92792d-5a62-9058-627c-0f9ddd90457f@kernel.dk>
Date: Wed, 13 Sep 2017 08:12:05 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Linus,

Small collection of fixes that would be nice to have in -rc1. This pull
request contains:

- NVMe pull request form Christoph, mostly with fixes for nvme-pci,
  host memory buffer in particular.

- Error handling fixup for cgwb_create(), in case allocation of 'wb'
  fails. From Christophe JAILLET.

- Ensure that trace_block_getrq() gets the 'dev' in an appropriate
  fashion, to avoid a potential NULL deref. From Greg Thelen.

- Regression fix for dm-mq with blk-mq, fixing a problem with stacking
  IO schedulers. From me.

- string.h fixup, fixing an issue with memcpy_and_pad(). This original
  change came in through an NVMe dependency, which is why I'm including
  it here. From Martin Wilck.

- Fix potential int overflow in __blkdev_sectors_to_bio_pages(), from
  Mikulas.

- MBR enable fix for sed-opal, from Scott.

Please pull!


  git://git.kernel.dk/linux-block.git for-linus


----------------------------------------------------------------
Akinobu Mita (1):
      nvme-pci: use appropriate initial chunk size for HMB allocation

Christoph Hellwig (4):
      nvme: fix lightnvm check
      nvme-pci: fix host memory buffer allocation fallback
      nvme-pci: propagate (some) errors from host memory buffer setup
      nvme-pci: implement the HMB entry number and size limitations

Christophe JAILLET (1):
      mm/backing-dev.c: fix an error handling path in 'cgwb_create()'

Greg Thelen (1):
      block: tolerate tracing of NULL bio

Jens Axboe (2):
      Merge branch 'nvme-4.14' of git://git.infradead.org/nvme into for-linus
      block: directly insert blk-mq request from blk_insert_cloned_request()

Martin Wilck (1):
      string.h: un-fortify memcpy_and_pad

Mikulas Patocka (1):
      block: fix integer overflow in __blkdev_sectors_to_bio_pages()

Scott Bauer (1):
      block: sed-opal: Set MBRDone on S3 resume path if TPER is MBREnabled

 block/blk-core.c             |  7 ++++-
 block/blk-lib.c              |  4 +--
 block/blk-mq.c               | 16 ++++++++++
 block/blk-mq.h               |  1 +
 block/opal_proto.h           |  1 +
 block/sed-opal.c             | 32 +++++++++++++++++++
 drivers/nvme/host/core.c     | 11 ++++---
 drivers/nvme/host/lightnvm.c | 26 ----------------
 drivers/nvme/host/nvme.h     | 13 +++++---
 drivers/nvme/host/pci.c      | 74 ++++++++++++++++++++++++++++++--------------
 include/linux/nvme.h         |  4 ++-
 include/linux/string.h       | 15 ++-------
 include/trace/events/block.h |  5 ++-
 mm/backing-dev.c             |  6 ++--
 14 files changed, 134 insertions(+), 81 deletions(-)

-- 
Jens Axboe
