Return-Path: <SRS0=2VWl=72=fb.com=shli@kernel.org>
From: Shaohua Li <shli@kernel.org>
To: linux-block@vger.kernel.org
Cc: axboe@kernel.dk,
	Kernel-team@fb.com,
	Shaohua Li <shli@fb.com>
Subject: [PATCH V2 0/2] block/loop: improve performance
Date: Thu, 24 Aug 2017 12:24:51 -0700
Message-Id: <cover.1503602376.git.shli@fb.com>
List-ID: <linux-block@vger.kernel.org>

From: Shaohua Li <shli@fb.com>

two small patches to improve performance for loop in directio mode. The goal is
to increase IO size sending to underlayer disks. As Omar pointed out, the
patches have slight conflict with his, but should be easy to fix.

Thanks,
Shaohua

Shaohua Li (2):
  block/loop: set hw_sectors
  block/loop: allow request merge for directio mode

 drivers/block/loop.c | 67 ++++++++++++++++++++++++++++++++++++++++------------
 drivers/block/loop.h |  1 +
 2 files changed, 53 insertions(+), 15 deletions(-)

-- 
2.9.5
