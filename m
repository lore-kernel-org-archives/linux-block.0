Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:35392 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752697AbdDLNTr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Apr 2017 09:19:47 -0400
Received: by mail-wm0-f54.google.com with SMTP id w64so87769566wma.0
        for <linux-block@vger.kernel.org>; Wed, 12 Apr 2017 06:19:46 -0700 (PDT)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
To: mb@lightnvm.io
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bart.VanAssche@sandisk.com,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH v6] lightnvm: pblk
Date: Wed, 12 Apr 2017 15:19:14 +0200
Message-Id: <1492003155-19320-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Matias,

A last spin to fix a regression that I introduced yesterday on v4. This
should be the one.

Thanks,
Javier

Changes since v5:
* Fix regression on the erase scheduler introduced on v4

Changes since v4:
* Rebase on top of Matias' for-4.12/core
* Fix type implicit conversions reported by sparse (reported by Bart Van
  Assche)
* Make error and debug statistics long atomic variables.

Changes since v3:
* Apply Bart's feedback [1]
* Implement dynamic L2P optimizations for > 32-bit physical media
  geometry (from Matias Bjørling)
* Fix memory leak on GC (Reported by Simon A. F. Lund)
* 8064 is a perfectly round number of lines :)

[1] https://lkml.org/lkml/2017/4/8/172

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
 drivers/lightnvm/Kconfig         |    9 +
 drivers/lightnvm/Makefile        |    5 +
 drivers/lightnvm/pblk-cache.c    |  114 +++
 drivers/lightnvm/pblk-core.c     | 1655 ++++++++++++++++++++++++++++++++++++++
 drivers/lightnvm/pblk-gc.c       |  555 +++++++++++++
 drivers/lightnvm/pblk-init.c     |  949 ++++++++++++++++++++++
 drivers/lightnvm/pblk-map.c      |  136 ++++
 drivers/lightnvm/pblk-rb.c       |  852 ++++++++++++++++++++
 drivers/lightnvm/pblk-read.c     |  529 ++++++++++++
 drivers/lightnvm/pblk-recovery.c |  998 +++++++++++++++++++++++
 drivers/lightnvm/pblk-rl.c       |  182 +++++
 drivers/lightnvm/pblk-sysfs.c    |  507 ++++++++++++
 drivers/lightnvm/pblk-write.c    |  411 ++++++++++
 drivers/lightnvm/pblk.h          | 1121 ++++++++++++++++++++++++++
 15 files changed, 8044 insertions(+)
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
