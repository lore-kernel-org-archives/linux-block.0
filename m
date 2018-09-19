Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40184 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727056AbeISNcB (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Sep 2018 09:32:01 -0400
Date: Wed, 19 Sep 2018 15:55:07 +0800
From: Ming Lei <ming.lei@redhat.com>
To: "jianchao.wang" <jianchao.w.wang@oracle.com>
Cc: linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 2/4] lib/percpu-refcount: introduce percpu_ref_resurge()
Message-ID: <20180919075506.GA23172@ming.t460p>
References: <20180918101946.13329-1-ming.lei@redhat.com>
 <20180918101946.13329-3-ming.lei@redhat.com>
 <242969d0-1370-b342-025d-a11b7f59d28f@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <242969d0-1370-b342-025d-a11b7f59d28f@oracle.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Sep 19, 2018 at 01:19:10PM +0800, jianchao.wang wrote:
> Hi Ming
> 
> On 09/18/2018 06:19 PM, Ming Lei wrote:
> > +		unsigned long __percpu *percpu_count;
> > +
> > +		WARN_ON_ONCE(__ref_is_percpu(ref, &percpu_count));
> > +
> > +		/* get one extra ref for avoiding race with .release */
> > +		rcu_read_lock_sched();
> > +		atomic_long_add(1, &ref->count);
> > +		rcu_read_unlock_sched();
> > +	}
> 
> The rcu_read_lock_sched here is redundant. We have been in the critical section
> of a spin_lock_irqsave.

Right.

> 
> The atomic_long_add(1, &ref->count) may have two result.
> 1. ref->count > 1
>    it will not drop to zero any more.
> 2. ref->count == 1
>    it has dropped to zero and .release may be running.

IMO, both the two cases are fine and supported, or do you have other
concern about this way?

thanks, 
Ming
