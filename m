Return-Path: <jiufei.xue@linux.alibaba.com>
To: Christoph Hellwig <hch@lst.de>, Shaohua Li <shli@kernel.org>,
 Jens Axboe <axboe@kernel.dk>
Cc: linux-block <linux-block@vger.kernel.org>, caspar@linux.alibaba.com,
 Joseph Qi <joseph.qi@linux.alibaba.com>
From: Jiufei Xue <jiufei.xue@linux.alibaba.com>
Subject: [PATCH V2 0/4] fix a few problems in block layer
Message-ID: <014d8f0c-31db-c18b-855e-5e425b9499be@linux.alibaba.com>
Date: Tue, 27 Feb 2018 20:07:04 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

I have found a few problems while reviewing the patch 74d46992e0d9
("block: replace bi_bdev with a gendisk pointer and partitions index"),
So fix them.

Changes since v1:
- add a Fixes tag in individual patch.
- check end-of-device of bio in blk_partition_remap when the bi_partno
is not zero to avoid another partition lookup.

Jiufei Xue (4)
  block: fix the count of PGPGOUT for WRITE_SAME
  block: bio_check_eod() needs to consider partition
  block: display the correct disk name for bio
  block: fix a typo and modify the documentation for bio

 block/blk-core.c          |   81 +++++++++++++++++++++-------------------------
 block/partition-generic.c |    6 ---
 drivers/block/pktcdvd.c   |    2 -
 include/linux/bio.h       |    4 +-
 4 files changed, 41 insertions(+), 52 deletions(-)
