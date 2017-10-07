Return-Path: <SRS0=uvfw=BG=fb.com=shli@kernel.org>
From: Shaohua Li <shli@kernel.org>
To: linux-block@vger.kernel.org
Cc: vgoyal@redhat.com,
	tj@kernel.org,
	axboe@kernel.dk,
	Kernel-team@fb.com,
	Shaohua Li <shli@fb.com>
Subject: [PATCH V2 0/3] block: export latency info for cgroups
Date: Fri,  6 Oct 2017 17:55:58 -0700
Message-Id: <cover.1507337347.git.shli@fb.com>
List-ID: <linux-block@vger.kernel.org>

From: Shaohua Li <shli@fb.com>

Hi,

latency info is a good sign to determine if IO is healthy. The patches export
such info to cgroup io.stat.

I sent the first patch separately before, but since the latter depends on it, I
include it here.

Thanks,
Shaohua

V1->V2: improve the scalability

Shaohua Li (3):
  blk-stat: delete useless code
  block: set request_list for request
  blockcg: export latency info for each cgroup

 block/blk-cgroup.c         |  29 +++++++-
 block/blk-core.c           |   2 +-
 block/blk-mq.c             |   5 ++
 block/blk-stat.c           | 178 +++++++++++++++++++++++++++++++++++----------
 block/blk.h                |   5 ++
 include/linux/blk-cgroup.h |   9 +++
 include/linux/blk_types.h  |   5 +-
 7 files changed, 189 insertions(+), 44 deletions(-)

-- 
2.9.5
