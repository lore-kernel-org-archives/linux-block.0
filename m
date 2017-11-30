Return-Path: <axboe@kernel.dk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 4.15-rc
Message-ID: <ed934de4-4245-a2f9-f04a-7e27ec05a1cb@kernel.dk>
Date: Thu, 30 Nov 2017 14:14:50 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Linus,

A selection of fixes/changes that should make it into this series. This
pull request contains:

- NVMe, two merges, containing:
	- pci-e, rdma, and fc fixes
	- Device quirks

- Fix for a badblocks leak in null_blk

- Pull bcache fixes from Michael Lyle. Most important is a regression
  fix for a case where bcache could return the wrong data in some
  circumstances.

- Regression fix for blktrace for a bug introduced in this series.

- blktrace cleanup for cgroup id.

- bdi registration error handling.

- Small series with cleanups for blk-wbt.

- Various little fixes for typos and the like.

Nothing earth shattering, most important are the NVMe and bcache fixes.

Please pull!


  git://git.kernel.dk/linux-block.git for-linus


----------------------------------------------------------------
Colin Ian King (1):
      nvme: fix spelling mistake: "requeing" -> "requeuing"

David Disseldorp (1):
      null_blk: fix dev->badblocks leak

Huacai Chen (1):
      bcache: Fix building error on MIPS

Israel Rukshin (1):
      nvme-rdma: Use mr pool

James Smart (1):
      nvmet-fc: correct ref counting error when deferred rcv used

Jeff Lien (1):
      nvme-pci: add quirk for delay before CHK RDY for WDC SN200

Jens Axboe (4):
      Merge branch 'nvme-4.15' of git://git.infradead.org/nvme into for-linus
      nvme-fc: don't use bit masks for set/test_bit() numbers
      blktrace: fix trace mutex deadlock
      Merge branch 'nvme-4.15' of git://git.infradead.org/nvme into for-linus

Kai-Heng Feng (1):
      nvme-pci: disable APST on Samsung SSD 960 EVO + ASUS PRIME B350M-A

Keith Busch (2):
      nvme: Fix NULL dereference on reservation request
      nvme: Suppress static analyis warning

Marcos Paulo de Souza (1):
      blktrace: Use blk_trace_bio_get_cgid inside blk_add_trace_bio

Max Gurtovoy (1):
      nvme-rdma: fix memory leak during queue allocation

Michael Lyle (1):
      bcache: check return value of register_shrinker

Mikulas Patocka (1):
      block: remove useless assignment in bio_split

Minwoo Im (2):
      nvme-pci: avoid hmb desc array idx out-of-bound when hmmaxd set.
      nvme-pci: fix NULL pointer dereference in nvme_free_host_mem()

Randy Dunlap (1):
      block: genhd.c: fix message typo

Rui Hua (1):
      bcache: recover data from backing when data is clean

Sagi Grimberg (7):
      nvme-fabrics: introduce init command check for a queue that is not alive
      nvme-fc: check if queue is ready in queue_rq
      nvme-loop: check if queue is ready in queue_rq
      nvme-rdma: don't suppress send completions
      nvme-rdma: don't complete requests before a send work request has completed
      nvme-rdma: wait for local invalidation before completing a request
      nvme-rdma: Check remotely invalidated rkey matches our expected rkey

Tang Junhui (1):
      bcache: add a comment in journal bucket reading

weiping zhang (7):
      bdi: convert bdi_debug_register to int
      bdi: add error handle for bdi_debug_register
      block: add WARN_ON if bdi register fail
      blk-wbt: remove duplicated setting in wbt_init
      blk-sysfs: remove NULL pointer checking in queue_wb_lat_store
      blk-wbt: move wbt_clear_stat to common place in wbt_done
      blk-wbt: fix comments typo

 block/bio.c                   |   2 +-
 block/blk-sysfs.c             |   5 +-
 block/blk-wbt.c               |   7 +-
 block/genhd.c                 |   9 +-
 drivers/block/null_blk.c      |   5 +-
 drivers/md/bcache/alloc.c     |   2 +-
 drivers/md/bcache/btree.c     |   5 +-
 drivers/md/bcache/extents.c   |   2 +-
 drivers/md/bcache/journal.c   |   7 +-
 drivers/md/bcache/request.c   |  13 +--
 drivers/nvme/host/core.c      |  19 ++-
 drivers/nvme/host/fabrics.h   |  30 +++++
 drivers/nvme/host/fc.c        |  21 +++-
 drivers/nvme/host/multipath.c |   2 +-
 drivers/nvme/host/nvme.h      |   2 +-
 drivers/nvme/host/pci.c       |  17 ++-
 drivers/nvme/host/rdma.c      | 266 ++++++++++++++++++++----------------------
 drivers/nvme/target/fc.c      |   9 +-
 drivers/nvme/target/loop.c    |  25 +++-
 include/uapi/linux/bcache.h   |   2 +-
 kernel/trace/blktrace.c       |  30 ++---
 mm/backing-dev.c              |  22 +++-
 22 files changed, 291 insertions(+), 211 deletions(-)

-- 
Jens Axboe
