Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pa0-f68.google.com ([209.85.220.68]:34516 "EHLO
        mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758555AbcIPMZ1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Sep 2016 08:25:27 -0400
Received: by mail-pa0-f68.google.com with SMTP id vz6so3449914pab.1
        for <linux-block@vger.kernel.org>; Fri, 16 Sep 2016 05:25:26 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
To: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        axboe@fb.com
Cc: keith.busch@intel.com,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
Subject: [GIT PULL 0/7] LightNVM pull request for 4.9
Date: Fri, 16 Sep 2016 14:25:02 +0200
Message-Id: <1474028709-30260-1-git-send-email-m@bjorling.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Jens,

A couple of patches for 4.9. We are preparing the pblk target for
upstream, but it will have to wait for at least a cycle before it is
ready.

Geert and Arnd sent two fixes. One check for DMA and another for missing
a device_add check.

Simon added sysfs support to LightNVM. It allows the user to inspect the
geometry of a device through sysfs. As NVMe device driver integrates
with blk-mq, it also exposes the blk-mq sysfs structure.

I added a couple of plumbing patches to enable sysfs. It mainly
refactors nvme and null_blk to take control over nvm_dev and replaces
the gendisk parameter in blk_mq_(un)register_disk() with device and the
associated request queue.

Please pick up.

The patches are available here:

  https://github.com/OpenChannelSSD/linux.git for-jens

Thank you,
Matias

Arnd Bergmann (1):
  lightnvm: propagate device_add() error code

Geert Uytterhoeven (1):
  lightnvm: NVM should depend on HAS_DMA

Matias Bjørling (4):
  nvme: refactor namespaces to support non-gendisk devices
  null_blk: refactor to support non-gendisk devices
  blk-mq: register device instead of disk
  lightnvm: control life of nvm_dev in driver

Simon A. F. Lund (1):
  lightnvm: expose device geometry through sysfs

 block/blk-mq-sysfs.c         |  17 ++--
 block/blk-sysfs.c            |   4 +-
 drivers/block/null_blk.c     | 128 +++++++++++++++++-----------
 drivers/lightnvm/Kconfig     |   2 +-
 drivers/lightnvm/Makefile    |   2 +-
 drivers/lightnvm/core.c      |  55 +++++-------
 drivers/lightnvm/lightnvm.h  |  35 ++++++++
 drivers/lightnvm/sysfs.c     | 198 +++++++++++++++++++++++++++++++++++++++++++
 drivers/md/dm-rq.c           |   2 +-
 drivers/nvme/host/core.c     | 149 +++++++++++++++++++-------------
 drivers/nvme/host/lightnvm.c |  33 ++++++--
 drivers/nvme/host/nvme.h     |  26 ++++--
 include/linux/blk-mq.h       |   4 +-
 include/linux/lightnvm.h     |  18 ++--
 14 files changed, 498 insertions(+), 175 deletions(-)
 create mode 100644 drivers/lightnvm/lightnvm.h
 create mode 100644 drivers/lightnvm/sysfs.c

-- 
2.1.4

