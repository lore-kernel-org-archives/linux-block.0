Return-Path: <prvs=697b38d23=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>
Subject: [PATCH 0/5] Five small zoned block device patches
Date: Fri, 15 Jun 2018 14:55:16 -0700
Message-Id: <20180615215521.27435-1-bart.vanassche@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

Hello Jens,

In this patch series there are five patches with small improvements for the
zoned block device code. Please consider these patches for the upstream kernel.

Thanks,

Bart.

Bart Van Assche (5):
  block: Remove a superfluous cast from blkdev_report_zones()
  include/uapi/linux/blkzoned.h: Remove a superfluous __packed directive
  block: Remove bdev_nr_zones()
  block: Inline blk_queue_nr_zones()
  block: Make struct request_queue smaller for CONFIG_BLK_DEV_ZONED=n

 block/Kconfig                 |  4 ++++
 block/Makefile                |  1 +
 block/blk-mq-debugfs-zoned.c  | 24 ++++++++++++++++++++++++
 block/blk-mq-debugfs.c        | 15 ---------------
 block/blk-mq-debugfs.h        |  9 +++++++++
 block/blk-zoned.c             |  2 +-
 include/linux/blkdev.h        | 20 ++++++--------------
 include/uapi/linux/blkzoned.h |  2 +-
 8 files changed, 46 insertions(+), 31 deletions(-)
 create mode 100644 block/blk-mq-debugfs-zoned.c

-- 
2.17.0
