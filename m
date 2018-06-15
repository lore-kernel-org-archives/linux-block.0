Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:32452 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756429AbeFOW1S (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Jun 2018 18:27:18 -0400
From: Igor Konopko <igor.j.konopko@intel.com>
To: mb@lightnvm.io, javier@cnexlabs.com
Cc: linux-block@vger.kernel.org, michal.sorn@intel.com,
        marcin.dziegielewski@intel.com, igor.j.konopko@intel.com
Subject: [PATCH 0/5] lightnvm: More flexible approach to metadata
Date: Sat, 16 Jun 2018 00:27:01 +0200
Message-Id: <20180615222706.3801-1-igor.j.konopko@intel.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

This series of patches introduce some more flexibility in pblk
related to OOB meta:
-ability to use different sizes of metadata (previously fixed 16b)
-ability to use pblk on drives without metadata
-ensuring that extended (interleaved) metadata is not in use

I belive that most of this patches, maybe except of number 4 (Support
for packed metadata) are rather simple, so waiting for comments
especially about this one.

Igor Konopko (5):
  lightnvm: pblk: Helpers for OOB metadata
  lightnvm: pblk: Remove resv field for sec meta
  lightnvm: Flexible DMA pool entry size
  lightnvm: pblk: Support for packed metadata in pblk.
  lightnvm: pblk: Disable interleaved metadata in pblk

 drivers/lightnvm/core.c          | 33 ++++++++++-----
 drivers/lightnvm/pblk-core.c     | 86 +++++++++++++++++++++++++++++++---------
 drivers/lightnvm/pblk-init.c     | 52 +++++++++++++++++++++++-
 drivers/lightnvm/pblk-map.c      | 21 ++++++----
 drivers/lightnvm/pblk-rb.c       |  3 ++
 drivers/lightnvm/pblk-read.c     | 85 +++++++++++++++++++++++++--------------
 drivers/lightnvm/pblk-recovery.c | 67 +++++++++++++++++++++----------
 drivers/lightnvm/pblk-sysfs.c    |  7 ++++
 drivers/lightnvm/pblk-write.c    | 22 ++++++----
 drivers/lightnvm/pblk.h          | 46 +++++++++++++++++++--
 drivers/nvme/host/lightnvm.c     |  7 +++-
 include/linux/lightnvm.h         |  9 +++--
 12 files changed, 333 insertions(+), 105 deletions(-)

-- 
2.14.3
