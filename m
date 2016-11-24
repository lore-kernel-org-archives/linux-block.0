Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:34317 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751287AbcKXBzF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Nov 2016 20:55:05 -0500
Date: Wed, 23 Nov 2016 17:15:18 -0800
From: Shaohua Li <shli@fb.com>
To: Tejun Heo <tj@kernel.org>
CC: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <Kernel-team@fb.com>, <axboe@fb.com>, <vgoyal@redhat.com>
Subject: Re: [PATCH V4 10/15] blk-throttle: add a simple idle detection
Message-ID: <20161124011517.GC4724@ksenks-mbp.dhcp.thefacebook.com>
References: <cover.1479161136.git.shli@fb.com>
 <ba2d677b381e94a2f6c4bf5108f4906c78e99d4f.1479161136.git.shli@fb.com>
 <20161123214619.GE11306@mtj.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20161123214619.GE11306@mtj.duckdns.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Nov 23, 2016 at 04:46:19PM -0500, Tejun Heo wrote:
> Hello, Shaohua.
> 
> On Mon, Nov 14, 2016 at 02:22:17PM -0800, Shaohua Li wrote:
> > Unfortunately it's very hard to determine if a cgroup is real idle. This
> > patch uses the 'think time check' idea from CFQ for the purpose. Please
> > note, the idea doesn't work for all workloads. For example, a workload
> > with io depth 8 has disk utilization 100%, hence think time is 0, eg,
> > not idle. But the workload can run higher bandwidth with io depth 16.
> > Compared to io depth 16, the io depth 8 workload is idle. We use the
> > idea to roughly determine if a cgroup is idle.
> 
> Hmm... I'm not sure thinktime is the best measure here.  Think time is
> used by cfq mainly to tell the likely future behavior of a workload so
> that cfq can take speculative actions on the prediction.  However,
> given that the implemented high limit behavior tries to provide a
> certain level of latency target, using the predictive thinktime to
> regulate behavior might lead to too unpredictable behaviors.

Latency just reflects one side of the IO. Latency and think time haven't any
relationship. For example, a cgroup dispatching 1 IO per second can still have
high latency. If we only take latency account, we will think the cgroup is
busy, which is not justified.
 
> Moreover, I don't see why we need to bother with predictions anyway.
> cfq needed it but I don't think that's the case for blk-throtl.  It
> can just provide idle threshold where a cgroup which hasn't issued an
> IO over that threshold is considered idle.  That'd be a lot easier to
> understand and configure from userland while providing a good enough
> mechanism to prevent idle cgroups from clamping down utilization for
> too long.

We could do this, but it will only work for very idle workload, eg, the
workload is completely idle. If workload dispatches IO sporadically, this will
likely not work. The average think time is more precise for predication.

Thanks,
Shaohua
