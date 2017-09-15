Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:43228 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751226AbdIOMZo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Sep 2017 08:25:44 -0400
Received: by mail-wm0-f46.google.com with SMTP id a137so2572851wma.0
        for <linux-block@vger.kernel.org>; Fri, 15 Sep 2017 05:25:44 -0700 (PDT)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
To: linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH 00/11] lightnvm: pblk: cleanup
Date: Fri, 15 Sep 2017 14:25:28 +0200
Message-Id: <1505478339-13089-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

This patchset is a general cleanup to improve code readability.

Javier González (11):
  lightnvm: pblk: use constant for GC max inflight
  lightnvm: pblk: normalize ppa namings
  lightnvm: pblk: refactor read lba sanity check
  lightnvm: pblk: simplify data validity check on GC
  lightnvm: pblk: refactor read path on GC
  lightnvm: pblk: put bio on bio completion
  lightnvm: pblk: simplify path on REQ_PREFLUSH
  lightnvm: pblk: allocate bio size more accurately
  lightnvm: pblk: improve naming for internal req.
  lightnvm: pblk: refactor rqd alloc/free
  lightnvm: pblk: use rqd->end_io for completion

 drivers/lightnvm/pblk-cache.c    |  24 +++---
 drivers/lightnvm/pblk-core.c     | 156 +++++++++++++++++++++------------------
 drivers/lightnvm/pblk-gc.c       | 134 ++++++++++++++++-----------------
 drivers/lightnvm/pblk-rb.c       |  19 ++---
 drivers/lightnvm/pblk-read.c     | 122 +++++++++++++++---------------
 drivers/lightnvm/pblk-recovery.c |  15 ++--
 drivers/lightnvm/pblk-write.c    |  49 +++++-------
 drivers/lightnvm/pblk.h          |  44 +++++------
 8 files changed, 271 insertions(+), 292 deletions(-)

-- 
2.7.4
