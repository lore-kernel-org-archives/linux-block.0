Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 24 Sep 2018 11:01:17 -0700
From: Tejun Heo <tj@kernel.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
	Jianchao Wang <jianchao.w.wang@oracle.com>,
	Hannes Reinecke <hare@suse.com>,
	Johannes Thumshirn <jthumshirn@suse.de>
Subject: Re: [PATCH v10 5/8] percpu-refcount: Introduce percpu_ref_resurrect()
Message-ID: <20180924180117.GG1297799@devbig004.ftw2.facebook.com>
References: <20180921203122.49743-1-bvanassche@acm.org>
 <20180921203122.49743-6-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180921203122.49743-6-bvanassche@acm.org>
List-ID: <linux-block@vger.kernel.org>

Hello, Bart.

On Fri, Sep 21, 2018 at 01:31:19PM -0700, Bart Van Assche wrote:
> +void percpu_ref_resurrect(struct percpu_ref *ref)
> +{
> +	unsigned long __percpu *percpu_count;
>  	unsigned long flags;
>  
>  	spin_lock_irqsave(&percpu_ref_switch_lock, flags);
>  
> -	WARN_ON_ONCE(!percpu_ref_is_zero(ref));
> +	WARN_ON_ONCE(!(ref->percpu_count_ptr & __PERCPU_REF_DEAD));
> +	WARN_ON_ONCE(__ref_is_percpu(ref, &percpu_count));

So, this in itself is fine but I'm a bit worried that this might it
easier to abuse percpu_ref's dying mode.  More specifically, it isn't
a good idea to depend on percpu_ref's implementation details from
outside - ie. the only guarantee there ever is that percpu_ref won't
give out new refs after ->percpu_ref is called - e.g. users can't
piggy back on implied rcu grace period.

Can you please note that in the function comment?  Provided that,

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
