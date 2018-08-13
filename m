Return-Path: <prvs=7568bcc2f=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Bart Van Assche <bart.vanassche@wdc.com>
Subject: [PATCH v2 0/2] Fix a race condition related to creation of /dev/nvme0n<x>
Date: Mon, 13 Aug 2018 10:25:29 -0700
Message-Id: <20180813172531.7451-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Hello Jens,

The two patches in this series fix a race condition related to the creation of
the sysfs attributes for the /dev/nvme0n<x> devices nodes. I encountered this
race while adding tests to the blktests project for the NVMeOF kernel
drivers. Please consider these patches for the upstream kernel.

Thanks,

Bart.

Bart Van Assche (2):
  block: Introduce alloc_disk_node_attr()
  nvme: Fix race conditions related to creation of /dev/nvme0n<x>

 block/genhd.c                | 26 ++++++++++++++++++++++++--
 drivers/nvme/host/core.c     | 17 +++++------------
 drivers/nvme/host/lightnvm.c | 34 +++++++---------------------------
 drivers/nvme/host/nvme.h     |  9 ++++-----
 include/linux/genhd.h        | 13 +++++++++++--
 5 files changed, 51 insertions(+), 48 deletions(-)

-- 
2.18.0
