Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <bart.vanassche@sandisk.com>
To: Jens Axboe <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, Bart Van Assche
	<bart.vanassche@sandisk.com>
Subject: [PATCH 0/4] Four patches for the blk-mq debugfs code
Date: Wed, 1 Feb 2017 10:20:55 -0800
Message-ID: <20170201182059.25601-1-bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: Bart.VanAssche@sandisk.com
List-ID: <linux-block@vger.kernel.org>

Hello Jens,

Please consider the four patches in this series for kernel v4.11.

Thanks,

Bart.

Bart Van Assche (4):
  blk-mq-debugfs: Add missing __acquires() / __releases() annotations
  blk-mq-debug: Avoid that sparse complains about req_flags_t usage
  blk-mq-debug: Make show() operations interruptible
  blk-mq-debug: Introduce debugfs_create_files()

 block/blk-mq-debugfs.c | 75 +++++++++++++++++++++++++++++++++-----------------
 block/elevator.c       |  2 +-
 2 files changed, 50 insertions(+), 27 deletions(-)

-- 
2.11.0
