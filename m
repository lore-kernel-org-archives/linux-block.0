Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:35836 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752074AbdF3P44 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Jun 2017 11:56:56 -0400
Received: by mail-wm0-f52.google.com with SMTP id w126so113901408wme.0
        for <linux-block@vger.kernel.org>; Fri, 30 Jun 2017 08:56:56 -0700 (PDT)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
To: mb@lightnvm.io, axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH 00/10] lightnvm: pblk fixes for 4.13
Date: Fri, 30 Jun 2017 17:56:33 +0200
Message-Id: <1498838203-21539-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Jens,

Here you have a second round of fixes for pblk. They are in essence bug
fixes including a double-free reported by Dan.

There is also regression fix for pblk removal, which was introduced with
the new metadata scheduler. This fix makes that removing a pblk instance
takes again at most 2 seconds.

Finally, I also included a patch for double checking the L2P to verify a
cache hit before reading from the write cache. We have experienced a
database not issuing fsync before reading recently written metadata
triggering a bad cache read. We verified it this week. This patch is an
easy fix that we can make in pblk.

The patches apply on top of your for-4.13/block and can be found at:

   https://github.com/OpenChannelSSD pblk.for-4.13

Please pull.

Thanks,
Javier

Javier González (10):
  lightnvm: pblk: fix bad le64 assignations
  lightnvm: pblk: fix double-free on pblk init
  lightnvm: pblk: remove unused return variable
  lightnvm: pblk: schedule if data is not ready
  lightnvm: pblk: use right metadata buffer for recovery
  lightnvm: pblk: use vmalloc for GC data buffer
  lightnvm: pblk: remove target using async. I/Os
  lightnvm: pblk: add initialization check
  lightnvm: pblk: verify that cache read is still valid
  lightnvm: pblk: set line bitmap check under debug

 drivers/lightnvm/pblk-core.c     |  21 +++--
 drivers/lightnvm/pblk-gc.c       |  11 ++-
 drivers/lightnvm/pblk-init.c     |  17 +++-
 drivers/lightnvm/pblk-map.c      |   2 +-
 drivers/lightnvm/pblk-rb.c       |  27 +++++-
 drivers/lightnvm/pblk-read.c     |   7 +-
 drivers/lightnvm/pblk-recovery.c | 173 ++++++++++++++++++++++-----------------
 drivers/lightnvm/pblk-sysfs.c    |   4 +-
 drivers/lightnvm/pblk-write.c    |   5 +-
 drivers/lightnvm/pblk.h          |  22 ++++-
 10 files changed, 184 insertions(+), 105 deletions(-)

-- 
2.7.4
