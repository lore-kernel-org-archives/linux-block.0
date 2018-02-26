Return-Path: <jiufei.xue@linux.alibaba.com>
From: Jiufei Xue <jiufei.xue@linux.alibaba.com>
Subject: [PATCH 0/4] fix a few problems in block layer
To: hch@lst.de, Shaohua Li <shli@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, caspar@linux.alibaba.com,
 Joseph Qi <joseph.qi@linux.alibaba.com>
Message-ID: <fc363a8d-957c-be3a-e60a-a8b40727d727@linux.alibaba.com>
Date: Mon, 26 Feb 2018 20:01:42 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

I have found a few problems while reviewing the patch 74d46992e0d9
("block: replace bi_bdev with a gendisk pointer and partitions index"),
So fix them.

Jiufei Xue (4)
block: fix the count of PGPGOUT for WRITE_SAME
block: bio_check_eod() needs to consider partition
block: display the correct disk name for bio
block: fix a typo and modify the documentation for bio

block/blk-core.c          |   18 +++++-------------
block/partition-generic.c |    6 ------
drivers/block/pktcdvd.c   |    2 +-
include/linux/bio.h       |    4 +++-
4 files changed, 9 insertions(+), 21 deletions(-)
