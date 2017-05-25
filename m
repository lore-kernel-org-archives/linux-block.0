Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <bart.vanassche@sandisk.com>
To: Jens Axboe <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, Christoph Hellwig <hch@lst.de>, "Bart Van
 Assche" <bart.vanassche@sandisk.com>
Subject: [PATCH 0/5] Five blk-mq-debugfs patches
Date: Thu, 25 May 2017 16:38:05 -0700
Message-ID: <20170525233810.23211-1-bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: Bart.VanAssche@sandisk.com
List-ID: <linux-block@vger.kernel.org>

Hello Jens,

This series contains four patches that add new features to the blk-mq-debugfs
code and that are intended for kernel v4.13 and one bug fix that is intended
for kernel v4.12. The patches in this series are:

Bart Van Assche (5):
  blk-mq: Only register debugfs attributes for blk-mq queues
  blk-mq-debugfs: Show atomic request flags
  blk-mq-debugfs: Show requeue list
  blk-mq-debugfs: Show busy requests
  blk-mq-debugfs: Add 'kick' operation

 block/blk-mq-debugfs.c | 71 +++++++++++++++++++++++++++++++++++++++++++++++++-
 block/blk-sysfs.c      |  6 ++---
 2 files changed, 73 insertions(+), 4 deletions(-)

-- 
2.12.2
