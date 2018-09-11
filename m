Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54242 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725945AbeIKE5a (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Sep 2018 00:57:30 -0400
Date: Tue, 11 Sep 2018 08:00:50 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org,
        Jianchao Wang <jianchao.w.wang@oracle.com>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] percpu-refcount: relax limit on percpu_ref_reinit()
Message-ID: <20180911000049.GB30977@ming.t460p>
References: <20180909125824.9150-1-ming.lei@redhat.com>
 <20180910164920.GE1100574@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180910164920.GE1100574@devbig004.ftw2.facebook.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Tejun,

On Mon, Sep 10, 2018 at 09:49:20AM -0700, Tejun Heo wrote:
> Hello, Ming.
> 
> On Sun, Sep 09, 2018 at 08:58:24PM +0800, Ming Lei wrote:
> > @@ -196,15 +197,6 @@ static void __percpu_ref_switch_to_percpu(struct percpu_ref *ref)
> >  
> >  	atomic_long_add(PERCPU_COUNT_BIAS, &ref->count);
> >  
> > -	/*
> > -	 * Restore per-cpu operation.  smp_store_release() is paired
> > -	 * with READ_ONCE() in __ref_is_percpu() and guarantees that the
> > -	 * zeroing is visible to all percpu accesses which can see the
> > -	 * following __PERCPU_REF_ATOMIC clearing.
> > -	 */
> 
> So, while the location of percpu counter resetting moved, the pairing
> of store_release and READ_ONCE is still required to ensure that the
> clearing is visible before the switching to percpu mode becomes
> effective.  Can you please rephrase and keep the above comment?

OK, will do it in V2.

> 
> > -	for_each_possible_cpu(cpu)
> > -		*per_cpu_ptr(percpu_count, cpu) = 0;
> > -
> >  	smp_store_release(&ref->percpu_count_ptr,
> >  			  ref->percpu_count_ptr & ~__PERCPU_REF_ATOMIC);
> >  }
> ...
> > @@ -357,10 +349,11 @@ EXPORT_SYMBOL_GPL(percpu_ref_kill_and_confirm);
> >  void percpu_ref_reinit(struct percpu_ref *ref)
> >  {
> >  	unsigned long flags;
> > +	unsigned long __percpu *percpu_count;
> >  
> >  	spin_lock_irqsave(&percpu_ref_switch_lock, flags);
> >  
> > -	WARN_ON_ONCE(!percpu_ref_is_zero(ref));
> > +	WARN_ON_ONCE(__ref_is_percpu(ref, &percpu_count));
> 
> Can you elaborate this part?  This doesn't seem required for the
> described change.  Why is it part of the patch?

The motivation of this patch is to avoid the above warning and allow
the ref to switch back to percpu mode without dropping to zero.

That is why the check has to be changed to the above way.


Thanks,
Ming
