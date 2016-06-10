Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36040 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752785AbcFJMV3 (ORCPT
	<rfc822;linux-block@vger.kernel.org>);
	Fri, 10 Jun 2016 08:21:29 -0400
Received: by mail-wm0-f65.google.com with SMTP id m124so17504417wme.3
        for <linux-block@vger.kernel.org>; Fri, 10 Jun 2016 05:21:28 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
To: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	axboe@fb.com, keith.busch@intel.com, linux-nvme@lists.infradead.org
Cc: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
Subject: [PATCH 0/6] sysfs support for LightNVM
Date: Fri, 10 Jun 2016 14:20:56 +0200
Message-Id: <1465561262-13789-1-git-send-email-m@bjorling.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Jens and Keith,

If the patches look good to you, would you pick them up through your
tree?

The common way to expose a storage device is to export it through the
gendisk structure, which takes care of handling the visibility lifetime
of the device to user-space and carries device driver and block layer
specific sysfs entries.

For LightNVM, no gendisk is exposed, which hides these entries.

This patchset enables LightNVM to expose a subset of the gendisk entries
by implementing a new non-gendisk device that only exposes the sysfs
entries that are relevant to the device driver and LightNVM. For example
/mq and the NVMe sysfs entries.

The new non-gendisk exposes itself in place of the original gendisk.
Thus, a gendisk device exposed through /sys/class/nvme/nvme0n1, will
still be exposed through the same directory, although only with the /mq,
lightnvm, and nvme specific entries.

The LightNVM storage device can be found through sysfs by searching
for devices that has the "lightnvm" dev type.

v2:
 - Updated "expose gennvm target type" to expose its own kobject, which
   pblk and others can hook into.
 - Fixed missing disk_name in null_blk patch on lightnvm device

Thanks,
Matias

Matias Bjørling (4):
  nvme: refactor namespaces to support non-gendisk devices
  null_blk: refactor to support non-gendisk devices
  blk-mq: register device instead of disk
  lightnvm: let drivers control the lifetime of nvm_dev

Simon A. F. Lund (2):
  lightnvm: expose device geometry through sysfs
  lightnvm: expose gennvm target type through sysfs

 block/blk-mq-sysfs.c         |  13 ++-
 block/blk-sysfs.c            |   4 +-
 drivers/block/null_blk.c     | 128 +++++++++++++++++-----------
 drivers/lightnvm/Makefile    |   2 +-
 drivers/lightnvm/core.c      |  52 +++++-------
 drivers/lightnvm/gennvm.c    | 112 +++++++++++++++++++++----
 drivers/lightnvm/lightnvm.h  |  35 ++++++++
 drivers/lightnvm/sysfs.c     | 195 +++++++++++++++++++++++++++++++++++++++++++
 drivers/md/dm.c              |   2 +-
 drivers/nvme/host/core.c     | 165 ++++++++++++++++++++----------------
 drivers/nvme/host/lightnvm.c |  29 ++++++-
 drivers/nvme/host/nvme.h     |  26 ++++--
 include/linux/blk-mq.h       |   4 +-
 include/linux/lightnvm.h     |  28 +++++--
 14 files changed, 597 insertions(+), 198 deletions(-)
 create mode 100644 drivers/lightnvm/lightnvm.h
 create mode 100644 drivers/lightnvm/sysfs.c

-- 
2.1.4

