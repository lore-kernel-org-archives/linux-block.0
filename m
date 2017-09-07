Return-Path: <SRS0=Wszy=AI=fb.com=shli@kernel.org>
From: Shaohua Li <shli@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org
Cc: tj@kernel.org,
	lizefan@huawei.com,
	tglx@linutronix.de,
	kernel-team@fb.com,
	axboe@kernel.dk,
	Shaohua Li <shli@fb.com>
Subject: [PATCH 0/3] block: make loop block device cgroup aware
Date: Wed,  6 Sep 2017 19:00:50 -0700
Message-Id: <cover.1504748195.git.shli@fb.com>
List-ID: <linux-block@vger.kernel.org>

From: Shaohua Li <shli@fb.com>

Hi,

The IO dispatched to under layer disk by loop block device isn't cloned from
original bio, so the IO loses cgroup information of original bio. These IO
escapes from cgroup control. The patches try to address this issue. The idea is
quite generic, but we currently only make it work for blkcg.

Thanks,
Shaohua

Shaohua Li (3):
  kthread: add a mechanism to store cgroup info
  block: make blkcg aware of kthread stored original cgroup info
  block/loop: make loop cgroup aware

 block/bio.c                | 31 -------------------------
 drivers/block/loop.c       | 13 +++++++++++
 drivers/block/loop.h       |  1 +
 include/linux/bio.h        |  2 --
 include/linux/blk-cgroup.h | 25 ++++++--------------
 include/linux/kthread.h    | 13 +++++++++++
 include/linux/sched.h      |  1 +
 kernel/kthread.c           | 57 +++++++++++++++++++++++++++++++++++++++++++++-
 8 files changed, 91 insertions(+), 52 deletions(-)

-- 
2.9.5
