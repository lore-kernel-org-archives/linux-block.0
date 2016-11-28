Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-yw0-f193.google.com ([209.85.161.193]:34068 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751515AbcK1WVu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Nov 2016 17:21:50 -0500
Date: Mon, 28 Nov 2016 17:21:48 -0500
From: Tejun Heo <tj@kernel.org>
To: Shaohua Li <shli@fb.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kernel-team@fb.com, axboe@fb.com, vgoyal@redhat.com
Subject: Re: [PATCH V4 10/15] blk-throttle: add a simple idle detection
Message-ID: <20161128222148.GB12948@htj.duckdns.org>
References: <cover.1479161136.git.shli@fb.com>
 <ba2d677b381e94a2f6c4bf5108f4906c78e99d4f.1479161136.git.shli@fb.com>
 <20161123214619.GE11306@mtj.duckdns.org>
 <20161124011517.GC4724@ksenks-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161124011517.GC4724@ksenks-mbp.dhcp.thefacebook.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hello, Shaohua.

On Wed, Nov 23, 2016 at 05:15:18PM -0800, Shaohua Li wrote:
> > Hmm... I'm not sure thinktime is the best measure here.  Think time is
> > used by cfq mainly to tell the likely future behavior of a workload so
> > that cfq can take speculative actions on the prediction.  However,
> > given that the implemented high limit behavior tries to provide a
> > certain level of latency target, using the predictive thinktime to
> > regulate behavior might lead to too unpredictable behaviors.
> 
> Latency just reflects one side of the IO. Latency and think time haven't any
> relationship. For example, a cgroup dispatching 1 IO per second can still have
> high latency. If we only take latency account, we will think the cgroup is
> busy, which is not justified.

Yes, the two are indepndent metrics; however, whether a cgroup is
considered idle or not affects whether blk-throttle will adhere to the
latency target or not.  Thinktime is a magic number which can be good
but whose behavior can be very difficult to predict from outside the
black box.  What I was trying to say was that putting in thinktime
here can greatly weaken the configured latency target in unobvious
ways.

> > Moreover, I don't see why we need to bother with predictions anyway.
> > cfq needed it but I don't think that's the case for blk-throtl.  It
> > can just provide idle threshold where a cgroup which hasn't issued an
> > IO over that threshold is considered idle.  That'd be a lot easier to
> > understand and configure from userland while providing a good enough
> > mechanism to prevent idle cgroups from clamping down utilization for
> > too long.
> 
> We could do this, but it will only work for very idle workload, eg, the
> workload is completely idle. If workload dispatches IO sporadically, this will
> likely not work. The average think time is more precise for predication.

But we can increase sharing by upping the target latency.  That should
be the main knob - if low, the user wants stricter service guarantee
at the cost of lower overall utilization; if high, the workload can
deal with higher latency and the system can achieve higher overall
utilization.  I think the idle detection should be an extra mechanism
which can be used to ignore cgroup-disk combinations which are staying
idle for a long time.

Thanks.

-- 
tejun
