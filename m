Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:52901 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932327AbeB0P5p (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Feb 2018 10:57:45 -0500
Received: by mail-wm0-f41.google.com with SMTP id t3so25032717wmc.2
        for <linux-block@vger.kernel.org>; Tue, 27 Feb 2018 07:57:44 -0800 (PST)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
To: mb@lightnvm.io
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH V4] lightnvm: simplify geometry structure
Date: Tue, 27 Feb 2018 16:57:11 +0100
Message-Id: <1519747032-25704-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Sending this separately as it seems to be the controversial one.

# Changes since V3
>From Matias:
  - Remove nvm_common_geo
  - Do appropriate renames when having a single geometry for device and
    targets

Javier

Javier González (1):
  lightnvm: simplify geometry structure.

 drivers/lightnvm/core.c          | 114 +++++--------
 drivers/lightnvm/pblk-core.c     |  16 +-
 drivers/lightnvm/pblk-gc.c       |   2 +-
 drivers/lightnvm/pblk-init.c     | 123 +++++++-------
 drivers/lightnvm/pblk-read.c     |   2 +-
 drivers/lightnvm/pblk-recovery.c |  14 +-
 drivers/lightnvm/pblk-rl.c       |   2 +-
 drivers/lightnvm/pblk-sysfs.c    |  39 +++--
 drivers/lightnvm/pblk-write.c    |   2 +-
 drivers/lightnvm/pblk.h          |  93 +++++------
 drivers/nvme/host/lightnvm.c     | 344 +++++++++++++++++++++++----------------
 include/linux/lightnvm.h         | 202 ++++++++++++-----------
 12 files changed, 501 insertions(+), 452 deletions(-)

-- 
2.7.4
