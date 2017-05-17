Return-Path: <prvs=631096caf0=shli@fb.com>
From: Shaohua Li <shli@fb.com>
To: <linux-block@vger.kernel.org>
CC: <axboe@kernel.dk>, <tj@kernel.org>, <Kernel-team@fb.com>
Subject: [PATCH 0/4] blk-throttle: fix a few issues
Date: Wed, 17 May 2017 13:07:23 -0700
Message-ID: <cover.1495050247.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

Hi,

The patchset fix a few issues for io.low limit. The title of the patches
explain the issues pretty well.

Thanks,
Shaohua

Shaohua Li (4):
  blk-throttle: add hierarchy support for latency target and idle time
  blk-throttle: output some debug info in trace
  blk-throttle: respect 0 bps/iops settings for io.low
  blk-throttle: force user to configure all settings for io.low

 block/blk-throttle.c | 172 ++++++++++++++++++++++++++++++++-------------------
 1 file changed, 109 insertions(+), 63 deletions(-)

-- 
2.9.3
