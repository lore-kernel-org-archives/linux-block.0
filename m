Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-dm3nam03on0058.outbound.protection.outlook.com ([104.47.41.58]:56073
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752985AbdDOS4O (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 15 Apr 2017 14:56:14 -0400
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias@cnexlabs.com>
To: <axboe@fb.com>
CC: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias@cnexlabs.com>
Subject: [GIT PULL 00/19] LightNVM patches for 4.12.
Date: Sat, 15 Apr 2017 20:55:34 +0200
Message-ID: <20170415185553.16098-1-matias@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Jens,

With this merge window, we like to push pblk upstream. It is a new
host-side translation layer that implements support for exposing
Open-Channel SSDs as block devices.

We have described pblk in the LightNVM paper "LightNVM: The Linux
Open-Channel SSD Subsystem" that was accepted at FAST 2017. The paper
defines open-channel SSDs, the subsystem, pblk and has an evaluation as
well. Over the past couple of kernel versions we have shipped the
support patches for pblk, and we are now comfortable pushing the core of
pblk upstream.

The core contains the logic to control data placement and I/O scheduling
on open-channel SSDs. Including implementation of translation table
management, GC, recovery, rate-limiting, and similar components. It
assumes that the SSD is media-agnostic, and runs on both 1.2 and 2.0 of
the Open-Channel SSD specification without modifications.

I want to point out two neat features of pblk. First, pblk can be
instantiated multiple times on the same SSD, enabling I/O isolation
between tenants, and makes it able to fulfill strict QoS requirements.
We showed results from this at the NVMW '17 workshop this year, while
presenting the "Multi-Tenant I/O Isolation with Open-Channel SSDs" talk.
Second, now that a full host-side translation layer is implemented, one
can begin to optimize its data placement and I/O scheduling algorithms
to match user workloads. We have shown a couple of the benefits in the
LightNVM paper, and we know of a couple of companies and universities
that have begun making new algorithms.

In detail, this pull request contains:

 - The new host-side FTL pblk from Javier, and other contributors.

 - Add support to the "create" ioctl to force a target to be
   re-initialized at using "factory" flag from Javier.

 - Fix various errors in LightNVM core from Javier and me.

 - An optimization from Neil Brown to skip error checking on mempool
   allocations that can sleep.

 - A buffer overflow fix in nvme_nvm_identify from Scott Bauer.

 - Fix for bad block discovery handle error handling from Christophe
   Jaillet.

 - Fixes from Dan Carpenter to pblk after it went into linux-next.

Please pull from the for-jens branch or apply the patches posted with
this mail:

   https://github.com/OpenChannelSSD/linux.git for-jens

Thanks,
Matias

Christophe JAILLET (1):
  lightnvm: Fix error handling

Dan Carpenter (3):
  lightnvm: pblk-gc: fix an error pointer dereference in init
  lightnvm: fix some WARN() messages
  lightnvm: fix some error code in pblk-init.c

Javier González (12):
  lightnvm: submit erases using the I/O path
  lightnvm: rename scrambler controller hint
  lightnvm: free reverse device map
  lightnvm: double-clear of dev->lun_map on target init error
  lightnvm: fix cleanup order of disk on init error
  lightnvm: bad type conversion for nvme control bits
  lightnvm: allow to init targets on factory mode
  lightnvm: make nvm_free static
  lightnvm: clean unused variable
  lightnvm: fix type checks on rrpc
  lightnvm: convert sprintf into strlcpy
  lightnvm: physical block device (pblk) target

Matias Bjørling (1):
  lightnvm: enable nvme size compile asserts

NeilBrown (1):
  lightnvm: don't check for failure from mempool_alloc()

Scott Bauer (1):
  nvme/lightnvm: Prevent small buffer overflow in nvme_nvm_identify

 Documentation/lightnvm/pblk.txt  |   21 +
 drivers/lightnvm/Kconfig         |    9 +
 drivers/lightnvm/Makefile        |    5 +
 drivers/lightnvm/core.c          |  124 +--
 drivers/lightnvm/pblk-cache.c    |  114 +++
 drivers/lightnvm/pblk-core.c     | 1655 ++++++++++++++++++++++++++++++++++++++
 drivers/lightnvm/pblk-gc.c       |  555 +++++++++++++
 drivers/lightnvm/pblk-init.c     |  957 ++++++++++++++++++++++
 drivers/lightnvm/pblk-map.c      |  136 ++++
 drivers/lightnvm/pblk-rb.c       |  852 ++++++++++++++++++++
 drivers/lightnvm/pblk-read.c     |  529 ++++++++++++
 drivers/lightnvm/pblk-recovery.c |  998 +++++++++++++++++++++++
 drivers/lightnvm/pblk-rl.c       |  182 +++++
 drivers/lightnvm/pblk-sysfs.c    |  507 ++++++++++++
 drivers/lightnvm/pblk-write.c    |  411 ++++++++++
 drivers/lightnvm/pblk.h          | 1121 ++++++++++++++++++++++++++
 drivers/lightnvm/rrpc.c          |   25 +-
 drivers/nvme/host/lightnvm.c     |   42 +-
 include/linux/lightnvm.h         |   13 +-
 include/uapi/linux/lightnvm.h    |    4 +
 20 files changed, 8165 insertions(+), 95 deletions(-)
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
2.9.3
