Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-yw0-f196.google.com ([209.85.161.196]:34643 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752005AbcJDP4T (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Oct 2016 11:56:19 -0400
Date: Tue, 4 Oct 2016 11:56:16 -0400
From: Tejun Heo <tj@kernel.org>
To: Vivek Goyal <vgoyal@redhat.com>
Cc: Shaohua Li <shli@fb.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, axboe@fb.com, Kernel-team@fb.com,
        jmoyer@redhat.com
Subject: Re: [PATCH V3 00/11] block-throttle: add .high limit
Message-ID: <20161004155616.GB4205@htj.duckdns.org>
References: <cover.1475529372.git.shli@fb.com>
 <20161004132805.GB28808@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161004132805.GB28808@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hello, Vivek.

On Tue, Oct 04, 2016 at 09:28:05AM -0400, Vivek Goyal wrote:
> On Mon, Oct 03, 2016 at 02:20:19PM -0700, Shaohua Li wrote:
> > Hi,
> > 
> > The background is we don't have an ioscheduler for blk-mq yet, so we can't
> > prioritize processes/cgroups.
> 
> So this is an interim solution till we have ioscheduler for blk-mq?

It's a common permanent solution which applies to both !mq and mq.

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

Oh, if we actually can implement proportional IO control, it'd be
great.  The problem is that we have no way of knowing IO cost for
highspeed ssd devices.  CFQ gets around the problem by using the
walltime as the measure of resource usage and scheduling time slices,
which works fine for rotating disks but horribly for highspeed ssds.

We can get some semblance of proportional control by just counting bw
or iops but both break down badly as a means to measure the actual
resource consumption depending on the workload.  While limit based
control is more tedious to configure, it doesn't misrepresent what's
going on and is a lot less likely to produce surprising outcomes.

We *can* try to concoct something which tries to do proportional
control for highspeed ssds but that's gonna be quite a bit of
complexity and I'm not so sure it'd be justifiable given that we can't
even figure out measurement of the most basic operating unit.

> Agreed that we have issues with proportional IO and we don't have good
> solutions for these problems. But I can't see that how this mechanism
> will overcome these problems either.

It mostly defers the burden to the one who's configuring the limits
and expects it to know the characteristics of the device and workloads
and configure accordingly.  It's quite a bit more tedious to use but
should be able to cover good portion of use cases without being overly
complicated.  I agree that it'd be nice to have a simple proportional
control but as you said can't see a good solution for it at the
moment.

> IIRC, biggest issue with proportional IO was that a low prio group might
> fill up the device queue with plenty of IO requests and later when high
> prio cgroup comes, it will still experience latencies anyway. And solution
> to the problem probably would be to get some awareness in device about 
> priority of request and map weights to those priority. That way higher
> prio requests get prioritized.

Nah, the real problem is that we can't even decide what the
proportions should be based on.  The most fundamental part is missing.

> Or run device at lower queue depth. That will improve latencies but migth
> reduce overall throughput.

And that we can't do this (and thus basically operate close to
scheduling time slices) for highspeed ssds.

> Or thorottle number of buffered writes (as Jens's writeback throttling)
> patches were doing. Buffered writes seem to be biggest culprit for 
> increased latencies and being able to control these should help.

That's a different topic.

> ioprio/weight based proportional IO mechanism is much more generic and
> much easier to configure for any kind of storage. io.high is absolute
> limit and makes it much harder to configure. One needs to know a lot
> about underlying volume/device's bandwidth (which varies a lot anyway
> based on workload).

Yeap, no disagreement there, but it still is a workable solution.

> IMHO, we seem to be trying to cater to one specific use case using
> this mechanism. Something ioprio/weight based will be much more
> generic and we should explore implementing that along with building
> notion of ioprio in devices. When these two work together, we might
> be able to see good results. Just software mechanism alone might not
> be enough.

I don't think it's catering to specific use cases.  It is a generic
mechanism which demands knowledge and experimentation to configure.
It's more a way for the kernel to cop out and defer figuring out
device characteristics to userland.  If you have a better idea, I'm
all ears.

Thanks.

-- 
tejun
