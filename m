Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <bart.vanassche@sandisk.com>
To: Jens Axboe <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, Christoph Hellwig <hch@lst.de>, "Bart Van
 Assche" <bart.vanassche@sandisk.com>
Subject: [PATCH v2 0/4] blk-mq-debugfs patches for kernel v4.13
Date: Wed, 31 May 2017 14:30:46 -0700
Message-ID: <20170531213050.30276-1-bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: Bart.VanAssche@sandisk.com
List-ID: <linux-block@vger.kernel.org>

Hello Jens,

This series contains four patches that add new features to the blk-mq-debugfs.
The changes compared to v1 of this series are:
- Left out the first patch of this series because it's already upstream.
- Renamed "ctx" into "params" in the patch that shows the busy requests.
- In the same patch, switched from blk_mq_debugfs_rq_show() to
  __blk_mq_debugfs_rq_show().

Please consider these patches for kernel v4.13.

Thanks,

Bart.

Bart Van Assche (4):
  blk-mq-debugfs: Show atomic request flags
  blk-mq-debugfs: Show requeue list
  blk-mq-debugfs: Show busy requests
  blk-mq-debugfs: Add 'kick' operation

 block/blk-mq-debugfs.c | 72 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 71 insertions(+), 1 deletion(-)

-- 
2.12.2
