Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wr0-f171.google.com ([209.85.128.171]:34324 "EHLO
        mail-wr0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751445AbdBYQxI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 25 Feb 2017 11:53:08 -0500
Received: by mail-wr0-f171.google.com with SMTP id o22so24722826wro.1
        for <linux-block@vger.kernel.org>; Sat, 25 Feb 2017 08:53:07 -0800 (PST)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
To: mb@lightnvm.io
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [RFC PATCH v2] lightnvm: pblk
Date: Sat, 25 Feb 2017 17:53:00 +0100
Message-Id: <1488041581-17379-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

This patch introduces pblk, a new target for LightNVM implementing a
full host-based FTL. Details on the commit message.

Changes since v1:
* Rebase on top of Matias' for-4.12/core
* Move from per-LUN block allocation to a line model. This means that a
  whole lines across all LUNs is allocated at a time. Data is still
  stripped in a round-robin fashion at a page granurality.
* Implement new disk format scheme, where metadata is stored per line
  instead of per LUN. This allows for space optimizations.
* Improvements on GC workqueue management and victim selection.
* Implement sysfs interface to query pblk's operation and statistics.
* Implement a user - GC I/O rate-limiter
* Various bug fixes

Javier González (1):
  lightnvm: physical block device (pblk) target

 Documentation/lightnvm/pblk.txt  |   21 +
 drivers/lightnvm/Kconfig         |   18 +
 drivers/lightnvm/Makefile        |    5 +
 drivers/lightnvm/pblk-cache.c    |  119 +++
 drivers/lightnvm/pblk-core.c     | 1539 ++++++++++++++++++++++++++++++++++++++
 drivers/lightnvm/pblk-gc.c       |  401 ++++++++++
 drivers/lightnvm/pblk-init.c     |  937 +++++++++++++++++++++++
 drivers/lightnvm/pblk-map.c      |  146 ++++
 drivers/lightnvm/pblk-rb.c       |  857 +++++++++++++++++++++
 drivers/lightnvm/pblk-read.c     |  512 +++++++++++++
 drivers/lightnvm/pblk-recovery.c |  142 ++++
 drivers/lightnvm/pblk-rl.c       |  219 ++++++
 drivers/lightnvm/pblk-sysfs.c    |  947 +++++++++++++++++++++++
 drivers/lightnvm/pblk-write.c    |  407 ++++++++++
 drivers/lightnvm/pblk.h          |  958 ++++++++++++++++++++++++
 15 files changed, 7228 insertions(+)
 create mode 100644 Documentation/lightnvm/pblk.txt
 create mode 100644 drivers/lightnvm/pblk-cache.c
 create mode 100644 drivers/lightnvm/pblk-core.c
 create mode 100644 drivers/lightnvm/pblk-gc.c
 create mode 100644 drivers/lightnvm/pblk-init.c
 create mode 100644 drivers/lightnvm/pblk-map.c
 create mode 100644 drivers/lightnvm/pblk-rb.c
 create mode 100644 drivers/lightnvm/pblk-read.c
 create mode 100644 drivers/lightnvm/pblk-recovery.c
 create mode 100644 drivers/lightnvm/pblk-rl.c
 create mode 100644 drivers/lightnvm/pblk-sysfs.c
 create mode 100644 drivers/lightnvm/pblk-write.c
 create mode 100644 drivers/lightnvm/pblk.h

-- 
2.7.4
