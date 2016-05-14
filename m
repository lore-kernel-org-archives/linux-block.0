Return-Path: <linux-fsdevel-owner@vger.kernel.org>
From: Jon Derrick <jonathan.derrick@intel.com>
To: linux-block@vger.kernel.org
Cc: Jon Derrick <jonathan.derrick@intel.com>,
	"Jens Axboe" <axboe@fb.com>,
	"Alexander Viro" <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org,
	"Dan Williams" <dan.j.williams@intel.com>,
	"Jeff Moyer" <jmoyer@redhat.com>,
	"Stephen Bates" <stephen.bates@microsemi.com>,
	"Keith Busch" <keith.busch@intel.com>,
	linux-nvme@lists.infradead.org,
	"Christoph Hellwig" <hch@infradead.org>
Subject: [RFCv2 0/3] Support for high-priority block device flag
Date: Fri, 13 May 2016 18:02:45 -0600
Message-Id: <1463184168-3381-1-git-send-email-jonathan.derrick@intel.com>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>


V2: Added inode locking as appropriate when setting i_flags


This set intends to recreate block polling (now HIPRI) behavior that was
present in 4.5, where all IO on a queue could be selected to use
block polling behavior. The set allows a block device file to subscribe
to block polling on a block device granularity, rather than a per-queue
granularity.

There have been few-to-no arguments in support of the per-queue,
always-poll functionality that 4.5 offered, moreso in favor of enabling
polling on the entire block device (or indivual IOs as 4.6 offers).

I've been made aware that streams and ioprio may supercede this
functionality in the future, but I'm hoping this is an acceptable
stopgap in the meantime.

This set applies against 4.6-rc7 as well as Jens' for-4.7/core

(I've also been made aware that it may not apply cleanly to 4.7 after
several DAX changes)


Jon Derrick (3):
  block: allow other bd i_node flags when DAX is disabled
  block: add helper for setting and clearing S_DAX on inode
  block: Introduce S_HIPRI inode flag

 block/ioctl.c           | 43 +++++++++++++++++++++++++++++++++++++++++++
 fs/block_dev.c          | 23 +++++++++++++++++++----
 include/linux/fs.h      |  2 ++
 include/uapi/linux/fs.h |  2 ++
 4 files changed, 66 insertions(+), 4 deletions(-)

-- 
1.8.3.1

