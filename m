Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:50706 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751979AbdIVO3K (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Sep 2017 10:29:10 -0400
Received: by mail-wm0-f42.google.com with SMTP id b195so4457309wmb.5
        for <linux-block@vger.kernel.org>; Fri, 22 Sep 2017 07:29:09 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH V6 00/18] blk-throttle: add .low limit
From: Paolo Valente <paolo.valente@unimore.it>
In-Reply-To: <20170905210228.vzwjtg24fbmwfl6y@kernel.org>
Date: Fri, 22 Sep 2017 16:29:05 +0200
Cc: Shaohua Li <shli@fb.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>, Kernel-team@fb.com,
        tj@kernel.org, axboe@fb.com, vgoyal@redhat.com
Message-Id: <7FFAF7D4-2FFF-4B8D-BDC4-2DC09C5627EE@unimore.it>
References: <cover.1484451062.git.shli@fb.com> <A6F2F3C7-8020-4912-BB31-C4E6CD3EC858@unimore.it> <20170905210228.vzwjtg24fbmwfl6y@kernel.org>
To: Shaohua Li <shli@kernel.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


> Il giorno 05 set 2017, alle ore 23:02, Shaohua Li <shli@kernel.org> ha =
scritto:
>=20
> On Thu, Aug 31, 2017 at 09:24:23AM +0200, Paolo VALENTE wrote:
>>=20
>>> Il giorno 15 gen 2017, alle ore 04:42, Shaohua Li <shli@fb.com> ha =
scritto:
>>>=20
>>> Hi,
>>>=20
>>> cgroup still lacks a good iocontroller. CFQ works well for hard =
disk, but not
>>> much for SSD. This patch set try to add a conservative limit for =
blk-throttle.
>>> It isn't a proportional scheduling, but can help prioritize cgroups. =
There are
>>> several advantages we choose blk-throttle:
>>> - blk-throttle resides early in the block stack. It works for both =
bio and
>>> request based queues.
>>> - blk-throttle is light weight in general. It still takes queue =
lock, but it's
>>> not hard to implement a per-cpu cache and remove the lock =
contention.
>>> - blk-throttle doesn't use 'idle disk' mechanism, which is used by =
CFQ/BFQ. The
>>> mechanism is proved to harm performance for fast SSD.
>>>=20
>>> The patch set add a new io.low limit for blk-throttle. It's only for =
cgroup2.
>>> The existing io.max is a hard limit throttling. cgroup with a max =
limit never
>>> dispatch more IO than its max limit. While io.low is a best effort =
throttling.
>>> cgroups with 'low' limit can run above their 'low' limit at =
appropriate time.
>>> Specifically, if all cgroups reach their 'low' limit, all cgroups =
can run above
>>> their 'low' limit. If any cgroup runs under its 'low' limit, all =
other cgroups
>>> will run according to their 'low' limit. So the 'low' limit could =
act as two
>>> roles, it allows cgroups using free bandwidth and it protects =
cgroups from
>>> their 'low' limit.
>>>=20
>>> An example usage is we have a high prio cgroup with high 'low' limit =
and a low
>>> prio cgroup with low 'low' limit. If the high prio cgroup isn't =
running, the low
>>> prio can run above its 'low' limit, so we don't waste the bandwidth. =
When the
>>> high prio cgroup runs and is below its 'low' limit, low prio cgroup =
will run
>>> under its 'low' limit. This will protect high prio cgroup to get =
more
>>> resources.
>>>=20
>>=20
>> Hi Shaohua,
>=20
> Hi,
>=20
> Sorry for the late response.
>> I would like to ask you some questions, to make sure I fully
>> understand how the 'low' limit and the idle-group detection work in
>> your above scenario.  Suppose that: the drive has a random-I/O peak
>> rate of 100MB/s, the high prio group has a 'low' limit of 90 MB/s, =
and
>> the low prio group has a 'low' limit of 10 MB/s.  If
>> - the high prio process happens to do, say, only 5 MB/s for a given
>>  long time
>> - the low prio process constantly does greedy I/O
>> - the idle-group detection is not being used
>> then the low prio process is limited to 10 MB/s during all this time
>> interval.  And only 10% of the device bandwidth is utilized.
>>=20
>> To recover lost bandwidth through idle-group detection, we need to =
set
>> a target IO latency for the high-prio group.  The high prio group
>> should happen to be below the threshold, and thus to be detected as
>> idle, leaving the low prio group free too use all the bandwidth.
>>=20
>> Here are my questions:
>> 1) Is all I wrote above correct?
>=20
> Yes
>> 2) In particular, maybe there are other better mechanism to saturate
>> the bandwidth in the above scenario?
>=20
> Assume it's the 4) below.
>> If what I wrote above is correct:
>> 3) Doesn't fluctuation occur?  I mean: when the low prio group gets
>> full bandwidth, the latency threshold of the high prio group may be
>> overcome, causing the high prio group to not be considered idle any
>> longer, and thus the low prio group to be limited again; this in turn
>> will cause the threshold to not be overcome any longer, and so on.
>=20
> That's true. We try to mitigate the fluctuation by increasing the low =
prio
> cgroup bandwidth graduately though.
>=20
>> 4) Is there a way to compute an appropriate target latency of the =
high
>> prio group, if it is a generic group, for which the latency
>> requirements of the processes it contains are only partially known or
>> completely unknown?  By appropriate target latency, I mean a target
>> latency that enables the framework to fully utilize the device
>> bandwidth while the high prio group is doing less I/O than its limit.
>=20
> Not sure how we can do this. The device max bandwidth varies based on =
request
> size and read/write ratio. We don't know when the max bandwidth is =
reached.
> Also I think we must consider a case that the workloads never use the =
full
> bandwidth of a disk, which is pretty common for SSD (at least in our
> environment).
>=20

Hi Shaohua,
sorry for adding this bit so late (and of course thanks for your
previous explanations).  By fully utilizing the device bandwidth, I
(imprecisely) didn't mean reaching peak rate, but being close to, and
thus utilizing, the maximum possible throughput achievable with the
workload to serve.  But the only way to know what such maximum
throughput would be, one should be able to let each group enjoy the
maximum possible bandwidth that wouldn't jeopardize the bandwidth and
latency that has to be guaranteed to the other groups.  Yet the
mechanism to do that is exactly the one that one wants to properly
configure, i.e., throttling with your extensions.  So, one should
iteratively change the involved parameters (.low limit, target
latency, ...) until reaching optimal overall throughput, without
violating service guarantees.  Such a task may be very long to
accomplish, depending on the complexity of the system and of the I/O
performed by the groups; or even unfeasible in a dynamic system.

Did what I wrote above make any sense for you?

Thanks,
Paolo

> Thanks,
> Shaohua
