Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-yb1-f194.google.com ([209.85.219.194]:46721 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbeILU6c (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Sep 2018 16:58:32 -0400
Date: Wed, 12 Sep 2018 08:53:21 -0700
From: Tejun Heo <tj@kernel.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-kernel@vger.kernel.org,
        Jianchao Wang <jianchao.w.wang@oracle.com>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] percpu-refcount: relax limit on percpu_ref_reinit()
Message-ID: <20180912155321.GE2966370@devbig004.ftw2.facebook.com>
References: <20180910164920.GE1100574@devbig004.ftw2.facebook.com>
 <20180911000049.GB30977@ming.t460p>
 <20180911134836.GG1100574@devbig004.ftw2.facebook.com>
 <20180911154540.GA10082@ming.t460p>
 <20180911154959.GI1100574@devbig004.ftw2.facebook.com>
 <20180911160532.GB10082@ming.t460p>
 <20180911163032.GA2966370@devbig004.ftw2.facebook.com>
 <20180911163443.GD10082@ming.t460p>
 <20180911163856.GB2966370@devbig004.ftw2.facebook.com>
 <20180912015247.GA12475@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180912015247.GA12475@ming.t460p>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hello,

On Wed, Sep 12, 2018 at 09:52:48AM +0800, Ming Lei wrote:
> > If you killed and waited until kill finished, you should be able to
> > re-init.  Is it that you want to kill but abort killing in some cases?
> 
> Yes, it can be re-init, just with the warning of WARN_ON_ONCE(!percpu_ref_is_zero(ref)).

We can add another interface but it can't be re _init_.

> > How do you then handle the race against release?  Can you please
> 
> The .release is only called at atomic mode, and once we switch to
> percpu mode, .release can't be called at all. Or I may not follow you,
> could you explain a bit the race with release?

Yeah but what guards ->release() starting to run and then the ref
being switched to percpu mode?  Or maybe that doesn't matter?

> > describe the exact usage you have on mind?
> 
> Let me explain the use case:
> 
> 1) nvme timeout comes
> 
> 2) all pending requests are canceled, but won't be completed because
> they have to be retried after the controller is recovered
> 
> 3) meantime, the queue has to be frozen for avoiding new request, so
> the refcount is killed via percpu_ref_kill().
> 
> 4) after the queue is recovered(or the controller is reset successfully), it
> isn't necessary to wait until the refcount drops zero, since it is fine to
> reinit it by clearing DEAD and switching back to percpu mode from atomic mode.
> And waiting for the refcount dropping to zero in the reset handler may trigger
> IO hang if IO timeout happens again during reset.

Does the recovery need the in-flight commands actually drained or does
it just need to block new issues for a while.  If latter, why is
percpu_ref even being used?

> So what I am trying to propose is the following usage:
> 
> 1) percpu_ref_kill() on .q_usage_counter before recovering the controller for
> preventing new requests from entering queue

The way you're describing it, the above part is no different from
having a global bool which gates new issues.

> 2) controller is recovered
> 
> 3) percpu_ref_reinit() on .q_usage_counter, and do not wait for
> .q_usage_counter dropping to zero, then we needn't to wait in NVMe reset
> handler which can be thought as single thread, and avoid IO hang when
> new timeout is triggered during the waiting.

This sounds possibly confused to me.  Can you please explain how the
recovery may hang if you wait for the ref to drain?

Thanks.

-- 
tejun
