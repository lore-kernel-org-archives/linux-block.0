Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:33956 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750835AbdAODmh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 14 Jan 2017 22:42:37 -0500
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
        by mx0b-00082601.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id v0F3gPXt005112
        for <linux-block@vger.kernel.org>; Sat, 14 Jan 2017 19:42:37 -0800
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0b-00082601.pphosted.com with ESMTP id 27ygp5hj20-2
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT)
        for <linux-block@vger.kernel.org>; Sat, 14 Jan 2017 19:42:37 -0800
Received: from facebook.com (2401:db00:21:603d:face:0:19:0)     by
 mx-out.facebook.com (10.102.107.97) with ESMTP id
 a729650adad411e692ec0002c99331b0-d95f3a50 for <linux-block@vger.kernel.org>;
        Sat, 14 Jan 2017 19:42:35 -0800
From: Shaohua Li <shli@fb.com>
To: <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>
CC: <Kernel-team@fb.com>, <tj@kernel.org>, <axboe@fb.com>,
        <vgoyal@redhat.com>
Subject: [PATCH V6 00/18] blk-throttle: add .low limit
Date: Sat, 14 Jan 2017 19:42:17 -0800
Message-ID: <cover.1484451062.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi,

cgroup still lacks a good iocontroller. CFQ works well for hard disk, but not
much for SSD. This patch set try to add a conservative limit for blk-throttle.
It isn't a proportional scheduling, but can help prioritize cgroups. There are
several advantages we choose blk-throttle:
- blk-throttle resides early in the block stack. It works for both bio and
  request based queues.
- blk-throttle is light weight in general. It still takes queue lock, but it's
  not hard to implement a per-cpu cache and remove the lock contention.
- blk-throttle doesn't use 'idle disk' mechanism, which is used by CFQ/BFQ. The
  mechanism is proved to harm performance for fast SSD.

The patch set add a new io.low limit for blk-throttle. It's only for cgroup2.
The existing io.max is a hard limit throttling. cgroup with a max limit never
dispatch more IO than its max limit. While io.low is a best effort throttling.
cgroups with 'low' limit can run above their 'low' limit at appropriate time.
Specifically, if all cgroups reach their 'low' limit, all cgroups can run above
their 'low' limit. If any cgroup runs under its 'low' limit, all other cgroups
will run according to their 'low' limit. So the 'low' limit could act as two
roles, it allows cgroups using free bandwidth and it protects cgroups from
their 'low' limit.

An example usage is we have a high prio cgroup with high 'low' limit and a low
prio cgroup with low 'low' limit. If the high prio cgroup isn't running, the low
prio can run above its 'low' limit, so we don't waste the bandwidth. When the
high prio cgroup runs and is below its 'low' limit, low prio cgroup will run
under its 'low' limit. This will protect high prio cgroup to get more
resources.

The implementation is simple. The disk queue has a state machine. We have 2
states LIMIT_LOW and LIMIT_MAX. In each disk state, we throttle cgroups
according to the limit of the state. That is io.low limit for LIMIT_LOW state,
io.max limit for LIMIT_MAX. The disk state can be upgraded/downgraded between
LIMIT_LOW and LIMIT_MAX according to the rule aboe. Initially disk state is
LIMIT_MAX. And if no cgroup sets io.low, the disk state will remain in
LIMIT_MAX state. Systems with only io.max set will find nothing changed with the
patches.

The first 10 patches implement the basic framework. Add interface, handle
upgrade and downgrade logic. The patch 10 detects a special case a cgroup is
completely idle. In this case, we ignore the cgroup's limit. The patch 11-18
adds more heuristics.

The basic framework has 2 major issues.

1. fluctuation. When the state is upgraded from LIMIT_LOW to LIMIT_MAX, the
cgroup's bandwidth can change dramatically, sometimes in a way we are not
expected. For example, one cgroup's bandwidth will drop below its io.low limit
very soon after a upgrade. patch 10 has more details about the issue.

2. idle cgroup. cgroup with a io.low limit doesn't always dispatch enough IO.
In above upgrade rule, the disk will remain in LIMIT_LOW state and all other
cgroups can't dispatch more IO above their 'low' limit. Hence there is waste.
patch 11 has more details about the issue.

