Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34199 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753284AbcK1Vji (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Nov 2016 16:39:38 -0500
Received: by mail-wm0-f68.google.com with SMTP id g23so21318568wme.1
        for <linux-block@vger.kernel.org>; Mon, 28 Nov 2016 13:39:37 -0800 (PST)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
To: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: axboe@fb.com, =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
Subject: [PATCH 00/23] LightNVM patches for 4.10
Date: Mon, 28 Nov 2016 22:38:51 +0100
Message-Id: <20161128213914.12516-1-m@bjorling.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Jens,

A bunch of patches for 4.10 have been prepared.

Javier has been busy eliminating abstractions in the LightNVM
interface. Mainly killing generic nvm_block and nvm_lun, which
simplifies the locking mechanism within targets. He also added a couple
of new hints and error codes that are useful for the hardware.

I have a small fix to fix a wrong free, and also a larger patch that
attaches the sysfs entries added in 4.9 to attach to the native nvme
gendisk.


With these patches, the pblk target is ready to be upstreamed. If
nothing comes along to delay it, we will push it in the next cycle.

Please pick up.

Thanks,
Matias

Javier González (21):
  lightnvm: enable to send hint to erase command
  lightnvm: do not protect block 0
  lightnvm: export set bad block table
  lightnvm: add ECC error codes
  lightnvm: rrpc: split bios of size > 256kb
  lightnvm: remove sysfs configuration interface
  lightnvm: cleanup unused target operations
  lightnvm: make address conversion functions global
  lightnvm: remove unnecessary variables in rrpc
  lightnvm: use constant name instead of value
  lightnvm: remove gen_lun abstraction
  lightnvm: manage lun partitions internally in mm
  lightnvm: move block provisioning to targets
  lightnvm: remove get_lun operation on gennvm
  lightnvm: remove debug lun statistics from gennvm
  lightnvm: eliminate nvm_block abstraction on mm
  lightnvm: eliminate nvm_lun abstraction in mm
  lightnvm: introduce helpers for generic ops in rrpc
  lightnvm: introduce max_phys_sects helper function
  lightnvm: use target nvm on target-specific ops.
  lightnvm: transform target get/set bad block

Matias Bjørling (2):
  nvme: lightnvm: frees wrong cmd structure
  nvme: lightnvm: attach lightnvm sysfs to nvme block device

 drivers/lightnvm/Makefile    |   2 +-
 drivers/lightnvm/core.c      | 375 +++++++++++-------------
 drivers/lightnvm/gennvm.c    | 663 +++++++++++++++++++++----------------------
 drivers/lightnvm/gennvm.h    |  34 ++-
 drivers/lightnvm/lightnvm.h  |  35 ---
 drivers/lightnvm/rrpc.c      | 514 +++++++++++++++++++++------------
 drivers/lightnvm/rrpc.h      |  65 ++++-
 drivers/lightnvm/sysblk.c    |  98 +++----
 drivers/lightnvm/sysfs.c     | 198 -------------
 drivers/nvme/host/core.c     |  45 ++-
 drivers/nvme/host/lightnvm.c | 192 ++++++++++++-
 drivers/nvme/host/nvme.h     |  31 +-
 include/linux/lightnvm.h     | 244 ++++++++--------
 13 files changed, 1278 insertions(+), 1218 deletions(-)
 delete mode 100644 drivers/lightnvm/lightnvm.h
 delete mode 100644 drivers/lightnvm/sysfs.c

-- 
2.9.3

