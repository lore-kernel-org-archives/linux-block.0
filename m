Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <bart.vanassche@sandisk.com>
To: Jens Axboe <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, Christoph Hellwig <hch@lst.de>, "Bart Van
 Assche" <bart.vanassche@sandisk.com>
Subject: [PATCH v3 0/4] Extend blk-mq-debugfs functionality further
Date: Thu, 1 Jun 2017 08:55:09 -0700
Message-ID: <20170601155513.26712-1-bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: Bart.VanAssche@sandisk.com
List-ID: <linux-block@vger.kernel.org>

Hello Jens,

This series contains four patches that add new features to the blk-mq-debugfs
code. Please consider these patches for kernel v4.13.

Thanks,

Bart.

Changes between v2 and v3:
- Renamed a function in the patch that shows busy requests. In the same patch,
  added a comment as requested by Ming.
- Added Reviewed-by tags to those patches that got an additional review.  

Changes compared to v1:
- Left out the first patch of this series because it's already upstream.
- Renamed "ctx" into "params" in the patch that shows the busy requests.
- In the same patch, switched from blk_mq_debugfs_rq_show() to
  __blk_mq_debugfs_rq_show().

The patches in this series are:

Bart Van Assche (4):
  blk-mq-debugfs: Show atomic request flags
  blk-mq-debugfs: Show requeue list
  blk-mq-debugfs: Show busy requests
  blk-mq-debugfs: Add 'kick' operation

 block/blk-mq-debugfs.c | 77 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 76 insertions(+), 1 deletion(-)

-- 
2.12.2
