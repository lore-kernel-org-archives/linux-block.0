Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35215 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751685AbcKRLjG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Nov 2016 06:39:06 -0500
Received: by mail-wm0-f67.google.com with SMTP id a20so5275114wme.2
        for <linux-block@vger.kernel.org>; Fri, 18 Nov 2016 03:39:06 -0800 (PST)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
To: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: axboe@fb.com, keith.busch@intel.com,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
Subject: [PATCH 0/2] nvme: lightnvm: fix and wire up
Date: Fri, 18 Nov 2016 12:38:12 +0100
Message-Id: <1479469094-1337-1-git-send-email-m@bjorling.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi all,

The first patch is a small fix to the freeing of the cmd structure in
lightnvm, and the second patch wires up the lightnvm sysfs interface to
the nvme gendisk.

-Matias

Matias Bjørling (2):
  nvme: lightnvm: frees wrong cmd structure
  nvme: lightnvm: attach lightnvm sysfs to nvme block device

 drivers/lightnvm/Makefile    |   2 +-
 drivers/lightnvm/core.c      |  15 +---
 drivers/lightnvm/lightnvm.h  |  35 --------
 drivers/lightnvm/sysfs.c     | 198 -------------------------------------------
 drivers/nvme/host/core.c     |  45 +++++-----
 drivers/nvme/host/lightnvm.c | 177 +++++++++++++++++++++++++++++++++++---
 drivers/nvme/host/nvme.h     |  31 +++----
 include/linux/lightnvm.h     |   2 -
 8 files changed, 202 insertions(+), 303 deletions(-)
 delete mode 100644 drivers/lightnvm/lightnvm.h
 delete mode 100644 drivers/lightnvm/sysfs.c

-- 
2.1.4

