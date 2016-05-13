Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:43759 "EHLO
	mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932146AbcEMXAI (ORCPT
	<rfc822;linux-block@vger.kernel.org>);
	Fri, 13 May 2016 19:00:08 -0400
Date: Fri, 13 May 2016 15:59:50 -0700
From: Shaohua Li <shli@fb.com>
To: Vivek Goyal <vgoyal@redhat.com>
CC: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<tj@kernel.org>, <axboe@fb.com>, <jmoyer@redhat.com>,
	<Kernel-team@fb.com>
Subject: Re: [PATCH 00/10]block-throttle: add low/high limit
Message-ID: <20160513225947.GA2467823@devbig084.prn1.facebook.com>
References: <cover.1462923578.git.shli@fb.com>
 <20160513191245.GB8403@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20160513191245.GB8403@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, May 13, 2016 at 03:12:45PM -0400, Vivek Goyal wrote:
> On Tue, May 10, 2016 at 05:16:30PM -0700, Shaohua Li wrote:
> > Hi,
> > 
> > This patch set adds low/high limit for blk-throttle cgroup. The interface is
> > io.low and io.high.
> > 
> > low limit implements best effort bandwidth/iops protection. If one cgroup
> > doesn't reach its low limit, no other cgroups can use more bandwidth/iops than
> > their low limit. cgroup without low limit is not protected. If there is cgroup
> > with low limit but the cgroup doesn't reach low limit yet, the cgroup without
> > low limit will be throttled to very low bandwidth/iops.
> 
> Hi Shaohua,
> 
> Can you please describe a little what problem are you solving and how
> it is not solved with what we have right now.

The goal is to implement a best effort limit. io.max is a hard limit,
which means cgroup can't use more bandwidth than max even there is no IO
pressure. If we set a high io.max limit for a low priority cgroup, high
priority cgroup will get harmed and dispatch less IO. If we set a low
io.max limit, total disk bandwidth can't be fully used by low priority
cgroup if high priority cgroup doesn't run. Either isn't good. This is
exactly what io.high tries to solve. The io.high is a soft limit, cgroup
could exceed the limit if there is no IO pressure. So in above example,
low priority cgroup can use more than io.high IO if high priority cgroup
isn't running and use up to io.high IO otherwise.

> Are you trying to guarantee minimum bandwidth to a cgroup? And approach
> seems to be that specify minimum bandwidth required by a cgroup in
> io.low and if cgroup does not get that bandwidth, other cgroups will
> be automatically throttled and will not get more than their io.low
> limit BW.

This is exactly what io.low tries to do, protect high priority cgroup.

> I am wondering how would one configure io.low limit? How would
> application know what's the device IO capability and what part of
> that bandwidth application requires.

I agree configure io.low/high limit isn't easy. We have the same problem
for any limit based scheduling including io.max. I don't have good
answer yet for the configuration, but those limits can only be found
after a lot of testing/benchmarking.

> IOW, proportional control using
> absolute limits is very tricky as it requires one to know device's
> IO rate capabilities. To make it more complex, device throughput
> is not fixed and varies based on badndwith. That mean, io.low also
> somehow needs to adjust accorginly. And to me that means using a
> notion of prio/weight works best instead of absolute limits.
>
> In general you seem to be wanting to implement proportional control
> outside CFQ so that it can be used with other block devices. I think
> your previous idea of assigning weights to cgroup and translating
> it automatically to some sort of control (number of tokens) was
> better than absolute limits.
> 
> Having said that, it required knowing cost of IO and I am not sure
> if we reached some conclusion at LSF about this.

So this patch set only tries to extend current blk-throttle, it isn't
related to the proportional control which I was working on before.

As for proportional control, I think proportional control is much better
than a limit based control, as it's easy to configure and adaptive. The
problem is we don't have a good way to measure IO cost, so my original
proportional control patches use either bandwidth or IOPS, none is
precise. Tejun has concerns on this. According to him, if we can't
precisely measure IO cost, we shouldn't do proportional control. This is
debatable though, I'll not give up the proportional patches. This patch
set gives us a temporary solution to prioritize cgroups giving the
proportional control is controversial. The io.low/io.high limit also
matches memcg behavior, which has the same interfaces.

> On the other hand, all these algorithms only control how much IO
> can be dispatched from a cgroup. Given deep queue depths of devices,
> we will not gain much if device is not implementing some sort of
> priority mechanism where one IO in queue is preferred over other.

We can't solve this issue without hardware support, hardware can freely
reschedule any IO. The limit based control can only have a big picture
scheduling. Tejun used to think about adding logic to throttle cgroup
based on IO latency, but the big problem is if latency increases we
don't know which cgorup makes the IO latency increase. It could be the
cgroup itself dispatch some IO or could be any other cgroup. And so we
don't know which cgroup should be throttled further.

