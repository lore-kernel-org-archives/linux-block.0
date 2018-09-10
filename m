Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-yw1-f67.google.com ([209.85.161.67]:41082 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727784AbeIJVoW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Sep 2018 17:44:22 -0400
Date: Mon, 10 Sep 2018 09:49:20 -0700
From: Tejun Heo <tj@kernel.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-kernel@vger.kernel.org,
        Jianchao Wang <jianchao.w.wang@oracle.com>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] percpu-refcount: relax limit on percpu_ref_reinit()
Message-ID: <20180910164920.GE1100574@devbig004.ftw2.facebook.com>
References: <20180909125824.9150-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180909125824.9150-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hello, Ming.

On Sun, Sep 09, 2018 at 08:58:24PM +0800, Ming Lei wrote:
> @@ -196,15 +197,6 @@ static void __percpu_ref_switch_to_percpu(struct percpu_ref *ref)
>  
>  	atomic_long_add(PERCPU_COUNT_BIAS, &ref->count);
>  
> -	/*
> -	 * Restore per-cpu operation.  smp_store_release() is paired
> -	 * with READ_ONCE() in __ref_is_percpu() and guarantees that the
> -	 * zeroing is visible to all percpu accesses which can see the
> -	 * following __PERCPU_REF_ATOMIC clearing.
> -	 */

So, while the location of percpu counter resetting moved, the pairing
of store_release and READ_ONCE is still required to ensure that the
clearing is visible before the switching to percpu mode becomes
effective.  Can you please rephrase and keep the above comment?

> -	for_each_possible_cpu(cpu)
> -		*per_cpu_ptr(percpu_count, cpu) = 0;
> -
>  	smp_store_release(&ref->percpu_count_ptr,
>  			  ref->percpu_count_ptr & ~__PERCPU_REF_ATOMIC);
>  }
...
> @@ -357,10 +349,11 @@ EXPORT_SYMBOL_GPL(percpu_ref_kill_and_confirm);
>  void percpu_ref_reinit(struct percpu_ref *ref)
>  {
>  	unsigned long flags;
> +	unsigned long __percpu *percpu_count;
>  
>  	spin_lock_irqsave(&percpu_ref_switch_lock, flags);
>  
> -	WARN_ON_ONCE(!percpu_ref_is_zero(ref));
> +	WARN_ON_ONCE(__ref_is_percpu(ref, &percpu_count));

Can you elaborate this part?  This doesn't seem required for the
described change.  Why is it part of the patch?

Thanks.

-- 
tejun