For issue 1, we make cgroup bandwidth increase/decrease smoothly after a
upgrade/downgrade. This will reduce the chance a cgroup's bandwidth drop under
its 'low' limit rapidly. The smoothness means we could waste some bandwidth in
the transition though. But we must pay something for sharing.

The issue 2 is very hard. We introduce two mechanisms for this. One is 'idle
time' or 'think time' borrowed from CFQ. If a cgroup's average idle time is
high, we treat it's idle and its 'low' limit isn't respected. Please see patch
12 - 14 for details. The other is 'latency target'. If a cgroup's io latency is
low, we treat it's idle and its 'low' limit isn't resptected. Please see patch
15 - 18 for fetails. Both mechanisms only happen when a cgroup runs below its
'low' limit.

The disadvantages of blk-throttle is it exports a kind of low level knobs.
Configuration would not be easy for normal users. It would be powerful for
experienced users though.

More tuning is required of course, but otherwise this works well. Please
review, test and consider merge.

Thanks,
Shaohua

V5->V6:
- Change default setting for io.low limit. It's 0 now, which makes more sense
- The default setting for latency is still 0, the default setting for idle time
  becomes bigger. So with the default settings, cgroups have small latency but
  disk sharing could be harmed
- Addressed other issues pointed out by Tejun

V4->V5, basically address Tejun's comments:
- Change interface from 'io.high' to 'io.low' so consistent with memcg
- Change interface for 'idle time' and 'latency target'
- Make 'idle time' per-cgroup-disk instead of per-cgroup
- Chnage interface name for 'throttle slice'. It's not a real slice
- Make downgrade smooth too
- Make latency sampling work for both bio and request based queue
- Change latency estimation method from 'line fitting' to 'bucket based
  calculation'
- Rebase and fix other problems

Issue pointed out by Tejun isn't fixed yet:
- .pd_offline_fn vs .pd_free_fn. .pd_free_fn seems too late to change states
http://marc.info/?l=linux-kernel&m=148183437022975&w=2

V3->V4:
- Add latency target for cgroup
- Fix bugs
http://marc.info/?l=linux-block&m=147916216512915&w=2

V2->V3:
- Rebase
- Fix several bugs
- Make harddisk think time threshold bigger
http://marc.info/?l=linux-kernel&m=147552964708965&w=2

V1->V2:
- Drop io.low interface for simplicity and the interface isn't a must-have to
  prioritize cgroups.
- Remove the 'trial' logic, which creates too much fluctuation
- Add a new idle cgroup detection
- Other bug fixes and improvements
http://marc.info/?l=linux-block&m=147395674732335&w=2

V1:
http://marc.info/?l=linux-block&m=146292596425689&w=2


Shaohua Li (18):
  blk-throttle: use U64_MAX/UINT_MAX to replace -1
  blk-throttle: prepare support multiple limits
  blk-throttle: add .low interface
  blk-throttle: configure bps/iops limit for cgroup in low limit
  blk-throttle: add upgrade logic for LIMIT_LOW state
  blk-throttle: add downgrade logic
  blk-throttle: make sure expire time isn't too big
  blk-throttle: make throtl_slice tunable
  blk-throttle: choose a small throtl_slice for SSD
  blk-throttle: detect completed idle cgroup
  blk-throttle: make bandwidth change smooth
  blk-throttle: add a simple idle detection
  blk-throttle: add interface to configure idle time threshold
  blk-throttle: ignore idle cgroup limit
  blk-throttle: add interface for per-cgroup target latency
  block: track request size in blk_issue_stat
  blk-throttle: add a mechanism to estimate IO latency
  blk-throttle: add latency target support

 Documentation/block/queue-sysfs.txt |   6 +
 block/bio.c                         |   2 +
 block/blk-core.c                    |   2 +-
 block/blk-mq.c                      |   2 +-
 block/blk-stat.c                    |  11 +-
 block/blk-stat.h                    |  29 +-
 block/blk-sysfs.c                   |  12 +
 block/blk-throttle.c                | 961 +++++++++++++++++++++++++++++++++---
 block/blk-wbt.h                     |  10 +-
 block/blk.h                         |   9 +
 include/linux/blk_types.h           |  10 +-
 11 files changed, 959 insertions(+), 95 deletions(-)

-- 
2.9.3

