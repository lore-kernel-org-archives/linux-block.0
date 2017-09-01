Return-Path: <SRS0=upyn=AC=fb.com=shli@kernel.org>
From: Shaohua Li <shli@kernel.org>
To: linux-block@vger.kernel.org
Cc: kernel-team@fb.com,
	axboe@kernel.dk,
	Shaohua Li <shli@fb.com>
Subject: [PATCH V3 0/2] block/loop: improve performance
Date: Thu, 31 Aug 2017 22:09:44 -0700
Message-Id: <cover.1504240556.git.shli@fb.com>
List-ID: <linux-block@vger.kernel.org>

From: Shaohua Li <shli@fb.com>

two small patches to improve performance for loop in directio mode. The goal is
to increase IO size sending to underlayer disks.

Thanks,
Shaohua

V2 -> V3:
- Use GFP_NOIO pointed out by Ming
- Rebase to latest for-next branch

Shaohua Li (2):
  block/loop: set hw_sectors
  block/loop: allow request merge for directio mode

 drivers/block/loop.c | 67 ++++++++++++++++++++++++++++++++++++++++------------
 drivers/block/loop.h |  1 +
 2 files changed, 53 insertions(+), 15 deletions(-)

-- 
2.9.5
