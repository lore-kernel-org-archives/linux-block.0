Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:51766 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S965037AbcKNWWZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Nov 2016 17:22:25 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.17/8.16.0.17) with SMTP id uAEMJF0S001106
        for <linux-block@vger.kernel.org>; Mon, 14 Nov 2016 14:22:24 -0800
Received: from mail.thefacebook.com ([199.201.64.23])
        by m0089730.ppops.net with ESMTP id 26qesjapgs-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT)
        for <linux-block@vger.kernel.org>; Mon, 14 Nov 2016 14:22:24 -0800
Received: from facebook.com (2401:db00:21:603d:face:0:19:0)     by
 mx-out.facebook.com (10.212.232.63) with ESMTP id
 d05d42b2aab811e6881d0002c992ebde-5deefa50 for <linux-block@vger.kernel.org>;
        Mon, 14 Nov 2016 14:22:23 -0800
From: Shaohua Li <shli@fb.com>
To: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <Kernel-team@fb.com>, <axboe@fb.com>, <tj@kernel.org>,
        <vgoyal@redhat.com>
Subject: [PATCH V4 00/15] blk-throttle: add .high limit
Date: Mon, 14 Nov 2016 14:22:07 -0800
Message-ID: <cover.1479161136.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi,

The background is we don't have an ioscheduler for blk-mq yet, so we can't
prioritize processes/cgroups. This patch set tries to add basic arbitration
between cgroups with blk-throttle. It adds a new limit io.high for
blk-throttle. It's only for cgroup2.

io.max is a hard limit throttling. cgroups with a max limit never dispatch more
IO than their max limit. While io.high is a best effort throttling. cgroups
with high limit can run above their high limit at appropriate time.
Specifically, if all cgroups reach their high limit, all cgroups can run above
their high limit. If any cgroup runs under its high limit, all other cgroups
will run according to their high limit.

An example usage is we have a high prio cgroup with high high limit and a low
prio cgroup with low high limit. If the high prio cgroup isn't running, the low
prio can run above its high limit, so we don't waste the bandwidth. When the
high prio cgroup runs and is below its high limit, low prio cgroup will run
under its high limit. This will protect high prio cgroup to get more resources.
If both cgroups reach their high limit, both can run above their high limit
(eg, fully utilize disk bandwidth). All these can't be done with io.max limit.

The implementation is simple. The disk queue has 2 states LIMIT_HIGH and
LIMIT_MAX. In each disk state, we throttle cgroups according to the limit of
the state. That is io.high limit for LIMIT_HIGH state, io.max limit for
LIMIT_MAX. The disk state can be upgraded/downgraded between
LIMIT_HIGH/LIMIT_MAX according to the rule above. Initially disk state is
LIMIT_MAX. And if no cgroup sets io.high, the disk state will remain in
LIMIT_MAX state. Users with only io.max set will find nothing changed with the
patches.

The first 8 patches implement the basic framework. Add interface, handle
upgrade and downgrade logic. The patch 8 detects a special case a cgroup is
completely idle. In this case, we ignore the cgroup's limit. The patch 9-15
adds more heuristics.

The basic framework has 2 major issues.
1. fluctuation. When the state is upgraded from LIMIT_HIGH to LIMIT_MAX, the
cgroup's bandwidth can change dramatically, sometimes in a way not expected.
For example, one cgroup's bandwidth will drop below its io.high limit very soon
after a upgrade. patch 9 has more details about the issue.
2. idle cgroup. cgroup with a io.high limit doesn't always dispatch enough IO.
In above upgrade rule, the disk will remain in LIMIT_HIGH state and all other
cgroups can't dispatch more IO above their high limit. Hence this is a waste of
disk bandwidth. patch 10 has more details about the issue.

For issue 1, we make cgroup bandwidth increase smoothly after a upgrade. This
will reduce the chance a cgroup's bandwidth drop under its high limit rapidly.
The smoothness means we could waste some bandwidth in the transition though.
But we must pay something for sharing.

The issue 2 is very hard to solve. The patch 10 uses the 'think time check'
idea borrowed from CFQ to detect idle cgroup. It's not perfect, eg, not works
well for high IO depth workloads.  But it's the best I tried so far and in
practice works well. This definitively needs more tuning.

The big change in this version comes from patch 13 - 15. We add a latency
target for each cgroup. The goal is to solve issue 2. If a cgroup's average io
latency exceeds its latency target, the cgroup is considered as busy.

Please review, test and consider merge.

Thanks,
Shaohua

V3->V4:
- Add latency target for cgroup
- Fix bugs

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


Shaohua Li (15):
  blk-throttle: prepare support multiple limits
  blk-throttle: add .high interface
  blk-throttle: configure bps/iops limit for cgroup in high limit
  blk-throttle: add upgrade logic for LIMIT_HIGH state
  blk-throttle: add downgrade logic
  blk-throttle: make sure expire time isn't too big
  blk-throttle: make throtl_slice tunable
  blk-throttle: detect completed idle cgroup
  blk-throttle: make bandwidth change smooth
  blk-throttle: add a simple idle detection
  blk-throttle: add interface to configure think time threshold
  blk-throttle: ignore idle cgroup limit
  blk-throttle: add a mechanism to estimate IO latency
  blk-throttle: add interface for per-cgroup target latency
  blk-throttle: add latency target support

 block/bio.c               |    2 +
 block/blk-sysfs.c         |   18 +
 block/blk-throttle.c      | 1035 ++++++++++++++++++++++++++++++++++++++++++---
 block/blk.h               |    9 +
 include/linux/blk_types.h |    4 +
 5 files changed, 1001 insertions(+), 67 deletions(-)

-- 
2.9.3

