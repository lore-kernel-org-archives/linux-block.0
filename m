Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:60124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755195AbdIFQFR (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 6 Sep 2017 12:05:17 -0400
Date: Wed, 6 Sep 2017 09:05:12 -0700
From: Shaohua Li <shli@kernel.org>
To: Joseph Qi <jiangqi903@gmail.com>
Cc: Paolo VALENTE <paolo.valente@unimore.it>, Shaohua Li <shli@fb.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>, Kernel-team@fb.com,
        tj@kernel.org, axboe@fb.com, vgoyal@redhat.com
Subject: Re: [PATCH V6 00/18] blk-throttle: add .low limit
Message-ID: <20170906160512.e4hmmqojnagiprp3@kernel.org>
References: <cover.1484451062.git.shli@fb.com>
 <A6F2F3C7-8020-4912-BB31-C4E6CD3EC858@unimore.it>
 <20170905210228.vzwjtg24fbmwfl6y@kernel.org>
 <aa0b5483-10bc-6fd7-88e3-834492f90916@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <aa0b5483-10bc-6fd7-88e3-834492f90916@gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Sep 06, 2017 at 09:12:20AM +0800, Joseph Qi wrote:
> Hi Shaohua,
> 
> On 17/9/6 05:02, Shaohua Li wrote:
> > On Thu, Aug 31, 2017 at 09:24:23AM +0200, Paolo VALENTE wrote:
> >>
> >>> Il giorno 15 gen 2017, alle ore 04:42, Shaohua Li <shli@fb.com> ha scritto:
> >>>
> >>> Hi,
> >>>
> >>> cgroup still lacks a good iocontroller. CFQ works well for hard disk, but not
> >>> much for SSD. This patch set try to add a conservative limit for blk-throttle.
> >>> It isn't a proportional scheduling, but can help prioritize cgroups. There are
> >>> several advantages we choose blk-throttle:
> >>> - blk-throttle resides early in the block stack. It works for both bio and
> >>>  request based queues.
> >>> - blk-throttle is light weight in general. It still takes queue lock, but it's
> >>>  not hard to implement a per-cpu cache and remove the lock contention.
> >>> - blk-throttle doesn't use 'idle disk' mechanism, which is used by CFQ/BFQ. The
> >>>  mechanism is proved to harm performance for fast SSD.
> >>>
> >>> The patch set add a new io.low limit for blk-throttle. It's only for cgroup2.
> >>> The existing io.max is a hard limit throttling. cgroup with a max limit never
> >>> dispatch more IO than its max limit. While io.low is a best effort throttling.
> >>> cgroups with 'low' limit can run above their 'low' limit at appropriate time.
> >>> Specifically, if all cgroups reach their 'low' limit, all cgroups can run above
> >>> their 'low' limit. If any cgroup runs under its 'low' limit, all other cgroups
> >>> will run according to their 'low' limit. So the 'low' limit could act as two
> >>> roles, it allows cgroups using free bandwidth and it protects cgroups from
> >>> their 'low' limit.
> >>>
> >>> An example usage is we have a high prio cgroup with high 'low' limit and a low
> >>> prio cgroup with low 'low' limit. If the high prio cgroup isn't running, the low
> >>> prio can run above its 'low' limit, so we don't waste the bandwidth. When the
> >>> high prio cgroup runs and is below its 'low' limit, low prio cgroup will run
> >>> under its 'low' limit. This will protect high prio cgroup to get more
> >>> resources.
> >>>
> >>
> >> Hi Shaohua,
> > 
> > Hi,
> > 
> > Sorry for the late response.
> >> I would like to ask you some questions, to make sure I fully
> >> understand how the 'low' limit and the idle-group detection work in
> >> your above scenario.  Suppose that: the drive has a random-I/O peak
> >> rate of 100MB/s, the high prio group has a 'low' limit of 90 MB/s, and
> >> the low prio group has a 'low' limit of 10 MB/s.  If
> >> - the high prio process happens to do, say, only 5 MB/s for a given
> >>   long time
> >> - the low prio process constantly does greedy I/O
> >> - the idle-group detection is not being used
> >> then the low prio process is limited to 10 MB/s during all this time
> >> interval.  And only 10% of the device bandwidth is utilized.
> >>
> >> To recover lost bandwidth through idle-group detection, we need to set
> >> a target IO latency for the high-prio group.  The high prio group
> >> should happen to be below the threshold, and thus to be detected as
> >> idle, leaving the low prio group free too use all the bandwidth.
> >>
> >> Here are my questions:
> >> 1) Is all I wrote above correct?
> > 
> > Yes
> >> 2) In particular, maybe there are other better mechanism to saturate
> >> the bandwidth in the above scenario?
> > 
> > Assume it's the 4) below.
> >> If what I wrote above is correct:
> >> 3) Doesn't fluctuation occur?  I mean: when the low prio group gets
> >> full bandwidth, the latency threshold of the high prio group may be
> >> overcome, causing the high prio group to not be considered idle any
> >> longer, and thus the low prio group to be limited again; this in turn
> >> will cause the threshold to not be overcome any longer, and so on.
> > 
> > That's true. We try to mitigate the fluctuation by increasing the low prio
> > cgroup bandwidth graduately though.
> > 
> >> 4) Is there a way to compute an appropriate target latency of the high
> >> prio group, if it is a generic group, for which the latency
> >> requirements of the processes it contains are only partially known or
> >> completely unknown?  By appropriate target latency, I mean a target
> >> latency that enables the framework to fully utilize the device
> >> bandwidth while the high prio group is doing less I/O than its limit.
> > 
> > Not sure how we can do this. The device max bandwidth varies based on request
> > size and read/write ratio. We don't know when the max bandwidth is reached.
> > Also I think we must consider a case that the workloads never use the full
> > bandwidth of a disk, which is pretty common for SSD (at least in our
> > environment).
> > 
> I have a question on the base latency tracking.
> From my test on SSD, write latency is much lower than read when doing
> mixed read/write, but currently we only track read request and then use
> it's average as base latency. In other words, we don't distinguish read
> and write now. As a result, all write request's latency will always be
> considered as good. So I think we have to track read and write latency
> separately. Or am I missing something here?

For base latency we only consider read, but for cgroup latency we do consider
write. For the base latency, only using read isn't a big problem, because we
use the latency as a rough base to check if cgroup's latency is good or not.
The comparison is never going to be precise.

Thanks,
Shaohua
