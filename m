Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-bn3nam01on0043.outbound.protection.outlook.com ([104.47.33.43]:32224
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751513AbdAaMRu (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 Jan 2017 07:17:50 -0500
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias@cnexlabs.com>
To: <axboe@fb.com>
CC: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias@cnexlabs.com>
Subject: [PATCH 00/12] lightnvm: 4.11 patches
Date: Tue, 31 Jan 2017 13:17:08 +0100
Message-ID: <20170131121720.10971-1-matias@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Jens,

Here are the patches for the 4.11 window. The following changes have
been made:

 - New ioctls for vectored I/Os. Now liblightnvm is fully supported and
   applications can begin to use the liblightnvm API to integrate with
   Open-Channel SSDs.

 - Merging of the general media manager with the lightnvm core. This
   removes the need to instantiate the media manager before initializing
   targets, and also eliminates the persistent metadata that was used
   by gennvm.

 - Interface cleanups for target implementations. Enables pblk to be
   simplified.

 - Fix memory leak on target creation failure.

 - Clean up end_io() path so that it follows the same approach as bio
   structures to end ios.

Please pick up.

-Matias

Javier González (3):
  lightnvm: Add CRC read error
  lightnvm: free properly on target creation error
  lightnvm: allow targets to use sysfs

Matias Bjørling (9):
  lightnvm: merge gennvm with core
  lightnvm: collapse nvm_erase_ppa and nvm_erase_blk
  lightnvm: remove nvm_submit_ppa* functions
  lightnvm: remove nvm_get_bb_tbl and nvm_set_bb_tbl
  lightnvm: make nvm_map_* return void
  lightnvm: cleanup nvm transformation functions
  lightnvm: reduce number of nvm_id groups to one
  lightnvm: add ioctls for vector I/Os
  lightnvm: use end_io callback instead of instance

 drivers/block/null_blk.c      |    6 +-
 drivers/lightnvm/Kconfig      |    9 -
 drivers/lightnvm/Makefile     |    3 +-
 drivers/lightnvm/core.c       | 1024 ++++++++++++++++++++++++-----------------
 drivers/lightnvm/gennvm.c     |  657 --------------------------
 drivers/lightnvm/gennvm.h     |   62 ---
 drivers/lightnvm/rrpc.c       |    7 +-
 drivers/lightnvm/rrpc.h       |    3 -
 drivers/lightnvm/sysblk.c     |  733 -----------------------------
 drivers/nvme/host/core.c      |    4 +
 drivers/nvme/host/lightnvm.c  |  317 +++++++++++--
 drivers/nvme/host/nvme.h      |    6 +
 include/linux/lightnvm.h      |  138 +-----
 include/uapi/linux/lightnvm.h |   50 ++
 14 files changed, 965 insertions(+), 2054 deletions(-)
 delete mode 100644 drivers/lightnvm/gennvm.c
 delete mode 100644 drivers/lightnvm/gennvm.h
 delete mode 100644 drivers/lightnvm/sysblk.c

-- 
2.9.3

