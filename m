Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:8520 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754180AbcKPXZN (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Nov 2016 18:25:13 -0500
From: Scott Bauer <scott.bauer@intel.com>
To: linux-nvme@lists.infradead.org
Cc: Rafael.Antognolli@intel.com, axboe@fb.com, keith.busch@intel.com,
        jonathan.derrick@intel.com, j.naumann@fu-berlin.de,
        hch@infradead.org, linux-block@vger.kernel.org, sagi@grimberg.me
Subject: [PATCH v1 0/7] SED OPAL Library
Date: Wed, 16 Nov 2016 16:17:25 -0700
Message-Id: <1479338252-8777-1-git-send-email-scott.bauer@intel.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Changes from V0->V1:
1) Split the Nvme patche into two different patches (SEC_OPS and unlock)
2) Created work queues to send commands to the controllers:
  2a) Allows us to use correct blk API (blk_execute_rq_nowait)
  2b) Commands are no longer being sent in an IRQ but in the system_wq
3) Clean up left-over crud in nvme: pci.c and core.c
4) Implement fixes suggested by Jonathan Derrick
5) Actually allow a user to enable the Global Locking Range


This Patch series implements a large portion of the Opal protocol for
self encrypting devices. The driver has the capability of storing a
locking range's password, either directly in the driver, or in the
Kernel's key managment. The password can then be replayed during a
resume from previous suspend-to-RAM.

The driver also supports logic to bring the device out of a factory
default-inactive state into a functional Opal state.

The following logic is supported in order to bring the tper into a
working state:

1) Taking Ownership of the drive (Setting the Admin CPIN).
2) Activating the Locking SP (In Single User Mode or Normal Mode).
3) Setting up Locking Ranges (Single User or Normal Mode).
4) Adding users to Locking Ranges (Normal Mode Only).
5) Locking or Unlocking Locking Rangs (Single User Mode or Normal Mode).
6) Reverting the TPer (Restore to factory default).
7) Setting LR/User passwords (Single User Mode or Normal Mode).
8) Eabling/disabling Shadow MBR.
9) Enabling Users in the LockingSP (Normal Mode Only).
10) Saving Password for resume from suspend.


Each command above is exported through an ioctl in the block layer.

We have userland tooling staged in nvme-cli which can be used for
testing:
https://github.com/linux-nvme/nvme-cli/pull/137

Once we've fixed any nits and issues we will merge the userland tooling
into the master branch of nvme-cli.

I have a series of test scripts I've been using which can be helpful if
people want to test or immediately start using and testing the code:

https://github.com/ScottyBauer/nvme-cli-sed-sh

Scott Bauer (7):
  Include: Add definitions for sed
  lib: Add Sed-opal library
  lib: Add Sed to Kconfig and Makefile
  include: Add sec_ops to block device operations
  nvme: Implement SED Security Operations
  nvme: Implement SED Unlock from suspend
  block: ioctl: Wire up Sed to block ioctls

 block/compat_ioctl.c          |   14 +
 block/ioctl.c                 |  200 ++-
 drivers/nvme/host/core.c      |  118 ++
 drivers/nvme/host/nvme.h      |    4 +-
 drivers/nvme/host/pci.c       |    7 +-
 include/linux/blkdev.h        |    1 +
 include/linux/sed-opal.h      |   58 +
 include/linux/sed.h           |   91 ++
 include/uapi/linux/sed-opal.h |  118 ++
 include/uapi/linux/sed.h      |   55 +
 lib/Kconfig                   |   12 +
 lib/Makefile                  |    7 +
 lib/sed-opal.c                | 3338 +++++++++++++++++++++++++++++++++++++++++
 lib/sed-opal_internal.h       |  587 ++++++++
 lib/sed-opal_key.c            |   46 +
 lib/sed.c                     |  250 +++
 16 files changed, 4903 insertions(+), 3 deletions(-)
 create mode 100644 include/linux/sed-opal.h
 create mode 100644 include/linux/sed.h
 create mode 100644 include/uapi/linux/sed-opal.h
 create mode 100644 include/uapi/linux/sed.h
 create mode 100644 lib/sed-opal.c
 create mode 100644 lib/sed-opal_internal.h
 create mode 100644 lib/sed-opal_key.c
 create mode 100644 lib/sed.c


