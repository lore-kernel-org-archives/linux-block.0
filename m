Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wj0-f195.google.com ([209.85.210.195]:34527 "EHLO
        mail-wj0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750742AbdAWMAU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Jan 2017 07:00:20 -0500
Received: by mail-wj0-f195.google.com with SMTP id ip10so1729274wjb.1
        for <linux-block@vger.kernel.org>; Mon, 23 Jan 2017 03:59:43 -0800 (PST)
From: "=?UTF-8?q?Matias=20Bj=C3=B8rling?=" <m@bjorling.me>
To: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias@cnexlabs.com>
Subject: [PATCH 0/8] lightnvm: cleanups and support for vector ioctls
Date: Mon, 23 Jan 2017 12:59:11 +0100
Message-Id: <20170123115919.14339-1-matias@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

A couple of patches. The first seven patches is cleanup patches, that
cleans up the codebase for when pblk is added to the kernel, and
prepare the code such that a device can be used as a normal block device
(as long as the access rules are respected).

The last patch adds ioctls for vectored I/Os, which enables liblightnvm
to integrate without any kernel modifications.

-Matias

Matias Bjørling (8):
  lightnvm: merge gennvm with core
  lightnvm: collapse nvm_erase_ppa and nvm_erase_blk
  lightnvm: remove nvm_submit_ppa* functions
  lightnvm: remove nvm_get_bb_tbl and nvm_set_bb_tbl
  lightnvm: make nvm_map_* return void
  lightnvm: cleanup nvm transformation functions
  lightnvm: reduce number of nvm_id groups to one
  lightnvm: add ioctls for vector I/Os

 drivers/block/null_blk.c      |    3 +-
 drivers/lightnvm/Kconfig      |    9 -
 drivers/lightnvm/Makefile     |    3 +-
 drivers/lightnvm/core.c       | 1016 ++++++++++++++++++++++++-----------------
 drivers/lightnvm/gennvm.c     |  657 --------------------------
 drivers/lightnvm/gennvm.h     |   62 ---
 drivers/lightnvm/sysblk.c     |  733 -----------------------------
 drivers/nvme/host/core.c      |    4 +
 drivers/nvme/host/lightnvm.c  |  314 +++++++++++--
 drivers/nvme/host/nvme.h      |    6 +
 include/linux/lightnvm.h      |  121 +----
 include/uapi/linux/lightnvm.h |   50 ++
 12 files changed, 940 insertions(+), 2038 deletions(-)
 delete mode 100644 drivers/lightnvm/gennvm.c
 delete mode 100644 drivers/lightnvm/gennvm.h
 delete mode 100644 drivers/lightnvm/sysblk.c

-- 
2.7.4

