Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:4640 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727701AbeJEUhA (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 5 Oct 2018 16:37:00 -0400
From: Igor Konopko <igor.j.konopko@intel.com>
To: mb@lightnvm.io, javier@cnexlabs.com
Cc: linux-block@vger.kernel.org, marcin.dziegielewski@intel.com,
        igor.j.konopko@intel.com
Subject: [PATCH 0/5] lightnvm: pblk: Flexible metadata
Date: Fri,  5 Oct 2018 15:34:32 +0200
Message-Id: <20181005133437.25255-1-igor.j.konopko@intel.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

This series of patches extends the way how pblk can
store L2P sector metadata. After this set of changes
any size of NVMe metadata (including 0) is supported.

Igor Konopko (5):
  lightnvm: pblk: Do not reuse DMA memory on partial read
  lightnvm: pblk: Helpers for OOB metadata
  lightnvm: Flexible DMA pool entry size
  lightnvm: Disable interleaved metadata
  lightnvm: pblk: Support for packed metadata

 drivers/lightnvm/core.c          | 33 ++++++++++----
 drivers/lightnvm/pblk-core.c     | 77 +++++++++++++++++++++++++-------
 drivers/lightnvm/pblk-init.c     | 54 +++++++++++++++++++++-
 drivers/lightnvm/pblk-map.c      | 21 ++++++---
 drivers/lightnvm/pblk-rb.c       |  3 ++
 drivers/lightnvm/pblk-read.c     | 56 +++++++++++------------
 drivers/lightnvm/pblk-recovery.c | 28 +++++++-----
 drivers/lightnvm/pblk-sysfs.c    |  7 +++
 drivers/lightnvm/pblk-write.c    | 14 ++++--
 drivers/lightnvm/pblk.h          | 55 +++++++++++++++++++++--
 drivers/nvme/host/lightnvm.c     |  7 ++-
 include/linux/lightnvm.h         |  9 ++--
 12 files changed, 278 insertions(+), 86 deletions(-)

-- 
2.17.1
