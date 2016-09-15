Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:58417 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754954AbcIOQX2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Sep 2016 12:23:28 -0400
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
        by mx0b-00082601.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id u8FGHNOw008552
        for <linux-block@vger.kernel.org>; Thu, 15 Sep 2016 09:23:27 -0700
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0b-00082601.pphosted.com with ESMTP id 25fy1880vq-7
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT)
        for <linux-block@vger.kernel.org>; Thu, 15 Sep 2016 09:23:27 -0700
Received: from facebook.com (2401:db00:11:d0a2:face:0:39:0)     by
 mx-out.facebook.com (10.223.100.97) with ESMTP id
 b661b85c7b6011e686a424be0593f280-5d51d6d0 for <linux-block@vger.kernel.org>;
        Thu, 15 Sep 2016 09:23:19 -0700
From: Shaohua Li <shli@fb.com>
To: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <axboe@fb.com>, <Kernel-team@fb.com>, <tj@kernel.org>,
        <jmoyer@redhat.com>, <vgoyal@redhat.com>
Subject: [PATCH V2 00/11] block-throttle: add .high limit
Date: Thu, 15 Sep 2016 09:23:07 -0700
Message-ID: <cover.1473953743.git.shli@fb.com>
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
completely idle. In this case, we ignore the cgroup's limit. The patch 9-11
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

The issue 2 is very hard to solve. To be honest, I don't have a good solution
yet. The patch 10 uses the 'think time check' idea borrowed from CFQ to detect
idle cgroup. It's not perfect, eg, not works well for high IO depth workloads.
But it's the best I tried so far and in practice works well. This definitively
needs more tuning.

Please review, test and consider merge.

Thanks,
Shaohua

V1->V2:
- Drop io.low interface for simplicity and the interface isn't a must-have to
  prioritize cgroups.
- Remove the 'trial' logic, which creates too much fluctuation
- Add a new idle cgroup detection
- Other bug fixes and improvements

V1:
http://marc.info/?l=linux-block&m=146292596425689&w=2

------------------------------------------------------
Shaohua Li (11):
  block-throttle: prepare support multiple limits
  block-throttle: add .high interface
  block-throttle: configure bps/iops limit for cgroup in high limit
  block-throttle: add upgrade logic for LIMIT_HIGH state
  block-throttle: add downgrade logic
  blk-throttle: make sure expire time isn't too big
  blk-throttle: make throtl_slice tunable
  blk-throttle: detect completed idle cgroup
  block-throttle: make bandwidth change smooth
  block-throttle: add a simple idle detection
  blk-throttle: ignore idle cgroup limit

 block/bio.c               |   2 +
 block/blk-sysfs.c         |  18 ++
 block/blk-throttle.c      | 704 +++++++++++++++++++++++++++++++++++++++++-----
 block/blk.h               |   9 +
 include/linux/blk_types.h |   1 +
 5 files changed, 669 insertions(+), 65 deletions(-)

-- 
2.8.0.rc2

