Return-Path: <axboe@kernel.dk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 4.15-rc
Message-ID: <fd786646-141c-c7d1-e7eb-f33f698bf2f2@kernel.dk>
Date: Thu, 21 Dec 2017 10:53:15 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Linus,

It's been a few weeks, so here's a small collection of fixes that
should go into the current series.

This pull request contains:

- NVMe pull request from Christoph, with a few important fixes.

- kyber hang fix from Omar.

- A blk-throttl fix from Shaohua, fixing a case where we double charge
  a bio.

- Two call_single_data alignment fixes from me, fixing up some unfortunate
  changes that went into 4.14 without being properly reviewed on the
  block side (since nobody was CC'ed on the patch...).

- A bounce buffer fix in two parts, one from me and one from Ming.

- Revert bdi debug error handling patch. It's causing boot issues for some
  folks, and a week down the line, we're still no closer to a fix. Revert
  this patch for now until it's figured out, then we can retry for 4.16.

Please pull!


  git://git.kernel.dk/linux-block.git for-linus


----------------------------------------------------------------
David Disseldorp (1):
      nvme: set discard_alignment to zero

James Smart (1):
      nvme-fc: remove double put reference if admin connect fails

Jens Axboe (5):
      Merge branch 'nvme-4.15' of git://git.infradead.org/nvme into for-linus
      block: fix blk_rq_append_bio
      block: unalign call_single_data in struct request
      null_blk: unalign call_single_data
      Revert "bdi: add error handle for bdi_debug_register"

Keith Busch (2):
      nvme: check hw sectors before setting chunk sectors
      nvme: setup streams after initializing namespace head

Ming Lei (2):
      nvme: call blk_integrity_unregister after queue is cleaned up
      block: don't let passthrough IO go into .make_request_fn()

Omar Sandoval (1):
      kyber: fix another domain token wait queue hang

Shaohua Li (1):
      block-throttle: avoid double charge

 block/bio.c                        |  2 ++
 block/blk-map.c                    | 38 ++++++++++++++++++++++----------------
 block/blk-throttle.c               |  8 +-------
 block/bounce.c                     |  6 ++++--
 block/kyber-iosched.c              | 37 ++++++++++++++++++++++++-------------
 drivers/block/null_blk.c           |  4 ++--
 drivers/nvme/host/core.c           | 11 ++++++-----
 drivers/nvme/host/fc.c             |  1 -
 drivers/scsi/osd/osd_initiator.c   |  4 +++-
 drivers/target/target_core_pscsi.c |  4 ++--
 include/linux/bio.h                |  2 ++
 include/linux/blk_types.h          |  9 ++++-----
 include/linux/blkdev.h             | 25 +++++++++++++++++++++----
 mm/backing-dev.c                   |  5 +----
 14 files changed, 94 insertions(+), 62 deletions(-)

-- 
Jens Axboe
