Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UtDpm/kb"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33A69F2
	for <linux-block@vger.kernel.org>; Wed, 13 Dec 2023 16:29:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702513762;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1LeZ/fU4LwYjjPD6kCZ/Dz47GuZJrnHiPdFj1ii6HAY=;
	b=UtDpm/kbByW1p45VSdYK/0lbZpwdXptp1d+a+ur7hBSluvbF6uv54iYRg+u+IPvhBgojVb
	30QLVoAHLqlK+UuQLO0NPxnAAJt/rGvjKT/jjdSbOgflx3o/AchRbjqRuGgZlsqhCMu5fw
	eWScBxNGYFaQG7U8zVvyjPb89RnDJCo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-445-aJ77xxIyMSOoP7xhMe2hVg-1; Wed, 13 Dec 2023 19:29:18 -0500
X-MC-Unique: aJ77xxIyMSOoP7xhMe2hVg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8796288CC40;
	Thu, 14 Dec 2023 00:29:17 +0000 (UTC)
Received: from fedora (unknown [10.72.116.126])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 6A385492BE6;
	Thu, 14 Dec 2023 00:29:12 +0000 (UTC)
Date: Thu, 14 Dec 2023 08:29:08 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Joe Mario <jmario@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org,
	Juri Lelli <juri.lelli@redhat.com>,
	Andrew Theurer <atheurer@redhat.com>,
	Sebastian Jug <sejug@redhat.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>, ming.lei@redhat.com
Subject: Re: [PATCH V3] blk-mq: don't schedule block kworker on isolated CPUs
Message-ID: <ZXpMVDZi/adXLyn3@fedora>
References: <20231025025737.358756-1-ming.lei@redhat.com>
 <b5f2ccfb-0ec0-42f5-a676-187850ca8b4f@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5f2ccfb-0ec0-42f5-a676-187850ca8b4f@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

On Wed, Dec 13, 2023 at 04:43:26PM -0500, Joe Mario wrote:
> Tested-by: Joe Mario <jmario@redhat.com>
> 
> Running fio on an nvme, I verified that block kworker threads no longer ran on isolated cpus.
> I used:
>   # timeout -s INT 60 bpftrace -e 'kprobe:nvme_queue_rq{ @["CPU=",cpu] = count(); }'
> 
> The kernel with this V3 patch showed no hits on isolated cpus.
> An unpatched kernel showed 40587 hits on isolated cpus.

Hi Joe,

Thanks for the test!

Jens, any chance to merge this patch? It does address use case in CPU
isolation, meantime don't affect normal non-isolation cases.

Thanks,
Ming


