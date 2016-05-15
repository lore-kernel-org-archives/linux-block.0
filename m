Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:53509 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751630AbcEOG1G (ORCPT <rfc822;linux-block@vger.kernel.org>);
	Sun, 15 May 2016 02:27:06 -0400
Subject: [PATCH v2 0/3] "Device DAX" for persistent memory
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
	Dave Chinner <david@fromorbit.com>,
	linux-kernel@vger.kernel.org, hch@lst.de,
	linux-block@vger.kernel.org, Jeff Moyer <jmoyer@redhat.com>,
	Jan Kara <jack@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ross Zwisler <ross.zwisler@linux.intel.com>
Date: Sat, 14 May 2016 23:26:18 -0700
Message-ID: <146329357870.17948.14240958684074905846.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Changes since v1: [1]

1/ Dropped the lead in cleanup patches from this posting as they appear
on the libnvdimm-for-next branch.

2/ Fixed the needlessly overweight fault locking by replacing it with
rcu_read_lock() and drop taking the i_mmap_lock since it has no effect
or purpose.  Unlike block devices the vfs does not arrange for character
device inodes to share the same address_space.

3/ Fixed the device release path since the class release method is not
called when the device is created by device_create_with_groups().

4/ Cleanups resulting from the switch to carry (struct dax_dev *) in
filp->private_date.


---

Device DAX is the device-centric analogue of Filesystem DAX
(CONFIG_FS_DAX).  It allows memory ranges to be allocated and mapped
without need of an intervening file system or being bound to block
device semantics.

Why "Device DAX"?

1/ As I mentioned at LSF [2] we are starting to see platforms with
performance and feature differentiated memory ranges.  Environments like
high-performance-computing and usages like in-memory databases want
exclusive allocation of a memory range with zero conflicting
kernel/metadata allocations.  For dedicated applications of high
bandwidth or low latency memory device-DAX provides a predictable direct
map mechanism.

Note that this is only for the small number of "crazy" applications that
are willing to re-write to get every bit of performance.  For everyone
else we, Dave Hansen and I, are looking to add a mechanism to hot-plug
device-DAX ranges into the mm to get general memory management services
(oversubscribe / migration, etc) with the understanding that it may
sacrifice some predictability.

2/ For persistent memory there are similar applications that are willing
to re-write to take full advantage of byte-addressable persistence.
This mechanism satisfies those usages that only need a pre-allocated
file to mmap.

3/ It answers Dave Chinner's call to start thinking about pmem-native
solutions.  Device DAX specifically avoids block-device and file system
conflicts.


[1]: https://lists.01.org/pipermail/linux-nvdimm/2016-May/005660.html
[2]: https://lwn.net/Articles/685107/

---

Dan Williams (3):
      /dev/dax, pmem: direct access to persistent memory
      /dev/dax, core: file operations and dax-mmap
      Revert "block: enable dax for raw block devices"


 block/ioctl.c                       |   32 --
 drivers/Kconfig                     |    2 
 drivers/Makefile                    |    1 
 drivers/dax/Kconfig                 |   26 ++
 drivers/dax/Makefile                |    4 
 drivers/dax/dax.c                   |  568 +++++++++++++++++++++++++++++++++++
 drivers/dax/dax.h                   |   24 +
 drivers/dax/pmem.c                  |  168 ++++++++++
 fs/block_dev.c                      |   96 ++----
 include/linux/fs.h                  |    8 
 include/uapi/linux/fs.h             |    1 
 mm/huge_memory.c                    |    1 
 mm/hugetlb.c                        |    1 
 tools/testing/nvdimm/Kbuild         |    9 +
 tools/testing/nvdimm/config_check.c |    2 
 15 files changed, 835 insertions(+), 108 deletions(-)
 create mode 100644 drivers/dax/Kconfig
 create mode 100644 drivers/dax/Makefile
 create mode 100644 drivers/dax/dax.c
 create mode 100644 drivers/dax/dax.h
 create mode 100644 drivers/dax/pmem.c
