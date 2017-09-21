Return-Path: <zhangweiping@didichuxing.com>
Date: Thu, 21 Sep 2017 23:16:27 +0800
From: weiping zhang <zhangweiping@didichuxing.com>
To: <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>
Subject: [PATCH v2 0/2] fix wrong value when user modify nr_request by sysfs
Message-ID: <cover.1506006064.git.zhangweiping@didichuxing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-Path: zhangweiping@didichuxing.com
List-ID: <linux-block@vger.kernel.org>

Hi Jens,

This is v2 of fixing nr_request.

v1 -> v2:

blk-mq: fix nr_requests wrong value when modify it from sysfs
this patch return -EINVAL when user write a value that's too large.

blk-sysfs: return EINVAL when user modify nr_request less than
  BLKDEV_MIN_RQ
In order to keep same behavior with former patch, also return EINVAL 
when user write a value less than BLKDEV_MIN_RQ

weiping zhang (2):
  blk-mq: fix nr_requests wrong value when modify it from sysfs
  blk-sysfs: return EINVAL when user modify nr_request less than
    BLKDEV_MIN_RQ

 block/blk-mq.c    | 8 ++++++--
 block/blk-sysfs.c | 2 +-
 2 files changed, 7 insertions(+), 3 deletions(-)

-- 
2.9.4
