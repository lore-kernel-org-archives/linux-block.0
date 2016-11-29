Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:36604 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751485AbcK2SOU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Nov 2016 13:14:20 -0500
Date: Tue, 29 Nov 2016 10:14:03 -0800
From: Shaohua Li <shli@fb.com>
To: Tejun Heo <tj@kernel.org>
CC: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <Kernel-team@fb.com>, <axboe@fb.com>, <vgoyal@redhat.com>
Subject: Re: [PATCH V4 15/15] blk-throttle: add latency target support
Message-ID: <20161129181403.GA36738@shli-mbp.local>
References: <cover.1479161136.git.shli@fb.com>
 <420a0f26dd7a20ad8316258c81cb64043134bc86.1479161136.git.shli@fb.com>
 <20161129173108.GB22330@htj.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20161129173108.GB22330@htj.duckdns.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Nov 29, 2016 at 12:31:08PM -0500, Tejun Heo wrote:
> Hello,
> 
> On Mon, Nov 14, 2016 at 02:22:22PM -0800, Shaohua Li wrote:
> > One hard problem adding .high limit is to detect idle cgroup. If one
> > cgroup doesn't dispatch enough IO against its high limit, we must have a
> > mechanism to determine if other cgroups dispatch more IO. We added the
> > think time detection mechanism before, but it doesn't work for all
> > workloads. Here we add a latency based approach.
> 
> As I wrote before, I think that the two mechanisms should operate on
> two mostly separate aspects of io control - latency control for
> arbitrating active cgroups and idle detection to count out cgroups
> which are sitting doing nothing - instead of the two meachanisms
> possibly competing.

What the patches do doesn't conflict what you are talking about. We need a way
to detect if cgroups are idle or active. I think the problem is how to define
'active' and 'idle'. We must quantify the state. We could use:
1. plain idle detection
2. think time idle detection

1 is a subset of 2. Both need a knob to specify the time. 2 is more generic.
Probably the function name 'throtl_tg_is_idle' is misleading. It really means
'the cgroup's high limit can be ignored, other cgorups can dispatch more IO'
 
> >  static bool throtl_tg_is_idle(struct throtl_grp *tg)
> >  {
> > -	/* cgroup is idle if average think time is more than threshold */
> > -	return ktime_get_ns() - tg->last_finish_time >
> > +	/*
> > +	 * cgroup is idle if:
> > +	 * 1. average think time is higher than threshold
> > +	 * 2. average request size is small and average latency is higher
>                                                                    ^
> 								   lower, right?
oh, yes

> > +	 *    than target
> > +	 */
> 
> So, this looks like too much magic to me.  How would one configure for
> a workload which may issue small IOs, say, every few seconds but
> requries low latency?

configure the think time threshold to several seconds and configure the latency
target, it should do the job.

Thanks,
Shaohua
