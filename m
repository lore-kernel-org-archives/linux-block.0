Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:38545 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752707AbcKROn6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Nov 2016 09:43:58 -0500
Received: by mail-wm0-f51.google.com with SMTP id f82so41993709wmf.1
        for <linux-block@vger.kernel.org>; Fri, 18 Nov 2016 06:43:57 -0800 (PST)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
To: mb@lightnvm.io
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH 00/20] lightnvm: simplify media manager
Date: Fri, 18 Nov 2016 15:43:22 +0100
Message-Id: <1479480222-18790-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

This patchset simplifies the generic media manager interface and moves
lun and block functionality to lightnvm targets. This makes that
rrpc-specific functionality is not exposed on the media manager. This is
done in preparation for the pblk target.

Matias: patches 0 - 4 have been posted before. Patches apply to you
for-4.10/core

Javier González (20):
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

 drivers/lightnvm/core.c      | 306 ++++++++------------
 drivers/lightnvm/gennvm.c    | 664 ++++++++++++++++++++-----------------------
 drivers/lightnvm/gennvm.h    |  34 ++-
 drivers/lightnvm/rrpc.c      | 512 +++++++++++++++++++++------------
 drivers/lightnvm/rrpc.h      |  65 ++++-
 drivers/lightnvm/sysblk.c    |  98 +++----
 drivers/nvme/host/lightnvm.c |  15 +-
 include/linux/lightnvm.h     | 231 +++++++--------
 8 files changed, 1005 insertions(+), 920 deletions(-)

-- 
2.7.4

