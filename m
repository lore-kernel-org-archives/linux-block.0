Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <bart.vanassche@sandisk.com>
To: Jens Axboe <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, Bart Van Assche
	<bart.vanassche@sandisk.com>
Subject: [PATCH 0/2] Export more queue state information through debugfs
Date: Thu, 30 Mar 2017 11:21:25 -0700
Message-ID: <20170330182127.24288-1-bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: Bart.VanAssche@sandisk.com
List-ID: <linux-block@vger.kernel.org>

Hello Jens,

This is a short patch series with one patch that exports the queue state
and another patch that shows symbolic names for hctx state and flags
instead of a numerical bitmask.

Please consider these patches for kernel v4.12.

Thanks,

Bart.

Changes compared to v2:
- Introduced function blk_flags_show() in patch 1.
- Modified error message in patch 1 such that it shows the names of the
  valid commands.
- Added patch "blk-mq: Show symbolic names for hctx state and flags"

Changes compared to v1:
- Constified blk_queue_flag_name.
- Left out QUEUE_FLAG_VIRT because it is a synonym of QUEUE_FLAG_NONROT.
- Check array size before reading from blk_queue_flag_name[].
- Add functionality to restart a block layer queue.

Bart Van Assche (2):
  blk-mq: Export queue state through /sys/kernel/debug/block/*/state
  blk-mq: Show symbolic names for hctx state and flags

 block/blk-mq-debugfs.c | 143 +++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 140 insertions(+), 3 deletions(-)

-- 
2.12.0
