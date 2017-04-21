Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:38735 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1426665AbdDUXdB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Apr 2017 19:33:01 -0400
Received: by mail-wm0-f50.google.com with SMTP id r190so27942476wme.1
        for <linux-block@vger.kernel.org>; Fri, 21 Apr 2017 16:33:01 -0700 (PDT)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
To: mb@lightnvm.io
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH 0/5] lightnvm: pblk extra patches for 4.12
Date: Sat, 22 Apr 2017 01:32:44 +0200
Message-Id: <1492817569-13532-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Matias,

This is a couple of bug fixes for the pblk release patch.

Thanks,
Javier

Javier González (5):
  lightnvm: pblk: fix race condition on line retry
  lightnvm: pblk: fix bad error check
  lightnvm: pblk: fix memory leak on error path
  lightnvm: pblk: free metadata on line alloc failure
  lightnvm: pblk: fix erase counters on error fail

 drivers/lightnvm/pblk-core.c  | 60 ++++++++++++++++++++++++++-----------------
 drivers/lightnvm/pblk-gc.c    |  2 +-
 drivers/lightnvm/pblk-init.c  |  9 ++++---
 drivers/lightnvm/pblk-map.c   |  4 +--
 drivers/lightnvm/pblk-rl.c    |  6 +++--
 drivers/lightnvm/pblk-write.c |  7 +++--
 drivers/lightnvm/pblk.h       |  6 ++---
 7 files changed, 57 insertions(+), 37 deletions(-)

-- 
2.7.4
