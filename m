Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wj0-f179.google.com ([209.85.210.179]:34967 "EHLO
        mail-wj0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753810AbcKUMRZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Nov 2016 07:17:25 -0500
Received: by mail-wj0-f179.google.com with SMTP id v7so25864622wjy.2
        for <linux-block@vger.kernel.org>; Mon, 21 Nov 2016 04:17:25 -0800 (PST)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
To: mb@lightnvm.io
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH 0/8] lightnvm: simplify media manager V2
Date: Mon, 21 Nov 2016 13:10:29 +0100
Message-Id: <1479730237-20797-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

V2:
  - Fix 2 bad memory free on error rrpc init error handling. Reported by
    kbuild.

This patchset simplifies the generic media manager interface and moves
lun and block functionality to lightnvm targets. This makes that
rrpc-specific functionality is not exposed on the media manager. This is
done in preparation for the pblk target.

Javier González (8):
  lightnvm: move block provisioning to targets
  lightnvm: remove get_lun operation on gennvm
  lightnvm: remove debug lun statistics from gennvm
  lightnvm: eliminate nvm_block abstraction on mm
  lightnvm: eliminate nvm_lun abstraction in mm
  lightnvm: introduce helpers for generic ops in rrpc
  lightnvm: introduce max_phys_sects helper function
  lightnvm: use target nvm on target-specific ops.

 drivers/lightnvm/core.c      | 154 ++++++-----
 drivers/lightnvm/gennvm.c    | 612 ++++++++++++++++++++-----------------------
 drivers/lightnvm/gennvm.h    |  20 +-
 drivers/lightnvm/rrpc.c      | 443 +++++++++++++++++++++----------
 drivers/lightnvm/rrpc.h      |  62 ++++-
 drivers/lightnvm/sysblk.c    |  65 +++--
 drivers/nvme/host/lightnvm.c |  14 +-
 include/linux/lightnvm.h     | 217 +++++++--------
 8 files changed, 885 insertions(+), 702 deletions(-)

-- 
2.7.4

