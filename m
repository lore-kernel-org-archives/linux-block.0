Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35296 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751825AbdA0WRL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Jan 2017 17:17:11 -0500
Date: Fri, 27 Jan 2017 17:09:58 -0500
From: Tejun Heo <tj@kernel.org>
To: Douglas Miller <dougmill@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, Christoph Lameter <cl@linux.com>,
        linux-block@vger.kernel.org,
        Guilherme Piccoli <gpiccoli@br.ibm.com>
Subject: Re: [PATCH 1/1] percpu-refcount: fix reference leak during
 percpu-atomic transition
Message-ID: <20170127220958.GA2476@mtj.duckdns.org>
References: <1485550748-28075-1-git-send-email-dougmill@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1485550748-28075-1-git-send-email-dougmill@linux.vnet.ibm.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hello, Douglas.

On Fri, Jan 27, 2017 at 02:59:08PM -0600, Douglas Miller wrote:
> @@ -212,7 +212,7 @@ static inline bool percpu_ref_tryget(struct percpu_ref *ref)
>  		this_cpu_inc(*percpu_count);
>  		ret = true;
>  	} else {
> -		ret = atomic_long_inc_not_zero(&ref->count);
> +		ret = (atomic_long_inc_not_zero(&ref->count) != 0);
>  	}
>  
>  	rcu_read_unlock_sched();
> @@ -246,7 +246,7 @@ static inline bool percpu_ref_tryget_live(struct percpu_ref *ref)
>  		this_cpu_inc(*percpu_count);
>  		ret = true;
>  	} else if (!(ref->percpu_count_ptr & __PERCPU_REF_DEAD)) {
> -		ret = atomic_long_inc_not_zero(&ref->count);
> +		ret = (atomic_long_inc_not_zero(&ref->count) != 0);

Ugh.... Damn it.  This is why we use bools instead of ints for these
things.  For some reason, we're returning bools but using an integer
variable to cache the result.  :(

Can you please convert the local variable to bool instead?

Thanks a lot for spotting this.

-- 
tejun
