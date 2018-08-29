Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39562 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727444AbeH2QUc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Aug 2018 12:20:32 -0400
Received: by mail-ed1-f67.google.com with SMTP id h4-v6so3778260edi.6
        for <linux-block@vger.kernel.org>; Wed, 29 Aug 2018 05:23:52 -0700 (PDT)
From: Hans Holmberg <hans.ml.holmberg@owltronix.com>
To: Matias Bjorling <mb@lightnvm.io>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Javier Gonzales <javier@cnexlabs.com>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Subject: [PATCH 0/7] pblk fixes
Date: Wed, 29 Aug 2018 14:23:27 +0200
Message-Id: <1535545414-550-1-git-send-email-hans.ml.holmberg@owltronix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Hans Holmberg <hans.holmberg@cnexlabs.com>

This patchset contains a bunch of cleanups and bugfixes for 4.20.
The patches depend on some of Javier's for-4.20 patches.

For ordering, see:

Branch: for-4.20/pblk
Remote: ssh://github.com/OpenChannelSSD/linux

Hans Holmberg (7):
  lightnvm: introduce nvm_rq_to_ppa_list
  lightnvm: pblk: fix mapping issue on failed writes
  lightnvm: pblk: allocate line map bitmaps using a mempool
  lightnvm: pblk: move global caches to module init/exit
  lightnvm: pblk: remove unused parameters in pblk_up_rq
  lightnvm: pblk: fix up prints in pblk_read_check_rand
  lightnvm: pblk: fix write amplificiation calculation

 drivers/lightnvm/core.c          | 14 +++------
 drivers/lightnvm/pblk-core.c     | 25 +++++++++------
 drivers/lightnvm/pblk-init.c     | 60 ++++++++++++++++++++++-------------
 drivers/lightnvm/pblk-map.c      | 10 +++---
 drivers/lightnvm/pblk-read.c     | 13 +++-----
 drivers/lightnvm/pblk-recovery.c | 11 ++++---
 drivers/lightnvm/pblk-sysfs.c    |  3 +-
 drivers/lightnvm/pblk-write.c    | 68 +++++++++++++++++++++++++++-------------
 drivers/lightnvm/pblk.h          | 11 ++++---
 include/linux/lightnvm.h         |  5 +++
 10 files changed, 134 insertions(+), 86 deletions(-)

-- 
2.7.4
