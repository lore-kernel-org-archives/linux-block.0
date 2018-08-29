Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39163 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727316AbeH2Q2N (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Aug 2018 12:28:13 -0400
Received: by mail-ed1-f67.google.com with SMTP id h4-v6so3795437edi.6
        for <linux-block@vger.kernel.org>; Wed, 29 Aug 2018 05:31:30 -0700 (PDT)
From: Hans Holmberg <hans.ml.holmberg@owltronix.com>
To: Matias Bjorling <mb@lightnvm.io>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Javier Gonzales <javier@cnexlabs.com>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Subject: [PATCH 0/4] Introduce trace events for pblk
Date: Wed, 29 Aug 2018 14:31:13 +0200
Message-Id: <1535545877-770-1-git-send-email-hans.ml.holmberg@owltronix.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Hans Holmberg <hans.holmberg@cnexlabs.com>

This patchset adds trace events for tracking the internal state of
pblk. I've used the events extensively the last few months, and
they have proven very useful.

The patches depend on some of Javier's for-4.20 patches.
For ordering, see:

Branch: for-4.20/pblk
Remote: ssh://github.com/OpenChannelSSD/linux

Hans Holmberg (4):
  lightnvm: pblk: add trace events for chunk states
  lightnvm: pblk: add trace events for line state changes
  lightnvm: pblk: add trace events for pblk state changes
  lightnvm: pblk: add tracing for chunk resets

 drivers/lightnvm/pblk-core.c     |  69 ++++++++++++++++++-
 drivers/lightnvm/pblk-gc.c       |   8 +++
 drivers/lightnvm/pblk-init.c     |   8 +++
 drivers/lightnvm/pblk-recovery.c |   6 ++
 drivers/lightnvm/pblk-trace.h    | 145 +++++++++++++++++++++++++++++++++++++++
 drivers/lightnvm/pblk-write.c    |  10 ++-
 drivers/lightnvm/pblk.h          |  14 ++++
 7 files changed, 256 insertions(+), 4 deletions(-)
 create mode 100644 drivers/lightnvm/pblk-trace.h

-- 
2.7.4
