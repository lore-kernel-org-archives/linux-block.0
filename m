Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:43503 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753944AbeDSQkK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 Apr 2018 12:40:10 -0400
Received: by mail-lf0-f68.google.com with SMTP id v207-v6so1079218lfa.10
        for <linux-block@vger.kernel.org>; Thu, 19 Apr 2018 09:40:10 -0700 (PDT)
From: Hans Holmberg <hans.ml.holmberg@owltronix.com>
To: Matias Bjorling <mb@lightnvm.io>
Cc: linux-block@vger.kernel.org, Javier Gonzales <javier@cnexlabs.com>,
        linux-kernel@vger.kernel.org,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Subject: [PATCH 0/3] Rework write error handling in pblk
Date: Thu, 19 Apr 2018 18:39:21 +0200
Message-Id: <1524155964-3743-1-git-send-email-hans.ml.holmberg@owltronix.com>
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

Hans Holmberg (3):
  lightnvm: pblk: rework write error recovery path
  lightnvm: pblk: garbage collect lines with failed writes
  lightnvm: pblk: fix smeta write error path

 drivers/lightnvm/pblk-core.c     |  50 +++++++-
 drivers/lightnvm/pblk-gc.c       |  79 ++++++++-----
 drivers/lightnvm/pblk-init.c     |  41 +++++--
 drivers/lightnvm/pblk-recovery.c |  91 ---------------
 drivers/lightnvm/pblk-rl.c       |  29 ++++-
 drivers/lightnvm/pblk-sysfs.c    |  15 ++-
 drivers/lightnvm/pblk-write.c    | 243 ++++++++++++++++++++++++++++-----------
 drivers/lightnvm/pblk.h          |  33 ++++--
 8 files changed, 362 insertions(+), 219 deletions(-)

-- 
2.7.4