> To me biggest problem with IO has been writes overwhelming the device
> and killing read latencies. CFQ did it to an extent but soon became
> obsolete for faster devices. So now Jens's patch of controlling
> background write might help here.
> 
> Not sure how proportional control at block layer will help with devices
> of deep queue depths and without having any notion of priority of request.
> Writes can easily fill up the queue and when latency sensitive IO comes
> in, it will still suffer. So we probably need something proportional
> control along with some sort of prioritization implemented in device.

I agree. proportional control is still the ultimate goal. deep queue
depth makes the problem very hard. The CFQ way (idle disk) is not a
choice for fast devices though.

Thanks,
Shaohua

> > 
> > high limit implements best effort limitation. cgroup with high limit can use
> > more than high limit bandwidth/iops if all cgroups use at least high limit
> > bandwidth/iops. If one cgroup is below its high limit, all cgroups can't use
> > more bandwidth/iops than their high limit. If some cgroups have high limit and
> > the others haven't, the cgroups without high limit will use max limit as their
> > high limit.
> > 
> > The disk queue has a state machine. We have 3 states LIMIT_LOW, LIMIT_HIGH and
> > LIMIT_MAX. In each state, we throttle cgroups up to a limit according to their
> > state limit. LIMIT_LOW state limit is low limit, LIMIT_HIGH high limit and
> > LIMIT_MAX max limit. In a state, if condition meets, queue can upgrade to
> > higher level state or downgrade to lower level state. For example, queue is in
> > LIMIT_LOW state and all cgroups reach their low limit, the queue will be
> > upgraded to LIMIT_HIGH. In another example, queue is in LIMIT_MAX state, but
> > one cgroup is below its high limit, the queue will be downgraded to LIMIT_HIGH.
> > If all cgroups don't have limit for specific state, the state will be invalid.
> > We will skip invalid state for upgrading/downgrading. Initially queue state is
> > LIMIT_MAX till some cgroup gets low/high limit set, so this will maintain
> > backward compatibility for users with only max limist set.
> > 
> > If downgrade/upgrade only happens according to limit, we will have performance
> > issue. For example, if one cgroup has low limit set but the cgroup never
> > dispatch enough IO to reach low limit, the queue state will remain in
> > LIMIT_LOW. Other cgroups will be throttled and the whole disk utilization will
> > be low. To solve this issue, if cgroup is below limit for a long time, we treat
> > the cgroup idle and its corresponding limit will be ignored for
> > upgrade/downgrade logic. The idle based upgrade could introduce a dilemma
> > though, since we will do downgrade if cgroup is below its limit (eg idle). For
> > example, if a cgroup is below its low limit for a long time, queue is upgraded
> > to HIGH state. The cgroup continues to be below its low limit, the queue will
> > be downgraded to LOW state. In this example, the queue will keep switching
> > state between LOW and HIGH.
> > 
> > The key to avoid unnecessary state switching is to detect if cgroup is truly
> > idle, which is a hard problem unfortunately. There are two kinds of idle. One
> > is cgroup intends to not dispatch enough IO (real idle). In this case, we
> > should do upgrade quickly and don't do downgrade. The other is other cgroups
> > dispatch too many IO and use all bandwidth, the cgroup can't dispatch enough IO
> > and looks idle (fake idle). In this case, we should do downgrade quickly and
> > never do upgrade.
> > 
> > Destinguishing the two kinds of idle is impossible for a high queue depth disk
> > as far as I can tell. This patch set doesn't try to precisely detect idle.
> > Instead we record history of upgrade. If queue upgrades because cgroup hits
> > limit, future downgrade is likely because of fake idle, hence future upgrade
> > should run slowly and future downgrade should run quickly. Otherwise future
> > downgrade is likely because of real idle, hence future upgrade should run
> > quickly and future downgrade should run slowly. The adaptive upgrade/downgrade
> > time means disk downgrade in real idle happens rarely and disk upgrade in fake
> > idle happens rarely. This doesn't avoid repeatedly state switching though.
> > Please see patch 6 for details.
> > 
> > User must carefully set the limits. Inproper setting could be ignored. For
> > example, disk max bandwidth is 100M/s. One cgroup has low limit 60M/s, the
> > other 50M/s. When the first cgroup runs in 60M/s, there is only 40M/s bandwidth
> > remaining. The second cgroup will never reach 50M/s, so the cgroup will be
> > treated idle and its limit will be literally ignored.
> > 
> > Comments and benchmarks are welcome!
> > 
> > Thanks,
> > Shaohua
> > 
> > Shaohua Li (10):
> >   block-throttle: prepare support multiple limits
> >   block-throttle: add .low interface
> >   block-throttle: configure bps/iops limit for cgroup in low limit
> >   block-throttle: add upgrade logic for LIMIT_LOW state
> >   block-throttle: add downgrade logic
> >   block-throttle: idle detection
> >   block-throttle: add .high interface
> >   block-throttle: handle high limit
> >   blk-throttle: make sure expire time isn't too big
> >   blk-throttle: add trace log
> > 
> >  block/blk-throttle.c | 813 +++++++++++++++++++++++++++++++++++++++++++++++----
> >  1 file changed, 764 insertions(+), 49 deletions(-)
> > 
> > -- 
> > 2.8.0.rc2
