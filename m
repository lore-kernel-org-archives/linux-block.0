Return-Path: <SRS0=1zCZ=7Z=fb.com=shli@kernel.org>
From: Shaohua Li <shli@kernel.org>
To: linux-block@vger.kernel.org
Cc: axboe@kernel.dk,
	Kernel-team@fb.com,
	Shaohua Li <shli@fb.com>
Subject: [PATCH 0/2] block/loop: improve performance
Date: Wed, 23 Aug 2017 16:49:22 -0700
Message-Id: <cover.1503531709.git.shli@fb.com>
List-ID: <linux-block@vger.kernel.org>

From: Shaohua Li <shli@fb.com>

two small patches to improve performance for loop in directio mode. The goal is
to increase IO size sending to underlayer disks.

Thanks,
Shaohua

Shaohua Li (2):
  block/loop: set hw_sectors
  block/loop: allow request merge for directio mode

 drivers/block/loop.c | 44 ++++++++++++++++++++++++++++++++++++--------
 drivers/block/loop.h |  1 +
 2 files changed, 37 insertions(+), 8 deletions(-)

-- 
2.9.5
