Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-yw1-f68.google.com ([209.85.161.68]:38585 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726622AbeIKSsE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Sep 2018 14:48:04 -0400
Date: Tue, 11 Sep 2018 06:48:36 -0700
From: Tejun Heo <tj@kernel.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-kernel@vger.kernel.org,
        Jianchao Wang <jianchao.w.wang@oracle.com>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] percpu-refcount: relax limit on percpu_ref_reinit()
Message-ID: <20180911134836.GG1100574@devbig004.ftw2.facebook.com>
References: <20180909125824.9150-1-ming.lei@redhat.com>
 <20180910164920.GE1100574@devbig004.ftw2.facebook.com>
 <20180911000049.GB30977@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180911000049.GB30977@ming.t460p>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hello, Ming.

On Tue, Sep 11, 2018 at 08:00:50AM +0800, Ming Lei wrote:
> > > @@ -357,10 +349,11 @@ EXPORT_SYMBOL_GPL(percpu_ref_kill_and_confirm);
> > >  void percpu_ref_reinit(struct percpu_ref *ref)
> > >  {
> > >  	unsigned long flags;
> > > +	unsigned long __percpu *percpu_count;
> > >  
> > >  	spin_lock_irqsave(&percpu_ref_switch_lock, flags);
> > >  
> > > -	WARN_ON_ONCE(!percpu_ref_is_zero(ref));
> > > +	WARN_ON_ONCE(__ref_is_percpu(ref, &percpu_count));
> > 
> > Can you elaborate this part?  This doesn't seem required for the
> > described change.  Why is it part of the patch?
> 
> The motivation of this patch is to avoid the above warning and allow
> the ref to switch back to percpu mode without dropping to zero.
> 
> That is why the check has to be changed to the above way.

So, this part seems wrong.  The function is called percpu_ref_reinit()
- the refcnt is expected to be in its initial state with just the base
ref once this function returns.  If you're removing the restriction on
when this can be called, you should also make sure that the function
actually enforces the target state.  Also, this is a separate logical
change, please put it in a separate patch.

Thanks.

-- 
tejun
