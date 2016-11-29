Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:41543 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1755101AbcK2Xjk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Nov 2016 18:39:40 -0500
Date: Tue, 29 Nov 2016 15:39:24 -0800
From: Shaohua Li <shli@fb.com>
To: Tejun Heo <tj@kernel.org>
CC: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <Kernel-team@fb.com>, <axboe@fb.com>, <vgoyal@redhat.com>
Subject: Re: [PATCH V4 15/15] blk-throttle: add latency target support
Message-ID: <20161129233922.GA67472@shli-mbp.local>
References: <cover.1479161136.git.shli@fb.com>
 <420a0f26dd7a20ad8316258c81cb64043134bc86.1479161136.git.shli@fb.com>
 <20161129173108.GB22330@htj.duckdns.org>
 <20161129181403.GA36738@shli-mbp.local>
 <20161129225446.GC17732@htj.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20161129225446.GC17732@htj.duckdns.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Nov 29, 2016 at 05:54:46PM -0500, Tejun Heo wrote:
> Hello,
> 
> On Tue, Nov 29, 2016 at 10:14:03AM -0800, Shaohua Li wrote:
> > What the patches do doesn't conflict what you are talking about. We need a way
> > to detect if cgroups are idle or active. I think the problem is how to define
> > 'active' and 'idle'. We must quantify the state. We could use:
> > 1. plain idle detection
> > 2. think time idle detection
> > 
> > 1 is a subset of 2. Both need a knob to specify the time. 2 is more generic.
> > Probably the function name 'throtl_tg_is_idle' is misleading. It really means
> > 'the cgroup's high limit can be ignored, other cgorups can dispatch more IO'
> 
> Yeah, both work towards about the same goal.  I feel a bit icky about
> using thinktime as it seems more complicated than called for here.
> 
> > > >  static bool throtl_tg_is_idle(struct throtl_grp *tg)
> > > >  {
> > > > -	/* cgroup is idle if average think time is more than threshold */
> > > > -	return ktime_get_ns() - tg->last_finish_time >
> > > > +	/*
> > > > +	 * cgroup is idle if:
> > > > +	 * 1. average think time is higher than threshold
> > > > +	 * 2. average request size is small and average latency is higher
> > >                                                                    ^
> > > 								   lower, right?
> > oh, yes
> > 
> > > > +	 *    than target
> > > > +	 */
> > > 
> > > So, this looks like too much magic to me.  How would one configure for
> > > a workload which may issue small IOs, say, every few seconds but
> > > requries low latency?
> > 
> > configure the think time threshold to several seconds and configure the latency
> > target, it should do the job.
> 
> Sure, with a high enough number, it'd do the same thing but it's a
> fuzzy number which can be difficult to tell from user's point of view.
> Implementation-wise, this isn't a huge difference but I'm worried that
> this can fall into the trap of "this isn't doing what I'm expecing it
> to" - "try to nudge that number a bit" situation.
> 
> If we have latency target and a dumb idle setting.  Each's role is
> clear - latency target determines the guarantee that we want to give
> to that cgroup and accordingly how much utilization we're willing to
> sacrifice for that, and idle period to ignore the cgroup if it's idle
> for a relatively long term.  The distinction between the two knobs is
> fairly clear.
> 
> With thinktime, the roles of each knob seem more muddled in that
> thinktime would be a knob which can also be used to fine-tune
> not-too-active sharing.

The dumb idle or think time idle is about implementation choice. Let me take
this way. Defien a knob called 'idle_time'. In the first implementation, we
implement the knob as dump idle. Later we implement it as think time idle.
Would this make you feel better? Or just using the new name 'idle_time' alreay
makes you happy?

For dump idle, we probably can't let user configure the 'idle_time' too small
though.

> Most of our differences might be coming from where we assign
> importance.  I think that if a cgroup wants to have latency target, it
> should be the primary parameter and followed as strictly and clearly
> as possible even if that means lower overall utilization.  If a cgroup
> issues IOs sporadically and thinktime can increase utilization
> (compared to dumb idle detection), that means that the cgroup wouldn't
> be getting the target latency that it configured.  If such situation
> is acceptable, wouldn't it make sense to lower the target latency
> instead?

lowering the target latency doesn't really help. In a giving latency target,
cgroup can dispatch 1 IO per second or 1000 IO per second. The reality is if
application stops dispatching IO (idle) and if application's IO latency is high
haven't any relationship.

Thanks,
Shaohua
