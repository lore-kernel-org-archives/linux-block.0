Return-Path: <prvs=547e67762=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Mike Snitzer <snitzer@redhat.com>,
	Bart Van Assche <bart.vanassche@wdc.com>
Subject: [PATCH 0/3] Avoid that blk_{un,}register_queue() trigger lock inversion
Date: Tue, 16 Jan 2018 10:17:49 -0800
Message-Id: <20180116181752.25847-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Hello Jens,

The three patches in this series are what I came up with after having
analyzed a lockdep complaint triggered by blk_unregister_queue. Please
consider these patches for kernel v4.16.

Thanks,

Bart.

Bart Van Assche (3):
  block: Unexport elv_register_queue() and elv_unregister_queue()
  block: Document scheduler change code locking requirements
  block: Protect less code with sysfs_lock in blk_{un,}register_queue()

 block/blk-sysfs.c        | 13 ++++---------
 block/blk.h              |  3 +++
 block/elevator.c         | 10 ++++++++--
 include/linux/elevator.h |  2 --
 4 files changed, 15 insertions(+), 13 deletions(-)

-- 
2.15.1
