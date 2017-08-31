Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:38214 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750970AbdHaHYa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 31 Aug 2017 03:24:30 -0400
Received: by mail-wm0-f48.google.com with SMTP id 187so14257597wmn.1
        for <linux-block@vger.kernel.org>; Thu, 31 Aug 2017 00:24:29 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH V6 00/18] blk-throttle: add .low limit
From: Paolo VALENTE <paolo.valente@unimore.it>
In-Reply-To: <cover.1484451062.git.shli@fb.com>
Date: Thu, 31 Aug 2017 09:24:23 +0200
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>, Kernel-team@fb.com,
        tj@kernel.org, axboe@fb.com, vgoyal@redhat.com
Message-Id: <A6F2F3C7-8020-4912-BB31-C4E6CD3EC858@unimore.it>
References: <cover.1484451062.git.shli@fb.com>
To: Shaohua Li <shli@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


> Il giorno 15 gen 2017, alle ore 04:42, Shaohua Li <shli@fb.com> ha =
scritto:
>=20
> Hi,
>=20
> cgroup still lacks a good iocontroller. CFQ works well for hard disk, =
but not
> much for SSD. This patch set try to add a conservative limit for =
blk-throttle.
> It isn't a proportional scheduling, but can help prioritize cgroups. =
There are
> several advantages we choose blk-throttle:
> - blk-throttle resides early in the block stack. It works for both bio =
and
>  request based queues.
> - blk-throttle is light weight in general. It still takes queue lock, =
but it's
>  not hard to implement a per-cpu cache and remove the lock contention.
> - blk-throttle doesn't use 'idle disk' mechanism, which is used by =
CFQ/BFQ. The
>  mechanism is proved to harm performance for fast SSD.
>=20
> The patch set add a new io.low limit for blk-throttle. It's only for =
cgroup2.
> The existing io.max is a hard limit throttling. cgroup with a max =
limit never
> dispatch more IO than its max limit. While io.low is a best effort =
throttling.
> cgroups with 'low' limit can run above their 'low' limit at =
appropriate time.
> Specifically, if all cgroups reach their 'low' limit, all cgroups can =
run above
> their 'low' limit. If any cgroup runs under its 'low' limit, all other =
cgroups
> will run according to their 'low' limit. So the 'low' limit could act =
as two
> roles, it allows cgroups using free bandwidth and it protects cgroups =
from
> their 'low' limit.
>=20
> An example usage is we have a high prio cgroup with high 'low' limit =
and a low
> prio cgroup with low 'low' limit. If the high prio cgroup isn't =
running, the low
> prio can run above its 'low' limit, so we don't waste the bandwidth. =
When the
> high prio cgroup runs and is below its 'low' limit, low prio cgroup =
will run
> under its 'low' limit. This will protect high prio cgroup to get more
> resources.
>=20

Hi Shaohua,
I would like to ask you some questions, to make sure I fully
understand how the 'low' limit and the idle-group detection work in
your above scenario.  Suppose that: the drive has a random-I/O peak
rate of 100MB/s, the high prio group has a 'low' limit of 90 MB/s, and
the low prio group has a 'low' limit of 10 MB/s.  If
- the high prio process happens to do, say, only 5 MB/s for a given
  long time
- the low prio process constantly does greedy I/O
- the idle-group detection is not being used
then the low prio process is limited to 10 MB/s during all this time
interval.  And only 10% of the device bandwidth is utilized.

To recover lost bandwidth through idle-group detection, we need to set
a target IO latency for the high-prio group.  The high prio group
should happen to be below the threshold, and thus to be detected as
idle, leaving the low prio group free too use all the bandwidth.

Here are my questions:
1) Is all I wrote above correct?
2) In particular, maybe there are other better mechanism to saturate
the bandwidth in the above scenario?

If what I wrote above is correct:
3) Doesn't fluctuation occur?  I mean: when the low prio group gets
full bandwidth, the latency threshold of the high prio group may be
overcome, causing the high prio group to not be considered idle any
longer, and thus the low prio group to be limited again; this in turn
will cause the threshold to not be overcome any longer, and so on.
4) Is there a way to compute an appropriate target latency of the high
prio group, if it is a generic group, for which the latency
requirements of the processes it contains are only partially known or
completely unknown?  By appropriate target latency, I mean a target
latency that enables the framework to fully utilize the device
bandwidth while the high prio group is doing less I/O than its limit.

Thanks,
Paolo