> 
> Joe
> 
> On 10/24/23 10:57 PM, Ming Lei wrote:
> > Kernel parameter of `isolcpus=` or 'nohz_full=' are used for isolating CPUs
> > for specific task, and user often won't want block IO to disturb these CPUs,
> > also long IO latency may be caused if blk-mq kworker is scheduled on these
> > isolated CPUs.
> > 
> > Kernel workqueue only respects this limit for WQ_UNBOUND, for bound wq,
> > the responsibility should be on wq user.
> > 
> > So don't not run block kworker on isolated CPUs by ruling out isolated CPUs
> > from hctx->cpumask. Meantime in cpuhp handler, use queue map to check if
> > all CPUs in this hw queue are offline, this way can avoid any cost in fast
> > IO code path.
> > 
> > Cc: Juri Lelli <juri.lelli@redhat.com>
> > Cc: Andrew Theurer <atheurer@redhat.com>
> > Cc: Joe Mario <jmario@redhat.com>
> > Cc: Sebastian Jug <sejug@redhat.com>
> > Cc: Frederic Weisbecker <frederic@kernel.org>
> > Cc: Bart Van Assche <bvanassche@acm.org>
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> > 
> > V3:
> > 	- avoid to check invalid cpu as reported by Bart
> > 	- take current cpu(to be offline, not done yet) into account
> > 	- simplify blk_mq_hctx_has_online_cpu()
> > 
> > V2:
> > 	- remove module parameter, meantime use queue map to check if
> > 	all cpus in one hctx are offline
> > 
> >  block/blk-mq.c | 51 ++++++++++++++++++++++++++++++++++++++++----------
> >  1 file changed, 41 insertions(+), 10 deletions(-)
> > 
> > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > index e2d11183f62e..4556978ce71b 100644
> > --- a/block/blk-mq.c
> > +++ b/block/blk-mq.c
> > @@ -29,6 +29,7 @@
> >  #include <linux/prefetch.h>
> >  #include <linux/blk-crypto.h>
> >  #include <linux/part_stat.h>
> > +#include <linux/sched/isolation.h>
> >  
> >  #include <trace/events/block.h>
> >  
> > @@ -2158,7 +2159,11 @@ static int blk_mq_hctx_next_cpu(struct blk_mq_hw_ctx *hctx)
> >  	bool tried = false;
> >  	int next_cpu = hctx->next_cpu;
> >  
> > -	if (hctx->queue->nr_hw_queues == 1)
> > +	/*
> > +	 * In case of single queue or no allowed CPU for scheduling
> > +	 * worker, don't bound our worker with any CPU
> > +	 */
> > +	if (hctx->queue->nr_hw_queues == 1 || next_cpu >= nr_cpu_ids)
> >  		return WORK_CPU_UNBOUND;
> >  
> >  	if (--hctx->next_cpu_batch <= 0) {
> > @@ -3459,14 +3464,30 @@ static bool blk_mq_hctx_has_requests(struct blk_mq_hw_ctx *hctx)
> >  	return data.has_rq;
> >  }
> >  
> > -static inline bool blk_mq_last_cpu_in_hctx(unsigned int cpu,
> > -		struct blk_mq_hw_ctx *hctx)
> > +static bool blk_mq_hctx_has_online_cpu(struct blk_mq_hw_ctx *hctx,
> > +		unsigned int this_cpu)
> >  {
> > -	if (cpumask_first_and(hctx->cpumask, cpu_online_mask) != cpu)
> > -		return false;
> > -	if (cpumask_next_and(cpu, hctx->cpumask, cpu_online_mask) < nr_cpu_ids)
> > -		return false;
> > -	return true;
> > +	enum hctx_type type = hctx->type;
> > +	int cpu;
> > +
> > +	/*
> > +	 * hctx->cpumask has rule out isolated CPUs, but userspace still
> > +	 * might submit IOs on these isolated CPUs, so use queue map to
> > +	 * check if all CPUs mapped to this hctx are offline
> > +	 */
> > +	for_each_online_cpu(cpu) {
> > +		struct blk_mq_hw_ctx *h = blk_mq_map_queue_type(hctx->queue,
> > +				type, cpu);
> > +
> > +		if (h != hctx)
> > +			continue;
> > +
> > +		/* this current CPU isn't put offline yet */
> > +		if (this_cpu != cpu)
> > +			return true;
> > +	}
> > +
> > +	return false;
> >  }
> >  
> >  static int blk_mq_hctx_notify_offline(unsigned int cpu, struct hlist_node *node)
> > @@ -3474,8 +3495,7 @@ static int blk_mq_hctx_notify_offline(unsigned int cpu, struct hlist_node *node)
> >  	struct blk_mq_hw_ctx *hctx = hlist_entry_safe(node,
> >  			struct blk_mq_hw_ctx, cpuhp_online);
> >  
> > -	if (!cpumask_test_cpu(cpu, hctx->cpumask) ||
> > -	    !blk_mq_last_cpu_in_hctx(cpu, hctx))
> > +	if (blk_mq_hctx_has_online_cpu(hctx, cpu))
> >  		return 0;
> >  
> >  	/*
> > @@ -3883,6 +3903,8 @@ static void blk_mq_map_swqueue(struct request_queue *q)
> >  	}
> >  
> >  	queue_for_each_hw_ctx(q, hctx, i) {
> > +		int cpu;
> > +
> >  		/*
> >  		 * If no software queues are mapped to this hardware queue,
> >  		 * disable it and free the request entries.
> > @@ -3909,6 +3931,15 @@ static void blk_mq_map_swqueue(struct request_queue *q)
> >  		 */
> >  		sbitmap_resize(&hctx->ctx_map, hctx->nr_ctx);
> >  
> > +		/*
> > +		 * rule out isolated CPUs from hctx->cpumask for avoiding to
> > +		 * run wq worker on isolated CPU
> > +		 */
> > +		for_each_cpu(cpu, hctx->cpumask) {
> > +			if (cpu_is_isolated(cpu))
> > +				cpumask_clear_cpu(cpu, hctx->cpumask);
> > +		}
> > +
> >  		/*
> >  		 * Initialize batch roundrobin counts
> >  		 */
> 

-- 
Ming

