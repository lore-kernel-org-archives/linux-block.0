Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:45127 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752110AbeDXFpr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Apr 2018 01:45:47 -0400
Received: by mail-wr0-f196.google.com with SMTP id p5-v6so19273322wre.12
        for <linux-block@vger.kernel.org>; Mon, 23 Apr 2018 22:45:46 -0700 (PDT)
From: Hans Holmberg <hans.ml.holmberg@owltronix.com>
To: Matias Bjorling <mb@lightnvm.io>
Cc: linux-block@vger.kernel.org, Javier Gonzales <javier@cnexlabs.com>,
        linux-kernel@vger.kernel.org,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Subject: [PATCH v2 0/3] Rework write error handling in pblk
Date: Tue, 24 Apr 2018 08:45:29 +0300
Message-Id: <1524548732-4326-1-git-send-email-hans.ml.holmberg@owltronix.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Hans Holmberg <hans.holmberg@cnexlabs.com>

This patch series fixes the(currently incomplete) write error handling 
in pblk by:

 * queuing and re-submitting failed writes in the write buffer
 * evacuating valid data data in lines with write failures, so the
   chunk(s) with write failures can be reset to a known state by the fw

Lines with failures in smeta are put back on the free list.
Failed chunks will be reset on the next use.

If a write failes in emeta, the lba list is cached so the line can be 
garbage collected without scanning the out-of-band area.

Changes in V2:
- Added the recov_writes counter increase to the new path
- Moved lba list emeta reading during gc to a separate function
- Allocating the saved lba list with pblk_malloc instead of kmalloc
- Fixed formatting issues
- Removed dead code

Hans Holmberg (3):
  lightnvm: pblk: rework write error recovery path
  lightnvm: pblk: garbage collect lines with failed writes
  lightnvm: pblk: fix smeta write error path

 drivers/lightnvm/pblk-core.c     |  52 +++++++-
 drivers/lightnvm/pblk-gc.c       | 102 +++++++++------
 drivers/lightnvm/pblk-init.c     |  47 ++++---
 drivers/lightnvm/pblk-rb.c       |  39 ------
 drivers/lightnvm/pblk-recovery.c |  91 -------------
 drivers/lightnvm/pblk-rl.c       |  29 ++++-
 drivers/lightnvm/pblk-sysfs.c    |  15 ++-
 drivers/lightnvm/pblk-write.c    | 269 ++++++++++++++++++++++++++-------------
 drivers/lightnvm/pblk.h          |  36 ++++--
 9 files changed, 384 insertions(+), 296 deletions(-)

-- 
2.7.4
