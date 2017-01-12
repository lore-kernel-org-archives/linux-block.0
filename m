Return-Path: <Damien.LeMoal@wdc.com>
From: Damien Le Moal <damien.lemoal@wdc.com>
To: Jens Axboe <axboe@kernel.dk>,
	Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-block@vger.kernel.org,
	Shaun Tancheff <shaun@tancheff.com>,
	Hannes Reinecke <hare@suse.de>,
	Damien Le Moal <damien.lemoal@wdc.com>
Subject: [PATCH 0/2] Rename blk_queue_zone_size and bdev_zone_size
Date: Thu, 12 Jan 2017 11:42:51 +0900
Message-Id: <20170112024253.5814-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: damien.lemoal@wdc.com
List-ID: <linux-block@vger.kernel.org>

All block device data fields and functions returning a number of 512B
sectors are by convention named xxx_sectors while names in the form
of xxx_size are generally used for a number of bytes. The blk_queue_zone_size
and bdev_zone_size functions were not following this convention so rename
them.

This is a style fix and no functional change is introduced by this patch.

Damien Le Moal (2):
  block: Rename blk_queue_zone_size and bdev_zone_size
  f2fs: Rename bdev_zone_size to bdev_zone_sectors

 block/blk-zoned.c         |  4 ++--
 block/partition-generic.c | 14 +++++++-------
 fs/f2fs/segment.c         |  4 ++--
 fs/f2fs/super.c           |  6 +++---
 include/linux/blkdev.h    |  6 +++---
 5 files changed, 17 insertions(+), 17 deletions(-)

-- 
2.9.3

Western Digital Corporation (and its subsidiaries) E-mail Confidentiality Notice & Disclaimer:

This e-mail and any files transmitted with it may contain confidential or legally privileged information of WDC and/or its affiliates, and are intended solely for the use of the individual or entity to which they are addressed. If you are not the intended recipient, any disclosure, copying, distribution or any action taken or omitted to be taken in reliance on it, is prohibited. If you have received this e-mail in error, please notify the sender immediately and delete the e-mail in its entirety from your system.
