Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50430 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726622AbeIKUpq (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Sep 2018 16:45:46 -0400
Date: Tue, 11 Sep 2018 23:45:41 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org,
        Jianchao Wang <jianchao.w.wang@oracle.com>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] percpu-refcount: relax limit on percpu_ref_reinit()
Message-ID: <20180911154540.GA10082@ming.t460p>
References: <20180909125824.9150-1-ming.lei@redhat.com>
 <20180910164920.GE1100574@devbig004.ftw2.facebook.com>
 <20180911000049.GB30977@ming.t460p>
 <20180911134836.GG1100574@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180911134836.GG1100574@devbig004.ftw2.facebook.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Sep 11, 2018 at 06:48:36AM -0700, Tejun Heo wrote:
> Hello, Ming.
> 
> On Tue, Sep 11, 2018 at 08:00:50AM +0800, Ming Lei wrote:
> > > > @@ -357,10 +349,11 @@ EXPORT_SYMBOL_GPL(percpu_ref_kill_and_confirm);
> > > >  void percpu_ref_reinit(struct percpu_ref *ref)
> > > >  {
> > > >  	unsigned long flags;
> > > > +	unsigned long __percpu *percpu_count;
> > > >  
> > > >  	spin_lock_irqsave(&percpu_ref_switch_lock, flags);
> > > >  
> > > > -	WARN_ON_ONCE(!percpu_ref_is_zero(ref));
> > > > +	WARN_ON_ONCE(__ref_is_percpu(ref, &percpu_count));
> > > 
> > > Can you elaborate this part?  This doesn't seem required for the
> > > described change.  Why is it part of the patch?
> > 
> > The motivation of this patch is to avoid the above warning and allow
> > the ref to switch back to percpu mode without dropping to zero.
> > 
> > That is why the check has to be changed to the above way.
> 
> So, this part seems wrong.  The function is called percpu_ref_reinit()
> - the refcnt is expected to be in its initial state with just the base
> ref once this function returns.  If you're removing the restriction on

But the comment says that 'Re-initialize @ref so that it's in the same
state as when it finished', and this invariant isn't changed with this
patch.

> when this can be called, you should also make sure that the function
> actually enforces the target state.  Also, this is a separate logical
> change, please put it in a separate patch.

OK, will do it in V2.

Thanks,
Ming
