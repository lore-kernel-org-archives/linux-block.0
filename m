Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:40065 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755842AbdLTRWO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Dec 2017 12:22:14 -0500
Received: by mail-wm0-f65.google.com with SMTP id f206so11103963wmf.5
        for <linux-block@vger.kernel.org>; Wed, 20 Dec 2017 09:22:14 -0800 (PST)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
To: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
Subject: [PATCH 00/25] Updates to lightnvm and pblk
Date: Wed, 20 Dec 2017 18:21:40 +0100
Message-Id: <20171220172205.26464-1-m@bjorling.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi,

A bunch of patches for the lightnvm subsystem and pblk.

The first part is preparation patches for the 2.0 revision of the
specification. This includes removing the null_blk implementation
and killing the rrpc implementation, which used already deprecated
definitions from the 1.2 revision. Then a couple of patches of
general clean up and then finally provide a path to support both
the 1.2 and 2.0 revisions simultaneously.

The second part is fixes for the lightnvm subsystem, pblk, and
new features that include ioctl support for instantiating pblk
with specific overprovisioning percentage and adding iostat
support.

-Matias

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
 drivers/nvme/host/lightnvm.c     |  137 +---
 include/linux/lightnvm.h         |  120 +--
 include/uapi/linux/lightnvm.h    |    9 +
 21 files changed, 586 insertions(+), 2918 deletions(-)
 delete mode 100644 drivers/lightnvm/rrpc.c
 delete mode 100644 drivers/lightnvm/rrpc.h

-- 
2.9.3
