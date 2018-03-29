Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:41299 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752201AbeC2WHA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Mar 2018 18:07:00 -0400
Received: by mail-lf0-f68.google.com with SMTP id o102-v6so10323549lfg.8
        for <linux-block@vger.kernel.org>; Thu, 29 Mar 2018 15:07:00 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        keith.busch@intel.com, javier@cnexlabs.com,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 00/37] lightnvm patches for 4.17
Date: Fri, 30 Mar 2018 00:04:47 +0200
Message-Id: <20180329220524.30363-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Jens,

Here is a bunch of patches for 4.17. They include:

 - Open-Channel 2.0 support by Javier and I.
 - Lots of refactoring patches to enable 2.0 support.
 - Fixes to pblk from Hans, Markus, and Dan.
 - Introduction of write amplication and padding counters. From Hans.
 - Fix from Johannes to unify the permission checks for the lightnvm
   ioctls.
 - Fixes from Heiner for bad block initialization and
   over-provisioning validation.

Please pick up when convenient.

-Matias

Dan Carpenter (1):
  lightnvm: pblk: remove some unnecessary NULL checks

Hans Holmberg (8):
  lightnvm: pblk: handle bad sectors in the emeta area correctly
  lightnvm: pblk: check data lines version on recovery
  lightnvm: pblk: export write amplification counters to sysfs
  lightnvm: pblk: add padding distribution sysfs attribute
  lightnvm: pblk: delete writer kick timer before stopping thread
  lightnvm: pblk: allow allocation of new lines during shutdown
  lightnvm: pblk: prevent race in pblk_rb_flush_point_set
  lightnvm: pblk: don't recover unwritten lines

Heiner Litz (2):
  lightnvm: fix bad block initialization
  lightnvm: Avoid validation of default op value

Javier González (14):
  lightnvm: pblk: refactor bad block identification
  lightnvm: pblk: refactor init/exit sequences
  lightnvm: simplify geometry structure
  lightnvm: add minor version to generic geometry
  lightnvm: add shorten OCSSD version in geo
  lightnvm: complete geo structure with maxoc*
  lightnvm: normalize geometry nomenclature
  lightnvm: add support for 2.0 address format
  lightnvm: make address conversions depend on generic device
  lightnvm: implement get log report chunk helpers
  lightnvm: pblk: check for supported version
  lightnvm: pblk: rename ppaf* to addrf*
  lightnvm: pblk: implement get log report chunk
  lightnvm: pblk: implement 2.0 support

Johannes Thumshirn (1):
  lightnvm: centralize permission check for lightnvm ioctl

Markus Elfring (1):
  lightnvm/pblk-gc: Delete an error message for a failed memory
    allocation in pblk_gc_line_prepare_ws()

Matias Bjørling (10):
  lightnvm: remove chnl_offset in nvme_nvm_identity
  lightnvm: remove mlc pairs structure
  lightnvm: remove multiple groups in 1.2 data structure
  lightnvm: make 1.2 data structures explicit
  lightnvm: flatten nvm_id_group into nvm_id
  lightnvm: add 2.0 geometry identification
  lightnvm: remove max_rq_size
  lightnvm: remove nvm_dev_ops->max_phys_sect
  nvme: lightnvm: add late setup of block size and metadata
  lightnvm: remove function name in strings

 drivers/lightnvm/core.c          | 238 +++++------
 drivers/lightnvm/pblk-cache.c    |   4 +
 drivers/lightnvm/pblk-core.c     | 202 +++++++---
 drivers/lightnvm/pblk-gc.c       |  12 +-
 drivers/lightnvm/pblk-init.c     | 850 +++++++++++++++++++++++----------------
 drivers/lightnvm/pblk-map.c      |   6 +-
 drivers/lightnvm/pblk-rb.c       |  21 +-
 drivers/lightnvm/pblk-read.c     |   2 +-
 drivers/lightnvm/pblk-recovery.c |  91 ++++-
 drivers/lightnvm/pblk-rl.c       |   2 +-
 drivers/lightnvm/pblk-sysfs.c    | 235 +++++++++--
 drivers/lightnvm/pblk-write.c    |   2 +-
 drivers/lightnvm/pblk.h          | 304 ++++++++++----
 drivers/nvme/host/core.c         |   6 +-
 drivers/nvme/host/lightnvm.c     | 747 ++++++++++++++++++++++++++--------
 drivers/nvme/host/nvme.h         |   2 +
 include/linux/lightnvm.h         | 338 ++++++++++------
 17 files changed, 2090 insertions(+), 972 deletions(-)

-- 
2.11.0
