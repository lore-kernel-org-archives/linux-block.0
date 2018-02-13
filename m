Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:55114 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964915AbeBMOGR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Feb 2018 09:06:17 -0500
Received: by mail-wm0-f68.google.com with SMTP id i186so16232795wmi.4
        for <linux-block@vger.kernel.org>; Tue, 13 Feb 2018 06:06:17 -0800 (PST)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
To: mb@lightnvm.io
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH 0/8] lightnvm: pblk: implement support for 2.0
Date: Tue, 13 Feb 2018 15:06:00 +0100
Message-Id: <1518530768-20956-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

This patchset implements support for 2.0 spec in pblk.

The first patch abstracts the geometry retrieved from the identify
command and allows both specs to coexist under the same geometry
description. From there on, we build the missing 2.0 support in lightnvm
core: address format, address conversion and report chnk get log page.
The last three patches implement the actual support for 2.0 in pblk.

Note that we only port functionality for 2.0. Newer functionality
enabled by 2.0 (e.g., wear-leveling) will be submitted in following
patches.

This patches apply on top of Matias' latest patches.

Javier González (8):
  lightnvm: exposed generic geometry to targets
  lightnvm: show generic geometry in sysfs
  lightnvm: add support for 2.0 address format
  lightnvm: convert address based on spec. version
  lightnvm: implement get log report chunk helpers
  lightnvm: pblk: implement get log report chunk
  lightnvm: pblk: refactor init/exit sequences
  lightnvm: pblk: implement 2.0 support

 drivers/lightnvm/core.c          | 171 ++++-----
 drivers/lightnvm/pblk-core.c     | 134 +++++--
 drivers/lightnvm/pblk-gc.c       |   2 +-
 drivers/lightnvm/pblk-init.c     | 787 +++++++++++++++++++++++----------------
 drivers/lightnvm/pblk-read.c     |   2 +-
 drivers/lightnvm/pblk-recovery.c |  14 +-
 drivers/lightnvm/pblk-rl.c       |   2 +-
 drivers/lightnvm/pblk-sysfs.c    | 130 ++++++-
 drivers/lightnvm/pblk-write.c    |   2 +-
 drivers/lightnvm/pblk.h          | 253 +++++++++----
 drivers/nvme/host/lightnvm.c     | 553 ++++++++++++++++++---------
 include/linux/lightnvm.h         | 317 ++++++++++------
 12 files changed, 1553 insertions(+), 814 deletions(-)

-- 
2.7.4
