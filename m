Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:45055 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751746AbdJCKGu (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 Oct 2017 06:06:50 -0400
Received: by mail-wm0-f46.google.com with SMTP id 196so5454422wma.1
        for <linux-block@vger.kernel.org>; Tue, 03 Oct 2017 03:06:49 -0700 (PDT)
From: Hans Holmberg <hans.ml.holmberg@owltronix.com>
To: Matias Bjorling <mb@lightnvm.io>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Javier Gonzales <jg@lightnvm.io>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Subject: [PATCH 0/9] recovery robustness improvements
Date: Tue,  3 Oct 2017 12:05:04 +0200
Message-Id: <1507025113-13351-1-git-send-email-hans.ml.holmberg@owltronix.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Hans Holmberg <hans.holmberg@cnexlabs.com>

This patchset improves the robustness of recovery - fixing a bunch of
issues that occurs when removing and re-creating a pblk instance.
It also adds a couple of debug-only prints to facilitate detection
of L2P table corruptions.

The patches apply on top of:
https://github.com/OpenChannelSSD/linux branch for-4.15/pblk

Hans Holmberg (9):
  lightnvm: pblk: prevent gc kicks when gc is not operational
  lightnvm: pblk: recover partially written lines correctly
  lightnvm: pblk: free full lines during recovery
  lightnvm: pblk: start gc if needed during init
  lightnvm: pblk: consider bad sectors in emeta during recovery
  lightnvm: pblk: shut down gc gracefully during exit
  lightnvm: pblk: add l2p crc debug printouts
  lightnvm: pblk: gc all lines in the pipeline before exit
  lightnvm: pblk: correct valid lba count calculation

 drivers/lightnvm/pblk-core.c     |  3 ++
 drivers/lightnvm/pblk-gc.c       | 88 +++++++++++++++++++++++++++-------------
 drivers/lightnvm/pblk-init.c     | 47 ++++++++++++++++++---
 drivers/lightnvm/pblk-map.c      |  7 ++--
 drivers/lightnvm/pblk-recovery.c | 46 ++++++++++++++-------
 drivers/lightnvm/pblk-sysfs.c    |  2 +-
 drivers/lightnvm/pblk.h          |  6 ++-
 7 files changed, 145 insertions(+), 54 deletions(-)

-- 
2.7.4
