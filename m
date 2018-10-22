Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga12.intel.com ([192.55.52.136]:43133 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728388AbeJVS6G (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Oct 2018 14:58:06 -0400
From: Igor Konopko <igor.j.konopko@intel.com>
To: mb@lightnvm.io, javier@cnexlabs.com, hans.ml.holmberg@owltronix.com
Cc: linux-block@vger.kernel.org, igor.j.konopko@intel.com
Subject: [PATCH v2 0/5] lightnvm: Flexible metadata
Date: Mon, 22 Oct 2018 12:36:06 +0200
Message-Id: <20181022103611.39271-1-igor.j.konopko@intel.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

This series of patches extends the way how pblk can
store L2P sector metadata. After this set of changes
any size of NVMe metadata (including 0) is supported.

Patches are rebased on top of block/for-next since
there was no ocssd/for-4.21 branch yet.

Changes v1 --> v2:
-Revert sector meta size back to 16b for pblk
-Dma pool for larger oob meta are handled in core instead of pblk
-Pblk oob meta helpers uses __le64 as input outpu instead of u64
-Other minor fixes based on v1 patch review

Igor Konopko (5):
  lightnvm: pblk: Move lba list to partial read context
  lightnvm: pblk: Helpers for OOB metadata
  lightnvm: Flexible DMA pool entry size
  lightnvm: Disable interleaved metadata
  lightnvm: pblk: Support for packed metadata

 drivers/lightnvm/core.c          | 45 +++++++++++++++++++++++----
 drivers/lightnvm/pblk-core.c     | 66 ++++++++++++++++++++++++++++++++++------
 drivers/lightnvm/pblk-init.c     | 43 ++++++++++++++++++++++++--
 drivers/lightnvm/pblk-map.c      | 20 +++++++-----
 drivers/lightnvm/pblk-rb.c       |  3 ++
 drivers/lightnvm/pblk-read.c     | 63 +++++++++++++++++++++-----------------
 drivers/lightnvm/pblk-recovery.c | 22 ++++++++------
 drivers/lightnvm/pblk-sysfs.c    |  7 +++++
 drivers/lightnvm/pblk-write.c    | 14 ++++++---
 drivers/lightnvm/pblk.h          | 47 ++++++++++++++++++++++++++--
 drivers/nvme/host/lightnvm.c     |  9 ++++--
 include/linux/lightnvm.h         |  5 ++-
 12 files changed, 272 insertions(+), 72 deletions(-)

-- 
2.14.4
