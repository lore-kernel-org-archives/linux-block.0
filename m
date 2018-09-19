Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-yb1-f193.google.com ([209.85.219.193]:37342 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727676AbeITCQW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Sep 2018 22:16:22 -0400
Date: Wed, 19 Sep 2018 13:36:41 -0700
From: Tejun Heo <tj@kernel.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Jianchao Wang <jianchao.w.wang@oracle.com>,
        Kent Overstreet <kent.overstreet@gmail.com>
Subject: Re: [PATCH] percpu-refcount: relax limit on percpu_ref_reinit()
Message-ID: <20180919203641.GD902964@devbig004.ftw2.facebook.com>
References: <20180911154959.GI1100574@devbig004.ftw2.facebook.com>
 <20180911160532.GB10082@ming.t460p>
 <20180911163032.GA2966370@devbig004.ftw2.facebook.com>
 <20180911163443.GD10082@ming.t460p>
 <20180911163856.GB2966370@devbig004.ftw2.facebook.com>
 <20180912015247.GA12475@ming.t460p>
 <20180912155321.GE2966370@devbig004.ftw2.facebook.com>
 <20180912221139.GB15810@ming.t460p>
 <20180918124909.GA902964@devbig004.ftw2.facebook.com>
 <20180919025148.GB20560@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180919025148.GB20560@ming.t460p>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hello, Ming.

On Wed, Sep 19, 2018 at 10:51:49AM +0800, Ming Lei wrote:
> > That doesn't make sense to me.  How is synchronize_rcu() gonna change
> > anything there?
> 
> As you saw in the new post, synchronize_rcu() isn't used for avoiding
> the race. Instead, it is done by grabbing one extra ref on atomic part.

This is layering violation.  It just isn't a good idea to depend on
percpu_ref internal implementation details like this.

> > 1. Callers of percpu_ref must not depend on what internal
> >    synchronization construct percpu_ref uses.  Again, percpu_ref
> >    doesn't even use regular RCU.
> > 
> > 2. If there is already an outer RCU protection around ref operation,
> >    that RCU critical section can and should be used for
> >    synchronization, not percpu_ref.
> 
> I guess the above doesn't apply any more because there isn't new 
> synchronize_rcu() introduced in my new post.

It still does.  The problem is that what you're doing creates
dependencies on percpu_ref's implementation details - how it
guarantees the mode transition visibility using what sort of
synchronization construct.

> > Right?  There isn't much wheel to reinvent here and using percpu_ref
> > for the above is likely already incorrect due to the different RCU
> > type being used.
> 
> No RCU story any more, :-)
> 
> It might work, but still a reinvented wheel since perpcu-refcount does
> provide same function. Not mention the inter-action between the two
> mechanism may have to be considered.

Why would the two independent mechanisms interact with each other?
What's problematic is entangling two mechanisms in an implementation
dependent way.

> Also there is still cost introduced in WRITER side, and the
> synchronize_rcu() often takes a bit long, especially there might be lots
> of namespaces, each need to run one synchronize_rcu(). We have learned
> lessons in converting to blk-mq for scsi, in which synchronize_rcu()
> introduces long delay in booting.

You're already paying that latency.  It's not like percpu_ref can make
it happen magically without paying the same cost.  You also can easily
overlay the two grace periods as the percpu_ref part can be
asynchronous (if you still care about it).  But, from what I've read
till now, it doesn't even look like you'd need to do anything with
percpu_ref if you all you need to do is shutting down issue of new
commands.

Thanks.

-- 
tejun
