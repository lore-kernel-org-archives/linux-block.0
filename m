Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:34846 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755393AbdDGSuZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 Apr 2017 14:50:25 -0400
Received: by mail-wm0-f44.google.com with SMTP id w64so5180724wma.0
        for <linux-block@vger.kernel.org>; Fri, 07 Apr 2017 11:50:24 -0700 (PDT)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
To: mb@lightnvm.io
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH v3] lightnvm: pblk
Date: Fri,  7 Apr 2017 20:50:14 +0200
Message-Id: <1491591015-7554-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

This patch introduces pblk, a new target for LightNVM implementing a
full host-based FTL. Details on the commit message.

Changes since v2:
* Rebase on top of Matias' for-4.12/core
* Implement L2P scan recovery to recover L2P table in case of power
  failure.
* Re-design disk format to be more flexible in future versions (from
  Matias Bjørling)
* Implement per-instance uuid to allow correct recovery without
  forcing line erases (from Matias Bjørling)
* Re-design GC threading to have several GC readers and a single
  writer that places data on the write buffer. This allows to maximize
  the GC write buffer budget without having unnecessary GC writers
  competing for the write buffer lock.
* Simplify sysfs interface.
* Refactoring and several code improvements (together with Matias
  Bjørling)

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
 drivers/lightnvm/Kconfig         |   19 +
 drivers/lightnvm/Makefile        |    5 +
 drivers/lightnvm/pblk-cache.c    |  112 +++
 drivers/lightnvm/pblk-core.c     | 1641 ++++++++++++++++++++++++++++++++++++++
 drivers/lightnvm/pblk-gc.c       |  542 +++++++++++++
 drivers/lightnvm/pblk-init.c     |  942 ++++++++++++++++++++++
 drivers/lightnvm/pblk-map.c      |  135 ++++
 drivers/lightnvm/pblk-rb.c       |  859 ++++++++++++++++++++
 drivers/lightnvm/pblk-read.c     |  513 ++++++++++++
 drivers/lightnvm/pblk-recovery.c | 1007 +++++++++++++++++++++++
 drivers/lightnvm/pblk-rl.c       |  182 +++++
 drivers/lightnvm/pblk-sysfs.c    |  500 ++++++++++++
 drivers/lightnvm/pblk-write.c    |  408 ++++++++++
 drivers/lightnvm/pblk.h          | 1127 ++++++++++++++++++++++++++
 include/linux/lightnvm.h         |   57 +-
 pblk-sysfs.c                     |  581 ++++++++++++++
 17 files changed, 8638 insertions(+), 13 deletions(-)
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
 create mode 100644 pblk-sysfs.c

-- 
2.7.4
