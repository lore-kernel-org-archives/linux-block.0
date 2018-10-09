Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35476 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbeJIS3l (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Oct 2018 14:29:41 -0400
Received: by mail-pf1-f194.google.com with SMTP id l17-v6so683118pff.2
        for <linux-block@vger.kernel.org>; Tue, 09 Oct 2018 04:13:14 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 00/45] lightnvm updates for 4.20.
Date: Tue,  9 Oct 2018 13:11:30 +0200
Message-Id: <20181009111215.7653-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Jens,

Please pick up the following patches for 4.20.

The changes include:

 - pblk trace support from Hans.
 - SPDX license header update from Javier.
 - Tons of refactoring patches from Javier, and me to cleanly abstract
   the 1.2 and 2.0 specs behind a common core interface.
 - Enable pblk to use a common interface to retrieve chunk metadata.
   From me.
 - Bug fixes from Hans, Javier, Jia-ju, Wei, Zhoujie, and me.

Thanks!,
Matias

Hans Holmberg (11):
  lightnvm: introduce nvm_rq_to_ppa_list
  lightnvm: pblk: allocate line map bitmaps using a mempool
  lightnvm: pblk: remove unused parameters in pblk_up_rq
  lightnvm: pblk: fix up prints in pblk_read_check_rand
  lightnvm: pblk: fix write amplificiation calculation
  lightnvm: pblk: add trace events for chunk states
  lightnvm: pblk: add trace events for line state changes
  lightnvm: pblk: add trace events for pblk state changes
  lightnvm: pblk: add tracing for chunk resets
  lightnvm: pblk: stop recreating global caches
  lightnvm: pblk: fix mapping issue on failed writes

Javier González (21):
  lightnvm: pblk: fix race condition on metadata I/O
  lightnvm: pblk: add helpers for chunk addresses
  lightnvm: pblk: improve line helpers
  lightnvm: pblk: fix comment typo
  lightnvm: pblk: remove unused variable.
  lightnvm: pblk: guarantee emeta on line close
  lightnvm: move ppa transformations to core
  lightnvm: pblk: calculate line pad distance in helper
  lightnvm: use internal allocation for chunk log page
  lightnvm: pblk: encapsulate rqd dma allocations
  lightnvm: pblk: refactor metadata paths
  lightnvm: pblk: take write semaphore on metadata
  lightnvm: pblk: recover open lines on 2.0 devices
  lightnvm: pblk: add SPDX license tag
  lightnvm: pblk: fix race on sysfs line state
  lightnvm: pblk: remove unused function
  lightnvm: pblk: encapsulate rb pointer operations
  lightnvm: pblk: move ring buffer alloc/free rb init
  lightnvm: pblk: guarantee mw_cunits on read buffer
  lightnvm: do no update csecs and sos on 1.2
  lightnvm: pblk: guarantee that backpointer is respected on writer
    stall

Jia-Ju Bai (1):
  lightnvm: pblk: fix two sleep-in-atomic-context bugs

Matias Bjørling (10):
  lightnvm: remove dependencies on BLK_DEV_NVME and PCI
  lightnvm: combine 1.2 and 2.0 command flags
  lightnvm: pblk: fix rqd.error return value in pblk_blk_erase_sync
  lightnvm: move device L2P detection to core
  lightnvm: move bad block and chunk state logic to core
  lightnvm: pblk: unify vector max req constants
  lightnvm: pblk: fix incorrect min_write_pgs
  lightnvm: pblk: remove size and out of bounds read check
  lightnvm: pblk: refactor put line fn on read completion
  lightnvm: pblk: remove debug from pblk_[down/up]_page

Wei Yongjun (1):
  lightnvm: pblk: fix error handling of pblk_lines_init()

Zhoujie Wu (1):
  lightnvm: pblk: consider max hw sectors supported for max_write_pgs

 drivers/lightnvm/Kconfig         |   3 +-
 drivers/lightnvm/core.c          | 334 ++++++++++++++----
 drivers/lightnvm/pblk-cache.c    |   1 +
 drivers/lightnvm/pblk-core.c     | 589 +++++++++++++++++--------------
 drivers/lightnvm/pblk-gc.c       |  11 +-
 drivers/lightnvm/pblk-init.c     | 321 +++++++----------
 drivers/lightnvm/pblk-map.c      |  13 +-
 drivers/lightnvm/pblk-rb.c       | 110 +++---
 drivers/lightnvm/pblk-read.c     |  86 ++---
 drivers/lightnvm/pblk-recovery.c | 477 +++++++++----------------
 drivers/lightnvm/pblk-rl.c       |   5 +-
 drivers/lightnvm/pblk-sysfs.c    |  12 +-
 drivers/lightnvm/pblk-trace.h    | 145 ++++++++
 drivers/lightnvm/pblk-write.c    |  90 ++---
 drivers/lightnvm/pblk.h          | 225 ++++--------
 drivers/nvme/host/lightnvm.c     |  32 +-
 include/linux/lightnvm.h         | 166 ++++++++-
 17 files changed, 1436 insertions(+), 1184 deletions(-)
 create mode 100644 drivers/lightnvm/pblk-trace.h

-- 
2.17.1
