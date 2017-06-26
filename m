Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:35989 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751574AbdFZJ6Q (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Jun 2017 05:58:16 -0400
Received: by mail-wm0-f46.google.com with SMTP id 62so2853172wmw.1
        for <linux-block@vger.kernel.org>; Mon, 26 Jun 2017 02:58:16 -0700 (PDT)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
To: mb@lightnvm.io, axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH 00/20] LightNVM: pblk patches for 4.13
Date: Mon, 26 Jun 2017 11:57:09 +0200
Message-Id: <1498471049-25505-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Matias,

Here you have the pblk patchset for this window.

Apart from small fixes for LightNVM core and pblk, there are three
relevant changes:

 - Metadata for each line is no longer issued on a separate workqueue,
   but instead, all I/Os are scheduled on the write thread. This allows
   to have more control over LUN collisions. The result is that we can
   use the full bandwidth of the device for user data. In the 4.12 pblk,
   we use ~25% of the bandwidth for metadata.

 - The rate-limiter and GC have been tuned to keep the GC writer busy.
   Also, capacity per line is guaranteed for GC I/O as we reach
   capacity.

 - We have now a FTL state machine. This allows to fail gracefully to
   user space in case of irrecoverable errors. This state machine will
   be the base for the pblk's FTL log.

The patches apply into your for-4.13/core. You can also find them in:

  https://github.com/OpenChannelSSD/linux.git pblk.for-4.13

Thanks,
Javier

Javier González (20):
  lightnvm: re-convert ppa format on I/O failure
  lightnvm: propagate right error code to target
  lightnvm: pblk: spare double cpu_to_le64 calc.
  lightnvm: pblk: add debug stat for read cache hits
  lightnvm: pblk: expose max sec per write on sysfs
  lightnvm: pblk: generalize erase path
  lightnvm: pblk: rename read request pool
  lightnvm: pblk: sched. metadata on write thread
  lightnvm: pblk: delete redundant debug line stat
  lightnvm: pblk: delete redundant buffer pointer
  lightnvm: pblk: issue multiplane reads if possible
  lightnvm: pblk: simplify meta. memory allocation
  lightnvm: pblk: decouple bad block from line alloc
  lightnvm: pblk: choose optimal victim GC line
  lightnvm: pblk: set metadata list for all I/Os
  lightnvm: pblk: cleanup unnecessary code
  lightnvm: pblk: add lock assertions on helpers
  lightnvm: pblk: redesign GC algorithm
  lightnvm: pblk: set mempool and workqueue params.
  lightnvm: pblk: fail gracefully on irrec. error

 drivers/lightnvm/core.c          |   8 +-
 drivers/lightnvm/pblk-cache.c    |   8 +-
 drivers/lightnvm/pblk-core.c     | 606 ++++++++++++++++++++++++++-------------
 drivers/lightnvm/pblk-gc.c       | 488 ++++++++++++++++++-------------
 drivers/lightnvm/pblk-init.c     | 358 ++++++++++++++---------
 drivers/lightnvm/pblk-map.c      |  73 +++--
 drivers/lightnvm/pblk-rb.c       |  79 +++--
 drivers/lightnvm/pblk-read.c     |  82 +++---
 drivers/lightnvm/pblk-recovery.c | 130 +++++----
 drivers/lightnvm/pblk-rl.c       |  88 ++++--
 drivers/lightnvm/pblk-sysfs.c    | 114 ++++----
 drivers/lightnvm/pblk-write.c    | 350 +++++++++++++++++-----
 drivers/lightnvm/pblk.h          | 275 +++++++++++++-----
 drivers/nvme/host/lightnvm.c     |   2 +-
 14 files changed, 1763 insertions(+), 898 deletions(-)

-- 
2.7.4
