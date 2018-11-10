Return-Path: <axboe@kernel.dk>
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id d68-v6sm11178615pfa.80.2018.11.10.07.13.20
        for <linux-block@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 10 Nov 2018 07:13:20 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Subject: [PATCHSET 0/6] Various block optimizations
Date: Sat, 10 Nov 2018 08:13:11 -0700
Message-Id: <20181110151317.3813-1-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

A mixed bag of optimizations that are now possible, on top of my
for-4.21/block branch.


 block/blk-cgroup.c         |   8 ++--
 block/blk-core.c           |  16 ++++----
 block/blk-flush.c          |   3 +-
 block/blk-mq-debugfs.c     |   2 +-
 block/blk-mq.c             |  24 +++++------
 block/blk-mq.h             |  12 +++---
 block/blk-rq-qos.c         |  90 +++++++++++-----------------------------
 block/blk-rq-qos.h         |  35 ++++++++++++----
 block/blk-softirq.c        |   4 +-
 block/blk-sysfs.c          |  18 ++++----
 block/blk-wbt.c            |   2 +-
 block/elevator.c           |   9 ++--
 block/genhd.c              |   8 ++--
 drivers/md/dm-table.c      |   2 +-
 drivers/nvme/host/pci.c    |  17 ++++++--
 drivers/scsi/scsi_lib.c    |   2 +-
 fs/block_dev.c             |  29 ++++++++++---
 fs/iomap.c                 |   2 +-
 include/linux/blk-mq-ops.h | 100 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/blk-mq.h     |  94 +-----------------------------------------
 include/linux/blkdev.h     |  27 ++++++++++--
 21 files changed, 268 insertions(+), 236 deletions(-)

-- 
Jens Axboe
