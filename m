Return-Path: <prvs=425928092f=shli@fb.com>
From: Shaohua Li <shli@fb.com>
To: <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>
CC: <axboe@kernel.dk>, <tj@kernel.org>, Vivek Goyal <vgoyal@redhat.com>,
        <jmoyer@redhat.com>, <Kernel-team@fb.com>
Subject: [PATCH 0/3] blk-throttle: add .low limit fix
Date: Mon, 27 Mar 2017 15:19:40 -0700
Message-ID: <cover.1490651903.git.shli@fb.com>
In-Reply-To: <567d5361-7d6b-c53e-8ada-a2966e48dc54@fb.com>
References: <567d5361-7d6b-c53e-8ada-a2966e48dc54@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

Jens,

The 3 patches replace the last two patches (patch 17/18) of the series I sent
out today. The new patch overloads blk stat as you suggested.

Thanks,
Shaohua

Shaohua Li (3):
  block: track request size in blk_issue_stat
  blk-throttle: add a mechanism to estimate IO latency
  blk-throttle: add latency target support

 block/blk-core.c          |   2 +-
 block/blk-mq.c            |   2 +-
 block/blk-stat.c          |  15 +++-
 block/blk-stat.h          |  44 +++++++---
 block/blk-throttle.c      | 199 ++++++++++++++++++++++++++++++++++++++++++++--
 block/blk-wbt.h           |  10 +--
 block/blk.h               |   2 +
 include/linux/blk_types.h |   9 ++-
 8 files changed, 254 insertions(+), 29 deletions(-)

-- 
2.9.3
