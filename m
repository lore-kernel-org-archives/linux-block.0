Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:54664 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753935AbcJDRIk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 4 Oct 2016 13:08:40 -0400
Date: Tue, 4 Oct 2016 10:08:13 -0700
From: Shaohua Li <shli@fb.com>
To: Vivek Goyal <vgoyal@redhat.com>
CC: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <axboe@fb.com>, <Kernel-team@fb.com>, <tj@kernel.org>,
        <jmoyer@redhat.com>
Subject: Re: [PATCH V3 00/11] block-throttle: add .high limit
Message-ID: <20161004170812.GA73678@anikkar-mbp.local.dhcp.thefacebook.com>
References: <cover.1475529372.git.shli@fb.com>
 <20161004132805.GB28808@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20161004132805.GB28808@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi,
On Tue, Oct 04, 2016 at 09:28:05AM -0400, Vivek Goyal wrote:
> On Mon, Oct 03, 2016 at 02:20:19PM -0700, Shaohua Li wrote:
> > Hi,
> > 
> > The background is we don't have an ioscheduler for blk-mq yet, so we can't
> > prioritize processes/cgroups.
> 
> So this is an interim solution till we have ioscheduler for blk-mq?

This is still a generic solution to prioritize workloads.

> > This patch set tries to add basic arbitration
> > between cgroups with blk-throttle. It adds a new limit io.high for
> > blk-throttle. It's only for cgroup2.
> > 
> > io.max is a hard limit throttling. cgroups with a max limit never dispatch more
> > IO than their max limit. While io.high is a best effort throttling. cgroups
> > with high limit can run above their high limit at appropriate time.
> > Specifically, if all cgroups reach their high limit, all cgroups can run above
> > their high limit. If any cgroup runs under its high limit, all other cgroups
> > will run according to their high limit.
> 
> Hi Shaohua,
> 
> I still don't understand why we should not implement a weight based
> proportional IO mechanism and how this mechanism is better than proportional IO .
>
> Agreed that we have issues with proportional IO and we don't have good
> solutions for these problems. But I can't see that how this mechanism
> will overcome these problems either.

No, I never declare this mechanism is better than proportional IO. The problem
with proportional IO is we don't have a mechanism to measure IO cost, which is
the core for proportional. This mechanism only prioritizes IO. It's not as
useful as proportional, but works for a lot of scenarios.

> 
> IIRC, biggest issue with proportional IO was that a low prio group might
> fill up the device queue with plenty of IO requests and later when high
> prio cgroup comes, it will still experience latencies anyway. And solution
> to the problem probably would be to get some awareness in device about 
> priority of request and map weights to those priority. That way higher
> prio requests get prioritized.
> 
> Or run device at lower queue depth. That will improve latencies but migth
> reduce overall throughput.

Yep, this is the hardest part. It really depends on the tradeoff between
throughput and latency. Running device at low queue depth sounds working, but
the sacrifice is extremely high for modern SSD. Small size IO throughput has a
range from several MB/s to several GB/s depending on queue depth. If run device
at lower queue depth, the sacrific is big enough to make device sharing no
sense.
 
> Or thorottle number of buffered writes (as Jens's writeback throttling)
> patches were doing. Buffered writes seem to be biggest culprit for 
> increased latencies and being able to control these should help.

big size read can significantly increase latency too. Please note latency isn't
the only factor applications care about. non-interactive workloads don't care
about single IO latency, throughput or amortized latency is more important for
such workloads.

> ioprio/weight based proportional IO mechanism is much more generic and
> much easier to configure for any kind of storage. io.high is absolute
> limit and makes it much harder to configure. One needs to know a lot
> about underlying volume/device's bandwidth (which varies a lot anyway
> based on workload).
> IMHO, we seem to be trying to cater to one specific use case using
> this mechanism. Something ioprio/weight based will be much more
> generic and we should explore implementing that along with building
> notion of ioprio in devices. When these two work together, we might
> be able to see good results. Just software mechanism alone might not
> be enough.

Agree, proportional IO mechanism is easier to configure. The problem we can't
build it without hardware support.

Thanks,
Shaohua
