Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-yw1-f52.google.com ([209.85.161.52]:45359 "EHLO
        mail-yw1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726828AbeIRSVl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Sep 2018 14:21:41 -0400
Date: Tue, 18 Sep 2018 05:49:09 -0700
From: Tejun Heo <tj@kernel.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-kernel@vger.kernel.org,
        Jianchao Wang <jianchao.w.wang@oracle.com>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] percpu-refcount: relax limit on percpu_ref_reinit()
Message-ID: <20180918124909.GA902964@devbig004.ftw2.facebook.com>
References: <20180911134836.GG1100574@devbig004.ftw2.facebook.com>
 <20180911154540.GA10082@ming.t460p>
 <20180911154959.GI1100574@devbig004.ftw2.facebook.com>
 <20180911160532.GB10082@ming.t460p>
 <20180911163032.GA2966370@devbig004.ftw2.facebook.com>
 <20180911163443.GD10082@ming.t460p>
 <20180911163856.GB2966370@devbig004.ftw2.facebook.com>
 <20180912015247.GA12475@ming.t460p>
 <20180912155321.GE2966370@devbig004.ftw2.facebook.com>
 <20180912221139.GB15810@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180912221139.GB15810@ming.t460p>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hello, Ming.

Sorry about the delay.

On Thu, Sep 13, 2018 at 06:11:40AM +0800, Ming Lei wrote:
> > Yeah but what guards ->release() starting to run and then the ref
> > being switched to percpu mode?  Or maybe that doesn't matter?
> 
> OK, we may add synchronize_rcu() just after clearing the DEAD flag in
> the new introduced helper to avoid the race.

That doesn't make sense to me.  How is synchronize_rcu() gonna change
anything there?

> > > 4) after the queue is recovered(or the controller is reset successfully), it
> > > isn't necessary to wait until the refcount drops zero, since it is fine to
> > > reinit it by clearing DEAD and switching back to percpu mode from atomic mode.
> > > And waiting for the refcount dropping to zero in the reset handler may trigger
> > > IO hang if IO timeout happens again during reset.
> > 
> > Does the recovery need the in-flight commands actually drained or does
> > it just need to block new issues for a while.  If latter, why is
> 
> The recovery needn't to drain the in-flight commands actually.

Is it just waiting till confirm_kill is called?  So that new ref is
not given away?  If synchronization like that is gonna work, the
percpu ref operations on the reader side must be wrapped in a larger
critical region, which brings up two issues.

1. Callers of percpu_ref must not depend on what internal
   synchronization construct percpu_ref uses.  Again, percpu_ref
   doesn't even use regular RCU.

2. If there is already an outer RCU protection around ref operation,
   that RCU critical section can and should be used for
   synchronization, not percpu_ref.

> > percpu_ref even being used?
> 
> Just for avoiding to invent a new wheel, especially .q_usage_counter
> has served for this purpose for long time.

It sounds like this was more of an abuse.  So, basically what you want
is sth like the following.

READER

 rcu_read_lock();
 if (can_issue_new_commands)
	issue;
 else
	abort;
 rcu_read_unlock();

WRITER

 can_issue_new_commands = false;
 synchronize_rcu();
 // no new command will be issued anymore

Right?  There isn't much wheel to reinvent here and using percpu_ref
for the above is likely already incorrect due to the different RCU
type being used.

> > > So what I am trying to propose is the following usage:
> > > 
> > > 1) percpu_ref_kill() on .q_usage_counter before recovering the controller for
> > > preventing new requests from entering queue
> > 
> > The way you're describing it, the above part is no different from
> > having a global bool which gates new issues.
> 
> Right, but the global bool has to be checked in fast path, and the sync

That likely bool test isn't gonna cost anything.

> between updating the flag and checking it has to be considered. Given
> blk-mq has already used .q_usage_counter for this purpose, that is why
> I suggest to scale percpu-refcount to cover this use case.

And the synchronization part should always be considered and is
already likely wrong.

Thanks.

-- 
tejun
