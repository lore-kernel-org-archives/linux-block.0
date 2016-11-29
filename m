Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-yw0-f193.google.com ([209.85.161.193]:33427 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751602AbcK2RIm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Nov 2016 12:08:42 -0500
Date: Tue, 29 Nov 2016 12:08:40 -0500
From: Tejun Heo <tj@kernel.org>
To: Shaohua Li <shli@fb.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kernel-team@fb.com, axboe@fb.com, vgoyal@redhat.com
Subject: Re: [PATCH V4 10/15] blk-throttle: add a simple idle detection
Message-ID: <20161129170840.GD19454@htj.duckdns.org>
References: <cover.1479161136.git.shli@fb.com>
 <ba2d677b381e94a2f6c4bf5108f4906c78e99d4f.1479161136.git.shli@fb.com>
 <20161123214619.GE11306@mtj.duckdns.org>
 <20161124011517.GC4724@ksenks-mbp.dhcp.thefacebook.com>
 <20161128222148.GB12948@htj.duckdns.org>
 <20161128231017.GA99394@shli-mbp.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161128231017.GA99394@shli-mbp.local>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hello, Shaohua.

On Mon, Nov 28, 2016 at 03:10:18PM -0800, Shaohua Li wrote:
> > But we can increase sharing by upping the target latency.  That should
> > be the main knob - if low, the user wants stricter service guarantee
> > at the cost of lower overall utilization; if high, the workload can
> > deal with higher latency and the system can achieve higher overall
> > utilization.  I think the idle detection should be an extra mechanism
> > which can be used to ignore cgroup-disk combinations which are staying
> > idle for a long time.
> 
> Yes, we can increase target latency to increase sharing. But latency and think
> time are different. In the example I mentioned earlier, we must increase the
> latency target very big to increase sharing even the cgroup just sends 1 IO per
> second. Don't think this's what users want. In a summary, we can't only use
> latency to determine if cgroups could dispatch more IO.
> 
> Currently the think time idle detection is an extra mechanism to ignore cgroup
> limit. So we currently we only ignore cgroup limit when think time is big or
> latency is small. This does make the behavior a little bit difficult to
> predict, eg, not respect latency target sometimes, but this is necessary to
> have better sharing.

So, it's not like we can get better sharing for free.  It always comes
at the cost of (best effort) latency guarantee.  Using thinktime for
idle detection doesn't mean that we get higher utilization for free.
If we get higher utilization by using thinktime instead of plain idle
detection, it means that we're sacrificing latency guarantee more with
thinktime, so I don't think the argument that using thinktime leads to
higher utilization is a clear winner.

That is not to say that there's no benefit to thinktime.  I can
imagine cases where it'd allow us to ride the line between acceptable
latency and good overall utilization better; however, that also comes
with cases where one has to wonder "what's going on?  I have no idea
what it's doing".

Given that blk-throttle is gonna ask for explicit and detailed
configuration from its users, I think it's vital that it has config
knobs which are immediately clear.  Being tedious is already a burden
and I don't think adding unpredictability there is a good idea.

Thanks.

-- 
tejun