> The implementation is simple. The disk queue has a state machine. We =
have 2
> states LIMIT_LOW and LIMIT_MAX. In each disk state, we throttle =
cgroups
> according to the limit of the state. That is io.low limit for =
LIMIT_LOW state,
> io.max limit for LIMIT_MAX. The disk state can be upgraded/downgraded =
between
> LIMIT_LOW and LIMIT_MAX according to the rule aboe. Initially disk =
state is
> LIMIT_MAX. And if no cgroup sets io.low, the disk state will remain in
> LIMIT_MAX state. Systems with only io.max set will find nothing =
changed with the
> patches.
>=20
> The first 10 patches implement the basic framework. Add interface, =
handle
> upgrade and downgrade logic. The patch 10 detects a special case a =
cgroup is
> completely idle. In this case, we ignore the cgroup's limit. The patch =
11-18
> adds more heuristics.
>=20
> The basic framework has 2 major issues.
>=20
> 1. fluctuation. When the state is upgraded from LIMIT_LOW to =
LIMIT_MAX, the
> cgroup's bandwidth can change dramatically, sometimes in a way we are =
not
> expected. For example, one cgroup's bandwidth will drop below its =
io.low limit
> very soon after a upgrade. patch 10 has more details about the issue.
>=20
> 2. idle cgroup. cgroup with a io.low limit doesn't always dispatch =
enough IO.
> In above upgrade rule, the disk will remain in LIMIT_LOW state and all =
other
> cgroups can't dispatch more IO above their 'low' limit. Hence there is =
waste.
> patch 11 has more details about the issue.
>=20
> For issue 1, we make cgroup bandwidth increase/decrease smoothly after =
a
> upgrade/downgrade. This will reduce the chance a cgroup's bandwidth =
drop under
> its 'low' limit rapidly. The smoothness means we could waste some =
bandwidth in
> the transition though. But we must pay something for sharing.
>=20
> The issue 2 is very hard. We introduce two mechanisms for this. One is =
'idle
> time' or 'think time' borrowed from CFQ. If a cgroup's average idle =
time is
> high, we treat it's idle and its 'low' limit isn't respected. Please =
see patch
> 12 - 14 for details. The other is 'latency target'. If a cgroup's io =
latency is
> low, we treat it's idle and its 'low' limit isn't resptected. Please =
see patch
> 15 - 18 for fetails. Both mechanisms only happen when a cgroup runs =
below its
> 'low' limit.
>=20
> The disadvantages of blk-throttle is it exports a kind of low level =
knobs.
> Configuration would not be easy for normal users. It would be powerful =
for
> experienced users though.
>=20
> More tuning is required of course, but otherwise this works well. =
Please
> review, test and consider merge.
>=20
> Thanks,
> Shaohua
>=20
> V5->V6:
> - Change default setting for io.low limit. It's 0 now, which makes =
more sense
> - The default setting for latency is still 0, the default setting for =
idle time
>  becomes bigger. So with the default settings, cgroups have small =
latency but
>  disk sharing could be harmed
> - Addressed other issues pointed out by Tejun
>=20
> V4->V5, basically address Tejun's comments:
> - Change interface from 'io.high' to 'io.low' so consistent with memcg
> - Change interface for 'idle time' and 'latency target'
> - Make 'idle time' per-cgroup-disk instead of per-cgroup
> - Chnage interface name for 'throttle slice'. It's not a real slice
> - Make downgrade smooth too
> - Make latency sampling work for both bio and request based queue
> - Change latency estimation method from 'line fitting' to 'bucket =
based
>  calculation'
> - Rebase and fix other problems
>=20
> Issue pointed out by Tejun isn't fixed yet:
> - .pd_offline_fn vs .pd_free_fn. .pd_free_fn seems too late to change =
states
> http://marc.info/?l=3Dlinux-kernel&m=3D148183437022975&w=3D2
>=20
> V3->V4:
> - Add latency target for cgroup
> - Fix bugs
> http://marc.info/?l=3Dlinux-block&m=3D147916216512915&w=3D2
>=20
> V2->V3:
> - Rebase
> - Fix several bugs
> - Make harddisk think time threshold bigger
> http://marc.info/?l=3Dlinux-kernel&m=3D147552964708965&w=3D2
>=20
> V1->V2:
> - Drop io.low interface for simplicity and the interface isn't a =
must-have to
>  prioritize cgroups.
> - Remove the 'trial' logic, which creates too much fluctuation
> - Add a new idle cgroup detection
> - Other bug fixes and improvements
> http://marc.info/?l=3Dlinux-block&m=3D147395674732335&w=3D2
>=20
> V1:
> http://marc.info/?l=3Dlinux-block&m=3D146292596425689&w=3D2
>=20
>=20
> Shaohua Li (18):
>  blk-throttle: use U64_MAX/UINT_MAX to replace -1
>  blk-throttle: prepare support multiple limits
>  blk-throttle: add .low interface
>  blk-throttle: configure bps/iops limit for cgroup in low limit
>  blk-throttle: add upgrade logic for LIMIT_LOW state
>  blk-throttle: add downgrade logic
>  blk-throttle: make sure expire time isn't too big
>  blk-throttle: make throtl_slice tunable
>  blk-throttle: choose a small throtl_slice for SSD
>  blk-throttle: detect completed idle cgroup
>  blk-throttle: make bandwidth change smooth
>  blk-throttle: add a simple idle detection
>  blk-throttle: add interface to configure idle time threshold
>  blk-throttle: ignore idle cgroup limit
>  blk-throttle: add interface for per-cgroup target latency
>  block: track request size in blk_issue_stat
>  blk-throttle: add a mechanism to estimate IO latency
>  blk-throttle: add latency target support
>=20
> Documentation/block/queue-sysfs.txt |   6 +
> block/bio.c                         |   2 +
> block/blk-core.c                    |   2 +-
> block/blk-mq.c                      |   2 +-
> block/blk-stat.c                    |  11 +-
> block/blk-stat.h                    |  29 +-
> block/blk-sysfs.c                   |  12 +
> block/blk-throttle.c                | 961 =
+++++++++++++++++++++++++++++++++---
> block/blk-wbt.h                     |  10 +-
> block/blk.h                         |   9 +
> include/linux/blk_types.h           |  10 +-
> 11 files changed, 959 insertions(+), 95 deletions(-)
>=20
> --=20
> 2.9.3
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-block" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
