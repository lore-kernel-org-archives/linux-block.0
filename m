Return-Path: <prvs=5482b108a=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>
Subject: [PATCH v2 0/3] Avoid that blk_{un,}register_queue() trigger lock inversion
Date: Wed, 17 Jan 2018 11:48:07 -0800
Message-Id: <20180117194810.26583-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Hello Jens,

The three patches in this series are what I came up with after having
analyzed a lockdep complaint triggered by blk_unregister_queue(). Please
consider these patches for kernel v4.16.

Thanks,

Bart.

Changes compared to v1:
- Restored the code that protects against races between changing the scheduler
  from sysfs and unregistering a block layer queue.

Bart Van Assche (3):
  block: Unexport elv_register_queue() and elv_unregister_queue()
  block: Document scheduler modification locking requirements
  block: Protect less code with sysfs_lock in blk_{un,}register_queue()

 block/blk-sysfs.c        | 37 ++++++++++++++++++++++++++++---------
 block/blk.h              |  3 +++
 block/elevator.c         | 10 ++++++++--
 include/linux/elevator.h |  2 --
 4 files changed, 39 insertions(+), 13 deletions(-)

-- 
2.15.1
