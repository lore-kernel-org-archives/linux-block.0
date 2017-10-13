Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:51260 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753258AbdJMMrH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Oct 2017 08:47:07 -0400
Received: by mail-wm0-f66.google.com with SMTP id f4so21572146wme.0
        for <linux-block@vger.kernel.org>; Fri, 13 Oct 2017 05:47:07 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
Subject: [GIT PULL 00/58] LightNVM updates for 4.15
Date: Fri, 13 Oct 2017 14:45:49 +0200
Message-Id: <20171013124647.32668-1-m@bjorling.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Jens,

A couple of patches for 4.15.

Javier has improved garbage collection, statistics, memory pool usage,
and added support for single LUN configurations. He also made a lot of
bug fixes and cleanup patches.

Rakesh have been fixing up a lot of subsystem bugs with respect to
loading and unloading pblk, cleanup of memory pools, and a couple of
fixes spread across the lightnvm subsystem and pblk.

Hans has been looking into garbage collection, and shutting it
down gracefully when pblk is unloaded.

Please pull from the for-4.15/for-jens branch or apply the patches
posted with this thread:

   https://github.com/OpenChannelSSD/linux.git for-4.15/for-jens

Thanks,
Matias

Hans Holmberg (10):
  lightnvm: pblk: prevent gc kicks when gc is not operational
  lightnvm: pblk: recover partially written lines correctly
  lightnvm: pblk: free full lines during recovery
  lightnvm: pblk: start gc if needed during init
  lightnvm: pblk: consider bad sectors in emeta during recovery
  lightnvm: pblk: shut down gc gracefully during exit
  lightnvm: pblk: add l2p crc debug printouts
  lightnvm: pblk: gc all lines in the pipeline before exit
  lightnvm: pblk: correct valid lba count calculation
  lightnvm: pblk: remove spinlock when freeing line metadata

Javier González (31):
  lightnvm: pblk: initialize debug stat counter
  lightnvm: pblk: use right flag for GC allocation
  lightnvm: pblk: free padded entries in write buffer
  lightnvm: pblk: fix write I/O sync stat
  lightnvm: pblk: avoid deadlock on low LUN config
  lightnvm: pblk: fix min size for page mempool
  lightnvm: pblk: simplify work_queue mempool
  lightnvm: pblk: decouple read/erase mempools
  lightnvm: pblk: do not use a mempool for line bitmaps
  lightnvm: pblk: remove checks on mempool alloc.
  lightnvm: pblk: use constant for GC max inflight
  lightnvm: pblk: normalize ppa namings
  lightnvm: pblk: refactor read lba sanity check
  lightnvm: pblk: simplify data validity check on GC
  lightnvm: pblk: refactor read path on GC
  lightnvm: pblk: put bio on bio completion
  lightnvm: pblk: simplify path on REQ_PREFLUSH
  lightnvm: pblk: allocate bio size more accurately
  lightnvm: pblk: improve naming for internal req.
  lightnvm: pblk: refactor rqd alloc/free
  lightnvm: pblk: use rqd->end_io for completion
  lightnvm: pblk: check lba sanity on read path
  lightnvm: pblk: guarantee line integrity on reads
  lightnvm: pblk: remove redundant check on read path
  lightnvm: pblk: remove I/O dependency on write path
  lightnvm: pblk: enable 1 LUN configuration
  lightnvm: pblk: ensure right bad block calculation
  lightnvm: pblk: cleanup unused and static functions
  lightnvm: pblk: avoid being reported as hung on rated GC
  lightnvm: fail fast on passthrough commands
  lightnvm: implement generic path for sync I/O

Rakesh Pandit (17):
  lightnvm: prevent target type module removal when in use
  lightnvm: prevent bd removal if busy
  lightnvm: protect target type list with correct locks
  lightnvm: remove already calculated nr_chnls
  lightnvm: pblk: fix error path in pblk_lines_alloc_metadata
  lightnvm: include NVM Express driver if OCSSD is selected for build
  lightnvm: pblk: protect line bitmap while submitting meta io
  lightnvm: pblk: fix message if L2P MAP is in device
  lightnvm: pblk: improve error message if down_timeout fails
  lightnvm: pblk: print incompatible line version correctly
  lightnvm: pblk: reuse pblk_gc_should_kick
  lightnvm: pblk: fix changing GC group list for a line
  lightnvm: pblk: remove useless line
  lightnvm: remove unused argument from nvm_set_tgt_bb_tbl
  lightnvm: remove stale extern and unused exported symbols
  lightnvm: pblk: reduce arguments in __pblk_rb_update_l2p
  lightnvm: pblk: fix releases of kmem cache in error path

 drivers/lightnvm/Kconfig         |   3 +-
 drivers/lightnvm/core.c          | 190 +++++++-------
 drivers/lightnvm/pblk-cache.c    |  24 +-
 drivers/lightnvm/pblk-core.c     | 516 ++++++++++++++++++++-------------------
 drivers/lightnvm/pblk-gc.c       | 311 ++++++++++++-----------
 drivers/lightnvm/pblk-init.c     | 197 +++++++++------
 drivers/lightnvm/pblk-map.c      |  28 ++-
 drivers/lightnvm/pblk-rb.c       |  30 +--
 drivers/lightnvm/pblk-read.c     | 274 ++++++++++++---------
 drivers/lightnvm/pblk-recovery.c | 131 ++++------
 drivers/lightnvm/pblk-rl.c       |  43 +---
 drivers/lightnvm/pblk-sysfs.c    |   2 +-
 drivers/lightnvm/pblk-write.c    | 229 +++++++----------
 drivers/lightnvm/pblk.h          | 137 +++++++----
 drivers/nvme/host/lightnvm.c     |  72 ++++--
 include/linux/lightnvm.h         |  11 +-
 16 files changed, 1172 insertions(+), 1026 deletions(-)

-- 
2.9.3
