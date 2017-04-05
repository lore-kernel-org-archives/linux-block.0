Return-Path: <sbates130272@gmail.com>
Return-Path: <sbates130272@gmail.com>
From: sbates@raithlin.com
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Damien.LeMoal@wdc.com,
	osandov@osandov.com,
	sbates@raithlin.com,
	sagi@grimberg.me
Subject: [PATCH v2 0/2] blk-stat: Add ability to not bucket IO; improve IO polling.
Date: Wed,  5 Apr 2017 11:39:15 -0600
Message-Id: <1491413957-30885-1-git-send-email-sbates@raithlin.com>
List-ID: <linux-block@vger.kernel.org>

From: Stephen Bates <sbates@raithlin.com>

Omar recently developed some patches for block layer stats that use
callbacks to determine which bucket an IO should be considered for. At
the same time there was discussion at LSF/MM that we might not want to
consider all IO when generating stats for certain algorithms (e.g. IO
completion polling) or to bucket them in a more optimal fashion.

This set does two things. It makes the bucket callback for stats
signed so we can now ignore IO that cause a negative to be returned
from the bucket function. It then improves the IO polling latency
estimations by bucketing stats based on IO size and direction.

This patchset applies cleanly on 6809ef67eb7b4b68d (Merge branch
'for-4.12/block' into for-next) in Jens' for-next tree.

I've lightly tested this using QEMU and a real NVMe low-latency
device. I do not have performance number yet. Feedback would be
appreciated! I am not *super* happy with how the bucketing by size is
done. Any suggestions on how to improve this would be appreciated!

Cc: Damien.LeMoal@wdc.com
Cc: osandov@osandov.com

Changes since v1:
  Dropped the cast in blk_stat_rq_ddir() as per Omar's suggestion.
  Moved to an array of buckets based on IO size rather than a filter
  as suggested by Jens and Damien.

Stephen Bates (2):
  blk-stat: convert blk-stat bucket callback to signed
  blk-mq: Add a polling specific stats function

 block/blk-mq.c   | 54 ++++++++++++++++++++++++++++++++++++++++++++----------
 block/blk-stat.c |  6 ++++--
 block/blk-stat.h |  9 +++++----
 3 files changed, 53 insertions(+), 16 deletions(-)

-- 
2.7.4
