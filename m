Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39232 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726686AbeILGzD (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Sep 2018 02:55:03 -0400
Date: Wed, 12 Sep 2018 09:52:48 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org,
        Jianchao Wang <jianchao.w.wang@oracle.com>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] percpu-refcount: relax limit on percpu_ref_reinit()
Message-ID: <20180912015247.GA12475@ming.t460p>
References: <20180909125824.9150-1-ming.lei@redhat.com>
 <20180910164920.GE1100574@devbig004.ftw2.facebook.com>
 <20180911000049.GB30977@ming.t460p>
 <20180911134836.GG1100574@devbig004.ftw2.facebook.com>
 <20180911154540.GA10082@ming.t460p>
 <20180911154959.GI1100574@devbig004.ftw2.facebook.com>
 <20180911160532.GB10082@ming.t460p>
 <20180911163032.GA2966370@devbig004.ftw2.facebook.com>
 <20180911163443.GD10082@ming.t460p>
 <20180911163856.GB2966370@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180911163856.GB2966370@devbig004.ftw2.facebook.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Sep 11, 2018 at 09:38:56AM -0700, Tejun Heo wrote:
> Hello, Ming.
> 
> On Wed, Sep 12, 2018 at 12:34:44AM +0800, Ming Lei wrote:
> > > Why aren't switch_to_atomic/percpu enough?
> > 
> > The blk-mq's use case is this _reinit is done on one refcount which was
> > killed via percpu_ref_kill(), so the DEAD flag has to be cleared.
> 
> If you killed and waited until kill finished, you should be able to
> re-init.  Is it that you want to kill but abort killing in some cases?

Yes, it can be re-init, just with the warning of WARN_ON_ONCE(!percpu_ref_is_zero(ref)).

> How do you then handle the race against release?  Can you please

The .release is only called at atomic mode, and once we switch to
percpu mode, .release can't be called at all. Or I may not follow you,
could you explain a bit the race with release?

> describe the exact usage you have on mind?

Let me explain the use case:

1) nvme timeout comes

2) all pending requests are canceled, but won't be completed because
they have to be retried after the controller is recovered

3) meantime, the queue has to be frozen for avoiding new request, so
the refcount is killed via percpu_ref_kill().

4) after the queue is recovered(or the controller is reset successfully), it
isn't necessary to wait until the refcount drops zero, since it is fine to
reinit it by clearing DEAD and switching back to percpu mode from atomic mode.
And waiting for the refcount dropping to zero in the reset handler may trigger
IO hang if IO timeout happens again during reset.


So what I am trying to propose is the following usage:

1) percpu_ref_kill() on .q_usage_counter before recovering the controller for
preventing new requests from entering queue

2) controller is recovered

3) percpu_ref_reinit() on .q_usage_counter, and do not wait for
.q_usage_counter dropping to zero, then we needn't to wait in NVMe reset
handler which can be thought as single thread, and avoid IO hang when
new timeout is triggered during the waiting.

Thanks,
Ming
