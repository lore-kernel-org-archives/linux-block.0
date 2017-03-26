Return-Path: <sbates130272@gmail.com>
Return-Path: <sbates130272@gmail.com>
From: sbates@raithlin.com
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Damien.LeMoal@wdc.com,
	osandov@osandov.com,
	sbates@raithlin.com
Subject: [PATCH 0/2] blk-stat: Add ability to not bucket IO, add this to IO poling.
Date: Sat, 25 Mar 2017 20:18:10 -0600
Message-Id: <1490494692-2416-1-git-send-email-sbates@raithlin.com>
List-ID: <linux-block@vger.kernel.org>

From: Stephen Bates <sbates@raithlin.com>

Omar recently developed some patches for block layer stats that use
callbacks to determine which bucket an IO should be considered for. At
the same time there was discussion at LSF/MM that we might not want to
consider all IO when generating stats for certain algorithms (e.g. IO
completion polling).

This set does two things. It makes the bucket callback for stats
signed so we can now ignore IO that cause a negative to be returned
from the bucket function. It then uses this new functionality to
filter IO for the IO completion polling algorithms.

This patchset applies cleanly on a83b576c9c25cf (block: fix stacked
driver stats init and free) in Jens' for-next tree.

I've lightly tested this using QEMU and a real NVMe low-latency
device. I do not have performance number yet. Feedback would be
appreciated!

[BTW this is my first submission for an all new setup so apologies if
this does not come through correctly!]

Cc: Damien.LeMoal@wdc.com
Cc: osandov@osandov.com

Stephen Bates (2):
  blk-stat: convert blk-stat bucket callback to signed
  blk-stat: add a poll_size value to the request_queue struct

 block/blk-mq.c         | 17 +++++++++++++++--
 block/blk-stat.c       |  8 +++++---
 block/blk-stat.h       |  9 +++++----
 block/blk-sysfs.c      | 30 ++++++++++++++++++++++++++++++
 include/linux/blkdev.h |  1 +
 5 files changed, 56 insertions(+), 9 deletions(-)

-- 
2.7.4
