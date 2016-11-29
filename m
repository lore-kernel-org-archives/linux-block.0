Return-Path: <linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org>
From: Scott Bauer <scott.bauer@intel.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH v2 0/4] SED OPAL Library
Date: Tue, 29 Nov 2016 14:51:58 -0700
Message-Id: <1480456322-27339-1-git-send-email-scott.bauer@intel.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: keith.busch@intel.com, sagi@grimberg.me, hch@infradead.org,
 Rafael.Antognolli@intel.com, axboe@fb.com, linux-block@vger.kernel.org,
 jonathan.derrick@intel.com, j.naumann@fu-berlin.de
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org
List-ID: <linux-block@vger.kernel.org>

Changes from v1->v2
1) Removed work queues and call backs. The code now operates in
   in a normal call chain fashion. Each opal command provides a
   series of commands it needs to run. next() iterates through
   the functions only calling the subsequent function once the
   current has finished and if no error has occured.

2) Refactored the ioctl handling. A driver that wants to
   support SED now sets up a block ioctl handler and forwards
   the request into the sed library.

3) The implementing ioctl handler in the driver now passes a
   combined send/recv function pointer and a pointer to "data"
   that may be necessary for sending data to the controller.
   In the case of nvme we send the "nvme_sec_submit" fn pointer
   as well as a nvme_ns sturcutre as the "data".

   When the sed library wants to send the opal packet to the
   controller it calls the fn pointer. In this case it calls
   nvme_sec_submit, and passes the nvme_ns. The nvme driver
   handles the actual submission to the controller.

4) Instead of passing around strings we now pass around major
   and minor numbers.

5) Removed the user-land pointer indirection.

6) Moved sed* from lib/ to block/

7) Removed the manditory secure erase when setting up a locking
   range. Instead made a new secure erase function.

9) Added a kref_get and nvme_ns_put in the unlock_from_suspend.

8) Added addition to MAINTAINERS
--------------------------------------------------------------------

This Patch series implements a large portion of the Opal protocol for
self encrypting devices. The driver has the capability of storing a
locking range's password. It either stores directly in the driver,
or in the Kernel's key managment. The password can then be replayed
during a resume from previous suspend-to-RAM.

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

Scott Bauer (4):
  include: Add definitions for sed
  block: Add Sed-opal library
  nvme: Implement resume_from_suspend and sed block ioctl
  Maintainers: Add Information for SED Opal library

 MAINTAINERS                   |   10 +
 block/Makefile                |    2 +-
 block/sed-opal.c              | 3157 +++++++++++++++++++++++++++++++++++++++++
 block/sed-opal_internal.h     |  601 ++++++++
 block/sed.c                   |  207 +++
 drivers/nvme/host/core.c      |   76 +
 drivers/nvme/host/nvme.h      |    4 +-
 drivers/nvme/host/pci.c       |    7 +-
 include/linux/sed-opal.h      |   57 +
 include/linux/sed.h           |   85 ++
 include/uapi/linux/sed-opal.h |  108 ++
 include/uapi/linux/sed.h      |   64 +
 12 files changed, 4375 insertions(+), 3 deletions(-)
 create mode 100644 block/sed-opal.c
 create mode 100644 block/sed-opal_internal.h
 create mode 100644 block/sed.c
 create mode 100644 include/linux/sed-opal.h
 create mode 100644 include/linux/sed.h
 create mode 100644 include/uapi/linux/sed-opal.h
 create mode 100644 include/uapi/linux/sed.h



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
