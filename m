Return-Path: <zhangweiping@didichuxing.com>
Date: Thu, 5 Apr 2018 18:09:58 +0800
From: Weiping Zhang <zhangweiping@didichuxing.com>
To: <axboe@kernel.dk>, <cohuck@redhat.com>, <mst@redhat.com>,
	<jasowang@redhat.com>
CC: <linux-block@vger.kernel.org>, <virtualization@lists.linux-foundation.org>
Subject: [RFC PATCH 0/2] use larger max_request_size for virtio_blk
Message-ID: <cover.1522922101.git.zhangweiping@didichuxing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-Path: zhangweiping@didichuxing.com
List-ID: <linux-block@vger.kernel.org>

Hi,

For virtio block device, actually there is no a hard limit for max request
size, and virtio_blk driver set -1 to blk_queue_max_hw_sectors(q, -1U);.
But it doesn't work, because there is a default upper limitation
BLK_DEF_MAX_SECTORS (1280 sectors). So this series want to add a new helper
blk_queue_max_hw_sectors_no_limit to set a proper max reqeust size.

Weiping Zhang (2):
  blk-setting: add new helper blk_queue_max_hw_sectors_no_limit
  virtio_blk: add new module parameter to set max request size

 block/blk-settings.c       | 20 ++++++++++++++++++++
 drivers/block/virtio_blk.c | 32 ++++++++++++++++++++++++++++++--
 include/linux/blkdev.h     |  2 ++
 3 files changed, 52 insertions(+), 2 deletions(-)

-- 
2.9.4
