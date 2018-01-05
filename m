Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:39385 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751278AbeAENQk (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 5 Jan 2018 08:16:40 -0500
Received: by mail-wm0-f65.google.com with SMTP id i11so2417423wmf.4
        for <linux-block@vger.kernel.org>; Fri, 05 Jan 2018 05:16:39 -0800 (PST)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
Subject: [GIT PULL 00/25] LightNVM updates for 4.16
Date: Fri,  5 Jan 2018 14:15:56 +0100
Message-Id: <20180105131621.20808-1-m@bjorling.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Jens,

Here is a couple of patches for 4.16.

This patchset prepares the lightnvm and pblk source code for the 2.0
specification release. The specification is close to its final
revision. After these changes, 2.0 support is a quick drop.

While adopting 2.0 specification, the rrpc and null_blk
implementation had to go. rrpc used the deprecated device-side
table mapping table API for the 1.2 specification, and there are
no users of it. Similarly, null_blk has not worked with pblk for
a while.

Javier and Hans have been hard at work at fixing up bugs in pblk,
especially concerning synchronization points between user I/O and GC
I/O. While also fixing bugs that occurred on bringup/bringdown.

They also added support for iostats and added an option to add
support for defining the amount of over-provisioning an instance
should have.

Please pull from the for-4.16/for-jens branch or apply the patches
posted with this patchset.

    https://github.com/OpenChannelSSD/linux.git for-4.16/for-jens

Thanks,
Matias

Hans Holmberg (5):
  lightnvm: pblk: refactor emeta consistency check
  lightnvm: pblk: rename sync_point to flush_point
  lightnvm: pblk: clear flush point on completed writes
  lightnvm: pblk: prevent premature sync point resets
  lightnvm: pblk: remove pblk_gc_stop

Javier González (13):
  lightnvm: remove unnecessary field from nvm_rq
  lightnvm: refactor target type lookup
  lightnvm: guarantee target unique name across devs.
  lightnvm: pblk: compress and reorder helper functions
  lightnvm: pblk: remove pblk_for_each_lun helper
  lightnvm: pblk: use exact free block counter in RL
  lightnvm: set target over-provision on create ioctl
  lightnvm: pblk: ignore high ecc errors on recovery
  lightnvm: pblk: do not log recovery read errors
  lightnvm: pblk: ensure kthread alloc. before kicking it
  lightnvm: pblk: free write buffer on init failure
  lightnvm: pblk: print instance name on instance info
  lightnvm: pblk: add iostat support

Matias Bjørling (7):
  null_blk: remove lightnvm support
  lightnvm: remove rrpc
  lightnvm: use internal pblk methods
  lightnvm: remove hybrid ocssd 1.2 support
  lightnvm: remove lower page tables
  lightnvm: make geometry structures 2.0 ready
  lightnvm: pblk: refactor pblk_ppa_comp function

 drivers/block/null_blk.c         |  220 +-----
 drivers/lightnvm/Kconfig         |    7 -
 drivers/lightnvm/Makefile        |    1 -
 drivers/lightnvm/core.c          |  460 ++++-------
 drivers/lightnvm/pblk-cache.c    |    5 +
 drivers/lightnvm/pblk-core.c     |   55 +-
 drivers/lightnvm/pblk-gc.c       |   23 +-
 drivers/lightnvm/pblk-init.c     |  104 ++-
 drivers/lightnvm/pblk-map.c      |    2 +-
 drivers/lightnvm/pblk-rb.c       |  111 ++-
 drivers/lightnvm/pblk-read.c     |   35 +-
 drivers/lightnvm/pblk-recovery.c |   43 +-
 drivers/lightnvm/pblk-rl.c       |   54 +-
 drivers/lightnvm/pblk-sysfs.c    |   15 +-
 drivers/lightnvm/pblk-write.c    |   23 +-
 drivers/lightnvm/pblk.h          |  165 ++--
 drivers/lightnvm/rrpc.c          | 1625 --------------------------------------
 drivers/lightnvm/rrpc.h          |  290 -------
 drivers/nvme/host/lightnvm.c     |  173 +---
 include/linux/lightnvm.h         |  125 +--
 include/uapi/linux/lightnvm.h    |    9 +
 21 files changed, 595 insertions(+), 2950 deletions(-)
 delete mode 100644 drivers/lightnvm/rrpc.c
 delete mode 100644 drivers/lightnvm/rrpc.h

-- 
2.9.3
