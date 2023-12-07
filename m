Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HT4wAfcu"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7292ED5C
	for <linux-block@vger.kernel.org>; Wed,  6 Dec 2023 17:11:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701911486;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ExJdtbKmNQpxsox6HxA6icn3NiLLvZaWuFWfZqOZ2U4=;
	b=HT4wAfcuERSkvkih3Ctju5LW7uVQhcaEZIjnKLwU/vSVwypD6aQ52bETfJbC8Z2PN28z4j
	vOJpb2tqTzRukV0qr0032D+HC5MQwrfm1LJuPfX+znz2mab6aRPYtqtF2uqgADcjMiBKUn
	T00sw3tX/M540SCe0ii1UYkBDLYaOfk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-609-MjrAbh1mMma7D6M1fsK8pQ-1; Wed,
 06 Dec 2023 20:11:21 -0500
X-MC-Unique: MjrAbh1mMma7D6M1fsK8pQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AF34E283780C;
	Thu,  7 Dec 2023 01:11:20 +0000 (UTC)
Received: from fedora (unknown [10.72.120.12])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 238F7492BC6;
	Thu,  7 Dec 2023 01:11:13 +0000 (UTC)
Date: Thu, 7 Dec 2023 09:11:09 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Yury Norov <yury.norov@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	Yi Zhang <yi.zhang@redhat.com>, Guangwu Zhang <guazhang@redhat.com>,
	Chengming Zhou <zhouchengming@bytedance.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH V4 resend] lib/group_cpus.c: avoid to acquire cpu hotplug
 lock in group_cpus_evenly
Message-ID: <ZXEbrXwzkNMrg+bH@fedora>
References: <20231120083559.285174-1-ming.lei@redhat.com>
 <ZXEUyH/38KeATuF4@yury-ThinkPad>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXEUyH/38KeATuF4@yury-ThinkPad>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

On Wed, Dec 06, 2023 at 04:41:44PM -0800, Yury Norov wrote:
> Hi Ming,
> 
> On Mon, Nov 20, 2023 at 04:35:59PM +0800, Ming Lei wrote:
> > group_cpus_evenly() could be part of storage driver's error handler,
> > such as nvme driver, when may happen during CPU hotplug, in which
> > storage queue has to drain its pending IOs because all CPUs associated
> > with the queue are offline and the queue is becoming inactive. And
> > handling IO needs error handler to provide forward progress.
> > 
> > Then dead lock is caused:
> > 
> > 1) inside CPU hotplug handler, CPU hotplug lock is held, and blk-mq's
> > handler is waiting for inflight IO
> > 
> > 2) error handler is waiting for CPU hotplug lock
> > 
> > 3) inflight IO can't be completed in blk-mq's CPU hotplug handler because
> > error handling can't provide forward progress.
> > 
> > Solve the deadlock by not holding CPU hotplug lock in group_cpus_evenly(),
> > in which two stage spreads are taken: 1) the 1st stage is over all present
> > CPUs; 2) the end stage is over all other CPUs.
> > 
> > Turns out the two stage spread just needs consistent 'cpu_present_mask', and
> > remove the CPU hotplug lock by storing it into one local cache. This way
> > doesn't change correctness, because all CPUs are still covered.
> > 
> > Cc: Keith Busch <kbusch@kernel.org>
> > Cc: linux-nvme@lists.infradead.org
> > Cc: linux-block@vger.kernel.org
> > Reported-by: Yi Zhang <yi.zhang@redhat.com>
> > Reported-by: Guangwu Zhang <guazhang@redhat.com>
> > Tested-by: Guangwu Zhang <guazhang@redhat.com>
> > Reviewed-by: Chengming Zhou <zhouchengming@bytedance.com>
> > Reviewed-by: Jens Axboe <axboe@kernel.dk>
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  lib/group_cpus.c | 22 ++++++++++++++++------
> >  1 file changed, 16 insertions(+), 6 deletions(-)
> > 
> > diff --git a/lib/group_cpus.c b/lib/group_cpus.c
> > index aa3f6815bb12..ee272c4cefcc 100644
> > --- a/lib/group_cpus.c
> > +++ b/lib/group_cpus.c
> > @@ -366,13 +366,25 @@ struct cpumask *group_cpus_evenly(unsigned int numgrps)
> >  	if (!masks)
> >  		goto fail_node_to_cpumask;
> >  
> > -	/* Stabilize the cpumasks */
> > -	cpus_read_lock();
> >  	build_node_to_cpumask(node_to_cpumask);
> >  
> > +	/*
> > +	 * Make a local cache of 'cpu_present_mask', so the two stages
> > +	 * spread can observe consistent 'cpu_present_mask' without holding
> > +	 * cpu hotplug lock, then we can reduce deadlock risk with cpu
> > +	 * hotplug code.
> > +	 *
> > +	 * Here CPU hotplug may happen when reading `cpu_present_mask`, and
> > +	 * we can live with the case because it only affects that hotplug
> > +	 * CPU is handled in the 1st or 2nd stage, and either way is correct
> > +	 * from API user viewpoint since 2-stage spread is sort of
> > +	 * optimization.
> > +	 */
> > +	cpumask_copy(npresmsk, data_race(cpu_present_mask));
> 
> Now that you initialize the npresmsk explicitly, you can allocate it
> using alloc_cpumask_var().

Indeed, but this way is actually before this patch, and not related with
this fix.

> 
> The same actually holds for nmsk too, and even before this patch. Maybe
> fix it in a separate prepending patch?

Yeah, 'nmsk' is similar with 'npresmsk', and it is not fix, just one
optimization.

group_cpus_evenly() is only run in slow path, so this kind of
micro-optimization is not urgent and should be done in standalone
patch, and even we can live with it.

> 
> > +
> >  	/* grouping present CPUs first */
> >  	ret = __group_cpus_evenly(curgrp, numgrps, node_to_cpumask,
> > -				  cpu_present_mask, nmsk, masks);
> > +				  npresmsk, nmsk, masks);
> >  	if (ret < 0)
> >  		goto fail_build_affinity;
> >  	nr_present = ret;
> > @@ -387,15 +399,13 @@ struct cpumask *group_cpus_evenly(unsigned int numgrps)
> >  		curgrp = 0;
> >  	else
> >  		curgrp = nr_present;
> > -	cpumask_andnot(npresmsk, cpu_possible_mask, cpu_present_mask);
> > +	cpumask_andnot(npresmsk, cpu_possible_mask, npresmsk);
> >  	ret = __group_cpus_evenly(curgrp, numgrps, node_to_cpumask,
> >  				  npresmsk, nmsk, masks);
> 
> The first thing the helper does is checking if nprepmask is empty.
> cpumask_andnot() returns false in that case. So, assuming that present
> cpumask in the previous call can't be empty, we can save few cycles if
> drop corresponding check in the helper and do like this:
>         
> 	if (cpumask_andnot(npresmsk, cpu_possible_mask, npresmsk) == 0) {
>                 nr_others = 0;
>                 goto fail_build_affinity;
>         }
> 
>   	ret = __group_cpus_evenly(curgrp, numgrps, node_to_cpumask,
>   				  npresmsk, nmsk, masks);
> 
> Although, it's not related to this patch directly. So, if you fix
> zalloc_cpumask_var(), the patch looks good to me.

I'd rather not make things complicated, as mentioned this API is only
run in slow path.

> 
> Reviewed-by: Yury Norov <yury.norov@gmail.com>

Thanks for the review!


Thanks, 
Ming

