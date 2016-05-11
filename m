Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:9275 "EHLO
	mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752439AbcEKAQo (ORCPT
	<rfc822;linux-block@vger.kernel.org>);
	Tue, 10 May 2016 20:16:44 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.16.0.11/8.16.0.11) with SMTP id u4B0ED0f018992
	for <linux-block@vger.kernel.org>; Tue, 10 May 2016 17:16:43 -0700
Received: from mail.thefacebook.com ([199.201.64.23])
	by m0001303.ppops.net with ESMTP id 22u4gm6um3-1
	(version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <linux-block@vger.kernel.org>; Tue, 10 May 2016 17:16:43 -0700
Received: from facebook.com (2401:db00:11:d0a2:face:0:39:0)	by
 mx-out.facebook.com (10.212.232.59) with ESMTP	id
 a2ff628a170d11e685ef0002c991e86a-d70e2c50 for <linux-block@vger.kernel.org>;
	Tue, 10 May 2016 17:16:42 -0700
From: Shaohua Li <shli@fb.com>
To: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <tj@kernel.org>, <vgoyal@redhat.com>, <axboe@fb.com>,
	<jmoyer@redhat.com>, <Kernel-team@fb.com>
Subject: [PATCH 00/10]block-throttle: add low/high limit
Date: Tue, 10 May 2016 17:16:30 -0700
Message-ID: <cover.1462923578.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi,

This patch set adds low/high limit for blk-throttle cgroup. The interface is
io.low and io.high.

low limit implements best effort bandwidth/iops protection. If one cgroup
doesn't reach its low limit, no other cgroups can use more bandwidth/iops than
their low limit. cgroup without low limit is not protected. If there is cgroup
with low limit but the cgroup doesn't reach low limit yet, the cgroup without
low limit will be throttled to very low bandwidth/iops.

high limit implements best effort limitation. cgroup with high limit can use
more than high limit bandwidth/iops if all cgroups use at least high limit
bandwidth/iops. If one cgroup is below its high limit, all cgroups can't use
more bandwidth/iops than their high limit. If some cgroups have high limit and
the others haven't, the cgroups without high limit will use max limit as their
high limit.

The disk queue has a state machine. We have 3 states LIMIT_LOW, LIMIT_HIGH and
LIMIT_MAX. In each state, we throttle cgroups up to a limit according to their
state limit. LIMIT_LOW state limit is low limit, LIMIT_HIGH high limit and
LIMIT_MAX max limit. In a state, if condition meets, queue can upgrade to
higher level state or downgrade to lower level state. For example, queue is in
LIMIT_LOW state and all cgroups reach their low limit, the queue will be
upgraded to LIMIT_HIGH. In another example, queue is in LIMIT_MAX state, but
one cgroup is below its high limit, the queue will be downgraded to LIMIT_HIGH.
If all cgroups don't have limit for specific state, the state will be invalid.
We will skip invalid state for upgrading/downgrading. Initially queue state is
LIMIT_MAX till some cgroup gets low/high limit set, so this will maintain
backward compatibility for users with only max limist set.

If downgrade/upgrade only happens according to limit, we will have performance
issue. For example, if one cgroup has low limit set but the cgroup never
dispatch enough IO to reach low limit, the queue state will remain in
LIMIT_LOW. Other cgroups will be throttled and the whole disk utilization will
be low. To solve this issue, if cgroup is below limit for a long time, we treat
the cgroup idle and its corresponding limit will be ignored for
upgrade/downgrade logic. The idle based upgrade could introduce a dilemma
though, since we will do downgrade if cgroup is below its limit (eg idle). For
example, if a cgroup is below its low limit for a long time, queue is upgraded
to HIGH state. The cgroup continues to be below its low limit, the queue will
be downgraded to LOW state. In this example, the queue will keep switching
state between LOW and HIGH.

The key to avoid unnecessary state switching is to detect if cgroup is truly
idle, which is a hard problem unfortunately. There are two kinds of idle. One
is cgroup intends to not dispatch enough IO (real idle). In this case, we
should do upgrade quickly and don't do downgrade. The other is other cgroups
dispatch too many IO and use all bandwidth, the cgroup can't dispatch enough IO
and looks idle (fake idle). In this case, we should do downgrade quickly and
never do upgrade.

Destinguishing the two kinds of idle is impossible for a high queue depth disk
as far as I can tell. This patch set doesn't try to precisely detect idle.
Instead we record history of upgrade. If queue upgrades because cgroup hits
limit, future downgrade is likely because of fake idle, hence future upgrade
should run slowly and future downgrade should run quickly. Otherwise future
downgrade is likely because of real idle, hence future upgrade should run
quickly and future downgrade should run slowly. The adaptive upgrade/downgrade
time means disk downgrade in real idle happens rarely and disk upgrade in fake
idle happens rarely. This doesn't avoid repeatedly state switching though.
Please see patch 6 for details.

User must carefully set the limits. Inproper setting could be ignored. For
example, disk max bandwidth is 100M/s. One cgroup has low limit 60M/s, the
other 50M/s. When the first cgroup runs in 60M/s, there is only 40M/s bandwidth
remaining. The second cgroup will never reach 50M/s, so the cgroup will be
treated idle and its limit will be literally ignored.

Comments and benchmarks are welcome!

Thanks,
Shaohua

Shaohua Li (10):
  block-throttle: prepare support multiple limits
  block-throttle: add .low interface
  block-throttle: configure bps/iops limit for cgroup in low limit
  block-throttle: add upgrade logic for LIMIT_LOW state
  block-throttle: add downgrade logic
  block-throttle: idle detection
  block-throttle: add .high interface
  block-throttle: handle high limit
  blk-throttle: make sure expire time isn't too big
  blk-throttle: add trace log

 block/blk-throttle.c | 813 +++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 764 insertions(+), 49 deletions(-)

-- 
2.8.0.rc2

