Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 20 Sep 2018 13:53:33 -0700
From: Tejun Heo <tj@kernel.org>
To: Jianchao Wang <jianchao.w.wang@oracle.com>
Cc: axboe@kernel.dk, kent.overstreet@gmail.com, ming.lei@redhat.com,
	bart.vanassche@wdc.com, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] percpu_ref: add a new helper interface
 __percpu_ref_get_many
Message-ID: <20180920205333.GF902964@devbig004.ftw2.facebook.com>
References: <1537438703-25217-1-git-send-email-jianchao.w.wang@oracle.com>
 <1537438703-25217-2-git-send-email-jianchao.w.wang@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1537438703-25217-2-git-send-email-jianchao.w.wang@oracle.com>
List-ID: <linux-block@vger.kernel.org>

Hello,

On Thu, Sep 20, 2018 at 06:18:21PM +0800, Jianchao Wang wrote:
> -static inline void percpu_ref_get_many(struct percpu_ref *ref, unsigned long nr)
> +static inline void __percpu_ref_get_many(struct percpu_ref *ref, unsigned long nr)
>  {
>  	unsigned long __percpu *percpu_count;
>  
> -	rcu_read_lock_sched();

So, if we're gonna do this (please read below tho), please add the
matching assertion

>  	if (__ref_is_percpu(ref, &percpu_count))
>  		this_cpu_add(*percpu_count, nr);
>  	else
>  		atomic_long_add(nr, &ref->count);
> +}
>  
> +/**
> + * percpu_ref_get_many - increment a percpu refcount
> + * @ref: percpu_ref to get
> + * @nr: number of references to get
> + *
> + * Analogous to atomic_long_add().
> + *
> + * This function is safe to call as long as @ref is between init and exit.
> + */
> +static inline void percpu_ref_get_many(struct percpu_ref *ref, unsigned long nr)
> +{
> +	rcu_read_lock_sched();
> +	__percpu_ref_get_many(ref, nr);
>  	rcu_read_unlock_sched();
>  }

And add the matching variant for get/put with and without _many.

Ming, so, if we make locking explicit like above, I think it should be
fine to share the locking.  However, please note that percpu_ref and
blk_mq are using different types of RCU, at least for now, and I'm not
really sure that unifying that and taking out one rcu read lock/unlock
is a meaningful optimization.

Let's please first do something straight-forward.  If somebody can
show that this actually impacts performance, we can optimize it but
right now all these seem premature to me.

Thanks.

-- 
tejun
