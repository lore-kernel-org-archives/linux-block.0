Return-Path: <linux-block-owner@vger.kernel.org>
Received: from gateway31.websitewelcome.com ([192.185.143.40]:51193 "EHLO
        gateway31.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1756164AbcLPToV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Dec 2016 14:44:21 -0500
Received: from cm6.websitewelcome.com (cm6.websitewelcome.com [108.167.139.19])
        by gateway31.websitewelcome.com (Postfix) with ESMTP id 8EBE195B4A
        for <linux-block@vger.kernel.org>; Fri, 16 Dec 2016 12:54:57 -0600 (CST)
From: Stephen Bates <sbates@raithlin.com>
To: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, axboe@fb.com
Cc: sagi@grimberg.me, james_p_freyensee@linux.intel.com,
        jonathan.derrick@intel.com, Stephen Bates <sbates@raithlin.com>
Subject: [PATCH 0/2] nvme: Improvements in sysfs entry for NVMe CMBs
Date: Fri, 16 Dec 2016 11:54:49 -0700
Message-Id: <1481914491-21456-1-git-send-email-sbates@raithlin.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi

This series adds some more verbosity to the NVMe CMB sysfs entry.

Jens I based this off v4.9 because for some reason your for-4.10/block
is missing my original CMB commit (202021c1a63c6)?

Stephen

Stephen Bates (2):
  nvme : Use correct scnprintf in cmb show
  nvme: improve cmb sysfs reporting

 drivers/nvme/host/pci.c | 33 ++++++++++++++++++++++++++++++---
 include/linux/nvme.h    |  8 ++++++++
 2 files changed, 38 insertions(+), 3 deletions(-)

--
2.1.4
